Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0EAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAB720880
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y3qkyJ7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfCRQYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:24:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44927 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfCRQYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:24:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id u9so12078499lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SiqMnfm5TZ2LmVE8Ai51nyuWZVO7BZO00d5xRd/aP0k=;
        b=Y3qkyJ7awtnQx8XjVr6NiOdtQ0ATgDHnC+1yX7TqVcHN3daq99lf/G3Ed+75paUF/l
         12jpYS3ZY+K9CFXmMFrtw8Lj2U7bxSxCY234Afa0Gj6WXOm2TTnRTwenknz1YvHoT0ii
         R9OjTPp3bpFv1K69ZyKBvtai0/UG4eOKIUAL3kG+gIrv+7+Nvic7Fjp4llB1xKm94Yz1
         EamHaVLptPzBIY8kSnyc+80WlqYzH4xTnhEnnzisXKqKt90A69cmmCeKp0C8509ecAk3
         FwH30BXElalSaGZZNgXD/7MpTY1yrey8N5odgbKLBpcVDa+txNQVmr1k3Jm1kaoT0PcS
         nxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SiqMnfm5TZ2LmVE8Ai51nyuWZVO7BZO00d5xRd/aP0k=;
        b=U8mtS6qgvmxU3KcBVoflyuMJtmEP4ob1tzmr7dUx2XAzQVKeEX0n6XXOeczwH5/mGd
         gazd05SIAzqP635/fe6BrSSrAxR8tCu6wTHePOhjYjMwz+9mfMolmehFhLlQgVax8SUB
         wwZ1TUKAMSZ9TVO+XMiNJ79c4MA8AKKkOwWzg0z80e4Nle0zKJYwlZbTCOeiuSmiJraK
         kcDV/sCc6sOA5YE2u8UCYmP8AQLcyhTMFAtu4kJg6agZJC2ip9PjgqVjNxeLd/S+E20n
         zhcOVCjt8sGbbEtdIdpx+XdCrOOGSgkIsuYee6EkxWzTM80CEgHzdSuY+Nwwyvu1Mg54
         pBhA==
X-Gm-Message-State: APjAAAXxiGhbVsm7qZ/L1n6DoaByqaSLVrO0snujI+W2aS0xovQlWiZI
        EWKZvt80cd+ijKDPUrIMd9ECUhLPSSTmr6dfMaLi1A==
X-Google-Smtp-Source: APXvYqzsQtKMdknuILbv+s+Oqkrv1ygbOV0xZuDKFxI2EeETkwiqObqT29Px5Xl64PnmsvQ0nOhxfiRQLCYKZ35wB/U=
X-Received: by 2002:a19:ef19:: with SMTP id n25mr11172682lfh.0.1552926239532;
 Mon, 18 Mar 2019 09:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190318084210.397476003@linuxfoundation.org>
In-Reply-To: <20190318084210.397476003@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 18 Mar 2019 21:53:48 +0530
Message-ID: <CA+G9fYufPYYGHZNA7vcU3Be9_Rw2RO4HSf_s4ebXXe098t1tVA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/31] 4.9.164-stable review
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

On Mon, 18 Mar 2019 at 15:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.164 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 20 08:42:01 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.164-rc1.gz
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

kernel: 4.9.164-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 631b5fe18b599ae5cdcb38801e9581e46fcccd76
git describe: v4.9.163-32-g631b5fe18b59
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.163-32-g631b5fe18b59


No regressions (compared to build v4.9.163)

No fixes (compared to build v4.9.163)


Ran 22693 total tests in the following environments and test suites.

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
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
