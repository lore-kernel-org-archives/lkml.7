Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E63EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144A322CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6xQgguI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389386AbfHWIJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:09:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33643 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733287AbfHWIJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:09:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id z17so8073894ljz.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 01:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1oC9ul/byHaTj9kHAFt1syinUgIIsihUipkOTFXN1b4=;
        b=g6xQgguIn8bkm+g/kORDgmq94PQSpmT9mRwB2slFoDsxvCtKMbAqIpSxU69hy9dGLY
         Iwsd533mpLn9km1zbGwGgNEiC54wgReNQW6p0lP8uodnTpHug2jHGqaYeUuWniPpFoNa
         9t+wY2hsx0HULPQpywmAKWyvWJnVkhEDJFxV+WqLfL4yNBXquK23I4Oq9g+9BX/sRq1W
         9qBZ5bpZ0gSZRiiaphmc+kKcor1P21KOcz0NNWHbtUDr5N15oeFVtXYqWVJ4CPKiuuET
         81X6osZDFIAlSIbRiewNJGoK88AUMLzFgtT/J71X3wFVAEfPJQW8W0DuSSvo/bjmCUpL
         VI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1oC9ul/byHaTj9kHAFt1syinUgIIsihUipkOTFXN1b4=;
        b=c8AoJRQiCOIxY4ZMHb2SrPEkL/gHTJ8adMc/WA+eQDneuJ+cglK79T6qhgSnyZfR04
         A+8X0QWm35X5l4e5k6S5BJM7/CXszdds4OJYoLgkpLJAs7Od0frB9jaIIXrhPky3Eulx
         X5GceIA9qAMCAD6oFXffOEPRoUnEMByYvNZJ3+VfwrxNnVx1xl2ykS/KFvnotEPEeBIM
         QEkbbwYa4V+ZXlvtlwKt2uOH7uBCIEmoABDVmD7AmbajRmfi8CkOorkd5sYx9mQEsh27
         UACkAc1Px9IUiuxpMp28ODf7PrxkW70xZZKhqNgPiphi8/xIy2dEOY6Zg5kHSjFlcVPA
         07HQ==
X-Gm-Message-State: APjAAAX8Phts/lldT2o1WFPzP6NLd2GZh0mHHSilZr1DoPyp9EMRckH1
        8mDseyM5DUYk0R+CyqcN/xjiLwIAZXlJkQWDDsJ4tA==
X-Google-Smtp-Source: APXvYqzOceqFYC1iSqtfJx6cr3uKsvLAa0r7BzZjT2fFOV/Yn++jandiwJ+bVFVhqOEY+1t/OjeEWsM4x5TFGO6dguI=
X-Received: by 2002:a2e:a0c3:: with SMTP id f3mr2101512ljm.123.1566547769296;
 Fri, 23 Aug 2019 01:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190822170811.13303-1-sashal@kernel.org>
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 23 Aug 2019 13:39:18 +0530
Message-ID: <CA+G9fYtuPOCnmua59DDVCQ9ueJRz=Q0bgh_QYZ7Ct-OtH0DZ7A@mail.gmail.com>
Subject: Re: [PATCH 5.2 000/135] 5.2.10-stable review
To:     Sasha Levin <sashal@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019 at 22:38, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 5.2.10 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 24 Aug 2019 05:07:10 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
5.2.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.2.y
> and the diffstat can be found below.
>
> --
> Thanks,
> Sasha

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.2.10-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.2.y
git commit: f5284fbdcd34b923c32f702a0d46a00b9e744d71
git describe: v5.2.9-135-gf5284fbdcd34
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.2-oe/bui=
ld/v5.2.9-135-gf5284fbdcd34


No regressions (compared to build v5.2.9)


No fixes (compared to build v5.2.9)

Ran 22639 total tests in the following environments and test suites.

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
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-fs-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
