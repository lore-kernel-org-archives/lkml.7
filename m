Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ABEC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 13:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877ED222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 13:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G967Z0wT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgACNnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 08:43:25 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35817 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgACNnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 08:43:25 -0500
Received: by mail-lj1-f196.google.com with SMTP id j1so36534954lja.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 05:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zMerWaeEb4CP775YC6/wAxbdCZHMzy1EkcII8sLrY0A=;
        b=G967Z0wTZu5dz/vv0AWfZCV5mVfdDYg/F6RZPQCLE7djNuINhXXPQcsDpDSKj+P0LG
         nVeW9Ab6Nr4SrlNdPNy/TSLkGjEH8T9ebmqlRS3EYDYgAuOGGNKMnWISB+oRuTsxLx20
         4n6ZDrMah9lD/14jY+CczPuZHOhgKvoTjJr2gTI/lxz+iYqX1KFoacR/yodeWnHW7lZq
         bb/vyjtMJtd9UOTSf1WrXKni4zt0IlhGGUdBa9upQEpVQ5IEJG8qh2XjdNuGHojRceMf
         6YknA+ERjznlM25n7j+08p4skm1gYsI5oWmYZniZgPfEHfJyVQofspnJmrdtKLiFXAJm
         hAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zMerWaeEb4CP775YC6/wAxbdCZHMzy1EkcII8sLrY0A=;
        b=M8J0b8NaGF1a+RrFFjC93CARfXntI96wZ2SzDj2niAHqdua30CdAv+EAngd/XiTeVR
         BFNTA0xoP7dACGqo8tS89mJy08LH1d70LaAryUyl2WdeP+O6PcGqU3i6K9Cq7XLX65kq
         oi6nVVoccDOpN9oIbc9nHK+W2NnF/r6mFBWuPDz9PxXUQJxjdbgESq0b+faKuXjDpVPg
         Vk9s4fcAqZEbvQVihWn+oxoP8wE0GZZiCGk60yWJWO5FNlZWvgoC1PMyVWozTyCyI96z
         n3INUnXmYa96tFgZqSvDEFWthNR4EuFeV0lcjrNhLI21puwmMxLhZfr8UsoNxtkukNIL
         xZ/Q==
X-Gm-Message-State: APjAAAVsNHFGsQQ9M1WYVgUlNCDkW2Bd+sXJTffSINqqF4i/jEiQLV96
        W+YZV7E+jfpkxAWdX8eawc5auKYQszfOCovBVx5fQA==
X-Google-Smtp-Source: APXvYqxDIZ6anbPeXlV6jrCtn2c9dGb/nyHg65sPM0A8dJyOwmsnf7+8UF77dIIWJ0ucZUC6Cl6BibRlZDxZz7mepJE=
X-Received: by 2002:a2e:8316:: with SMTP id a22mr1375788ljh.141.1578059003263;
 Fri, 03 Jan 2020 05:43:23 -0800 (PST)
MIME-Version: 1.0
References: <20200102220356.856162165@linuxfoundation.org> <20200102230518.GA1087@roeck-us.net>
 <20200103001639.GK16372@sasha-vm> <20200103083819.GC831558@kroah.com>
In-Reply-To: <20200103083819.GC831558@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 3 Jan 2020 19:13:11 +0530
Message-ID: <CA+G9fYu4doGffbPfdeemO9HHnxko860E_EeWBvmiyREb0zWgKA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/91] 4.14.162-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

> I've pushed out -rc2 versions with this patch removed now.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.162-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 0e6f77cf689c028a3c0927237bac986deca2c3fd
git describe: v4.14.161-91-g0e6f77cf689c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.161-91-g0e6f77cf689c

No regressions (compared to build v4.14.161)

No fixes (compared to build v4.14.161)

Ran 22654 total tests in the following environments and test suites.

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
* ltp-containers-tests
* ltp-fs-tests
* ltp-cve-tests
* spectre-meltdown-checker-test
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-cpuhotplug-tests
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* v4l2-compliance
* kvm-unit-tests

--=20
Linaro LKFT
https://lkft.linaro.org
