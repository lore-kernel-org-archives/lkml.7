Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166E0C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E355C2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oLIKcVxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfFRMej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:34:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41382 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfFRMei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:34:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id 136so9126162lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 05:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mS5RnvuKMOqlVsA7l+DtvxWKqOTIjTs/YP9uQGG4Zag=;
        b=oLIKcVxnz9IgOVdTuatFzk9cKxcOC9pl2aLFEZAHUgH75Dtfia6TJH22C2G65VmFz1
         IbeXyqX9QEtZJIHrdmhT2Huph1UYaCA04l374aUTnwowEkHwfS/1VBU/H/DUPOdrqbjk
         jnRl20Vo3VHfBF6EZy4Zyq8ocVi891nAO1eyXIY0t4E0MnOWJGSDJSWYPMDBHvi0CPN2
         5Ish1ieKg7f/sGXWANwnMMFknL6Cpz8X1T9tim4Lkspi2UoOrHg9ZQRTKLOIkZuI6PcM
         KZpuHggz16ZkhyUSr5+XrDxMmCIlVyzvJS9aP/gmz3NUsCvTdAIEV+hI+jj7hPKTiWBe
         p1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mS5RnvuKMOqlVsA7l+DtvxWKqOTIjTs/YP9uQGG4Zag=;
        b=IE6v/oxyxjgKWr3kcYUyi2GnCw1dTbx15QRbR/GQqay/zWEfMTr/KHR3SxuhtbBn5J
         Vr2wzw7AR3bc+VBtzQfgZ950trWVRWEClFLWgQ+NQlTIaARJMNF4RFcmonHMqPFp9NAD
         fjacGw1N/oukm81upAbigvUQJnoAaqQ6rawqvI1HZTpZT0bLh8dEvOfbXjEPWc24zcKw
         ASG8C8aP4dmdzdSnCmvBJI0niIHrgxP5OrMPRMITL0CQkoIQACURE601cxb0N1Oh0azB
         sqsGN5mMWoEs2dwS8fXxTFMBZY6GKbn/KLMIbzpSZiaKZ7AIrLR+BOO512fMA4L15iJ4
         Gllg==
X-Gm-Message-State: APjAAAV/OVr4LYlelS+kRbpa9H0ZBxUhsx1IwPSRu3rmHpSzcIwVMD5k
        bCT0biBW77frGtzsIcd9ec/wVbd65YZ/OSiS9IneXmTowfk=
X-Google-Smtp-Source: APXvYqxOQvAdJzvQbybKhqM925/XVRciuQGlH6JgKMdujokRD/VIzJBvMPzoA4gtPpNxqV9I+Zq3ObgXqtZlRc+eIaU=
X-Received: by 2002:a05:6512:51c:: with SMTP id o28mr42431131lfb.67.1560861276939;
 Tue, 18 Jun 2019 05:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190617210759.929316339@linuxfoundation.org>
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 Jun 2019 18:04:25 +0530
Message-ID: <CA+G9fYsUmFrTDHJfS=1vYVfv4BVRZ0AByEOHV6toidAxWuDqDg@mail.gmail.com>
Subject: Re: [PATCH 5.1 000/115] 5.1.12-stable review
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

On Tue, 18 Jun 2019 at 02:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.1.12 release.
> There are 115 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 19 Jun 2019 09:06:21 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.1.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

NOTE:
kernel/workqueue.c:3030 __flush_work+0x2c2/0x2d0
Kernel warning is been fixed by below patch.

> John Fastabend <john.fastabend@gmail.com>
>     bpf: sockmap, only stop/flush strp if it was enabled at some point

Summary
------------------------------------------------------------------------

kernel: 5.1.12-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.1.y
git commit: 760bc74bb0d3cb65cdc8af61a564384ba10374ac
git describe: v5.1.11-116-g760bc74bb0d3
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.1-oe/bui=
ld/v5.1.11-116-g760bc74bb0d3


No regressions (compared to build v5.1.11)

No fixes (compared to build v5.1.11)

Ran 22821 total tests in the following environments and test suites.

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
* libgpiod
* ltp-containers-tests
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
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
