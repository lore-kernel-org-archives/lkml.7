Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320EEC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D94214AE
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECi1L8Ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfFHTGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 15:06:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36892 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfFHTGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 15:06:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id 131so4541141ljf.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 12:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6i3nMyC0pxX9g9ZOmluPAmte2RCJfloAGvvix4oF/q0=;
        b=ECi1L8Ruwbfw1pB3XA1zxhqSZ1ueXjCteSPPzTn8v4cQYmmWwfSA8tz8CqbhzU9ll5
         CnMQgteRm1jbU7/RyHZAYXk7nE6ys44jCc4FL5cuVH31CvHzW/II/I8CU/ByEMgmTIcN
         I8irHaGR0GMAGF+y2LkHpObSTC3/V4rqSZigKRDk9qoCPsBEZ0LqIjurPXLI+kE+PfMw
         fyXd5FTAxy0gPwxCfAzEFEHnMk8Pl+GHB/nL66yeo8Jl78HipwttuyOOvfwh6SxoP+56
         /bn+7jjaUs5+mlrUakKNynUXfZJrtG7ExZMaN62NdH9wDES9udVYgz7/c69qvMI8rAvQ
         aKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6i3nMyC0pxX9g9ZOmluPAmte2RCJfloAGvvix4oF/q0=;
        b=Y2ZPQ8SPqYkjnjv4D3Zj9ooTmB6MQwdL07E0WeVKvPG7aX0THuucwfJKYhak2HxYoO
         nErd1vy8/rQiclPSn7H7AiU9htqDoc+JZ1P4qEDnLXK4ewrcNsC2oX9MCGqkT/mN35Pz
         MKRBflLFAQrBW+rOdBJlwhJbMz4p1JIFSJvv6l4ZjugbhZIj4FFbOOKj5MgodoQoDWit
         2afUOeRLulRUT1KhyEfMGSkO+z99xXgadKGIzqGFZd5ZXMZIvhAVRpmfs5fPAEdfbVbw
         Xgb74B4ISC1CYcwTvk9nRJZXlcpMGN7Vex1KpyIk0qXpU1M5OpqpKO33SS+SzE8+YpTK
         16pw==
X-Gm-Message-State: APjAAAXGFrkQMGub51ceChxNWZ/32RYVc+HoD89cm1pBdY+SgKrZ7X9m
        T2jaopPve1Q0zDspYQ2h8YwvZFYFkGr8x9wXA81QUQ==
X-Google-Smtp-Source: APXvYqwcT4Jhjjegl2n8+3gFm7MurE3TwNr2KoJch9exVtX4nMBXmEo7aWCQagA0gTh0bKy2VDLiL6abw2BcWLLSrjk=
X-Received: by 2002:a2e:2b11:: with SMTP id q17mr31572451lje.23.1560020794839;
 Sat, 08 Jun 2019 12:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190607153848.271562617@linuxfoundation.org> <20190608093256.GD19832@kroah.com>
In-Reply-To: <20190608093256.GD19832@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 9 Jun 2019 00:36:23 +0530
Message-ID: <CA+G9fYsB52VKE1+z8eJvz-x-Nyq2E7DtOoCw6vJPH_0F7UiXNg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/69] 4.14.124-stable review
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

On Sat, 8 Jun 2019 at 15:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jun 07, 2019 at 05:38:41PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.124 release.
> > There are 69 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun 09 Jun 2019 03:37:08 PM UTC.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.124-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> > and the diffstat can be found below.
>
> -rc2 is out, to hopefully resolve the btrfs 32bit build failure:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.124-rc2.gz

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

NOTE:
selftest sources version updated to 5.1
Following test cases reported pass after upgrade
  kselftest:
    * bpf_test_libbpf.sh
    * net_ip_defrag.sh
Few kselftest test cases reported failure and we are investigating.

LTP version upgrade to 20190517

Summary
------------------------------------------------------------------------

kernel: 4.14.124-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 396e28a10fffc503c28b113c1e867b8e3684a98a
git describe: v4.14.123-70-g396e28a10fff
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.123-70-g396e28a10fff

No regressions (compared to build v4.14.123)

Fixes (compared to build v4.14.123)
------------------------------------------------------------------------
  kselftest:
    * bpf_test_libbpf.sh
    * net_ip_defrag.sh

Ran 22140 total tests in the following environments and test suites.

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
* network-basic-tests
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
