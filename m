Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EF1C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 06:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F1C205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 06:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDn9BDTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfEJGhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 02:37:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44030 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfEJGhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 02:37:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id z5so4084133lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 23:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dDjtLoV+g4xy2332cvIu8FDNJxtwUQ2tO38cCGm0YQY=;
        b=TDn9BDTgqTF18lV6Y9Q/zpvWXhjJXDjRAtDmEBLF0uOlgxK3GaUm3gPif2kaAIkWh2
         iVzCGcgHQ75L8bwIcFHzPaLfpN8b+0UPC5Q19E3IxnRgqlCcnE+0maeNbOUznXrjknZf
         s7AQwJ/Gno/TVHopsap+uSg0GkfB6QgOvfpBCAZGysWKedZeDyV0f6yWK9dOOnVT9v+3
         6XgmXbdUbYQX8ao8jBxEO/VC0tdHfoTwkS6IeylriOcIAvbPpGQWDAbuzgr+oYvhH6GQ
         uIH67wVNY2FAjg1Dsb/r0h81ghpxlteIVDGLtkax5kIa3KtQi/WWUkF43koYoUijEekN
         f0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dDjtLoV+g4xy2332cvIu8FDNJxtwUQ2tO38cCGm0YQY=;
        b=L0bqFf41gveOyOfmEZz4PV52leHuf9IB6VfYpt1SDRt7dQVTxlkmXWi5hAGvN1rzDa
         sPvGIeGodQiO9G7krQs0PrZ24MYnvROv8am/pnzq3p/rx2YoQ0/fNNw2PDZlgtD3SwzO
         IR4R3r90U2Lm9F7qMio/iHnpprpg7k6jkMG6v6P8Wu4wgKAaZt17L2Q2ZfzaDa5qYdwk
         +XvdABwo6ghBwkVCrMwALqlUSAMbCvOZQvHw7BPM5nndDkoOoToNekez5jKVThtvCuhg
         22eDUo4+yat704IDy8xcyHEwEsUJZ4LT60UToSJwPQMakaiPMUXHpJdNTgw3tUpF2N6y
         Ug7w==
X-Gm-Message-State: APjAAAXkZKhNVDkY3rGWaY101P/fgNSmz14DxmcsZwG3InL+vGPkwk2O
        kqoUDlYcfHZtK5lI0pByrYpoK43VU2W97iCG6oKQlw==
X-Google-Smtp-Source: APXvYqwWe7ViNXHczZrFZNkQUdAzrCiLGv/nAdovj6i7neR/CCUcE6e69I3OUd+Bt0eZruHLMWQOIDUsU9hkCNs3SV4=
X-Received: by 2002:a2e:568d:: with SMTP id k13mr4712010lje.194.1557470237752;
 Thu, 09 May 2019 23:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190509181247.647767531@linuxfoundation.org>
In-Reply-To: <20190509181247.647767531@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 10 May 2019 12:07:06 +0530
Message-ID: <CA+G9fYvCwWPpF8MaKWkOhmV9nZR1p3MQeUhjF7QWa9rabcGfaA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/28] 4.9.175-stable review
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

On Fri, 10 May 2019 at 00:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.175 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 11 May 2019 06:11:12 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.175-rc1.gz
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

kernel: 4.9.175-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 50bbfeb1e2a357db99ff35681cfa95341b33103a
git describe: v4.9.174-29-g50bbfeb1e2a3
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.174-29-g50bbfeb1e2a3

No regressions (compared to build v4.9.174)

No fixes (compared to build v4.9.174)

Ran 22312 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
