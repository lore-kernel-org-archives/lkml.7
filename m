Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1D7C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8332077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxQBnfbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfD0Slu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 14:41:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40925 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfD0Slu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 14:41:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id s4so3283469pfh.7;
        Sat, 27 Apr 2019 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=21DwThvxufkJWxS+o0w3mnYdV/6wIi5J/6oGkHRvyVc=;
        b=ZxQBnfbHh8W/9leGDn8GO+wmb0vBhBO4PE0XfFhJGlS7LGSGFojSobVjhnCNcMbke0
         b1V3BocOjors5IeliViJvTCxkiokiT2wyfoVmPLbVn6sBn4AXNL7/U7QOnqfESVqzNEk
         khO17W8e7MNI0RFRT8FYjAv96mWfCLe6BA9rrfHuX9cyd/lAV2/3IO/Ff729lRrqLgLz
         rfS1NPZ7Jgk/xPfyUoNRH+wS1fHVxgqT8waAKtTpnoosK1XRgHi/s1MxZoaJkUugBj4M
         HPPG6magpPSnmbEqJpKQ3yRUb6uGhEqmYAd5R+dsrQ8OUWhydlooiZ4bsYH09wOuAJlK
         /3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=21DwThvxufkJWxS+o0w3mnYdV/6wIi5J/6oGkHRvyVc=;
        b=s5YSmmmwfp79s3XroAiLPl+Ru1ToYyymcCFZCgEvwDIVB557RN/ek8MuD4LZFVP17p
         7S1ag/mMoqS//yN7oAwuVqx1OVUOCIfNUEvr1VSsaAQsgjMpczIeNSkiNIDY2sppGY4o
         teo0mYqdb+o45E/CRmy1jxaVwra/onvIXs2RzpeIHiAnguG+gS0hKuoEmd1Rss17+ISu
         xYM9T3Cvt+NLIVjQURSLkGPrKzLCSVrSGP3b2XhuWXnGrBPSnVYwXbXDLY5M+PirMbe0
         5/pjDvHn1OsV7gfnMlWP7m5j+4ig0LlAQJPLBv/jqwrlzNl2KhpWRDd+VmkwnQe89Ugd
         9bLA==
X-Gm-Message-State: APjAAAURNxrJGn6YUxpCNiwYeofph2svaHOyYu2VLyvYN4p2bvDs5qVL
        C1I7NbFK4IeeCjYTett2CLQZ5cFT
X-Google-Smtp-Source: APXvYqwPj5ytl5tdEAecqYn4GhXSPbAB2yYuvzFKwuNdXslWVnMFcrSkZJ7EDA6eDHiUiRV07cutFQ==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr50760975pgj.396.1556390509778;
        Sat, 27 Apr 2019 11:41:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v19sm57129783pfa.138.2019.04.27.11.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 11:41:48 -0700 (PDT)
Subject: Re: [PATCH 3.16 000/202] 3.16.66-rc1 review
To:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        Denis Kirjanov <kda@linux-powerpc.org>
References: <lsq.1556377988.384060557@decadent.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <75f5b016-011b-8183-3d55-1fb3ddedfa7d@roeck-us.net>
Date:   Sat, 27 Apr 2019 11:41:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/19 8:13 AM, Ben Hutchings wrote:
> This is the start of the stable review cycle for the 3.16.66 release.
> There are 202 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May 01 18:00:00 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 137 pass: 136 fail: 1
Failed builds:
	i386:tools/perf
Qemu test results:
	total: 226 pass: 226 fail: 0

Guenter
