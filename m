Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF313C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBE4208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HN5Dr4rf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfFMSj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:39:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42999 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfFMSj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:39:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id y13so15859007lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zhnffrfz5nZyBtxW2a41/tZfwftWpsUjhwz59SaODwM=;
        b=HN5Dr4rfiwkuocy9IH0pR3iqpRySJLbDADNeiPg+mqttfLSuaDn/53bA4h0oKBwtMt
         DYRXn0yQ5hOCxnNmDId7Z82uELL8s+dbY5OlG9tymy1d5NpNZ5dUjKZh7lbpb7g3aiHC
         ds3PCK0BmhJjDsk2YXlEtQcX0Rm11cRe+6RxwYCBnpKoYGJ1retDOdFN7EsaE2pbcbxN
         402AynkRh/4U0d3sgec+8sh5WMq3k1TptJt0IjjtooL5lKXSCdShDW1PqHfUAyNdtRW0
         qoqrT2z6UJiWOSLV9FqgqMGXJ7QzWze3QE2iOKwOzvA4SFlDQHSgGxOp25C6+/SerrwC
         hy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zhnffrfz5nZyBtxW2a41/tZfwftWpsUjhwz59SaODwM=;
        b=FA8BQLiciWfJZyOoSoFL3qgMKwPUXkz/m5zq+4LfqOFvOa7tKmITGK5SbZWZ6KYCJ+
         gV5BVrUG5lAQ1F/XPwwysXL620Y1JObix6ASq+LX35FppwOVJ/KfV/Q5v2+39DcbKvWH
         Kndy4oC3KrlTDDL3Z7ia/GUdW6q3hdbv/4465LoZiumyGcVdIddY5T2GOLor6fOxnDnk
         TrjbmpS6zuFRMNoCrf4yHPOScp7DPTIytPmGDBaqC30v4UwStKBp/wAzmdxWR9cpm8zj
         tOCBlwK2Fep0oYBNSiylkYyko/pkP2PzbX+psdjahmtPQLmnCHeppx/AnGBkZJvv72e+
         vbaA==
X-Gm-Message-State: APjAAAX2ieJ6+FY4uTWFUyuRdDMSgJcGHSiGmGnoMRN3O/a5GRfZZGjP
        ohtxdhZVs7bp2PHE9GBzZi+9R+w+GK03XNiGqucFmA==
X-Google-Smtp-Source: APXvYqwB8ibiY25D7G0qqULRnpwIt8vPiRMqv8qmvd6Z14aIpEOYlpUfksjAxOqiNTXnxdmOyydTdiESfikz8uTJycQ=
X-Received: by 2002:ac2:482d:: with SMTP id 13mr2201932lft.132.1560451163907;
 Thu, 13 Jun 2019 11:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190613075652.691765927@linuxfoundation.org>
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 14 Jun 2019 00:09:12 +0530
Message-ID: <CA+G9fYsRq=DyOWhhPq3axyhLVBWLp7-3QZ3p5dSScR06ar5SZg@mail.gmail.com>
Subject: Re: [PATCH 5.1 000/155] 5.1.10-stable review
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

On Thu, 13 Jun 2019 at 14:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.1.10 release.
> There are 155 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 15 Jun 2019 07:54:40 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.1.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.1.y
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

kernel: 5.1.10-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.1.y
git commit: b7eabc3862b8717f2bcc47f3f3830ec575423c8c
git describe: v5.1.9-157-gb7eabc3862b8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.1-oe/bui=
ld/v5.1.9-157-gb7eabc3862b8

No regressions (compared to build v5.1.8-72-g2df16141a2c4)

No fixes (compared to build v5.1.8-72-g2df16141a2c4)

Ran 23163 total tests in the following environments and test suites.

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
* build
* install-android-platform-tools-r2600
* kselftest
* libgpiod
* libhugetlbfs
* ltp-commands-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-sched-tests
* spectre-meltdown-checker-test
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-ipc-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* network-basic-tests
* perf
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
