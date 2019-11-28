Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6089CC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3334921770
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLvoZlTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfK1I4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:56:40 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46888 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfK1I4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:56:40 -0500
Received: by mail-lf1-f66.google.com with SMTP id a17so19401256lfi.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 00:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rsvhqVEc8W9N9lJvrGMrOxgnq8ofC0A7592rwPDo3sc=;
        b=OLvoZlTGPhnIxJh6RXxAp6IInTJIJoOOfd1AkWrRBhriSGLCKTaGrTuXu+0LtW7q/W
         ycCGvWy93cn2so2BAoLn53ktsbc2JO3q9YYH6/+QxQhxalaEvQCuCAiLzHG2bkDZjcyg
         rTYU3RScyRyvvSISZYvCOZFJMfbxnMMpxKw/lMjuRd0iNeXMv3JwyPv5HCzmzMvOLX22
         l8nTy+ZUASaCNCs21NvscKB+6pqVCIgDwTJJqcW/+HY0pFfKqXwrpbJ573axC/sGZDhG
         j64p9DB7ZwJ9EJFK2PuBB5zqqvpsOitEhcV98P5hKtQUBhuGTDj6V+x1T4/tNPHnzE1Y
         RaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rsvhqVEc8W9N9lJvrGMrOxgnq8ofC0A7592rwPDo3sc=;
        b=FUeoR010WoaXBScQGopFw19T2p0m3TXKcL6K0wSmSqQYhx60+rRFlERqEC240pVe99
         n+5xeNVKPyqI6Xn3nuIy8fnSKac0N4xXNqLjf2rijGS4Fha/qPhRn8Z9QOwlyKO0rNMR
         vekHsaYfqWFcQHFk9kJqciwXvcKqRGaDlzTWN7YlIhQV/qpQLk19y3c8akVgYvS5UvZU
         s71E66D+Ap0OZvfSDf6COKC/nT3bH/6sCwm44gYsoTd7Gquzs2wE03eGBafVNhyFMp78
         b6B8jf8gRKiOvDBdEO1VP5Kgi7ojxCyovzTALTTSECLAmb7fpX/4xviUhs8qESGxngI1
         adTQ==
X-Gm-Message-State: APjAAAWXwW1HN6hgaJCF9BjNfuCc3Evx6YmS9QoN2PecAZDHr4rdIoCH
        bcjrwZlT4Eck87r6bvP4i4Q6MJxCJEGnjvLqxSiJ9g==
X-Google-Smtp-Source: APXvYqy2r73CX24TK2abu/IrRUo8YzrxriqIzkMfeKAEKPSKbnnda6JFLmzOpLL1il8q4Vq3PuqemHsofHnXV5hjGRU=
X-Received: by 2002:a19:8104:: with SMTP id c4mr25848755lfd.191.1574931398231;
 Thu, 28 Nov 2019 00:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20191127202632.536277063@linuxfoundation.org>
In-Reply-To: <20191127202632.536277063@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 28 Nov 2019 14:26:27 +0530
Message-ID: <CA+G9fYt8UCoKYnemrGFX4btoNukF0FFTsppzePKDbGbV5sQrtg@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/66] 5.4.1-stable review
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

On Thu, 28 Nov 2019 at 02:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.1 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 29 Nov 2019 20:18:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
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

kernel: 5.4.1-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: d6453d6b0c5737ef7e24b4216b86ddc013bfc158
git describe: v5.4-67-gd6453d6b0c57
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4-67-gd6453d6b0c57

No regressions (compared to build v5.4)

No fixes (compared to build v5.4)


Ran 26389 total tests in the following environments and test suites.

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
* linux-log-parser
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
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
