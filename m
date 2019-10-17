Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E0BC4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192882054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zjE7WN8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407800AbfJQGVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 02:21:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46744 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404695AbfJQGVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 02:21:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id d1so1175052ljl.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 23:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vJwljksPMBM6dZICB00B0fndAGErly1ln+LuF+3T1Rg=;
        b=zjE7WN8Zy0vPZUWHzZrqOD97ssZvZUOaL9dpeEI7xBaaBeXQE1LJKoBDcG+3XDkUhB
         DIyU5B/rVpwBFbyeDFMMYA9A245D7hrI30lt2yrK992oRHIJKoSuA/rzidJ/VLg+ptit
         SZYkPIJ09G8CKS/J9IPSZrAaQyokbacW3FpTnYSzMYyjFroLtsd7zVzVM3LHjJsyKxCb
         TVu5nTiE916jxYnqkGbsOoK+OUo/muc+Pfr9kwd0ImvQVO6T8OIQBN9ViPn7evumH02I
         Oh7HN9bQnu87n+Y+JIpxuAW3QVdCu1Gu+YA+7FKjkknUoSjqY3DZ2PwfwOgLL43QKeFk
         7BFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vJwljksPMBM6dZICB00B0fndAGErly1ln+LuF+3T1Rg=;
        b=P0xK2Dw/yn6WtaV+HdKYwjBoUW5s0CgVEDyAp1Fr2MC8OFyIaOAnkY+QrthKyCFQQW
         B7KvFR52W9eBFjOJPUsr/tfNQPFYjSx3W5RAHyMfM72BFtPpirBflHddwB5BmzYBdYZA
         Sr5YvHHKeqCl+BXNWfNcs3zUJZkikpZMjVMpcRG3blriw/EMJM1pS1FiXEUKeK1BdltG
         sMmO05HcxyIOW6LIv5Dfbyi/eF1Ks5XnhS4wEnseVp9RVG1Xj3t/CDzzb+MLLK3flj70
         F2nhK+BmcV3kd1CTxr5prI/u9sVyGNVA9Wc21J7SkRHQjYBLuogi0PvQxl8kGub/UH7F
         CWAQ==
X-Gm-Message-State: APjAAAXDZhFBRmWPgrySJ3UEkkC4bw1sjdn2km9XxHhYKp1CtPexZ4AM
        h1U5kOBgJSzRFxrxvhZ5pqUTWxmkSHgoDpB+S42ok+OkHx0=
X-Google-Smtp-Source: APXvYqxmmTxaeIoGxwbq8L1+RJyEQesoPePa6UviAVrooX49W5WsmJeeGXHxaWGK4+b7b5GbWQsKJ7zgLPRb3H0J8Fw=
X-Received: by 2002:a2e:9702:: with SMTP id r2mr1116080lji.194.1571293280339;
 Wed, 16 Oct 2019 23:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191016214759.600329427@linuxfoundation.org>
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 17 Oct 2019 11:51:08 +0530
Message-ID: <CA+G9fYtYEcvwRGpXFf+JnqZz+P=pgHZ4R9NAVezpSpq0BmEZvA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/92] 4.9.197-stable review
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

On Thu, 17 Oct 2019 at 03:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.197 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri 18 Oct 2019 09:43:41 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.197-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
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

kernel: 4.9.197-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 5749cdc967d4817de5000f6054619fb41b4f4333
git describe: v4.9.196-93-g5749cdc967d4
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.196-93-g5749cdc967d4


No regressions (compared to build v4.9.196)


No fixes (compared to build v4.9.196)

Ran 23358 total tests in the following environments and test suites.

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
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* prep-tmp-disk
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
