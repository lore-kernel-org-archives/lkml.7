Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAAECA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E4C2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP4Gq/5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbfJ1Nef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 09:34:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34480 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfJ1Nef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:34:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id e4so2595297pgs.1;
        Mon, 28 Oct 2019 06:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lJ7KQ+REwM0xQ8Im/wZ/WZKbyrekCI5+Vrs+SZxQrJg=;
        b=iP4Gq/5/uCsJtZOhcaC5p1OTrEuUjM+eAUauvev+eL5G8uc7yDjAqDxF7iG4XTR1oo
         1BfDvds8CDGoRN0QALhAA+BcRNCUgEqQTPKYO+j1rBbB7zyYT/rMTeyc5D9dNAFFGFVk
         00iFILUYp0P61Rk2ucskxc22E1gYZdOuB2mFoUckIlYbonkYHr4VZpdzZY0yOxeYueqV
         4xAs3iWxGy7gCd5bbBKtywpkFenCMm1b7pBenmUUOnTaXr64Inr1YBdsu9OZ9iDyl0DB
         p1okLjIkzY6Bps3pe/03ntKereWe/ie5GqaM6/xq8Z87buycT2nuUcOeeKd0V/wojSKJ
         LqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lJ7KQ+REwM0xQ8Im/wZ/WZKbyrekCI5+Vrs+SZxQrJg=;
        b=CSRfm5qHdnG39Ky6+lTv5kC6LLFhus+0qO2GFbo2/a5jVTIqMP8e+A0KWhTsECQXWH
         /uqdF05KvBrATpsHr1eKkPgIv3XaXp49MfwmA5RU1XY4afu3bZKA9+e69s49aSRJtBlA
         uzDb0EYUOeGFQleBPAfzIFf5x/qEcsxrwClq0PzAxce1U7q3FeQTOYP7/1Q2c/L8gZNz
         N/0LmqKWmG3hxyU/T/AYaBgZ7wXuLF0tmQGjoLIV1Bn1qoH3C1umLQyq3mg91qmcBsoF
         pyl+eLegFabmTkpV3VLJrxuvC6Ao1l0l83MYjnACygr3J/EhwqaS4qRC7cRIslMoM9/C
         H+9Q==
X-Gm-Message-State: APjAAAVV7L9/h4vLEchMbvxY7qRJLHXxfB0VJ/ZEeIDfadQwxjJRs7Sl
        3avAiiSuXs9cNtLn/a1Ndq8FCBA/
X-Google-Smtp-Source: APXvYqwNJhlSpXqnasMnN0xVWapPYRIRuaARxa4hj/a2NAtJD+Nkl/WNCO06zSprRUQun6AvKeMPMw==
X-Received: by 2002:a63:6949:: with SMTP id e70mr20619917pgc.226.1572269674453;
        Mon, 28 Oct 2019 06:34:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 16sm7788140pfc.21.2019.10.28.06.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 06:34:33 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/49] 4.9.198-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20191027203119.468466356@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5b9da5d6-9622-d640-9621-ea61fa266d97@roeck-us.net>
Date:   Mon, 28 Oct 2019 06:34:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191027203119.468466356@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/19 2:00 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.198 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue 29 Oct 2019 08:27:02 PM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 159 fail: 13
Failed builds:
	All mips
Qemu test results:
	total: 356 pass: 298 fail: 58
Failed tests:
	All mips

Guenter
