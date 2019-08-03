Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F37EC31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 05:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AD92087C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 05:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMajgYd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfHCFuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 01:50:20 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33318 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfHCFuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 01:50:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so54499709lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 22:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1SSAQj0JAqVNZ89OxICGVwd/tUG1D7d0oLxRMKn0L5M=;
        b=EMajgYd8HWaKDOKTloVrJV09QHLqIZQkaSMbdzGYcMCo0JziIkgawMw1zUYoNQsopV
         r2jshU+s9n6RGY+Qv/GlkGYHhH5iodN4IqfaUwn+JlcGsm4HXJgowY1Q8G+6vBADcg8l
         IkZm+WhWCCLH46Gx0ojOf5d7Y8QrtAZ9BpKx5xU3TEIl6NfhwFkraaCGZD3kxV8IedMr
         UIA11qr5+bhLiaiiM4FH94nreqFzZBeSfXl8A41v2n/g+Y8ukEatDri0LY5nd8bqXtV3
         Q+TE/il6t3A7OC7LEDiQVpMPbLGqIcAIVTkQDM6RxJAHsPIwgGGf88qVFqHZlgTH3b6Z
         bl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1SSAQj0JAqVNZ89OxICGVwd/tUG1D7d0oLxRMKn0L5M=;
        b=LUUS3N+7bSp7ojn5ESxEzmT3N/nKTjQT7vjJRRcQ5h1p1GPmE5dRnhLZmx2XzIw09t
         MAib8pf9uQpVaG3rvP3ILxYcizlfZvNq1XBliDdd9JqmZGTm03p+wnDqGw139CDDWOKf
         nGMAKoqzhwF1rN9YzO5P02FLWHJt1mNA6hq6VG+ozfUhYhRgMGTz3sYAQL+w+BMVZtWG
         tIypJTeLL46prRyJ0rkF2yD7ETxMlJreLCDajaFAKnsclJ29qL0LkeJRRYyDXUhU4ZQB
         3PFZjMOO9ie+hDysDaHyGYzXkUtfgl1p/L4sFSSCkahgQG/yq+5d7XMlO67ODOpte3Sq
         g1QA==
X-Gm-Message-State: APjAAAU8czu34+UwaLVSpyO+yKQV60tEQt1GvXSCOOcyFgfClg/RguAa
        j9iXSSQFP1Xo6mIFhyWnWjI7dvWqFzrDMNasIsydpQ==
X-Google-Smtp-Source: APXvYqx0FuHTfjqYLyHkUP/iMRJRl3qBSivHGd698pmIMai0T3UHCifQjN6I5UzyrpoGnGVkAnKfSwM3cfPlHDflHmA=
X-Received: by 2002:ac2:5596:: with SMTP id v22mr231497lfg.132.1564811418441;
 Fri, 02 Aug 2019 22:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190802092055.131876977@linuxfoundation.org>
In-Reply-To: <20190802092055.131876977@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 3 Aug 2019 11:20:05 +0530
Message-ID: <CA+G9fYsFFZvU74RN-ucQ_P4WZ_Wi1nHdbyiRN77sw6vV9AV+xg@mail.gmail.com>
Subject: Re: [PATCH 5.2 00/20] 5.2.6-stable review
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

On Fri, 2 Aug 2019 at 15:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.2.6 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun 04 Aug 2019 09:19:34 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.2.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.2.6-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.2.y
git commit: 44397d30b22dd93340c705ef34bb61c16f43503b
git describe: v5.2.4-235-g44397d30b22d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.2-oe/bui=
ld/v5.2.4-235-g44397d30b22d


No regressions (compared to build v5.2.4)


No fixes (compared to build v5.2.4)

Ran 21444 total tests in the following environments and test suites.

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
