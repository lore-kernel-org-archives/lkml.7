Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA0BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CC220830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyzOgv5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbfDJKua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:50:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45343 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730487AbfDJKua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:50:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id bf11so1182386plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 03:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qt7J+BOdc4k1brjEj7nBHghxg+YhvcBrkx9XRiQmp+M=;
        b=FyzOgv5QAUpUVqJhOr6dgsRFFTe0/u1nzI+WBfYfJ1F9wBrWVTqlXbpOZhZf/8IpHz
         6IRwE+xTgxzgrKq9nk3DIT6rgQsXXB5+H9eLVUtUi/YcfgOYbavRHJ2OREcmalN2LehN
         3M3ROKG4XBVMtzorlmMIj2L++50x0xl3AGls1Yy84be4swGAp7N/LbxUYdVmWvgVdtI3
         JN6SwU58lY9CAdP8YwBtkNQqbCI/cpNjxuoc0zIaQCY6kuyQPDtapcfJePgq1lwiRuUo
         yovAEyP2QX1mL991ykCWejlr9ZrYzwdUMixfSm3Qwp82OE9n6qGWdxx/m1u/Nrb/ctg/
         Gytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qt7J+BOdc4k1brjEj7nBHghxg+YhvcBrkx9XRiQmp+M=;
        b=e0Vz6Hmqh4sJvtz4YiSMidb4mrtPmGgilCOCQwvZSwPTZDCYNI/et4wmJjPAfFRsGb
         O1lNVmDijcfi7x4LiiLeLpiMbiblDWj0OlhqWYsPfBwJHJyAPJoKUlBkCiRMOiLtPUdn
         DydYF8ZJuBOiW3Am67fhSN3vCKcbOJoZVL/vwVsqlrDS1Hala4G5CsxE5JGvfXBsppd6
         PEPahXgGrdyIAmi4Yq8ldBZZKIflMEGbUvsvQEGO0ErktJSjKHZOFpIzykSNJypVB1zo
         SPP1oBa59a0gLiWGkI9yNh59atb89gGn1S03JOxNwLbUcMkOGy2KFuOShUuS2k4g6Ejw
         NOTQ==
X-Gm-Message-State: APjAAAVZV31pIfgjCNBdRM+T2DGCMFoMnAo1sy8OP8ZYZ8PLiBuiTA6j
        8nCHmCISoujCBJMOhTtKrNtQbru+
X-Google-Smtp-Source: APXvYqxPsW4WWCMV0oki0+Af1DgYMkiSqRY8w8i82dfIcja1Qi6Yu1txl6egoOq08cyFp+g4kC1pzQ==
X-Received: by 2002:a17:902:b10c:: with SMTP id q12mr42901746plr.254.1554893429085;
        Wed, 10 Apr 2019 03:50:29 -0700 (PDT)
Received: from ?IPv6:2405:204:8382:93c7:dd33:fc65:e9c2:ba4? ([2405:204:8382:93c7:dd33:fc65:e9c2:ba4])
        by smtp.gmail.com with ESMTPSA id i2sm51488518pfo.9.2019.04.10.03.50.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 03:50:28 -0700 (PDT)
Subject: Re: [PATCH] staging: fbtft: fix alignment should match open
 parenthesis
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20190410100022.11091-1-himadri18.07@gmail.com>
 <20190410104240.GG6095@kadam>
From:   Himadri Pandya <himadri18.07@gmail.com>
Message-ID: <3509afac-e460-8b68-22b4-98b91600d9a1@gmail.com>
Date:   Wed, 10 Apr 2019 16:20:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410104240.GG6095@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/04/19 4:12 PM, Dan Carpenter wrote:
> On Wed, Apr 10, 2019 at 03:30:22PM +0530, Himadri Pandya wrote:
>> Fix checkpatch warning "Alignment should match open parenthesis".
>>
>> Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
>> ---
>>   drivers/staging/fbtft/fb_tinylcd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
>> index 9469248f2c50..60cda57bcb33 100644
>> --- a/drivers/staging/fbtft/fb_tinylcd.c
>> +++ b/drivers/staging/fbtft/fb_tinylcd.c
>> @@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
>>   	write_reg(par, 0xE5, 0x00);
>>   	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>>   	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
>> -		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
>> +		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
> The original code was written that way deliberately.  I don't know
> why it's broken up like that but it probably means something to people
> who have read the hardware spec.  I would leave it as-is.
>
> regards,
> dan carpenter

Okay. Thank you for reviewing it.

- Himadri

