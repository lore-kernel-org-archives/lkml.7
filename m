Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161E9C468BC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 04:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E013320833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 04:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss5p1Lwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfFJEce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 00:32:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42439 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbfFJEcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 00:32:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id go2so3099878plb.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 21:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xHPzuC4R5KkZBw6vFRw90KpfbbD11GlApZT+SmWKwe4=;
        b=Ss5p1Lwy68hqtdh3br0uV9egK7a/GcBg6EEsyJeGu3+IIamR5xkByvx2tCZ3y7Pg1w
         4AK9N2fAAHodTXOMEkPMOly1SMDOxOTdYTyhHevVoNx6X36PPgiWxsifLf7/zsSiA+4k
         mg2fPTy6ll0dYm6QUjXkHGHXlEg7AOA+hyZluTdR8NVIWGiLy0L1Jvm2noL1EU5zHBHC
         uwTI0rS8FMVQZzi1pxjYgZ8FMZTMK3T8bFbPSuFTDGd49mQFGYZZ/x/hjA/v8rs2wWBj
         ZoZFmr4M6gsuWs0fI7llM7xLgY4a3gRQAjEvZ+g52+ZcjGDCzi7bpRtbc9BNB0HwPCdE
         G0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xHPzuC4R5KkZBw6vFRw90KpfbbD11GlApZT+SmWKwe4=;
        b=Q80i9HoqfwLdKq25mS7/PeUCWETC5sgRYUfyoOprnVM/OfcR2VnwjV1UtO7iSsrfDf
         j9BUTvb8Fqci0U8z0FgY3BZx0+s1F26/K2B5OBVjzjkL+6UGd/GuVXkxZoaQrLmy5fsv
         jTGEaLRuRrYQC8kZRMFYPmDOHA3R9ZbWI1gpQw/LlTCctywfmOgn9qr917hPw3U2OEyO
         T4kjwJ9v+AcVyzkO1ON58h63mKSVNz8YbDz8EnbDKBHKkpquevB2sStgGBRD+FPQQ7ys
         aXNK232clRAtkeGyKIEvRCmHlZ0LbowGlAb34kC4Iw3k3dt/Xl3zuTlXqkkecYdAx3uw
         YfqA==
X-Gm-Message-State: APjAAAV0Q/NLgvuRTfnwe9N4FUuabuW6qElqnVm+KEiaOEPX17AdIzSZ
        /bwYxxBfVBdTxQFIbtyyAgs=
X-Google-Smtp-Source: APXvYqzpCQBfxr7tCmPsXXFKsBCVmnhsOxlS5W/E2s+08qDC23SjwQwMkTJAH20Cb2JhL1mczbwGjQ==
X-Received: by 2002:a17:902:968b:: with SMTP id n11mr32173861plp.120.1560141153272;
        Sun, 09 Jun 2019 21:32:33 -0700 (PDT)
Received: from [10.0.2.15] ([171.79.92.225])
        by smtp.gmail.com with ESMTPSA id m20sm9102784pjn.16.2019.06.09.21.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 21:32:32 -0700 (PDT)
Subject: Re: [PATCH 1/2] staging: rtl8712: r8712_setdatarate_cmd(): Change
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, straube.linux@gmail.com,
        larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        colin.king@canonical.com, valdis.kletnieks@vt.edu,
        tiny.windzz@gmail.com
References: <20190607140658.11932-1-nishkadg.linux@gmail.com>
 <20190607141548.GP31203@kadam>
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
Message-ID: <98b587c9-df5b-0905-ab8f-69a4bae296b0@gmail.com>
Date:   Mon, 10 Jun 2019 10:02:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607141548.GP31203@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/19 7:45 PM, Dan Carpenter wrote:
> Probably you sent this patch unintentionally.  The subject doesn't make
> any sort of sense.  :P

So the problem with the subject line is that git send-email and vim (as 
configured on my laptop) tend to line-wrap even the subject line. Since 
I have two patches that do the same thing for different functions, I 
felt I should have the driver and the function name in the subject line 
(to avoid confusion between the patches and to allow for easy searching 
later). But that doesn't leave enough space in the subject line for 
"Change return values/type" or any other descriptive message. What 
should I do?


> On Fri, Jun 07, 2019 at 07:36:57PM +0530, Nishka Dasgupta wrote:
>> Change the return values of function r8712_setdatarate_cmd from _SUCCESS
>> and _FAIL to 0 and -ENOMEM respectively.
>> Change the return type of the function from u8 to int to reflect this.
>> Change the call site of the function to check for 0 instead of _SUCCESS.
>> (Checking that the return value != 0 is not necessary; the return value
>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> itself can simply be passed into the conditional.)
>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



> This is obvious.  No need to mention it in the commit message.

Okay, I'll amend that.

>> diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
>> index b424b8436fcf..761e2ba68a42 100644
>> --- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
>> +++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
>> @@ -1367,7 +1367,7 @@ static int r8711_wx_set_rate(struct net_device *dev,
>>   			datarates[i] = 0xff;
>>   		}
>>   	}
>> -	if (r8712_setdatarate_cmd(padapter, datarates) != _SUCCESS)
>> +	if (r8712_setdatarate_cmd(padapter, datarates))
>>   		ret = -ENOMEM;
>>
>>   	return ret;
> 
> 
> It would be better to write this like so:
> 
> 	ret = r8712_setdatarate_cmd(padapter, datarates);
> 	if (ret)
> 		return ret;
> 
> 	return 0;
> 
> Or you could write it like:
> 
> 	return r8712_setdatarate_cmd(padapter, datarates);

Okay, since this is the only point at which a return happens in this 
function, I can do this.

> Which ever one you prefer is fine
Thanking you,
Nishka

> regards,
> dan carpenter
> 

