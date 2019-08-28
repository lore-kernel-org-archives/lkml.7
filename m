Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AFDC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 04:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472C722DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 04:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bu7mC2+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfH1E5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 00:57:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33867 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfH1E5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 00:57:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id z21so957150lfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 21:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aF4vQQPAnM4wrO+hnAOdMHydtR2sgfwjhXFlqwAQKCo=;
        b=bu7mC2+faFWXe7ElbzYXC4F9BGrzhPTjTuR5R7atmVRuixXcXQIMK55jJdglGZGarv
         p3bSO7Hh5vLAQSLwHeSMxNz5I7Z0C3hQcMlQfKqUdbeqSGt7LpTAHXrR9RlIlCiOr+fE
         PCwHLSCO0sxawbCZI25fCHmWj4Rx48rFFtfW9zSEovtRponYsT7lAqiRZxtr/LGnyBIx
         TQEKklWPkFPvIMJKrcggzitO44CHJjW8A20jc7rORk+bgtPGsYKRlQrdnWMefHdE5bD6
         dN1lCPVxa8T+kBfFtAE5AHAO+QkV3AeDxc5mMwCyQ8tpQNndQjFdaIMcKtp137RRKUVW
         w2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aF4vQQPAnM4wrO+hnAOdMHydtR2sgfwjhXFlqwAQKCo=;
        b=RP7nqnKsPz6bQaMXS0fGoWfy9B5oMZ5rPzES9rrQQ8MMgMpV/ckd4ZrWXdmOpwXBOY
         CBDc6R+T3J5r3Kax3rLMg7Lic6Q0mIjT+sTJO2iJS7aE6jckF+MPW13lEoYc6XOQ0WVy
         JNNV5/y/ykabctSJTAibY3zV8FqMJzoBI4pMM8dwz5AOVl+Aeu2XsJV8vNaCCI8SUlNC
         GxXVch2l/Mh1RKDupVFgw1URQJk12/pwJzWjPFeRbPbPWagKi4KHwnVCN6beXtLoZYXm
         ePeeiD7OlyLqTSfpTTPrWAnwkoJSAIUmb1hvEct3Sqq9sOveddZw6DhxWL5C2tiVMMAh
         Rhmg==
X-Gm-Message-State: APjAAAV8JagpgvXn2zbF//puM9GRWbJN6OkpFRKExAF1ven1dvbY9fY7
        whYNXEjYS2ros9nSjNJ48+H/zHashD4oCl1JMTSixQ==
X-Google-Smtp-Source: APXvYqyFtKMBWetyIy6MzY35Sbc8VdpSv3o36q0twIoF8bsBySzZ01qszD/vrbc1VjBzQG3EiqsQkR1R6wZKUPVSRjM=
X-Received: by 2002:a19:ef05:: with SMTP id n5mr1242292lfh.192.1566968229010;
 Tue, 27 Aug 2019 21:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190827072718.142728620@linuxfoundation.org>
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Aug 2019 10:26:57 +0530
Message-ID: <CA+G9fYsnw6XNbGKbAXNq662p2RiwtMH7O+yDLXz1pD6B7iDNLw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/98] 4.19.69-stable review
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

On Tue, 27 Aug 2019 at 13:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.69 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu 29 Aug 2019 07:25:02 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.69-rc1.gz
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

kernel: 4.19.69-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: e944704d5a79f6d6506a872edebd16e2b93cb349
git describe: v4.19.68-99-ge944704d5a79
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.68-99-ge944704d5a79


No regressions (compared to build v4.19.67-86-gdef4c11b3131)


No fixes (compared to build v4.19.67-86-gdef4c11b3131)

Ran 25199 total tests in the following environments and test suites.

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
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
