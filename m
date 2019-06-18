Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B762C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045B82082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGqWnthD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfFRHoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:44:32 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40316 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRHob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:44:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so8478195lff.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uOt44gNbqC0n9BpMxtizdXC2L3VUUEGukyH8Eh7hqjc=;
        b=kGqWnthDpDY939cuqtuCvndn4ukCZvXPdDzRRXuKMvkHkz6DpdyvgmUPi5y5n3riu1
         zZ4NjDlItaJ9J8IgfjiJExfRs/G5MMC6r6GeT4wZgY3B24wanL7NK2fanL6Gs/5IjlAh
         0c3+4O1e6EQQ2r+E59/mGRs+iePIx1NXSMVz6p0ITFLMkJiwhFsIrW0k/oc6wDIFb740
         Hvw7D0GiM/j5TABP1/4+yHv68syWV50AhYOjs7Or7MSBjtcL6vroH5WC+uYbG2D+4Jk/
         jliZIs27Ap9v5odQX1hd9h1kP1SWqwy4uC4UKIPCNmgQ7Vo41MJqKI3yr6etPPLg5avc
         AibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uOt44gNbqC0n9BpMxtizdXC2L3VUUEGukyH8Eh7hqjc=;
        b=aup5b7EGpJfbbJ7Yyzq8ILHAAcaKUhls/lnr3Hs9zHMTfM54hBKqqzHcFSlP9QJ9Wt
         PRpGwjBGSRCkR+nu8HdVfJLZK3rw23VboLGLGaT5dXIOOc7CK3/AMrhOdqlpy9c7TbM9
         fkF/Kgt5SAXuy4eRDuyen2VeB7kihA3N3Ya9ZzXAg74FSY5N84zvsWrXaM+230kHsIBU
         nlNT2wvKF8Gb/BdoUwFoBtojZvCBOAVz8asBCTQdDtmz7p2i1iSWFDZtBhPiA8387fbO
         ySOKJw2JEcL0eJdd5/W6GIYyQEvKf/IIbTrMC2RhBm3tgM1G0QOOd0jrFNpDn0cQNE3C
         vwVg==
X-Gm-Message-State: APjAAAVCxDcZLK+xidNfFQElOlNttaSqeMSd8LPXLJ8DrH0bHnxcmSSm
        eL18czzzkudculpGEgeqz9Yis8uiPbbESc4zWpa/AA==
X-Google-Smtp-Source: APXvYqyqEt/ImBvxkLvS2rsbF3LkIy/Yu9CicO18EHNbC9J/KuJucNWlzfYzS1bsMwf087ySF0Zn54nNCBLPTFBODSM=
X-Received: by 2002:a19:488e:: with SMTP id v136mr56122136lfa.192.1560843869634;
 Tue, 18 Jun 2019 00:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190617210752.799453599@linuxfoundation.org>
In-Reply-To: <20190617210752.799453599@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 Jun 2019 13:14:18 +0530
Message-ID: <CA+G9fYtj0REFYMAmJPSkCNe4DVZ6_1SbQfMro9H3jPXq9gmtzQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/75] 4.19.53-stable review
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

On Tue, 18 Jun 2019 at 02:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.53 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 19 Jun 2019 09:06:21 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.53-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.53-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: d486e007abd08ab6e977da19580953578878bb41
git describe: v4.19.52-76-gd486e007abd0
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.52-76-gd486e007abd0


No regressions (compared to build v4.19.52)

No fixes (compared to build v4.19.52)


Ran 23439 total tests in the following environments and test suites.

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
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
