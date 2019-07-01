Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9590EC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C005208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfh5vicc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfGAFqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 01:46:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42844 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfGAFqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 01:46:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id t28so11696807lje.9;
        Sun, 30 Jun 2019 22:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8yYaeGYH1lk4dhqKXsvPRW0fUGxbl4jEGeDfKa2Ty6Y=;
        b=kfh5vicc77Conm69He5+G8+PaZuy/aFnTfW7eGf/0g7by8v+gTDKKa3E0WWlj69uu5
         xcSMYJhYj+K+94FeYJGSkPWVpC4WMpWgxUmu+NyOxZYY1+dfW9U4Mi4l+CGMbzF4Jctb
         3iBKTJAGhcDfRwEwkkp0m9jC1QQf1O0Q40g5kLxOvAS52UpwPlVOiwZ9Z82ZGbLISm/J
         i7/lBRwJkWMYEESXHHM3il3VcBySiIlyxHLJYq4Z2iE9sdgBueKyM3Rt6c0E3ac2HSSN
         2juMxi+rr3EHPPfx/X1onWMfWZmBfYyr9c4njFBxxIkLofQwY5uKm5hTiIyLfZef6KKB
         ox7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8yYaeGYH1lk4dhqKXsvPRW0fUGxbl4jEGeDfKa2Ty6Y=;
        b=RTxVBV7eK6Y8e2aNN3vOJu231R/kaZPKFhgONVmno0REfdT1csvtb8NQIfh+abHCsW
         FJWtRJQjaaRQBLf23T2MORR6ANy165VQqJRlT2xjkov/Sr1c28BI4xnp/i72yPO4DGGH
         oktzpRKKVQ0PKYL8JVABp1dRJ/sQqjCfc4phX1dqyowU38sP/qYKDBC3qMhVMUw7UXRr
         /rD0Q9NxL+yJxVfRCYuGXFmer/DADpuVf+caqV89JnNHcvVFY4VYyhZkUwU9KpG2lkL1
         cbQH//Gc7mvo/8MScSouSelhbYc0eQ1Z+UpU9FOYP2Hxbrrv4mAC0O77FwQfy5rieDKH
         zfbA==
X-Gm-Message-State: APjAAAVHBvvukSRq6U+BEPT72vXuRE7KuoLAET/cH5q828I/upIj4v2u
        WSaj+wxk3WHq/uPunOtGxUY=
X-Google-Smtp-Source: APXvYqz6tnhd9uDkTCwEyyQMlwXFBa/szeO/kbZD0HykwS+epBivubnP5CszJLpw3z7J7a1pcp4Jgg==
X-Received: by 2002:a2e:89ca:: with SMTP id c10mr12904311ljk.106.1561959965169;
        Sun, 30 Jun 2019 22:46:05 -0700 (PDT)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id w15sm3395418ljh.0.2019.06.30.22.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 22:46:04 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH] ALSA: xen-front: fix unintention integer
 overflow on left shifts
To:     Takashi Iwai <tiwai@suse.de>, Colin King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        xen-devel@lists.xenproject.org
References: <20190627165853.21864-1-colin.king@canonical.com>
 <s5hv9wq6qrg.wl-tiwai@suse.de>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <de93db15-c85f-3108-22c3-75b89a3a2e59@gmail.com>
Date:   Mon, 1 Jul 2019 08:46:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <s5hv9wq6qrg.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/19 11:46 AM, Takashi Iwai wrote:
> On Thu, 27 Jun 2019 18:58:53 +0200,
> Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Shifting the integer value 1 is evaluated using 32-bit
>> arithmetic and then used in an expression that expects a 64-bit
>> value, so there is potentially an integer overflow. Fix this
>> by using the BIT_ULL macro to perform the shift.
>>
>> Addresses-Coverity: ("Unintentional integer overflow")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Thank you for you patch,
Oleksandr
> The fix is correct, but luckily we didn't hit the integer overflow, as
> all passed values are less than 32bit.
>
> In anyway, applied now.  Thanks.
>
>
> Takashi
>
>> ---
>>   sound/xen/xen_snd_front_alsa.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
>> index b14ab512c2ce..e01631959ed8 100644
>> --- a/sound/xen/xen_snd_front_alsa.c
>> +++ b/sound/xen/xen_snd_front_alsa.c
>> @@ -196,7 +196,7 @@ static u64 to_sndif_formats_mask(u64 alsa_formats)
>>   	mask = 0;
>>   	for (i = 0; i < ARRAY_SIZE(ALSA_SNDIF_FORMATS); i++)
>>   		if (pcm_format_to_bits(ALSA_SNDIF_FORMATS[i].alsa) & alsa_formats)
>> -			mask |= 1 << ALSA_SNDIF_FORMATS[i].sndif;
>> +			mask |= BIT_ULL(ALSA_SNDIF_FORMATS[i].sndif);
>>   
>>   	return mask;
>>   }
>> @@ -208,7 +208,7 @@ static u64 to_alsa_formats_mask(u64 sndif_formats)
>>   
>>   	mask = 0;
>>   	for (i = 0; i < ARRAY_SIZE(ALSA_SNDIF_FORMATS); i++)
>> -		if (1 << ALSA_SNDIF_FORMATS[i].sndif & sndif_formats)
>> +		if (BIT_ULL(ALSA_SNDIF_FORMATS[i].sndif) & sndif_formats)
>>   			mask |= pcm_format_to_bits(ALSA_SNDIF_FORMATS[i].alsa);
>>   
>>   	return mask;
>> -- 
>> 2.20.1
>>
>>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel

