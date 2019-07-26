Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B401C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237B72238C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWnrUtBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfGZCFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 22:05:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43679 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfGZCFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 22:05:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so23941897pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 19:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cCr2oTsYVgIcEXvmtc7DlfGkkVp1TEqKVaiHx8VkY0g=;
        b=hWnrUtBcKGH6duUC6atM3dFoGEBxjthHp13HPcOGJP3NvGrheBc5ubV7GtbnVrlUG5
         w5xBX1gRoM47ksIqKWOFmWXir+gUPA0Gh2eTDKgpymSSztq9tcT/zBuN/n0rKnfOUuca
         qEBOAK2NsqTXHIFBuLpt5vzs2eCB9GmKpjPB+kgUHv7LrzqssPl1EAlagaMpS3cl11B5
         Ddh3fFfxS5tzaLVHZMBeZDV1ZxTtRHvN9GoQhg8GT5xbsqmQxdkN3vS5pSlF/m8Bxnq0
         02OcN90av2yFVbUIr4WKCyoepL+F+iRgaISztNFR+JUkamvg6b92qQRwAurdm9kPr6/f
         qF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cCr2oTsYVgIcEXvmtc7DlfGkkVp1TEqKVaiHx8VkY0g=;
        b=l8Vftz7JEsQCgsl/ycDEQPCT8ux2KArNh6ESX564solBEEBrWhN4r6RajInpWAuVZ/
         bEnGfK53Vbsu0/ZsZxYh/vQG0UJ9dZNYDuJPHyQJh96nPhgI/rDDQFLFn73dZwC01lpP
         0D5dRp4LCp+bEApMua7T5vZBJSXkMbNJiMsA1FLr00XExDJMnotcKRs2qCBMV7DPfx7b
         seCcaqxTjAEKuwayz0g6pHo2BlwokLPWZYUYl5XgRtBj6yJi5kPcAkLUXEYwvba3v8IZ
         4vD07x/HyMTiJesuiv8e2LANoKTTi4a837SjxaMI58EWnfr/XhpFj3RtaOqBqTNx2gL2
         2F9g==
X-Gm-Message-State: APjAAAUOTQr36yECygdR9aYf9NDFpsDFnuM+qzZXQrZc1xONgE7QVVmB
        Hx/q58WaSyZ0eNBsnZBy2lIsL1IKOU8=
X-Google-Smtp-Source: APXvYqyW0cJeyN4gZGlH3R5yMUABavXqQ5fq8IodhkOzNunm92SeAYGrTnWkOwPKwtBRZvJudMSzfg==
X-Received: by 2002:a17:90a:4806:: with SMTP id a6mr96016852pjh.38.1564106742844;
        Thu, 25 Jul 2019 19:05:42 -0700 (PDT)
Received: from ?IPv6:2402:f000:4:72:808::177e? ([2402:f000:4:72:808::177e])
        by smtp.gmail.com with ESMTPSA id b126sm75007442pfa.126.2019.07.25.19.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 19:05:42 -0700 (PDT)
Subject: Re: [PATCH] ALSA: i2c: ak4xxx-adda: Fix a possible null pointer
 dereference in build_adc_controls()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tglx@linutronix.de, gregkh@linuxfoundation.org, perex@perex.cz,
        rfontana@redhat.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190725082733.15234-1-baijiaju1990@gmail.com>
 <s5hy30myuvw.wl-tiwai@suse.de>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <5ef03517-a52f-fe24-30e9-62466d4a1319@gmail.com>
Date:   Fri, 26 Jul 2019 10:05:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <s5hy30myuvw.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/7/25 23:52, Takashi Iwai wrote:
> On Thu, 25 Jul 2019 10:27:33 +0200,
> Jia-Ju Bai wrote:
>> In build_adc_controls(), there is an if statement on line 773 to check
>> whether ak->adc_info is NULL:
>> 	if (! ak->adc_info ||
>> 		! ak->adc_info[mixer_ch].switch_name)
>>
>> When ak->adc_info is NULL, it is used on line 792:
>>      knew.name = ak->adc_info[mixer_ch].selector_name;
>>
>> Thus, a possible null-pointer dereference may occur.
>>
>> To fix this bug, referring to lines 773 and 774, ak->adc_info
>> and ak->adc_info[mixer_ch].selector_name are checked before being used.
>>
>> This bug is found by a static analysis tool STCheck written by us.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   sound/i2c/other/ak4xxx-adda.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/i2c/other/ak4xxx-adda.c b/sound/i2c/other/ak4xxx-adda.c
>> index 5f59316f982a..9a891470e84a 100644
>> --- a/sound/i2c/other/ak4xxx-adda.c
>> +++ b/sound/i2c/other/ak4xxx-adda.c
>> @@ -775,11 +775,13 @@ static int build_adc_controls(struct snd_akm4xxx *ak)
>>   				return err;
>>   
>>   			memset(&knew, 0, sizeof(knew));
>> -			knew.name = ak->adc_info[mixer_ch].selector_name;
>> -			if (!knew.name) {
>> +			if (! ak->adc_info ||
>> +				! ak->adc_info[mixer_ch].selector_name) {
>>   				knew.name = "Capture Channel";
>>   				knew.index = mixer_ch + ak->idx_offset * 2;
>>   			}
>> +			else
>> +				knew.name = ak->adc_info[mixer_ch].selector_name;
>>   
>>   			knew.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
>>   			knew.info = ak4xxx_capture_source_info;
> The code change itself looks good, but please follow the standard
> coding style.  In short: please run checkpatch.pl, fix errors (some
> warnings may be ignored) and resubmit.

Okay, thanks for the advice.
I will send a v2 patch.


Best wishes,
Jia-Ju Bai
