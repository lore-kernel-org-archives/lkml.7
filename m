Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06A0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 05:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A554B2148D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 05:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fRbZbMN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfCWFiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 01:38:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38588 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfCWFiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 01:38:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id a6so2763261lfl.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cZZJws5H2P6s4ksRmtvWJWzkl1YlVDsVksJF6aqH1L8=;
        b=fRbZbMN4MBtTWZLTWGKxkucrl7l1onszeHy0CGHYiyylIwM7KW74+SLterXKyeRDjD
         ULuWSdYxXiRqt3ql/S+AB+xuRlfj2XlthRepIE08lpXk6nLyMnUIfSTKBwRCePRPCxgg
         w2IPE3vSC272L+JMXiZpJEde/lOtG8/4Wq6o/yXRM1vF0SS9WeGkXxfnxRBnyRYyZuVz
         9aP5hqJYIQ46k1sI5+wz3KRGtX9b6CemLHBzBXuQVBNj5zYs748miL8vdqHWeBRgxCfL
         sZjpux0kKGXrnH3PBc/asjLhPHuGxZDhpQkMtqj//O3ADchw9Cwq8D2LCmX7UQARqJjc
         f0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cZZJws5H2P6s4ksRmtvWJWzkl1YlVDsVksJF6aqH1L8=;
        b=O1BGGZMAy7RvDlRTnMnOh74mcxvz9JqQOJOJEcm0owdMa2ZQkzCQaInmyROnBdbwCv
         NDJJYEt6YCCCnG5K+7Vr0WDhy1Ej81K4f4xKDgvL5d6TrVI1AGQgQFNLeEzNsmoH7uBO
         wM7Pj+y+dDBGrVRRPap0e/TTxTbIPjisofCULsdSee+elyiXWwVmHKSumMKT+lwqH1my
         p/CL67BJp24Ts0H1krirZnFeP+BheTgPp3JywpmTxRnyNAZzE70FWuSVxXNcueQ0QKFy
         mkDuR2uANt/kcMyvzFGb9nRfmxBH/75jYkhlUyjg+3pwR+GrQqhr/THbZBlpyr+djDd6
         oeTg==
X-Gm-Message-State: APjAAAUsz7U9XwiVHfGs64SMgJVegR0LAQ7SZc2YWIdtalbBNnZ4L+k7
        Ity1VBRQ70zF1ZojnHOCohOlbnj3oHp2aQLCzW5ySg==
X-Google-Smtp-Source: APXvYqx6X3V3dNrfG3h2xUuLm1IUoz+1AIQ5Dr0tv5yKqSOCT464hBYGlttB0M17ZehQXWL2XURRtmzXeCVuzbLuKSw=
X-Received: by 2002:ac2:482f:: with SMTP id 15mr6941203lft.57.1553319492063;
 Fri, 22 Mar 2019 22:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190322111306.356185024@linuxfoundation.org>
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 23 Mar 2019 11:08:01 +0530
Message-ID: <CA+G9fYsKTMh3UuOu3WZE9R-bWWO+e0Odn6oT+nDfJRfwTiq7Zw@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/280] 4.19.31-stable review
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

On Fri, 22 Mar 2019 at 17:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.31 release.
> There are 280 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Mar 24 11:11:09 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.31-rc1.gz
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

kernel: 4.19.31-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: f4bc3dea377c7afbfe0a36d2c72e9031910349e9
git describe: v4.19.30-281-gf4bc3dea377c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.30-281-gf4bc3dea377c

No regressions (compared to build v4.19.30)


No fixes (compared to build v4.19.30)


Ran 23127 total tests in the following environments and test suites.

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
