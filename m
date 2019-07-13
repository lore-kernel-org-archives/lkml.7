Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0618C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 03:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892C520896
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 03:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wpOn8oqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfGMDFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 23:05:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39658 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfGMDFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 23:05:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so11086397ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 20:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xGCNM2E6Vf2bKEDhIUTL8F00ewA4KlinsHR9+GCg3hg=;
        b=wpOn8oqBAHkefeN5DnP08xmFfrNNiiohDBn/iC9IBMhm93AnbvYIeHCkGjw3LKjckx
         Kjnq23pPJTiR1+WotqBxd2MkOUCRVprl8xrAn/vYhhKrTdiwjQq5FLZQsT5LU6hgcA8q
         1gwsnC6BATsITNkCIyzuToZxquw+aVpzWRB3IjmJB3nCj8gQeuUPPuUpJx4Zf1tE7OR/
         SMWSyCAywbkTvzMCexLjX7CU2B5c50s58HJL6Mq9ptX5E+70kP26z3/28jBQ84MXN0eh
         bFRp8MTI07OIQxrVmzEeTxagt7Q4MQNaMiaJjvAwybuzGB7ju+oHJTdqufCCRhN/nSfL
         LY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xGCNM2E6Vf2bKEDhIUTL8F00ewA4KlinsHR9+GCg3hg=;
        b=fxufazxtzJ1PTHuqm0yrjl/6YSn99dvn08fIH8LreMLgvvEKuFvywkXeIgerutNfFM
         10uzGBtfLGAdrGGfrRd/xltmlA08YsxUSFQhKWOjp35MGNP3iQvgZp2A7FfCqTnSMUoS
         jdwKhZs53swfdsTMjSlwg9b0BFNuVjIDE8yXNuMlld2WcKS0cwgX7HiGhTo6t6vmqOs7
         ZFZU2NozlFi6dkjgDg33ZYt/1QbD75iZtIEUCc1VsQsPURQX1Me3XHszxG4CWQX8Tzwd
         2syzBi3pqvapABL/wcrK6dTB0YVd7D4SA9bukJ6eOVVKkDzJUTrwmABuCdpeOSGa29ON
         16kQ==
X-Gm-Message-State: APjAAAX5RYYdkKAgLOfEUmS6GECPmh3eIkNB7hZNwK3zRoECPK5nmcLH
        yVRFqG2tKNr8ScbuTEzHM4/WUCMrxMRNVwMurGB1hQ==
X-Google-Smtp-Source: APXvYqy+2bIYH5q+DuXF113WtyoJ2JRjhc0VqseuHWx59/q7EeozlRYkZ5IFph5LLN93IQqQV1CTd8YV/2zFNVZdwww=
X-Received: by 2002:a2e:8559:: with SMTP id u25mr7632583ljj.224.1562987102807;
 Fri, 12 Jul 2019 20:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190712121620.632595223@linuxfoundation.org>
In-Reply-To: <20190712121620.632595223@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 13 Jul 2019 08:34:51 +0530
Message-ID: <CA+G9fYsm6jgQm6tdQU9Pyc5cUoW9D5Ff7kxb-2mPzzhE99+Q5w@mail.gmail.com>
Subject: Re: [PATCH 5.2 00/61] 5.2.1-stable review
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

On Fri, 12 Jul 2019 at 18:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.2.1 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun 14 Jul 2019 12:14:36 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.2.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.2.y
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

kernel: 5.2.1-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.2.y
git commit: 61731e8fe278d37915a743554d370bc33a2037cb
git describe: v5.2-62-g61731e8fe278
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.2-oe/bui=
ld/v5.2-62-g61731e8fe278


No regressions (compared to build v5.2)

No fixes (compared to build v5.2)

Ran 22507 total tests in the following environments and test suites.

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
* network-basic-tests
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
