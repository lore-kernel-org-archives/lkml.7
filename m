Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D163C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 04:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AA621479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 04:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFqCXAfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfDTEwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 00:52:45 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34706 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfDTEwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 00:52:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id h5so5298562lfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 21:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CfrZodEoXxGWRn4QCnAeZ4nkoI2ENygvqosG1ox4654=;
        b=GFqCXAfsC4mNC+Yc1ZcriM3vQCfZY/lXb2C0lQOHwOhku2pCRgFMFhw/xs/oQbg/v7
         OJtjfaP5wfg2Gr0x/Hqr7Q47ePqHDk5F28dMmGES9eXoDxA0M4YRJoKoDLj9grT2WWv2
         /hY3i9S8kcslBWD7ke3OG20uhARMc1fCyHcYkEnNhtliRhQB5inlUZh0L0uMcFG3XTFJ
         75stP+BCLXE+ArYLbITAOZoEQEnjSp1GfNaQx/Lkjev/J9YGhlh7RdhE2CRrS/lqzG/v
         gYScbeorF781c2Z2PneiQc14bajRHk4ZO0xllP1sCTEkjnyTVvuLUE99J1+5+NJp1KcV
         Iciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CfrZodEoXxGWRn4QCnAeZ4nkoI2ENygvqosG1ox4654=;
        b=Im4eJWppTRqn1m4TG5DQ/KnkPkfFeKexIZITLUmqBrS2FW7MEN1a+RfdDJ+S8oMMnm
         /lDlpIIXMDQ034OmIyPkvKHfEmvfX2t4b9+LQzZ0kSaYwYILD+C7ijzhav4tk/cwZhY4
         n4B07vNZrA6HHRyzYFQ0/NoIspVLu6mT+J24KXeq3xQfEGKoiK83G9lwnE5sZqYI/whl
         Rt72T1fzb5Kg2p9rOFumUcsL4y6sr5Ad90BPs+SrVhxBguxf7lpHcrnGvE8MDNAkATrW
         5qe1yrGcNTnL7UxlICmC9c/IRkrMWQlhH1zaGYwbkUYqzZuPQ5+0Kd9QvCyH8B8VeUJS
         W2zg==
X-Gm-Message-State: APjAAAW46cSF9G6sPMzz1sEccSg4JilJfYK65uxDo90dxCyq/mdtZzPH
        UCy87HmtXiv4lAqUOvbuS2tCHz+eRChA/5zkl1M1ig==
X-Google-Smtp-Source: APXvYqxRtUV1qWmTSeTl9OcGRwtVdePy0KqgdYt0ysbyItTQEEmfleSTNn2daOAuwwP2gycSrDtcO/M8QHGYow0Ru7Y=
X-Received: by 2002:ac2:42d6:: with SMTP id n22mr4185773lfl.57.1555735963545;
 Fri, 19 Apr 2019 21:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190418160436.781762249@linuxfoundation.org>
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 20 Apr 2019 10:22:32 +0530
Message-ID: <CA+G9fYvS1-6Br-vxZ1VJQc2Bo3TSXLWwG8mCsV_LPq+3CNKkpw@mail.gmail.com>
Subject: Re: [PATCH 5.0 00/93] 5.0.9-stable review
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

On Thu, 18 Apr 2019 at 23:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.0.9 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Apr 20 16:03:33 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.0.9-rc1.gz
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

kernel: 5.0.9-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.0.y
git commit: a6b9c7d1cb06316cd1cea76371029603b6459de8
git describe: v5.0.8-94-ga6b9c7d1cb06
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.0-oe/bui=
ld/v5.0.8-94-ga6b9c7d1cb06

No regressions (compared to build v5.0.7-118-ge6fdfdbfcc6a)

No fixes (compared to build v5.0.7-118-ge6fdfdbfcc6a)

Ran 23788 total tests in the following environments and test suites.

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
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
