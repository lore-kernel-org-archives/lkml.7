Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23BEC4360D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 01:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB4220863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 01:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZDhIp3D3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbfIIBeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 21:34:04 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41088 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731948AbfIIBeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 21:34:04 -0400
Received: by mail-lf1-f65.google.com with SMTP id j4so9127476lfh.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 18:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/FtBE5vj6y6aRaahSnO4O7TNJUGWPE04BVWV9bB+9rg=;
        b=ZDhIp3D36gkx0L8LBeNBNBWt+d/82dBlSSrFH4f4MdaP81ZZ97dTxFhuvAchCGZnpu
         1qkIPVMsGHSXHSaupPiIV7UK47XNF8gZCAxgh0zLcbRS/K/2hAirRNTwo6n7IUMT7j6n
         Gov6o1Nva109tVLIbZAEjedaOgR8tzqkZ02s9EE8miT8gcmXNpZ/c9sUO1o774VMDolJ
         iXrxKiQwu8CwxuCsu5H6kfKzBT+9zRZ/MV//L+ageIpdD7EOD9+CS6ieBWdZ0OkvPiJj
         yZACUwNDgmDG7VY9+J1iqPFxnF+u4V71cE62bGBS4vIbH1MOGxT/AFvoxssMgTPeKMtA
         k3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/FtBE5vj6y6aRaahSnO4O7TNJUGWPE04BVWV9bB+9rg=;
        b=NOLh0TdlNHCGkrD4zSsN0zL8uWWqRNaZfreRhmqEOXJS9X31KzxA1kqqTn5LoabHrb
         b4kXI0p/aLPEho5bBP+HmrDao9E+gzmZKTBxeSt9elQSSdZbFc6mmbskr+cgn6IWE51+
         AwvMTDibH9/4Xcokfj3/MDF1n+hjLSoPN5YWI1T++jl7lpxoxW6d8x8RrUuSO8cPPEEr
         uq+JWvfnoysDYRyWTQZXALuT8JEkMErKFI9bjX9eW/vw14p3psqiYePTMEfqEeKT7ran
         8IKufGwcu6tCa4Yr0iIpHVDeE+pq0V7xeULkWordtda+i7mBrciOcb2h6eKJMC8yE2zz
         ZTwg==
X-Gm-Message-State: APjAAAXTV+LZqSQN0Kf3/pL+v28QDLNGF0z5f4PdVYxLaCCXr2Xv+l2Y
        QgHUKnXtPNg622sDOiPzPvCdoYRnc6FzSI1fPQ4rWGDT088=
X-Google-Smtp-Source: APXvYqzqm+/O8rhwjPyTPNiNG541bfU6r/Zzag3Lk5NRSryPGdXalQU8CCPYMy4epWtRFmqetBA6GXrB4V0W77XkLKw=
X-Received: by 2002:a19:8017:: with SMTP id b23mr14084158lfd.132.1567992842060;
 Sun, 08 Sep 2019 18:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190908121057.216802689@linuxfoundation.org>
In-Reply-To: <20190908121057.216802689@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 9 Sep 2019 07:03:50 +0530
Message-ID: <CA+G9fYvdFQfKXtP1GguaP-k7YYqxEMrjO+7Gg-d13pzLnDspZA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/26] 4.9.192-stable review
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

On Sun, 8 Sep 2019 at 18:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.192 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue 10 Sep 2019 12:09:36 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.192-rc1.gz
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

Summary
------------------------------------------------------------------------

kernel: 4.9.192-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: e2a45fc6bf15db630000dee73d525ccec5cf6617
git describe: v4.9.191-27-ge2a45fc6bf15
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.191-27-ge2a45fc6bf15


No regressions (compared to build v4.9.191)


No fixes (compared to build v4.9.191)

Ran 21791 total tests in the following environments and test suites.

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
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
