Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4D5C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566EE214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ShxIFflc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKLNY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:24:59 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44633 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfKLNY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:24:59 -0500
Received: by mail-oi1-f193.google.com with SMTP id s71so14727797oih.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 05:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6R1tie6dlOZucxkUVWftPimXFbZ5fDjQVYV/EyvmWpQ=;
        b=ShxIFflcHIEugiaNPzaqsT//Wgk48uuLn47SIdQsMJREwbRmK5zbtE5BZDj8jKvSJC
         lhlG0YsVyAvEGvTnAe+YJ/7/9nMihjLTy14DeMGcYprSQ5447x+iejU5WSupIaBYei1l
         CSVG94FRtjcAj8PMkWDMhQe2efMLeRiDJDvEJ6z1RXWjx6NQmrN593Xtdm11YmVsUY8/
         yulAwlyliCJCq3EfSGG3Y/fjz5J4HpnWJNKRqkg0ZNdSHgQtcM/fkUb3omnrYuAICPXB
         PVxp9KbrQ3dWnJuN4vAR+5LNKQI2+zggoEzX7sYJY4sMpDPsDr+FlebgAU8R2DYnqG4Q
         Xtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6R1tie6dlOZucxkUVWftPimXFbZ5fDjQVYV/EyvmWpQ=;
        b=Ua0Fne7iPLdhS0wvWCObvHcZqm9bWgTK5xLmPLFV31ZrGwadFH0oVZSNyP7504ks1R
         RtwRBlOgYlWJAwBk1k78kBHevPSLUzPienAUfNP2LMihy9TiPF3i85/bI7d3fNv0TGFg
         HvcgCSmxBJv5GK2P7TSTzm0QFkSTtnFCdnPjIlT04MknBvJaE2dU+ksUZYZtJHZeJggj
         7R352CcsonHhX5zxaefS47FvcMUfgBNJ9kfX4vwbLjcxUyid/tEgsEmoXNnrDYjeobuZ
         CJcgmd0Vx3ZjS/K4NZoNneyY92i8amu1tJzKJorjGoQrK0gLVFzVV1j+E1T5BSTSblYr
         vjlg==
X-Gm-Message-State: APjAAAWlm6JyyUSUvVI/5g/EppTlF+NGokpmAqVsGU1ERHkFj+TEsUPV
        xZuAN0CIgIiThI45ghuC8gSm6DQGwmTvXI/7fwLY9A==
X-Google-Smtp-Source: APXvYqwVYKY+TQs2J/Re8zydff/PsMZM6vnyCxUK6VTuAWl6e+TgnAd8Q63nO1R+u5VMFOMIADsyPtVmKkkveERSTsM=
X-Received: by 2002:a05:6808:3a1:: with SMTP id n1mr3842412oie.86.1573565097781;
 Tue, 12 Nov 2019 05:24:57 -0800 (PST)
MIME-Version: 1.0
References: <20191111181331.917659011@linuxfoundation.org> <20191112052759.GB1208865@kroah.com>
In-Reply-To: <20191112052759.GB1208865@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Nov 2019 18:54:46 +0530
Message-ID: <CA+G9fYueMYg=FoGvGBjoNW-rgKqAOWa0a-Ha10Mu2TEaQGX_wg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/65] 4.9.201-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019 at 11:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Nov 11, 2019 at 07:28:00PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.201 release.
> > There are 65 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 13 Nov 2019 18:08:44 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.201-rc1.gz
>
> There is now an -rc2:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.201-rc2.gz

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.201-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: a3a12cc6ffc178797f76cc8e4424477336e09efb
git describe: v4.9.200-65-ga3a12cc6ffc1
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.200-65-ga3a12cc6ffc1

No regressions (compared to build v4.9.200)

No fixes (compared to build v4.9.200)

Ran 23526 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-none
* prep-tmp-disk
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
