Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEF5C4CEC8
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 04:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11E62067B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 04:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VpuTZYFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbfINE24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 00:28:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45171 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfINE24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 00:28:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id q64so18428690ljb.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 21:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6fqgx63VOqDYCNdvOw0tw59tN2HQTbk3mErF+HxzwU8=;
        b=VpuTZYFJzG6MbOAORz/s1yxi3NnDLYSris0eK+rofPmTPPQTg52hT/M6oE7ZIMOlNO
         H8w5rT0DPq5FftFCrFjvYiWUbDfV4jDqvGY0NMh3ow9zk2q75tYVpioUdf/YNta+Q1d4
         p6ka+Ieop3hDxjqB9RrTuhGO03FpD/7Oy2SqIK/r78Xi6cinUNpZK1lmrPbS0SWl/JJa
         TXkNsn5Jt1dB8q+YYwRJNDINOdlmZUFwqFbQrfrmCW6tGRhPHZg0Wy44kl34mjRtUiJQ
         2CnvD1m8X6FSdh8mqGd79+A/Px8ikpMr0xNRTIu1xW6f2E/rGEwQVKtSwYnY2vzVCywc
         RoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6fqgx63VOqDYCNdvOw0tw59tN2HQTbk3mErF+HxzwU8=;
        b=IF90BPGWmzTTVdyPggy2q8vFwm/4td6U4uhipflw6/U2n6+SNRvWT9YY5hRppHidL1
         ZovrXNN2Ril/W/BRxmyUC9B3kHwuUhUmpDBb9I1bu+IE8OYeCAG7RSH6Lvq4CHSwLTOZ
         goQUAqp0cPs4ErAUVeRTaJ3bQDI4k8f6YzlY39zkf2lVJJ/BVP2yrDg9yZCI5vPjf1kb
         c+bLyY0u/aeYEkyGM1G5EcpRObiEY5o2342OotZlx4AilA9eRBylBCjlfTIz1dr2VTWZ
         sa043Rn5gF51QedRsvKEAY6p95n+/uph67rpWsq3GewQHc1ThWY5izVRNCoZMWO/Ii8K
         D7VA==
X-Gm-Message-State: APjAAAWJ0eJ6sN1rdGfJmQObLFTj9Y0cu8e9HdpJb6AOKdKtMDJ8+UPt
        +kPwvhI3Lhy0szkDrkJUoDKv5eR7FcYglKkQyGaO2A==
X-Google-Smtp-Source: APXvYqxrtkzpc4NinDTqSSBWPcIIn2YwZLFpA9GSCrkT+j3zh43YT4NaLVb72vbrHk+mkhdKQvQOCRNnuCHCw2oZFpQ=
X-Received: by 2002:a2e:a17a:: with SMTP id u26mr31856397ljl.137.1568435333893;
 Fri, 13 Sep 2019 21:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190913130424.160808669@linuxfoundation.org>
In-Reply-To: <20190913130424.160808669@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 14 Sep 2019 00:28:42 -0400
Message-ID: <CA+G9fYsj_eTiMSmj-Dsw16hOG9o7DHDbkwuo8V-AToAj1=2_zA@mail.gmail.com>
Subject: Re: [PATCH 4.4 0/9] 4.4.193-stable review
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

On Fri, 13 Sep 2019 at 09:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.193 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun 15 Sep 2019 01:03:32 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.193-rc1.gz
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

kernel: 4.4.193-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 0a1ee44c69166b2750a62fdb079320a396dff30c
git describe: v4.4.192-10-g0a1ee44c6916
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.192-10-g0a1ee44c6916


No regressions (compared to build v4.4.192)

No fixes (compared to build v4.4.192)

Ran 20018 total tests in the following environments and test suites.

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
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* ltp-pty-tests
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* prep-tmp-disk
* ssuite

Summary
------------------------------------------------------------------------

kernel: 4.4.193-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.193-rc1-hikey-20190913-557
git commit: e289b20abbc0882c0710519376b654c0df71b784
git describe: 4.4.193-rc1-hikey-20190913-557
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.193-rc1-hikey-20190913-557


No regressions (compared to build 4.4.193-rc1-hikey-20190913-556)


No fixes (compared to build 4.4.193-rc1-hikey-20190913-556)

Ran 1536 total tests in the following environments and test suites.

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
