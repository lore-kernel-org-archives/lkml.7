Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886D1ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7CC2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZgbqFiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392050AbfJQB3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 21:29:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36600 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfJQB3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 21:29:45 -0400
Received: by mail-qk1-f196.google.com with SMTP id y189so406665qkc.3;
        Wed, 16 Oct 2019 18:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=WuM4nCTZ81BlJjiPSurvi5qoJfBbsasN21+Lbs4hI80=;
        b=YZgbqFiOHWigqEcnJTqSXSR3rpJQ9coxv7bijJC+IrPHRpZfIMgmMKhjjg8ltsUrzY
         d3fm19++8UGhjVn/X0+q2Q2uAY/8+ogW8b3lLVAwHB+yIbhvadVpU5f5Dw5hGIWONQQj
         cz5lAUxv5QsvX4TsyvcRAc6L0inAPwA2WuDEq6COkDo92UjY7tDN9KQo5y7sc+DzWYLx
         LVL1FA9TFH0kOlqet1p/FCqG5ptiGrftb5LIWKFdxMuS3ERsBhXtMtp7PmlPBUcSgxmc
         O8V8P4oQsfDs/FDa5FKdKIhXc9h8UFxCPSt5zOx8TzMtIMw8EnnHbDnC8766FJcDTALH
         FrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WuM4nCTZ81BlJjiPSurvi5qoJfBbsasN21+Lbs4hI80=;
        b=N8UIuB4jTbCwNEPVpVnXgkHwe+KGSAS+GCBPHQFeVJGe/EsXyc+LHnIGqHu+N+YYRX
         XyfdtZ3umCw0cxM0y13tO5pdg0/el0B6N1DpFX4F8T/qwBh9SZuj8l3L6GXssCkGg+cd
         30uXRGo+zH+ZqvBq1FvwodYra9q33uKxO34UhG6p0WijtyF2SJuYq4QeU5zaHMjazBfS
         iQbqhriZ+g01Rd027djC9v/ix0WJcVf5VViwDrBfJjSqxDXuycn3KHtdHAhrA6qDslNx
         ecj6PZ0uAMGqEGR/aSqXxMDrNXl2EAV8SPlZJErUaTSqgCSjX54Zt8SLGNYp5gj4kh8S
         ZyXA==
X-Gm-Message-State: APjAAAVj3AyKxX2u0Bo9zYrktgc358IQTWs5MJ9BEe9Do44PUdO1jQWX
        iBqU2CICei7gl5+q+DnOES8=
X-Google-Smtp-Source: APXvYqyEL0e9Qjox5zgJhKGGHo4fwV8d4cO8SiGrDORpEBQhAgKYy+ontyyqyDjou0k5tCq2KZ/XdA==
X-Received: by 2002:a05:620a:1211:: with SMTP id u17mr975797qkj.310.1571275784353;
        Wed, 16 Oct 2019 18:29:44 -0700 (PDT)
Received: from [192.168.1.101] ([201.53.210.37])
        by smtp.gmail.com with ESMTPSA id g25sm350465qtp.96.2019.10.16.18.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 18:29:43 -0700 (PDT)
Subject: Re: [PATCH] staging: sm750fb: format description of parameters the to
 kernel doc format
To:     Randy Dunlap <rdunlap@infradead.org>,
        outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
References: <20191017011849.6081-1-gabrielabittencourt00@gmail.com>
 <799632e2-a328-d72b-397d-3ee6b5e87e06@infradead.org>
