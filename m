Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6EEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 05:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CA020896
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 05:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nM5cG90Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfCWFad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 01:30:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41139 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfCWFac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 01:30:32 -0400
Received: by mail-lf1-f66.google.com with SMTP id 10so2753292lfr.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BmFECq+EM/+w9ef+AsBy3Q1da6klIWxYz8En6bwGT0k=;
        b=nM5cG90Qdw3iSaxOVuqrWWr9sTGS2Qjr7A1+xwpxyHdPxf11LG2Cl/y1FUiRghwRgx
         Aer3o9MaO/TGreh6nd442VTx2GTu6fFgNTZqlx9NyFtutPyc7JYrwalkADlF6GpzjbWN
         GTpGjHm3I9pV3eQNtXedHee2kFGfdkNzmTwUUlAvO1JUUv6nb7HwnHTJxBXR9eT57516
         /8vcKowbvXlJugNvTszfWvorLRqUt8B1qEVnlHGljtAMI3Lt/GivL2lUmEM9hB9dkghK
         /vr19YGNVbelL+EZET+GlJw2QsLFOasszv2HivcofdZcPRvdMnGl2NTkhe+Vl34v99MD
         5SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BmFECq+EM/+w9ef+AsBy3Q1da6klIWxYz8En6bwGT0k=;
        b=L5F2n6aRt4CIEZNlUEGFsCmEDoaHfGSYNhPDtKrMCHQA1zF0xiq1y5dSuEs83eTSC+
         GITi99LyQyqnfA0xrX2HSHtfZ+ACT/cGUx5+w3+lYQxKXjwWCANbErGLQX5nOuGE3w9+
         gPgQHcbsgNQeMtuIopjkOSAvpCoVhrcfNymgWaWaHec7uSEkzkRLRMwXVRg1oZUn1dlY
         KcF+DYGzR7XFWgF104sN5s7nG0AreKwSsgeJ1D0883V5KDzJCEm7joNdpHKtuGCzSG+H
         90df4ijA0DktwxY//3dprH2nHU5DgIKDsHxveAG6829PhAu8pjmnuqRnrgfxXKh9ppXR
         Na3Q==
X-Gm-Message-State: APjAAAXb9UFFD9zZnbK+r59wr3oAGk/SupAkV2JgiJOB048kGDvas/iO
        PCcqUo/LcXgJ28Vf23kKsEgYEvn+dcEaq39clllw8g==
X-Google-Smtp-Source: APXvYqwCcOdjpQ+E7gbva3LbXVvrQ5aBOW470j8IndOX6LNbAOyROnxI5sgt5ajap0Q5pqERVVyO2B862f5ECo583CY=
X-Received: by 2002:a19:ef19:: with SMTP id n25mr7453874lfh.0.1553319030648;
 Fri, 22 Mar 2019 22:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190322111215.873964544@linuxfoundation.org>
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 23 Mar 2019 11:00:19 +0530
Message-ID: <CA+G9fYv+TDdQfaj0_kGDZhWy2Oi+PbR2cSepFtKSJ4NfWkXr1Q@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/118] 4.9.165-stable review
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

On Fri, 22 Mar 2019 at 17:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.165 release.
> There are 118 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Mar 24 11:11:02 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.165-rc1.gz
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

Summary
------------------------------------------------------------------------

kernel: 4.9.165-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 7d2ac480f8d77207af9d191a51f9ae2036117da4
git describe: v4.9.164-119-g7d2ac480f8d7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.164-119-g7d2ac480f8d7


No regressions (compared to build v4.9.164)


No fixes (compared to build v4.9.164)

Ran 22660 total tests in the following environments and test suites.

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
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
