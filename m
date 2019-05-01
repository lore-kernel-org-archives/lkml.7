Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB2AC04AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 06:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D63A20866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 06:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nTGnvuPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfEAGCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 02:02:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33697 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfEAGCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 02:02:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id f23so14837516ljc.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 23:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7HdZpXE0HHdmJXfhsZA0aoR/+VevFbxfmo/ahj3IOT4=;
        b=nTGnvuPQZBuuK2YZH2d1t/h3t2VnAltLJ+dnY0zEQ6HOWiIGOu4E4YC6enDGsmbUQQ
         W2gYVWY2snnvVIRZQkd8mhsMxLhNX+Orr9aQe98jFYE06a/xxo/nJEp6AEAdhuvMvSx7
         4mArBDNWNomvguzR58kljAmLB6PlLiESqcLKHpw868Z47dalOHL2QXynuvf2vgcOL5mv
         TPpyy+xIvy4hPEUl9KV7kPC1npz0r9jPMusQbjOqa9XwsDASgtFmZF0P5le0lOFr/V0j
         DwkpDFy88vQ1uHF4SnMdi/dIIiSu6lEpp8V6gj02vIpa3bewtDU3nyDegHdn8jd+lz1i
         GDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7HdZpXE0HHdmJXfhsZA0aoR/+VevFbxfmo/ahj3IOT4=;
        b=XgR3ColIttmw5q5CFFIXDpscpIZiswQdp+tEvDkyKbqJ4pYQVKSLBgVmsVVyIv6jZN
         hNOQlX3REyaisICuFe6rpzj87e4lWS/nLfHiMACL2SvO7VacHTMVQbziaRGQQU6Iom6p
         1390ZQogxvkOfE1OBKYLCDFvlftZpJ5sZamk1rWmsJ32WKWZiWnfbQk6iRdZ8CV5OzIU
         qGXV61pZvrwDhzvU/hjDTTVGJxAGEWMnIuAdqs1lGQYnv2wZ0CBxWxgLMg+4PfRYH7Q8
         KujFdDh0+hx47g1CRxF2a5/O9W4HzQBINKIOJxrXPzzobgdNi3Jd8HCRyIN6oLWd+vjQ
         qbNw==
X-Gm-Message-State: APjAAAUBePGWt3zxcQ4tqGpPnmL7i36pPnjtM+oxKG841Ph7/IohoO8n
        UEcYVWlEcVr345gARx8CMj2tixurFOJbkfG5Dl2jdQ==
X-Google-Smtp-Source: APXvYqzZp0AuA/8B2FJcPdMgqV4w1XXo8YcWfTrdW8pyrtLVdzqWgYzvHondsqM5BafFwXGs7zN+WHIX6/nWDKevRJg=
X-Received: by 2002:a2e:9dcb:: with SMTP id x11mr3762924ljj.123.1556690518792;
 Tue, 30 Apr 2019 23:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190430113524.451237916@linuxfoundation.org>
In-Reply-To: <20190430113524.451237916@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 1 May 2019 11:31:47 +0530
Message-ID: <CA+G9fYsy5K19cBWtqwsJ6sNFOLSj_9DGEo1pz-0Ykb3Ez7Qsew@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/41] 4.9.172-stable review
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

On Tue, 30 Apr 2019 at 17:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.172 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu 02 May 2019 11:34:41 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.172-rc1.gz
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

kernel: 4.9.172-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: a707069e56d0b0365daa528a05c6388b41cfe4fa
git describe: v4.9.171-42-ga707069e56d0
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.171-42-ga707069e56d0


No regressions (compared to build v4.9.171)

No fixes (compared to build v4.9.171)

Ran 22955 total tests in the following environments and test suites.

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
* kvm-unit-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
