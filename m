Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140CAC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCD120882
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Modoamdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfG3JLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:11:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37460 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfG3JLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:11:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id c9so44122146lfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1PJKes8PdP7aRGTeIWA8t5aE58pX5GS0FLyuTTU9hkQ=;
        b=ModoamdrfO33tw0Ex67wddWNU2tEynswGWpuMrO4jpaBIK2a/ygsYk1VT2l0k/6DwW
         mXo4y4bXaoEeJhPGa2Z+KMtmlBb6DZR5TbqngtoYoy2TzCrP1M8n8illdX4UQJMZr024
         z0BWLx8GJKVr1JNdR6jAWnRENr35ys59JLo/Rc2dGY49I573DutoGmFRfbEy9xlYh8FU
         3gXgVN4mF1MYpXIEwDxsN4EIqDBJmyjPci7BiFcp9YFfSvBGXDS9/GV7DLqHqBZuSPvs
         sxzkvn9DDV2tL1NgoNozgBF0mPiQbLaILM4CSZuP8x9cMjze6oLj4N8IWCJiqcMEG1Xg
         a32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1PJKes8PdP7aRGTeIWA8t5aE58pX5GS0FLyuTTU9hkQ=;
        b=ImaBN2f+PSAAY0rvml1s7wcwwCNyukc9Dy1peJOrpbB5G9nlfDJxi1lDV3WBAjVaW3
         EutXOnaiaEMA+JI95Gkqrn95+OVVtP0tZWBuHFLWA9MV/fkI2rHGKpWWUyJT/AxaqvV2
         7dIu7VgePKlm/c3yelRHiU/epj6KWQxTZeh8bPos6yV5/v4KI9QXoPrwTkf2vYEg7gxw
         L3El2eb7zBM1fH8LvJOMSNkH9qvHrRW1GRqxlNtiPkW6/uLsl7xsQYa42cQGOJHqDPwk
         sUfS7AY5BwgY1jzpdWxsPYLjpY48Jxy+lubD7ES4/3QPRqsCQySXkXgypm1G0i9wngi4
         CvSQ==
X-Gm-Message-State: APjAAAUV8VzJXoR+L3NCVicjfsYZE9IpLh4Oz7BuYVI1Ut6N3tXylUsF
        rg0c7McgGoy8UQCsRxxU4YegrITbmJc++PJVZhwtZg==
X-Google-Smtp-Source: APXvYqxFe2IEjXVJCtcMeu7Rc70whEKYoQd5LXD+AYlyxiqJkJBKI4e7SF0/ksgK5Xjw2n8D6UF3EGJpK0dbA8zLOXI=
X-Received: by 2002:ac2:482d:: with SMTP id 13mr42209511lft.132.1564477905477;
 Tue, 30 Jul 2019 02:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190729190655.455345569@linuxfoundation.org>
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 30 Jul 2019 14:41:33 +0530
Message-ID: <CA+G9fYux=+d3SBWeDr3AJMitx-TcVixs53+vOExHSLA5K38M6Q@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/113] 4.19.63-stable review
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

On Tue, 30 Jul 2019 at 01:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.63 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 31 Jul 2019 07:05:01 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.63-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.63-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 0c75526c53c7c911b415119a86ace13c9d3e1724
git describe: v4.19.62-114-g0c75526c53c7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.62-114-g0c75526c53c7

No regressions (compared to build v4.19.62)

No fixes (compared to build v4.19.62)

Ran 23472 total tests in the following environments and test suites.

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
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
