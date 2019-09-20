Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7C0C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442C120B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iLzcF1bC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393031AbfITOls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:41:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34006 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393015AbfITOls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:41:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19so5855030lja.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 07:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/xQU0I14POU1160/0iVOcIzVuskH7tOT6JeJXF9wHh8=;
        b=iLzcF1bC+A7Ay72n5F4STM04JWspeI8LAlSp0+5y3xx/ASpzrb9u/YBy2T86K+MLTp
         w4hUfC5jOkS/jvGhpe1DMoJT1Hz3IEiFLd4E0wP0+pqXvEyqICe5JCZeDYq3FahFeq24
         qQLIC5Jx/ms6y6IBysPIPL7e/HyaA0+dBjdVi45EdkaRbNCJGvhUeFuaYVdp3tXK/PhT
         MdFfrAUHcQ3parxYJmUYxmuBk7/KeuVp4P5pQ5BXAncruBnaAi03s3VTKQhF/nxe16T2
         JcLs0+SeZtEkdvkkTK1ud++wWdqcowUypVKoNEIM87Ms8byShC81wwJm7OqPapTHvUpP
         A7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/xQU0I14POU1160/0iVOcIzVuskH7tOT6JeJXF9wHh8=;
        b=ulnal0pMOab9DmNIGcr4BPB7RA5bLqjI0aVt5cPFuRiFHC7EOfBEstCjPDl4ba6TBx
         pSzQeC4q6E/zoebC6q8ydZfqmELwShA8pkNxpAfYMibOrGgeMmWJBQTxcO0gGUlroR3s
         e4b+WA++dGL/byloNVWJ69aoJv/Tmb6xvu5QMDScXNh+/3LASQQYjmGBy7xL/wPsc8I9
         5N/ZolWZZu1gjKvHUDHI68a34NYtlfp02Fkj1bjAkQVpddWx6BvydiS827TiAFTr0uh6
         8L4pynt/Ih5Gp7d24MV9Zij70/JbbFBBLd/mZ9ZiDUQxiCPM/3nawNuaaxkgKW44kmYt
         suVQ==
X-Gm-Message-State: APjAAAXl7j76jhWA5V0xR5E24pDUQ02N+qJTXF34Lw1QosobwokYQPc2
        vLTo4en1qF7u659kzEaPKF7CIZWco24tOHS1k6oLCg==
X-Google-Smtp-Source: APXvYqzrR41AiPf2yHALsv/Q9ZxssKyD6wNwc2On4OM6CIP/fvhDUmcGj68P8ub2ZY03APCL5lGodtepOml2+YY7Wgo=
X-Received: by 2002:a2e:94cd:: with SMTP id r13mr9418176ljh.24.1568990506087;
 Fri, 20 Sep 2019 07:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190919214657.842130855@linuxfoundation.org>
In-Reply-To: <20190919214657.842130855@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 20 Sep 2019 20:11:35 +0530
Message-ID: <CA+G9fYtPMOK8WzhpQTMBZTtz3T9Hzf2aOusFDJF0cr0bKKo6cA@mail.gmail.com>
Subject: Re: [PATCH 5.3 00/21] 5.3.1-stable review
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

On Fri, 20 Sep 2019 at 03:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.3.1 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 21 Sep 2019 09:44:25 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.3.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.3.y
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

kernel: 5.3.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t
git branch: master
git commit: 574cc4539762561d96b456dbc0544d8898bd4c6e
git describe: v5.3-10169-g574cc4539762
Test details: https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5=
.3-10169-g574cc4539762


No regressions (compared to build v5.3-3662-g04cbfba62085)


No fixes (compared to build v5.3-3662-g04cbfba62085)

Ran 19661 total tests in the following environments and test suites.

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
* perf
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* network-basic-tests
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
