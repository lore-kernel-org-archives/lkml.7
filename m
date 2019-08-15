Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC7AC32753
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 01:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352A121851
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 01:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x5cDEOck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbfHOBfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 21:35:00 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41680 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfHOBe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 21:34:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id m24so862342ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 18:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I/Lae0s6pRU9TOD7qKwN2gmC/P7ae32u3Ng8m35B8oU=;
        b=x5cDEOckgk7/krK5Nj6zbpYyo9OD4uimfEX+R1EfKqtRXaV8f/UdfkVh08UIS3MBec
         zNy5kFIVvVZ/y/pxgEIItW9SrDjJw/lWcigKBwC2G/ylryacBLpC/IxI8t2kokel04Lg
         QGHeJ+F7CKs+0jc6Mju00YRp2KHTXjsDeUDv2TW125Z3611TveKrGVdFYW/lKO0NuFQX
         kJN4HsThdoXO3XjZDSxK37uLnFLx3gXL5f2duUrhq+qKqYEHp3iip0qfyVrvgYDQFTkz
         pAnOMaP7gDUIEbnJ98HGwyG8IPI3CTIhjIrhUNL/7YGsr9K4FCeh9kI1gm2yXH4NNjoC
         16gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I/Lae0s6pRU9TOD7qKwN2gmC/P7ae32u3Ng8m35B8oU=;
        b=Y1y2wEncgcsW9iiv7A32SxDaqr9Yn9uN8HlqDg3wMdtICZ7DIfkC0+bgSxQuxPGaKy
         JEDtQF10i8uPXK6mszBAzNxQLuvxd1fjI6fYYLX4m9qIiV82tx70paNBqK0YV6QkhcOS
         2FW12EkZwobgD+6JIhGOhy2UuNXFHbPPeUC+FSghE/kbZjBdCJVqYxQbSF0webOyvwcE
         6WxipW3cJAaOcnPcqtlar2I7nCOkMwFEQ61pJsjhl++ls6zbShWluFXpntHQGXZT2gVH
         /o3jQ9kZMc/9lMs4Ai8OWgqYJaaORkKeasWc4QB3O4742bzxem1jDo0Xvs2VTVbL6wPh
         UGMQ==
X-Gm-Message-State: APjAAAVc6sW4Qw0NpPAriE9x/au+ZxX5dx4EFB+lyDEjoYUpAXFEPy0K
        04UNeqttGhE4OsS3ghx+A53qeJQwSAlVGi+3Avfvl/4ewb4=
X-Google-Smtp-Source: APXvYqy2V4nJ8XrtHdhvj/eYl7EHAFOKqAkY30ezTPIXede0JuXPhan28tqrsiZoRAIfe0/oeIBXKtmXLq73TRPNjYk=
X-Received: by 2002:a2e:8559:: with SMTP id u25mr1311647ljj.224.1565832897436;
 Wed, 14 Aug 2019 18:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190814165759.466811854@linuxfoundation.org>
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 15 Aug 2019 07:04:45 +0530
Message-ID: <CA+G9fYuTC_TWJVD4mug6UdrmNwK59uZAbUYT4zLETvcjZpr0VA@mail.gmail.com>
Subject: Re: [PATCH 5.2 000/144] 5.2.9-stable review
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

On Wed, 14 Aug 2019 at 22:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.2.9 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri 16 Aug 2019 04:55:34 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.2.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.2.y
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

kernel: 5.2.9-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.2.y
git commit: 2440e485aeda5f36eaf2050eb1bb61be46275b39
git describe: v5.2.8-145-g2440e485aeda
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.2-oe/bui=
ld/v5.2.8-145-g2440e485aeda


No regressions (compared to build v5.2.8)


No fixes (compared to build v5.2.8)

Ran 22959 total tests in the following environments and test suites.

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
* ltp-securebits-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-sched-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* ltp-fs-tests
* ltp-open-posix-tests
* network-basic-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
