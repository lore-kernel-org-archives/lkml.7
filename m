Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7CFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5661020823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWmodNJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfCDUgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:36:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38551 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCDUgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:36:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id 199so5528143ljj.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 12:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qcApNx25zooK6/7GIvs0RDUIWqQoDgG/mllP8eAXbyM=;
        b=yWmodNJJc7M1azO4GJcg75+oifYD6CxnA+K5vmRk6s6jQIXJeHw9wHNU2cU0fuEPKB
         sgDEewDDZCHbjWJHWC14/b3Kk2f+FrvYzpsVuwi1dLCD04BVKZ6hCMyBXZdrz4nO22kM
         11pX68u5ejjFWDXHlp2N2bOPl1vcswV0+3ovCVKhtxoeCp24MfqqJ5A9x+1Hs04C4hvb
         rZLc4qKJmTkyXt0oZ/Vy2+lZvu08vevHv98MsENFut05qEfskh+laHfTTXypNKlCUHfq
         yVsYB2BFs6TM3ZQnkvV/QJArOX3V0fd1FFvcFF3wezlph3VL0s/WUGpu6WTjaKIv1ePJ
         j5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qcApNx25zooK6/7GIvs0RDUIWqQoDgG/mllP8eAXbyM=;
        b=N4+YD/mLz4l2691Syu+cLTaqCbK4z5oSrxAciByCYpgKk6miaYiuD4r/JFdeU85VS2
         vXlf971V8hZZ3jK/Ex3ivqdjci598artFZ+EeHch2n8+zZ407hSuarTDWIo8ycj3CCni
         g/DFdql20cxBGIW3z0gTdbDjPsXpfRvu+ycvZp9MaV5T4fPG/Tvzbwd6uckiNQQ6J0YL
         QcX4rew0OV2S1CJ07hZs3P/xB5Vbvpm9jIP7wsV+e+YwoNxxbRl04G18cvV/PVg5No1K
         s7Nb4Qori+42hdo3bL/ItybfU6Yf9sRCH2B2tL+LHYpr+PKYXjq4dB1RvfjHqW2vfES8
         dpTQ==
X-Gm-Message-State: APjAAAVArn9FJxPJXk9Apybz3P8OXqglRKqrYZss0TGrx7gy0dOd3FWe
        D7XpVPiEe0PY2NPxdMkySxd9K1l7O7pdVQ6qVJ5i6Q==
X-Google-Smtp-Source: APXvYqzW0dWUX8O79Q4ii2dbWXJziB6lDUm+n2GuqmKKuugaEYP7W/44SW9VMQkkJtQYTRokAu2vZwjbkkiZcseGomk=
X-Received: by 2002:a2e:9793:: with SMTP id y19mr11284693lji.194.1551731782368;
 Mon, 04 Mar 2019 12:36:22 -0800 (PST)
MIME-Version: 1.0
References: <20190304081630.610632175@linuxfoundation.org>
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Mar 2019 02:06:11 +0530
Message-ID: <CA+G9fYueBwOic8sV6tVZzejQw0vFUeJJdyPHefCfDg2AmykCxA@mail.gmail.com>
Subject: Re: [PATCH 4.20 00/88] 4.20.14-stable review
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

On Mon, 4 Mar 2019 at 14:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.20.14 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar  6 08:16:03 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.20.14-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.20.y
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

kernel: 4.20.14-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.20.y
git commit: e260750333d34f9c27f65cdf1b0129a6f0fe2952
git describe: v4.20.13-89-ge260750333d3
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.20-oe/bu=
ild/v4.20.13-89-ge260750333d3

No regressions (compared to build v4.20.13)

No fixes (compared to build v4.20.13)


Ran 21814 total tests in the following environments and test suites.

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
* spectre-meltdown-checker-test
* ltp-dio-tests
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
