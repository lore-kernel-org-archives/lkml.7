Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130E6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77BE206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pFE07vN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbfC0EGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 00:06:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39084 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfC0EGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 00:06:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id m13so10298764lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 21:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9RT0FcM76V8wyMg1SAzaVqy4+IOZhiy/JAbx0CxcbHk=;
        b=pFE07vN7eWPeoVS0x5r/Q0WYNd4F1OoDTYxOFYA53XG1nf5wJTy5QijNWvZXKJdRrt
         prphvGbZFbTCt8Q2PdFjMon92OcvPeizBYoxOkYF7NqWlGMLSaVEpUha+DIPTgv9DbPs
         pi18EVeeB+jvwJs6HJi+Av1RO9/5LxzKUaHYI2KTXcOdDfFhVTNhw8U14rHynthzMK5q
         wPeOYvCBDzYATab/Fm1S25DbDNdp0O31bwVftHD9ha2zLzskWjrA4YBKqdPdWkWX/juD
         F/+EDJrJPpgVCZcqyySntZkn1nZ8FwWaQhE3K04fz1pgVolM2vyLgygNzhhMDrUZXFvA
         wgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9RT0FcM76V8wyMg1SAzaVqy4+IOZhiy/JAbx0CxcbHk=;
        b=RSjer4nYms09D7KDCWFMuqibSmqJMeyHVC03Ej6OMM6GnLAM8McWCccrq0//cTqldq
         J/oqkRO/AHy2r1ZQ8Vq2Z7tGTyssQDO+bsJWiUuoLQ8ejKMP7jDksBKV+OuUiK5YY0id
         T/z8Wfkq1uTfX2ZqGNamX3btBtwHP2fGLifQfAI6DANCl6GyAGN8SvsitUUNieNqT1ST
         piUv9rZW9qa3c1TMQQY2tOruSq4h+l5zj3EdlSxuvr1dslkI8X91h1UErWiGAG8b9Jfs
         UHco8kn6AEHZChP8jsQvhv/FGCXM4jL+TQKUET62ArHlxe+seVMFUuVlNK0l0yQfYmZq
         nHFw==
X-Gm-Message-State: APjAAAXnoDOZk5+JmyvSwYIq7LXPGFQeD3dTQeNTy1ijytxnM+kQDnfl
        /vQ9LxMRNyquddPpXypytcRQI7h+KVu6cUh+5ZoPDA==
X-Google-Smtp-Source: APXvYqzkxv3nnakMGo4XYFm/bn5Knr2tBBoH2qnzpDk11NlJ0F4nyUhuNkviyWm4F7onUMq4jtKJrP4exCviCMttEzI=
X-Received: by 2002:ac2:4292:: with SMTP id m18mr16604282lfh.60.1553659577803;
 Tue, 26 Mar 2019 21:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190326042700.963224437@linuxfoundation.org>
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 27 Mar 2019 09:36:06 +0530
Message-ID: <CA+G9fYvQ5oHdxwBYPW-B9Bp9bdDAkhLrHJqhH0k=nuO1kZSftw@mail.gmail.com>
Subject: Re: [PATCH 5.0 00/52] 5.0.5-stable review
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

On Tue, 26 Mar 2019 at 12:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.0.5 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Mar 28 04:26:38 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.0.5-rc1.gz
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

kernel: 5.0.5-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.0.y
git commit: ebcb1bb407e721935a9b63a86b17bacb9a1bbe84
git describe: v5.0.4-53-gebcb1bb407e7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.0-oe/bui=
ld/v5.0.4-53-gebcb1bb407e7


No regressions (compared to build v5.0.4)

No fixes (compared to build v5.0.4)

Ran 23108 total tests in the following environments and test suites.

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
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
