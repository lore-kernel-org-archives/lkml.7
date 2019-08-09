Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1718C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7383320C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y2Ku+2Tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfHIT7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:59:15 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43558 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfHIT7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:59:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id j11so36701730otp.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 12:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9Afj5GOa4d4vaAmPJpsQ1rQnYzbIf3X9eV37rLEbS/I=;
        b=Y2Ku+2Tbwmfh8GOEQ/tpssC27p4yK4gMlCNpE8LRCZ2qnjtgUXBChQgsiQR6rWfRN7
         hbCZt3IB2qymevxTwyJr5W4PvziZ2/gIcs6HeGaZhCyf77643yF7usEy9L/6JXHs/Vqy
         hbsnT7lMcR5iMH9wVvtO/jDQCU3QDVvRpmaBSBP1Uy4WBO6f4hZApxbdYV/XO2s92pa9
         rJ8Cn6RLzoI8DsOgq3kCiEAX3ytdT48DNrhIp0MIGWylbHkNGXFJ/I91d1yU3aj24yNr
         vy5tDiUXpmol2rOVoyjs3O8DAUpaXEUbq3GpiJiER8+thMC+dq1Doe4w66jK48H6KUI9
         xS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9Afj5GOa4d4vaAmPJpsQ1rQnYzbIf3X9eV37rLEbS/I=;
        b=ofVzc4g/cq3eWI4Es0iNVpEGYQEx2jHpHN1gtP3AEfJGd85JxcgXRjaTpMYP2hXmAY
         U8uYpHcm86qL4MXtRTp0vrPzmcjfx1qw/epsAqFf+H8bU2QVJcL+XT2FLqEleFIe0/47
         E8XWIUQsiSnv6K+nkdbDwKrJPx9vJFhrCm/q/iFkdHX7uKlUMcHPIG+Qxwky2KwJSSg7
         AsjnM+jDsw1tZ+7THCgN1DX5BD5URaIVaBjv6X0yDkRxaVE5hllxXKftkLPrDPCYiyKy
         pYGNYlPZ0KXL4QuSFq7Wu5jkBzz4s/yxrL0f4+1AZSSwrTS8ukL6V4au9XhAtpzPur+Y
         /jSg==
X-Gm-Message-State: APjAAAVqpYpViccTFKD+xlERQNd7C7WzU9yQiyNFMJVyUJl2bPObnbCV
        /MnXT0SBL7WLvev2BLQ4hOhNNQ==
X-Google-Smtp-Source: APXvYqxxZecnYrFllyTQW5KWHUGnEZ7RnXqzxuM66rfFjVVs7Ht9g6GS6MeZULNqtPHZ37oyyLqLqg==
X-Received: by 2002:a6b:dd18:: with SMTP id f24mr69453ioc.97.1565380754160;
        Fri, 09 Aug 2019 12:59:14 -0700 (PDT)
Received: from [192.168.17.59] (CableLink-189-218-29-19.Hosts.InterCable.net. [189.218.29.19])
        by smtp.gmail.com with ESMTPSA id t14sm77046899ioi.60.2019.08.09.12.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 12:59:13 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/32] 4.9.189-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190809133922.945349906@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Message-ID: <524742dc-61b4-8738-3823-74a7f770d424@linaro.org>
Date:   Fri, 9 Aug 2019 14:59:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809133922.945349906@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 8/9/19 8:45 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.189 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 11 Aug 2019 01:38:45 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.189-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.189-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: 260869840af4f3d7b3b46c4047642a931535c196
git describe: v4.9.187-76-g260869840af4
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.187-76-g260869840af4


No regressions (compared to build v4.9.188)

No fixes (compared to build v4.9.188)

Ran 23630 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* network-basic-tests
* ltp-open-posix-tests
* prep-tmp-disk
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite


Greetings!

Daniel Díaz
daniel.diaz@linaro.org

-- 
Linaro LKFT
https://lkft.linaro.org
