Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246DCC32757
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2F121783
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zV887WZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405881AbfHIHpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:45:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36471 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfHIHpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:45:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so11984879ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 00:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UKjqWVTr3C0h3J0Gp1sJ/fu+v2mH08178mLseAx4SEg=;
        b=zV887WZ71uphJqnEtqJVRd5LDIKGEbZwoVbc+JsGW7qUdVJ23nKQ3ENwCQG/UpNy3g
         SgDwHFRvXV0CJukLVYAdRDPNw218VPF+VUOP4ocsewVnvDUaOBks65UgXF3ffo/SwGi9
         9R426gam0A5xgE41ONhVf7Jp6z2bEBC7HuJEUEl2hCkNkxvkCTuduj4km/n5fTXu2ZyW
         heQrLiGKbJmFHn9VSH839xzKkG/DdH2CFpfAXtSX+lMO8Jg9DYBqpFbhXf33PJrZWz3q
         Own8UBYbD7TAiYibQnQ9pqMN4hRWOdJXG6Ovzfj4ZptBkxcdAz8KPL6XzyTCtcsXhBhB
         Z46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UKjqWVTr3C0h3J0Gp1sJ/fu+v2mH08178mLseAx4SEg=;
        b=HpUA/vjEg9D2HNyCgWZhv37ROhg+o4ZgOsf+Z2TwFX+H61h1wXNWVW2VRO2FxnPPyT
         52KfCXfzvOFHPRRTCELAP0gzWsHG1rPgu28LG7oYMO2Va0hTT1W8p+Q1p43Cc/Q/69HW
         +08G12JbSljJBAI57gMROhwIhTw6aL2UKYtMjIzWDaLd8Wc597GQcyX9p82f2ZB6dO2z
         WnrSy5m3ugB4T9jg4sScK+go8BqMndk1OUaw0iJWt7f77C1rQmm6vBcWhaR1RuVRmwEQ
         2fb/HYfsa8tyt8dtaX8TIDE6x2Yow7Wz/2tXoh7W3nJxKNzPhvt2norGVGrmW7RTOH0K
         nKDg==
X-Gm-Message-State: APjAAAXX03XqlQ6K9Bl/6QAQAWWroT+/Q4sE77m+FUJYvMTVAlbcFVMV
        uWm1mda8TjJaTnIgERuRFlYJxAkQXDcJf0kOQnz5HQ==
X-Google-Smtp-Source: APXvYqxQF3/llLZUEjwl9FOWOaGb6gHftmmhIfPXJkdJcrA4FUOkHo+lbOSXCamIxalOcNksaViXfhjysqRQIXrXEPk=
X-Received: by 2002:a2e:85d7:: with SMTP id h23mr10823578ljj.53.1565336737777;
 Fri, 09 Aug 2019 00:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190808190452.867062037@linuxfoundation.org>
In-Reply-To: <20190808190452.867062037@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Aug 2019 13:15:26 +0530
Message-ID: <CA+G9fYuAYB11dZefGa7bY27Dz3GrKZWQurLaCwOehx1mLDWTOA@mail.gmail.com>
Subject: Re: [PATCH 5.2 00/56] 5.2.8-stable review
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

On Fri, 9 Aug 2019 at 00:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.2.8 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 10 Aug 2019 07:03:19 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.2.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.2.8-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.2.y
git commit: bd703501e2dfb5d3a64222f9a9a9921ac1c96b6d
git describe: v5.2.6-195-gbd703501e2df
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.2-oe/bui=
ld/v5.2.6-195-gbd703501e2df


No regressions (compared to build v5.2.6)

No fixes (compared to build v5.2.6)


Ran 21266 total tests in the following environments and test suites.

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
* libhugetlbfs
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
