Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED963C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFB520700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDCTKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:10:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44359 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfDCTKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:10:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 441AF307EA9A;
        Wed,  3 Apr 2019 19:10:21 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E2DE419C69;
        Wed,  3 Apr 2019 19:10:19 +0000 (UTC)
Subject: Re: [PATCH v2 2/8] kbuild: Support for Symbols.list creation
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Joao Moreira <jmoreira@suse.de>, live-patching@vger.kernel.org,
        pmladek@suse.cz, jikos@suse.cz, nstange@suse.de,
        jpoimboe@redhat.com, khlebnikov@yandex-team.ru, jeyu@kernel.org,
        matz@suse.de, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        michal.lkml@markovi.net
References: <20190301141313.15057-1-jmoreira@suse.de>
 <20190301141313.15057-3-jmoreira@suse.de> <20190318191926.GA23138@redhat.com>
 <alpine.LSU.2.21.1903202000470.29796@pobox.suse.cz>
 <5f615af5-ced7-2361-5b71-71fece8b43c5@suse.de>
 <ae018181-fd8a-03b2-69bf-e9302172bfeb@redhat.com>
 <699e78da-36ba-8217-c509-2e9b443bd380@suse.de>
 <1b6ee81b-5699-a1cc-9a85-02df0eeaed12@redhat.com>
 <20190328201703.GA8658@redhat.com> <20190401193529.GA26375@redhat.com>
 <alpine.LSU.2.21.1904031444020.18182@pobox.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <651eb328-b13a-9f31-d4da-9d2e965914e3@redhat.com>
Date:   Wed, 3 Apr 2019 15:10:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1904031444020.18182@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 03 Apr 2019 19:10:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 8:48 AM, Miroslav Benes wrote:
> 
>> and it looks like the combined KLP_MODULE_RELOC still contains the two
>> unique symbol position values (2 and 3):
>>
>>    % objcopy -O binary --only-section=.klp.module_relocs.vmlinux lib/livepatch/test_klp_convert.klp.o >(hexdump -C)
>>    00000000  00 00 00 00 00 00 00 00  02 00 00 00 00 00 00 00  |................|
>>    00000010  00 00 00 00 00 00 00 00  03 00 00 00              |............|
>>    0000001c
> 
> Nice :/
>   
>> Maybe we can work around this by modifying the annotation macros and/or
>> klp-convert, or live with this for now.
> 
> The question is (and I'll check later. I cannot wrap my head around it
> now) if it at least works if there are two references of the same symbol
> in two different .o. It would be same state_show in this case and not two
> different ones. If it works then I think we can live with it for a while,
> because after all duplicate symbols are quite rare in the kernel.

Possibly, but in testing that scenario I found another issue.  Check out what
happens to the combined .klp.module_relocs.vmlinux section for:

  test_klp_convert_a.c
  KLP_MODULE_RELOC(vmlinux) vmlinux_relocs_a[] = {
          KLP_SYMPOS(state_show, 2)
          KLP_SYMPOS(joe, 10)
          KLP_SYMPOS(joe2, 11)
  };

  test_klp_convert_b.c
  KLP_MODULE_RELOC(vmlinux) vmlinux_relocs_b[] = {
          KLP_SYMPOS(state_show, 2)
  };

The second file's klp_module_reloc are not aligned with the first,
so I think there is additional padding to push the second set to a
word boundary:

  % objcopy -O binary --only-section=.klp.module_relocs.vmlinux lib/livepatch/test_klp_convert.klp.o >(hexdump -C)
  00000000  00 00 00 00 00 00 00 00  02 00 00 00 00 00 00 00
            |-*sym----------------|  |--sympos-| |-*sym-----

  00000010  00 00 00 00 0a 00 00 00  00 00 00 00 00 00 00 00
            ----------| |--sympos-|  |-*sym----------------|

  00000020  0b 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
            |-sympos--|              |-*sym----------------|

                        ^^^^^^^^^^^
                        padding
  00000030  02 00 00 00
            |-sympos--|


in this case, klp-convert thought the last symbol's sympos was
incorrectly 0 and not 2.

If the packed attribute is merely a space optimization, can we
simply pull that (or can we specify slightly looser alignment to
account for the padding)?

I'll continue working on putting together v3 and add this new item
to the TODO list.

Thanks,

-- Joe
