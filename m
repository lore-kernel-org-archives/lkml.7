Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9840EC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8582158A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZCG9Utv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfK1IoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:44:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42957 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfK1IoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:44:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so19389589lfl.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 00:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1QZ3A4o6jUAyB3PxC5zRpui47YcoCkxIVIayUdZmVu0=;
        b=zZCG9UtvOwZAK1grCKaRzCYHS4KLRdtvuBphwaRPOLSx9Dn8TV16FEngYEvljnTFfm
         mm38rlBvMPSM3w6jVxSbi+aF8Y6hS+NXSKhXUhc1IHvExzVz1XKTTUtKbSaBjxXYAytB
         vxDohzZDHYT4HGbEV996fWwesJY4fAlTEd8wL8JeTRYQRFicH/G6GEod9BWiDeuxe6j5
         HA5UlY5T/PA49/5c1xwqUXoZw9KJr/XAhZ+THXrupALH6Cw88QDN27Fy8btqfpwGPGfK
         QtaSsgtsHK3T+ZxEBOCsVCZzVnycyCjM4Xxb0RrBT3bDHHlxBb3ktbVoXgLv5wvYe2Dv
         TT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1QZ3A4o6jUAyB3PxC5zRpui47YcoCkxIVIayUdZmVu0=;
        b=W7z+dSEfhILS+Dst3wKCCCcyBPhxwJREsrUC3wFtWusYz2+1c5PeEkniL/qIfCk1Y9
         XlPb7PbLdYFe6HZusISMFu3Bqn+MZ1FXHVbUgxPM+pV2WW+inP2TXkrM6TnSpa2NGpm2
         z49uff3Ej0By+llfbwLsUJZ2gpNi55qMemy1T2ntX+793MXOnmVYSQyC7rpjskrD2rhh
         pxnCwUEvzpTB2LD4Z2jiTOIRJ6RxS3YbR3FNW0kwFPhsq3pGuF22taFveFKUYfM2Gb2F
         bCrhv45RmdoB9eo3qN0jCT/SOKYL2au/A+1uxfDTQfi80N2sbvjaNaBBdrlPs+sc1b4k
         5eBg==
X-Gm-Message-State: APjAAAW9W9+lNo8gbD/+Xv9sEMhSC0L+rPOkEKptzrA7Cd51WFP8NEBW
        Yn9Yw9yl/hRtNVEgCjItH9Dzui1KXjBEqq/sGKbRqA==
X-Google-Smtp-Source: APXvYqzXiIowksFeLWLRy3juK5p/6F+2j1PS5lSup6jUcBPDKGziJUD1f+cQUdIxMsaDb/PXZMAfEpj9Si2teDsNiXo=
X-Received: by 2002:ac2:48b6:: with SMTP id u22mr8308593lfg.164.1574930651615;
 Thu, 28 Nov 2019 00:44:11 -0800 (PST)
MIME-Version: 1.0
References: <20191127203000.773542911@linuxfoundation.org>
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 28 Nov 2019 14:14:00 +0530
Message-ID: <CA+G9fYv6LQXD4ZCKgtt_X1R6vXzSOwhrsH7nHoJNhvGY9_YnBA@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/151] 4.9.204-stable review
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

On Thu, 28 Nov 2019 at 02:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.204 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 29 Nov 2019 20:18:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.204-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.204-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 3bbfc6b1c25b08b1e400515f8a2c333a6bdc7f26
git describe: v4.9.203-152-g3bbfc6b1c25b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.203-152-g3bbfc6b1c25b


No regressions (compared to build v4.9.203)

No fixes (compared to build v4.9.203)


Ran 23796 total tests in the following environments and test suites.

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
* linux-log-parser
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
* network-basic-tests
* ltp-fs-tests
* ltp-open-posix-tests
* prep-tmp-disk
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
