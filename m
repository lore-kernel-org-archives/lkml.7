Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0794AC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 04:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7892082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 04:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xv+GVhJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfEPEie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 00:38:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38129 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfEPEid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 00:38:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id y19so1504678lfy.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 21:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gd4cUjFL8g4A06srBnrmSIZCQVAp7wLeyPycG806AQU=;
        b=xv+GVhJfVR7J3tDJQbZMCt1MOFHKzALLMO/RCxVLj3oH0oQ4LqXRz7YLkHfIHO/5v+
         tip85BW4WEX28G66QH/Itp1rmkRbHOGuhXjLush+IhgpMUw54cDhQ6yOiLwz94a4axCb
         DNHaDjbncuLGG9EjHiWG/ON6k2eHRMspca4Z9dp/E9vSM6i5QVWQAKv2K60I+Zp2rHF3
         pKDQeeJJLqwqatAX6rlHUyc7qAWGGrZ8pUbxAN8J47XfNDer8XGX/yYI/Xz/OjtP+tD9
         WvGyEWtq1pJTAoXLMqStWA2+wL0ivfLlQ8VcGuiuqAy+xc4CJCFG7qdnoPEmOdGfJISB
         RUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gd4cUjFL8g4A06srBnrmSIZCQVAp7wLeyPycG806AQU=;
        b=F7e7nY5iDyOhWTnOo69ifdUxIVm5crajJlPAN3t6Bv2uTe8nl9efExoEKICos+Gx1x
         fIXiyIABNGGmq4/xRa9nWc92/cUiilwdDGLr3+At9IL29EF7bP+UewHpfjF39qYKgl1Z
         LoTB6Bru4/CS5mzn6ni04JB0LVPPZg/oxvubxVjxnN3Vh+kmZvoiBn8lVwTEsvio7OJC
         OtCrrHETP6pUk3adQQoJZ5WlvtuwtDiCjl7dzXaEwxWPZJnQsCKCcP5e+oWA8BzSuDQx
         ph5EWMFBavmsS+SU+huubaHIQj/q21kmWV1Tx7vzGu55xyJKsLwx7ZIUIouObmL3x/Hh
         6wPA==
X-Gm-Message-State: APjAAAXVrdQtdkoq189LQqt8z9q2M8HiKlwgjCrih7fWXuOOG/WAiZWG
        fZihg1kjA8X7GEKz+NKyDiVLEhaQ8MpfIfaTCyNW3g==
X-Google-Smtp-Source: APXvYqzc5vYa/0xR+027E5QOa4Mb3lZt+lgg5KPHnDl6aEZCSqPhbClPo3HNRE1SwtBEBYiJxLN0RdWZJa3fhmgJ6tI=
X-Received: by 2002:a05:6512:309:: with SMTP id t9mr22097210lfp.103.1557981511660;
 Wed, 15 May 2019 21:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190515090652.640988966@linuxfoundation.org>
In-Reply-To: <20190515090652.640988966@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 May 2019 10:08:20 +0530
Message-ID: <CA+G9fYv2=in-jo5jj7g8886mDx_aKOpQK7qFpB0J2dicCapvOw@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/113] 4.19.44-stable review
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

On Wed, 15 May 2019 at 16:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.44 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri 17 May 2019 09:04:35 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.44-rc1.gz
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

kernel: 4.19.44-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: b5001f5eab58fc1a2a3d5dfc90fa9bb513c73d8a
git describe: v4.19.43-114-gb5001f5eab58
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.43-114-gb5001f5eab58


No regressions (compared to build v4.19.43)

No fixes (compared to build v4.19.43)


Ran 23449 total tests in the following environments and test suites.

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
* libgpiod
* libhugetlbfs
* kselftest
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
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
