Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE656C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B708720850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b8L9zdz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfCSCyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:54:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37820 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfCSCyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:54:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id u2so13163664lfd.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qsDPjNkxr6Ikn1pcISydoKNul4OSctffc0IO0+a3pEE=;
        b=b8L9zdz2YM1pTRR7oMVSP7v4olYcNEliFcvQs1ifA+wyocFUUefLeD5DCLjgnykiFr
         Jfi9lPr4EyIb2F5X72TYS8gfc71Z9LjjOxcZZLAqKY5gmXxxZXSjfCap4Yv7Oz1u2M+Z
         goLiCghbjwi9BUAFbtWHRP3YwFoMbmZP6qHb3/18y2r55Icq3kR2coKFoaCaQPbeedu1
         cK6guT+sgY9y4yQiCtxKQvxtJxv13RzFQrlRuM0od0KNx0LMpsaSYOx2R0qlgpXPW/JI
         f3XlU+JVr0C0zgAgJdJCkfJdrv444emb2T1sNXIW2G8h9V9o8PWv+XmrlStpV8i+iDWj
         izew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qsDPjNkxr6Ikn1pcISydoKNul4OSctffc0IO0+a3pEE=;
        b=UwIZZYe2eIt01Kq178O79FZh8S6lMeFO0eEVodvK7zBDl6KX0rOvGmtPS/v+UeXVud
         kCK3WGDA3kcC2UKivxlaI+1vy91qg7Du3L85BVIEjG87uKU41kPnwvhScfqOOUzvZT0w
         tdB7uzzQMIKDA43tMR2Ce14T+QFMLtbTK5YyG2TyQSeZpAuVV2SgYsTnfqyaHZsBnumr
         l3gCPs5sLAYPuIy+SGQxSDfdNGEJZpBZgR4N92mEM77Yguc63T5L6UoKkQnSaQU/uRuw
         cmiDDiDWOQ4jmxmNzuCVT5gaKLch3zUjyugwU5pAcQCaXV1rFSV8DJM0D0I0GVcC9fXV
         3zsw==
X-Gm-Message-State: APjAAAU+CiIo7Y8yVVN8GEhiRr+rUI6YG04K2R048iq7xeWVhbIMrC1B
        ukb8oAQEMDS2Mwewyuq1eOJ5JNG8PFAz4NHTUWB8Fr8ytDk=
X-Google-Smtp-Source: APXvYqzDGooeRacfMqYN4K/3IkEuR7PmECLvQrxbpEzo7ewak3LrV48tdaqzjmhz/uoMSTkd9wAEyapib06wa7MXV+4=
X-Received: by 2002:a19:740e:: with SMTP id v14mr11408994lfe.94.1552964077198;
 Mon, 18 Mar 2019 19:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190318083715.877441740@linuxfoundation.org>
In-Reply-To: <20190318083715.877441740@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 Mar 2019 08:24:25 +0530
Message-ID: <CA+G9fYtHRmRKYdNXWQNsjzmTf4_G1BMmTyXbGiJ0B70twBWKsg@mail.gmail.com>
Subject: Re: [PATCH 5.0 00/43] 5.0.3-stable review
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

On Mon, 18 Mar 2019 at 14:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.0.3 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 20 08:36:53 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.0.3-rc1.gz
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

kernel: 5.0.3-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.0.y
git commit: ec6582f51005a29ff2e73fbfa43df92f456f54ca
git describe: v5.0.2-44-gec6582f51005
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.0-oe/bui=
ld/v5.0.2-44-gec6582f51005


No regressions (compared to build v5.0.2)


No fixes (compared to build v5.0.2)

Ran 23099 total tests in the following environments and test suites.

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
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
