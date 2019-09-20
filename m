Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97204C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6652086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DL25HkGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437873AbfITIsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 04:48:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36546 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437862AbfITIsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:48:10 -0400
Received: by mail-lf1-f65.google.com with SMTP id x80so4471090lff.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 01:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y/7i9K1tZS5+xr3+87PO17jvbv8mp/z4CCj1C0Jer/E=;
        b=DL25HkGw30/QdUJSaONkYA3IiIPMRsK8VIXze33GRtzdx5ic9pgUWjS7S+Iy1u+vNg
         0dsAvHBNzkLnLZ1mfzepD3JbjD1Maf18ESWm/0oNiA5WbtabT5EaUSzTnG9n6qPRD5ii
         icpuLqjvcNUThrcHrGQmQaGgFYIEFcAY9e321E1aKeYePjqTEdEk5JlKCJoUawNJVgtg
         ctLM6dVctZuZao8FHPSSQHmlJiUe8Vz1Npqu4HIO/cRU1T9mnUF28hgTrKLEIZe9mZw1
         9e5L6s43EkLcYagg4D9DuoodSefCFra158M3efUpKlJ5YgcB26QQHmFWMHLCpoO03gsf
         FfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y/7i9K1tZS5+xr3+87PO17jvbv8mp/z4CCj1C0Jer/E=;
        b=q69yEroCLPmGEoNcsQ1r2m8lZtL3ZZPwQIAMBe2dSOA0aFSHaOUdQ3aYDFBSzxseI1
         IufbXJS5eAQLxxssybBKSGcINGkPkeHUdb11y7k7ZebdBDr2vun/GU/1MimAKvbFmSGy
         ejH/5BJNuZ4JwkTv1rj044wdsRgrDCt+8zTQtlg+33TpqCWuR2m9BzaBTCGz8iFY387l
         4RUgNd/LDTh7urdveKHVfhdn/6gUzKL0bylOfAsjqDCfKbnUHatnKgDzGOWzVjrUiQp2
         KO/f+46gRDQhA9ssGpRHjuyR/Uq+uHyuKPM7W+OXF2PwJ4bih+CSBXQagpe2cqU6aT+C
         e8NA==
X-Gm-Message-State: APjAAAV0IX9RlbkDu9G3kkn3THh9crd52ccsE7MDiyX8FkKqXv/1W46z
        OI9nEXp6PQgFYEKwAlz7mJWnKRsDqS1rLFy2V8oe3g==
X-Google-Smtp-Source: APXvYqwe+a1FVpGMIWST9JzUjmF86QIdKlSPk4QG0AYKcfw7Sf9H8TPMOzMivwscYxYRgFf/3qquHXeg8NBXCZ+VsmQ=
X-Received: by 2002:ac2:48af:: with SMTP id u15mr8303701lfg.75.1568969286980;
 Fri, 20 Sep 2019 01:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190919214755.852282682@linuxfoundation.org>
In-Reply-To: <20190919214755.852282682@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 20 Sep 2019 14:17:55 +0530
Message-ID: <CA+G9fYue5nON3nWM25PZGPC9UQfRPHoo5qnY5H1VORPQCFPF=g@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/59] 4.14.146-stable review
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

On Fri, 20 Sep 2019 at 03:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.146 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 21 Sep 2019 09:44:25 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.146-rc1.gz
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

kernel: 4.14.146-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 981030d9563ce66bc738ff8fee0ed8c81922904b
git describe: v4.14.145-60-g981030d9563c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.145-60-g981030d9563c


No regressions (compared to build v4.14.145)


No fixes (compared to build v4.14.145)

Ran 22586 total tests in the following environments and test suites.

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
* ltp-timers-tests
* perf
* spectre-meltdown-checker-test
* ltp-fs-tests
* ltp-syscalls-tests
* network-basic-tests
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
