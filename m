Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44A1C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3B220835
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6HuLi55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfCCSEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 13:04:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42985 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfCCSE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 13:04:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id r5so3050003wrg.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 10:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TOufMnnmmtNHGEIKEMQa4bsFweIFVBHcN5FRcpt4CGQ=;
        b=a6HuLi55skSx7K3RFRFHDADAUgmijw44+EBn2lt+/4Wbk4bt24mzk3T0JNT4zma/0q
         rXiKP4DC3f+K9rOaNVSmPFwRBfAj+oSiRSVpkIuc+7/xebLq4fOfQa04SmFVSvyRzuv8
         qeu7asVk6ZzZv8s+BWWpryGEJBz/P2VkJbCgCpLZliIEzvJrdO5mb5yfOEJKfIsj33QQ
         qXrPCUqR/KYYzAj068POTcvGvM9msavABbsWv/t9ECumcNZFBQYiqVnChRpGvAU9XEPa
         1NrVR2lZ7wxKUEPuid60T0QaB2iSztxBxnTsIcBaKMKLgxaUA45Ia962BJJlzp+GT/bQ
         STdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TOufMnnmmtNHGEIKEMQa4bsFweIFVBHcN5FRcpt4CGQ=;
        b=Nk4eo3MFJFGB3D7ANXEJHxR6bIHNRxIPnqUFwCU7L1eI9DahonKNuEWsiSUULmAkX9
         LpWKn0gHrY2OP+vuU2n9gFmsljEJb4BX+cfa0WBqOQRGo/dA74jZfEhbZTAhRFamGCK6
         R+zs8hmwQVCXjndo0DWMuuCL0l0gvGUZ2/wylfjcmcChHo293xk2cYihmIRfhbP5EK2C
         sPhYXTwlrXRNZsbG2nmaT8vvLXV3T9rlJ4Be6FJPaQMz6ECtCLM8u5ZeKHxkRsun4ZqT
         YDna0pJnrbVM+TYWEvvaDiUtJCEtmjyqrd+Z4st/0GNPwn7MH/Kd+Jn39YzmxVCTDiqu
         XsKg==
X-Gm-Message-State: APjAAAVCqFrRQYWyc+EFN3ZrvGnCsOziK5raWiO/VzzZ2aYwGiM1Dovs
        owU75BlBzohLlrxHUXZl5MpZlnzV
X-Google-Smtp-Source: APXvYqyNTFUM+lomECPiHujpzIYetetnuNYUsfc5sgoRXvYSHHOTn5AuKyWtooS8L8TRArIen8Z49w==
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr6625639wrv.242.1551636267649;
        Sun, 03 Mar 2019 10:04:27 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:35a8:f48d:4b19:96c9? (p200300EA8BF1E20035A8F48D4B1996C9.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:35a8:f48d:4b19:96c9])
        by smtp.googlemail.com with ESMTPSA id y140sm15696887wmd.18.2019.03.03.10.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 10:04:27 -0800 (PST)
Subject: Re: Fwd: [PATCH net-next 1/2] lib: string: add strreplace_nonalnum
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <981d965e-b25b-be2b-2067-07aec5eafc7a@gmail.com>
 <43eb3aad-0e0b-9019-dfe3-47f205607df0@gmail.com>
 <20190303175514.GA16636@kroah.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <e55de1df-b70a-93b5-9f18-072392fa0657@gmail.com>
Date:   Sun, 3 Mar 2019 19:04:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190303175514.GA16636@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.03.2019 18:55, Greg Kroah-Hartman wrote:
> On Sun, Mar 03, 2019 at 06:47:32PM +0100, Heiner Kallweit wrote:
>> I submitted this through the netdev tree, maybe relevant for you as well.
>> See also here: https://marc.info/?t=155103900100003&r=1&w=2
>>
>> -------- Forwarded Message --------
>> Subject: [PATCH net-next 1/2] lib: string: add strreplace_nonalnum
>> Date: Sun, 3 Mar 2019 18:20:50 +0100
>> From: Heiner Kallweit <hkallweit1@gmail.com>
>> To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, David Miller <davem@davemloft.net>
>> CC: netdev@vger.kernel.org <netdev@vger.kernel.org>
>>
>> Add a new function strreplace_nonalnum that replaces all
>> non-alphanumeric characters. Such functionality is needed e.g. when a
>> string is supposed to be used in a sysfs file name. If '\0' is given
>> as new character then non-alphanumeric characters are cut. 
> 
> sysfs doesn't have any such requirements, it can use whatever you want
> to give it for a filename.
> 
Even a slash?
HWMON drivers is an example where such functionality occurs open-coded.

> So don't create a random kernel function for sysfs please.
> 
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  include/linux/string.h |  1 +
>>  lib/string.c           | 27 +++++++++++++++++++++++++++
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/include/linux/string.h b/include/linux/string.h
>> index 7927b875f..d827b0b0f 100644
>> --- a/include/linux/string.h
>> +++ b/include/linux/string.h
>> @@ -169,6 +169,7 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
>>  #endif
>>  void *memchr_inv(const void *s, int c, size_t n);
>>  char *strreplace(char *s, char old, char new);
>> +char *strreplace_nonalnum(char *s, char new);
>>  
>>  extern void kfree_const(const void *x);
>>  
>> diff --git a/lib/string.c b/lib/string.c
>> index 38e4ca08e..f2b1baf96 100644
>> --- a/lib/string.c
>> +++ b/lib/string.c
>> @@ -1047,6 +1047,33 @@ char *strreplace(char *s, char old, char new)
>>  }
>>  EXPORT_SYMBOL(strreplace);
>>  
>> +/**
>> + * strreplace_nonalnum - Replace all non-alphanumeric characters in a string.
>> + * @s: The string to operate on.
>> + * @new: The character non-alphanumeric characters are replaced with.
>> + *
>> + * If new is '\0' then non-alphanumeric characters are cut.
>> + *
>> + * Returns pointer to the nul byte at the end of the modified string.
> 
> Why do you need to point to the end of the string?
> 
I don't have to. I just tried to keep as close as possible to the original
strreplace().

> 
>> + */
>> +char *strreplace_nonalnum(char *s, char new)
>> +{
>> +	char *p = s;
>> +
>> +	for (; *s; ++s)
>> +		if (isalnum(*s)) {
>> +			if (p != s)
>> +				*p = *s;
>> +			++p;
>> +		} else if (new) {
>> +			*p++ = new;
>> +		}
>> +	*p = '\0';
> 
> No max length?  No error checking?  Surely we can do better, see the
> long thread on the kernel-hardnening list about string functions please.
> 
As for the review comment before, I basically used strreplace() as
template and extended it. What you say about hardening is right,
but it's open for quite a few functions, isn't it?
I'll have a look at the mail thread you mentioned.

> greg k-h
> 
Heiner
