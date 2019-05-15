Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6901CC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3582D20818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZqRX0DB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfEOT4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 15:56:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33676 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfEOT4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 15:56:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id w1so952717ljw.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 12:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uawGo0pp4OmePKbkNx2sxcNCeNCfcT4KDWSlS/V5nfE=;
        b=UZqRX0DBmVZ98VRCkQCaZzWygZXcixX7IuKkUdy1kRnSMal3XducHjoWqRAK1h/5No
         hPLcJgtxCaHtlODhOtVQpIaB5UnR+RSXKx5qn9I4DNS9/qTgE7vACJFpQn4WYoE6QfNX
         jWO++73yb3AQZLKio+dTbvpaNlSasCpESYPY3z/fl40jFITRveB5lV4tUcR4SQPDlYVM
         8WT/0cF7+8N0Ni/szAQquAUMEUdGV4IXVk79Wcu0aKCsks1ugOTOw0dicsCPSgcrZPuF
         K93ealeQZ+TyMXhyfQlcy6mTxqMgVlzTY0g26RwMZT98bs/BEfFc6UCIuWEsKCKeTrR3
         S2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uawGo0pp4OmePKbkNx2sxcNCeNCfcT4KDWSlS/V5nfE=;
        b=iuTlIbGoz9d3QE8fbBJcQ81DSNwkQ2hSQBWfXMoHR57NjaeV+pLKvmppR+fwkBA0fX
         t6VhxR6/fIMbz1aMOw8F/JftBNA15+FCGa8Ryu4FjTGuSNkMhAfsD9bAvbkLbMToLGNB
         i3awXYtI67r2iykRAM+3OvbHaOhS9F7oKGIavXjSxyigVQImqfDkpzCf4WrCWgvTswuT
         fDaswm39ZGdhb17EKkHbjYxOBp73iqfNO4Z8rtDkg6/4F9OJHIpEy7sKXWYdeEQidlgJ
         TRII2iaB+HH5RYMQsuYPajwc1Hj7bPCQgL7lK/LBVPvD9jp/QegWfSoioVtQpbSTuQ3p
         jEug==
X-Gm-Message-State: APjAAAWi0j2vO04jZvfLzlFaOpillA6eEV1WS2vSz2i/Y3+CNJmFpoxT
        eGyIggbsVepEhE7br2AHc4gtc7vLb0RTsq2l1GCtXQ==
X-Google-Smtp-Source: APXvYqy8TgyWEnRTbD9W6CoU8NmcSoWphn9ncxVdumlDIxezcPMsJJOd1dYZXJfc/yN6IGuFVPSC4TcWA4pX6x47h+s=
X-Received: by 2002:a2e:309:: with SMTP id 9mr23198480ljd.114.1557950212619;
 Wed, 15 May 2019 12:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190515090616.670410738@linuxfoundation.org>
In-Reply-To: <20190515090616.670410738@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 May 2019 01:26:41 +0530
Message-ID: <CA+G9fYuYYDpNTv9B5Y0uc1hAWfjv08EoUMhLFdOwVr6FQQC6Rw@mail.gmail.com>
Subject: Re: [PATCH 5.1 00/46] 5.1.3-stable review
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

On Wed, 15 May 2019 at 17:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.1.3 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri 17 May 2019 09:04:22 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.1.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.1.3-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.1.y
git commit: 6c9703ae24981e4e4fa32f4e181fdcfc94988591
git describe: v5.1.2-47-g6c9703ae2498
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.1-oe/bui=
ld/v5.1.2-47-g6c9703ae2498

No regressions (compared to build v5.1.2)

No fixes (compared to build v5.1.2)


Ran 19126 total tests in the following environments and test suites.

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
* ltp-fs-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
