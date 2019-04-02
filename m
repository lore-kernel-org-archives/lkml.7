Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E59C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221D62084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RpODnfDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfDBDBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:01:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38086 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfDBDBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 23:01:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id p14so10129364ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 20:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EHfMDyaNwfvE8phn/pfngq97nQCA+mM+utWqMw5r97c=;
        b=RpODnfDy/NF8JgX+yDegwnKpb9G6Wu7hpLYg+ubbGop/de5SquZo3/Qa6pCB7VLPg0
         YupUsJnWL1wg0jfiLI6Z1XaJImh0xd1LHxwEuqfeeBgTYi4uqTTWotjm8SsYr1V5lqCW
         yA347CasN9j721rgDFTVTAzXxADJtMBpchorN3Wg0/Zco1xafoluoxh1a9jfEcj7FA7w
         M+wIi6bnTG/uGqgehrMywKNIYtK1yD+K705RDdPotRf/69mGwjdW89L86RQgaLdQeSiT
         AprVJqE3EmOCWcsiyNTXwMSfcqp/M/xm9VW1VXWR69d+JK8sSNileNw+krvA2p7P7Nmg
         ZSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EHfMDyaNwfvE8phn/pfngq97nQCA+mM+utWqMw5r97c=;
        b=Uvw/6zPKSoDT1BVdYFm1jxwgPWZ7G1BCIewZeE2d895DD5yBFntcZzofUSKIEMe3IP
         Bg5QEyc14zJGFntQan+hR0jG5HiAhTdieef4mejnfLx8OhMJjcHamtADjUljRfx4wGgc
         lFrkN2BctT3T1JkzUeqSo7sev7xyzPbfrIQKuViuv0ZYDkulCm/N/2ORPLM3O4SRY7Zv
         z7G7caK0heHDXuBDcigOuOjtORvleEjGpTaMSGMX+TBKeypIMDxm0mVkTIIh2uz03BGA
         1C9XFaOoQ0mhEBhCc50Hpp+kp4N9HK9UqTzwOmC/MocXaVVkgEKlDQg6snD4cNMy/CSf
         +KrQ==
X-Gm-Message-State: APjAAAWtfjABLnJZi0qs2s7NyVCb+idUlW/EH+vJ7j/x59ZWYQLN+EqQ
        ZC4joDKoBRTjP/GClaj8+zGjpFAmuyXO+wmbc32upw==
X-Google-Smtp-Source: APXvYqyblwZ31kmm2TLq8ZXnY2/ycj0OVcnsf3wMzAnex4BNiKjr40qpu0LZXEAen8C/iyRyI8yyHMdmRvDYuflPh/4=
X-Received: by 2002:a2e:978c:: with SMTP id y12mr39648786lji.70.1554174111322;
 Mon, 01 Apr 2019 20:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190401170103.398401360@linuxfoundation.org>
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 2 Apr 2019 08:31:40 +0530
Message-ID: <CA+G9fYt2m2Ypx5Gmg3vJQfx3CUyk43R=s_Z1jUkZfj-YM1Gu+A@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/56] 4.9.167-stable review
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

On Mon, 1 Apr 2019 at 22:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.167 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Apr  3 17:00:20 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.167-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.167-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: ddec8bf2f297c9844b75e4fdf2620e39c230dd93
git describe: v4.9.166-57-gddec8bf2f297
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.166-57-gddec8bf2f297

No regressions (compared to build v4.9.166)

No fixes (compared to build v4.9.166)

Ran 22599 total tests in the following environments and test suites.

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
* perf
* spectre-meltdown-checker-test
* ltp-dio-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
