Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD81EC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05472054F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FpKO+rhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfIRNzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:55:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43430 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbfIRNzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:55:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id d5so7311246lja.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 06:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tNLvCJD8JwcCMK7I1v+h5eHmlGilLzYiGQKoWxXRw+I=;
        b=FpKO+rhM7RZkTbnbXB3cUCmrK8DBfBUTTWS1QVC7DLLpTIBsE5lEe1fnh0vJStLSbm
         +om4dvdgpmmZeSV5GPmsft+g3FqFrCh//a9HER0KxkUmjYPGtPDXtRUzjgEQzyXoTTMf
         X9hEPVZ3fM1HtAG4XJg+JloeeVheTbkUcUWKpb6Al9iNRhWpA//uRvb2mEzlmasBAYBU
         bqOCF/4smDqFtkPm0fFR5UZv5/TquKMnDK0lr9NtWtFjTYPSbKs/FHEdM+OhhOqcp9rp
         7fIZ2/GN4Cq55WRCfH3MTIN6scTZRdTK5xPDNmDk9jbC+6nt9+q63LYlM33WCcU2FSYt
         E+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tNLvCJD8JwcCMK7I1v+h5eHmlGilLzYiGQKoWxXRw+I=;
        b=CURGmIfZ9AIIm15Kok2POUMrHaaeUWUjrtSgEVweeRQBCPIGWt48z6y2f7NpLhSeIk
         02HLFBYVDj/7ck7ZihraHEQtrcoJjWHhBTxWTNbG0nMGR31lReDaBUc2cml70Zho/DXm
         Fyrbk3XASNa0lgm0qTQw6mJL+7It+EaCRitwaqI/uFD0gkRKnoVbYv92ljP9aqTNOfun
         ofkEq8Je9mmh/1mn1QYTItR/A6MiYUO6Ifl4r4l548qpDqK0FXGzWt6NKzxmaqsKIKx0
         x0BJyHm7WfTcIMCtGQo60FvU5wEjqdhac6+mv4jOz2ESkKRQm6ibcxhLuJBgDFgxIgc7
         vkyg==
X-Gm-Message-State: APjAAAWySOb6kx8h7djQ8wJcZizxZ/ASVqUFWz3ynBomYqB0uH6O6Hga
        jw1piCQ60q/I1V6gN0vU2Ap0AT9Xpx+zQAhMOFkBoA==
X-Google-Smtp-Source: APXvYqzKch4BK+EEAj9RkXabpSdJ2+4z3t02KRTSdQzxTzvZq7iGg1rXeGAx74Bd4Davhz9rAEV7rfO6zH+4HRy56M4=
X-Received: by 2002:a05:651c:150:: with SMTP id c16mr2344011ljd.224.1568814944322;
 Wed, 18 Sep 2019 06:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190918061222.854132812@linuxfoundation.org>
In-Reply-To: <20190918061222.854132812@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 18 Sep 2019 19:25:33 +0530
Message-ID: <CA+G9fYuMwOT+f40RNokrnVgwQZzN3u1D3y_dK3QHMdDJ8sFxiA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/45] 4.14.145-stable review
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

On Wed, 18 Sep 2019 at 11:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.145 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri 20 Sep 2019 06:09:47 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.145-rc1.gz
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

kernel: 4.14.145-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 187d767985cf878208592ce3ca667e5021abf2f6
git describe: v4.14.144-46-g187d767985cf
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.144-46-g187d767985cf

No regressions (compared to build v4.14.144)

No fixes (compared to build v4.14.144)

Ran 23713 total tests in the following environments and test suites.

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
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-mm-tests
* spectre-meltdown-checker-test
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-cpuhotplug-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
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
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
