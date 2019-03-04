Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B5EC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42644206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LGUwTvtb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfCDSm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:42:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34111 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfCDSmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:42:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id l5so5250104lje.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 10:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sAVKJLfR2/0/hXyK9IveKJMuinQ06nFz9F/bf1iroeA=;
        b=LGUwTvtbb8Wx1QaBIk5HR/xJWFCmyD5+NFRTXusBVkIdfkJyMORUQL6dOK+c3DRlRB
         VVMflaBGIteIEN8VLluVUcmqOZYqGmAAejS2dxwlfwrr846BLJolNjLsK9ciypDD7Qx1
         GihFsGaUkNMCMS9KC+RUX9zsIyE6bEw+oDoq3JKd7I5wCGUZm1RUYJWter8d8yjbTQ++
         4HddpeUVYQoE5KhSdVQuivi5XrcMHU2+w3RVYuA0a0TJrT2AealJttAcPX0/JZSR6OFU
         fe/04hbcpaRqCBgQbyZGHGvOICEgyQFFowiYY03+g8WnO/ndxBzhzSfmECgyhxQQnX5I
         aevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sAVKJLfR2/0/hXyK9IveKJMuinQ06nFz9F/bf1iroeA=;
        b=oxzhQ6Ii0Xd7kgKfLp07UC+wmzmDrhdcGCE089xJG0Tcz7stI/avB5bXSV+cQnq2na
         zkxt9VdfSnqNGTQL0A+KzuzTEP/+tEsNzjHtsfIjjUwMw8w1D8lMJIZePAn2017Nhf3O
         Em+zCbhsECL4V8UoTHhv3mJb2aohka9cmlNZIct4ZSbZKrYZtlWIcTrAMOhhaoYVX5/V
         74DevmmZJyyTMUNKVGRVz52CL6fong9FodDo0paSmvR/W45tQvELfyOQ4jwEZ8t9yjUf
         KJPc7l8j7GgJxsqbwnXjIDE0nVT4+PdZBgEYwGJ1/ts5TwzXZLNpt1RBbdVuD103ilD/
         50JA==
X-Gm-Message-State: APjAAAWiStG8CwkqWgkOg7SkP/AvBFCRsi8pmBrmtNerteghT6U0bESO
        Ds3kE8t1jQ9aMnAJaaZY/ZIIlVeqSnHj6OBYhIcN7w==
X-Google-Smtp-Source: APXvYqwolq2x7fjWEHJ58hBKLLDnFCuXxfop+2/IYAjJu8boX1pMhuslcxfucKKj8Fz/s3Gtb4iqb/OQ7+IgeSKHFf0=
X-Received: by 2002:a2e:3807:: with SMTP id f7mr11411982lja.9.1551724973511;
 Mon, 04 Mar 2019 10:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20190304081617.159014799@linuxfoundation.org>
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Mar 2019 00:12:41 +0530
Message-ID: <CA+G9fYtWwESNwy+Lxz-1LWwLePFfC9QJ6Jt6SgGNPcrSTF5yag@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/52] 4.14.105-stable review
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

On Mon, 4 Mar 2019 at 13:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.105 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar  6 08:15:55 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.105-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
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

kernel: 4.14.105-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: b0f58e2dfb7cf26c240d8e0fe6e08b5d11976e22
git describe: v4.14.104-53-gb0f58e2dfb7c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.104-53-gb0f58e2dfb7c

No regressions (compared to build v4.14.104)

No fixes (compared to build v4.14.104)

Ran 21829 total tests in the following environments and test suites.

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
* ltp-dio-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
