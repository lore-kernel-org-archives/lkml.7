Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1659DC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF033217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WhHqJhf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389670AbfEXIna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:43:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35151 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389281AbfEXIn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:43:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id h11so7957534ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2UGCpA22jrVv8p9U3LtnJYy4mTfB0OkTT5zNxTX9Y9E=;
        b=WhHqJhf1qkUGoFrvbntgMG9Vtkw0hDHAVDQd3JUXLi0k8UB+6RkvzcmMi8Mf+tlyt9
         Fzx3Rm70otucFLSGs8EdzagNeJQaaXvSRCbNXtP5FUOUuUiTo/RmPmkKgsQdzMGn/uez
         85sC67xAnXMroSY8YutK3NNUBorZS+9HShW7CgjxKJEirp63fNKdf/3eqs9d0OqpG0HR
         sHuCeMpEv8E5xLJ6hd3esDb0GemTWlSkV0CA6Sf9hbttrDeZQJVOhQns68JvbiXyBDG3
         J7LK9V5wPmGbRiozveCHAMDqjvNNosKRlXMEzblKSAHl3IqcV9eAJLlV5BZxqVaRuvuG
         miCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2UGCpA22jrVv8p9U3LtnJYy4mTfB0OkTT5zNxTX9Y9E=;
        b=Vf8ksG8p1f+quepm6PMPa57X+Wvcb+7ltpF3pUHlXKMr3Gfbk/BaG0CnpobFlGJPQo
         x4uYpboj5ovldcKfuTfw3q2CjIaFsx8ZU66/mamw7X26wHD+gicxKiJptSo8v4Q1UMmT
         V2gB6sWWPm/SYTrFfa46oVHORQpDhNPhxTalUDkcfAbCpb1GP2m1R7IU3P7L/hXAgkSV
         RaL4G3e6q1DPVzXfPheKn6xnNljZcgEKdizzZfeiydqxQzosRZYsMf6VHrbk4cg32Qut
         gooHMcWJxWv2g5Moqxn7Zn7dq6mKsRrFWGfCuaL4/zBX6LakPJg86bclsrygR6c8Qxzn
         PxOQ==
X-Gm-Message-State: APjAAAVICYvpQzGFke8oJHyPec6rtHEmKl0c/Vj4iEHMz/8imDF9Bp//
        zRYKuRxWQ8WoHyWr6B8Epw4FRvMIBmRCCdRkQnoX4w==
X-Google-Smtp-Source: APXvYqwjnmSEo46KGBhe5MUpoaw6uYQBmbXj0jbIUPWSD6KRHce5EuNKpxV2WFvs1OI0U9nJGdmCELgxnrJAycaNp2A=
X-Received: by 2002:a2e:b0fc:: with SMTP id h28mr33659890ljl.55.1558687407909;
 Fri, 24 May 2019 01:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190523181710.981455400@linuxfoundation.org>
In-Reply-To: <20190523181710.981455400@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 24 May 2019 14:13:15 +0530
Message-ID: <CA+G9fYuYgDB=ta07ZeQrRgEDwddQCmWpTr9N47CPEnWC5GuS_Q@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/53] 4.9.179-stable review
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

On Fri, 24 May 2019 at 00:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.179 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 25 May 2019 06:15:18 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.179-rc1.gz
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

kernel: 4.9.179-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: f6bc31d8c3be3e5ab957341b3f99f8b45fcc646e
git describe: v4.9.178-54-gf6bc31d8c3be
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.178-54-gf6bc31d8c3be

No regressions (compared to build v4.9.178)

No fixes (compared to build v4.9.178)

Ran 21733 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
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
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
