Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0365AC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 03:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6A72089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 03:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmlE5Rjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfFUD4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 23:56:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46882 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUD4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 23:56:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so4630033ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 20:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1+h46hKCsZxpDufPHC/omFa1OGQP6d5jo4yVhoLKsd4=;
        b=VmlE5RjxjJamdm46PXHiXB8jquaEZYTaPNtWtxsxJiZcaRiwT8RCW8SwvgDwyYT9Yp
         zY3/E0+mzVH7Nb05DHA6VzPfhSVqOkjGkhu/9rpFEuMh6AeDuWKGoDqJ46+pwhAS7Gss
         1pEF7FhPbFUrK5qXb5zetErSrLYy2h8sKAMSJtfrZz925xGrvRFEvJjDFhwtRR+wIZFv
         y+qHihvnrV8bp0rCv7WzbLJG2uvrEnH1CDQCyQYJYYjngnTIFG4wgjsuh8eUBzhJ1OrM
         YNd8BWJKA7b2EQx9iCvc7Y8Muja8K38cLiskUAH9p/vep5RJHd+hx28Nq5BNQxAUavDJ
         RHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1+h46hKCsZxpDufPHC/omFa1OGQP6d5jo4yVhoLKsd4=;
        b=SqmImjSAGVq/pQX32gJInc793SHd7TZnjGRcF6Rl5Ye9pUX0GMgQfIZyTz4T/5AjtB
         kYpnFPbsyFEHPZ4Z0Iqg85mpm1RSRPHd/YVmCDs2cJSfG5FObrd5J67r4P8BWv2nkJbD
         IEThMtt5t68fXP5Z0jZ9j8dEf0pGjvKzL4wNs7s+RYmKBvqRJiO6x0NYDk3jb9oCy4ZH
         VgXM0XEP8rTZLRcp94pl1VmkjVnSViL12TuyrczW/U3ixU/57ioBdYZHUvPcr1sVs+LW
         +U5xD1dUn3YxLSb57OfNgD6/0tTMjeVT8BlY4jDOeplN33Pk8CK37/kNf/N9YyyoXVm2
         QWyQ==
X-Gm-Message-State: APjAAAXl6p2yidPBFm9PgDVfeCw5i7VpDnb6Hocv0z7oIIK/SvtAUJlf
        Tk6AirVKMvxSO01M89RBLQoz5iMCApBAY5bMt3LUJw==
X-Google-Smtp-Source: APXvYqzXjT5L0vwSb82khXYF6enu1F2zVrKq39ZujyITytvgpjkL2FGQsn8aBfNAfl7r8b8grq+Sk3WzhaeAo3ZvtYY=
X-Received: by 2002:a2e:8559:: with SMTP id u25mr24566473ljj.224.1561089366167;
 Thu, 20 Jun 2019 20:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190620174349.443386789@linuxfoundation.org>
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 21 Jun 2019 09:25:54 +0530
Message-ID: <CA+G9fYv8M2OPuktEt4N7VPpwOCnLa9F90u6ORAfqshnjZTcc6w@mail.gmail.com>
Subject: Re: [PATCH 5.1 00/98] 5.1.13-stable review
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

On Thu, 20 Jun 2019 at 23:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.1.13 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 22 Jun 2019 05:42:15 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.1.13-rc1.gz
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

kernel: 5.1.13-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.1.y
git commit: 10bbe23e94c5975292d0a3ff74893d1625c1e07c
git describe: v5.1.12-99-g10bbe23e94c5
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.1-oe/bui=
ld/v5.1.12-99-g10bbe23e94c5

No regressions (compared to build v5.1.12)

No fixes (compared to build v5.1.12)

Ran 24447 total tests in the following environments and test suites.

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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-fs-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
