Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10974C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D777A218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qguydYpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfDYF62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:58:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33603 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfDYF62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:58:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id j11so16545750lfm.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 22:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fVrcKGlNw1yGG70zsmIktYA+1roXIuFxt4ihMpw/G1Q=;
        b=qguydYpDbsbYd2XOy7jVOSO9+APBmrN2YqAVrLfbm7cLG+AHM4JnIcR//SD5RTBeYU
         7s+ppFcKkG1iE0uWoBAbdiyBBkDF5kHJ6UAqjf0kHEZdep6mKYmQrfiq+bRu3vVKx/8q
         GMDHP2uMl2bzQluSVl1hZH4CZlU+7J6hE8MIUnPUK3TgAsY5pXSTOTyOwNLXersD0AzJ
         KxyNJf9u6k4XFF1j/DnenmhSgjjTUCugdubjnXSIJ3Cf/7s5/Kc7VUvbkQ+AV3DAcl6o
         mm+CiUdHvuQn8pf83WbqRsupnsqXb7dD0797aQuBl1PTmgjZfOHFj0qEq53yjhNbknoT
         12UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fVrcKGlNw1yGG70zsmIktYA+1roXIuFxt4ihMpw/G1Q=;
        b=gyOKPolRTEfFEdlq9/VHjzreNJV9JD9wC5HC/+jtfgvmggaDuvb+rllJY9R+1d12L1
         Qx7/9wa5fExHAXhROr3NvVkllwOcCLef3udfok80bpVoDekL05sIZ+41CiYnpM/eTazA
         lGerBM3Qnjb57D+vi7nZxytfJe/wzEp5C5Mk3VOGICKQ3YZJc7wwFKMmFzkMtXE7RZ6I
         zfDUMSSJ4ocU4NlehhSQscL7e2sh2+VAC0BZcxsDFyzUEhARug7r1qJd6C1+Ovwm8fHz
         mM1kXa+QnNX3nfZ37sqn04U5rWSCiETmB7BnrBannQvL20FwBM01zppsGfDbr00iTY5r
         iA8A==
X-Gm-Message-State: APjAAAXaR23PfbrIxjbrPMe+Ji35SdoRgsoPWSGQCOcNrMuRVg5VpxyL
        3cf/4fmaNkMj7HeINowAa0bEjF6IT1bdA3zTihfDqw==
X-Google-Smtp-Source: APXvYqzBHYj2i4TcdY3Ofz4LdYBZ2/tJise1sI+uayR+OXC7NJ3RqOTlcfCholHhQ698hp8DKRG0yAgE1fTo4Jcf/10=
X-Received: by 2002:a19:1949:: with SMTP id 70mr11719825lfz.103.1556171905826;
 Wed, 24 Apr 2019 22:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190424170906.751869122@linuxfoundation.org>
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 Apr 2019 11:28:14 +0530
Message-ID: <CA+G9fYucTJ1QWSmERRU0wXESHYvn6hXbzCqrMV1+1dF+Hygw=A@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/70] 4.14.114-stable review
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

On Wed, 24 Apr 2019 at 22:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.114 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri 26 Apr 2019 05:07:32 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.114-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.114-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 68dd4895dd2accf3ed604dd5a2248e4fd804831b
git describe: v4.14.113-71-g68dd4895dd2a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.113-71-g68dd4895dd2a

No regressions (compared to build v4.14.113)

No fixes (compared to build v4.14.113)


Ran 23414 total tests in the following environments and test suites.

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
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
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
* libhugetlbfs
* ltp-commands-tests
* ltp-fs-tests
* ltp-math-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
