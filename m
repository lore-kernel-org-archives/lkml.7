Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84699C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C022176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rxp1sZh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfLQO2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:28:41 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40044 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfLQO2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:28:40 -0500
Received: by mail-lj1-f193.google.com with SMTP id u1so302141ljk.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 06:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F8HPujqvxFcV77ysH2tsQiu4oWY4tr7fPjbjFjGXPDs=;
        b=rxp1sZh9Qz80/ywK57Z+LFj3wuXgM3gCAON9FWQpN7Q9JxbSLZsaqkRNp73ph8WC3Z
         CLauEU3X/lca019m9QAg3q+NyWjqTCdVysum3ugCEMJ8Dfkn3hoaMOCalqt7KKO100tn
         lCslB3/TG+/VVL04aYiA6NxiSlNixetm6yiamQPs1DNQ1IUah2qz879Q4FeHNbasPIgj
         XcUsCzdx+VLP70cn13Ooe12hBLtHHg9e3MDw0v4zMg+gP+Rr1yzrJfOixMNmgzuDn1ee
         4Cw3jZ0RUY268LbmDsdH9PsTnKqhcKdcarTVi7r1ZjyQDupAYM9BjLQYyNKAryiiEPWZ
         L5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F8HPujqvxFcV77ysH2tsQiu4oWY4tr7fPjbjFjGXPDs=;
        b=TI4CpQOv1BAr/LApoBHlUla2MY7dZMWdCesb2zqK7XwkryOYLcPtQXjPCsirmWKCqI
         Tf4xmmIFxKnE40oRoL/Xk17v25bpAjrM0oaGhLmgVOxVgto5aezxPJv3Nja2gqHqnCvh
         +OwLxPSBJC55dTmmrTaXNHrdMII5nI6LPPOFxRhOpp8XEpPwf82fYL8RF30LQoR/v4pi
         RcDarFanj4LCR/WNuBQpRcjofeU6uYnEb98G0oVaPJxJRu4vtdcWFzJd9+xgRaCA+W1t
         PTcoc97MfTewM/9VeFWSJxWDYqD6RvblwNY8PV+oCo0fGgk1ZoQjkDsUhR43ZBFNcrlM
         rbbA==
X-Gm-Message-State: APjAAAWj4ew+mfM2nGnluG+cxRt1FZf/69MeqqgrkEHT7X4TYKp0rC5m
        4SW28nV0kaZeGVpj/VKYahSu1V9HtPklWcvWhi04KTuLkTE=
X-Google-Smtp-Source: APXvYqxuV0Ka+crAITk182kukahRjSR+uBkpXzJRRpave7ybb4E87y1B/rGBfVLyPtWaNm1oxAjki8scZYzpyHIa0jA=
X-Received: by 2002:a2e:5357:: with SMTP id t23mr3430618ljd.227.1576592917601;
 Tue, 17 Dec 2019 06:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20191216174848.701533383@linuxfoundation.org> <20191217090548.GA2801817@kroah.com>
In-Reply-To: <20191217090548.GA2801817@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 17 Dec 2019 19:58:25 +0530
Message-ID: <CA+G9fYunRMLr8Fi7S7FTXK1dskE_w10=5XdE7Ew__HDFvHy_2Q@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/267] 4.14.159-stable review
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

On Tue, 17 Dec 2019 at 14:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> There is a -rc2 out now to resolve some reported issues:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.159-rc2.gz

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.159-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 66745e000c837d52e736de131726a861c6ea1ebf
git describe: v4.14.158-268-g66745e000c83
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.158-268-g66745e000c83

No regressions (compared to build v4.14.158)

No fixes (compared to build v4.14.158)

Ran 23039 total tests in the following environments and test suites.

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
* ltp-cve-tests
* spectre-meltdown-checker-test
* ltp-cap_bounds-tests
* ltp-commands-tests
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
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
