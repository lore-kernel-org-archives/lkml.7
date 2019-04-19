Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C00AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C5E20652
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Co7L5Tk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfDSS1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:27:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33479 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfDSS1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:27:32 -0400
Received: by mail-lf1-f66.google.com with SMTP id j11so4601430lfm.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kFcT1c77kBxvyzUNV0e2oilejLrc2MbtTnq3TlMVUeE=;
        b=Co7L5Tk1lOE1kvYTDJV2IGqOGGB1NIwltPU5KGdLvofTWT3aA/bNjglmAlz/CSAHVS
         kkfEat94o/CTUVYnh3bkSPJujfFdc2MKgd0y5GzJIZKa1LQhG2xAWyofF0tFGXAuGg0z
         NaMLjx9t8H+VBwF2sggG9mkg2p3cnxkqpIzUQsEaa43n5Ses7aZrscMFsHfDeWs5gYeb
         PB0fjQk/txg460rAtjJ1402drtsnENiSFMk6L/9b1n/IV4y2Li4srdeeeH5GErMDgwaz
         LjKPBuaUVFnIEybnKtwAkyF1lvQZtyZkXZrNlN6vXuWy3M1v8y/mWhEkLyXz6vVPYl4f
         IHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kFcT1c77kBxvyzUNV0e2oilejLrc2MbtTnq3TlMVUeE=;
        b=g0YVX3c0T9PkMj+UvwbRlffYguSX4hbU3ASZIxDHpRHLhyneuUTOWUW9n9YUKgwFjV
         Wtq3T91bBf4gRhAkij1923T47kWRcCjYA0lxrK/lq0GiI2drbmE51PgIfbvMY4AM3/QR
         3UAgzR5lhkR/Orz2DH49ynRq8P5sw+HsJO8I7i3aCJhddQNsHOZOiUW20vXTnsU+3zWv
         EVSQB5L3m09XH/AexlEf882eeXKIoUj/nMcsaXJULA0LLgUWNTeEP44sVICm4v95ugc8
         UZS1jhtl2nFFgh3nbokp50Y2IoIskOHUvMBlaqOMAq+KkcKqfo6b+GBsj4w6IhsvJM1b
         X8lw==
X-Gm-Message-State: APjAAAW2v3H+AqGQFe7UNNHLWQOL/mVLQ+GJEQCqAa+szEtJ+Vz0qKNs
        rKcuOkOpymebOOzng60wTakXVN9RODyNOwyQkNX+mi7N/yQ=
X-Google-Smtp-Source: APXvYqyS6OwkL/sPb2+F8k1XjT2yPRip02CGNcsRSSGl8xIPlrsJQbOJu4sXoaCrTCn5y9KR0rW0XOB0QDMyD2F/52s=
X-Received: by 2002:ac2:4285:: with SMTP id m5mr1312395lfh.103.1555657330155;
 Fri, 19 Apr 2019 00:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190418160422.455656724@linuxfoundation.org>
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 19 Apr 2019 12:31:59 +0530
Message-ID: <CA+G9fYvTh30_+8Px5m4VCZ_QpzKK3SS7HfcioA28Obv_8Ts_oA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/50] 4.9.170-stable review
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

On Thu, 18 Apr 2019 at 23:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.170 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Apr 20 16:03:22 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.170-rc1.gz
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

kernel: 4.9.170-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 0f6275bacb077add96e4270048916397f74645e6
git describe: v4.9.168-129-g0f6275bacb07
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.168-129-g0f6275bacb07


No regressions (compared to build v4.9.168)

No fixes (compared to build v4.9.168)

Ran 22741 total tests in the following environments and test suites.

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
* boot-lkft-ltp-syscalls-linux-4.9.y-540
* boot-lkft-perf-linux-4.9.y-540
* boot-lkft-v4l2-compliance-kvm-unit-tests-linux-4.9.y-540
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
* perf
* spectre-meltdown-checker-test
* boot-lkft-kselftests-linux-4.9.y-540
* boot-lkft-libhugetlbfs-linux-4.9.y-540
* boot-lkft-ltp-cap_bounds-cpuhotplug-fcntl-locktests-filecaps-fs_bind-fs_p=
erms_simple-fsx-nptl-pty-securebits-linux-4.9.y-540
* boot-lkft-ltp-containers-linux-4.9.y-540
* boot-lkft-ltp-cve-linux-4.9.y-540
* boot-lkft-ltp-fs-linux-4.9.y-540
* boot-lkft-ltp-hugetlb-mm-linux-4.9.y-540
* boot-lkft-ltp-io-dio-linux-4.9.y-540
* boot-lkft-ltp-ipc-linux-4.9.y-540
* boot-lkft-ltp-math-commands-linux-4.9.y-540
* boot-lkft-ltp-open-posix-linux-4.9.y-540
* boot-lkft-ltp-sched-linux-4.9.y-540
* boot-lkft-ltp-timers-linux-4.9.y-540
* ltp-open-posix-tests
* boot-lkft-ssuite-linux-4.9.y-540
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
