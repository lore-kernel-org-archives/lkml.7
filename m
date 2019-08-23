Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CFFC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C934F233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VAdVakV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbfHWIE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:04:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38335 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732319AbfHWIE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:04:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id x3so8027233lji.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 01:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VoF/algJSKMgKHWqGBpmdLixJOD0TiZXy6qPpZzkEGc=;
        b=VAdVakV+QVBl0S8hOWH4tSDl0EKbMKm24MZqZDksqfLD+Z8fcxIdCzyTvmb1EHBFDK
         2oJE6bWkxUzGbO0bGok5sT6lWbgyt/LTjDVhamqnmQLH/3VYwQnSVu3N31ieb+We97MG
         ioZ2XM5owl/yd+4W13HnRjJfewUwwpiWDjPMqpX/1ZU7BI2ijMa3167bFricdJRUfmsp
         SUnXyfkrPigxGTHFQ6JtlACR6gmZ5VV3beidJtt7Lz7gRSVCcdZ2RuA1yL8bWkLAupwP
         xQdb1y9JaJmg3n0SAGWaiBC5QGB61oFDxaqAiroYW3ukF0GaHqu5lINc/1t1m7gEDUPG
         XZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VoF/algJSKMgKHWqGBpmdLixJOD0TiZXy6qPpZzkEGc=;
        b=hdu5CRZuxG9qgCtLmUIT3MHD6ZOx4cz0i5TwN68sCa1H4EwJD79uJrXkF6Q1DY8ON/
         a5nGJxBvnDboxzBbivoFUvQLGN2A+orSYsuHuEKWNO/gyWIri0oNIx6yO/iizGLsoMoD
         9WEVhTt1XnbBJFHdgzgwIcbowuW15PjcGazHeEDGTZYFPwMw00+Oo9kWRIYjym2YLcEO
         CMb5jX+lF91qwht5Z/1n8WZzOyDU01S45sKdMHpiVkZs/bQQrRg7aLsnAZMzTYeB+Xbh
         9k0ORh0vwuR2BU6LyjiNRIrMn89I2202Oz8sVqg962/pA4BWH/nh7A/u5WHMiwvMpyh0
         dK9A==
X-Gm-Message-State: APjAAAWnIWUpoBTDfPiepCSEXsG1GSDjXP/LOavgeIBihpm6ISe9AS+Z
        ZsUt06TxC5d0HQB74rl+jatrEoByea1ZKNB9a2ESiA==
X-Google-Smtp-Source: APXvYqxjqqsEJEwHw8o+bjvJ6VZROY48MGDnQVrLOGHJbr2VsrDNaIsvFdI90H4SXgj5zRFGvryDMI/aXKtREeSEXYU=
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr2145187ljj.24.1566547465947;
 Fri, 23 Aug 2019 01:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190822171726.131957995@linuxfoundation.org>
In-Reply-To: <20190822171726.131957995@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 23 Aug 2019 13:34:14 +0530
Message-ID: <CA+G9fYvufBFEuYH8+qeukguhkK_fz20cVpHz+EX8=oddqdtonA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/71] 4.14.140-stable review
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

On Thu, 22 Aug 2019 at 22:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.140 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 24 Aug 2019 05:15:46 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.140-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
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

kernel: 4.14.140-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: c62e7b28b99c68e465814b56bc02089022f90fc1
git describe: v4.14.139-72-gc62e7b28b99c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.139-72-gc62e7b28b99c


No regressions (compared to build v4.14.139)


No fixes (compared to build v4.14.139)

Ran 22435 total tests in the following environments and test suites.

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
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-ipc-tests
* perf
* ltp-open-posix-tests
* network-basic-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
