Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68889C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 22:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAA420657
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 22:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCUcYqb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfCIWfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 17:35:48 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:38715 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfCIWfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 17:35:47 -0500
Received: by mail-pf1-f181.google.com with SMTP id n125so824864pfn.5;
        Sat, 09 Mar 2019 14:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MNaglBX7B2MzE2UPKFCqc8CDwhL3gLHcEoQ+mAwq/6c=;
        b=rCUcYqb3RRvfu9Rq2tAz2CX0tBJHMnNUdYqMew5KUkH37NuBxjyCafWr3v2zi+noCS
         mpXBrtRWigYlgfgKfpHWOpyhL3lAF32mRLSmdPqJR1G1Cv3/y6fu79XK6KSF3SLCudJA
         1YxTHqTGUSwQ2A4mLRd4xfRt9IhhTEnZhyO5PhsUQBSWifbi5uiMw8bWu/zbxX+rAIIT
         elUgnPiA78F6w048EdNrATesTJQC6alzKbZA24a8DSiGSOH3LwbrNhHOGkRNucd46OeX
         k60X/iWe8Q8Nz/0bvh5hf4wqKFTjnEmEp1S+lfZOMg7fyFZUXZ4WnqQ/ooApe9AkSWWz
         xCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MNaglBX7B2MzE2UPKFCqc8CDwhL3gLHcEoQ+mAwq/6c=;
        b=g+cXM86xX0ioGYJ9NTnzc3XAC0cuGEcHyOHbWdi9gjZM+5UyWAbK75KSijOtNyiugG
         uLjkGRatDNp4NHPVwJTC8sTghsDHDZB2hVM5By7JXurnmcJM4WCu6ZN7K0981NS+jHBA
         Pxin6rDPE/Glu1IJBDQbPs9stv3ydbrxJpy7QLfw8k7PcojRtyVfcU9YfQSj8FqLZXWq
         OUN7Y/+otb2Jd+Di8Lhg+k+FTcNAXwwEiVS+hnWzmraLevAXQGRomWXsd8GUZkAwPbMK
         IJxaO8xrE7g06YsV+1xpHBZAArLbV/04YLHY3EVZgctzPXEh+Qrx72rOC1dTrtYVAPOJ
         9AdA==
X-Gm-Message-State: APjAAAU1nVcS1DQjMFwEjapIJIvN9nHYTOmm8uWI2KAjIjJthXH0BRFb
        jE2MYtZCUfJDEf4oSMA7b9yWsZ7c
X-Google-Smtp-Source: APXvYqxP1xydhI3B86B1ITKz29peN3TWtd3zj+r+Lt2HY8b82Mv5ZUYJJa/ZmXkI+KaLB3e8WVBwtw==
X-Received: by 2002:aa7:91d7:: with SMTP id z23mr26028098pfa.137.1552170946805;
        Sat, 09 Mar 2019 14:35:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b65sm2382620pfm.127.2019.03.09.14.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 14:35:46 -0800 (PST)
Subject: Re: [PATCH 4.20 00/76] 4.20.15-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190308124914.789210760@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <005696a1-b0af-c4fa-8b49-c8ce3bb4ee0b@roeck-us.net>
Date:   Sat, 9 Mar 2019 14:35:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/19 4:49 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.15 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 10 12:48:49 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
