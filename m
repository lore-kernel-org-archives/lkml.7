Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A09EC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394402073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fODhMEEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfLDN4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:56:41 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39514 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfLDN4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:56:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id e10so8215424ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 05:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tx4bYfgLbwTH0yB5G8/3pgn3hc5merPWXci4kO/xkhM=;
        b=fODhMEEW8bWzTm9ir/kq2Vx6ttsNuqBm4SVJFTHjNwUiu4z8fbXDhgwst3NwSyCWSI
         a8k+sYEY2d35Q+MJZhFbcWIMQfcPHzaFzvFNMo23n4kP8/eyxl+AcXFtY/y3Z+WnosEJ
         hZT+iODodd9/5zuGorp0lmjZn6JdL7+6Kefy6rvupd9qIYP7KaAldNRQGr72x1P8NoF+
         gXvxs6XisyRzl59e+54ODXICpJdZBTFXogdXZZ+p6agbWO7P7zUSjgocJfVZfPIVd5pz
         Bar/1Xurf31RuCcWZqmC8hkO0jTjhMO+vgEnpV8Kx8u6lPnnZ29wks2xb9MHKMRt2quX
         443w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tx4bYfgLbwTH0yB5G8/3pgn3hc5merPWXci4kO/xkhM=;
        b=Mg4m2bWoEy+lfMii5kwR0HYSqWI2HzGFrD0Q/0lFFvidsT/cdpyzx6NY8WQZehDtOo
         Twa9sTOoUqYsapbXqokzY3Scz88FG6MWLvtF66/EbMVHkKYaDiYHWLJaArKjDV5jRBu2
         AgMytMCN3zj0TTQCY/zv8oKRNwiLygzKN/SEuoI8VwMos+Lc6lJYNtHZOdYV0qT4dZqY
         n1ar318FikNNXmDowH939hDN/blGxWv/+X3Vgqj+OvpV5zljJCYULk59EBCCFMQfCiWY
         RHA4ca5rW2LqrmKmMPeZBKKJMlgy+acGxQup9Zf4dInadhXBSw2xsOfD6sknTvxpVLxr
         v4iA==
X-Gm-Message-State: APjAAAUvAMhpA0GyKop7dWUjzcwNJmnMRlKGdrIR/YabuIZftlIiqKkI
        a175KafT4MimNjMeDd1uH8Bd9DycwcKKFH7/qEP8DA==
X-Google-Smtp-Source: APXvYqzosmmhAnbAO5YHSCv95Mbcbq2eHV4AffPo6ORl0sTgPSJn3zalV+T4lZo6U2FC6FLTAnLhcqLnCR42u11J9FA=
X-Received: by 2002:a2e:5357:: with SMTP id t23mr2140363ljd.227.1575467795092;
 Wed, 04 Dec 2019 05:56:35 -0800 (PST)
MIME-Version: 1.0
References: <20191203212705.175425505@linuxfoundation.org>
In-Reply-To: <20191203212705.175425505@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 4 Dec 2019 19:26:23 +0530
Message-ID: <CA+G9fYt+OD3ggbPcoDA=TAXL0b930yVSqpo4-kpbuYKu0A8iHQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/46] 5.4.2-stable review
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

On Wed, 4 Dec 2019 at 04:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.2 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 05 Dec 2019 21:20:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.4.2-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 3eb35d2ecc30a984db487889b72703a12cb97e88
git describe: v5.4.1-47-g3eb35d2ecc30
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.1-47-g3eb35d2ecc30

No regressions (compared to build v5.4.1)

No fixes (compared to build v5.4.1)

Ran 19155 total tests in the following environments and test suites.

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
* linux-log-parser
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
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
