Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FC6C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2C420989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CcRhjn79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfCRQ14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:27:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37644 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfCRQ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:27:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id a17so14645771ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3wLKH0zWKt4beR4KW2vWKa5yYTIq2Uu9RSPCyuHogOc=;
        b=CcRhjn79xXLf0lgkJyFodkrzMu4Q5UCAW21Tck17fbIg+Mwi28IWmXi7uVkZDQvuM+
         t7juktTO3phrVskjtdAAWI07d0JIU2HCXSmLS0nz9PZg7NqS+lsD/Krfx43xRmrRYOJJ
         VNIZ9GAefH+YBqZkxTqKOra1kwgiXoeDvwePAViufn/7YFMAKEFpOPuXMRIC2tDRKd0j
         +nxwmrIXpjVvU4Uq/HPiyMesUaeae49mpJlAni2ZHuzRJgTxGUuSI58bQ0Vq0lK42LeF
         GXCzsKrT8O22vtQC++rttDM5i1AM0zEFCdjW9c2e33tpbziG2Ibu6CVg2HSdn6lf550X
         IXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3wLKH0zWKt4beR4KW2vWKa5yYTIq2Uu9RSPCyuHogOc=;
        b=PMjtxN0IOEHs/hFMTKVJnNW5tTBE9CbyQ5tMgPcpH6nZHJRo0PQXQnSMsmDkIVJrbc
         g0HMRD+fQkj8dLYg8/nZzuMQ27wqlOGP9KchqWCRMpj2D0fyR/rbspsCx0a7PHC4UI+4
         TQyxhNK+i47/rKaZtdXOtzvI/pAnxX1VgBqyBsEVfmuD+kc0/+fPOBNXvrosdqctpGNp
         is2CT+hTIjOTOS8fmMG57jKT67nEnnhYc4nbKin0wdE9na+JSJxg8ESzYn2MOa/rWog7
         pPkwT5RHBYkPdB0zjRI/VcFW3n5P6H9y/5q5tdaTSSiadvxHWyRJm8h34GUPvin9IUCN
         BxDQ==
X-Gm-Message-State: APjAAAWVbkuUzq3eudKW8ae92p8izUkB7Bjj2VKrnrJ+wUtvAiwjdnok
        KpUlXguIDvXDZOFILC2r0mtt9ffHYy6N8bmYq/KGMQ==
X-Google-Smtp-Source: APXvYqyGNWIhCqQ0TV2saUVwpB9ySlRq/EmZnkLew7nlxCDHrrZBC2p1rahTnrDmtc0whqUwJRwlMwK3QTPiDeRI1d4=
X-Received: by 2002:a2e:6309:: with SMTP id x9mr10936534ljb.75.1552926472840;
 Mon, 18 Mar 2019 09:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190318084144.657740413@linuxfoundation.org>
In-Reply-To: <20190318084144.657740413@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 18 Mar 2019 21:57:41 +0530
Message-ID: <CA+G9fYs-F9cYytGjfmucE6oqPGDKaKMfJhS7KZEEHa+vKF9cLQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/34] 4.14.107-stable review
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

On Mon, 18 Mar 2019 at 15:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.107 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 20 08:41:26 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.107-rc1.gz
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

kernel: 4.14.107-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 6fdcb56d3713e8abec18669625bc170613795f5d
git describe: v4.14.106-35-g6fdcb56d3713
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.106-35-g6fdcb56d3713

No regressions (compared to build v4.14.106)

No fixes (compared to build v4.14.106)

Ran 22876 total tests in the following environments and test suites.

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
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
