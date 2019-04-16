Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970D6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E872075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdzfh5/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfDPEGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 00:06:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34875 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfDPEGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 00:06:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id t4so9228930ljc.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 21:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hes6/OoiXHVdVpK8XiO7P7HYekwRg/FiGOLiJXxrQFI=;
        b=fdzfh5/fFOUiiTZoftX+oXJLkVjR2uBeageQXOuOz4giyds+rjb4zNqTbTDvgy2GMI
         n/7KOTyAuJ9NteFg+43gSEY4e7lRjq581sD+0CExLsWOuRhi7XZxvp2PmaxOfxYIJ7cg
         oo+irurV7JdgE2+k1/ZxHEZNKO6BP2bDPOP13Hh9LegTh9kIEdsN0OUQWZ70OgEysi7I
         SuQE1X8qYu/xRkH2Ct4fqwIGKg0oGNt5JTSAKC7sEopKfV2t43kCU1p9ljPXoANWU1T1
         Qa5X9zfuR8K3kVi37cTHbMIFhKLzkRfiUCfUwfqx5Rk80aB1CDx1kZpeyCjLOcCKRkWk
         yU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hes6/OoiXHVdVpK8XiO7P7HYekwRg/FiGOLiJXxrQFI=;
        b=WrOKfvdQCrf4XG++PjgWzWp3g2CuJMd21rPVEdPK4W8dZCf31Fbr50N7mIxsiGkZLJ
         +3TVcoofURArGos1QL6LfZe9r8XeMaSha9yjBddjoedo9kcQVbS2CeCVeCvfwaexYeUn
         xeNdGuHIMvelzp7092RgrFDJGiaQcelzQrOxlXBdQ/PVgzqGGlBc3SuFoh2Gtzi0ZNQu
         pmh9n3cE4Ew2KEl21P/0Z+IzBTwdvNxnEtJfAMm4yTOU9WXBvyWbNcp2aHqhBVeIz4BA
         yG5PvpJ+MzIez0RVySxVIxRMczG3eUap11DzCAGoUd4HSwGkyFQDn2voT1ThNEV9eElM
         bSRA==
X-Gm-Message-State: APjAAAUn4k9RzC8uU2CCeOC/oso70RlGP1WkpySC+tHZXn7WlDE+HzdW
        Gf7gynjfxJe6K1IQYJjIuIkvHSmp689KXQbSJKkCsQ==
X-Google-Smtp-Source: APXvYqzgZGDz8BtWyoFNAsgqtbbSs75643z0bMSS/Q2CW1ha53SM/NApRZmQ3rxBbElh7ac6Ds7iBwLx6fprk37JKII=
X-Received: by 2002:a2e:8149:: with SMTP id t9mr44386193ljg.2.1555387601735;
 Mon, 15 Apr 2019 21:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190415183707.712011689@linuxfoundation.org>
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 16 Apr 2019 09:36:30 +0530
Message-ID: <CA+G9fYur2QNK5+YLTrK4J_SXkdFBgyj3bro_2DZJ62PbkTH0Zg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/76] 4.9.169-stable review
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

On Tue, 16 Apr 2019 at 00:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.169 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Apr 17 18:36:37 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.169-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
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

kernel: 4.9.169-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: a5905936a4b81c2c035f5abf34914d802573b0e3
git describe: v4.9.168-77-ga5905936a4b8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.168-77-ga5905936a4b8

No regressions (compared to build v4.9.168)

No fixes (compared to build v4.9.168)


Ran 22703 total tests in the following environments and test suites.

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
* perf
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
