Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462E5C468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCCD207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HtcwgU06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbfFJH2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:28:06 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44195 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387920AbfFJH2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:28:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so6922384ljc.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 00:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AEa1FvePR8TjZ5tPsRxQlttPXPZqqsvCq8N8U2/BMvw=;
        b=HtcwgU062b6u+RMDqDvjGg74AJiA9+ynAuFKqphFqFl/JshKhw9MMzPTmOfzMRCzem
         1HrS3tD6d1r+uUzzHzl1jN/eEMcwxSzER/EM2I0OGhlySIbnpWr5i4j0ry2h+UQK0XYB
         UV2cH0EQmVkdMLPX1DueHV9K8zIDOTv9DZOnOu5SuYdcZsNT6xV15huchBnzS2FxNwHL
         LLysgv0x+8vutN+rFP19VAhpRNOrmO98gC/CCGdYIg1Qp9tXmMJ5zYHVh74pXGtIK23/
         HcIofiUB+ZAG4Rhf5Jfu8DJ5Ki5bYqHseuw5HvM3AD9pmvKy4NH5qLkCbfSQso0sz7yR
         k2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AEa1FvePR8TjZ5tPsRxQlttPXPZqqsvCq8N8U2/BMvw=;
        b=fHxxBaKum8T/HIjvmnAOzbX4FlDblpw1/uK1TemsqXBFmaw+HAO5rmyKF2eZ9F6SuJ
         KWkKvPwIEp+rDUS2e0xzrHggBEKus21bpuzvzuNI8rA8r5uZLXzKAMynp+6zDj7RXjC7
         82srCRW9EQUo+EBkQyvhPW9y7oyTRdzlBQK27r3f0R3migpLb8kDY7f9mzF+HDuFw32X
         I+JdRuMgY5kvOZ2LlHDclRhkbECGdpCP73eaBGJMUaEJdY3U/6zMnjzsLm+nWYzdu/np
         Olbpw1d7tPYuxHz13yH2SD4JsYnDIm9iNR+Z2u6xvMlhSnFlSwgaOekpfniUHQ5jLUgh
         Zurw==
X-Gm-Message-State: APjAAAUvRB2lYx+c/9Nkw9SkX1L8YTdq+H/Su/yhY6aa7a8DmSxGnAB1
        iSrw3zwv2kLnMf/l0QZu5LQ72LclVx5HbUj927JBkQ==
X-Google-Smtp-Source: APXvYqwBYt0/vgndwbBN442Oa6LqSSXlPXPKb/oJDcXi16DiDK8SFaZYvjOj65nGlZvGc3NAeTvdGGmw1Q3TRRd3GGs=
X-Received: by 2002:a2e:9192:: with SMTP id f18mr35053516ljg.112.1560151684109;
 Mon, 10 Jun 2019 00:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190609164125.377368385@linuxfoundation.org>
In-Reply-To: <20190609164125.377368385@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 10 Jun 2019 12:57:53 +0530
Message-ID: <CA+G9fYuer7Pf3ZK+8up9_JQ0Vbs+09dwqgs7WC-yxZ-1WmK1Fg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/35] 4.14.125-stable review
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

On Sun, 9 Jun 2019 at 22:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.125 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue 11 Jun 2019 04:40:01 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.125-rc1.gz
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

kernel: 4.14.125-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 396ea3538ca4ce6f760fff7a837e10f2450c5526
git describe: v4.14.123-106-g396ea3538ca4
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.123-106-g396ea3538ca4

No regressions (compared to build v4.14.123)

No fixes (compared to build v4.14.123)

Ran 23749 total tests in the following environments and test suites.

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
* ltp-io-tests
* ltp-ipc-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-commands-tests
* ltp-hugetlb-tests
* ltp-math-tests
* ltp-mm-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
