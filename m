Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69276C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325E6205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6wf19Qw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfDBLFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:05:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33331 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbfDBLFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:05:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so11177047ljc.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L4nz6P79EazF4QGJMsEwzyd6R0TDkYs1FDXUSQwoBy0=;
        b=G6wf19QwB+/ESnO+pScyymKm2R2eIKfl1ai5jmIWvfS2LnGmmjIu19l8/arZenGQpx
         eajNES0KflOpUNb09/+LonXpT4Q12ORadWQnDtj77Sbt613V/1nGedJKLLVSiLbhgHx0
         vAldb1B7epGsZ5BwHj01b3wb1nFyoT+La9QT2mXR0dCRL5QxI4qffOOtAqrx+FJyglNl
         BzH7MaETVA7XsjTb9x4iBApJgx3HqSjSJZjJCPjAEM94RPXiRRsM1m3D8CbW3sre0wja
         /vkD1NxQobzIhfe6+ZjXfclm3kbCV90RWDcjs/a5ft64uP0k4A458TXasH7tuDq1qqCf
         JFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L4nz6P79EazF4QGJMsEwzyd6R0TDkYs1FDXUSQwoBy0=;
        b=RmSXBIa0xC3SrsIITvZ7lxxf9ZCBS6xrbhFigcvlp8ZsJAebTLGsiQtIEMOt8jYD1R
         gdzczdSsffkP1nFoFcpDSJ+aKulWkndW5UJekvLWMXPm10zTV3Y3oLxUV6Ec6x8j2Wnx
         UVi4C+OVvoMY45GnTKvde6J1OADEqP1J/jRlIDaegmuGj3PsQMBakYi0xkTi5O6XFUDV
         WCxIvkI5ufty+jkJhT1hNqGBEADmOCZ1WJCVKnwyo9ggr3HD5R1D2SDRVMxvw4JZJDqM
         0j2C4S7tRFENXhyK6dJeCI4PbOxIFLmWtZGPr8g185EsFODzABcwXpeS3y5VtOlh1zht
         6Hpw==
X-Gm-Message-State: APjAAAUQuWIn/Fe1COwsQa9uB8nlfYOmBcu5ax0FUn5Ly2q5k/QgcFZC
        Fg8/fw7TtY/MIERb+fG3AAxak7dQ4o8d7EHyfauklQ==
X-Google-Smtp-Source: APXvYqzIMECJt+B3TeO6Fg3cuOQ7Lg5qI96D7RHpvv4kHtP7Aj/DuS76i87QzYM0ZHdqo/yCyNKjjaEgr1tTxfM1UTk=
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr34402414ljg.64.1554203123266;
 Tue, 02 Apr 2019 04:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190401170048.449559024@linuxfoundation.org>
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 2 Apr 2019 16:35:11 +0530
Message-ID: <CA+G9fYvC80nexMB0EHhvyNWs1=3LUUkqEtS12rVF=cAQLHcfUw@mail.gmail.com>
Subject: Re: [PATCH 5.0 000/146] 5.0.6-stable review
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

On Mon, 1 Apr 2019 at 22:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.0.6 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Apr  3 16:59:21 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.0.6-rc1.gz
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

kernel: 5.0.6-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.0.y
git commit: 7505a898604161f421b3c512483a469199c61089
git describe: v5.0.5-147-g7505a8986041
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.0-oe/bui=
ld/v5.0.5-147-g7505a8986041


No regressions (compared to build v5.0.5)


No fixes (compared to build v5.0.5)

Ran 16660 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- juno-r2
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15

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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-fs-tests
* ltp-open-posix-tests

--=20
Linaro LKFT
https://lkft.linaro.org
