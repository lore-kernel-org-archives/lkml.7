Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE4DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB1A20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qsk9V8FY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfCDOsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:48:52 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41491 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfCDOsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:48:50 -0500
Received: by mail-lf1-f66.google.com with SMTP id y7so3698170lfg.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 06:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lITw2NDQrufdRMTOS8J7A504dTiBoPfsu1+tLW4+pyA=;
        b=Qsk9V8FY73u9aOeheKDLYRxKXzC36Dtva08I3RHEBZ04W/3qvm2w6E7aiJeWVlOKl3
         Th9NTC0P3xrKnQzW086LxJLFerrxqUy/fpIuvxQ4hn6aE3XsTbI3gNq8YPofjJU8HuvZ
         YA6o8Um4HgzbewiLRxw+oOnk/S2GYGE475ZFpAtgRLgc37tBnV4H6zfqsVzHCnW1bsfs
         9IqU2mcFbSxYcTz2td0qug5aEoEaM0HMnFn98stkS3080w+w+zFsqC0MqRZg6RjnIR4x
         38BOdhaSqaGrJTXrduvUGI/VkfD3LNvUlngZjJIKG/ML+Csw8YPcUu+Cg/xgiyNu9Hw/
         y91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lITw2NDQrufdRMTOS8J7A504dTiBoPfsu1+tLW4+pyA=;
        b=i+IflROUxptFx3FKwZEvaoRKCtwJ47+LoTtDJZYSsLv2piE+pT0463t8HqcapWMZvI
         FOA50qnBXqEU/UxSk1xuNiQ9t90ZQy9sFc3aHpJxc5EZP229cylOlKjy+rTjlg/Bwb2x
         pSEotU0iDs85eZuAKSv1ZZxshb26hCOJDymKNi44DMnQaWeqnO8/K0nomEEcD7Cn/KI+
         dkJIKDD8DG/1/CBlibO85MyCy3t3jo5OLzGYXj0p/k+/BUZXb2FdHIEGukZrUFoqx1va
         qc+K7fD2zTWHrE3R1gQoW8OEJhwYKZMA+HFSDCPNl+tkHSC2P3qRs2E+KqNSpfT07NJc
         /6xQ==
X-Gm-Message-State: APjAAAVFNOzE/5XcCH5U7Xi582CsHzRerlBq541KN7sFW4m842SwT9qD
        HXacVgsTiY/bhtSFiNxnU3qVegUHmZDLXkzigNlp4w==
X-Google-Smtp-Source: APXvYqxRxjJEjLujgi2tC79H3wlJS0JdOQE872y+8mDrRztWT1RbGWLQh/tC4v3Cphy3JJfTm9PXZbc3RQCr11KvdR0=
X-Received: by 2002:ac2:532c:: with SMTP id f12mr11320883lfh.0.1551710928122;
 Mon, 04 Mar 2019 06:48:48 -0800 (PST)
MIME-Version: 1.0
References: <20190304081602.307094059@linuxfoundation.org>
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 4 Mar 2019 20:18:36 +0530
Message-ID: <CA+G9fYsaB0BVnE9YUsS=xc7PJ9TuMnaTPPD4ZO+zSHRPo3+bxQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/32] 4.9.162-stable review
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

On Mon, 4 Mar 2019 at 13:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.162 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar  6 08:15:49 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.162-rc1.gz
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

kernel: 4.9.162-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 95ebbd164ce260ac8147ec92861b752e1416026c
git describe: v4.9.161-33-g95ebbd164ce2
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.161-33-g95ebbd164ce2

No regressions (compared to build v4.9.161)

No fixes (compared to build v4.9.161)

Ran 20841 total tests in the following environments and test suites.

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
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-mm-tests
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
