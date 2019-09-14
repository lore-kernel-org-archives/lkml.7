Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D48C4CEC8
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 04:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E902067B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 04:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vloFQkKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbfINES7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 00:18:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46102 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbfINES7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 00:18:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id e17so28894521ljf.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 21:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZlApnDH6uzGioq4MEPWFg3abrgliAQW/xOnjhVpM4Yw=;
        b=vloFQkKkYGt9gx3lZns42E668T7Uln2xC/1nmv0NSdGWwsqVKWhIaf5k/sVK7s0GcY
         9J2a/gfxxvJdDsigz62y4CD0eProtuZi0cpiYUi6zVVvM+HXP+jwcka0M/XFDHN7gv1M
         4F9puca7fRnFVXO9edKRl61+eBYtXtcyN1rqT44p+6jBIuCSiWZr5ApfurDEO6b0U5ou
         jd2TzzXW0NFFUL9fnbvQPAQufG8XfTNmRg9p0OpZ+VFJ0SWABLMmfAqIYh+9qS/6dSVd
         /b0zh4/wO0bjWzEPd3uE2kd1lx2RZAYFL87snowtePwwqctSFU/cXQPcDqZUguSfXAxC
         zdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZlApnDH6uzGioq4MEPWFg3abrgliAQW/xOnjhVpM4Yw=;
        b=bovRvTcJCrAXMMJnVx4X5X45DAjbZpd7pOOwnvmPCzL+udsdknwFQodEZPW4v15XcQ
         tp2yJItYRSMnMUF4A6f/xpri102X5rRn+csRvO6a2lwaq+k9OyWNGUX6AZM+PynS8tal
         bKtXSOdgv4haKN1qmeJgruFoznc0Grvkv2ck5uC9ZhLSdh39EXvJwfGut5PrC+i14YSe
         aawc552aSbu42ovpl3BkaDCyvqTG8m6eexBTaL6wk9b+jd4J/xno2URb8T4GaZz+N3Qk
         ldHbYSBv0htDUstVIlXz05zyHCGfJ/D+MsO42SJa0gQZptXYcfSYF/OxzI6NZ/IRT/am
         HDhA==
X-Gm-Message-State: APjAAAVCNzwNfnogPP47uCRpbH3P/zNH7d+o5cd04SSpLSSF7063KYm7
        pTdXyP3ns5Omiqw9wYRKKUCqKUDJGUQ1P+bZLlDJ2A==
X-Google-Smtp-Source: APXvYqwZwg6zJg0uKG8mcZf/ncSZcgrs3hNMIksbSWoXJEwVUL2LXeZ2dGnRBQ52DVqd0b5GwvZOIsQ7gKgFN8agMNo=
X-Received: by 2002:a2e:a17a:: with SMTP id u26mr31842116ljl.137.1568434737324;
 Fri, 13 Sep 2019 21:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190913130559.669563815@linuxfoundation.org>
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 14 Sep 2019 00:18:46 -0400
Message-ID: <CA+G9fYu9NYFPrD2WqKTPFkRmKfNiYFb+LL2H6Q7=OVW_A6Q3Tg@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/190] 4.19.73-stable review
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

On Fri, 13 Sep 2019 at 09:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.73 release.
> There are 190 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun 15 Sep 2019 01:03:32 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.73-rc1.gz
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

kernel: 4.19.73-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 490747a3f68a8ef2bba5b0cb5f29b896c02885c6
git describe: v4.19.72-191-g490747a3f68a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.72-191-g490747a3f68a

No regressions (compared to build v4.19.70)

No fixes (compared to build v4.19.70)

Ran 25136 total tests in the following environments and test suites.

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
* ltp-fs-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
