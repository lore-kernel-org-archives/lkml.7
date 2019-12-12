Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4280C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 05:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9981214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 05:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LeX1J7Ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfLLFH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 00:07:57 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34067 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfLLFH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 00:07:57 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so663561lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 21:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ak24EqfuSoiTkrHNDMRZ49rWPQkrtzEZ+p//LwAqXXo=;
        b=LeX1J7Ja6UGDEi3w0X9Jvy5W5G9UqKV1VT5p7kMAW+nowPqheO4eWjfYev1P5c0zCw
         F3SIBJyiqO7V8aJzrfBLXtApIHE1+aH+25Gh2ocEzCXvatnZSxq3c/drSEjzrXvtpgof
         83EAWN8aFluwDCLW75KAXgUiWKFbnYBP/oGM3AL0C+/vCptF+Z9mQZhvTyyFPhzq7Iu+
         ojngLjeXL+k/76DDmqmxJuKvCLppSuuv6e/K5xG6a3i8esWLFblASVcTGyZl4OpDKJDD
         BTvlXvzKPPiPjPTDBh6vdTC5APAYOmo1/ZcQ7HhdPAWUQ5o44qkjBB6ZuD7XjrBSu3p1
         YbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ak24EqfuSoiTkrHNDMRZ49rWPQkrtzEZ+p//LwAqXXo=;
        b=ui94o5aeg+iV+wHwGDU3pAFMiX5ZFYLUIAS/mjnJumle2vmNw0mhzFcB2fqsCldLD6
         a4NcxZDtTrefUkt7MqUAjcmVoC9I6RJPtK9GRLtAgFQ1dZk1TyxM5CT0L343tPniKbdz
         KQOABMetKGWwRKbN6a6kMfEly5qv49YnnTMyocbxUr7b9/UkyCD9keQ9m/YxnZE4B5oL
         5aAHXEum8ssRwuQ9zgcZy8de2Ggg22HeRinmAOwT4CIfylqbyANPSfisBmySgb5CLqFd
         lpoxy2m7GnFkKoSqxr9Szx8v218r+LqMujr9zb1v3za2Xac9nrQanvTrv9WMgOPtapfH
         i21A==
X-Gm-Message-State: APjAAAWLemOijFL22+pMe3s3+L0fIdChi3T7zZJh160uERpciVdH0Cqz
        H9bXJi16sxinRpeETtljTc374xcUpC0AF4vQWV59pA==
X-Google-Smtp-Source: APXvYqxKr+PWrP0+p0uZOFggLzKbVSAt1wVrRNXMtNFHYtl/+ZajN3jLbQnSWoAQQRdoUeARYZkWF8nGAwAoi70qEdE=
X-Received: by 2002:ac2:4a91:: with SMTP id l17mr4507584lfp.75.1576127274729;
 Wed, 11 Dec 2019 21:07:54 -0800 (PST)
MIME-Version: 1.0
References: <20191211150339.185439726@linuxfoundation.org>
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 12 Dec 2019 10:37:43 +0530
Message-ID: <CA+G9fYvpRtUDaNRpbCO9RKEFG_0qF=FWYjiy575RqFzg8YkhkA@mail.gmail.com>
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

On Wed, 11 Dec 2019 at 20:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.89 release.
> There are 243 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 13 Dec 2019 14:56:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.89-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.89-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 62dbca0959b37287a49ac6a949578849d490df83
git describe: v4.19.88-244-g62dbca0959b3
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.88-244-g62dbca0959b3


No regressions (compared to build v4.19.88)

No fixes (compared to build v4.19.88)

Ran 22458 total tests in the following environments and test suites.

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
* linux-log-parser
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
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
