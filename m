Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0155C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64D3205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BFg96rAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfGIEna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 00:43:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44425 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfGIEna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:43:30 -0400
Received: by mail-lj1-f193.google.com with SMTP id k18so18145764ljc.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 21:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3yICwhxosFrogk8JNVO3Jqk1hLwdCCqstmVXBk7Lr2o=;
        b=BFg96rAstkqVoZNhu3L6EIPnbSp/uHbmADzU8YmYsMXgrrQ4P4coJw5aX6zCP/74o3
         g2dXL2M6/eqyQx4wSqFZO4nAbrvEX1ez68wab5rozsGAJhWPNJipxDIaS5yiRSs+wlT2
         GIm0xalLkUVdYfj7DvsrqLyvz6ifX6MJX38wZeDzIo77qSzyWzS80qbGC8+dIFmi5JHy
         bJqInH4xOPbxpsV6WtneC8MSj8V0cKMCFH83bKMCUFds90F+wAGQeiAnbgDqpieA5WY+
         CmAJ3r5kprC3DtCqv2uwSyUheOGDSrca1fLro6OUXtK+88agkFtLgrAVwGMO+jmTwAJ+
         QLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3yICwhxosFrogk8JNVO3Jqk1hLwdCCqstmVXBk7Lr2o=;
        b=R2+KMLBDYtYb+tW3cMb8o62RXZ5E4WBziouJxz0BDwOYca06GRI1+u6fX6H51uzO4J
         pAv0CGcKkpiVxLEQAvrm1RIsfIfKypL8cZmrOG8hCVdeC2eFUGp9xViOaQdhdOjiiLQd
         VzBRWJWMStlkNOlPi38NzOlTgQ0V0h7jby2MlXEszyi8mhv/nnQm6jciNf41ZSU8Mqf+
         8LwjFyGaiYH9tnw3t9NmrdCBYQjrVTX+0JohPpY4ERSda3qjv+Lf/H8O1EMc+yeIY55h
         aQXGfx84Pcrz9LO4NzhM1wo5xx22zs6Un0s6ewGU90CyXFMy9vn7Zcgu4cWvsl6/v7sQ
         SnFw==
X-Gm-Message-State: APjAAAWiwDGq3Aooqx0zymNXGhODVoEQkXrU41RigxfihLBs6N9BZ9m+
        b9+fZMtgASeVHZ5BMnffXLelP8bKEpuNChL30n4UiA==
X-Google-Smtp-Source: APXvYqzI60rUCzoRQoaLHbbNvS6BHusb/FQ0G3MKagSKyJzePAcNl7wJfWDAJRi30YYYxP076YGBQWvubyFpxgZDnws=
X-Received: by 2002:a2e:6e0c:: with SMTP id j12mr12417486ljc.123.1562647408450;
 Mon, 08 Jul 2019 21:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190708150526.234572443@linuxfoundation.org>
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 9 Jul 2019 10:13:17 +0530
Message-ID: <CA+G9fYuUEib3uaKkTSf4Sfqv9DEUyXjx+nKcdPN70w15JU6AFQ@mail.gmail.com>
Subject: Re: [PATCH 5.1 00/96] 5.1.17-stable review
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

On Mon, 8 Jul 2019 at 21:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.1.17 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 10 Jul 2019 03:03:52 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.1.17-rc1.gz
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

kernel: 5.1.17-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.1.y
git commit: b64119f8dffe14ab62bbe65e01e72c102be085a9
git describe: v5.1.16-97-gb64119f8dffe
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.1-oe/bui=
ld/v5.1.16-97-gb64119f8dffe


No regressions (compared to build v5.1.16)

No fixes (compared to build v5.1.16)

Ran 18086 total tests in the following environments and test suites.

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
