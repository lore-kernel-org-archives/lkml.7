Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCC4C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7156120716
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T1OAEeYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfLTH7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:59:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34672 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfLTH7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:59:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id z22so4216679ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 23:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5LWA4PQE7gS1mCBR2NDvStJfINrh3qsGURJJxMiT3u4=;
        b=T1OAEeYUJZ5uDfoAaru8+r7aLESYI0S5MYrcTBD1ICORjXg1OFrcqjqTM0SzFpzTSC
         qSNQB7vhcyjdfJdtfCLmGicD4TLnmeL4ApY6+OpVZwbE2IN21klGd8AwjgI5jqGNzUJf
         3B9tjHEzzg9c5RSeMtb9SRi+Z8NOFJEAHXGguO3N830d2zQ4JNXYw+a4C5d3bvpFeQvQ
         FMlOHq9oULFOpHCdNz9/Xcf/vvLldxzayXWYvoIyeARh/w/FfDirS+dPgdHpaXFiUdem
         1A9eswIz1t2tETUs9i8Vzvvv+V1seqdQNemahDImK7nQNuGIk9NJI9aEkOEEu33s+rWp
         sWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5LWA4PQE7gS1mCBR2NDvStJfINrh3qsGURJJxMiT3u4=;
        b=nMsxWJ0/bCHZY6eaFvezsdqXWQGdt+Xm/d2ThmHG2x+1nwY3dOhT99yGni1r2SXLqm
         Z7Lb0x8Yo4eDS7kGSJW8YzRpxLnqd4gcZ5m5hKKsxbCfRufxg9oaYcO8NWeOr8yFZOBn
         IhrPA5171AWNKP1svrnL3s0NP7nB7Nj/oddQYqmCb210sBiggoLqt+r6aKg6cXcfqTMe
         czvdlS0MacfDyzbOgHdU3YTwaR+QC6QU36wwXm7KHN3UXO0vTej3rgod8tJ4VJo5neAP
         bq79ug+D02oqtgH9egagtYbCQPO73701JDrfT2DcEjsySAGosVOZT96tllVJ4XRNbkD8
         PSXA==
X-Gm-Message-State: APjAAAU26n5LNNBJupQaFCUWOJisMbbHP1v6j6OpyRLsHtBpHrYmpIr3
        bvEsxtFjzFiBZffb1ePWp9ls+ZsB9XM9UZhqUsvjYR5AQV0=
X-Google-Smtp-Source: APXvYqw3iLLc7jxcyoPkSv+vzYGrKUJbkhRPfjnMeBSeA8HO9a5U8v4C6p4ql9iQ2Rn/C7n3sgTnjLKF2/YmQC9i4ro=
X-Received: by 2002:a2e:a0c6:: with SMTP id f6mr8712071ljm.46.1576828742070;
 Thu, 19 Dec 2019 23:59:02 -0800 (PST)
MIME-Version: 1.0
References: <20191219183150.477687052@linuxfoundation.org>
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 20 Dec 2019 13:28:50 +0530
Message-ID: <CA+G9fYsnQxo8JPyPv2Zm2Ms0Cf5bT1hqXk3MmZ0p3W5k-a5-4A@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/162] 4.4.207-stable review
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

On Fri, 20 Dec 2019 at 00:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.207 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 21 Dec 2019 18:24:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.207-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
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

kernel: 4.4.207-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 9fe78e96326d85ca140930f72dbce8b198001210
git describe: v4.4.206-163-g9fe78e96326d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.206-163-g9fe78e96326d

No regressions (compared to build v4.4.206)

No fixes (compared to build v4.4.206)

Ran 16802 total tests in the following environments and test suites.

Environments
--------------
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* prep-tmp-disk
* ssuite

Summary
------------------------------------------------------------------------

kernel: 4.4.207-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.207-rc1-hikey-20191219-637
git commit: edc1100c367e3d8ec1489ada9ebd94f1024d0f51
git describe: 4.4.207-rc1-hikey-20191219-637
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.207-rc1-hikey-20191219-637


No regressions (compared to build 4.4.207-rc1-hikey-20191219-636)


No fixes (compared to build 4.4.207-rc1-hikey-20191219-636)

Ran 1566 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance

--=20
Linaro LKFT
https://lkft.linaro.org
