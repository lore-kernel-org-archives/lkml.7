Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4811AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181FD205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuBmnlOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfCYVLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:11:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39590 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbfCYVLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:11:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id m13so7070269lfb.6;
        Mon, 25 Mar 2019 14:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+7Uh8LOj1LZFVpA2U884cHEZy6CKZj9HKoIu42TLXgE=;
        b=EuBmnlOhbQHrOT3ngviRKIFmZDhrRO2aE1GgAdnbd6MVK/gwFLSQEKBJY/9yIrwhpv
         5afCyF9veQ+38cfwroSjB5uYq2RO7kVozZ2u6nctcnEWDMSXIoDDclsADkTJcGZTkQpr
         U29mnDNf33FHxpedGsnQfl4tpVXium7ijjeK4qE2pxCYMDiaKIC2T2tnW+q0n/qJUeIY
         D5zO1vbypfuZYATfigikcDgYCODHbWWFecwVRHF7TJAIH1yaC8zXtzP9oASIIqZh3Lcc
         d1eh2gfyDGXm5QBJSJ45eywv88JiM7+qEpNaLYDjF2VitOinjhWOa8869UIIqOGZaRhW
         oqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+7Uh8LOj1LZFVpA2U884cHEZy6CKZj9HKoIu42TLXgE=;
        b=Tgpr8HlpMNd9Vcqbjo3ThLkoUjtPN30HORPGpfu2lPy8p8/FQ61puooUQ2+wPedIUa
         A4MiFlV8EPTeM9YTAWloqu9DUX43QCty+0LuT0jZv7rj7mVjWdPFCoBU6wB2nE2oij51
         CzXecO3uhDMcGkEF5osWfG2zR4o5y2gLRDJOPKSyIQs4w6LnpMFvuznWIIkXRflsfrh/
         /ffz+GhNv6cUO/T2cFi5enJvnqM2U5DffV9HAKcx8CNkaoRYxxNq4GswhDIEXnSjH53B
         N2E3+JX5Rd9ng12xo4RR1Yg/32I/4RjLF9/T14KTlgsG4BWvnSsW6RNJquiXaqWJ1SkV
         2XBQ==
X-Gm-Message-State: APjAAAXMBE6YZrrrV/rzrX4UMR7AZhun9x2YvrXfiDlTw6f6nF1Xvj5a
        kL1cf8wmu4k8gTOGM/F2Q4PmWdMO
X-Google-Smtp-Source: APXvYqx109r3sX9qw5G2XfGxduik1f/2+LVIoBF6aymUqhUw9PjGIo0MnticPUFCJ7LdE31wgX5gkw==
X-Received: by 2002:a19:f50f:: with SMTP id j15mr14144396lfb.126.1553548265175;
        Mon, 25 Mar 2019 14:11:05 -0700 (PDT)
Received: from [192.168.1.19] (bku127.neoplus.adsl.tpnet.pl. [83.28.188.127])
        by smtp.gmail.com with ESMTPSA id z29sm3548604lfg.52.2019.03.25.14.11.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 14:11:04 -0700 (PDT)
Subject: Re: [PATCH 3/4] mfd: ti-lmu: Remove LM3532 backlight driver
 references
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz,
        tony@atomide.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20190321142838.22985-1-dmurphy@ti.com>
 <20190321142838.22985-3-dmurphy@ti.com>
 <8769a95d-179f-6219-0a63-9dd623cdd297@gmail.com> <20190325075317.GW4731@dell>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <c950b7d3-eeb1-2dc2-b732-3a40d5b3a8b7@gmail.com>
Date:   Mon, 25 Mar 2019 22:11:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325075317.GW4731@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 8:53 AM, Lee Jones wrote:
> On Sat, 23 Mar 2019, Jacek Anaszewski wrote:
> 
>> Hi Lee,
>>
>> Can we have your ack for this going via LED tree, please?
> 
> Patch looks okay.
> 
> You can take it through the LED, but if you do I will need you to send
> me a pull-request to a minimised immutable branch please.
> 
> If you cannot do this, I can apply the set and provide the same to
> you.
> 
> If you choose the former:
> 
>    Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> Please let me know what you decide
> 

I've been exposing integration branches in the past, but after Linus'
message [0] I have my doubts now. I wonder if it wouldn't make more
sense if I just took the patches, and you'd cherry-pick them only in
case such a need occurs. This way we would avoid this whole merge
noise, which in an optimistic and very plausible case will not be needed
at all.

[0] https://lkml.org/lkml/2017/4/19/1104

-- 
Best regards,
Jacek Anaszewski
