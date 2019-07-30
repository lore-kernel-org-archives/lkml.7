Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE23DC31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9855720665
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpXAV1Pj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbfG3JS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:18:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41187 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbfG3JS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:18:29 -0400
Received: by mail-lj1-f195.google.com with SMTP id d24so61359669ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6iUjqyu7puaZGhpAi6MyRyG6cTzBcQl5BSzTgNmE43Y=;
        b=QpXAV1PjcCAsOVKYPbvsUi/MbeltGu7SOf75gvXfyM7t2DO9dqkAa7qEHxjSfXrcge
         eyVU1TH8JWkOfLhgMUNxhYPVQ/vV38mwqOtEqBlp9VvH1YZg2IwH/nIqOy3e6Hfx/7yN
         jAplWlFWVN8tySXVcKGC/RBH54E7bwStzqrvttZcyd9Sl4z0mediMIgiINo1/3HGyCs2
         BltjE6Bxj9UDFLyavMRT9l2etRHORbtcHoky86uKMZkwwcwug7sOzVpQEtH0IcCchRNR
         udNIVaNpy59blTsjJbOkWK8r8Bbe7FwxJBAesmmse4UDPw5jEKaEwURCp23lxJN2M8hk
         3KRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6iUjqyu7puaZGhpAi6MyRyG6cTzBcQl5BSzTgNmE43Y=;
        b=GKQddmRHS2EG60y92XsxCcguRbg9t1eTkoFcB/mtfrDSEajhNii7rUNaKDBAXONlVL
         dPBEQ+Ox/BABZLBKFOeNfK6IdnRGxwT50tL+tYKUGVypmVMwrJ0a3v/nIqaM0cC8UDxg
         7u2HQuzBLyHlus9RFtIBPEY4Br+ff14rmLoDj1FKWxJ3GhVdXD4kEmiSgO0c9AacTwJM
         jzLaxmR0bXdPzhlTMvT0G2Qp5J5SjLVZC12SWYvzJoUuOKYP5tD/2dxKTmLCjq4b4ffr
         4vAJsGWW3TQCGNY2mGcqH4aSkyQmxeAwkgu0KOjjDTo274Up1tuvzdzgrjr/iNRte8Mu
         rcAQ==
X-Gm-Message-State: APjAAAVqPdpZf/+WUIFspniOLV8Ey8qY7yXd7vuo2RJGUnPjHlr4VpuS
        ZnjFZn8OynhYZAqgCYNLVfEGE6RIe+5ym3ojVIRRMw==
X-Google-Smtp-Source: APXvYqyxC3pATEXcCowDql2D3+Tg0p6F77KDXN36EYaTIN7KU33y/6ocxvauwWGduun50JgpjIqfC98kTw6UxZLmnL8=
X-Received: by 2002:a2e:8559:: with SMTP id u25mr60111856ljj.224.1564478306874;
 Tue, 30 Jul 2019 02:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190729190739.971253303@linuxfoundation.org>
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 30 Jul 2019 14:48:15 +0530
Message-ID: <CA+G9fYvpvFXfoiaiaKTgTVggvEi--xFS=4y=R9a4+Xw1Havb9w@mail.gmail.com>
Subject: Re: [PATCH 5.2 000/215] 5.2.5-stable review
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

On Tue, 30 Jul 2019 at 01:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.2.5 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 31 Jul 2019 07:05:01 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.2.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.2.5-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.2.y
git commit: 0c4d120e771a048ef7ae9a4130169b1cf03c36da
git describe: v5.2.4-216-g0c4d120e771a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.2-oe/bui=
ld/v5.2.4-216-g0c4d120e771a


No regressions (compared to build v5.2.4)


No fixes (compared to build v5.2.4)

Ran 22523 total tests in the following environments and test suites.

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
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-fs-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
