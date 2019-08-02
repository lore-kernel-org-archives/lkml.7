Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B143AC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 18:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E50216C8
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 18:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="adZrvhxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfHBSrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 14:47:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37122 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfHBSrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 14:47:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id c9so53567120lfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X3+bNZXgvXEGNlG2ziTE6HCZ1bNSEqqO3Mh6qezFir0=;
        b=adZrvhxNLzGBMLQsqkOa+TnMajVtpWXt4efpN08v3bVc5lh9COZ5cQjCHxDgyRvVbe
         5R+zYBjwO58w+1Z1nif0DPIUtLP4JE15hvwJdvju7adOVTl5kVbeNvI+LqFyYUSpe7zN
         yate4S4oPZnq93KGN47NrQIUXCdmee4T8e1XNmhNoSKcIEEATNmETvgAYYp+vIRHFKe7
         LDIlELYohPMjIm/QKNfC2yQfzB7sjdVW6ri9VgX9DJ+PubOrRfsE6DX8ddcuWheK/nBm
         aTm0SkQGRcHOqWK8iKS2BjBO0NINSFrFazPseNDdcI6okPhjZeAghU/klHwkxrO0dEPv
         M0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X3+bNZXgvXEGNlG2ziTE6HCZ1bNSEqqO3Mh6qezFir0=;
        b=FQHhcVncR7cSvCG7qqDC1az6SDd0ohc42AEfF6Nf1+jlvNBec9rkmxkuVVUi2Xflmr
         bS3FFSU0vBLoWsxawQrD155j7fblpDr9DP5qZeD9ZC17P96w+YFyeRySxXv/sKz7YYh/
         txYtNL0jwpVj+O/gnJf4oo0VGpC4u/z3G4C718JyVQaXKq0l1M0tBx3JLhwT3nbdyiuW
         vb/KgHYzNUsrLkE32Eg7lAptZoSNI/3NlYe5xpX/L/Jj8qy/sXVNuFtfuaRsXFnMhK5m
         r4Lo1V07n1uZX7sjVKEvKyVfnsvslgxbxVvu7G9DiVnARlrFqlNHmUHkv+fJjqPuEBZf
         VV5Q==
X-Gm-Message-State: APjAAAVIkmY1K0fnmK5GckRqwMjkzdds0Bq/NvT+rG1opfiWiO0cC4jJ
        CbuMR4PYplh0s1lqCB4dTaaK041r/d45vHoueDWmp+z2Um0=
X-Google-Smtp-Source: APXvYqwZLta6ERudg+ktKleH4LZn4FrKyTVrri74LPomNmbZQziWx4WrhWKoYmv0NnKdwVgTRiy2RvY+eG9S7mQmVlM=
X-Received: by 2002:ac2:4ace:: with SMTP id m14mr28295756lfp.99.1564771626906;
 Fri, 02 Aug 2019 11:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190802092238.692035242@linuxfoundation.org>
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 3 Aug 2019 00:16:53 +0530
Message-ID: <CA+G9fYsxEw5H8eRiddWBJ2S894KTEVGrVo_B2gHdZ+X10WpZ5w@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/223] 4.9.187-stable review
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

On Fri, 2 Aug 2019 at 15:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.187 release.
> There are 223 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun 04 Aug 2019 09:19:34 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.187-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.187-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 5380ded2525da1be5103e3f0f33129dcbffa3add
git describe: v4.9.186-224-g5380ded2525d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.186-224-g5380ded2525d

No regressions (compared to build v4.9.186)

No fixes (compared to build v4.9.186)

Ran 23662 total tests in the following environments and test suites.

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
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
