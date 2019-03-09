Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725F0C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 07:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B6820866
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 07:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uY9RsVS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfCIHLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 02:11:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36906 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfCIHLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 02:11:05 -0500
Received: by mail-lj1-f193.google.com with SMTP id a17so19270597ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 23:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ex4V746TSXUfmeAKW6SGSnbXf0B3DrryeZbFymWZKKI=;
        b=uY9RsVS79l3cmd9uTFUrG+cwC/VSWjshplSFw4ysHQzicwlPdA97YCcGhwasikAhzr
         2+y/hcIk5ogTgu3c0YSZUN1+QPPcJ6nlULB38xdpjbD1KVMxE1FcdjHTJVOs9LtJDxcx
         MP0fjFFTZlM9G5UibTz7apdC5byflywdLenYpqunp/LYvH6XWSGIyBX7sLp9FRgX2Nqs
         cuMW0pNsqQS6Ho5e2W8Q3u7cu5PCR6giFP6PTcl0URRcM0VCQRb7/WGwlDi0il8ZwsIS
         8z6MyXQehJklxSTKgeZF9yI8zoCxQrAXWa8jJ248JgStvyeNdQhGi5amwPiK6Jl55Dy7
         K6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ex4V746TSXUfmeAKW6SGSnbXf0B3DrryeZbFymWZKKI=;
        b=NbZ6NxBD2zHpuARvIk8pj/RpOHq5+RZKkQLOgTNOETGSymnS0rB3Bbs1USCod/ow0v
         1/xKYGLP/GyuQk1W+Kxe1qr/eBzpjXwiTeEkqcS34zcqrVkEr+cXQn0x3iaKWrYiBL51
         vltzWTVD5Dhf1FLnYk+aSKNnvwNCxIP9AunliS02l59vHfjCeYW072Gmt5A9qQ3/vUZa
         IRULYItUe4UxaVyR96vUyQK6c9kZ/kie3ez8lBBHt6EmMX/eO/3jnb5f3M58ZdYd+jGV
         7+92tJuoiT1ilUQElXbr9nDGt+tqIgeoeOkSLaAkVU4X7+F8Hik6lO5fcGmf5m9LcKUI
         hmSA==
X-Gm-Message-State: APjAAAVlTxIYwOkA14m+6pZ6pDTvoBcRFiZbjFF+t7ISrM4xRNR0mgsa
        mLODoHyXzkEBac3u3ONLVFUqFI8OpNYnB93HTaeKvA==
X-Google-Smtp-Source: APXvYqy7PjF8ok266cCzpW/h/WKB0d1zpJKQdUn+dTBP8j6JDjehHNSso+ONG6wElxVVLpVx/d2nnOt1haUJPyNi2r4=
X-Received: by 2002:a2e:9793:: with SMTP id y19mr10808028lji.194.1552115462825;
 Fri, 08 Mar 2019 23:11:02 -0800 (PST)
MIME-Version: 1.0
References: <20190308124902.257040783@linuxfoundation.org>
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 9 Mar 2019 12:40:51 +0530
Message-ID: <CA+G9fYt20F5npxSv9EwTKs+huXHU6eEo2=VbL2QKFOx1OQ5vwQ@mail.gmail.com>
Subject: Re: [PATCH 5.0 00/46] 5.0.1-stable review
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

On Fri, 8 Mar 2019 at 18:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.0.1 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Mar 10 12:48:36 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.0.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.0.y
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

kernel: 5.0.1-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.0.y
git commit: be3f50196584696914e058aaa2aa5b06a4662f2a
git describe: v5.0-47-gbe3f50196584
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.0-oe/bui=
ld/v5.0-47-gbe3f50196584

No regressions (compared to build v5.0-17-g4b26bbfb55b6)

No fixes (compared to build v5.0-17-g4b26bbfb55b6)

Ran 23152 total tests in the following environments and test suites.

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
