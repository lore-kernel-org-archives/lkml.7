Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF16C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 05:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E8420840
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 05:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGgXuS1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfG0FfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 01:35:18 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43957 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfG0FfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 01:35:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id c19so38522171lfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 22:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PzolGi6g/TcuDu8SL3iyFaFmwaFjqKwFAI80D9n/s1Q=;
        b=VGgXuS1Y9NES4hVTBbGA4O4397PVfo+SH0nSYNBaZA3UekU18/WJZh4K4ONF1sF86q
         30NqvPEha+oMSIPWg0Dw3GLgYq7uk870F5ZPMzfJsc6QATcb/OSb6IqqNWsfv7+uw72N
         ecQVde47OY0UBdCOa2sIfEDdYR+TT7+xyq7xByJpkizW0I+4dKZMgOxwv/61zQYOPW8G
         g6ws2uYOHjGwkCRjqSrB2G5nICZG0SIGRZfzHjcu+hqpPD6HH5NHBcsDCyLlz3RZMNQi
         ZOHwQVItlba9czw5zGI+aIVETOCjNq9WBhYVNGJbH8Kz4xGYyBH2wTalou8N2UhFwpue
         wfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PzolGi6g/TcuDu8SL3iyFaFmwaFjqKwFAI80D9n/s1Q=;
        b=iC8pcgYzCwelCQ0hFCrIY6y9zV8EQqW/BseC5NqKF9g8sRtrrOJDxG5goRWtZET/02
         ZouAPj98pQNYBIi++pLIwuiyfXRVznNaaWmqTZM/catYlaurQxFM7Q4jRkXeKlsuCB4D
         RrKi31z4LIh2CvA/fiRxtwWK/gsqt/oExFVHSaAIodg1K1cZiw5sOhun40B00AgaBdLi
         f653Atf5xX125gDCJGU305qOmUh6z0WdibpMo3uqqeQuQxtZbAb3kxzOIzMOgwOGos1n
         gHEwABE2qeHp8vJJpR8vXe1eGHmlOfAZfY36u5gx7RtI0IHdhOlc01S9sGXlR9g67O2C
         s6ZA==
X-Gm-Message-State: APjAAAUxPHn3dVdcBQyc9S7k4UMecZgXfqPXFZgcquiQx8nXz+cKwjro
        IDkcwwc3x4kUOYcBTS6XtN/T98E0xjtIIeoofoIdUg==
X-Google-Smtp-Source: APXvYqwnC3I49Q9Qpb94zyDJQeM8/85gk5segHmTrCFRL7t2meMzjC83QZLqr4w5cTUZGnFRlBqjwetertyfeCKYqO8=
X-Received: by 2002:ac2:546a:: with SMTP id e10mr47166003lfn.75.1564205715628;
 Fri, 26 Jul 2019 22:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190726152301.936055394@linuxfoundation.org>
In-Reply-To: <20190726152301.936055394@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 27 Jul 2019 11:05:04 +0530
Message-ID: <CA+G9fYs8BSxWnE2csOg93jNNFhqMFLavWh8FO3cpBuxy-U3QSg@mail.gmail.com>
Subject: Re: [PATCH 5.2 00/66] 5.2.4-stable review
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

On Fri, 26 Jul 2019 at 20:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.2.4 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun 28 Jul 2019 03:21:13 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.2.4-rc1.gz
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

kernel: 5.2.4-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.2.y
git commit: d61e440a1852a64d8a2d0d358b9582b19157e039
git describe: v5.2.3-67-gd61e440a1852
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.2-oe/bui=
ld/v5.2.3-67-gd61e440a1852

No regressions (compared to build v5.2.3)

No fixes (compared to build v5.2.3)

Ran 22512 total tests in the following environments and test suites.

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
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* kvm-unit-tests

--=20
Linaro LKFT
https://lkft.linaro.org
