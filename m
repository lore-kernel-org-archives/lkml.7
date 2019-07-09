Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F380C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A702073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f+huVF6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfGIEQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 00:16:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46625 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGIEQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:16:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so18105133ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 21:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=01/N1A7OKejZO4iVGz3ACnbrz0rautscSukM3UR9o6k=;
        b=f+huVF6Rdi/Q3Wi+XLxWbLHwwwTbJvpfzzP1rw1zouPZDUKUT3Pg5ddY4TeDnatyGd
         6EXq7BLXXXdgmJsA+d6zDQ7f5k3jnJ0eXwhhGxiuHSeSulrpOiRXE2BMoT7+uOQ1f28u
         Yz7e9hwJe+vBLDNQF5xAhE6yhjl9DQGd1skSAhd2w4EEyWeW34jg7KBPsWgLbIGf3ksD
         RzDQelgvpIJZg8yvnYqCuq5F/parfZtyqHeA7lv7CtFXKt0ivrSnsX4zfIRCAAg3nDFS
         pH8FvrrlIoHGBw/GpLzFByqYnor1eVlB7MT9Fm8VjfhU94H5H0L19cQDisDBYiOrHpjr
         Kurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=01/N1A7OKejZO4iVGz3ACnbrz0rautscSukM3UR9o6k=;
        b=TI0OazoimbDeZb/xYQbCHRt9WfGB6O7/aLc+QOY3NJfych0uErulQb44xUXsucZr64
         /DkKuJAhZ56zuuET13lizEdv53ErgCsa8jZgIr23zqLGLT6mrH/eV103C0zU4w6j8d2g
         +RJFydOn9G6xt+Z0b8cfO3HG1Dxg/4t3n1J0oSm8GxzrzgKK/BMUAEDUXGUqqVPFvQMK
         IhiYvJYzydemLHo6rLqGXIbKcxeDkNbH8Tiwcbg7mC1llLwitxU5Jhk+khBpFS5Tbagr
         9wGEAodhiUmQuj3nUn5Kxp4t2ZYBnbcTsrdZnNUsH5l2NIopCzLsEj+YZJhLdv2v8BN2
         3Atg==
X-Gm-Message-State: APjAAAWzBRxsazufBtzV75bzZaKBEFQxaTNxEGVlYXxD18r6iu6uMUAH
        v9714Z34ZDuHMDL7JN5Dr9U7GaH2Xs2AC2VdHJ3Ogg==
X-Google-Smtp-Source: APXvYqxQggoQC3JVKDxDmP/78fNp0reNB8aJzXQoiiKy33l1npEUt9p3zEDGNulvAEYBu0+jYPYXObWW7iHYKk/XZPU=
X-Received: by 2002:a2e:85d7:: with SMTP id h23mr12699643ljj.53.1562645780378;
 Mon, 08 Jul 2019 21:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190708150514.376317156@linuxfoundation.org>
In-Reply-To: <20190708150514.376317156@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 9 Jul 2019 09:46:09 +0530
Message-ID: <CA+G9fYs5hWk_BqTy-jQdiTXXHoDpOdThF_RsqCjeyGEFCE4b0w@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/56] 4.14.133-stable review
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

On Mon, 8 Jul 2019 at 20:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.133 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 10 Jul 2019 03:03:52 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.133-rc1.gz
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

kernel: 4.14.133-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 5c87156a66f25c493e12b023972fc2ccae813204
git describe: v4.14.132-57-g5c87156a66f2
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.132-57-g5c87156a66f2


No regressions (compared to build v4.14.132)


No fixes (compared to build v4.14.132)

Ran 23716 total tests in the following environments and test suites.

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
* v4l2-compliance
* ltp-cve-tests
* ltp-fs-tests
* network-basic-tests
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
