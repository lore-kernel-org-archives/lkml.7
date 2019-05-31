Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA24BC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C309B26A46
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ick3A2YQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfEaOQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 10:16:59 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53106 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfEaOQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:16:57 -0400
Received: by mail-it1-f196.google.com with SMTP id t184so15941985itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 07:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YXFGxKHnIt74cwR50mQuZdQqAZNrljv5y9/ydG0VpUM=;
        b=Ick3A2YQjusIIX2ylpMC6LTqkhj7doGXFDMptbRguvlBDPEBquMti9bPZMMiVtL9WO
         eDTgSqvl2vP+YbReBjGguL+vBbXylKNCQZb0TISqX65NZwlMRbUzCtYf19ETXmbZ7NVt
         82OAMU26Rd0ol+RuJSc8T50CKOXwEkey92ohPLrLCsoBzqZ6PdBCz7V0RZSb/VIvK/NB
         jj4RWQ2Znf0oVqvJHaiSt/IWolynIOnFjw6P62nHPQnJV098BAKxgSQaKK5hUdaS700E
         5pxV8ZKB6ppKzoGy2oO1QiTwyiENcf/FOUscCcZ25t//jrR/lsrWJ/iXAA4Di+hqOcGL
         ohAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YXFGxKHnIt74cwR50mQuZdQqAZNrljv5y9/ydG0VpUM=;
        b=fKWIinyFCf02diPlkPsDm1chVPHujBIkpgoL1LL4dHHUo5urcjNQXkt4xqlFIP7OpC
         tbeubxxk3GGhT08J6/kTGXIPteAGzvib1JWR1oQeeOMrEi4xQC9PA+0y+HT0tLmgLn49
         4HHPGPgJM1c0xgxTo/vrhWEbxjWS0kEc9mZdqqLjpEHM8B57zNYIctH9NYJ1VY4DIAuy
         Yd4hdjsOimRuz/rMoF8asxxRNVPc8VLry7uXunN5+MiIDRokdZoLcAB2YQvxmmPKnUtH
         6d6meMKqv52IE4vqv2GUiywfwSDf/nmNPo3/9BR9NZYefDUgoI8v9tvW9Ru4uTi4xYkC
         R4wg==
X-Gm-Message-State: APjAAAV2URZ4Qt7m8lgIuxbHwKuRPm74imUMRPvkAm8P8ECtSHzyeFNW
        oWcNlOgnynsIfsjkZ1qh0tGCww==
X-Google-Smtp-Source: APXvYqy4tYc+0TdDvWpiSglvXNSo29C9YlkQ1lVbn7HkiKD8226/TFOvunlgELn5F3jYJdHPTbBWFg==
X-Received: by 2002:a05:6638:3d6:: with SMTP id r22mr6739735jaq.71.1559312216989;
        Fri, 31 May 2019 07:16:56 -0700 (PDT)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id q142sm2478054itb.17.2019.05.31.07.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 07:16:56 -0700 (PDT)
Date:   Fri, 31 May 2019 09:16:55 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.1 000/405] 5.1.6-stable review
Message-ID: <20190531141655.wgqtz6n6jdxb5m5y@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20190530030540.291644921@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 07:59:58PM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.1.6 release.
> There are 405 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 01 Jun 2019 03:01:59 AM UTC.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.1.6-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-5.1.y
git commit: 6df8e06907e10b03bfeb68d794def0a11133a8a3
git describe: v5.1.5-406-g6df8e06907e1
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.1-oe/build/v5.1.5-406-g6df8e06907e1

No regressions (compared to build v5.1.5)

No fixes (compared to build v5.1.5)

Ran 23969 total tests in the following environments and test suites.

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
* ltp-timers-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* network-basic-tests
* ltp-fs-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

-- 
Linaro LKFT
https://lkft.linaro.org
