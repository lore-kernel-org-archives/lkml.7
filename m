Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E661EC4CECD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7B120882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbD1WO7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbfITGsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:48:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46291 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732505AbfITGsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:48:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id e17so5928940ljf.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 23:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=173BRYZ9x6alpIPcRk5BJ9zuLWX/VdslH4Vu4ViMU1Y=;
        b=lbD1WO7yB7R0dOyl7OmpRWseR1LK7WwUOgSugKroU0fSXGSeZ1Dlk+VAzDSRFbQVwD
         SlblZ8+sDwPbsEmvVhpD/mPFN4SYlJcFbDpH8IUpKLWcCKWL7jHVSbCFuiMlWdrO7KRU
         xdDi4MZTA/kevzKBc7/hdNiR903uJlSS3kWLhDpFI3kALsHwFlFnlEEnCBKrswZA5pGb
         AJbPp12YrXk2nCYfRDOeA2BwZ7moqQi4LWb0RGLx/WDCzgbF7gUcM+amuBLaoCv+Cg3s
         oZReIH4ghk6uP4WtG5+DTOmAzBfQ80GUrSipGL3XPQKGl/Ww0nCHHAHNfN13/37lCqS0
         Frqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=173BRYZ9x6alpIPcRk5BJ9zuLWX/VdslH4Vu4ViMU1Y=;
        b=Bxgc6uTnKAhY0tRhZRtxHgherCRd9zVKxcIOQ/p0dYyDHZO17L5oqEfzOknS2TWG8y
         La2Oo4ePjQ1cvyKPsDQhlNTK38pVhBjvPyJ5Raxs68rpJs9Lz55EfMNLMrMTJ+HSzqYy
         gsPXZCm/v16ByNsuOyANIUQZhYwQk6H0RWN6r1BCYfLgKTNVwsaHjD8J/eLi/w96un6N
         FBsm+51emBZVrA/xARItaEkaegumMzAEpAnROXrBB6u0nZh47nLIO8o9dzFa2raJ0BBq
         rEibOHZlXH+O531qjmu+iqJghQj5dBa6rWXP/n5FmRJ8TyRQSJCQPcJgohgnTpIJv4X8
         Khcw==
X-Gm-Message-State: APjAAAWAdPF0P18oW34GXhuaxug/h75HCpAXawTWBjd3rBkY4ghY307Y
        hMz4KuMnUXRJ44F2bgJpgz7NYrn6RYTV7va+GuVLKw==
X-Google-Smtp-Source: APXvYqy/EI/T6YZeS+T/wiUshJbbv0BS+oknh5gi9c07Kohq2IOkrIK8RpvPqb0wVdusqLrUrRHO6ouMOf3JGWpsZ1c=
X-Received: by 2002:a2e:a178:: with SMTP id u24mr7912665ljl.149.1568962127988;
 Thu, 19 Sep 2019 23:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190919214800.519074117@linuxfoundation.org>
In-Reply-To: <20190919214800.519074117@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 20 Sep 2019 12:18:36 +0530
Message-ID: <CA+G9fYuxXBBPU6HfQBa+zhQRzTS+DzUcXvw4zt6-Fz_fBS0wiQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/74] 4.9.194-stable review
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

On Fri, 20 Sep 2019 at 03:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.194 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 21 Sep 2019 09:44:25 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.194-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.194-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: febb363e252bd50629d7efc675ba30286a33f209
git describe: v4.9.193-75-gfebb363e252b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.193-75-gfebb363e252b


No regressions (compared to build v4.9.193)


No fixes (compared to build v4.9.193)

Ran 21866 total tests in the following environments and test suites.

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
* spectre-meltdown-checker-test
* v4l2-compliance
* network-basic-tests
* perf
* kvm-unit-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
