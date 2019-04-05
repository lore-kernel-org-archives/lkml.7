Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446F4C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4ED21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIZoq/tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfDEDQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:16:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45536 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbfDEDQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:16:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id y6so3892616ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 20:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R7iCZnPcrxhQugxMFUz3OkN4+WLc3XpfqP5yq6ICQnA=;
        b=xIZoq/tpHSXLm+dcgjth+tlTmKJC41ifJi1GS4xh477ePCyQbBHizD4WGA6glXiF8V
         179xU308dukUhBhgmW8kUxmtSBXbyqFW5KMBXK7tFrmUlLvm/i7AgiIfCWWts4FyLpoj
         /urvLYEGY2jdIuRKliCPvA1CCtw+NOgTapqtu+JKA1A8W6n9/mQNNgzs4wpjcpySAiHn
         PQXTwztgqdfkbWc9E5GduJ/Ka3mz0VYe1ykbV4Mqw/Lz12dpCWq6+3KQuaLS721u2DMK
         38H6vL8Lmz/2ttfG2KTMb5jstatRFOrHUNuJyiGRS4Ae9vxFep5IatkDcNW7XPY08iL2
         C2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R7iCZnPcrxhQugxMFUz3OkN4+WLc3XpfqP5yq6ICQnA=;
        b=KPgBbZZpuGn0VEibVDQIM6Q9EU6dmPhC30zkFcE7sIeYK6bzOcgoF36Dr4SstarA1O
         VXmWhqaya4SJmqVZXtEvJtM91LOp5wgRNRPonEWtSCk7G5FLHurZJlUoQQtH6F3QSYS5
         69MHwVhsQ5DSXQ8skVUlYj7MGFQigGGo7jtCHnELThpGCNWCiQCZLzgHAaHeQ2mdY/23
         JOyzBsSGZv9ISUpQdcF+dmOT6fhgvpigxlcRZ2IYDUTZZiFVCDhOXCes4s8DgC0dQyGy
         Asq5N2W83RYaHvjjQf+8uBE7eTkfPrmLp8SMBksvu6HSoDYEqfHycvNoZzzT1h9iMmCK
         GPFg==
X-Gm-Message-State: APjAAAW7cJ/Wy46j4Z+8Vyp1xs1PiVRN8td5Jny/NRwiOtDlJrbRz6ma
        D+o21Xbk1AHJlKmar/3IAWFZRsYLF5tQxa5AURg1kg==
X-Google-Smtp-Source: APXvYqxSJJ58PsTUS2XmJEl7rpRXr7GVTBlpeUFKEdpCmaQ4xp84UF0EHUSlgBaSAfktmB1VbxR3Pghgf+dErL/RFyo=
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr5225556ljg.64.1554434189533;
 Thu, 04 Apr 2019 20:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190404084545.245659903@linuxfoundation.org>
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 5 Apr 2019 08:46:18 +0530
Message-ID: <CA+G9fYs3s1xcB=yDNVwVFfmdeCYPfa6MzRczbXsL7Gy-dbDWXw@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/121] 4.14.111-stable review
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

On Thu, 4 Apr 2019 at 14:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.111 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Apr  6 08:44:23 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.111-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.111-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 4c8aee9c89b14fe8bba63a014b2ec11588683406
git describe: v4.14.110-121-g4c8aee9c89b1
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.110-121-g4c8aee9c89b1

No regressions (compared to build v4.14.109-230-g662f0922cca4)

No fixes (compared to build v4.14.109-230-g662f0922cca4)

Ran 23331 total tests in the following environments and test suites.

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
