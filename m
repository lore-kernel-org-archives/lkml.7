Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA301C04AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 06:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B6B217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 06:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLc+uJDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfEAGWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 02:22:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45514 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEAGWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 02:22:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id t11so12422342lfl.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 23:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m6km+JAH0oHG9f5WFZeJdeTpmbOD6ao1KvEKFIQJ73I=;
        b=pLc+uJDG7FQGzTMzpei7yAYfeIP+mHa+IOETuux9xkwKUdM+xxQHB7Vmo6hfCVxnKn
         BRSu5OXLpWZFKMgM98WtDtPp4teWS6vg4S0oISj5MKL4NzC8AhdxyFPOV0NDVfU3s28L
         +/tofEpvWquo4N6yZtddEonPZc1NB6fqPUtWUtmJq+vme+oizOY7vG4vk/8ndQJCM38+
         ujZMxmL9uZ3D/F/bPXFnOMd5Tp5mZzGzcnmJVW00JdrjVR/LXNy/ljMuncpsci/LGQjF
         1Yl/fIgb+tyg8xkUrLO+AIRokOa6gAvbYlHJzI7uSeTKTgJrOalU88t8GO11fgliJMyW
         RBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m6km+JAH0oHG9f5WFZeJdeTpmbOD6ao1KvEKFIQJ73I=;
        b=DDed4w0VnB9ewWQBb2AXHQyJgI2bYKjPPEik8KEzyDusEWP/D7GDja/TZrJgrRbpyK
         BdYeMm2KZ0XQoSGVnPEPNgtAwEa3TWxw7yL94y1dQdaIkq+qOXiHbpkMHkgOFxN1IKWt
         GGWF1rlB9KKtUUVD4qObNqd96sRfMV5EidBl+5khPS5Ysr3EHLsGoAjE5fMoBan1tcjd
         dqsmZD6xSGJypPyYy0R1OiIAv20vjQowmTjHowQ44VYB83x4x50XaZ1I4GFUZgLQHDjQ
         m/UMmBvNsK6CLbsu65lAblDeR3u0VTcxYNXMEVjeTHdATWh2R5wOR8rolb84MODlmcOh
         yzaw==
X-Gm-Message-State: APjAAAW4p0OapNtAgB95SPZUz0Cjru89sZO1T37B4oVkjpZfQkxigAaP
        xCICxYy+W9194jXjMO29rLxppsgkasPMSkQN+HiTqw==
X-Google-Smtp-Source: APXvYqxbhtTaep5uzmtTIGXLxSD68YfPc/jB2jGOHOYVVC16BFl/BaZ8n+y8zFwtEpF4BdbSiR5A8a1oYP4nPkXbKJo=
X-Received: by 2002:ac2:4246:: with SMTP id m6mr5251682lfl.0.1556691725780;
 Tue, 30 Apr 2019 23:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190430113609.741196396@linuxfoundation.org>
In-Reply-To: <20190430113609.741196396@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 1 May 2019 11:51:54 +0530
Message-ID: <CA+G9fYtBzC=OuuUvteiS_bBpudTE=Hhc+-Qe-xCtpfpky65Frg@mail.gmail.com>
Subject: Re: [PATCH 5.0 00/89] 5.0.11-stable review
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

On Tue, 30 Apr 2019 at 17:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.0.11 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu 02 May 2019 11:35:03 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.0.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.0.y
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

kernel: 5.0.11-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.0.y
git commit: 852cce372723872dc1e9f40fef3bcfd2b3215420
git describe: v5.0.10-90-g852cce372723
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.0-oe/bui=
ld/v5.0.10-90-g852cce372723

No regressions (compared to build v5.0.10)

No fixes (compared to build v5.0.10)

Ran 24990 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2600
* kselftest
* libgpiod
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
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
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* ltp-cve-tests
* ltp-fs-tests
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
