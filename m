Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65B0C10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FD8217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XyM9PeOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfDEGeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 02:34:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38748 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfDEGeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 02:34:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id a6so3549698lfl.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 23:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/A4eS3TP5mVKzSW3Q2OV3ZHPo5yBQt6fIKWbpp9cS/s=;
        b=XyM9PeOwEdvcMc+RXrZiK5dgVyljt9VHiwj+83NYLfRBfnxAHEqN5NIDvsGeyAdjff
         cd6mGkhGhLdv4FX2nDSoP3CFNLtxvTJdSrywgm0hw2AaSEokQuv04A6flV/asMbZ3A6e
         /sFnbXT/IBu1rGoCIg4IMqGtvQa8jdz2C1XhEhw8MKrIOP7+sGp1Vv9mu7WfCblLjnr3
         EzfEYBeZkctG4Nvn0z3WmPOnPiZslw4SpGTYsVgTKeJvogwmLvW5GvHoO5s0OZmYnXjv
         yZuaATULSMnPuhu+yAicl0pzADz5xn1QM6n/5k86dbk8z+YAvIF5F8oocg1maGK+xv4x
         omyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/A4eS3TP5mVKzSW3Q2OV3ZHPo5yBQt6fIKWbpp9cS/s=;
        b=ba/kiyvvxHEs1tCCkrazqq9l+zJZi17tkY/99X0fa3n2Nl+6iZ9PswKsRIkkZ4r1Ap
         0ZT8yP6bOqtwqRM2aTm9R0H23gmnavYjTkSREUlHtvPq2EvRie8wn/WOxFdYbfsQ+D+z
         O5y/9FabohIql2xrszQLtgVfpnNVCT45mbtwO+dm0VqLeTU258hCNh6EAwPxTZv7cFfm
         8KHVp5/pv3nBW0CxC2ROPB2mxYPhurfWXTTQYHzR0qtTeMFo45LIN3LEEhKTnHW2984g
         AR3jWKpH/qwEuAZC4KCppJjBua+f9eKnVgzKxAmBFF4k+/Iu9IHUV8DTPRDxbnrd7Egq
         xn0Q==
X-Gm-Message-State: APjAAAVBJYtPweRYKXEGMQgKlBXMkkXCK66+6nwTEKjyJil9fi6jfgkp
        AFTSfkGGyK9MRwtYWcT8tInst/3xOR1wZGwryiyzauRfmlE=
X-Google-Smtp-Source: APXvYqypFYiKl4YkkTQTIfV2Ydz1mypHNnOLjI/EAwjK53TUmQfJvFG5oaV9w0ljw1j9NqZmrSfFQQ9dG/qZjBeh2Vs=
X-Received: by 2002:ac2:4563:: with SMTP id k3mr5430061lfm.101.1554446057628;
 Thu, 04 Apr 2019 23:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190404084619.236418459@linuxfoundation.org>
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 5 Apr 2019 12:03:28 +0530
Message-ID: <CA+G9fYtJrZxcnV35PYoJecUEAZpXXO1uz3g6+HKccpdshpeKZQ@mail.gmail.com>
Subject: Re: [PATCH 5.0 000/246] 5.0.7-stable review
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

On Thu, 4 Apr 2019 at 14:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.0.7 release.
> There are 246 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Apr  6 08:44:36 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.0.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.0.y
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

kernel: 5.0.7-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.0.y
git commit: c3237e4b7d6eb01257dc3fb88eca7e17e526aab5
git describe: v5.0.6-248-gc3237e4b7d6e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.0-oe/bui=
ld/v5.0.6-248-gc3237e4b7d6e

No regressions (compared to build v5.0.5-394-gcfe061443e1b)

No fixes (compared to build v5.0.5-394-gcfe061443e1b)

Ran 23618 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
