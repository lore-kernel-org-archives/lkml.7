Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA14EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B2B217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0w8xd4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbfDEDO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:14:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44925 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbfDEDO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:14:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id h16so3893437ljg.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 20:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f9KiPt/p8Is4HCAIioSqgaDyFNaRTjF2uyDxcVObocI=;
        b=s0w8xd4N3SGdJ827goOS9vOrcuQQpEZacDpPcvZ7JA8AUmkyRlyrvIN3WRGxIjtg1m
         vW9c7qSiX61JnpvmSdV5tE+rHK74n57hb/NK7Gjsg5gsr3ZB8RL/HM3TVdkS4UhFugwg
         u8KHfTGJBct0TlwGxS/2GXc5tOdDbute9tFlXuzenqycZL/DaxBXF+xjuptctCLaERBE
         LeHeCMs0vsvHv88eXiDutFYXeGOBuAyiwJymsF3arSh+naIqEzvJK4xpYM+NFRED4N6O
         IkKtQi9Zs0/9ydlxaXm4EvNUhq21xgRJj5MkJ+Kb0GWqLuX2LPzn3+NtQts0eiKUAnMY
         Rzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f9KiPt/p8Is4HCAIioSqgaDyFNaRTjF2uyDxcVObocI=;
        b=I3NaWDlNcz0lzqEHKXvs2m86HawiAfaEAMG2NPQIMWJWhrO+9lB2h7GBXV5sHR2pyC
         4LMUg/tpBN2sm8pCN3FtDqNRUU395xC1BEgPiJM+xq0Wkg2RBUo9bjhozZhf32M6+VCp
         rJSmiJ7cuOSyXPi4r7rK2vgdKIbiSQ6y5fRnqdo9AT8DsVvTM1SfWjAGzMn6RllowVAk
         gKif2YFLsHmxAGYKXQfohADrdZMpzHDxkXCcfmrOA/cCNO9SBv9Tl1QZBnLeSZcjE7HX
         hJmXPPXUtvTI+HokTH467OYSnGb3r/RDyDF1MN/MQbnG8k6uE2nvKeKncQbkxLdf+DLx
         ofeg==
X-Gm-Message-State: APjAAAWcdWk29nqn/MC7JZT93gHign273t+nndWtST4Nu3kwPS7gpQiE
        2uF/bzonHy9bfHc3xU4ifuBPVa8U49+dykCOjjD3SA==
X-Google-Smtp-Source: APXvYqz75/MJ7FC1kLkbl9+evPwCfpjwFSsoxhiveFXxMcDsW1f2eigAbf6QYJid8/rCrDWYfEiQX30wm3uS4r2rP7w=
X-Received: by 2002:a2e:884a:: with SMTP id z10mr5327227ljj.21.1554434094078;
 Thu, 04 Apr 2019 20:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190404084535.450029272@linuxfoundation.org>
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 5 Apr 2019 08:44:43 +0530
Message-ID: <CA+G9fYv4Ce5vbAkFNtqOLoF66r5W4SAVzq=6DxuXC7r48N=hpw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/91] 4.9.168-stable review
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

On Thu, 4 Apr 2019 at 14:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.168 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Apr  6 08:44:27 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.168-rc1.gz
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

kernel: 4.9.168-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: ba980237d739a2beb8f17095af6ce29de69ef51f
git describe: v4.9.167-91-gba980237d739
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.167-91-gba980237d739

No regressions (compared to build v4.9.166-149-gea283005c82d)

No fixes (compared to build v4.9.166-149-gea283005c82d)

Ran 22706 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
