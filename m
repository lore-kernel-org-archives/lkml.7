Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1948C468C2
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 06:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A88F2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 06:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbB32089"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387793AbfFJGir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 02:38:47 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33982 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387485AbfFJGiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 02:38:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id y198so5802087lfa.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 23:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iGn/q4Q13MqrWMeqZokMUPss3YZHlZJtlTRMPfjLiIY=;
        b=fbB32089b8xODi1bWnjv3D9hBBDfgRHCl1D0DOTyOSsc5RLsAFg4sUNXLqxyjnOXmG
         4rozgAKJQ/h3fr8uKBBl/5dz5Nz0nQWxje7RWmqcyHHZI5NGiFacYB7AE7ED8yORg1kr
         g7MQG1SIj2NYXX9Sth+ySfdDqFnhtjeCE+cnxmM8tpvwbyKb2ciDq1uzseGbwLGq1mQG
         uzJ1K+NdBrs11whKNDY9hwbmIX6ltVD9gTGlX75H4Etkud0WYJVr0xY4Vz9Lf/8zA7VV
         1XZSQMtLmHxzqBCmLP9/U4ITK5v+O/qxhqXZO9W+MsVBrOopCvlW9CLMgecWuzHMjTwl
         FH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iGn/q4Q13MqrWMeqZokMUPss3YZHlZJtlTRMPfjLiIY=;
        b=VqCjQhqB5Soc7dp4+8z7MTpJY2esMQyQncsuA0dWQwF5Iy1r0Fsu+11+3nCYrHse6o
         EqiJ0OvtM4udePJBeKV1CeRA3o4+5dAxUNU2XaSGKDH21UcXu60a3lFW4GGNwYR4uQl+
         sOFUksM8/as+J2j+R+S+ZCTzK3Ql2yC99sv51kkjRwUWY7n+ptfdg71I1iTTbQxGD55S
         8t+ypnnfM2M55Sq5a1wyx7Z9UDua97LpP+3PJfmlNdx2TiTPstrA/J+z+Ippve1+nXws
         014kfTgGP67gv69nBvwlB5HF1l+RkWBdHRZk1kDfhPUa5jtUESlSuem1uwbRstTX7ewL
         naCQ==
X-Gm-Message-State: APjAAAVl5HiQ81qjtzqTvGa2D6zNfB5CrmMQodqGfMBhTU0Cde81DbWA
        ppbiE4UirGwbkLRJyN2futC79oXSmo3dzewHLdn1RA==
X-Google-Smtp-Source: APXvYqxS3niahYH9+6KRwhteHPEaD44LmaEn8dwnw8ls++OMsyuE6ADCaaqnR33cTk8e9h5OBV/3CqBnFMCoPeZq/Bc=
X-Received: by 2002:a19:ed0c:: with SMTP id y12mr31981224lfy.191.1560148724912;
 Sun, 09 Jun 2019 23:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190609164127.843327870@linuxfoundation.org>
In-Reply-To: <20190609164127.843327870@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 10 Jun 2019 12:08:33 +0530
Message-ID: <CA+G9fYtf1oB_31eJ44S63X8skoNoNmjngKTG7yKtJXKGMtXk6Q@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/83] 4.9.181-stable review
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

On Sun, 9 Jun 2019 at 22:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.181 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue 11 Jun 2019 04:39:58 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.181-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

NOTE:
selftest sources version updated to 5.1
LTP version upgrade to 20190517

Summary
------------------------------------------------------------------------

kernel: 4.9.181-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 4fcf72df7bc71264d86e616874a0a0cd382f1b12
git describe: v4.9.180-84-g4fcf72df7bc7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.180-84-g4fcf72df7bc7

No regressions (compared to build v4.9.180)

No fixes (compared to build v4.9.180)

Ran 23615 total tests in the following environments and test suites.

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
* network-basic-tests
* ltp-open-posix-tests
* prep-tmp-disk
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
