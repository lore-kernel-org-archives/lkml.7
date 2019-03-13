Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25886C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEFE2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LMDniwd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfCMI6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:58:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40437 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfCMI6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:58:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id u68so848230lff.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 01:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lR/wzxRQObyAnzdysFX0F1pD3kfiLqZrY4TFQsAQHCE=;
        b=LMDniwd6g0k+WaSh/yqweBRvP+2/d5Qt5e3Tso1rU6ij0PsPUeT/kWWP09M+eqN7CV
         isZwqWG09DR7a1q5clYJUzCrvnbCiY/NGIrZSMFocSpvrwRCVTzlu5u71hc93VwAbqNn
         xhVh0/Zr+Zbu4HRgHZ9IjLKXsvp3Zo/Uqv+at6/AYEapvx8crMtIgFlmj8G8oY8fJ6SK
         TFfbNuGm47bFmS4hV5ri5lM5lURTnL4fLye+cIJ2vypIGyVH6Fj7VvZ9crGj2N4/p/69
         vDvdjgjyupJ2CHLFutcqBS8t7vRO5u+5tghAhCpDyw9GcFuF0n0RcsAlSsOZO8zrieve
         XeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lR/wzxRQObyAnzdysFX0F1pD3kfiLqZrY4TFQsAQHCE=;
        b=QQiP+Us3uVRAwMRNCbgjAwaa1pOlj5onaq0SM+3iehnuB43lpBAQhVhdM2iuaA23C3
         fAKVEWfhgADX1W7ZTtY7ujso0mBiNFBm+4NNWubTcY5mfCNrvF6znUT/6AQqqpg7f1EX
         3Xv0BlxQ1JJhg7QT0Vk/6a7+ybRWSEsk1QzFIqdg8A80qAvrqfpnkN6waUP7J7zlm41n
         VCttCXAXK8vJdMs7XcDBiX8lu3aC8oEXnRX+VgENKtYoFBsSvVaFA/AQzklTMqd9uxGx
         ZsSueHh/dePrbS9OetOQBbiWJvgsZUbsFjJ0lJY+XJFQ0hhiGH3pH1xFBkAHw4rIyh1T
         cSCQ==
X-Gm-Message-State: APjAAAUTgXTZyAFPzqmHCq0gwiJFOhIBgxIxx6rvUGfQ46TyqX8XGX5Z
        WVmg/v797YIsPmQj3GHFRkIqOO3oHE8bmQEa/CBWlw==
X-Google-Smtp-Source: APXvYqyr1ZnPv+ecTqBPKKShLcSaFlRow0yaE+NKnWtLPyYXewbZj8z67SpwkzCsR540Otc9SZ8MZwaHSedSLm98NGs=
X-Received: by 2002:a19:57c6:: with SMTP id l189mr12474995lfb.0.1552467485080;
 Wed, 13 Mar 2019 01:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190312170403.643852550@linuxfoundation.org>
In-Reply-To: <20190312170403.643852550@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 13 Mar 2019 14:27:54 +0530
Message-ID: <CA+G9fYtU_+sJe5A9cWhivKATmNjYC-KH0bTE_VeW4QgVspfEcQ@mail.gmail.com>
Subject: Re: [PATCH 5.0 00/25] 5.0.2-stable review
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

On Tue, 12 Mar 2019 at 22:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.0.2 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Mar 14 17:03:43 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.0.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.0.2-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.0.y
git commit: b799d04b34331b5cf5507427dcc9f6581fbb7e26
git describe: v5.0.1-26-gb799d04b3433
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.0-oe/bui=
ld/v5.0.1-26-gb799d04b3433

No regressions (compared to build v5.0.1)

No fixes (compared to build v5.0.1)

Ran 21975 total tests in the following environments and test suites.

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
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-ipc-tests
* ltp-syscalls-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native

--=20
Linaro LKFT
https://lkft.linaro.org
