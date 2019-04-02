Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4B1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1921920857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMgAjtca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfDBLCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:02:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40473 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfDBLCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:02:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id q66so11151469ljq.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 04:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uWIyKqYUGN66w/VP6In43gZmFcqXvLWlLTGWY51dQes=;
        b=wMgAjtcayNeNUTT5hqQTQE9k5DD7qWjpeOmkTMKugiYX5CXoLA6EqBE38PmlLQs7q6
         nMSklk0dskw+Cs0iwkXoMZaNx6grzNM3LvTtBW/p4Tg2HhjqpcwTiYhvpOtCkM80AyDv
         lwB2+Nw7QkrithGdIvH7bb3EV7EZurBuBV9ii2jWXLsw6QeN/qmcWj5mduturUchC3w3
         UZ38bmKhODp/K4mPAzG1uWnVhlWehx3+mbHJwEXvTPgVmM0IyAF2ICw07oklA+OAxGvn
         6dKkMlEMeKhcN0UMv+RNV13hz9jo3U1ioGg1qC1uPWsuOVfKAw0TOaQBF1f8TbixH2j5
         XDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uWIyKqYUGN66w/VP6In43gZmFcqXvLWlLTGWY51dQes=;
        b=RKRz/0oClXJN2gzIEoq6vlLxjs1Pa3tOKamFSmmRlkEMRpJJhZC1aqIUQ/beYi39Mv
         ab7XI5N2Sseh42R/A7n7NQrcFuI5cQqQE6/cpspk53CqZxv6jCKCZiuOD9M11tT7XN5q
         4bzBePuRQE9+xpJRUk9hTegEXkrP4bS4BsXc6/lcgZY3bZLRhDAwRfnUIZEl8u5BkU0P
         ajtfU13UP/xrggShOKGddgNt6b/8zcC3qtLCW6CXmJJB7d8Iby0sbylpgtkbj3VYOh6d
         g/N46zi1XEIl9UMZcC1Zgen4nsIcmGA5zJ8W+ch+zkg3x+SDjCdfaliU8bjA8Zn6FjIj
         9DFg==
X-Gm-Message-State: APjAAAUzMZ74uKCzOYy+QnMLNIQ7kF9JVsB4nYzElhnmrD+AM/QsBISX
        An1X2WSOBwOdshRjzlTFTF20CQoyHzWRZJXjhwJPaQ==
X-Google-Smtp-Source: APXvYqylHZGiY1j6A+ME59u3JfX7TMmK6z0RCWkU6Lbp8JnDorjrDNQ23Y9zZlIaTisid6vj2qr3S8awE/RVXaWrdD4=
X-Received: by 2002:a2e:978c:: with SMTP id y12mr40897552lji.70.1554202953506;
 Tue, 02 Apr 2019 04:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190401170044.243719205@linuxfoundation.org>
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 2 Apr 2019 16:32:21 +0530
Message-ID: <CA+G9fYtSyRcGFX+HD7+aQD2GgW_Y1JNaRsOce4Hhnv2hxjRfPA@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/134] 4.19.33-stable review
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

On Mon, 1 Apr 2019 at 22:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.33 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Apr  3 16:59:23 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.33-rc1.gz
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

kernel: 4.19.33-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 01a3983fac4e760561475e7fa8908721c63be26b
git describe: v4.19.32-135-g01a3983fac4e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.32-135-g01a3983fac4e


No regressions (compared to build v4.19.32)


No fixes (compared to build v4.19.32)

Ran 20417 total tests in the following environments and test suites.

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
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
