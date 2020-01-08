Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD83C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD0D2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mx5Blo97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgAHQhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:37:13 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36153 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgAHQhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:37:12 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so4013122ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mSprmQdK8yTUyJ82NWGsdQl7KNFt6mfONZwoBzX7Scc=;
        b=Mx5Blo97fj+AnzG7KBhWIOrSA1aAzR//CiHXE3u3nCOCb/Dv7q7TRvXIugC3hQbr+6
         5sB6CFF9Fa7oSbQYUS7Ja84TQnoCD5hhr9fgzMQEkcC53H/P5NriyB6xVX5ToLZmOXls
         rdDYpufA7GGFQUBiAUMC9yKwUVZrWY5WDQOQJvRiSJvMIlH3g/huTZoRp5s65yF8Q9zV
         VwpEnoeii8VtiHNosrv4YIeca0IqGQI5ksHg0d8ZkkBIEnQClKeCStFoIGejBbyNDvx8
         xbUidIsN7AYJVPJVO+QHP/xcplbrQeYX4/HLKseEoWSJjMQcpc5vCoqxyoVz4p5Q7FRl
         d4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mSprmQdK8yTUyJ82NWGsdQl7KNFt6mfONZwoBzX7Scc=;
        b=ErlWilRCO5zx3xhSwf0vg42OEgZ72a2J1OX5w92wbAvoRl1Vt2v+BKZp88jky/mI96
         jSl9Lav9FRivuPgA7e7IB6jeG7xc5IxnNK0DywwDbuR8T/QNjg5m78GTXY7JH6/YYf41
         hhEiDUda6FsA8W2I6FQOL/M7iwZaRtMElP2yrS9ev4/oBJOE088Q9xoDi0OHGKCwcC2f
         B7YVjBvAH8u/kbE3Gc8lVMaXvbVcbaMYj3UgBHrHEZdfKiBZpCQtUK3akcuKVRZRVVD1
         dKTS3bGt1AfPG7U8tgCz53PQ+pz3+DPjXovMnNrR8Tw4OI0GFX8MwZkxWkUL0TYmU6qx
         ie4g==
X-Gm-Message-State: APjAAAVTkLhAa3QMQnNyKYpNjv8KkZkbRm+SC+plpWCRR5BWuBH1zRPe
        w8Lb5o359RZVAuXb1/stqmX62yRBJfl+WCnWixAMtQ==
X-Google-Smtp-Source: APXvYqxL+8Xqj+9eGKjoAtet7LHfIw8H9eIdzazSJAswsH91mD9301/A1IC9vC6MqgFYnflHn+OtiHoI5v5gF2nNkY4=
X-Received: by 2002:a2e:5357:: with SMTP id t23mr3450021ljd.227.1578501430805;
 Wed, 08 Jan 2020 08:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20200107205135.369001641@linuxfoundation.org>
In-Reply-To: <20200107205135.369001641@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 8 Jan 2020 22:06:59 +0530
Message-ID: <CA+G9fYvCL_wwOOY76n2_JGeTYFkMyPRti0xsaOJsQ3D76YwLDg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/74] 4.14.163-stable review
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

On Wed, 8 Jan 2020 at 02:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.163 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 09 Jan 2020 20:44:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.163-rc1.gz
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

kernel: 4.14.163-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 404399b2e7dbcae8377bff92324178718f9574d0
git describe: v4.14.161-163-g404399b2e7db
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.161-163-g404399b2e7db

No regressions (compared to build v4.14.161)

No fixes (compared to build v4.14.161)

Ran 21424 total tests in the following environments and test suites.

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
* linux-log-parser
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
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-open-posix-tests
* ltp-syscalls-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
