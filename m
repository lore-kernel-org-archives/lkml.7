Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC8BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE1B2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n8pOI0c6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbfCZLlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:41:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37782 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfCZLlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:41:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id u2so8373890lfd.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 04:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HB/L6QaS8f+64168V8Y0OktEXN/tOcSw7Bx1YHMdS14=;
        b=n8pOI0c6wgyT/PFUUIq76nj27jcisiLe9dQP/cJuuU2r88iZlLAULAe7911b8xDMdE
         /VIzClSKjT8KfYo/YQG3nwmL5B7us3E7yAPudKf3+PUIeHr4TWNYyAgCt+TfUYD1/43y
         Yb87dVn9qxAkdN6tgZUP/qBeSDxzHMv2qfsyhO0kQa6u9434w93vkI6G3koBN3X24uVI
         0JgJUrPKO7SILiGGI7xHVUQqKVYH7yvy4AdTLqZUu3Tx9uF3ZoVDDPK73OGY8KZ48Nmk
         Bwr2BGpM9hNdSW660FeENZPVJ1VEU6wQNC/NS9MVxRXBD2GKvi+nxXZ1ysmUJgj86Yq6
         g40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HB/L6QaS8f+64168V8Y0OktEXN/tOcSw7Bx1YHMdS14=;
        b=Qo6/NB88AwJ9nNVDElfvrpcHkRrxXA4MpvDCrVBAZDpRqx3yeYR9yX62KwfSB1kW3J
         Fwtidck/BzTECxXWlccYPB9/PLhmvvvHErAQHtvXs1UdztInkS9zuCluucoGgp2n1uVT
         LVsm/oTxTzl1vsGMfb9Xnl1cX6jvyJkx5qdtkNMAxNc0c6R0Vx1eiwUtYW/jzBUMjjyH
         /ANM9YcGDL7A8xRXUMPJK6L+KgRf1yzWyRedehjBHH295EobYH68XFV5RaJ1vC8hyOO9
         4AeHOUSp2hjwZYc1yne8WIxf43+yVJyJNd4SYZ2RLo7k+wUh4h0BPv5NKPyuOKzu2SSf
         1eSw==
X-Gm-Message-State: APjAAAVkFMJLiqc08xFMrzVzReBXn/5caY7G7Czz4XQRQnn8ae85oFNk
        TBVq1fR8IuEaIl6Qs88CyBFfVh5J3ODk/GhInh16RkSOGxo=
X-Google-Smtp-Source: APXvYqz9TsFYWzZNgHUFtqTaqUOd/woT5dDzTaMIa94xnclS7pWafaGQGWfup80MF/IUnYeIHSekxEUXjw/hmRGws7M=
X-Received: by 2002:a19:8c1e:: with SMTP id o30mr14616514lfd.137.1553600476863;
 Tue, 26 Mar 2019 04:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190326042607.558087893@linuxfoundation.org>
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 26 Mar 2019 17:11:05 +0530
Message-ID: <CA+G9fYvQtjQyFsUDMv5OtG0qLtfDh9oHF9UAvUB2moHgs+nkzQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/30] 4.9.166-stable review
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

On Tue, 26 Mar 2019 at 12:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.166 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Mar 28 04:25:51 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.166-rc1.gz
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

NOTE:
We started running perf tests on all our kernel branches.

Summary
------------------------------------------------------------------------

kernel: 4.9.166-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: b7e63ff5d9f9f1ae13c633d2b98e6b180398ff5f
git describe: v4.9.165-31-gb7e63ff5d9f9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.165-31-gb7e63ff5d9f9


No regressions (compared to build v4.9.165)


No fixes (compared to build v4.9.165)

Ran 22730 total tests in the following environments and test suites.

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
