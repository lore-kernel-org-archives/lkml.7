Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB5DC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56AF222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ftkqrw00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfDSS0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:26:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45733 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfDSS0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:26:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id t11so4566651lfl.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F+D6L8O3tZw8IKF7dbHJga3aJhVw9CwnL4UC684J/9g=;
        b=Ftkqrw00C5MSkH9UhpGCN15f0IYLLktdv9o8NQc81UmK/3KmOyHBzntpk+TugYBlB2
         MhvDFwHbN1cYnq/VjaiP7qHzlOLIypQmI470uOB/yFH47VhdVyvWgPBq3pmVL2eEZxQi
         /N8DoJMLCNWleqeBh+ExnzgIwlLahv1Hi4l78fEoeJjyt3odc0AAcZe0tat8g9GSTrjy
         0mzOh/rQlwBciM6fC4CfMYc+oDKsF/mxoUVd+G6hqqKMUx3HoaKm7UTzPemRkT75hs8X
         5LqjwsZz6ly0p5+lClIWKqLfwvdgPcjnH7o+GCVX/V3cZixRd8pq4Red7v/D3awCbps9
         TaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F+D6L8O3tZw8IKF7dbHJga3aJhVw9CwnL4UC684J/9g=;
        b=tjd2x285qkNVvIfvBV2kPHa3/Tpd2MrFidEcdszMkC8TSARHE0M3ANuq4A3Lguo1UH
         52FqElUHIZb0i8hVZ01alVe4SSiGxM3dJbBt/Rjf+MZTTDzVlVOH2p7rUhhMD2xEH5PL
         oxp5Qr34iYUINphefuQPiRo1gMtWDDYgvH27Wkf9Y6x1Mv88ISDxj86BQ5KfwLzMMuJn
         4BLMa+EGlGkn6EhnLl1QWGZe/re2mAs/ol6p4hdHN6fC1Yz2wFbo3kFNrISUMQ6JKV/+
         skymNGbGDnuIB12yPPWhbivB6i764VTfeFCcb8eM40WEKuikz8YwbCCjdNds9V35Y7Wy
         mDTw==
X-Gm-Message-State: APjAAAWA35g42S0d6urubLGLuWXha9RtU5gLs/neytG+MTAh3xae+V/E
        9vT5B7Umr5OVMtg3GqDlEUq7gpJD31rcOAx5I5wtCQ9GEyQ=
X-Google-Smtp-Source: APXvYqwl3/UAm2DGdHkzGDk8H7JYWgGss5CmBsVQDX6WjhJfrVH0NxFb6PE3sDRUrJSZ1IWFoQXDKqUu+iFJ5gigCAA=
X-Received: by 2002:ac2:42d6:: with SMTP id n22mr1351433lfl.57.1555657224421;
 Fri, 19 Apr 2019 00:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190418160430.325165109@linuxfoundation.org>
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 19 Apr 2019 12:30:12 +0530
Message-ID: <CA+G9fYs0qEK9oZBXO0=Byp2V9naW7Krvh3e8d4PhbO-Chyjc6g@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/92] 4.14.113-stable review
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

On Thu, 18 Apr 2019 at 23:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.113 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Apr 20 16:03:26 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.113-rc1.gz
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

kernel: 4.14.113-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 28a2bd553d97e102e55fb648812df81b270d1ee6
git describe: v4.14.111-163-g28a2bd553d97
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.111-163-g28a2bd553d97

No regressions (compared to build v4.14.111)

No fixes (compared to build v4.14.111)

Ran 23522 total tests in the following environments and test suites.

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
* boot-lkft-kselftests-linux-4.14.y-444
* boot-lkft-libhugetlbfs-linux-4.14.y-444
* boot-lkft-ltp-cap_bounds-cpuhotplug-fcntl-locktests-filecaps-fs_bind-fs_p=
erms_simple-fsx-nptl-pty-securebits-linux-4.14.y-444
* boot-lkft-ltp-containers-linux-4.14.y-444
* boot-lkft-ltp-cve-linux-4.14.y-444
* boot-lkft-ltp-fs-linux-4.14.y-444
* boot-lkft-ltp-hugetlb-mm-linux-4.14.y-444
* boot-lkft-ltp-io-dio-linux-4.14.y-444
* boot-lkft-ltp-ipc-linux-4.14.y-444
* boot-lkft-ltp-math-commands-linux-4.14.y-444
* boot-lkft-ltp-sched-linux-4.14.y-444
* boot-lkft-ltp-syscalls-linux-4.14.y-444
* boot-lkft-ltp-timers-linux-4.14.y-444
* boot-lkft-perf-linux-4.14.y-444
* boot-lkft-v4l2-compliance-kvm-unit-tests-linux-4.14.y-444
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
* boot
* kvm-unit-tests
* boot-lkft-ltp-open-posix-linux-4.14.y-444
* ltp-open-posix-tests
* boot-lkft-kselftests-vsyscall-mode-native-linux-4.14.y-444
* boot-lkft-kselftests-vsyscall-mode-none-linux-4.14.y-444
* boot-lkft-ssuite-linux-4.14.y-444
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
