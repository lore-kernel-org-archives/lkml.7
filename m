Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C041C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 06:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534C8206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 06:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zj+Ixevz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLQGlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 01:41:00 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42572 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfLQGk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 01:40:59 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so6096394lfl.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 22:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZzbVgb0Dsc1MnhDpYFuAmdtYBehM6wFQjI2gRgSINqU=;
        b=Zj+IxevzHy0cniNQF1XM329WmC/mEHJ6bVqLYiolS6BCzCQYIS80V0Ay+zq45WAEq1
         /d+PM7m7EM/K9JqGTbV+hYCbCruQkT3CIvMhhFYmaLutNBtiZCyXoHO88vjFHBD8Vc4Z
         V6UXm7oOMsl5k1i8WL4bUXrjCBwJ4Lg0nYN3Yo7DRae1Ir3gow+mS8VSRK9R8TRErr1P
         PRpsuqYr3TmH29WlF3asaFmJUnApFdH5K4dYVgDC9MLbtiVJ0FnCHcJ+FYC5iAl7VeMK
         m9RxKdGx7/zzW31Q1bpDQj60G3FLz+ROuOHomzHvS8Sll++BN9chP0sqneCFmTg+Jfe3
         evxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZzbVgb0Dsc1MnhDpYFuAmdtYBehM6wFQjI2gRgSINqU=;
        b=KcUCnXgHUDd4wSt92CVpbl4FgXwu5V3vLkWOJXVxfjvl0jAL5/dvAj8pUcyVSG4VDm
         oduu+K/L/2U8Mkel+Gzt/z9Ndwt5ciGAW2w1V+tXXjlCT10ftYYHAqrilRaRmf2XgjKV
         weveTla99hbCUlvLW9kgOb5P1bLKMhNtBHsj6KuJzoWD67VhDrOGAeDlhIs6UDxCTHsp
         lLQQtvgjpUWQVhFLHPptf19GjuApNYaZP2zhy5nsegnF7fW9yqH+j5QuNzt+geCo80fW
         mddW03JITvLeKHcB6QMYZVeS/3o+6rWfsAJonywGQaexbR8CB2cgsF1Sk/bt1hjt62E3
         fN9w==
X-Gm-Message-State: APjAAAWD3mnkizBu7m3Z6zd9zP6nqI2J7dUyD2W+cWnMJLfhXbqp7Jq3
        zy8t2squKwosAtxToseASmE2zgFu/HOK1m6d56dVQg==
X-Google-Smtp-Source: APXvYqyb73zwNv3ziW7+e9hRPvnZdExviQMYWdITo3G7CKWq6hPnOC6EIBQlYWoq/vh+8BOBYsy23JgHCyUPJ0f7tdY=
X-Received: by 2002:ac2:5337:: with SMTP id f23mr1690949lfh.192.1576564857544;
 Mon, 16 Dec 2019 22:40:57 -0800 (PST)
MIME-Version: 1.0
References: <20191216174747.111154704@linuxfoundation.org>
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 17 Dec 2019 12:10:46 +0530
Message-ID: <CA+G9fYtyVeFfOGAPcCPCwDKayFLc2_niPJfi=5-x+hbwHg3UVg@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/140] 4.19.90-stable review
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

On Mon, 16 Dec 2019 at 23:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.90 release.
> There are 140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 18 Dec 2019 17:41:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.90-rc1.gz
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

kernel: 4.19.90-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 9cc8b117a9932aaa067980374b1de1145afc4645
git describe: v4.19.89-140-g9cc8b117a993
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.89-140-g9cc8b117a993

No regressions (compared to build v4.19.89)

No fixes (compared to build v4.19.89)

Ran 22793 total tests in the following environments and test suites.

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
* linux-log-parser
* ltp-containers-tests
* ltp-cve-tests
* ltp-hugetlb-tests
* ltp-mm-tests
* spectre-meltdown-checker-test
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-cpuhotplug-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
