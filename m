Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB077C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEA1206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGZ+i9Z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfKOPwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:52:20 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35741 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfKOPwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:52:20 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so8406550lfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 07:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N5trgeVD3EORLjGO+xA4b3sDYv5TwYpSjVCXBJ/A2b4=;
        b=AGZ+i9Z/ANAdqhQDWmYJyNWnrUSkK00vBhoI5umuPoEVVrOLx7ThqiRnxpKrVNr8vn
         vDNOsPAwv4Q3EfzZdqu3RCjFDz08ePAIRk+ebM6Lhry2zQcFQUKGUFI/IK3O2QnwnBWB
         tsMv30MNEsAOnIKuZkYLb+xnTUkhG7sttw2zo9zsG1YzMXzy1bmEMNxl/JtG7Uvs9/AX
         r5kQ1Bj5yOXt1wgkF/CZGuWo3OHHjMqMQOKgy8IoGfGltquaO3V/CdvYYvEbClixKu6M
         xP5pDemcxadu5Rt0FygluglS72XuyRgYnFkpXtugDdFg8RivUEoEY4aJY6YJXt9mkURA
         xq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N5trgeVD3EORLjGO+xA4b3sDYv5TwYpSjVCXBJ/A2b4=;
        b=gfHiSysrtIyUddslTkXLp3w6gApDVHU+hG8LEf0MPh9qwJOlVMtKTYHv/qUwDhqyII
         08b35lDwHTAyXEicMVz/KjsS33iFqaimEWYNJSlCtR2ru9SsbqxGx4c4dMzWBktblVTI
         ZMEuesPuZjN/UXHaHweu81IPexrjERh0v06m10FxA0Fxtgon+NmYPnWRbyLxc0iaDqUU
         LSJUiVFAkYxyIeEDu2mCB8dwsyhQXNwWxy7Aq+UAcqv6jX+BE3Oz3k4V5/OiDDqMZk8n
         gW36Aozqiv4JSeZlJkrvZ60iHZJ6WyXevjFq1mhAMsRGmVKUDbZbR4IhKDowHldeYo0j
         BCvQ==
X-Gm-Message-State: APjAAAWh5RH7kpLllXnE+7IIOnkH1wFomyrM5VA4j/9SvqWR55DeqJdn
        H5kbnegib6kaGP4tDRsAxMixEZhM0OFPp52DwYuXoLRzd0M=
X-Google-Smtp-Source: APXvYqzSzUr1x6b0VTnz7N/sjujRkdhPKmenqMTT9HLOsTJ53Vw7JoA2OGmtdseEAGLl+Iw/x6f4Rr8Li+VfM1A6Lfg=
X-Received: by 2002:a19:f811:: with SMTP id a17mr11581671lff.132.1573833136685;
 Fri, 15 Nov 2019 07:52:16 -0800 (PST)
MIME-Version: 1.0
References: <20191115062009.813108457@linuxfoundation.org>
In-Reply-To: <20191115062009.813108457@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 15 Nov 2019 21:22:05 +0530
Message-ID: <CA+G9fYt-y23nfB1gU_e8JoTU+n973QgJCtMcqGrugRQ7sVHUMg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/31] 4.9.202-stable review
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

On Fri, 15 Nov 2019 at 11:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.202 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 17 Nov 2019 06:18:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.202-rc1.gz
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

kernel: 4.9.202-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: d7f83e4f45e886d919bc985bd225b8355ddd9284
git describe: v4.9.201-32-gd7f83e4f45e8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.201-32-gd7f83e4f45e8

No regressions (compared to build v4.9.201)

No fixes (compared to build v4.9.201)

Ran 23552 total tests in the following environments and test suites.

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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* prep-tmp-disk
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
