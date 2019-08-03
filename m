Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3456DC31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 05:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009AC2087C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 05:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVbfHyod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfHCFnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 01:43:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44525 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfHCFnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 01:43:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id v16so526687lfg.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 22:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gphf7jUqGLSt+fSw33wEgpVXiIORRB25dEwThP6m/hY=;
        b=FVbfHyod4pOR4+BNaq3xCKxsQwwXBzsjlR+gLEBIBo9Jd2ieTuaA3iRKofgSSVLUhv
         e0F653A6qnX1zisgrIlIJ/LlLg35ojuJA2VEHA28O2tnDuZgxmjfvU1lqYeba9Has/iB
         d2Sk81m0HReZ850Bmc/LbKw9X2jJ1Gf9noYckAbXrvWXN0HNlpTCVgLrLn7vKrUZXdGl
         U64uYSTidyogMskvU0h78u0tOar8TjyinrNZYN4xYj+utOAo1JRvdC0E8bO79AdVzt5V
         4HSFMHhoTBH9gfMhH611J4nhZaeM9wJ5ozqvh2cutyKgdDNQp89u/YcqfwbIUtwjAeZ5
         tKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gphf7jUqGLSt+fSw33wEgpVXiIORRB25dEwThP6m/hY=;
        b=LRlH5uFUs45Aon29j2OvV4WgbXJDP3ulwI7RLb8f4eBnfL4ZPaHNhSnlVbLTNocGwp
         l+R6f/hiaXRgq6OY2HUIbgiyJK+XmJe2cS3pgagglqn1KIZiN9YrN1SGRX44H3OfjITm
         BVvN2YsCoeOLM4ACSwNxZEqEW4mCKHQ6OASna7oQLTP/FBSOK/h8XUHpmKIeHIfxrP51
         OV1d+P/oZDYrEZf2WcvFz+LQM4xwysJKQQQDAnHIWHSGcbuqKiyqJsZVASPpAt31+yKL
         vONvVjue9/AEzziyk3hfxj4Gdr1lcblp6XsmL8NBbFQxFbdbGx+f9Y4XBWvPo31uYz5x
         t1sw==
X-Gm-Message-State: APjAAAVfBX9dHRe5q5Ojp1GfRwIVJtjbNbAWABt8KL7Zq1KNruw2HjC+
        7QcR8znJ93vOr/AEjLjNVabDGLKvNxs7V27cc5vT2g==
X-Google-Smtp-Source: APXvYqy209SeKHqOiZFKU13/MjmarmFuhOy63k8G6bEAxZQvN8YKc+5e76w/klFocL3xLiR3ugf+5BfI7j3PTRrnaTU=
X-Received: by 2002:a05:6512:51c:: with SMTP id o28mr231727lfb.67.1564811019438;
 Fri, 02 Aug 2019 22:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190802092058.428079740@linuxfoundation.org> <20190802155020.GA28265@kroah.com>
In-Reply-To: <20190802155020.GA28265@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 3 Aug 2019 11:13:26 +0530
Message-ID: <CA+G9fYvJcZgZaNW3v_Uc+5r-V_Lfp88iMAVTGHhm9HadwYh=vg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/25] 4.14.136-stable review
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

On Fri, 2 Aug 2019 at 21:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 02, 2019 at 11:39:32AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.136 release.
> > There are 25 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun 04 Aug 2019 09:19:34 AM UTC.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.136-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> > and the diffstat can be found below.
>
> -rc2 is out to match up with the failure of one patch to apply, and the
> ip tunnel patch added.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.136-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 8c06cc9d417294ee552cee5025f8dad9a982a026
git describe: v4.14.134-319-g8c06cc9d4172
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.134-319-g8c06cc9d4172

No regressions (compared to build v4.14.134)

No fixes (compared to build v4.14.134)

Ran 23868 total tests in the following environments and test suites.

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
* ltp-ipc-tests
* ltp-timers-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
