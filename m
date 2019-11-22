Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CBCC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AD1207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flOXSXoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfKVXuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:50:55 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34159 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfKVXuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:50:55 -0500
Received: by mail-ot1-f65.google.com with SMTP id w11so7751943ote.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 15:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CqM0Fr+h96C+cdpb71dRWGuzmExUtNtmv/8Z1ZX6kHc=;
        b=flOXSXoq6QQY/ihi2we1FWMr6yiYbbDyE4XlVxuu9izqj/uUcF4LFrPvqLKu9s6V3x
         u7U3l6KnVzn9DLSEaUlxN6L8QMRwg3Vju5/WgWf7SHABNgiErgdoqDty4/vZ0B18R+3v
         ZfydVhpe583b/QPZtfyDs0MU5aX4umhuOZoVej2MHafDqMBfz1dDVO5MZ95sXtnXZCCn
         J4052ArmCcj22hOhe5Fe/lvv5zTvFC8N3+R5ys0RPHycA8PEmiSRuOO6OQ8AgnqbYH4a
         HfrUZLT1evuYCfQzSD4Zy7YJ/cyvX0o8oYW6T/W1eW1txJU6ldgA5TqVP3b/PnDg0WPC
         Q10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CqM0Fr+h96C+cdpb71dRWGuzmExUtNtmv/8Z1ZX6kHc=;
        b=ss9oGCbDk84Ztwt30n35ZCDOsTAPsclqY0XLhklHJVzTp+P3Rg5KMg4LX0snt9ixia
         A1UDaLGcwCDfettxkkhcGy8cs6B5oFCpWAQudJd+AcLtu3idFLcLuUNRYzAROCt/O/FP
         FjkzBBNaRVLOUYqaj5o0ztm8zyak3FPr5uOWJXY+2c4zon3ecEzgP5KxeA9DXwtKQmxO
         Kn3fmWcjYt4uK1mVzvoS0AzWZ3/Ql57A3HGu3bVdDxyQkAykDFjc17qC+XnfwZ229pI9
         7jXpiXh4LB0r1mM/wyyr+5a8pKHzgNPhkkJqfMOCv65GaiaXydQcCyEJAOnV1Ksn+rbq
         pNgA==
X-Gm-Message-State: APjAAAUw4OMQeHGEb2xgh07t6Fq2DjZLIjCM/JQ1NOEutca70cJS7Ei+
        uY4P/o/X5Z2tyGZ6rsyEAvqarQ==
X-Google-Smtp-Source: APXvYqz7d6uImha8GKonBKekND+QYGBCpFUN6Yi9J8gqnu2ze32cMuBeOxSa0Ed61Kb3dDpiONzCRQ==
X-Received: by 2002:a9d:a2f:: with SMTP id 44mr10750999otg.83.1574466653933;
        Fri, 22 Nov 2019 15:50:53 -0800 (PST)
Received: from [192.168.17.59] (CableLink-189-218-29-211.Hosts.InterCable.net. [189.218.29.211])
        by smtp.gmail.com with ESMTPSA id w9sm2564495oiw.48.2019.11.22.15.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 15:50:53 -0800 (PST)
Subject: Re: [PATCH 5.3 0/6] 5.3.13-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20191122100320.878809004@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Message-ID: <d750d6a0-c0a8-5d0e-370d-511b2de3409b@linaro.org>
Date:   Fri, 22 Nov 2019 17:50:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191122100320.878809004@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11/22/19 4:30 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.3.13 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 24 Nov 2019 09:59:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.3.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.3.13-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-5.3.y
git commit: 6b14caa1dc5788cfb139f0bf14b311fe815f3549
git describe: v5.3.12-7-g6b14caa1dc57
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.3-oe/build/v5.3.12-7-g6b14caa1dc57


No regressions (compared to build v5.3.12)

No fixes (compared to build v5.3.12)

Ran 26387 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15
- x86

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* libgpiod
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-fs-tests
* network-basic-tests
* ltp-open-posix-tests
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
