Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B17C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB29F20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dmxNIGNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfEGIMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 04:12:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44054 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfEGIMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 04:12:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id c6so8030921lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3hq9FSGG02VY06FlEFLrIkkrfLPXKNPAfTz/bP6Jco8=;
        b=dmxNIGNrK286lTwLeNhvSglENwlRHGAUuMY7NMTexs5jIQmgcP4QFfDbaerm46jT33
         j/5cAT2yGKZUvNjqWt1YCoOisGXwegMPYPqsz83NlKForf9OuHlsO4gew3nUZE84cPuG
         KoI7MtZZ27ER876p8ZAMqWs6hniSq4XiLOTD0LJKk4H87VhypXP3LhJlfRndK1emedSl
         +eoH9QsQmeXqRvTiniNtNjSubZWax0bE4b0xb05MKO3TiYCdnxrBGyH5hhqb4ssuHDb0
         5pbbDbDxELxK2Pr8dZ5EGjS7LYJdYDIedLbUzqqvYJBrQ2uCLYiuY88/EUjta8KLjfoC
         gmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3hq9FSGG02VY06FlEFLrIkkrfLPXKNPAfTz/bP6Jco8=;
        b=L1i3m+ZQCdmYRwQOlzNjXcXxZya0QSrv2Qr+tUy9FCjSHj3Z34I7LromzH300p5R2l
         1UndPzhuhsiqEaGmgxp+vP3RKJ+4B49OsG+Sl5rl+N8aMnH+kMs/W39ufIR0tnnTlLvD
         Fv3h6zYxv2Zuw4Gzw6EaHnQxi1kdsVl1jo4RzsYvcftYItL9BEegNYZbkDAq/IclnFox
         aUdy6h6hfQFbtf5y7nMq/vNUYqSkB11U71uBwElGOkWxxgYqHpf96trvhh/U+lQDBKdl
         07yp3+pUHEEPAvnOejSDFJQgUxJh2mU37gdXOqs1Z6ZL/9ww1K1jNXFsJ1YGWDz5FflT
         zYGg==
X-Gm-Message-State: APjAAAXFt5JdIAghgBPKclAJzRNBm6WnAn6D1Jta03dKSL65hzvhE1mD
        78R/m4P1K5b9wcYrdTzg1ynX61b7QZ2twgKc5vhVNA==
X-Google-Smtp-Source: APXvYqxh7UgOnP5AIFKlhkZ26FDOZnUL6zYLVAbc2rh5hj9GhsDGTp2ikFlg4LlDgqc/zkvcNfhMvwR4F4Gs1Tu2R6Y=
X-Received: by 2002:a2e:1311:: with SMTP id 17mr16088273ljt.75.1557216768150;
 Tue, 07 May 2019 01:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190506143051.102535767@linuxfoundation.org>
In-Reply-To: <20190506143051.102535767@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 May 2019 13:42:36 +0530
Message-ID: <CA+G9fYveekDik6yESocHSA46poeLKKVExjx0KkMyLin_Cvf7-Q@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/62] 4.9.174-stable review
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

On Mon, 6 May 2019 at 20:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.174 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 08 May 2019 02:29:15 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.174-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The results from 4.9.174-rc2,

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.174-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 43d95ffd279c80b33fcc2c0b327c1195e3331185
git describe: v4.9.173-61-g43d95ffd279c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.173-61-g43d95ffd279c

No regressions (compared to build v4.9.173)

No fixes (compared to build v4.9.173)

Ran 23406 total tests in the following environments and test suites.

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
* kvm-unit-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
