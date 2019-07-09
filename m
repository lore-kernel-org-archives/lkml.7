Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E126CC606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0E3216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Az8wDUbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfGICLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 22:11:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34902 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfGICLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 22:11:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id p197so12258847lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 19:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b2d61h/e8K7gOexBQzZ4oZE/XD/sRT3CTsvG5+H3A4Q=;
        b=Az8wDUbxlJdsuRoTLXS8WpGGYc5jVO+MA1eR/qCcI5Mq8AhJqHP35faax/F5lL1Odb
         bc/gcnb2WCIDMS0dF1vKT7pAXmPdkZ8wGfuyXw4ipLbUsprXxY4J3+k2AWCsAbkpfYkf
         slwrauPARr48uLoKMmsABzbBSJCcvgFN6Ga7ytTObRW8nTBuYvCdQnS/wpO8oqzk5sxM
         ZafCsFj1mg822AhxmBfU9Ji0DAMMgTPz4eEMlr4A94bnMO5oiq1hmVLTdjl33DzwUFAO
         CJMKhYYxhBfWvhQIs2lyIPVVR8SrSPfqLPoZRGeK2rW0y5nGojy+NJK8yraVkfKw6iU2
         b8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b2d61h/e8K7gOexBQzZ4oZE/XD/sRT3CTsvG5+H3A4Q=;
        b=p54V61kwE07lBcUpaskofWXIbouSg/lTxU3OJa5pTYkoPXpq9KovADWacgZuCnwjpq
         +tFAMyghuHd46OTBMOQRfQzwnHxllGOmspZCHH0jTHwBixrJTMcko4Ve5gLZWOYqdfFN
         Q47oYy13JHmNp37loJZigQBdjf9ocisI5OyuZSltw5NXubl+kGW6FwqLhees7bOFQC3K
         SQbX7hQ7OS7PHpMIj/KrVBXxG27F2fqhGHt3MTl/MKmnY21cnpMfnP8gvP4o96+edhg7
         +CrD82MleA/b5dVWQnFYT8FKg5dNM8EpmrgnHcHh3Crmghb2zTslMOzoNCDJhXeg/C7x
         pX2A==
X-Gm-Message-State: APjAAAXR/4szZFd4zmgDjjz6Nc7Gx3KzwnTivspOnJrLty98JB4DDdfT
        pTADmXBobwh9nXnWn8KZ52KNRAVPtb8xEoKMWCPlRq521GY=
X-Google-Smtp-Source: APXvYqyEXn5Zj5tRUTNMBjRTanMF9aoy0uQ9svpDftElzBhGVu2a8UNMWA9QdZkDQjIELvV07tM+mUdIrOEmWBXmb08=
X-Received: by 2002:a19:ed0c:: with SMTP id y12mr9946172lfy.191.1562638260033;
 Mon, 08 Jul 2019 19:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190708150525.973820964@linuxfoundation.org>
In-Reply-To: <20190708150525.973820964@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 9 Jul 2019 07:40:48 +0530
Message-ID: <CA+G9fYuRfaWnZ4x5PO6fPj9-8wQZkco-imJD8HGT35ePvAXqMA@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/102] 4.9.185-stable review
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

On Mon, 8 Jul 2019 at 20:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.185 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 10 Jul 2019 03:03:52 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.185-rc1.gz
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

kernel: 4.9.185-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: bb7044a09b6bd0f3b0a78afd25a4eb42ca85f50d
git describe: v4.9.184-103-gbb7044a09b6b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.184-103-gbb7044a09b6b


No regressions (compared to build v4.9.184)

No fixes (compared to build v4.9.184)


Ran 23371 total tests in the following environments and test suites.

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
* ltp-fs-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
