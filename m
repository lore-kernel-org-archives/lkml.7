Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AA7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6BC206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KCUAEABU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbfC0EEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 00:04:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43540 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfC0EEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 00:04:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id f18so13081080lja.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 21:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dd/U3kNictxujG3bAxzBDuwKq/S1qTBaRcBnl22pal0=;
        b=KCUAEABU90HkbEpnCSvG7HMs/smiNrBgzkpZgieWVP6VMpL/dkEpCrcoJGk8+1c9Zg
         mbcS6KBX6srjiQJX/LiPmF19tY58U5pIqmrfaS2OpOY673sp5XP8lkuCdrSOUivWmz6t
         ojyZphHnMesa/eL/X4bqNCNMrO49KQN1x93AJfAtXRgDOUs4k77P7D2NFZHyKTXmy2HW
         F2/RsaCkkPqE0KamQys3Tj4tukvJgCAceu7PKqltQM2SB5hKViT9R8jsXzgDHblwHcxP
         MRomy9uBzyNvDJodyrVLzDiifOSY+cC9CrNtxxE8sRWbHMERqHlE1Znbveb/0AvfBaiE
         C6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dd/U3kNictxujG3bAxzBDuwKq/S1qTBaRcBnl22pal0=;
        b=jleeD8ggjHGjFZBA52I+SwLAjLmSNKqp1Y1hGmqoSdcEXuMjlz8QaAlKmRIN0SJCWA
         pjhb8CRPZYTPOPF6J/sQO5+CyNGGzmgLse7rbkGb8PJ//bseW1HSG+4fv9ddCVIHpOwc
         eFynv7AiAlD8gfwO9ANmzR6Jvur3fIbNa+SSvmfaKmmkuOP2ANADkHlgqN8Jv3qViXmY
         N1VAUk+RQ3Da42sMLB3pMAyj1yWht0BXc0tQlYNo2urpSTH33Fz4eW8hbTKuQzZpW3nq
         i6pXpaOqQluwfzXGOOFrWoRY5S/ToVEUEje7h9KEmWRD9JfA0wBdoMw4lkTT9VpbbDxJ
         ZvfQ==
X-Gm-Message-State: APjAAAUzOwkbBpI/vVfaHA7ypgoEGR+5a+cBrWzZrgopRXSagvXRZKaP
        46YRg5VQlHabfNzVIUdGdS2TEnisd/CEzeLmmZgDbg==
X-Google-Smtp-Source: APXvYqz0oYh5jgFjUMrFRndLSzx4TiYjZR4K0HmNAOdiMdncdgULeoo7Ey4E5l58XCDWjlxXCqKliCyS/pZefqzqnfE=
X-Received: by 2002:a2e:9597:: with SMTP id w23mr13379263ljh.111.1553659478165;
 Tue, 26 Mar 2019 21:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190326042702.565683325@linuxfoundation.org>
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 27 Mar 2019 09:34:27 +0530
Message-ID: <CA+G9fYvLvj9v753ZtvaqZnidZiGq9b8cNMLNEWr0y73KG+9YhQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/45] 4.19.32-stable review
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

On Tue, 26 Mar 2019 at 12:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.32 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Mar 28 04:26:41 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.32-rc1.gz
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

kernel: 4.19.32-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 91ed293142f4947a4c5c2af1fc80aa91b3782642
git describe: v4.19.31-46-g91ed293142f4
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.31-46-g91ed293142f4


No regressions (compared to build v4.19.31)

No fixes (compared to build v4.19.31)

Ran 23114 total tests in the following environments and test suites.

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
* ltp-ipc-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
