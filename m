Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A478C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 06:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E450B206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 06:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wHdoCC/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfLQG7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 01:59:03 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38263 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfLQG7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 01:59:02 -0500
Received: by mail-lj1-f194.google.com with SMTP id k8so9642831ljh.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 22:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gCXcM3Z6W9NAgGoD2kjwa2E6lbe4ZAp9ODtTpFpt3dQ=;
        b=wHdoCC/h0wg6psEP2+R23RHzaHMOGSxMEOYkmjmH3D4EcnZdgxHDniHTSAM8IwgwK0
         I878YahTYLCNNny/7XuqDgBAjz1usaXHNkOKsD/8PE+EzyOlk1tSGgpzVQf+CZtPVfM2
         WZT0t7DVecRgYpPrkGWvpGfH73VQy6Q4ehTZ1FykPILfQ2zEVLpSxKlBX9HMyy3akaju
         e7ONTKNTzAz4cV7qoiYqfXRE6kdov8s47ZTMWJyOreun+MDgCSZdU78cDz5Z6L61CWKj
         EAkgvndG4y1FvBkVFbdsPJusTrac461vpg0Sm8Apak0dPTVQXD7d/WCeFaYCoRhON6uK
         2Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gCXcM3Z6W9NAgGoD2kjwa2E6lbe4ZAp9ODtTpFpt3dQ=;
        b=EU3Al8Jkz+r6wKvenYTuC1ErybG2KeWzaW37qgf+iNaTM55/4lgFy72lPM6W+XnC3H
         pKN8aD3Lp6093gfmXJC+mdDt7rVyaZj2ZRBDyvE3Un1gUDLrIVfe17ILGIp5A39i//uQ
         nNIW1Fksp2UUtLnpzAQpJaQTjBiMAiL0321f4Uj4AUa+UXZF7pTr/9SxBWup7Szgm9VI
         6/SBTHP8En0bAOC4tv/RKFrk6fxTpJjJQtajLKP7SbpogD2OgHVq5bOjiORZZbwJdv+Q
         JhYuV4ItDzGrofivM7W28d+rZQuGGeox7UKjhdk9iYvk+e5mk7U4FaZO7BGYMWIvimxW
         m4Sw==
X-Gm-Message-State: APjAAAVOXMRlJvCXSJgC2l5IZhJVQCWGDX2itqFeuooQI7sTvlu0Ee1s
        CdIETSt9dT94neAGg6Fc81dG6Id7G2HNgTwJQa6oS/+NEdU=
X-Google-Smtp-Source: APXvYqxxAVMifNBzKSK3bNCGn9iU/1vJhkx8xuXmf6znmTVVbeyqCP86sufC3b0wLUCJ6sbTx1Lu/TAyo3GiQEqMhKo=
X-Received: by 2002:a2e:854c:: with SMTP id u12mr1949721ljj.135.1576565940259;
 Mon, 16 Dec 2019 22:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20191216174806.018988360@linuxfoundation.org>
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 17 Dec 2019 12:28:48 +0530
Message-ID: <CA+G9fYu5hZ43W6N9Kw-my2sB=Kn7rvH5xQs+3z5n_varti3KAQ@mail.gmail.com>
Subject: Re: [PATCH 5.3 000/180] 5.3.17-stable review
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

On Mon, 16 Dec 2019 at 23:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.3.17 release.
> There are 180 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 18 Dec 2019 17:41:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.3.17-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.3.17-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.3.y
git commit: 5770ae7aea0c5937b7ac1e2007f4c04adb0f58d4
git describe: v5.3.16-181-g5770ae7aea0c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.3-oe/bui=
ld/v5.3.16-181-g5770ae7aea0c


No regressions (compared to build v5.3.16)

No fixes (compared to build v5.3.16)

Ran 23086 total tests in the following environments and test suites.

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
* linux-log-parser
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
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
