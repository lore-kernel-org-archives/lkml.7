Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63436C433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 05:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396DD2073D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 05:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kn1nTjqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfHCFwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 01:52:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34452 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHCFww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 01:52:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id p17so74774154ljg.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 22:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YSlBGcAw76C1VbyShzFIB1RRXoIsjlJxCaN4hmv3Z0o=;
        b=kn1nTjqW1CDvMNVfyVZ1RFxz7eLrebdgvcaXz0Ie/RRx0XQtObtmO6CtmebRpq2tVp
         ypDfIGfP27oDK067dBJS0RV1EGduDyD/ojA6avUQHzg+X4rgyDsbS/qLlWbz4UNC6PZe
         IZE6GfQA+lsGSeaIekPXiOqeS5m79+ZVy+GQzHnzyXnUeZfZ9IGqPMBphEhqtqV32RqA
         KnChsLyFhYanGJomU8UwqI+Ymr38lsAoplx36D/NIKFYbbbegTCf1E3fwLho+dZqW3Ts
         XuyWViUgL5+LP20FuSmZz9OrpTaCN7vSzVKrGOE/YfPDqgxiAPFwaL10AotfB0DLMT4o
         CcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YSlBGcAw76C1VbyShzFIB1RRXoIsjlJxCaN4hmv3Z0o=;
        b=EocKcUeMXPNrGPHcWWpT295Y6/B+ZjmRswcBcExQNqeJvr2saN20IwJHMknEcLOYIi
         ALTakGVCgorVDVHeiUXD7XLCvF2RsJzIhc6JrMe8xjVCuMmwIVoW1JAwnOTp5nanmJOi
         Vb7mrbS4OCwrTEeFRMybPA4wiuhrK+QqT5RLIa+OgcWyTK2Fvbg4m53+zytEYdWhUDmR
         8YAapKdOLexLe/c9ZwvTHSfz5UCpU6wU+xIVMMtRExYJwRFeg2f9nvZyOQsbddm2lGR/
         k8BesUlwolsFyR8gpqBsbZs1IUNwa6Wlxde9hHqiU/NUuEcVePrmY/rXxhocgEpfG+4u
         dIrQ==
X-Gm-Message-State: APjAAAX9SU+3Ml8qk/CjARMRth100gvaqf9nlrVCpuMe8fVElCrhBVRK
        Ed2I2aB6QTNQg0iF2P4auJMFqkdL8huTNqBDqkIkHA==
X-Google-Smtp-Source: APXvYqzBTHcDTJcNUArxB1an2THOo2mV4dUYt14d6AZgygv729jMZVU955uQ0T+lDSrF9Rzu5h5oZ9Tn0fJ2/Z121qI=
X-Received: by 2002:a2e:b0f0:: with SMTP id h16mr49592222ljl.21.1564811570612;
 Fri, 02 Aug 2019 22:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190802092203.671944552@linuxfoundation.org>
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 3 Aug 2019 11:22:37 +0530
Message-ID: <CA+G9fYttF9BsfGJennzfrPzVk=H+xGDM9vpFE9gb4vYbhMDWhw@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/158] 4.4.187-stable review
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

On Fri, 2 Aug 2019 at 15:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.187 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun 04 Aug 2019 09:19:34 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.187-rc1.gz
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

kernel: 4.4.187-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: d9815060e3ec2433dfffc8a3dcaed9842b1798c7
git describe: v4.4.186-157-gd9815060e3ec
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.186-157-gd9815060e3ec


No regressions (compared to build v4.4.186)


No fixes (compared to build v4.4.186)

Ran 13277 total tests in the following environments and test suites.

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
* kselftest
* kvm-unit-tests
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
* ltp-timers-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* install-android-platform-tools-r2600

Summary
------------------------------------------------------------------------

kernel: 4.4.187-rc2
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.187-rc2-hikey-20190802-517
git commit: 83e555c108c2c8fc5cc0af29c02f47cc2676fb88
git describe: 4.4.187-rc2-hikey-20190802-517
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.187-rc2-hikey-20190802-517


No regressions (compared to build 4.4.187-rc1-hikey-20190802-516)


No fixes (compared to build 4.4.187-rc1-hikey-20190802-516)

Ran 1549 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

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

--=20
Linaro LKFT
https://lkft.linaro.org
