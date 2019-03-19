Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8382C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F3420850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="naIFWB+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfCSCwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:52:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41780 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfCSCwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:52:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id 10so13246211lfr.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iSAKB7nmnYYEdbiI8eT4P+CNd/POeBfTIQ0dBfuE4H8=;
        b=naIFWB+maPRmoRT21WmN+TnGxLUex4r4lzp9M/RXUCYZtrqGMIPRYD7p2AnSRCaeNN
         XnqjUqGx/i5TAGHvvjU0uHWl2YWbbQGoDT5iKZAk/ITznv7HkzMaUxvVqT4tyBYnfAMC
         CtZGXec3+0ygnK+KxNCNwy4CdnTppeRi7OyRXhvWSaXBLSQyWN8qkjxTfxSOg2J6rwqT
         RPJpQcomdCfQ4bY+LQeBqHnvAw0dXbVnERgC6UdoaeLAP3UF7sed7UW7e/AWINuqZJm8
         4geYkds0w8tmo0WhgD/6lbg+t9dN50+g7Tdib0DDadBgLb5IJZF4ud70fAhA4/HJAGDl
         uuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iSAKB7nmnYYEdbiI8eT4P+CNd/POeBfTIQ0dBfuE4H8=;
        b=iQs7NxEDCP+38kJswDQA7MPArOn485x5lLXNJxjVKyt0hLp32J1Z9cRdO2Xks0Diwm
         iJF41qk7JGx5MpPHb0ZQ+y8FvDFXTXxtolYWWyuIKdp4CDP39os5GsYxSHrYRvg197jW
         TPSnAPP7PyJ40ejxvmzEd58MsSm0A9GoaGh4PH+ym9PKgL5k421No6LT70B8Do8G0Gct
         QPsFGD7edd8CVjRp4bQjK9vp4Yw8L/uOHbViDI3rIczthIQGacvKanqWDaQPxwK4Y3B0
         nZkGskOkL+oOrKvmsXCLdP3dH7xRxKK5tJsUi/pS9IZty3sUWyB6HdXzVN7ueJ+tiUPE
         Prvg==
X-Gm-Message-State: APjAAAXnmfvYVTmC9KPA8bz8tWn0kGxxqj7BRwqDFh56hvHFfbK7P27t
        ll90tW+RUHS55AKmRUT3LYNLMrRJQLiLfNJZsNCmukLa8Q0=
X-Google-Smtp-Source: APXvYqz7lCZ1VZSghRLtLwJtvHdknx2qNUhjNVqTMG5GL/Ij4whGBHxttHGxVewo2AgUmTFJfvp+vWHKXuCFHADDI3g=
X-Received: by 2002:ac2:4292:: with SMTP id m18mr11058551lfh.60.1552963960218;
 Mon, 18 Mar 2019 19:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190318083843.398913295@linuxfoundation.org>
In-Reply-To: <20190318083843.398913295@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 Mar 2019 08:22:28 +0530
Message-ID: <CA+G9fYuOkJBD3ozXMMXZa-s582ZfiUxwQxOEibesgYQ3Bsz0ew@mail.gmail.com>
Subject: Re: [PATCH 4.20 00/52] 4.20.17-stable review
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

On Mon, 18 Mar 2019 at 14:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> ------------------
> NOTE, this is going to be the LAST 4.20.y release.  After this one, 4.20
> will be end-of-life.  Please move to the 5.0.y tree at this point in
> time, or let me know why that is not possible.
> ------------------
>
> This is the start of the stable review cycle for the 4.20.17 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 20 08:38:27 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.20.17-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.20.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------
kernel: 4.20.17-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.20.y
git commit: 32444766b5906c62c713977ef9deb76e744e485b
git describe: v4.20.16-53-g32444766b590
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.20-oe/bu=
ild/v4.20.16-53-g32444766b590

No regressions (compared to build v4.20.16)

No fixes (compared to build v4.20.16)

Ran 23040 total tests in the following environments and test suites.

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
* spectre-meltdown-checker-test
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
