Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA1AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB442073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7xUcL+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfDPL1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:27:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45748 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfDPL1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:27:20 -0400
Received: by mail-lf1-f68.google.com with SMTP id t11so11217328lfl.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 04:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sQbXDEP+T6dLkIrCuP+1EhAc7j0C97jWMAcy46QoDbY=;
        b=X7xUcL+O6GGWvXIKTzy5RcmxNA3NMolz3J3gQPxeL7BGrh3foUEnbLG7IqlVH/UfRX
         ln8rM+gsg/MvdSZKRf9OAwzHOvxag2AewVPmPKZRj5Ztd62A+oOEXGVADirWZRTrjcmk
         0LjmFtnezQXkzNU5LJCEsy3dTgcR7ZjD0ubRtXsXgmphelJWN1BFyltxxKgvoGYnv9nV
         3HwuiE8sANH81wimYgDGbjwUUwBPGwXt+Hg+lPbTuU9V8tEJzCmvo4A8YIhZoVk7FRPR
         0PBPCc4zRaumiDK+FfqqSe/id3HKtnS+BnhWqyNZyov1yYZ6Re3ydy28SDwuVuCFg2yJ
         e7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sQbXDEP+T6dLkIrCuP+1EhAc7j0C97jWMAcy46QoDbY=;
        b=SQv2+c5berPsy/wYvTMj5cjJCOqRXIbt9+iWPguA934TmgMWvrWbRrpClo58sA5OWC
         hUPE+7zWkO40czsNWubENaW9njl9gZmiHFzmy+Edad4k6+1uZyFNLCG7Y0mwpHY6SFYD
         J7FdDr4TvIc2C7VbjGkHD+5ejvcF1VvXSh65Pg/5upF/v5a4/9N0tIdE5b2nf/qg1Oyr
         WeOR8uPGD340Yy2ZWqE36FOKB1o5n0cGX8ruSHqm7ZL/vm5JGrYlK4VAR2yZpUscN/+p
         6+5HqXwmss6S+Hzwx4ovjUkqGXCVX87Pt/Vscc1toYr8PIODXv5d742XvhNB0gRy12Ge
         bY/Q==
X-Gm-Message-State: APjAAAW63mPy48GsrCtibot8zkt+5Y6nLYx9LJYHM2eV0XvPZTKkFGpe
        MW2Sbxi8GuOx3HEDsRaWQ3zBm+M/0kZub+jEnKPsiPQIoZA=
X-Google-Smtp-Source: APXvYqxwk5ntOHcd0pDM+CNmIAAZLkPStsjapNWaqfYZ67cn1gkPU2HeGsrT7NB+c2dwbSd+2nM58A7S+JcOfxxOzXE=
X-Received: by 2002:ac2:4214:: with SMTP id y20mr9617102lfh.75.1555414038540;
 Tue, 16 Apr 2019 04:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190415183744.887851196@linuxfoundation.org>
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 16 Apr 2019 16:57:07 +0530
Message-ID: <CA+G9fYtdGyJss=_4j18DUYDdojcmQ4=_hTx5FFKDxS6V2PSvvA@mail.gmail.com>
Subject: Re: [PATCH 5.0 000/117] 5.0.8-stable review
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

On Tue, 16 Apr 2019 at 00:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.0.8 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Apr 17 18:36:42 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.0.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.0.y
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

kernel: 5.0.8-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.0.y
git commit: e6fdfdbfcc6a9ee160e553eb0eaab811d6de783e
git describe: v5.0.7-118-ge6fdfdbfcc6a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.0-oe/bui=
ld/v5.0.7-118-ge6fdfdbfcc6a

No regressions (compared to build v5.0.7)

No fixes (compared to build v5.0.7)

Ran 23487 total tests in the following environments and test suites.

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
* kvm-unit-tests
* ltp-fs-tests
* perf
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
