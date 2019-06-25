Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C52C4646B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF3D206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAR85fHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfFYApv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 20:45:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39853 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfFYApv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 20:45:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id p24so11333694lfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 17:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4VRBV23X7CMhqByGit4IxjjQ4d/eDPyD6TIKsw0ukNQ=;
        b=hAR85fHT6Xqx79RDeSD0fXvrAwDQ0Wixbj/BblJouw3E8nlkTeiYi/3L9uWVLavTe7
         1JFnJDmyfY4J+P9oelU85/PNoDntEVb+4hw/1awwL508wcFz0Xi25YBToBWexcGJ471q
         u0cwJcUpaKvbvCgGpVijUyQv4tDWlMmaQ59Zx1DgnNvptNPNTU2CLVO5Q14iRcCnQWGk
         GuBEYdeKoJIi0otaEvZ5yX4OVnqmugOXEuhBu7mdEUVc/oWWpYU0yR3h8aYFnsTgARlu
         TGVxkHGdshwr7htvbJCI4a5wkz4H6JBNCLeCDYDCK3tFWEnSc56EwwnlaKp58ubS50Sg
         T1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4VRBV23X7CMhqByGit4IxjjQ4d/eDPyD6TIKsw0ukNQ=;
        b=WueRI8XKC1vkj78Gdb9ztieVc7MzE6ZHr/xYCvlC4X0DYiLLzW7IPlDu2yq1T3nj1j
         z2GCTopddCPRmia6K1AZRooWOwmmPuZS/iynOOlM3gSium8k5gc3EWzQLZUMehmaF2CR
         bv+6R6AVMXxoJ+vo7crVx9MIVuCZZfZMbEUlKX++PxErH5w8UlCWRHcAiuTq9uS/xooC
         WZOTTY7Kqrr5PMtjskb4UfoAWtse3CAJAVk9b04Zm6qksmzfrY2dSjuU5Mwo/ChVtM0w
         iuaU5wz5rw2qDfJouppxu6nRYaAXP0IN6m6NajBEJ5RYdyO3pcc6TPnQfUkfo7mPKyso
         v0dw==
X-Gm-Message-State: APjAAAXZ43GKFGCLqsEvASMNZLqIRLzRytej74RpnLEBCMrOeH43pbdB
        McZ80Sdt055iC8AvW7yaAKTyMIjvKdPJbai21G8PZA==
X-Google-Smtp-Source: APXvYqyIaDpffn7grow+EzToiDWbaCtIu+C4nwTkN9runRiYSKuD9MwDzFdUFCBxaaCyTZaomiIsJdsjwT6G193S+kA=
X-Received: by 2002:ac2:4ace:: with SMTP id m14mr19701768lfp.99.1561423548820;
 Mon, 24 Jun 2019 17:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190624092320.652599624@linuxfoundation.org>
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 25 Jun 2019 06:15:37 +0530
Message-ID: <CA+G9fYsxR5FtxPWNF5zs8uGWpAZCNRLAq+7azZCg_k0Mm_=fxA@mail.gmail.com>
Subject: Re: [PATCH 5.1 000/121] 5.1.15-stable review
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

On Mon, 24 Jun 2019 at 15:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.1.15 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 26 Jun 2019 09:22:03 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.1.15-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.1.15-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.1.y
git commit: 815c105311e8cdba0f84293235f6f043152808cd
git describe: v5.1.14-122-g815c105311e8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.1-oe/bui=
ld/v5.1.14-122-g815c105311e8


No regressions (compared to build v5.1.14)

No fixes (compared to build v5.1.14)

Ran 24427 total tests in the following environments and test suites.

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
* ltp-fs-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
