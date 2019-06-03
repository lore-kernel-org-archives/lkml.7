Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1408C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EE5243DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N/BIVHvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfFCTdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:33:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43045 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfFCTdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:33:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id 16so3792846ljv.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 12:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wUI9gVW/nhS4vRXB9vYqoY7kmuY4RLTiR4+fvOgFm+s=;
        b=N/BIVHvdFRvgSUtBS3ONW+AOMV95IreRw4yLbu2K5LEQCd5lKtjoSCDfIU0X++Z/12
         HEjxGdIfZJ/EhnyURl8FxKStzLIhlOoP2yuRy3mWV2WGxE2jdQNCtt4eP3f6JdhVnZMT
         zWaSwbYzHHbzdlaLaV9SNzsEYOD6YhPzNB/23hm54TkjnFUIYz1ia6uf5dCyMCNnwttr
         cHh6+mcVc3Xl495VVfJ/NLcRBoaqh3gg2N69oyfqS9a05OrX1Thm8DUtXzqlEOuA5Q5z
         KlhqA53Q+CgNVdQA9AQUx5XjZZxsKz8kY7lLwkanzeqvPRiInEvHdjFV9/ve4NBDINln
         yuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wUI9gVW/nhS4vRXB9vYqoY7kmuY4RLTiR4+fvOgFm+s=;
        b=W5rfTWQ6igpXg5q1DI1l2GLGyxjJo4JhA2YdJSChXBZljV1QULBscstj5vt0FxQ4Oi
         zOPVfsN5fz80o6mwHhdnbUJRaRdRahFH9rDB68hl6NWxmq2ocmIL9cy2dWdQ7qrl/+b4
         A8rfaFLULA/HGNGEUu2GEM9d2Wn58R+m6dikA6mQWACig/pIKOhaWnFeeR4JOtteFO8R
         Vk4cf5InI/4Ejk/ASmECDLVO8uSWWg9G5RLoAXTUQhsU5CUdth4G1igN9UqzMO/K8g8y
         8/IoKH7Tbm2LFW6KptHxbouVY99XXuooGzH8pNme827FEaUS4BiHF/kuabgIUzCV2a5q
         bbxg==
X-Gm-Message-State: APjAAAUfuXCsYrYCXypZs99RpxTw/G9HohQecjZgFJSlWaRNhqkbc3ck
        5Zx9h7ooxNd68K/Y7Ionugu8F5sIn5308bTLq1jQuA==
X-Google-Smtp-Source: APXvYqxT7g0rbBTauSgvhQL3bVoe+CkOBjODQONbh8Zv39m/18ueK374i+T0hrk7cZSf2hURjOzZLZ7i2Cdpm2DJafI=
X-Received: by 2002:a2e:90d1:: with SMTP id o17mr14959183ljg.187.1559590413365;
 Mon, 03 Jun 2019 12:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190603090522.617635820@linuxfoundation.org>
In-Reply-To: <20190603090522.617635820@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 4 Jun 2019 01:03:21 +0530
Message-ID: <CA+G9fYtDyv34JNgrT0gw7NbJXWC2p8F3_zHJUjYGiSE4kefK6A@mail.gmail.com>
Subject: Re: [PATCH 5.1 00/40] 5.1.7-stable review
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

On Mon, 3 Jun 2019 at 14:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.1.7 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 05 Jun 2019 09:04:46 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.1.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.1.y
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

kernel: 5.1.7-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.1.y
git commit: e674455b924207b06e6527d961a4b617cf13e7a9
git describe: v5.1.6-41-ge674455b9242
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.1-oe/bui=
ld/v5.1.6-41-ge674455b9242

No regressions (compared to build v5.1.6)

No fixes (compared to build v5.1.6)


Ran 21177 total tests in the following environments and test suites.

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
* kselftest
* network-basic-tests
* ltp-fs-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
