Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C237C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED8F20811
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0uufFQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfDYGFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:05:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38416 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbfDYGFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:05:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id p14so19083543ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 23:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b3RSKSGMURB5h0Ujfb4VZGFkfOTBTXJnavM4tHbxe4g=;
        b=s0uufFQZbG2VceVQb2s0c/VCnmt1SenuClKw/taE1U0PP73+R7Ak3ix4jHJGuqSFZL
         HyBbv9vEsAUNr2sv24+QAL6VrYPFWhK3lcXyZLHLuT/RSUcbsCtF3Tgo48p/qR+JNp8u
         4ZFAiGvhI//1RLx8dfP2EvluGPH4Xas0mwjv8xKADQcW9gRGXyDN/6DHgIeq8Tuk5J/R
         /dFxYGbNZd9qWMg+xvJal+Mk/4j9tBm3xuifgpoikg0q3XS+mAfIZaU+nB2wqV1/ALmI
         kxuU4FDxAL7LDHcFsThyY6tZ5bWfSB/QGHa13fC+y+v4GIllPuWKzMyLbVgNcaandJZc
         qnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b3RSKSGMURB5h0Ujfb4VZGFkfOTBTXJnavM4tHbxe4g=;
        b=A/O/XnBjKxmRtyuwiJdElLluzn+JG7jXrMfV8od0Sa8huy/LH5vUil3P16oyuU+Ep6
         PST5OemUUs7tNziq8Im1DjMO7TRBSJwxMvoRRQAvCfzExykFSLUdUtwRctFIm9Xy03YB
         ZEw5Kzf0Zh4I8zc3nDtUYsoqF/KDgcf5SNVicnOAI1mrO/xqZHcn1nHGL6yaFeDo6d7l
         Z1RhiIlauPVfYqvDiqzg9H3JppSdCZVpE+L/9U/rdI/FndW6eylWEyHvSGv/IF9N6+06
         7/D23zkxXEPVfieSGQD/2DFWF+mHd5v08TqTlX7e0B7lQmmgTgIQqGfvhq129KWXC3zD
         DqJQ==
X-Gm-Message-State: APjAAAUxCmOKCj3CsE5y97otkEPbBC7tLMj7gfyqFxpbpHLtncB4fYzZ
        7SBt2AmjcG93CZoP2Z4JCv6lGbM1to4049/A+YtAyQ27Rpw=
X-Google-Smtp-Source: APXvYqw8Tdgn3Bqz4O3FfVbZn8rAebq1G8pH0bcD2yOoe7BvyytweSRKK6yA5zABlMYzujpg/Mi5SFcF2aq5iPt6Ttk=
X-Received: by 2002:a2e:9993:: with SMTP id w19mr4429118lji.111.1556172338552;
 Wed, 24 Apr 2019 23:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190424170919.829037226@linuxfoundation.org>
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 Apr 2019 11:35:27 +0530
Message-ID: <CA+G9fYtxT+OS7EGmN-MtOheAD1f-OOszXOmP7Q7cAD4LUR430w@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/96] 4.19.37-stable review
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

On Wed, 24 Apr 2019 at 23:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.37 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri 26 Apr 2019 05:07:35 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.37-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
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

kernel: 4.19.37-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: cca3bd6b49acb02c8bf1a9231efe069edb667d03
git describe: v4.19.36-97-gcca3bd6b49ac
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.36-97-gcca3bd6b49ac

No regressions (compared to build v4.19.36)

No fixes (compared to build v4.19.36)

Ran 25017 total tests in the following environments and test suites.

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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
