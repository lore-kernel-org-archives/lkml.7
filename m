Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B2FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 04:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EF72245F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 04:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lz3i/ejE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfKTE6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 23:58:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45792 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfKTE57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 23:57:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id n21so25910144ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 20:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V4P6DNIYqK1+zdyL8L3/KTOZ5PDDb//FKvPiOoLUHxE=;
        b=Lz3i/ejEiWrEcI1Zi5wZsppYkhPZdbO0r9kLRC83ROijhaM9GK5coQCdmk2L5x70m4
         znrYSqimENp9r0JRvdQwYjNlHw1HTzAL5z0QA4eVXUd5F4xC1lyQqkCgNUYEFHU79BzK
         Jr04nWdl6uZ/67olX02eogqc007IVJa5HDoB/5nnxbDEuRelFyycTvegDa3UuHM2Zgb2
         k0X7+MXfG+X2JDkw2/SYK2lciJBMtYgWUxDzmMX6Zi/vikAhh1iRMD/PW3UhtLgywUxS
         UXk5zS9bnrLGXnaHd1MuFDh7F2dUCj8fusp4Ft7fWHgyMWJzPhLWdEYGHvpEiyC1Lrb3
         9sYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V4P6DNIYqK1+zdyL8L3/KTOZ5PDDb//FKvPiOoLUHxE=;
        b=mBnNZ5lR1WtZGzxQ+ippl+Kyml4nWDkw3TNhQuN/zfDEltPSvhhoQzmlNSVJRkTfHP
         6WwT4wvtBUsEpvGo01BfQUZXv507gesDTnGPkhlBPhaf8vnUGJFY57yIb2VZkDO58gW0
         nk2pb+9YtO85CV64TkUK5dd92l6izJBOOZO9NutjJukM+goYKLgIKgbYNyR5O8eWAON6
         e+mgW9sZZ/IlG1nOzWpwKhII9qU3FzpBNuOnhRZ+0SP51UAFS+4QaZoONB6f+rtYoLp4
         PPOhD1ABtFzR6AaaDeobu8t5sDYfj8l5TRR4y+BjH3yiisX3S3GR31UbWTZogFmiQ8Xy
         /M2A==
X-Gm-Message-State: APjAAAVoiP7tfH1u58dJzHx6ZlicxM+9Uk55oXqT0Dysdhoz13qGjad1
        ZgsaHHf9U3qERKK7fglslI/6tqdygpbA9P+tBJPYI0TKuII=
X-Google-Smtp-Source: APXvYqy30rcg1k3Zpdtfz5qLUui5bfmpYrwPVQV76TI1iK/QIeJ7jAc4lKImn2ZZ1zJ7dhv0hLm2/tbMSg8eR7ylhXU=
X-Received: by 2002:a2e:9695:: with SMTP id q21mr805068lji.206.1574225875612;
 Tue, 19 Nov 2019 20:57:55 -0800 (PST)
MIME-Version: 1.0
References: <20191119051400.261610025@linuxfoundation.org> <TYAPR01MB22854E4F20C28F3A10DA65E3B74C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191119122909.GC1913916@kroah.com> <TYAPR01MB228560FC98FFD1D449FA4EC2B74C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191119154839.GB1982025@kroah.com> <TYAPR01MB2285698B8E0F38B9EEF47128B74C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191119165207.GA2071545@kroah.com> <20191119180002.GA17608@roeck-us.net> <20191119181619.GB2283647@kroah.com>
In-Reply-To: <20191119181619.GB2283647@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 20 Nov 2019 10:27:44 +0530
Message-ID: <CA+G9fYufKfsvtHHTmc+yODAeqhE4qego2R3Kd3V=4kr301M9fA@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/422] 4.19.85-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "ben.hutchings@codethink.co.uk" <ben.hutchings@codethink.co.uk>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019 at 23:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
>
> Ok, I've now done just that, and pushed out a -rc4.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.85-rc4
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: d0112da1f7e63d8c9a40263ced73eb673177a053
git describe: v4.19.84-420-gd0112da1f7e6
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.84-420-gd0112da1f7e6

No regressions (compared to build v4.19.84)

No fixes (compared to build v4.19.84)

Ran 23846 total tests in the following environments and test suites.

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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-fs-tests
* network-basic-tests
* ltp-open-posix-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* kvm-unit-tests

--=20
Linaro LKFT
https://lkft.linaro.org
