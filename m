Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFC2C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B0421019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbdqYjUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390199AbfGRMmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 08:42:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46632 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRMmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 08:42:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so27228397ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 05:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oD5XEHM7kx3yyMtoXXSzAO3v41fm6Kmy/UcuiMgIOL0=;
        b=WbdqYjUCMs6tBv38XdWS8jEAPjbvmxT8BFqlOXRe2H2ZZy2gGuRmebYpTQkEMqaMDO
         mQ0gn7risnEs43Dy507iB3Klvtun7mwtM23eRiCS6Q1MgAlcKeAa1lAg4V1DsZMq2l01
         az5bhhoj8U8WIeZNqi9fm5yy2H2yjRZdoZkS+jC5K6Phq+5vTsUfMerY2HrSNFQisSyi
         JSNvVtg9zt+dv5L2KNItqZd030t99ywaRaaP2F2zv+ywa8yNiQzQwZReozLxwT6OaWsF
         z4w5CncjjzH6+czpUOlZGeLUNVO5XID9ygUS+12XiZpD/dMLDwWWqTNsKPL5NemMINSS
         L8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oD5XEHM7kx3yyMtoXXSzAO3v41fm6Kmy/UcuiMgIOL0=;
        b=hElcdrb9eP58zADyIIFEQPiAFrw2+yl4LIwPlk0Ii3gXihy91OOTCNeVTQmJmXrIny
         UnjdqjZiNgBgVq4GHcQWxsVXEbQR3qwmUnnIvS4xKy/90qoNRE2e6hGDKr02VNvfJwqM
         B9CrzWTepgVTkSH1EjnDKNFd8ysEBksubK1BrDWqvm57QftRqqyj8MYdj6vhgcvB6FKX
         E4TYh9ka3OHxlIM+JPfF6i1lWLCokqLzrTePTjcT04s9Lc7M9fGSvkZnAgcUrbvGwOtU
         lfQ5aZudC5FyNKcUhW8eLnf6mpCd9Y8CEqmRD3giLumm4vD9odqY/13hy0ddUIUnG8jV
         LXDw==
X-Gm-Message-State: APjAAAW7oCiVvxxLO9ZQIAaXXKrd6IImucS7/Ar/Bqdz26fmtx+aA3pT
        51+NoTsiJNNeamJjO5FktspLzQgvooDR6+RME6i4KQ==
X-Google-Smtp-Source: APXvYqxH66tL/Fn5fkuaZ0LSTxyIPpZlElb9j2DCmp7WgeI1hxLpc8MBFcsmg+yUYiQw69JUPCpJkWthVmng+B4l7Vg=
X-Received: by 2002:a2e:8495:: with SMTP id b21mr7607895ljh.149.1563453767877;
 Thu, 18 Jul 2019 05:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190718030030.456918453@linuxfoundation.org>
In-Reply-To: <20190718030030.456918453@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 18 Jul 2019 18:12:34 +0530
Message-ID: <CA+G9fYvXydEVdXBhLdagzj5gvxmdZgUkDQ8UFToRtb0UwH672g@mail.gmail.com>
Subject: Re: [PATCH 5.2 00/21] 5.2.2-stable review
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

On Thu, 18 Jul 2019 at 08:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.2.2 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 20 Jul 2019 02:59:27 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.2.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.2.2-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.2.y
git commit: cc78552c7d92a2d16d8fba672a91499028fca830
git describe: v5.2.1-22-gcc78552c7d92
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.2-oe/bui=
ld/v5.2.1-22-gcc78552c7d92


No regressions (compared to build v5.2.1)


No fixes (compared to build v5.2.1)

Ran 24019 total tests in the following environments and test suites.

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
* kselftest
* libgpiod
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
* libhugetlbfs
* network-basic-tests
* ltp-fs-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
