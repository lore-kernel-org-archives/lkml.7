Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501DAC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205C521738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBi2yLUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390075AbfGWNv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:51:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36834 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfGWNv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:51:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so19473605pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 06:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iieAYOuoQNwyrS3dY4/FXtAdVnIv4y3zEt6WfnxberI=;
        b=QBi2yLUHpAPrxVmIpm/So8E76VZkVKgKQcUchzNQ3F1+wpsRGN4CV2XRnMhmZIJfEz
         6zBaRa3wzEBgZK/TXJ4Jt69RuxOpBVo4HYvMxIRE85lKV/yqrs5OwKo/HwV9xivvdHWZ
         +FdiDnRN/6xO7MI0K2lNaPgIEGxK5mZDJCIdYYPYlQD/MoLxUFSShEXYz8XQOdPrEm9y
         OuC7zvaZ1dRddcDNYaptRuyybKnf+T+8GASIkZeze7kLcRpauuCM4vq1TZk2EFW9/Eqz
         n6OqYPipcMGnjXRTtCA6ojoDIe90pGcN0ln3VTmEkv0fxhu6NQWCOgpTtuJR7AhLkhbD
         WnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iieAYOuoQNwyrS3dY4/FXtAdVnIv4y3zEt6WfnxberI=;
        b=RErRy4iWX7ewcYs0Py2aKdxgubCRt/tIFvODC/OWqBD001Vf+npv2OxJriROCblIrg
         F2jn414DCi/g/sw/kxcT7yZE4x+BzKyJ6mKFS1a3nG9P+63Uq2eymW4RIMakrK5OsHiC
         0QgP6ToZYR10CTP1PU1+vSc+FEZPdEwfgmCsYfvyf50VcX9ClcXnpwvSxt4s4RGTizxO
         DHISXwBXT5hw2gycWzOK0peS9IB/y2xYvvli7GWVYZrCjJb568zpcuipyqw40lhOyWKB
         3y/DM5hqxut7h7xQ6mlznNOql0AhEoSq9wTiLGUQPID8AYYVKM8pTFLXVvl98V4Ql4GN
         4U/A==
X-Gm-Message-State: APjAAAUMe3m7GuGWg0GghP6DtopqPzoqkPe9kR0k6tOQnzUNIpzJEPZV
        4KNvknhbBmWU3Zzy8xaRj2XikpkE
X-Google-Smtp-Source: APXvYqyJm6C/KHEou+VhElLDQqxp0NqTiGzqbfFqyUUCsrST+UYbYP4pqzkywRDeV55i1NZGYphPbA==
X-Received: by 2002:a62:2b81:: with SMTP id r123mr5701513pfr.108.1563889888708;
        Tue, 23 Jul 2019 06:51:28 -0700 (PDT)
Received: from ?IPv6:2402:f000:4:72:808::177e? ([2402:f000:4:72:808::177e])
        by smtp.gmail.com with ESMTPSA id q21sm27138226pgb.48.2019.07.23.06.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 06:51:28 -0700 (PDT)
Subject: Re: [PATCH] ALSA: isa: gus: Fix a possible null-pointer dereference
 in snd_gf1_mem_xfree()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     huangfq.daxian@gmail.com, tglx@linutronix.de, allison@lohutok.net,
        perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190723134020.25972-1-baijiaju1990@gmail.com>
 <s5htvbc50cc.wl-tiwai@suse.de>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <57696d77-922b-51d6-0623-5c6f4fe2b972@gmail.com>
Date:   Tue, 23 Jul 2019 21:51:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <s5htvbc50cc.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the quick reply :)
I think you are right, and I did not consider "if (alloc->last == block)"
Sorry for the false report...


Best wishes,
Jia-Ju Bai

On 2019/7/23 21:47, Takashi Iwai wrote:
> On Tue, 23 Jul 2019 15:40:20 +0200,
> Jia-Ju Bai wrote:
>> In snd_gf1_mem_xfree(), there is an if statement on line 72 and line 74
>> to check whether block->next is NULL:
>>      if (block->next)
>>
>> When block->next is NULL, block->next is used on line 84:
>>      block->next->prev = block->prev;
>>
>> Thus, a possible null-pointer dereference may occur in this case.
> There is already a check beforehand:
>
> 	if (alloc->last == block) {
>
> and the code path you're referring to is only after this check fails,
> i.e. it's no last entry, hence block->next can be never NULL.
>
> So the current code is OK.
>
>
> thanks,
>
> Takashi
>
>> To fix this possible bug, block->next is checked before using it.
>>
>> This bug is found by a static analysis tool STCheck written by us.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   sound/isa/gus/gus_mem.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/isa/gus/gus_mem.c b/sound/isa/gus/gus_mem.c
>> index cb02d18dde60..ed6205b88057 100644
>> --- a/sound/isa/gus/gus_mem.c
>> +++ b/sound/isa/gus/gus_mem.c
>> @@ -81,7 +81,8 @@ int snd_gf1_mem_xfree(struct snd_gf1_mem * alloc, struct snd_gf1_mem_block * blo
>>   		if (block->prev)
>>   			block->prev->next = NULL;
>>   	} else {
>> -		block->next->prev = block->prev;
>> +		if (block->next)
>> +			block->next->prev = block->prev;
>>   		if (block->prev)
>>   			block->prev->next = block->next;
>>   	}
>> -- 
>> 2.17.0
>>
>>

