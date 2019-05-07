Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D47C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C142221530
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2xltNsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfEGHS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 03:18:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44923 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfEGHS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 03:18:58 -0400
Received: by mail-lf1-f67.google.com with SMTP id n134so9185851lfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 00:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KxOzBwPrI0UyBHLvYuriVgankKTqtmmygLFMUywfJls=;
        b=p2xltNsNDXGvw+JGUxGVnky4G2BbNoahQl6zgnbmLnSuzGmldBHdQggte0R+qb8me5
         iQuderc8CF4oFhQbOcrakU8/JUaHnMmihV53mZOV9lMO/zdFtPg3nAZFnQ6ycJvXOkRb
         F50/mnpG7nY/FlgEI2sxockt2w84gSjjAf7XILpd7AEplQa2IfnzwbkFe7WagIOhODBV
         hUL9iWXETlCtVzPQM1IiW4gQw1Uikdyc+aSyOdk6PxIAL/F6W1ePZ6bZ5EvhRxOyf4+H
         JoE6i4VivIjBSKKjV9jz3ced0r/0Y79N7mB4Ju6yN25m2gTj1UG6YEb0nMMIq0WCTgL8
         W4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KxOzBwPrI0UyBHLvYuriVgankKTqtmmygLFMUywfJls=;
        b=jKqUU9lFqef0YjRONHS8b68Z5WehneC8vI9HT6xYFtRw6r90MF0wD5XnfN2Yc0dFxx
         gB7gvDJGrjj1J3sSUyAnvDKmp9Q61XXXcdJAGFJ6rS/EZaZRO/Wi3epPaJc9BEBI0qYX
         tPHzxcZTKD1jjqOCUTov/nDp8r/aDNLu8pj9/NUs16SxLJ9teBGNZfZDLVCBQLG6Q0oB
         qTnDvsj3qa/yagaoM/pC65dkWUsbOl4E0oSO6FICedfwsgZTOOMnOKfs2qU7YuYB0ehU
         BZawTpA24bx/4c64qtaEuUNaesqC7S1pis5MQ/ld0rhuDh9SMYGm7TysVjm0W0FHSHQi
         2KBA==
X-Gm-Message-State: APjAAAXVj5rgMzjbmzPqVjvKScaB6fkg6XdxDsoisRafedxqNCXPsl47
        LMQZCBBAIhccLFZHG7BFBrmUa8CAj2b7APCr/xgD8A==
X-Google-Smtp-Source: APXvYqymcjyu44lBADWsOxMfSm1VDEWO/uT9+PCI5Cb3Aen9oAJIj+02t297YXdJb4zvR6zgHdqDFOI+a9YWDqvWS0k=
X-Received: by 2002:ac2:4246:: with SMTP id m6mr10253557lfl.0.1557213536734;
 Tue, 07 May 2019 00:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190506143054.670334917@linuxfoundation.org>
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 May 2019 12:48:45 +0530
Message-ID: <CA+G9fYsQhu8=23c0zNPKuDxOxJuwCesNYZikEtMztUBYy30u1w@mail.gmail.com>
Subject: Re: [PATCH 5.0 000/122] 5.0.14-stable review
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

On Mon, 6 May 2019 at 20:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.0.14 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 08 May 2019 02:29:09 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.0.14-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.0.14-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.0.y
git commit: 5b4a1a11a18cf15168a00c41c55384b2558cdee0
git describe: v5.0.13-123-g5b4a1a11a18c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.0-oe/bui=
ld/v5.0.13-123-g5b4a1a11a18c


No regressions (compared to build v5.0.13)

No fixes (compared to build v5.0.13)


Ran 25048 total tests in the following environments and test suites.

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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
