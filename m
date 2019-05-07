Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF705C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE084204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/qFACIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfEGJuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:50:03 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46906 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEGJuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:50:03 -0400
Received: by mail-lf1-f68.google.com with SMTP id k18so11322768lfj.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 02:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zNp1YRbEftpcKw7owid8pQ+LWmXYBCyJ8w39jtFzBAA=;
        b=F/qFACIovh3CmwXbjD+3dOHfVjXBeZbPAoIXTG2azrXfNtT/bcEXpzNFVL+rmk5JLH
         h0G1jedbQoQ5rkDEEkjbQw1v5BehJ1m7AhnQyS5lRMaoSdszaRv4kSBptu0xFEX4F+WX
         ZmVXq39zMGZpBtm8DBQRMDYa49xCk4hzx5DlJMtZGzgjFurOSh3u79hQ/FlMDziRY38L
         7duLzNBiyGXZKKLi+p1lh2XZVPKmur4S0oE90B37WFeUDqnqYzqhZmor3oaAXcxa7/Wf
         kPJWRBu3boVh7PlHQdGc8djRuoXh+aBfrcC2utQbfGh7j1bs7to+K1tUynjmgjE7uYyP
         6rFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zNp1YRbEftpcKw7owid8pQ+LWmXYBCyJ8w39jtFzBAA=;
        b=VEuWo/U9sXeqHYL9++fImMd135ACfs6rZ8dN2XIOxDaZI50B3nUUD1kfbymCRABdIX
         Cp1WMAut6OvXCZg8AlOT6qR76wyoNdrJtI6aiuZ+xABblAUilrbAbkSfMvTwCGdh5SE1
         7juAiGo83wybDEOuzd15rWwnb/6HEaB1mmA9YEFbHxWj4bIaMlMLxIKW6pR5TertzYyo
         YjNVCWHDM3r/Wp9olYpOGn9saTQEP/Ifgsch0MUrjH0FJJfMqQkRnZUr87w2Cb5Y9MWY
         jSIXYXrwj1wd5rqj9pouevOb7Ps/8eh1rpFJfEomC8f6T55yP3qNnwRbGsvxBhkaAS8U
         gcdQ==
X-Gm-Message-State: APjAAAXsLBvWB64cEO8n/NoAWHtxC27X+rHcSWQf/2fAl1f4Tge00lE6
        fn8bb5p0axbhmDOI7gKaYUjw5s+NreSVagwFHbws4g==
X-Google-Smtp-Source: APXvYqwNaK3JJjwoFLCb4Is81ZPtl2ydAoHQvVJGVpBpMJ/jw6Tvx6Yg61XRCN0Q9QxYxb6MVvlq4DXiYVzgeG0Fmm0=
X-Received: by 2002:ac2:55b0:: with SMTP id y16mr1245772lfg.142.1557222601585;
 Tue, 07 May 2019 02:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190506143053.899356316@linuxfoundation.org>
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 May 2019 15:19:50 +0530
Message-ID: <CA+G9fYt6Chi3=u=EEg6kNv1_VdbWEe4Nzu7rJuKPLnzVAk7JJQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/99] 4.19.41-stable review
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

On Mon, 6 May 2019 at 20:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.41 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 08 May 2019 02:29:12 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.41-rc1.gz
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

kernel: 4.19.41-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: f897c76a347c330cca7fc03afaa64164eda545f7
git describe: v4.19.40-100-gf897c76a347c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.40-100-gf897c76a347c

No regressions (compared to build v4.19.40)

No fixes (compared to build v4.19.40)

Ran 24695 total tests in the following environments and test suites.

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
* ltp-timers-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
