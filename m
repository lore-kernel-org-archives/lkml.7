Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE324C468BC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A369020862
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oHR6ZTIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbfFJItJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:49:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45325 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388020AbfFJItJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:49:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so7117824lje.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zQpr307ZRi4AOPorhWYAYbPU8liPOSECGeUOKCZAFRQ=;
        b=oHR6ZTIY3GNDpq/fhgQWZHRMhQ+qqtH6NJnbiHl1rnj6iSYZ07zycjE0tTg9d5E8L/
         4G9hFw9Yo4nqnLFioh2DMe595v4HiWoDf/qMCGA9RzwTwUfgcGmHc/xci8zO4pQ+/zi0
         zj+F/ti5pwnIHYqLDaWRw1RRI6iU6DUb5G9fTvZUGBcTI3JdhsjNh9e0HcigqqedCIQq
         E+UqCGQMhEWjDCYQ9ak2SKESbtJP7mvFAfIiv93tTNGxLpX4yMv/93uPlcZxwWoY3h/S
         XesgyLkZ8S53nd/OgKgcl6mnEq/2y1ko3bn24hAMgAD0+72IEPyR2bVSqlkWPjLfDJ7L
         Aw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zQpr307ZRi4AOPorhWYAYbPU8liPOSECGeUOKCZAFRQ=;
        b=Nk6YDxJqq5g8gZqchFTsp7Ap/4YXiVYXuivA+mm1BsIM3EqoKPlkQiRp+MDAXexoG0
         2pbr4Us+FmhGq+MYKO0H7CnDUsiMWWPJ1Vjhx5MBMhmeoDwPuWn0/EScP4whrOAn/NIt
         fSTNAJ73hxnpDnBssKCPEYiQFbOOsA9EPQ1LPyLwzP0fZo0HVfuJUfVJxVyvdUufIMbU
         m/w/Vn1XcsbXdbeXbXbrene+rGSGQ+790BxLdQx6rQIV4qpDvOYY28bDy2QgNnYoPX6u
         cxJaHFygAd7AhnqGNzcWD+BRcJhwGDdi1L+za/7yCeBtbOx1nXvx516pnzCBLGRvClh6
         O9nA==
X-Gm-Message-State: APjAAAVv75GN6LtUo+yV34wNOTYKgwQJwbhOX74ygKX6I2r/BkdCkG5F
        D2mwihNGzXLlCotVBZH6crCgSxrK/eKMuOLLQUH8zg==
X-Google-Smtp-Source: APXvYqwfPHKAbgHZMMl6Sz7Ycl+4Yx3U/xCUKp5vxsnSILq9jq0I9wYyx8hpi6bX9qV5yYdHboZG0OlQdWsH/ixwUy0=
X-Received: by 2002:a2e:81c4:: with SMTP id s4mr24081059ljg.182.1560156547167;
 Mon, 10 Jun 2019 01:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190609164147.729157653@linuxfoundation.org>
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 10 Jun 2019 14:18:55 +0530
Message-ID: <CA+G9fYu6eYm8sDJ=8pDvon-iyv6WwMtbC-cvdtYhQVyXvReBsg@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/241] 4.4.181-stable review
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

On Sun, 9 Jun 2019 at 22:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.181 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue 11 Jun 2019 04:39:53 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.181-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
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

kernel: 4.4.181-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: c9c6a085b72ef62ce2cdcfbee79476ad2bdbd703
git describe: v4.4.180-242-gc9c6a085b72e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.180-242-gc9c6a085b72e

No regressions (compared to build v4.4.180)

No fixes (compared to build v4.4.180)


Ran 16751 total tests in the following environments and test suites.

Environments
--------------
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.181-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.181-rc1-hikey-20190609-454
git commit: 08da993f3205945652b0e60ef5bc2fcbd22db646
git describe: 4.4.181-rc1-hikey-20190609-454
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.181-rc1-hikey-20190609-454


No regressions (compared to build 4.4.181-rc1-hikey-20190607-453)


No fixes (compared to build 4.4.181-rc1-hikey-20190607-453)

Ran 1551 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

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

--=20
Linaro LKFT
https://lkft.linaro.org
