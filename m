Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1E2C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEC62166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hC+wXI/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfGIEYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 00:24:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41215 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfGIEYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:24:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id d24so9021952ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 21:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eTsII2jVWy/TWAPD/cCi3Eg6y30l0Z/PSexrTql7jxQ=;
        b=hC+wXI/lLxGTOmeLNJ4qUh4ECbXN9maYRNa2x8/yH1UYeSR2kgJbIEaVQ0Rd8L97Dq
         hEQnQ2oDtcwLzfM4mzd5VPwQZP+y5WhjIAvqwaJNfEix8NdBfpVoTU1t+ml2dNuJy9ND
         xV55758j+rlmarpl+BDWztRA6Cbxco+mBwzuMtu/P1hJuUfwiPkk6GlHqZ9b8rRgx/a/
         k7acGkhimhNgTI24ALTi812SLKFdxD/akaoeQ3YB4rf701vj4CeWBCKveEoNqQ//tCXi
         onNCYnovXZmyOP1y0a8b2Gty09cbHCJfEp/Rn20zcyIw3PsL7TOmMO5x1S6G6at/dr8D
         wwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eTsII2jVWy/TWAPD/cCi3Eg6y30l0Z/PSexrTql7jxQ=;
        b=VxYqNmQCLvpwltOdNjNvw9NEu8P0QnBtuSu/92rotgjtlK3wGkhpxA9SGMDB3yiYPK
         8iB6VjgNZ814A+ds0ELar6/4Pd/pZqKC03ITD6h8izOI8EHfOHQfYr2A8ncrGvuSonHE
         iEg3dsIWbOtfnUSPzqJepRFjTQPPdqxUf1+1MFl/vulmNI3vJdMmIdMgQZqub9Y0lrFE
         H8py9efJ7hIkmaKYrvPgF6DW0/vrpEVMcx0o3RNLs7dYT08Ogc4OgCj3g+66EX/3zZYr
         g2/jvfAopT3V9lOQ4rzzXIFgZ0+Ky6Dk9K4YgJjjKLsNn/u/NdPukOwmHZCWir/CTcJr
         SwFA==
X-Gm-Message-State: APjAAAXOYhSoEuRLX6OBNpah5sWwNR38dvi1JDNwovOGwlCn4ronT5vh
        9AWIIJEezthKNhMQpvSCYSfemZUPymTDVfgYygbeiQ==
X-Google-Smtp-Source: APXvYqxjXGKgol7YMUcuTeCWhNVhckQpTJsS9ttDgYVse54cyLDzvhBQTa2fOf9DV0Nmn3RaihyvK1C3uOxJwsCCPYg=
X-Received: by 2002:a2e:9b4a:: with SMTP id o10mr12703909ljj.137.1562646279974;
 Mon, 08 Jul 2019 21:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190708150521.829733162@linuxfoundation.org>
In-Reply-To: <20190708150521.829733162@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 9 Jul 2019 09:54:28 +0530
Message-ID: <CA+G9fYutQ2tmskCf=h27VQA_LBE+4tv7B0TXkPxXkL_30ivfdA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/90] 4.19.58-stable review
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

On Mon, 8 Jul 2019 at 20:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.58 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 10 Jul 2019 03:03:52 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.58-rc1.gz
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

kernel: 4.19.58-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: c4064b6569551279bd81da840126527a77b0ad20
git describe: v4.19.57-91-gc4064b656955
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.57-91-gc4064b656955


No regressions (compared to build v4.19.57)

No fixes (compared to build v4.19.57)

Ran 24004 total tests in the following environments and test suites.

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
* ltp-containers-tests
* ltp-dio-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
