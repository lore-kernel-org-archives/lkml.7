Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF00C10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 05:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4FD21902
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 05:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijzEElnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfCWFOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 01:14:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38847 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCWFOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 01:14:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id a6so2746275lfl.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3pDKbKx/M7tVYOTOeVAY4kAPGDgmF6svJdLHcm9Av9w=;
        b=ijzEElnxOgLBBIHlJ8Sv3Itc5tatDci2C6dtAGgoEjqZCvsn0NxSrkh4AIf07fDl7h
         MxolDvntFryLvsKL0/rXqcx26YU4kgnJfKnAJrqVF7pc6KZ5HE+8P8wRBitpALqIsZ3m
         544Ied9lV3tJKalclQ+siPGRh0E8QeCefIXoJr+OxToPylWgZWo0+HCUjN/b/sDhzJEE
         0vTBibg2S0UBpu2oIOoIvkJc9Fm15bjZRNRjZqjHQbkxtNFqUGdwf7Sb9MgcPzf9KQw6
         1hyFpKT5TERt4p69ZHkV//WkY0juTPvAZY7Xd1SenzCxzFQGiBH4sA/r+sRpwNjJ+2lg
         mUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3pDKbKx/M7tVYOTOeVAY4kAPGDgmF6svJdLHcm9Av9w=;
        b=YFKtI8dfJsTA2C8LC3T6zsPYYFNz6lnRboVP2tlmFVsHShhdzBY5d+S5eG+UqIqUWn
         04qY8DcWloArELaujzCGOJrLNWb6sZveTRDpwvMuwT9h7Snf1x6vmtYyvenHW2DBFUqK
         /Fc5eyrywGEEqLjAg4Iw9DwyQ3dDJPM9eZ1vQMN/EODbz0TxGdYvC+X1ntDVOpEhxXZM
         6MBlU35Y30s1KFDSzEz71KS8O+1UzH3oUeOSEFUqZzfblxHA4t0itMnqdAa026rLbux1
         4v6MFhHnrAyhm5j5FKQs7x8ZpGXpSreb1+lVjER3ndjiH9TnrI1O2r8Yy47hxnn13wt7
         bqXw==
X-Gm-Message-State: APjAAAUNVfqZQ7qM9nJ9Qcgec5CBpVTka8sFdPbKi3ML15ll5jgPEDZf
        olhSgWyS3QH1eGxpaMw8oasw2YhuyAbEosXHoIK7ZXuA01c=
X-Google-Smtp-Source: APXvYqzUSxF6dUCz1iwOZ2gnN+IGxScq5JnOorerJKyg8JrVkK6DAv5v5l23iywwRpwL4FdeehS6AIrhuuQAZSeUqvI=
X-Received: by 2002:ac2:4292:: with SMTP id m18mr6618548lfh.60.1553318060820;
 Fri, 22 Mar 2019 22:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190322111236.796964179@linuxfoundation.org>
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 23 Mar 2019 10:44:09 +0530
Message-ID: <CA+G9fYsF5fLO28pX8ghvdJQuz-PLmGiZWtGSDp=5_86fgMfW-w@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/230] 4.4.177-stable review
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

On Fri, 22 Mar 2019 at 16:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.177 release.
> There are 230 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Mar 24 11:10:58 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.177-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
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

kernel: 4.4.177-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 6926dee23fa096361e7d170c7fa21a8b51eb7673
git describe: v4.4.176-231-g6926dee23fa0
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.176-231-g6926dee23fa0


No regressions (compared to build v4.4.176)

No fixes (compared to build v4.4.176)


Ran 17857 total tests in the following environments and test suites.

Environments
--------------
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.177-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.177-rc1-hikey-20190322-403
git commit: aedc0057d8f3e9e59eea8f9ee59fa773bec7914b
git describe: 4.4.177-rc1-hikey-20190322-403
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.177-rc1-hikey-20190322-403


No regressions (compared to build 4.4.177-rc1-hikey-20190321-402)


No fixes (compared to build 4.4.177-rc1-hikey-20190321-402)

Ran 3000 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

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
* spectre-meltdown-checker-test

--=20
Linaro LKFT
https://lkft.linaro.org
