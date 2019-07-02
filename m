Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0598C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787AD20663
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q8PZzJ3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfGBPoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:44:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44161 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfGBPoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:44:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so17359212ljc.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 08:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J/Zq9g98WhFnjJ6y9wBnnlW6K7Ygb2l9Rki+bO5sY+I=;
        b=Q8PZzJ3eZS8L9ysfK8C6aSAQh4HfqdNWbqXXILy/RbRM+y7YWs2Iw7KBgd9rkNKoC+
         HxLR7rGe4Iz3iDBYPicAmzpVXipEj74zq0pCzjftJKPn9b1SsdjNDpNKpy7hansSQry0
         FDt+5PL1G2DBHIhXyApvTjr+vaTqBBa/SqYKSAu9+N82t1otddwa9HjHPkhZMgRqHnkY
         9HRJCTh/hZpSjlyoz04GUG06eIbKI1zzPnTgEGZvCmmBZQ/bl7OZcOV7mhHhOSPRYWwl
         m4iOwXGXLClMW3mQ51tl7oDcDm11HjQn82vM/1qG612oQ5G7kW1BCKeXUafGDGguEFQu
         zufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J/Zq9g98WhFnjJ6y9wBnnlW6K7Ygb2l9Rki+bO5sY+I=;
        b=OMD2M6UeNVUSNQtuFLNcKL+yVxP8ddHULixwS0wuHlvWOI52d/t1c4KmusSIblsH5C
         icUL/y25dPGTwI9/AsxkkSJhOsczQnvbu+b3IDFUMu9cCI9AvFDiqYaJfhEZT00QaSON
         0kK89lM/44rykBL3Jql0jZ+mZWeO85lHdLUcEbYpM7f8xDGf+JsSODEBrOePqBjM9vBt
         Cbb9d7+DV+al30ve7QBOfvs5/f+8T88SHEL0IfgT2WkfG1lX9VOBGzYS1EzYFgUb61mi
         N5mLwvjKP+fBgCEcdugVrFaJOY9lxGL/SdkFAoWBj8GNQYVYb0aWOa17ycp+QmKaXf8F
         22zQ==
X-Gm-Message-State: APjAAAWMtXDKSH9zUtE+TyezPHAOVWH8MQy7Qic1Q9wuKtploUVxlMiH
        92LmCFf5gEvcXP6j6wlH9GFxs34rNnT1GYJYIyPGfVMItrA=
X-Google-Smtp-Source: APXvYqxEhb3B1z/H72FVDsDuHgIXwdXzYIWyPbk5VQgwkxwUTrr29cmyE4xym6p4R5jLar9LhfjCRBn3aaLaLsABrpc=
X-Received: by 2002:a2e:b0f0:: with SMTP id h16mr17941985ljl.21.1562082248436;
 Tue, 02 Jul 2019 08:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190702080123.904399496@linuxfoundation.org>
In-Reply-To: <20190702080123.904399496@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 2 Jul 2019 21:13:56 +0530
Message-ID: <CA+G9fYuKoCVAK7C4Urr_LpAb5KNFGusVELUYjVt3PMVU3+=K0w@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/43] 4.14.132-stable review
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

On Tue, 2 Jul 2019 at 13:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.132 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu 04 Jul 2019 07:59:45 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.132-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.132-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 3734933c2330c5fe94ed2724033965b2eb545028
git describe: v4.14.131-44-g3734933c2330
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.131-44-g3734933c2330


No regressions (compared to build v4.14.131)

No fixes (compared to build v4.14.131)


Ran 22541 total tests in the following environments and test suites.

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
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
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
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-timers-tests
* perf
* v4l2-compliance
* libhugetlbfs
* ltp-commands-tests
* ltp-cve-tests
* ltp-math-tests
* ltp-sched-tests
* ltp-syscalls-tests
* network-basic-tests
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
