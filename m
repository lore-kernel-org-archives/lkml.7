Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36474C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D62206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oCqwhElD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfKOPxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:53:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33164 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfKOPxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:53:20 -0500
Received: by mail-lf1-f66.google.com with SMTP id d6so8399494lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 07:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2OlOWxrT9e9cqRQHfIhdq+hrzgQL9PDKv2E2QsxhWkw=;
        b=oCqwhElDuOFlNAldux08vq/obkK2FkurgT4WAR/I18XFvboljfqIN4Y2UOroQMXO2/
         QBaYKteZrWE9fnNvdVe5LkFbNIz2axssglBXYzDz1qX6Yt1YCe7GlinUeQpeOZ3MRxXR
         HYgVM7vC2h2QaY1+p9BUYsJlANeYwhBK1ez6sEXgxwBj6RgoivJui6QvrJ/DqpFR/R76
         w3YQwU5OmxvybybFusuDktF2zE3oOBWBbt8wr4F9bs3mTMS2WcojO9QUPRPJa5XzGhdS
         tTlKY6rJlExTVK79+zeKuug3u5d2FZLatRmv0mz+jKoGqumj8GxaluGrqZ52H2fdfKGd
         Qqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2OlOWxrT9e9cqRQHfIhdq+hrzgQL9PDKv2E2QsxhWkw=;
        b=ntaYVAgQZivceCc1clQX+HJOesb/rwxcvESsFm8wQ3tCP9lmHPiCUVsaFbBR3gjQY5
         IUpFp9B0vj06gyr40Fd5RD9pIg+Emb9x4shB1ERJNUWcpCDn9aBBGuStfkJttRZ2C5Fv
         rAddk2G9C/L83HTYkYS9BX/fIWyYy+/88SweKLJrtmu0p33Sg6C5CrD8qWxLqtCESDx3
         DaH5h58zAxZhbeeODwK4R8CTmp8I6Y+iExpdlRKVOlMZdLMwb6TPgD2Bkz7RJcf+FYAy
         Hpk3Vea/cq/K7ON3gT66LgfILmjcI+QiWfytziv5excF/HbX4j3TBlnACkqF5Ict1sw4
         qTRg==
X-Gm-Message-State: APjAAAUAu5E2bLFFD6E3GPrS8G4jrqze1xPW/Bq+e0bdd34pgIDTjKHO
        cEz0khGchkFayZYhvmnOaKGgro2XUXx8tTDCJrEHUw==
X-Google-Smtp-Source: APXvYqyzh6WYDGRv8TzZnZV41sLdIoafTflvNw9rdLLIobn13xw5bW1oveli8wIecP6+mzIbaQo13nSrkjsL99I/qI0=
X-Received: by 2002:a19:6503:: with SMTP id z3mr11500998lfb.192.1573833198729;
 Fri, 15 Nov 2019 07:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20191115062006.854443935@linuxfoundation.org>
In-Reply-To: <20191115062006.854443935@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 15 Nov 2019 21:23:07 +0530
Message-ID: <CA+G9fYugWXr+MdXDZ=E9QV4kdt7x0YgqJwO7DbKacx-wXQu0Qg@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/20] 4.4.202-stable review
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

On Fri, 15 Nov 2019 at 11:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.202 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 17 Nov 2019 06:18:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.202-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.202-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: b0074e36d782e84e6a2e08910103642762949d2b
git describe: v4.4.201-21-gb0074e36d782
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.201-21-gb0074e36d782


No regressions (compared to build v4.4.201)

No fixes (compared to build v4.4.201)

Ran 18051 total tests in the following environments and test suites.

Environments
--------------
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* prep-tmp-disk
* spectre-meltdown-checker-test
* kselftest
* kvm-unit-tests
* v4l2-compliance
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* ssuite

Summary
------------------------------------------------------------------------

kernel: 4.4.202-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.202-rc1-hikey-20191115-607
git commit: 493901fc04b1127d80037f3fb43e916a4eec9f10
git describe: 4.4.202-rc1-hikey-20191115-607
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.202-rc1-hikey-20191115-607


No regressions (compared to build 4.4.201-rc2-hikey-20191112-605)

No fixes (compared to build 4.4.201-rc2-hikey-20191112-605)

Ran 1538 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance

--=20
Linaro LKFT
https://lkft.linaro.org
