Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B54ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 20:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B436521835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 20:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ODXUKTq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395495AbfJQUC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 16:02:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40818 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393263AbfJQUC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 16:02:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id 7so3847958ljw.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 13:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uyfTpc4uoGGfUXhiiQ1ULESUjtJAjGktU/a6QTF0Zxk=;
        b=ODXUKTq6gV6Zgod339kE7rlWH0ZnqPl50KwGglJq5xCspeReCHnduUb4AEu3vi4e91
         HiDEvxN6Cea4dbNCmZa5h3CySEQAqwknzeog8qejMsL2mUcmJCtl7aGsCN0L4uwvZ6N5
         o/jhjerrNZxplOaJXZkIT0nHd21x4oqgULlstIPItodHfnnzb37w7EOPg+EOX3p/CKL+
         5VZiP32aIaSqJCHhREt/zwIZsiCwyUbM+7IRJcNWjWbu1oCsscAfFOR/MycSsagKUics
         XCQXUNZyU7MwHpjkrdFWnNu0wNqDO7BelKt9XD2SY8GJmXaahzmZgqxB6eZ2kppDdEHK
         B5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uyfTpc4uoGGfUXhiiQ1ULESUjtJAjGktU/a6QTF0Zxk=;
        b=VFzshWNeyYpXzFm/35riLsIDJ3btYeV8vNGsMSunnWcFu8KlSpG7U5K6l111QF9HnH
         HeYEp+rqoScKIX9Cjhs3NkYTKP1SSaMxjh4YPhcQPYosH5VSQWdl2o+/fO6ytxy3rE2d
         IWF3VEKpkrTIXI+bqgiMi33EhWkFO49uWJGOVI6RcKkX6G/6VJVCYVhLp80/uhIkS2Xf
         kWnRKj/IHxD/GEMDHX02/rodJBJZafWXdLgvsHU/qM+3KiBGouUBvOmOztioP7tQ9C9U
         RwYwQmeBRAT7RJGCxPwHrjiIVEWKJyWYNILXG/OTqpCTwyza9t1ana920YvYq5gmJbjr
         sqUA==
X-Gm-Message-State: APjAAAVSgJvosy9mxBgLitIrr9e6rp95aZ1T1LGczArqhPgcyxOhm0C+
        0q1gthrYN7IglZtnZdBUskh26QEIzOKS1iNJKcwCeg==
X-Google-Smtp-Source: APXvYqz7YfwiA1STU4iQjyXHFbERzSURVwH4loWX5wkYhcI2X5zdovKfhKrbF7BblnhYxlc1K6FFMYSctkyjJv+atac=
X-Received: by 2002:a2e:5354:: with SMTP id t20mr3675619ljd.227.1571342546083;
 Thu, 17 Oct 2019 13:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191016214729.758892904@linuxfoundation.org>
In-Reply-To: <20191016214729.758892904@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 18 Oct 2019 01:32:14 +0530
Message-ID: <CA+G9fYvfDTFpba=XTMvOebUjJO1x3keK_cYiEq_x28OEHnatpw@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/79] 4.4.197-stable review
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

On Thu, 17 Oct 2019 at 03:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.197 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri 18 Oct 2019 09:43:41 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.197-rc1.gz
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

kernel: 4.4.197-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: cb63cd392f388e3874d4bc23b0090c3e137bf22d
git describe: v4.4.196-80-gcb63cd392f38
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.196-80-gcb63cd392f38


No regressions (compared to build v4.4.196)


No fixes (compared to build v4.4.196)

Ran 12991 total tests in the following environments and test suites.

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
* kvm-unit-tests
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
* ltp-timers-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* libhugetlbfs
* install-android-platform-tools-r2600

Summary
------------------------------------------------------------------------

kernel: 4.4.197-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.197-rc1-hikey-20191016-586
git commit: 8ef378ea28b5d306c5655fc0b219b8dc01fb1b3f
git describe: 4.4.197-rc1-hikey-20191016-586
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.197-rc1-hikey-20191016-586


No regressions (compared to build 4.4.197-rc1-hikey-20191016-585)


No fixes (compared to build 4.4.197-rc1-hikey-20191016-585)

Ran 1523 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

Test Suites
-----------
* build
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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance

--=20
Linaro LKFT
https://lkft.linaro.org
