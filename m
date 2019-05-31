Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1566C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAE2268F6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tz/bmVgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfEaMr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 08:47:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46461 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfEaMr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 08:47:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so3989681pgr.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 05:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mrOvROKkD6rEtKj8wt1DbcS2uRCJ3D/8JqzJE6LAZsI=;
        b=Tz/bmVgg+/llAxfI4JKND90fWUcOivF2HhnGibjeZarDNFSasZgVY8nSO1NWp/QGVq
         Cv1dYM51wKg++UR1jbh1/EuEKhV8SBL32Wz30rcr0vHi765piUJLR6zAWCwJJnVOGQ1n
         n0pHVSNjw3OWjwdMaBeetNsjmwe85cMWRirG5NiAX3sGPmqfRzHvZwbzOyHrqmF6RQsm
         JsXDmAawjHvHTUHJw0QWneRhH5U6ioVjGTWDbYdP267LS993J4hEj+RZNPNltTIM4aTG
         5ZeOTrSNGFQBXQCBEhW+hjDpboaU321kcz1hgNUtTzXjRr07HEG8zW/YdwQolBi6O8aU
         Tcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mrOvROKkD6rEtKj8wt1DbcS2uRCJ3D/8JqzJE6LAZsI=;
        b=Ap7xgUFYiqstx1umhSbVp5bwD0MhQoSmucgVdy11fUgoxqbDtVWwSK2E/ssb66u2nT
         drA9c8CKbN1A5yF68RKjnJTrGS0mPsJbUNoSStRk6ispppqRC7Rn85lTuF6aDhlzVa19
         90l3ov7/2TaFhEOnZZuBRA0Vrv0EfB6r11zxsSl0mF8fXT8Uu0w8FaRM+SnYtADZUOZC
         0cbDdRKzQCtMdoJ1R+GJdAXRtg5nTe0YOPs+7OsNv30MbxDTGb/4qS0sov8HWB/uvrP6
         zNXvcizqKUPKXkBdaKCDzaA+T3UaeuR/Hvg8CsMKnQI94jCe8Jxp6GxPLCLiV0UblYsI
         sBUA==
X-Gm-Message-State: APjAAAU5xTg35TeK95qIU+Y4DJpnfkTnwKTaQgxYMJQXL1ldAt6iC+n3
        F1I13/acplMLyO/uno+i6lOfxKgz
X-Google-Smtp-Source: APXvYqzB6F7GVc2P/vdc99tPiND53CNErHrnx/6SB9dA9xIarGsroG8GHVpNUdhbPwiRTCuWtmIlSA==
X-Received: by 2002:a17:90a:5d15:: with SMTP id s21mr8923444pji.125.1559306878540;
        Fri, 31 May 2019 05:47:58 -0700 (PDT)
Received: from [10.0.2.15] ([157.40.69.0])
        by smtp.gmail.com with ESMTPSA id q7sm10413838pjb.0.2019.05.31.05.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 05:47:57 -0700 (PDT)
Subject: Re: [PATCH] staging: comedi: Remove variable runflags
To:     Ian Abbott <abbotti@mev.co.uk>, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org, olsonse@umich.edu, jkhasdev@gmail.com,
        giulio.benetti@micronovasrl.com, nishadkamdar@gmail.com,
        kas.sandesh@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20190530205131.29955-1-nishkadg.linux@gmail.com>
 <8292224d-9c4a-d29e-4a86-d3352fcd2be1@mev.co.uk>
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
Message-ID: <ceb54997-3057-81df-f3f0-e04b36e950c4@gmail.com>
Date:   Fri, 31 May 2019 18:17:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8292224d-9c4a-d29e-4a86-d3352fcd2be1@mev.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/19 3:55 PM, Ian Abbott wrote:
> On 30/05/2019 21:51, Nishka Dasgupta wrote:
>> Remove variable runflags and use its value directly. Issue found with
>> checkpatch.
>>
>> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
>> ---
>>   drivers/staging/comedi/comedi_fops.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/comedi/comedi_fops.c 
>> b/drivers/staging/comedi/comedi_fops.c
>> index f6d1287c7b83..b84ee9293903 100644
>> --- a/drivers/staging/comedi/comedi_fops.c
>> +++ b/drivers/staging/comedi/comedi_fops.c
>> @@ -676,16 +676,12 @@ EXPORT_SYMBOL_GPL(comedi_is_subdevice_running);
>>   static bool __comedi_is_subdevice_running(struct comedi_subdevice *s)
>>   {
>> -    unsigned int runflags = __comedi_get_subdevice_runflags(s);
>> -
>> -    return comedi_is_runflags_running(runflags);
>> +    return 
>> comedi_is_runflags_running(__comedi_get_subdevice_runflags(s));
>>   }
>>   bool comedi_can_auto_free_spriv(struct comedi_subdevice *s)
>>   {
>> -    unsigned int runflags = __comedi_get_subdevice_runflags(s);
>> -
>> -    return runflags & COMEDI_SRF_FREE_SPRIV;
>> +    return __comedi_get_subdevice_runflags(s) & COMEDI_SRF_FREE_SPRIV;
>>   }
>>   /**
>>
> 
> I couldn't reproduce this checkpatch issue, even with '--subjective'.

I'm sorry, that was extremely careless of me. I used Coccinelle to find 
this, not Checkpatch.
Here is the Coccinelle script I used:

@@identifier i1, i2, f1, f2; type T; expression e1, e2; statement S1, S2;@@
(
- T i1 = f1(...);
|
- T i1 = e1;
)
... when != e2 = <+...i1...+>
     when != if (<+...i1...+>) S1 else S2
     when != f2(...,<+...i1...+>,...)
     when != i1->i2
     when != i2[<+...i1...+>]
     when != while(<+...i1...+>) S1
     when != for(...;<+...i1...+>;...) S1

Again, I'm sorry for the confusion; I don't know why it happened, but it 
won't happen again.

Nishka

