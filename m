Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C5EC2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24A0214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYgum4FQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbfLMFSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 00:18:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45588 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732007AbfLMFSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:18:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id d20so1175118ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 21:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mkqW0xP+nBYYH3p1CPEf1+sCjfdLgUHi6SV4lII+1qk=;
        b=IYgum4FQjmmsJQYJqncXVmFAwCkO0Oew84UItkH3AqX8huUghy0eWDWaMyS928lYOw
         sJaIeeqN9ICZIqlckf/IGnCAW1ZLI5aFNtPxjODWXYK3HlDCqAWW2I5ntUlWsE/c/nB+
         TCamoHuzYtB8jFWwYOCTvaJmmDQrWrvi6IOWAVE//XI6wFfLjHyflX4WZU9XYP8SUUmj
         ij+tXcuSicMZfP8SoYbMO7FDbq4ZIbFDnxn7JbThykhY7Vv5GQ+o29jH0ZHfRGCbtdL3
         ttgehD2DaPcPHANaRNUBhWkAJMRwNpxBsOwsp6nZ/R3Q7KnNtAhCsMFQjilHFpuglpcg
         y/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mkqW0xP+nBYYH3p1CPEf1+sCjfdLgUHi6SV4lII+1qk=;
        b=kwUMRmDZtDbD4G0oFI/ZMIC52ADuUgDlugFcsOFoNKeE+NgFyZteD4LBI3AYSp1W11
         3g4oIGIogEWjODzw24PAowm2QLQuzOaWcGIlXvhNcvbsOFrjw95Sh+LxqcuzNGby34kJ
         xe4K9iY51qfq3WF75wWE+wauwRHIqGBkAbZd+4rccw4i/yRdOd5mbtHjLIB3QxIBD3FV
         vhbMgF/t5uU1mx0FwCBOfTMzekseDqUmz9aYOClJpmVt9OIJZMitNV4ZQ6TYdPefVLXt
         r9YYMBovOUbjLgoMkPksTxnU9/4oaUk66PnkibeiMk7HB4rdr7ohwTeFGRnTSB6CPT6S
         /Npg==
X-Gm-Message-State: APjAAAXBPetfwvUdHuB7Oc7GGlxlrUIL+zZXswSkXgdw44oJA1ClSRKx
        r5+hE/e1K79A5uLWxruqPGDBJ6HEIu118USfB08bslSV9bM=
X-Google-Smtp-Source: APXvYqw9yHd6d5jpLfcnFpEkBIL2C7kblPOexo6jcCFrl4KgMzywo0/ANIKPSQcw1CjR3VkDT48403LnkyTZNWdeWfw=
X-Received: by 2002:a2e:a0c6:: with SMTP id f6mr8134530ljm.46.1576214309236;
 Thu, 12 Dec 2019 21:18:29 -0800 (PST)
MIME-Version: 1.0
References: <20191211150339.185439726@linuxfoundation.org> <20191212100524.GC1470066@kroah.com>
In-Reply-To: <20191212100524.GC1470066@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 13 Dec 2019 10:48:17 +0530
Message-ID: <CA+G9fYvNVUKJV=G8qq-vY77bB12ZVVkX7E4H=GtoWANtbg33mg@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/243] 4.19.89-stable review
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

On Thu, 12 Dec 2019 at 15:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 11, 2019 at 04:02:42PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.89 release.
> > There are 243 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 13 Dec 2019 14:56:06 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.89-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> > and the diffstat can be found below.
>
> I have pushed out -rc2 with a bunch of fixes for existing issues, and
> some new fixes:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.89-rc2.gz

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.89-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: b71ac9dfc6f0f5ef4a9dfa80113bea22cd8b8167
git describe: v4.19.88-255-gb71ac9dfc6f0
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.88-255-gb71ac9dfc6f0

No regressions (compared to build v4.19.88)

No fixes (compared to build v4.19.88)

Ran 24936 total tests in the following environments and test suites.

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
* kselftest
* ltp-fs-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
