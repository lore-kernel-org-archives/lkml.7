Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA34C46470
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF9F217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEJmk03c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfEVFEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 01:04:48 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45634 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfEVFEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 01:04:48 -0400
Received: by mail-lf1-f65.google.com with SMTP id n22so607763lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 22:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wQ83vV6Xzy7wYFkYEqzCiPkq4lX2zxIRrExWbBkR//4=;
        b=hEJmk03cX0a0Qi5BPpCuVpLOWj/NGj8cbmDyxMxgFxrUqddQDWTYojzGgFQpijPAZz
         Eai8a3aPOX1H8V49tjYtGGmVisNq+NjWY/aFM+Uh5/8zLRI+rm4Kc1ameaz37+Jg+QCU
         ECt5tkhKGDiVSscse8r6u9heWT9P3RwF0uvp+A56BnQJjfpmKjlyKByFqmcgm3aqbAG9
         m57POEzusllyL20cHUsGgVvSfqIGlu3VWhnE88IRQckQXxs7o/0oSqIMigfCbL5gm6jb
         x02TryiJfFxE43hiZMZhb5tozag1eqWQ7kXSvoRvMv3aec1a1XKVA8mTr8gpz3QpHLbp
         PeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wQ83vV6Xzy7wYFkYEqzCiPkq4lX2zxIRrExWbBkR//4=;
        b=kY1E/poWrpySgeqLkOZa0+odHbhBXJHbCBOKqZ9nCY2AbUoTm7QUSx/M4s931L4ML6
         BTKHb5Dc9sV0912KROp37WjqxaJluK8UReR/JQbLqvOFQw/aimjk5HymcY+3iZvuGAYL
         Dlr6bJjwrFVmBO+2U1vpkULzhznEKtwfEjlXcGMRvOgX8mQT9r/Svh2dJJG0+U7PHJ6P
         +8FBbC5jUHS4UM72dycQn510OMPtD/IgJckao8OWxHOsjBUKDWF3vKtr+gNYvz6xoQ7s
         5Gjqz7Hy/fCXu5wqT6g4tU5JEy+nzJfbyjXf7hRYpvdQDnZt0mZjj+pnvLUqyl3fBtIP
         Rt0A==
X-Gm-Message-State: APjAAAUBqnzvWJx0nqyMLfGm6LVBOCCayiChA3TfhQ+2dnxvHnUiuTFh
        ZIY0uuja1NjKWVqvUb1OHR4wJqx7SsFesZ3dt3Jtfg==
X-Google-Smtp-Source: APXvYqw44ADoIV4ABsrg3W7afaX2YDIuemxMPKVCdCPTEPdveseKVKDQjwZMKF7MDLpdHtuNkmH4cIymAYXrAXdSZ64=
X-Received: by 2002:ac2:490c:: with SMTP id n12mr13591539lfi.4.1558501486489;
 Tue, 21 May 2019 22:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190520115247.060821231@linuxfoundation.org>
In-Reply-To: <20190520115247.060821231@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 22 May 2019 10:34:35 +0530
Message-ID: <CA+G9fYux5rxbm64DUvy6S_xsVoSzAnT0t=nV4tdS4SaUP5aH5w@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/105] 4.19.45-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019 at 17:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.45 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 22 May 2019 11:50:49 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.45-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

4.19.45-rc2 report,

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.45-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 84889965d346f29e8d1614f9c3cb35c389a40eec
git describe: v4.19.44-103-g84889965d346
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.44-103-g84889965d346


No regressions (compared to build v4.19.44)

No fixes (compared to build v4.19.44)


Ran 21466 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
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
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
