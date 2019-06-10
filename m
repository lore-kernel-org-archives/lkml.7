Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA449C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CF2208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AhIJOmo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbfFJIJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:09:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33522 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388261AbfFJIJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:09:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so1164977ljg.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D6Vo0jYDgz9b+B/vaMJxf3BWXy1OdUl04IFIbufzB6s=;
        b=AhIJOmo3qN67WX//EruiLtjjqLpKkJpkzeNfLEmup2ypZYmrd3xOXeE4zRTGdoUwoh
         psu0LcbTUDqGL80W/icWRJhBlKenT9nHB2PPmODB3QuwYLCaVGSfeXXYccYs08s4E1ii
         HIkpQwOpKU8CQQE4zJbK+Gkbuz/Xs62hqsl/PP3ZWORV+xC5TXSL2h+PYdHa9RKXzaeW
         1DgjXJ/1jc9iY1hG1+qmS85MSt8pvAQYjoEK3lsr/JLWeIgQc24HPLh1f2pCF7epooBt
         YgCV2nP2LlszoKghzwlE5p9t/rm6fGxsmHnU+dUlCkiOX9QXxf7BVOmB0aApmjLMPniQ
         PJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D6Vo0jYDgz9b+B/vaMJxf3BWXy1OdUl04IFIbufzB6s=;
        b=DFe5Lnf8a6DESy8WO7vVl54EPZEVWSMWQ5s65INCqtB9c8VUuZ+pSgoQbeQMoEiMg4
         XQ6PVVHQ0O7u6CpLsgqooRqwDc54f0Pzl33P3TrzrF+FIjp7P9HgmKpRurLugHxO3EIk
         I/fd1dXqpDDkxaJQm4ldcdldFpd/EmE1Sig/IHzTKrPxzZ3fuNOQx4/mHYIKOVHheoKK
         HuVsVKaC9HtuiNjsmzuvFVN1RCMowohbaE3yIPNfFJMxBHYVJ5JZmVxy1Gxc+nBevN3i
         BNQGDTraYLGj1RVvjO4ddGM1teregCLFV2mPR4dYhNqbdrEKWi5F53+Po1FhUy4oONna
         dGdg==
X-Gm-Message-State: APjAAAXSxsk6l6447Dn2dw3gyJ9rkn2fkZZhQwLden6wzfe+OA4UFCFX
        8CZtRvm+k3+mAkj9CHtnYE2e1fkuN12IxJdsM9Ux+Q==
X-Google-Smtp-Source: APXvYqyzhKy/wV67f44tLOWg4Nvf0guM+TedLzlOmCC5ayUMJLXLERURONI95FKVVRNSAjeMLzGjM1gd2zt1aUWRb/8=
X-Received: by 2002:a2e:12c8:: with SMTP id 69mr24351474ljs.189.1560154170163;
 Mon, 10 Jun 2019 01:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190609164127.123076536@linuxfoundation.org>
In-Reply-To: <20190609164127.123076536@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 10 Jun 2019 13:39:18 +0530
Message-ID: <CA+G9fYufPgu4Oxnc9eBYkActL0fViWbSNzvrQ96OGaROi+ZrtQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/51] 4.19.50-stable review
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

On Sun, 9 Jun 2019 at 22:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.50 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue 11 Jun 2019 04:40:08 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.50-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
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

kernel: 4.19.50-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 4954dbe53dd310cc698cab437bfe8bd965d26685
git describe: v4.19.48-126-g4954dbe53dd3
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.48-126-g4954dbe53dd3

No regressions (compared to build v4.19.48)

No fixes (compared to build v4.19.48)

Ran 24961 total tests in the following environments and test suites.

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
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
