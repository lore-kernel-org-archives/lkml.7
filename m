Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347E0C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4E82077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MW2m1HTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfDYFYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:24:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44949 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfDYFYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:24:53 -0400
Received: by mail-lf1-f67.google.com with SMTP id h18so16448033lfj.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 22:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZPvoBwbLbMHqNh9pdOo1HxHg/yHIstoXFIhCf3/h0tk=;
        b=MW2m1HTdib56Z0qCLy8sgKOcQf/5XhTzHatM/XaU8iI/jDz075RuFmj6H71X+OkmNW
         kIXc7/2rE7n2a2ZUNIFWnLhVLpF+03tx+PDAMbgZT3T5vkbkVYa3tCdTIj1NcbhN23/u
         jSbActvh0ixIG33F3Sker+vcHFTSXFTzrCXafkXu537x+ewS5IHsH7J+ch69l32zzCke
         E0gqe8/In/TQ3iqNzooLcHcgC4i1T2IX4O8vU5x9U2v2wpfpX3whfppiJswFYR3kDQhP
         rUZvYFka9IDOBI4NnbsDRVI5EkDP1EwJV9Qk60Dp3HXLKoKKHOjBsFHLfX/Lmj9rMA70
         NDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZPvoBwbLbMHqNh9pdOo1HxHg/yHIstoXFIhCf3/h0tk=;
        b=HBYwsJMVaml+qTWEX3ScJjGQxxtDv5tww5zJrvh6PBtMI2z7O/wpU/+x6Vp5HdgZ/o
         ik2tCgDwwlOsRlyTdGFlz17/vaMXTLmvltWiPl3mjYoJn2v+5i5vVW8HgeMTf/weZVUf
         aBL/rLfa+o0UEBdHD4L+/Ct1YtqEeVXOcitTCBakn3vqx7HxxiIKIeoouUsOe1p1Mf4B
         sdC8e/Zed4I7g5UEVnrtZ+6946jIqdrkZvMcP3TSlT6xCIOfNpk/TteKvK1aU7voa60B
         WsOToGu2H0rcLFa64ccTuSIwNDGlfwasw9IQ7/7A3Q+Ukk/CJfIkbS8o7XFhrQTAFJKI
         Bk9A==
X-Gm-Message-State: APjAAAXuZoXikG5WGjNLhvMSLlsIqX372F8+22GlTQW08bMKVefB6Djm
        YONWw60LzW14t8HY3vC/ZjqZ0TY+n93l3YVJDEZbLg==
X-Google-Smtp-Source: APXvYqxZVyaUE97JLHRmeg/Sv0jkApfv10rHVcWQlkpqGQeQ7CevJ4VHl5uMnEiy0qK+f+wUvD9xXiBlrzjvWp2rgUE=
X-Received: by 2002:ac2:5625:: with SMTP id b5mr18948903lff.137.1556169890648;
 Wed, 24 Apr 2019 22:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190424170839.924291114@linuxfoundation.org>
In-Reply-To: <20190424170839.924291114@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 Apr 2019 10:54:36 +0530
Message-ID: <CA+G9fYt2YfTnKC=2eV+3DstfCt59GUkC-by-F=7iNhRO1yfiJQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/44] 4.9.171-stable review
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

On Wed, 24 Apr 2019 at 22:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.171 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri 26 Apr 2019 05:07:31 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.171-rc1.gz
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

kernel: 4.9.171-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 31c9affd8381d405e30aae64cd373519e6a17134
git describe: v4.9.170-45-g31c9affd8381
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.170-45-g31c9affd8381

No regressions (compared to build v4.9.170)

No fixes (compared to build v4.9.170)

Ran 22982 total tests in the following environments and test suites.

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
* kvm-unit-tests
* ltp-ipc-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
