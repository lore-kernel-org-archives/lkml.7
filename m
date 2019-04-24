Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0616DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5512183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbfDXTOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:14:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:60034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726427AbfDXTOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:14:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9984CAE00;
        Wed, 24 Apr 2019 19:14:06 +0000 (UTC)
Subject: Re: [PATCH v3 0/9] klp-convert livepatch build tooling
To:     Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
 <20190417201316.GA690@redhat.com>
 <alpine.LSU.2.21.1904242013310.30239@pobox.suse.cz>
From:   Joao Moreira <jmoreira@suse.de>
Message-ID: <bcedf943-6c94-5d23-a637-4f29daf21eda@suse.de>
Date:   Wed, 24 Apr 2019 16:13:59 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1904242013310.30239@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/19 3:19 PM, Miroslav Benes wrote:
> [...]
> 
>> Result: a small tweak to sympos_sanity_check() to relax its symbol
>> uniqueness verification:  allow for duplicate <object, name, position>
>> instances.  Now it will only complain when a supplied symbol references
>> the same <object, name> but a different <position>.
>>
>> diff --git a/scripts/livepatch/klp-convert.c b/scripts/livepatch/klp-convert.c
>> index 82c27d219372..713835dfc9ec 100644
>> --- a/scripts/livepatch/klp-convert.c
>> +++ b/scripts/livepatch/klp-convert.c
>> @@ -194,7 +194,10 @@ static void clear_sympos_annontations(struct elf *klp_elf)
>>   	}
>>   }
>>
>> -/* Checks if two or more elements in usr_symbols have the same name */
>> +/*
>> + * Checks if two or more elements in usr_symbols have the same
>> + * object and name, but different symbol position
>> + */
>>   static bool sympos_sanity_check(void)
>>   {
>>   	bool sane = true;
>> @@ -203,7 +206,9 @@ static bool sympos_sanity_check(void)
>>   	list_for_each_entry(sp, &usr_symbols, list) {
>>   		aux = list_next_entry(sp, list);
>>   		list_for_each_entry_from(aux, &usr_symbols, list) {
>> -			if (strcmp(sp->symbol_name, aux->symbol_name) == 0) {
>> +			if (sp->pos != aux->pos &&
>> +			    strcmp(sp->object_name, aux->object_name) == 0 &&
>> +			    strcmp(sp->symbol_name, aux->symbol_name) == 0)
>>   				WARN("Conflicting KLP_SYMPOS definition: %s.%s,%d vs. %s.%s,%d.",
>>   				sp->object_name, sp->symbol_name, sp->pos,
>>   				aux->object_name, aux->symbol_name, aux->pos);
> 
> Looks good and I'd definitely include it in v4.
> 
>> Unique sympos
>> -------------
>>
>> But even with the above workaround, specifying unique symbol positions
>> will (and should) result in a klp-convert complaint.
>>
>> When modifying the test module with unique symbol position annotation
>> values (1 and 2 respectively):
>>
>>    test_klp_convert_multi_objs_a.c:
>>
>>      extern void *state_show;
>>      ...
>>      KLP_MODULE_RELOC(vmlinux) vmlinux_relocs_b[] = {
>>              KLP_SYMPOS(state_show, 1)
>>      };
>>
>>    test_klp_convert_multi_objs_b.c:
>>
>>      extern void *state_show;
>>      ...
>>      KLP_MODULE_RELOC(vmlinux) vmlinux_relocs_b[] = {
>>              KLP_SYMPOS(state_show, 2)
>>      };
>>
>>
>> Each object file's symbol table contains a "state_show" instance:
>>
>>    % eu-readelf --symbols lib/livepatch/test_klp_convert_multi_objs_a.o | grep '\<state_show\>'
>>       30: 0000000000000000      0 NOTYPE  GLOBAL DEFAULT    UNDEF state_show
>>
>>    % eu-readelf --symbols lib/livepatch/test_klp_convert_multi_objs_b.o | grep '\<state_show\>'
>>       20: 0000000000000000      0 NOTYPE  GLOBAL DEFAULT    UNDEF state_show
>>
>> and the intermediate test_klp_convert_multi_objs.klp.o file contains a
>> combined .klp.module_relocs.vmlinux relocation section with two
>> KLP_SYMPOS structures, each with a unique <sympos> value:
>>
>>    % objcopy -O binary --only-section=.klp.module_relocs.vmlinux \
>>        lib/livepatch/test_klp_convert_multi_objs.klp.o >(hexdump)
>>
>>    0000000 0000 0000 0000 0000 0001 0000 0000 0000
>>    0000010 0000 0000 0002 0000
>>
>> but the symbol tables were merged, sorted and non-unique symbols
>> removed, leaving a *single* unresolved "state_show" instance:
>>
>>    % eu-readelf --symbols lib/livepatch/test_klp_convert_multi_objs.klp.o | grep '\<state_show\>'
>>       53: 0000000000000000      0 NOTYPE  GLOBAL DEFAULT    UNDEF state_show
>>
>> which means that even though we have separate relocations for each
>> "state_show" instance:
>>
>>    Relocation section [ 6] '.rela.text.unlikely' for section [ 5] '.text.unlikely' at offset 0x44510 contains 11 entries:
>>      Offset              Type            Value               Addend Name
>>      0x0000000000000003  X86_64_32S      000000000000000000      +0 state_show
>>      ...
>>      0x0000000000000034  X86_64_32S      000000000000000000      +0 state_show
>>      ...
>>
>> they share the same rela->sym and there is no way to distinguish which
>> one correlates to which KLP_SYMPOS structure.
>>
>>
>> Future Work
>> -----------
>>
>> I don't see an easy way to support multiple homonym <object, name>
>> symbols with unique <position> values in the current livepatch module
>> Elf format.  The only solutions that come to mind right now include
>> renaming homonym symbols somehow to retain the relocation->symbol
>> relationship when separate object files are combined.  Perhaps an
>> intermediate linker step could make annotated symbols unique in some way
>> to achieve this.  /thinking out loud
> 
> I'd set this aside for now and we can return to it later. I think it could
> be quite rare in practice.
> 
> I was thinking about renaming the symbol too. We can extend the symbol
> naming convention we have now and deal with it in klp_resolve_symbols(),
> but maybe Josh will come up with something clever and cleaner.

I think this could work well, but (sorry if I understood Joe's idea 
wrongly) not as a linker step. Instead of modifying the linker, I think 
we could create another tool and plug it into the kbuild pipeline prior 
to the livepatch module linking. This way, we would parse the .o elf 
files, check for homonyms and rename them based on a convention that is 
later understood by klp-convert, as suggested.

If I am not missing something, this would fix the case where we have 
homonyms pointing to the same or different positions, without additional 
user intervention other then adding the SYMPOS annotations.

If you consider this to be useful I can start experiencing.

>   
> Miroslav
> 
