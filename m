Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64BDC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8303C20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0BIFAlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfDPLVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:21:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45225 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfDPLVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:21:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id y6so18693663ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 04:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PGlT4HNSRFUHnu8eYnaUTNe1AZmLLaNzfZhY2FWb3zU=;
        b=O0BIFAlX4rbQklUSJZsJ7x3QG0mUffBWFIjIPQKpwf/XlD3cAlMhWY7tNrntiIvpCT
         cQuOfSu+PxMTtkZzx5sRKvmdHXMjlKLtWvSLCEjxDkkV4D0qJwuR574NBwnzlkEh/mlo
         /db7fb9fYRs1wqLLFj43eZ52TjpG8e/qG4pJ2zDvbQtb4sEEd0TiudShbFtHHU96ILE3
         Xkqj9qLAB2QD+07va0U6ba7MODgjnjxjSVgtqVHR4DThiIqTM97xtWLGfpLFffVXadl/
         sVMJWyRAIstJXzeHcI9yr7IV3DCOonjarhS7n4pmlvyEkTs2mDuL0sKN6n3FJvtKt43X
         IdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PGlT4HNSRFUHnu8eYnaUTNe1AZmLLaNzfZhY2FWb3zU=;
        b=RJRpbhcu1ex+13KUnX+1L+ZQ5cV5vhf+pDWUHeaPx0vnXi7iYthbnh+p6qTGoVOB2Z
         1aZxVYtX7H4hBbQ//iBTjdOU2vjqaq/ss0LsZXTUZM4J8Ttttow+TPOKbjNSOHXcV11f
         zPThJr6o9urRseFjht58nncXAxAEke7nLCe3S1ugfybLn7eb21hvZKzK7aCAJONzmx0d
         Fzs4amXMRocF/4bq6mmxSB17vORyMj+cBc1tG2ZDnyjrvKVk6LI2+C7rEGomY4BeN3bt
         EIyDeDqcwcCvp3KQWqOf+H/QGywL7vzsriESLq9MLzjaQidOiSadwKFOxXDFJJNVEqsm
         I5XA==
X-Gm-Message-State: APjAAAWkCgCirn8PiDUrRlYzPXyZPZt6hWMho++kFRE0OQ/JVwbs9ZyG
        2DUpYkSPZWfez4L5BEzDgwZQJEJTi8Tsajkot3Ty/w==
X-Google-Smtp-Source: APXvYqxvCzMCxXFXBwnK6D/2OQv4GPkcl1pOVVoSHuEBJENJ6Ch+X/Ae249q0z3cTNO+Hz7ih4GJ+07snq1ZH121548=
X-Received: by 2002:a2e:8149:: with SMTP id t9mr45693697ljg.2.1555413674602;
 Tue, 16 Apr 2019 04:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190415183740.341577907@linuxfoundation.org>
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 16 Apr 2019 16:51:03 +0530
Message-ID: <CA+G9fYtGYo9NLXfpO_f+GM7s1wLS_c4ida9CHgjLU5P_YseZnA@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/101] 4.19.35-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 at 00:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.35 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Apr 17 18:36:40 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.35-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.35-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: e4f859c2cd83c05fc968871175b2a2ed5e43eb49
git describe: v4.19.34-102-ge4f859c2cd83
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.34-102-ge4f859c2cd83

No regressions (compared to build v4.19.34)

No fixes (compared to build v4.19.34)

Ran 23582 total tests in the following environments and test suites.

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
* boot
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
* kvm-unit-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