From:   gbittencourt <gabrielabittencourt00@gmail.com>
Message-ID: <d55516db-28c5-aa53-8d07-20201dc4ffca@gmail.com>
Date:   Wed, 16 Oct 2019 22:29:27 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <799632e2-a328-d72b-397d-3ee6b5e87e06@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 10/16/19 10:25 PM, Randy Dunlap wrote:
> Hi,
>
> On 10/16/19 6:18 PM, Gabriela Bittencourt wrote:
>> Cluster comments that describes parameters of functions and create one
>> single comment before the function in kernel doc format.
> Good plan.
>
> How did you test this patch?
I haven't test it. How can I do it?
>
>> Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
>> ---
>>   drivers/staging/sm750fb/sm750_accel.c | 65 +++++++++++++++------------
>>   1 file changed, 37 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
>> index dbcbbd1055da..d5564cd60f3b 100644
>> --- a/drivers/staging/sm750fb/sm750_accel.c
>> +++ b/drivers/staging/sm750fb/sm750_accel.c
>> @@ -130,20 +130,24 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
>>   	return 0;
>>   }
>>   
>> -int sm750_hw_copyarea(
>> -struct lynx_accel *accel,
>> -unsigned int sBase,  /* Address of source: offset in frame buffer */
>> -unsigned int sPitch, /* Pitch value of source surface in BYTE */
>> -unsigned int sx,
>> -unsigned int sy,     /* Starting coordinate of source surface */
>> -unsigned int dBase,  /* Address of destination: offset in frame buffer */
>> -unsigned int dPitch, /* Pitch value of destination surface in BYTE */
>> -unsigned int Bpp,    /* Color depth of destination surface */
>> -unsigned int dx,
>> -unsigned int dy,     /* Starting coordinate of destination surface */
>> -unsigned int width,
>> -unsigned int height, /* width and height of rectangle in pixel value */
>> -unsigned int rop2)   /* ROP value */
>> +/**
> Missing function name and short description.  Documentation/doc-guide/kernel-doc.rst says:
>
> The general format of a function and function-like macro kernel-doc comment is::
>
>    /**
>     * function_name() - Brief description of function.
>     * @arg1: Describe the first argument.
>     * @arg2: Describe the second argument.
>     *        One can provide multiple line descriptions
>     *        for arguments.
>     *
>     * A longer description, with more discussion of the function function_name()
>     * that might be useful to those using or modifying it. Begins with an
>     * empty comment line, and may include additional embedded empty
>     * comment lines.
>     *
>     * The longer description may have multiple paragraphs.
>     *
>     * Context: Describes whether the function can sleep, what locks it takes,
>     *          releases, or expects to be held. It can extend over multiple
>     *          lines.
>     * Return: Describe the return value of function_name.
>     *
>     * The return value description can also have multiple paragraphs, and should
>     * be placed at the end of the comment block.
>     */
>
>> + * @sBase: Address of source: offset in frame buffer
>> + * @sPitch: Pitch value of source surface in BYTE
>> + * @sx, @sy: Starting coordinate of source surface
> Those should be on separate lines.
>
>> + * @dBase: Address of destination: offset in frame buffer
>> + * @dPitch: Pitch value of destination surface in BYTE
>> + * @Bpp: Color depth of destination surface
>> + * @dx, @dy: Starting coordinate of destination surface
> Ditto.
>
>> + * @width, @height: width and height of rectangle in pixel value
>> + * @rop2: ROP value
>> + */
>> +int sm750_hw_copyarea(struct lynx_accel *accel,
>> +		      unsigned int sBase, unsigned int sPitch,
>> +		      unsigned int sx, unsigned int sy,
>> +		      unsigned int dBase, unsigned int dPitch,
>> +		      unsigned int Bpp, unsigned int dx, unsigned int dy,
>> +		      unsigned int width, unsigned int height,
>> +		      unsigned int rop2)
>>   {
>>   	unsigned int nDirection, de_ctrl;
>>   
>> @@ -288,20 +292,25 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
>>   	return de_ctrl;
>>   }
>>   
>> -int sm750_hw_imageblit(struct lynx_accel *accel,
>> -		 const char *pSrcbuf, /* pointer to start of source buffer in system memory */
>> -		 u32 srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
>> -		 u32 startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
>> -		 u32 dBase,    /* Address of destination: offset in frame buffer */
>> -		 u32 dPitch,   /* Pitch value of destination surface in BYTE */
>> -		 u32 bytePerPixel,      /* Color depth of destination surface */
>> -		 u32 dx,
>> -		 u32 dy,       /* Starting coordinate of destination surface */
>> -		 u32 width,
>> -		 u32 height,   /* width and height of rectangle in pixel value */
>> -		 u32 fColor,   /* Foreground color (corresponding to a 1 in the monochrome data */
>> -		 u32 bColor,   /* Background color (corresponding to a 0 in the monochrome data */
>> -		 u32 rop2)     /* ROP value */
>> +/**
> Similar comments here...
>
>> + * @pSrcbuf: pointer to start of source buffer in system memory
>> + * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
>> + * and -ive mean button up
>> + * @startBit: Mono data can start at any bit in a byte, this value should be
>> + * 0 to 7
>> + * @dBase: Address of destination: offset in frame buffer
>> + * @dPitch: Pitch value of destination surface in BYTE
>> + * @bytePerPixel: Color depth of destination surface
>> + * @dx, @dy: Starting coordinate of destination surface
>> + * @width, @height: width and height of rectangle in pixel value
>> + * @fColor: Foreground color (corresponding to a 1 in the monochrome data
>> + * @bColor: Background color (corresponding to a 0 in the monochrome data
>> + * @rop2: ROP value
>> + */
>> +int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
>> +		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
>> +		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
>> +		       u32 height, u32 fColor, u32 bColor, u32 rop2)
>>   {
>>   	unsigned int ulBytesPerScan;
>>   	unsigned int ul4BytesPerScan;
>>
> Thanks.
Thanks.
