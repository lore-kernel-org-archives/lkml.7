Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4071C2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76DC2073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fY7/Xirf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfLDTNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:13:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36390 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfLDTNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:13:45 -0500
Received: by mail-lf1-f68.google.com with SMTP id n12so462127lfe.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 11:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1wonwDfxTC0Az8eUJTY72CoGHscEa6AAMn+TBh2tAvM=;
        b=fY7/Xirfo4q788ZTffCNjFp3MHoTFfy2WxfBWaPjbLULbKk8RgbB2bPUF/4HTa05oe
         ouZrx/KfTuxivZUbdQV4rBSFn3p63PU89gjbJCMjxxrho6g6Cnb37wURpudvDEOXXRWa
         3RAvWgC0KrLmP3npEqNDTyCMhXcduKGcPJ/Uu6yCTACVitF87X2Cr0pjXDx8rL+rCMBR
         NZBfXVNub+B+ihC5sTkE1vwOxlmblgMJUdxSEv2nOU4V/zN63hs3rs54ABOWjOCIwd59
         1GBbSEzwl3hd2R+EegkBC4rQYhEpN4Di63rjdDawr5NAePqJ9hshJqg7KEI7w3FFfPF+
         qqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1wonwDfxTC0Az8eUJTY72CoGHscEa6AAMn+TBh2tAvM=;
        b=YHyMhXR7nZmKqADdRmCv5ltfDr5zJqNw85JTxZ5m91yknDDpGAs9V+LjTC6eRjc/C+
         E5tPcJsMEmvpRD50gd5jzQLMA2SlKg0+WnMWXJ9AWbv9lVUBpKhH2z0QCQmvU3EhgkhR
         F5XWh+4B9/Xt4sTkqSwLCj7B2d/erhwJU69vDOqVJL6EOIIcZZXPlPsLhXIERPvHmraQ
         ohsBmZJuipdcbFvAm8Ujge/j5MWi5g/d7ZW3RItwfFwdbzqNh9FWOiYo0nHMNDXY4ePy
         QTgIgkhDoLReqmmmnvQVHyfDHV3QFutQnY75PYvKa6yWzlUsCpka/z8d+94qXidGFwWE
         B/Mw==
X-Gm-Message-State: APjAAAUpRRIgBFZTvtOqIUaxlueK5BvqBl/podqw5lMlu8eDx3VH4Ytb
        xdO27Ll6+aZ6jKSM9nmQdFPzsENr9RN+TA9FHtvFPA==
X-Google-Smtp-Source: APXvYqwk+zySa8vF4Oy+VleK8hxaeKdUpR1PJpQiLnv3+ZXkEZiOk/GdhaEpRspMk6yakjCinhm7CAObziIxg2GOGfw=
X-Received: by 2002:a19:e343:: with SMTP id c3mr2996659lfk.192.1575486822742;
 Wed, 04 Dec 2019 11:13:42 -0800 (PST)
MIME-Version: 1.0
References: <20191203213005.828543156@linuxfoundation.org>
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 5 Dec 2019 00:43:31 +0530
Message-ID: <CA+G9fYv=nBu=j_3bTjuG86o5=dM2gv25Zo07MHOF-N9Lm3E9MA@mail.gmail.com>
Subject: Re: [PATCH 5.3 000/135] 5.3.15-stable review
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

On Wed, 4 Dec 2019 at 04:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.3.15 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 05 Dec 2019 21:20:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.3.15-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.3.y
> and the diffstat can be found below.
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.3.15-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.3.y
git commit: 682bd5084c785a2b36f6d7e4cd76e8c6d85dcac3
git describe: v5.3.14-136-g682bd5084c78
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.3-oe/bui=
ld/v5.3.14-136-g682bd5084c78


No regressions (compared to build v5.3.14)

No fixes (compared to build v5.3.14)

Ran 23162 total tests in the following environments and test suites.

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
* kselftest
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* linux-log-parser
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
* network-basic-tests
* spectre-meltdown-checker-test
* v4l2-compliance
* perf
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
