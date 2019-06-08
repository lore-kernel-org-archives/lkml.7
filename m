Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F048C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 07:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22464212F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 07:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="riyB48st"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfFHHyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 03:54:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44099 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfFHHyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 03:54:54 -0400
Received: by mail-lf1-f67.google.com with SMTP id r15so3238715lfm.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G7zE5DHgudNt5dsF6CsBxWN91KsOd/Kmfm8hMmncNRg=;
        b=riyB48steJX3fiicN0tXXs2mmIgCpBl0i1kmP1E2/eU7SUd6wdXVieh92yyOu9CX8o
         dih1K2WA/a9JZU5/R891YA/xbXc5qu7f6PRAFY5GxcT3YcBMyPnWcD5f74n2O5ujQUDM
         J3+uCsjD8g6KHhscQrcR53Qv8Y4NcbNyMk9Ff40ZXILfXeADiPFlkjZeUZPhqlUMRdwg
         CHiYJptY6VdECmvlvCGsQdVVZZaxAcNtAjVi2qVm37jvErn29ptXrnor9ykCyDzwyeAv
         aCTe3jPd7AhUIf8mw3Iujnfed83VsXf4s25xSRO+UORoYdatwRpT7OHQZzeQ0odkFffu
         1OFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G7zE5DHgudNt5dsF6CsBxWN91KsOd/Kmfm8hMmncNRg=;
        b=B76MwGfJKOLxqz/Hn382qFTfJXsTXZArvK3dxDcF97A9jO7QCwaNB+ML7AKJENvp5A
         j8M7pCOO9IO65Z9/pndxL+2b3Kft5UB+QIgETSOdrzY0xi3o3mDsO7Iw6mmTcW55a59L
         I0DpyaAgixzp73GdIrBBnE2KdBHI463uzCdHh9gJiYpJgDMffesGP1yMyOZ/UUhINlmu
         D+mz7ye5ys5thZpwGoaDIPnph1XAYfK435WDpkQA9hevn8jPcHFr7guk4SVIF6h3drg/
         AFlreZCJMN9udETyRpitedmT0HDDcbTq643GsTdeVaQZAZVLed4I+z7fCywz3V1qxPxg
         FHbA==
X-Gm-Message-State: APjAAAUOPpZfCaUsJL42CFNO9uiw69JWMn0e4Lyg6icuZUWdJTQ+prLx
        6KwX37Emi8M8lWpVJKpTYTOZpdz+C6r2PwT7qlDjTA==
X-Google-Smtp-Source: APXvYqxva82rvwJJmktaaj7ZhGgKjh2/vkmeE3Rxu3UcDCTnTNG055ZaW/ATHhX4WOpgmQPubEiXFJOBY0rm6ogMa3k=
X-Received: by 2002:ac2:4ace:: with SMTP id m14mr21063196lfp.99.1559980492829;
 Sat, 08 Jun 2019 00:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190607153849.101321647@linuxfoundation.org>
In-Reply-To: <20190607153849.101321647@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 8 Jun 2019 13:24:41 +0530
Message-ID: <CA+G9fYvu0nXEmayFX5CkH8wE+y+6Ya7QmtMCHP7b0sTMKw=brg@mail.gmail.com>
Subject: Re: [PATCH 5.1 00/85] 5.1.8-stable review
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

On Fri, 7 Jun 2019 at 21:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.1.8 release.
> There are 85 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun 09 Jun 2019 03:37:09 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.1.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

NOTE:
selftest sources version updated to 5.1
Following test cases reported pass after upgrade
  kselftest:
    * bpf_test_libbpf.sh
    * bpf_test_select_reuseport
    * bpf_test_tcpbpf_user
    * bpf_test_verifier
    * seccomp_seccomp_bpf
    * timers_set-timer-lat

Few kselftest test cases reported failure and we are investigating.
    * bpf_test_netcnt
    * net_ip_defrag.sh
    * net_xfrm_policy.sh
    * timestamping_txtimestamp.sh
    * tpm2_test_smoke.sh
    * tpm2_test_space.sh
    * ...

LTP version upgrade to 20190517
New test case tgkill03 is an intermittent failure reported on qemu devices.
Following test cases reported failures and we are investigating
    * ioctl_ns05
    * ioctl_ns06
    * aio02
    * acct01

Summary
------------------------------------------------------------------------

kernel: 5.1.8-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.1.y
git commit: cef30fd8e063aacee3601ac8df2c4d1c5980b759
git describe: v5.1.7-86-gcef30fd8e063
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.1-oe/bui=
ld/v5.1.7-86-gcef30fd8e063

No regressions (compared to build v5.1.7)


Fixes (compared to build v5.1.7)
------------------------------------------------------------------------
  kselftest:
    * bpf_test_libbpf.sh
    * bpf_test_select_reuseport
    * bpf_test_tcpbpf_user
    * bpf_test_verifier
    * seccomp_seccomp_bpf
    * timers_set-timer-lat

Ran 16135 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2600
* kselftest
* libgpiod
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
* ltp-timers-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* kvm-unit-tests

--=20
Linaro LKFT
https://lkft.linaro.org
