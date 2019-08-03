Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42EFC31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 15:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E0C20679
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 15:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0R6yoJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfHCP7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 11:59:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34451 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfHCP7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 11:59:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so31335626pgc.1;
        Sat, 03 Aug 2019 08:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kQnMGUpuUF8DUEv+N4lnxsQu4HZHm9a8tVrnn27y94I=;
        b=J0R6yoJD+pNi1sMe2V16NoMZLrF71ZF1MWasRpJxEbDHhpteLbkha4+VgPmEcDt9PO
         JBX9WBjXxNDbZ6+WqDGbmCyRFzzIBryoKDVWqU7hRUbjLQhgxAC5nhFp1zbL7AySVqV9
         uDWz5NYyKqnqlR/mhjoJqjBSqEt7KTOKdAIApCYfbLTLtkndzyK6dJlsjRvWR9jqBe+C
         gjSNwfSwoIxJF9ovFML0XbUjwCP4/y9FUoPxy7XDCnywvH4E2nCVo5CfV2LQIbOvQTr2
         xf7IHHqMv/uPSFbw1PTR9Ya9aLc2NGsqCt+Dp6ZuqfEwYEPGuMe7ze3wvfxxHWWZoGqj
         khoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kQnMGUpuUF8DUEv+N4lnxsQu4HZHm9a8tVrnn27y94I=;
        b=Jur8dmGXAb0RtiaRKows5Twih5jAnxHiBZkp5PzS1acbps8V1fJ37+sVMPBAtlAPt1
         mi/TqqomDPejAE8BCO3yC4rsdTzgtJxzYbX7om5A0VhdEfqoGGhIWm6v8xqTMHUHDp3v
         blVSew9ZfJs6RLYfKp41ejDVDhK2QsjU+bJfTgAtyi+DZjpYUoF08+ERIpcx+BF0sPW8
         aZXEtPamTXPrZo3R9miI813VgvpiFZYC3i8lI5ox8p6UWyXIC2Jtwtks4mZPjxYmF4FG
         +aKOAau7rLIcbqHusBd3Gi0ypidtg3JrPnj6ynIqSD9xc93TDPAeuPeNpQ6BY65fls67
         4+HQ==
X-Gm-Message-State: APjAAAUsIFt5YDyR3WgZHke9UIjXJJfNxEuvxW/Es1Cz2/+llBzRy4iO
        jWqfoobTgZ8DHhl9+lKHDZocXDNG
X-Google-Smtp-Source: APXvYqwX7pWy1OoYB6KtrzG0fTvXLrrzh4Aa/F59R2sS8Amt5jNNDimd4jZR0s/EqSdthRMhTbkBDw==
X-Received: by 2002:a17:90a:17ab:: with SMTP id q40mr9973324pja.106.1564847944361;
        Sat, 03 Aug 2019 08:59:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 85sm83960004pfv.130.2019.08.03.08.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 08:59:03 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/25] 4.14.136-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190802092058.428079740@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e9462e38-b01e-635c-5ddd-6e22b0dded8b@roeck-us.net>
Date:   Sat, 3 Aug 2019 08:59:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802092058.428079740@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/19 2:39 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.136 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 04 Aug 2019 09:19:34 AM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 346 pass: 346 fail: 0

Guenter
