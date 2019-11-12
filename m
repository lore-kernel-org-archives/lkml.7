Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACF2C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44722084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PlmniiAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfKLFma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 00:42:30 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45150 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfKLFma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 00:42:30 -0500
Received: by mail-lf1-f66.google.com with SMTP id v8so11719743lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 21:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y4MKvz0vf5znuyxPzI0zc4sZxNrfZWFQiG0Ct6YROUY=;
        b=PlmniiAPxWzRDOcjMLwd+hE9M7dEKYMop5DrVREzExqblbQNlA89n/7rgzGO+bBJVy
         Nf9qT1q4zUJu1Xjpgqdf+10LT1TVCABhaFO/SQOZomKaUiyNgu7ALsTE4T4VHIBvQ42e
         3HC6HW5hhmVJJ8N+yetodbVuXNGG0wz0HFs4Yw4AIUYj2cYTcAFmqTDKKMMG2jWcXK0J
         YZ23IsopzX71cnl35XFe15oQ0aUAIArBbGsaNPRjlenV2nEcEAfyBR8RnnMXBL/2Z8Jp
         Ufl0VIudf6SZdNQzSULuofJGNgeQptzWQEgF3ThL7Cs1eNKnU5U3gLgw7G3KrTOFovDg
         /J+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y4MKvz0vf5znuyxPzI0zc4sZxNrfZWFQiG0Ct6YROUY=;
        b=VInOqfxRM/6Eik15Jn5S1NAKaYxSRfvVtOSUvnT2vhH7j6oQ9YCz0s7trV3VS8YBkI
         KhbiTIEVZ6N+Drl4re/ijaolyVPhtM+vqkTKHDu/ehTb8rn3J/Qm71+6Zbv1WHIKTeUY
         UoW9ZBf/rO6yRHua4dZlv5Rri9lyIfEYKfhYOpgcg//8EqbqL/NyaTQiHYZRll7vVdCG
         6B1sF5OYSiTp509h4PTXnXlvnyUhhm5cI3W2JuByqFgDyXaFj0ESWJa3AYeoiFh0Oxih
         1w1re3Z4IjqfHnpxuGVmnSjhbu6OFCnX5PtberGmIfZ4EpqMOTMxQaXNfmLBAeN83QM9
         QuQQ==
X-Gm-Message-State: APjAAAWc/Yn7ln0glsZS0Tl0yzeL8BPXMz3/GwfNOzBDpLqtyBiWxl5f
        BOPRxEAC+pGmAg8PK7qN3oOgGCoRh7hn2y/zJT/IzA==
X-Google-Smtp-Source: APXvYqwi8ThHgK351M+9ZybYIwICmmPCW3Gm4Eza2MRMgA7cNRmMgNxtvt3OgG8MGk7Q8kYEspuHnWL2kE7i7proIrg=
X-Received: by 2002:a19:e018:: with SMTP id x24mr17700593lfg.191.1573537347798;
 Mon, 11 Nov 2019 21:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20191111181459.850623879@linuxfoundation.org>
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Nov 2019 11:12:15 +0530
Message-ID: <CA+G9fYvBckngrAhc4NEU9G-_UrE9evmJNkCz3ZP7eEZjwyHGKA@mail.gmail.com>
Subject: Re: [PATCH 5.3 000/193] 5.3.11-stable review
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

On Tue, 12 Nov 2019 at 00:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.3.11 release.
> There are 193 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 13 Nov 2019 18:08:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.3.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.3.11-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.3.y
git commit: feeefcbdbfc1362972ef26970aed0aafe90cc1ae
git describe: v5.3.10-194-gfeeefcbdbfc1
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.3-oe/bui=
ld/v5.3.10-194-gfeeefcbdbfc1


No regressions (compared to build v5.3.10)

No fixes (compared to build v5.3.10)

Ran 26052 total tests in the following environments and test suites.

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
* perf
* spectre-meltdown-checker-test
* network-basic-tests
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
