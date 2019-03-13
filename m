Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77F4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 03:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859882173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 03:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9TMHiOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfCMD7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 23:59:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40699 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfCMD7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 23:59:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id u68so360719lff.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 20:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S6iM50LGyHqoTD1Bs2JKkfzQK7k9WYUvPNvGrYetkF4=;
        b=U9TMHiORRRvIxh212poh/GoKwgAHL0Wyn9sRTf+odJx1rIn4YYbwWjcC3euUgQ7XFh
         Mq6x8g2t9DYTVaBYiQNT+KqOMfVuP50I4QYzYyK+CVoXUmVSgJrSYB96Zc+Ug8xUz5xL
         vVbO4tu32yyZCza3kOcVry0XfO5Dop/GDyqYI1FAnl8AU/4Xl82+imK+L5AFdW9V5eac
         7UwWGPn/VYK2onhGbCYduk4KCDtgoiev3OU2iF3qP7ZmdKl/uAT6cFiKy4NjQXRenALt
         gTnlGQxN2XPQTX7rc+4cviCjrt2ifGnOCSo+RF6/eqTcql0ht4dy1E61/0EmVxMmxjpC
         oEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S6iM50LGyHqoTD1Bs2JKkfzQK7k9WYUvPNvGrYetkF4=;
        b=iOpKx6G4viEZCnp+4xkRkkotIfM6i1nsbQ1ItXduwL6bWfRDywq73BCGFD3nSSzzfq
         lHTiCcJwSLTh2NXbDCVCo/l5pwI5CR3E+dmLSbid505///rgpSr6zDl6gYUjLPkArpjl
         TsIRBrGa+vN9Uzen7WvGoKFipd9EXiYSHYo5Anjaoe2403wr0HjXdVM3I23IJOf1dNiT
         6TFR37MvxlcVJJ4h19zP1sf2Y9VIEEdR9Znd2FrGQWEHcUed5t9l7SaxBa2872P82hvd
         acv9I5jGaju0WCJr9llz/yG6b2CbSqu0UpLtdfw+0j5Pkv1dTROTBGnMJ6/vkrHneqqX
         2cHQ==
X-Gm-Message-State: APjAAAWXgrjZH+Ni/NHgOoIQ5Jwqly771s2HR67wY8hwOI/ZNG8W/i1e
        Lbmc8ZwhuQkmaNcAx3ozLbfRLzfmfrkEY2XM7PUrag==
X-Google-Smtp-Source: APXvYqyAj+zg0USrhweNZ/5+MimQHhIFQwRSwF2NcKJYOKHOjp2/F9VcY68o9rsLk6Mzj4umpkDpJMCMRDScvgKRjCw=
X-Received: by 2002:ac2:4292:: with SMTP id m18mr21730188lfh.60.1552449581327;
 Tue, 12 Mar 2019 20:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190312170349.421581206@linuxfoundation.org>
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 13 Mar 2019 09:29:30 +0530
Message-ID: <CA+G9fYsho21rPrDQFNsAknG5LGncG-0P6UWB+Aj_gccObXaB6g@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/149] 4.19.29-stable review
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

On Tue, 12 Mar 2019 at 22:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.29 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Mar 14 17:02:30 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.29-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
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

kernel: 4.19.29-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 6d884178544e4eca1bd21c4626e16346f7e5aa9e
git describe: v4.19.28-150-g6d884178544e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.28-150-g6d884178544e

No regressions (compared to build v4.19.28)

No fixes (compared to build v4.19.28)

Ran 23131 total tests in the following environments and test suites.

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
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
