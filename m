Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D805C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B23C20896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VP/HMkwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfFMSeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:34:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32916 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfFMSeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:34:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id h10so13661472ljg.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xFA1HvjWXfIYOquKURB1WrLdmnfWnV8ZvDcbMemW+N8=;
        b=VP/HMkwQRbTlRVJP4HZxL5ZrlUyNoXOASFkzmJAXy6pAi+rGne+NBBV6Q19NYkcwj7
         TubQZUFb2O4+3tJCh+ciz6LhGhoOz9nPjx0qWIdXGUpr4pKLl5FZrrhVGHoLPZMRFGf9
         wS4M7n5QV1iQUMgh0lMD9fH5dVErdb/zwhFIabayuCW7Bz8dIBBi/wrgZmI22Ozm7nxC
         bxh7+HlZohu0RGjQqgkcithlpCflgS7dKsYTsMhdMPFY4+rDcvTwO7Z0sYv1dd5chZRM
         I7kR9Rp6/tHIAc8QR1hya3i3krfOCH4Gxh0yIy3PsMSrWtsHTVedoCMccd7PvCpTALhP
         WBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xFA1HvjWXfIYOquKURB1WrLdmnfWnV8ZvDcbMemW+N8=;
        b=Szq4XHXJ/HCHtlzs1qJt44D4/C+sUGCyw5s2HDIl5mQFmZ0oacwMHj8e1QCRDE49ev
         C0VUujwl/adYoNreDhmDle+J3hIE1MZ5rZkhbzWqF3GrydpaJmu3mCs/RJfTAGNCTm6c
         zG0UJbYoCluls5lJTLENKGTU8mNWHl4tFeA6Yfu5VTuffgMpvWbQzFjtdr/w1r5b2ug6
         kSIUFtC+HQe+R5RnZLU5horTaC06KraGZSTY18fIyozJpjx48GVYv7BOgKIAHilEHd4c
         tCnEiZOLoMdPdmt7My4LPY6OCrCp+2B143WKYwENJ5Lpt1hbkY7E30+fFxm9v5M9OECa
         2Kpw==
X-Gm-Message-State: APjAAAURQqnXdvugZFzDKADjOVIlFTZ7uuTkONNCRBhqCsS1fScLe05h
        zmy8r7TjcKZxwQjHGqunA1T/+Djgtgz6VSgN+qyU5g==
X-Google-Smtp-Source: APXvYqwY9CVw6eH9mEgvZKHBnlWABTBw3k1y56NpDF8i5dWBU589aPHM5lfxx5SGbEj8cV2K9z88TjdKEmRWju2BHEk=
X-Received: by 2002:a2e:6e0c:: with SMTP id j12mr25106765ljc.123.1560450846392;
 Thu, 13 Jun 2019 11:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190613075643.642092651@linuxfoundation.org>
In-Reply-To: <20190613075643.642092651@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 14 Jun 2019 00:03:55 +0530
Message-ID: <CA+G9fYtxiMGO227KyPn-7Wtp_LPipGQAem0F0Ffpu5j8oWyrOA@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/118] 4.19.51-stable review
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

On Thu, 13 Jun 2019 at 14:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.51 release.
> There are 118 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 15 Jun 2019 07:54:44 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.51-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.51-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: c6c7a311e997d044523cae077b58b1849cb8858f
git describe: v4.19.50-119-gc6c7a311e997
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.50-119-gc6c7a311e997

No regressions (compared to build v4.19.49-53-g768292d05361)

No fixes (compared to build v4.19.49-53-g768292d05361)

Ran 24778 total tests in the following environments and test suites.

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
* v4l2-compliance
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
