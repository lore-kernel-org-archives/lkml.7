Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFEEC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 10:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5062207FF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 10:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e7dFTkkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfKIKqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 05:46:16 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33556 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfKIKqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 05:46:15 -0500
Received: by mail-lf1-f67.google.com with SMTP id d6so6006790lfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 02:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4UwkKgL7QHQVRwe8tvh/dFC6LdCmbrhTK7UqRShgUPQ=;
        b=e7dFTkkrBmCNdqF34d3iiK+gKWmRcXrK3NLTHt7WA2A/4stvOk92DcsKTWQnlM8ghZ
         DKAtSzTeD+oCRPuxYaPHwJPQyF0nzCGnW+dw7AZs/CSHeicTMVJ6RJWW7Gi7/knY0Drs
         OobmXQ+7LaC4uhim+ekj29puE4niKdhy1uAXKdDGJajG7P07xsQJ7r6No2uOgRJ/YMA+
         K49zXF5nzzMX66VD6yOwAXY21qg8tNayAj0G8ng2xOjX0JSK2XhfpJNE7ObF6wY3UIGm
         fB7OxBk5/26kJcV52AFy1nkUpVMZAhGHx/JlDE+18pr6TTBZJDeID8JD5Mdg5MfpRosW
         ZQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4UwkKgL7QHQVRwe8tvh/dFC6LdCmbrhTK7UqRShgUPQ=;
        b=T6vgcMuYxhCu4Z88VmgSni4C5amNQEDCJOWje+DpC2uK7GT2NB9oAcRvecJRq2qUD4
         uEmkQplV+f7iTRGKHNDVqOpSfJ4emZ+dbuWWLgh7WDyJuN5EXbB6/oI3/hVwe7SlnYJv
         Tsn9uQSgEh5oP8MO4mRKUu8hSoNi+SUg8KvUn14GIaUlaMMfaHWQXnVy0EnGFhORTmfF
         0kUndy3U93EmhAADsX/rH7Hen4dd3zeBMFOF1DLnS2g/79UQHpec0p8oHuDxZQ7j92bF
         xFHJKO44eePMGgX7608jzl1KYCQYqGGmEtZ0SfKmHrHJeIUSFz1+z8vOzJisq6aBm4FN
         fuEg==
X-Gm-Message-State: APjAAAXdCbY94wA+WtL8pH02c+LfD+cN/aM/nKUSNop0rFYrWMdIt9W0
        c/S/hsejHITjTu2Ri1TVsfY5uiYuejZSvxLufEhzHCcMnYA=
X-Google-Smtp-Source: APXvYqy8nrExtm1/Qbhy0rr4pbYil/M9IUBSELB1eZbXd1ciGmc44Al5QRBBsGEqbKTjAv6T7iYZXZWqfE4PLtwXtAM=
X-Received: by 2002:a19:9116:: with SMTP id t22mr9058262lfd.99.1573296371865;
 Sat, 09 Nov 2019 02:46:11 -0800 (PST)
MIME-Version: 1.0
References: <20191108174745.495640141@linuxfoundation.org>
In-Reply-To: <20191108174745.495640141@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 9 Nov 2019 16:16:00 +0530
Message-ID: <CA+G9fYsKOjK68DUwCyJUctmqq1GENvN_ugN6Dn+G5Np3WSXydQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/79] 4.19.83-stable review
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

On Sat, 9 Nov 2019 at 00:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.83 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun 10 Nov 2019 05:42:11 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.83-rc1.gz
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

kernel: 4.19.83-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: b56f5a59d51ac99b2c9af3df39a0a7a573053bcc
git describe: v4.19.82-80-gb56f5a59d51a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.82-80-gb56f5a59d51a

No regressions (compared to build v4.19.82-80-g54bd90285427)

No fixes (compared to build v4.19.82-80-g54bd90285427)

Ran 23927 total tests in the following environments and test suites.

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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
