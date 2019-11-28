Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CF9C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F50D208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sGxqYLXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfK1N3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:29:31 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33765 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1N3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:29:30 -0500
Received: by mail-lf1-f67.google.com with SMTP id d6so20091907lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 05:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iUl6g4ZG+wDV0G17ul1kD+ARP55ICE5OtOglq5iOgz0=;
        b=sGxqYLXpCyyHDIWmSaxWrLXiPHaoECIuxBeJiovZdl5emAyjvNwHf+eUHGsZIcYZOA
         HUhn/b9Q90F3VX5TsO4oQjOHCdgdVK4c64+uVzl+mKWxXdDEQFL3DZwIGCRXgqoJiWZ5
         Uxqh4KjbeGTPstR/dHplpjOr4ugpmY/w2frptEvTXWb3Xr/j8ElxrN4pVLwlkyRUkpBD
         mLMGb59u1Ygqpeb+V9jaZtfrZponJbvoSoejPylbU5tUDWccFCQ7YWzkKf4sTwlznQ/p
         hVIBAf+hXBZbpOHrWtWpGBPmTiMZXM9elt0sT6miF/Ltp3Q7kzp4fAqFGDHcU5OoHVTP
         Rktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iUl6g4ZG+wDV0G17ul1kD+ARP55ICE5OtOglq5iOgz0=;
        b=Y38d3PVMcIhFdis4XJny8K7PliRWScA76HfuUZiTxs1vk22kKKSOCBg2QSxct9wZiv
         vCFkaCJV6AQvLQcPHACkzJo83jKqTyF+iagGRI98g2jJaIJudtbX/jeoI9FYnHRqgRYc
         FjJ2wddV6A7v8TBvj8QsM8lS/YlfM8hhspa4rkWB92QTFt2jyJiRvKib5WEtLDt73lWx
         6DWcN4UNJBKDcdDDyydWIBXgY1Wyqqbk757JfqmqmlIzkkZFqqA8Pi+pxqeK2vHvgJnA
         S7kJPG4CO5C4OoSRdHy3dc2EGqGKCrndpB1W+wyzFWVVuRB5yzOPZ3g976x/YlfxY3Pz
         afuQ==
X-Gm-Message-State: APjAAAXb4ATDTGRTkaOV66ebQBUaTF4kOW1U/Z3pjV+d8CzzQBjS8Z10
        0hC6R0lcZUtfXgzIS5PLlNh32JA2dRQ0tVHyBwdz9w==
X-Google-Smtp-Source: APXvYqy9ssoAEBTSBtcfzRRSsapfFUjRyzMCo+M15XsAK9DQibBgGVQW8yp8l47pJpL2aNqcohQDTZvV3gfeX8HKjqw=
X-Received: by 2002:ac2:5b0f:: with SMTP id v15mr20796774lfn.99.1574947768629;
 Thu, 28 Nov 2019 05:29:28 -0800 (PST)
MIME-Version: 1.0
References: <20191127202857.270233486@linuxfoundation.org>
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 28 Nov 2019 18:59:17 +0530
Message-ID: <CA+G9fYs-ugvOrYBZbmieSK1rQrcRh6R9cL3Vz8xK59sB3aAqyg@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/132] 4.4.204-stable review
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

On Thu, 28 Nov 2019 at 02:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.204 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 29 Nov 2019 20:18:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.204-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
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

kernel: 4.4.204-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: d7e1aa334904482d6133568d82815d712c9705b1
git describe: v4.4.203-133-gd7e1aa334904
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.203-133-gd7e1aa334904


No regressions (compared to build v4.4.203)

No fixes (compared to build v4.4.203)


Ran 20052 total tests in the following environments and test suites.

Environments
--------------
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
* kselftest
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* ltp-containers-tests
* ltp-fs-tests
* network-basic-tests
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* prep-tmp-disk
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
