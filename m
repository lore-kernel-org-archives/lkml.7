Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32565C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020A12184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEji+5P9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfDEEyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 00:54:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36296 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEEyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 00:54:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id d18so3423424lfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 21:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7DX2t1pWBEGYb2ebpSdri15RObjrznBa0xgAJcVNgx0=;
        b=hEji+5P9DEp+CLLODWncmuu/0/lzxbubH0j7dI1qMo8BmIwtlU/dSPoqoyP9n8BF9l
         jcd0S+TJUMrS0xYt86ukYZUFgsUtMe32YDvq8VWdEHsyE/auXvUI/4h6ZHlcB1vFkN9E
         S15vf7JJ0u24v45yXHHu3KGYGyRlnXDpcp+v4aWv6JqGp3/Dcv2DB2bLIfxI19da5JWN
         0YzLKdXGKCjBCuzC0uhE7j80NKTgmhNj57BMSk4pJwCIbS6B2Ev45FyvidzwoyHdssqp
         wuaPwnXbKRy/3I4JXC+Re43wyBRKKhNQKQbdGKJ6gb+iaKDatoaNVoZtzEhcN0gQNfy/
         GIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7DX2t1pWBEGYb2ebpSdri15RObjrznBa0xgAJcVNgx0=;
        b=ENwrYAId8PnYQgqhsEf10D7Rs8SvtJI46mpUTbh51ddkGLxGATz4TyPgHlMy2h+YFq
         Zna43JBgSfiJROh5SubuXJChCLEWkryoB8yv9rXM5xnCWtbC7EZo9NRUMa/pxp5a+kct
         s4WNuEux0vUqjG1ZbGkhjZvRrX6N8EjK7xflOjpNwyxt1qPGWzl57C+qBa/GyQxtLCXZ
         ojYHYEKWUN/IU/6wr6ZRBZFZgHVY48eTvc1WLA95kGbZ8WSK35fDWDwnlfNLh56Gq77L
         Wa15/qOdRydBhE2mI4oXU3xi7Nc91L6aKBKXWATbd/pPPsNAxjR7vnIFz+HA6FxWbW3u
         aFig==
X-Gm-Message-State: APjAAAXAV76elsbOc7UTABDK77r7PzQKv+e52uWNG51xnbXPAwYyr5oq
        hYmxEkZ4qbWvGo+94LEdR6gGu12xEJFS9t7bU5TiUDtWaSY=
X-Google-Smtp-Source: APXvYqwEwzYrpIbRCxwiwKiWgKPs8VTgbVDE491x/+vO11IkMc24323UsY3qpNYjPzuDWK5od8I8nq2bw70qrEXUKio=
X-Received: by 2002:ac2:514a:: with SMTP id q10mr5544917lfd.17.1554440058775;
 Thu, 04 Apr 2019 21:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190404084603.119654039@linuxfoundation.org>
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 5 Apr 2019 10:24:07 +0530
Message-ID: <CA+G9fYv6p=x=4-MufsPZVq4jCyPg5osn2Mk7-3VKDakXavsFNw@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/187] 4.19.34-stable review
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

On Thu, 4 Apr 2019 at 14:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.34 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Apr  6 08:44:30 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.34-rc1.gz
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

kernel: 4.19.34-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 4b338ef616b3d99a0c49c952acec89b827db9c1b
git describe: v4.19.33-187-g4b338ef616b3
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.33-187-g4b338ef616b3


No regressions (compared to build v4.19.32-323-g8822c8438169)

No fixes (compared to build v4.19.32-323-g8822c8438169)

Ran 23543 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
