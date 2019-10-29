Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E79CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A984B20578
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fCQ4ACvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388543AbfJ2N3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:29:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45129 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388529AbfJ2N3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:29:32 -0400
Received: by mail-lf1-f66.google.com with SMTP id v8so10506911lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xu8apSxRKH3HFmHAIww+OjNpsskAxGY7U9dHEs1Yj34=;
        b=fCQ4ACvx8jtoiDDKm15+5oLsiHRUid9NDgEVy2XBjYAzdqVgjZLYoPbxldFUvSMWIp
         TNzLW+f8MBmaszrgu99ii47/rUXykX975ucUXzxC67Pk8Ozm9nF6izFQuoNeq4R6kPqZ
         1lOzzcOHqMZDhAUVDrAz4wKg8wnT50l9MSqdb58MWrO/D+VrI17lczrpmPhnI3REDsli
         2ZiPRM5i4byGpWvAlbNJl/YnDNA12+Vg3oe63+A/7YFUSpgeUbjrTVdl/GZRFcF6XUWb
         aD56Pn0HZb03J4V1qEfkcnOIj0xuI6KGJ4W9POXhxhcSrZsmpAxCWYeTqsW2uNP9nbpw
         qNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xu8apSxRKH3HFmHAIww+OjNpsskAxGY7U9dHEs1Yj34=;
        b=ixFEMBJwDPlRtlcXcgIiSc2Z3iDuTtwisEmK3JAaOdOcUKz64YMqup0h6ZbkPLlzvr
         XTZYR+QLQTDbVfNpTagc11xQQjLWGaOsGOf0g+F8WJEe9JYPocvI/z4XJRr2/p+u8aOf
         Q9AvvnCTey8SJL/t9DL7xBuWu689rVQRIeoajP4YUuQZpbDLjBo9lk/4Sk2i4ni5u8au
         51IiZ634UcZpjChYgxBDOOsU2qKtoB0HYXt5bxh0ynM898f/D2+mEWLAM2piw94uJkMq
         JqFGSZaoSK9vjCvKmvi1YokbFwx2aKr6vXRl0Q1i3eqPZjspKTgyAW8k38AKO+0SEiR0
         pLeQ==
X-Gm-Message-State: APjAAAVOwPTI8ubjXHIbbE0O2Nn5kznikJvBtWyrTXTbS5mlWdMpDyaV
        FZD+Eeboqhvp82mV8essAoaBQWvm7ozyO3uGVX5OJQ==
X-Google-Smtp-Source: APXvYqwnUFOcokWRMSlEU7lFeUIhO4qkBj+lBlMcEbTZL3TiNXXGYmK//HoccMXo9/EoMJfn1EOq28qfUafDb1BrMwM=
X-Received: by 2002:a19:9116:: with SMTP id t22mr942866lfd.99.1572355768687;
 Tue, 29 Oct 2019 06:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191027203056.220821342@linuxfoundation.org>
In-Reply-To: <20191027203056.220821342@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 29 Oct 2019 18:59:17 +0530
Message-ID: <CA+G9fYsH31J-d27n59SWNuJFiZfZpT7bQSn2axOEj2icFvg52Q@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/41] 4.4.198-stable review
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

On Mon, 28 Oct 2019 at 02:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.198 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue 29 Oct 2019 08:27:02 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.198-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Note:
The new test case  from LTP version upgrade syscalls sync_file_range02 is a=
n
intermittent failure. We are investigating this case.

Summary
------------------------------------------------------------------------

kernel: 4.4.198-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 3e3483176187700a1041c9c454d38c9d361d6a60
git describe: v4.4.197-40-g3e3483176187
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.197-40-g3e3483176187

No regressions (compared to build v4.4.197-42-gc1c6537ef129)

No fixes (compared to build v4.4.197-42-gc1c6537ef129)

Ran 13332 total tests in the following environments and test suites.

Environments
--------------
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
* ssuite
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
