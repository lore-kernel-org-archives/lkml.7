Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D56EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FC420883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w7/PA3iZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfDBI6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:58:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39563 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbfDBI6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:58:20 -0400
Received: by mail-lf1-f65.google.com with SMTP id m13so8372145lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 01:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uSvmonhjaoX1OgpwfeLCOa4tfQdFP/FyrBnLzSwWzs8=;
        b=w7/PA3iZ4GBcteaA2AiOjHXkO4mQeteF9JkCj3VqQXc8OJI2RbUEFqjLMkLEO+Oskr
         qvAHjaFUEP5empZ0ruYN9/RqenuXBdV5fooFdrdtznyhTzTpjsle8tLHWXXZK1aWUXWz
         nhBpz5ptOD0EQ/O49RMOwg1FbfEKt6DqQole/kRoDFGXJQmgSlchPPcia5pHWs6esXjz
         M/zv5joaVtNP/sg60/s8Mfxx1PG/n41Alr4PSm1SNjelPF6cEXF4JP7EopbYn44StccM
         S+JqLQc3TSj7JkM3Es7r6jeIP0qY7gNDCNQFgm5GY+bgZz/cDo1zXCAV/PkXN92sIJ2L
         Cmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uSvmonhjaoX1OgpwfeLCOa4tfQdFP/FyrBnLzSwWzs8=;
        b=TO8WqNwpFfsnI3Wx2R78BiLLUtPOrKpHu4VvZFCzjbebBCqXELTakT59WsZ5UZtkA4
         swC0/ZmaDRNxs863HPgudMldc0UEQooqVjgEG/zxH9GXoQNBJ7B1zek2hFRvGEoHM4pt
         +fYWVauDrlA/onW23RwswTeiPgbih4VQmhJoErb5RorkGlCJ2HKx7xJ2H3a0OLZWDnZp
         MQnmbAU/pX62x+uwRaBJUAhw/q3xXeIqujnC892KDEXQLvgqoG2Tn+/5IdoFG7NllWqY
         BVpU+BinvMt68BoBZJb2onDbS5AW5R6i46dnZo1ifjXhqqgP7Qg8JlK5IGGepnrGv85X
         3Y/A==
X-Gm-Message-State: APjAAAW3V3sZV8gTntm/mqX3Fj9jlxi/ZTKj/Kqo30YyiL+n3ORLbB5p
        gfAtlin5dpU9WPGhZxXo7L/QCaQf1DDVfIfUpc3xvQ==
X-Google-Smtp-Source: APXvYqwSHWOd+8aQjgZ47ddq5/urPyuSJnj4OaUk0M3CUEfLvNJfTeexCMQwe4/xrCS+jEMTbNCrEHp56wTESEDJ4qk=
X-Received: by 2002:ac2:5110:: with SMTP id q16mr15382380lfb.44.1554195498236;
 Tue, 02 Apr 2019 01:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190401170045.246405031@linuxfoundation.org>
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 2 Apr 2019 14:28:07 +0530
Message-ID: <CA+G9fYu1bL2L3kFNk=3ekfMQThAqwa+-o3jUpUtGVzi5gNAcpw@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/107] 4.14.110-stable review
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

On Mon, 1 Apr 2019 at 22:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.110 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Apr  3 16:59:25 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.110-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.110-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: d9f7d17a43aadb81f676a3a3f012a1bb32fe9bbc
git describe: v4.14.109-108-gd9f7d17a43aa
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.109-108-gd9f7d17a43aa


No regressions (compared to build v4.14.109)

No fixes (compared to build v4.14.109)


Ran 23299 total tests in the following environments and test suites.

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
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-sched-tests
* ltp-syscalls-tests
* ltp-timers-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-dio-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-io-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
