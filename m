Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50298C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222312087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6HISqiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfEGHTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 03:19:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34461 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfEGHTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 03:19:53 -0400
Received: by mail-lf1-f67.google.com with SMTP id v18so8810879lfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 00:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=88E6yMMuAS1OtjvbUW5DvuvZIuxPInlpgDWbZST8uvI=;
        b=e6HISqiQPEkRaR+n71oJohkWMutsmayp3D/qihFSzCbipzJddTzEfgXMPNzCIFkVOr
         V29+GgiOlnnrsQ2x4pFAF3XIEalBZcxr8VHefMZcpmLubZrl+SBBzI6phPSf0QanDJe2
         tXEe9a2+LdYE0kp9oU2XY7QZQtsOJOwqn9/QMk8OGBxctoEWh/rcoV/VqDuR2a1ZIUi1
         bZW9I1rzymCXS7nlm9noVcWd+7/hzZPpxYgm5QOyQAsz7dhUI+F7v0oS+jSo0fG7M+NL
         St1cTJ9wQAIlQ3PXsn1XXO3SSYrO7+QeKkQMKuO3ZDBYnt8a6nR/wdOkJ19zKzikeuZP
         hieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=88E6yMMuAS1OtjvbUW5DvuvZIuxPInlpgDWbZST8uvI=;
        b=Anbz+xnmiHS9KeLh9RyriYVAIFGfgfbwmduR2DUys92AFI3hxgPAuYQxQiekl6UX+S
         4zGLoHlpmknsjqLxzhEHfQ2Y1kn2fy4GSNEz4WMuLoBYdBEgC1TELfW3G8z1KRPK34Jf
         Nd2KcfM1gSwUqKv0O7zzsLdX3goSzjsbqbyuEU9+r059agVTOzTD78rUuSd0x2hnu5e2
         xeXkXGw2p/SwzcPJdy2A8lX8NukJBO2OPIFsnLLMkk8Ge792fhmMTumTvSEf4Z1Z8GVY
         dk40jYPdXKx7+9JcK5pbeXqs79ethkys/d489FXtEvOEYyLrua446mvhAatjmyabNhFJ
         D+EQ==
X-Gm-Message-State: APjAAAULIkxE9zYmG6Zfd9DJ7C/nrq+1VHf8Ou1r8q95ErFkWME2mZnS
        BcJ68GUNDElpa6nSG2tM72RHm2+opfljf/Q1towpUw==
X-Google-Smtp-Source: APXvYqx5vCtNFRAmyZRjkrjbhBzyCS7DyVFiHP9rOKOPJygejyqfVFPNvys3d72j0dfCaOqbVBhchglMXlrlLY9DE2c=
X-Received: by 2002:a05:6512:309:: with SMTP id t9mr15312660lfp.103.1557213591673;
 Tue, 07 May 2019 00:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190506143053.287515952@linuxfoundation.org>
In-Reply-To: <20190506143053.287515952@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 May 2019 12:49:40 +0530
Message-ID: <CA+G9fYtrJ9M9V6wOxyB4j=0kkYJOZgbZb7Tb3qP_kM8+e=sBxA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/75] 4.14.117-stable review
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

On Mon, 6 May 2019 at 20:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.117 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 08 May 2019 02:29:19 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.117-rc1.gz
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

kernel: 4.14.117-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 2e004f6acb8062e310cf8e50c91d562d91dcdb73
git describe: v4.14.116-76-g2e004f6acb80
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.116-76-g2e004f6acb80

No regressions (compared to build v4.14.116)

No fixes (compared to build v4.14.116)

Ran 22369 total tests in the following environments and test suites.

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
* ltp-timers-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
