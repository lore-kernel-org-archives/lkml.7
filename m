Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42939C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 03:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10272217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 03:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kVqmce3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfCMDw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 23:52:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42230 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfCMDwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 23:52:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id v3so229350ljk.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 20:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bkdR30meNw5hMFmdX+iAexPeOCWs/rd4HYQIMU3jV8A=;
        b=kVqmce3z3SHd2zCWUxndAGFhZQFWl0b1PjVpCch2f6QoVpE8tztM93wXb9XtZyfAXN
         4Fr4yYX/Nck8iKG4HSbQePtE+JPx1DKGy4vfu40Y0fo32Yx4rjjnZdrifzAgOTN9LLXL
         o5wVamaCneV3f7wJfgynVkEp1TChe+8l45zjj3HWJ6B65EinuyKkgTpBAPasF7ryBFx1
         rgR1Ktl/18auQywlWRUyQMl8PZDFZK80c+1fKk96unSBegkJcQRwvCIvosLPl0Dfg9ZK
         eLprNcVrAPq8c+5pFM/QDjfjElF2WsgEa6jEaQTs1FyRJLyCmh9mepknEMgHw0WIuIBk
         GOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bkdR30meNw5hMFmdX+iAexPeOCWs/rd4HYQIMU3jV8A=;
        b=bvwi7c1x8y6FRhTathIDyTJSMZuch74cP6/XQziOCALfUNgzGjU09FVdbPegxA4VCE
         e2Gqv1loPmR3rp79hxbq3SvABEN4CLp2YPWilYb+1NASGI4bwGJ6rDUBetbtBl1HXTga
         gD4aTmvwhmEpVYt3c7QI2AFu2/w8W1YzPe/43TE3yWE21vvnGQMRUZ4N9g56VoZaT2RV
         y5ubL+Rbiq8J1bZ6zoptxlxvyeGYTdiKMFd6n2VYFFplXL8TDpSAzsTmXQf5f0ACG5qk
         c3s3UCk7jh7L4+7iEEWzETanWtfdNxJUd0LdPmR3cXWykJ05i4V4pem6m/1mBPJtscFI
         FIAA==
X-Gm-Message-State: APjAAAWW/I93zCSgtXHY+maOXGAHCfWr/fDlPQ+qm/xCJJb87nlUYpum
        hgxDQd/PZ0cVvMGeS+qDo2aRX0Qj8sfFrbtKusFwEvM0RR4=
X-Google-Smtp-Source: APXvYqz5XsEJBEY6f++UuL7sMyuzDCCIRHWAysczQMIUmrfwt6T4QZ+0yUAOkea+oPulONhlRooqlb1F9BJA+hG6MSc=
X-Received: by 2002:a2e:5cc1:: with SMTP id q184mr21396334ljb.123.1552449143514;
 Tue, 12 Mar 2019 20:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190312170341.127810985@linuxfoundation.org>
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 13 Mar 2019 09:22:11 +0530
Message-ID: <CA+G9fYsPE2uKjYvXHR6qPz-SzUrsVTQWVXV3-4AuR1wo8m-=5A@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/135] 4.14.106-stable review
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

On Tue, 12 Mar 2019 at 22:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.106 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Mar 14 17:02:27 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.106-rc1.gz
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

kernel: 4.14.106-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: f881675936ef263f178eab5a5cf95bc86089cf20
git describe: v4.14.105-136-gf881675936ef
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.105-136-gf881675936ef

No regressions (compared to build v4.14.105)

No fixes (compared to build v4.14.105)

Ran 22869 total tests in the following environments and test suites.

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
* boot
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
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
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
