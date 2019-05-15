Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6376BC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A022084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlvgNIgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfEOSGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:06:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41541 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfEOSGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:06:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id d8so525303lfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sjmiq1cCH63qmG8pGXuSooVJ5F0u+qb0wj0/CssAcp4=;
        b=SlvgNIgQqK5M9gCVm3yAs+0hobGk05eWLldR5Fsl6Q1n3/k8h0E8dRirHMgte8T0Gs
         ABGmEhUfERBQkJvO1HYDZvx/HNhkOT4zeUIfFguFpIt5Omak0dFeo09dyPB8qhO4XBYF
         +ecMN/vuucJEXLT3613aUoz4kgZglpKXDqPY1pgFqZiGdnJw/QvyZuzmLhSYVmF8gZid
         WkQAmpAY+IidAoVceJWcPN9/7URBwtGVCIbFHqGebO5qPB3nqd9PymhgXhrVFY1EAgcK
         v8/S98bQOkrrxT6ySChm6BU0bVopFSW4lICbF1HXh/C61OjKO42uoSwjBrOKEokUiObR
         pEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sjmiq1cCH63qmG8pGXuSooVJ5F0u+qb0wj0/CssAcp4=;
        b=cWixKd+YZ8oBhuI7FniamLsi3c8a/Ajc4VZZF2VUteyzy4XbkzyZK1FmCG7Z9k4z/E
         b7QCXTvzpF9I/wbLpK16alcrLtK/VEZSVUFemUmTZRxVLGi6LC0NJJ2ZkARIQcoeWmOA
         F4f9EK5W5CEOPfCdRI9Qbloki9a7QZ0Opj+2b8xdMeoApF4N0N+rOtM7ShloUGErrdJY
         QbNjW9mtOzLUXUOi/Vd/wzso/LCEJjLlVGep/FN3ELcaS6I4G9/RFp0t2/bsCsBptgBa
         2qiSriiLtYNK8zbwRdWl5Nng9RoYa55jfEumSetTuvOy4+nTt6csDeni+XkE7OItlelp
         8hag==
X-Gm-Message-State: APjAAAU6on5y3j1scR2OKLrfV4pi5eDFKIHAcHv+8RCrcxoJZQ2ak36L
        D8GeTz/3Kocax8et6WlenaGrCJ41dCylsHsP25qgOQ==
X-Google-Smtp-Source: APXvYqw7+yY7rcMpUyzxSf/n8K0DZ3ig6cmT0emvJBhlDW/eZOy+5izYGPwJ2+mf+jNzPk5qIMy1dmCbW8r77gZbbjk=
X-Received: by 2002:a05:6512:507:: with SMTP id o7mr202686lfb.137.1557943593111;
 Wed, 15 May 2019 11:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190515090651.633556783@linuxfoundation.org>
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 15 May 2019 23:36:21 +0530
Message-ID: <CA+G9fYuXv8KPEsXieSVZLY6uk=2Pfwh3B+xFa1FDRRrT=MYT9Q@mail.gmail.com>
Subject: Re: [PATCH 5.0 000/137] 5.0.17-stable review
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

On Wed, 15 May 2019 at 16:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.0.17 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri 17 May 2019 09:04:31 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.0.17-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.0.y
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

kernel: 5.0.17-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.0.y
git commit: 174f1e44d0165ce68f4e520718847304556717e3
git describe: v5.0.16-138-g174f1e44d016
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.0-oe/bui=
ld/v5.0.16-138-g174f1e44d016


No regressions (compared to build v5.0.16)

No fixes (compared to build v5.0.16)

Ran 24960 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
