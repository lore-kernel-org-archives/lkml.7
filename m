Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656C0FA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFA62054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4/JOpzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438071AbfJQGW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 02:22:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41906 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbfJQGWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 02:22:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id r2so875592lfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 23:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ry24i9PkQNvKLPORFI92b+pTok+uMbLqLEeRrMBf4MQ=;
        b=A4/JOpzcoLLIKOw/I0ydPCgKBhJKBoHK7y//vL+zmeugX8uIWFZFePqOpZf295SF7g
         LOVjktlXLBbhWixzIToTnK9YgoIyWxtOFE9lXsOXdYBT66TOajo76XFc5MFvoR0GN+us
         OuwYzazs0/vl23EaLIeE/94BXJabrMkXBjirqtVNktukJ7l8IpyfMmvyNIiVc9qK+XBy
         5R6e7aHNMh5pxh9dI9mVL/E1PM79zYaKWn/CfG9/Ef9PIrHTiYKRW5wLClaggVdfH2+8
         fDSut9xEk7tNC3KrmY8/w2UtKFjFy6Awk3I5gx7WvI8jTWyoorKXQx9zV+bbS0zTLmJJ
         lVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ry24i9PkQNvKLPORFI92b+pTok+uMbLqLEeRrMBf4MQ=;
        b=oDk6eWyyFUARlKBI9O2Jj+whELvyKdVS/ZKPj9pZPkha3YGd1OGcFb2JrpTCsnW0a/
         Y3qisR5KryeYpLne1917Pko/f7zYdQrV8ENLPs0+KGGdAP2lPlZJaExLVjpUhG+6Mmsf
         OltEpKGrQJVxspTL/aiHfMtwIL/SSwkspqGrwm4Bl4diBfYlhSup2qfA9bvEGRMvLMp0
         2FoMs5nLMDqnOGPrrgHDMigdrFBM1UUk9PcKF953vMyUMYqUCoEYerWRAnWWuMsJSrpZ
         Z6831kNvnAkLXePXhY9JvO5o0jGMhdgfS4poQHWQF7vcTETyWRw6PJZdCzMh//VFw07A
         /oWQ==
X-Gm-Message-State: APjAAAVolbRRAP+opJ0aZ+b0f8Ti8wZuY5Z3cOy065WCctPIESs6Zpkt
        UFzvNhiOCTijs+P73AAcbSzdorR8aiKCxBDLe3LfZpS6C50=
X-Google-Smtp-Source: APXvYqwADeHq5XuGYwmOqn+IEKns4QKDXr/k3g7934u4wZg5giRDRAMPzGRCOwaDDG1vwyu/d/q+JqG748ktRIKuvyE=
X-Received: by 2002:ac2:4566:: with SMTP id k6mr1064918lfm.132.1571293373792;
 Wed, 16 Oct 2019 23:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191016214756.457746573@linuxfoundation.org>
In-Reply-To: <20191016214756.457746573@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 17 Oct 2019 11:52:42 +0530
Message-ID: <CA+G9fYvwveqUnctZcykmRGea8-5NZmNCt=7SO2ya-U_=smWmQg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/65] 4.14.150-stable review
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

On Thu, 17 Oct 2019 at 03:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.150 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri 18 Oct 2019 09:43:41 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.150-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
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

kernel: 4.14.150-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 66f69184d7229bdf1ac19b8928747553ca3e5914
git describe: v4.14.149-66-g66f69184d722
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.149-66-g66f69184d722


No regressions (compared to build v4.14.149)

No fixes (compared to build v4.14.149)


Ran 23950 total tests in the following environments and test suites.

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
* ltp-timers-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-fs-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
