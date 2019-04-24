Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AA0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512C820835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbfDXVAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:00:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbfDXVAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:00:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50FB33098490;
        Wed, 24 Apr 2019 21:00:52 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E99C25D9C5;
        Wed, 24 Apr 2019 21:00:50 +0000 (UTC)
Subject: Re: [PATCH v3 3/9] livepatch: Add klp-convert tool
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
 <20190410155058.9437-4-joe.lawrence@redhat.com>
 <20190423203529.GA15743@redhat.com>
 <alpine.LSU.2.21.1904241941230.30239@pobox.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <4581c471-e6ac-16a8-1bee-bb03a4476bf6@redhat.com>
Date:   Wed, 24 Apr 2019 17:00:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1904241941230.30239@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 24 Apr 2019 21:00:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 1:47 PM, Miroslav Benes wrote:
> On Tue, 23 Apr 2019, Joe Lawrence wrote:
>> diff --git a/scripts/livepatch/klp-convert.c b/scripts/livepatch/klp-convert.c
>> index 82c27d219372..126395f1c0cd 100644
>> --- a/scripts/livepatch/klp-convert.c
>> +++ b/scripts/livepatch/klp-convert.c
>> @@ -517,6 +517,7 @@ static bool convert_rela(struct section *oldsec, struct rela *r,
>>   		if (r1->sym->name == r->sym->name) {
>>   			list_del(&r1->list);
>>   			list_add(&r1->list, &sec->relas);
>> +			break;
>>   		}
>>   	}
>>   	return true;
> 
> Couldn't we remove the loop all together instead of breaking it?
> 
> 	list_del(&r->list);
> 	list_add(&r->list, &sec->relas);
> 
> could be sufficient.

Ah yea, good point.

> 
>> @@ -549,8 +550,8 @@ static bool is_converted(char *sname)
>>   }
>>   
>>   /*
>> - * Checks if symbol must be converted (conditions):
>> - * not resolved, not already converted or isn't an exported symbol
>> + * Checks if symbol must be or was already converted (conditions):
>> + * not resolved or isn't an exported symbol
>>    */
>>   static bool must_convert(struct symbol *sym)
>>   {
>> @@ -566,7 +567,7 @@ static bool must_convert(struct symbol *sym)
>>   	if (strcmp(sym->name, ".TOC.") == 0)
>>   		return false;
>>   
>> -	return (!(is_converted(sym->name) || is_exported(sym->name)));
>> +	return (!is_exported(sym->name));
>>   }
>>   
>>   /* Checks if a section is a klp rela section */
>> @@ -640,7 +641,8 @@ int main(int argc, const char **argv)
>>   			if (!must_convert(rela->sym))
>>   				continue;
>>   
>> -			if (!find_missing_position(rela->sym, &sp)) {
>> +			if (!is_converted(rela->sym->name) &&
>> +			    !find_missing_position(rela->sym, &sp)) {
>>   				WARN("Unable to find missing symbol: %s",
>>   						rela->sym->name);
>>   				return -1;
> 
> Looks good.

There were a few additional spots I needed to update (like main's 
section walk doesn't need to re-convert klp_rela_sections, and likewise, 
convert_rela doesn't need to re-convert_klp_symbol), but I will include 
with v4 for a real review.

Thanks,

-- Joe
