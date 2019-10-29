Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045A4CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 06:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C964420679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 06:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x6H8nr6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbfJ2GVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 02:21:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46216 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfJ2GVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 02:21:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id w8so9414571lji.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 23:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3mjDtFuttkWnacbQtxejyUKqELdseg1f4u1cMomtOQU=;
        b=x6H8nr6RaPjU0pdJ4CmKUdVK6ZL5SLBfcd0R2tv1CQxAF0Yo0jTq9r41P0iD8CYDY2
         4/HL/a+XspY+/FBql+UjpezlJO8jblELv13f5f1M1AQ/aEysQkcfKVKcYRNNSd3RfOzD
         u8RaWq0Ll01ts7CVQ4BMpVR1Iay4f6lW0Km5GYyxcQ4FWRZehBzrN47roEuuvXd1zrhU
         utmgBH1DuFfYBiFgWF32tGKaqykP1L0SEeaKjbOVDd93069DdvP1odQ67jWnIwuf+518
         JePsfRHggeG0stlHsaTLKQZHZPXTdUu7RnnkCDJuM4OoDpn1YSU8r+b4f7YssSSSCO/U
         r8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3mjDtFuttkWnacbQtxejyUKqELdseg1f4u1cMomtOQU=;
        b=BjE/QeuaKPMS6HSrHAIDPVXPDIzJo8bN0TYOpCeZWEMs5eGLFlxho0sJ/M27exrVyv
         nxInQXuIRt0cSTJq5rV6sc7jB9XxsDTI1KJ5Inx+LJkekHWk2l3YbAQSWLPRSEM6Vdib
         Cx1LSxc3OS/5qkyZ1dY36bnksbAYY9l33zP+bc+Fd/aA7UKCBgye8zgM1KIrFhIrqCMa
         qMzPC6elid75CdC1xsGrRE5WNpEzjMeaVS8It1ybM0y3cf3z1cghj3dHarGkrEc/V4TS
         vTLopZdTo/DbPEjW6Yol5ZzwgV00l9Dr0gt9FZ6659UPQcJvcWxGVkNBE56nEq9yFXvu
         hkaA==
X-Gm-Message-State: APjAAAW0QAISMPGXjgEZVCQHRSJJfJJ9o3/Wn4YjFTPLAPN/2+prn9yw
        +QDhTQFlz9l4CNxt0XTgBQVQiCGboOMCJpXphBCLUw==
X-Google-Smtp-Source: APXvYqwJL+KLsfQm4IBRUbyByU7cwJcmEttvyhwfzpWaxoQurPFLYDtWXtVKibJEVkwicul6oWTd4moOAlkjjtXOUXs=
X-Received: by 2002:a05:651c:1ae:: with SMTP id c14mr1021867ljn.135.1572330097959;
 Mon, 28 Oct 2019 23:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191027203251.029297948@linuxfoundation.org>
In-Reply-To: <20191027203251.029297948@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 29 Oct 2019 11:51:26 +0530
Message-ID: <CA+G9fYuA+kLqLo1_ev0=QRvYtMrVhwRvm+QO-tOCVYca2Mt97Q@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/93] 4.19.81-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019 at 02:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.81 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue 29 Oct 2019 08:27:02 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.81-rc1.gz
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

Note:
The new test case  from LTP version upgrade syscalls sync_file_range02 is a=
n
intermittent failure. We are investigating this case.
The listed fixes in the below section are due to LTP upgrade to v20190930.

Summary
------------------------------------------------------------------------

kernel: 4.19.81-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: b74869f752bfa7ad50c55349ee2f0bbd61a45f0c
git describe: v4.19.80-94-gb74869f752bf
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.80-94-gb74869f752bf

No regressions (compared to build v4.19.79-82-g99661e9ccf92)

Fixes (compared to build v4.19.79-82-g99661e9ccf92)
------------------------------------------------------------------------

ltp-syscalls-tests:
    * ioctl_ns05
    * ioctl_ns06
    * ustat02

Ran 20491 total tests in the following environments and test suites.

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
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
