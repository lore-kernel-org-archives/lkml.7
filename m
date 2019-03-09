Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D220C4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 06:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB370207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 06:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k9xUBkw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCIGou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 01:44:50 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40538 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfCIGou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 01:44:50 -0500
Received: by mail-lf1-f65.google.com with SMTP id u68so139406lff.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 22:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J8d74+zlN8JK3x+6M6/ucvABcQVQb+dGrRSI9O+hyvs=;
        b=k9xUBkw321IbrFgzvJOvwM9UotM+DQhdREHztlYPDFMlHDPZAxqToRmCZUxtGFuN9O
         pvki4JHb2kWpZMHzSCRuEd4VH/xynEWId3xnxKvmYwgxdbHd5X6Z54WS8l7nYGCKz6a9
         u2c3t1cqbTUhJoBA5U6x4NFl2I3LSZPC5+Koz7EQZTPah1FN7Odyys4QmEBGQRx1WxiP
         VRJQOwXVyjt80nsU88UscL4TnEOEqHg6ILNpkRB5pwxceez7RB0VUSIflJ2z6tbh+ZEW
         ZeggGLNYPkKo2+CbZbWIkFv5V5Tw8jYj08HwdkprNHpHhlBQb82h3qlYSt5diAlwn5WN
         iv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J8d74+zlN8JK3x+6M6/ucvABcQVQb+dGrRSI9O+hyvs=;
        b=UKh8Vynr8PhyH4QHm9E3huJGxpjdwOCj2SiN4BgQbVBgZpb9IV8vngaSPQiAY+Mg0X
         1tjPcCBGnNWpQVnadjWVS8mll9EOfnoYMwazctK9SKhQxxW+souZxOlC3bY3x3X3lCSP
         g6arSLq8WxyuCBJIF5iiSS04S5yoLC/irSOzmJs0D1NgI/DZmE+HydXIIt3U2Im7B5sb
         /gGUyW3fxgtQeiAliZRFaIWsx0MG9BNtXfXBCyk5jYPAKWLxTYxErf+ilCztU3tlV+t6
         d3V6JaNkHsDMooorRa4iEp5Gcxmm4zxim1z+o7kdTXHs0RUuTKG4qeqXt7H5d/0yhSlI
         ko5A==
X-Gm-Message-State: APjAAAX9OrBAtGsz/V9z6A8hpkwKW5iPa303XI0YDig/0vzs7yp/5imB
        yOKPv2Ix+4srvP1l7ym3VmzgJTPC3qLUSUHQyZXM8w==
X-Google-Smtp-Source: APXvYqxXxe08ButJ2M79fYbBE5PF1uv47KFWguiMBoyLB5AHH7MvqnwripC7MskAH+dJCaQIpvpmsek5ZBwom3W3JGQ=
X-Received: by 2002:ac2:4292:: with SMTP id m18mr11706302lfh.60.1552113888140;
 Fri, 08 Mar 2019 22:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20190308124914.789210760@linuxfoundation.org>
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 9 Mar 2019 12:14:37 +0530
Message-ID: <CA+G9fYufNRN6CS8+psJY055Fww+motv+theDnp5OkW+t2uqW2A@mail.gmail.com>
Subject: Re: [PATCH 4.20 00/76] 4.20.15-stable review
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

On Fri, 8 Mar 2019 at 18:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.20.15 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Mar 10 12:48:49 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.20.15-rc1.gz
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

kernel: 4.20.15-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.20.y
git commit: b80b02d1b1651606ab4c202888512583ffcc6bf3
git describe: v4.20.13-166-gb80b02d1b165
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.20-oe/bu=
ild/v4.20.13-166-gb80b02d1b165


No regressions (compared to build v4.20.13)

No fixes (compared to build v4.20.13)


Ran 20015 total tests in the following environments and test suites.

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
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native

--=20
Linaro LKFT
https://lkft.linaro.org
