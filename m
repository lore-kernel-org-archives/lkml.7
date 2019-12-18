Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D4FC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF362072B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojh4dsnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfLRIB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:01:59 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47055 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfLRIB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:01:58 -0500
Received: by mail-lf1-f68.google.com with SMTP id f15so954605lfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 00:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MBjT2DfCl1YQDiFc2LHryWAga8NQEb+p9ojRnPoDK+A=;
        b=ojh4dsnkUSEJW1/tr7ggIumiK/gSPSZ3M2/p6Lo0Zltk7mPp1ZGrxjplf3FTut0h+O
         6ZaUu9lJaU69yTHpIejSaxexV8b3TyyiHR019uzi7tRqYu+adajeeDoe95L/VJVuAhxW
         WBQmdeQ89HK2Ny45znibASAEk6z6quAtXN4BAPIbCCxLP0hTRkKQ3lQsrkexSnijqH7v
         rrz5ROHQaXdtr1mb7UcE4JyJvjrVK62eG8ulNbFNnhcBjpFzTIqlULFBd37WDfY1qW2f
         SDzk3ypKSvbLsszxXQv1Je52MSIakS2b+JmCRMJ01nGTmOUFXkdi8xBcQOcGY2i8D+f9
         O2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MBjT2DfCl1YQDiFc2LHryWAga8NQEb+p9ojRnPoDK+A=;
        b=na/QtXWnMgeMdkWltDzmCsxrT7CAWA4luMMtLJXV8vca1S9XnXJf8lQIn52YBxjyoT
         zuCw0nLzQfumUOAttHcm0+wEB9/UlU7SDuucGU0qmK1y7gUCCJYpsIY7znAqapr4GF7v
         G5+Xl8apFBn4t2B92Thh0na6LowTXb/ndOanQ/Y1CABLsAypq4+VZ1oZRYLb3/oK3D2N
         z1otI6AeToKI334r91HwRIaBxe5G8ag2iPj2NHh+Gu+XQ/4khZ6Ln76yz4g4OeTc6Eoj
         cDwkmLGajhyW5tuCQbk8uBC0+1FSHoU1QbCj27szXDMIv2al2pu3gCQDl591004Gqq+i
         lwHA==
X-Gm-Message-State: APjAAAWa9nnbGKDYW+HdAMBQ5eTc1ghjIzmcby/APONlRdsgutg/CHc2
        zu6zZMpzBesu1/mpFqLz56OJIAVuIVxeWQK0Eo2e2g==
X-Google-Smtp-Source: APXvYqwhjyTY4pumh/uxn4r02qF7rkOSKr25PxtSobVUM8Djxc8jYxNEfBFVGlQGi4pXtTUsUkmRVndCTBVVcTWHJbU=
X-Received: by 2002:a19:784:: with SMTP id 126mr843014lfh.191.1576656116500;
 Wed, 18 Dec 2019 00:01:56 -0800 (PST)
MIME-Version: 1.0
References: <20191217200903.179327435@linuxfoundation.org>
In-Reply-To: <20191217200903.179327435@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 18 Dec 2019 13:31:44 +0530
Message-ID: <CA+G9fYuFq9VySZFw1mfZEofkaaDS8z8B3a=rzTFT_knwep59-w@mail.gmail.com>
Subject: Re: [PATCH 5.3 00/25] 5.3.18-stable review
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

On Wed, 18 Dec 2019 at 01:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.3.18 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Note, this is the LAST 5.3.y kernel to be released, after this one, it
> will be end-of-life.  You should have moved to the 5.4.y series already
> by now.
>
> Responses should be made by Thu, 19 Dec 2019 20:08:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.3.18-rc1.gz
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

kernel: 5.3.18-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.3.y
git commit: 0763039c48446b647d8619afe0624d6e5c62e4c0
git describe: v5.3.16-216-g0763039c4844
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.3-oe/bui=
ld/v5.3.16-216-g0763039c4844


No regressions (compared to build v5.3.16)


No fixes (compared to build v5.3.16)

Ran 21111 total tests in the following environments and test suites.

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
