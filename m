Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C02C16A69
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAE6217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oGzRJoYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfEVFBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 01:01:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33644 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfEVFBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 01:01:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id x132so647954lfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 22:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jgQD83G/QeoPZseh2qY5Vt6KeEPbXsH7VU5l6EXF03Y=;
        b=oGzRJoYB1NLg2FoSVVswdfhLqWiJVSjHSHNn1gTmtPGWArKRFzrhTeDYjrz5UgGN5b
         Rpj9Iw/7zxx1h02puSU1OhpHLWdk3BE/OL+SvYbSJJzjLpHjen4ZGneR1t9u3xVdoqdy
         Az0p2VwXH6sc6O6b+2EReZQ1741B9KOslCKujJKljicfA7khxTYZSC2gmgo2T1LIy9Zr
         2h3/2p3RSErF5hvOI/OeGeyv8H32JtOsnrZmT9fNvi6OrYj6xs7xokVx1bSv3eUc0Ehn
         rycPeNmtppMsHzgXj2vjCUZtBdMO6hr5kWH/WeN3kZESU20IgTCFi+uatMhDauTussMc
         dk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jgQD83G/QeoPZseh2qY5Vt6KeEPbXsH7VU5l6EXF03Y=;
        b=R1Z54XBbaV9/HhFhM4QNTcBSHMukKdJvUioOONYw+bYjlqnwILERXqDmeMECVsHd5f
         Q9LoVeMjS5k2kNMoII48QonluLLkdmVjPmzRV9Bge9Pm7LVxQRSzGzdK2ivW/TFcMzRP
         fei4T3MmYiooHoSUcXUyIikuYGH6CKfRct/rd7qSrJqs+UPFR1R5vkwZRpaX2iNZcyPL
         QxGXr67RKAmoB/WXKzTNoXDb++dR6E6nmpfdC4skPx9xfC8mnnQmhq0BPdVyhYpMdzQp
         AdMQQGBlGkS8ztcvVc8rSoWaZy5fRWFU1GjNgRIpN0KTcoM3Ji4KP+9c/NjspPElfmR4
         dkWw==
X-Gm-Message-State: APjAAAWZosj6eSjy6IslXMdFbRQnokBQnmhkb6Ge1Whd0T2I8dgqPLSo
        POk4RcaPCnBiMl68g1u6KGv/YbPpRSo/xNetqbhSRw==
X-Google-Smtp-Source: APXvYqwc1yEBMH3CQ/V/isx5Nlb7inSkP5g3CDYTkLT7S5mwIGhVhrOGu7ujkKhucB/VvTQuvPFT2jAVGCilB0ZjQ1M=
X-Received: by 2002:ac2:429a:: with SMTP id m26mr4139132lfh.152.1558501293105;
 Tue, 21 May 2019 22:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190520115245.439864225@linuxfoundation.org>
In-Reply-To: <20190520115245.439864225@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 22 May 2019 10:31:21 +0530
Message-ID: <CA+G9fYsVxmDCQasZ0YOtbTELLZ4j+Ya-9hD5az89ngfKe_kkGA@mail.gmail.com>
Subject: Re: [PATCH 5.0 000/123] 5.0.18-stable review
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

On Mon, 20 May 2019 at 17:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.0.18 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 22 May 2019 11:50:46 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.0.18-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

5.0.18-rc2 report,

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.0.18-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.0.y
git commit: 5eaa7ad66ec7e9d1c3e1ef871ec29a5427d05ca7
git describe: v5.0.17-121-g5eaa7ad66ec7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.0-oe/bui=
ld/v5.0.17-121-g5eaa7ad66ec7


No regressions (compared to build v5.0.17)

No fixes (compared to build v5.0.17)


Ran 21429 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
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
