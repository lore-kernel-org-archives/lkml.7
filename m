Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5635C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 06:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8144B217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 06:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QbhMpmEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfEJGgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 02:36:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44934 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfEJGgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 02:36:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id e13so4074013ljl.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 23:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jdn1fB5jK2H9U7klv9WLYai3MkQ8jjCmQ0uyEZntdqE=;
        b=QbhMpmEZ8IEj071UOyImUxcupm/StXph+T9Z8knKJ4PpktNB98llcx9Wuxs9WKxIyN
         Sq8dbRU7UrZeIgoWGzDr5klJN3ykYw2hcmu2v667LBcIrKFLkPDxP5E4MZwXzOrCdrIr
         UjTSP++617UkcCA8B627dZ/xakGdZod/QE+WPiuzZK6ZZ4Sr8dhMoz7UABabRgK0eVvS
         D4e8sbFGoYf0PPjq2i5YQr5fllJx7Tudie1dRo119xUOIi+5M7oodFN1jJsuFZJvqxyg
         tnWfe+ySBKNDV18HWw27XNjnTrVTO6hLab0u5i+/9Bmx557KXnBKGPRCzrbsPOt/VReh
         6cZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jdn1fB5jK2H9U7klv9WLYai3MkQ8jjCmQ0uyEZntdqE=;
        b=nKqC30PLVx1GiBJh82lNkS/MsThCBwvmp4/+oc2GAxMA+e3F3OeLIKeRS4yyylMJg9
         7hmlbKgzgGBg+W+7MFIHVmQJtNOQ3DirZGxqmMJDiuhqlulQ2Bdox7LXsCDoqJT0Yz3U
         r3wq/2b3uZeNtkcAgp/qcoYxPWyYHdKa6kjRsDLiKVLoXLCMyOZKBmueBki+1CyrIM5r
         myGgPwSPkN3nJAhDY+ro/W0/O6ZbkTodtJvIwSSHXwZjTS9lFjump3tCMMXLJuVBKFeA
         T+2dDQJ1ROl0fjKVDRPOVgcgQI5C5m7Gf94gH8vospG0Y3s6YBPSoaoMZQPx2247LMRE
         +L9A==
X-Gm-Message-State: APjAAAXjkOz8QMcDx6tL3CuwaOyDW4CVu2pQfjd9jaLiZKDdNMzNFRMN
        WIRNbOVk/+GxKgS0mRpv6htv1UvwOlSGIaiJUpwX+w==
X-Google-Smtp-Source: APXvYqwovU9fCF8YmwMEJZhh0/PzADcVGKOIy7Ujk0rMuR4qjDtBbQDRUvCXHyWDfeona9Ck+tqMBnfgl0018FSX1Wc=
X-Received: by 2002:a2e:9193:: with SMTP id f19mr4604787ljg.111.1557470178310;
 Thu, 09 May 2019 23:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190509181309.180685671@linuxfoundation.org>
In-Reply-To: <20190509181309.180685671@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 10 May 2019 12:06:07 +0530
Message-ID: <CA+G9fYvKNb-WD+0govE2NWzjHisdJXiRRioTQGZKHP0gvO9WKw@mail.gmail.com>
Subject: Re: [PATCH 5.0 00/95] 5.0.15-stable review
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

On Fri, 10 May 2019 at 00:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.0.15 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 11 May 2019 06:11:22 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.0.15-rc1.gz
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

kernel: 5.0.15-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.0.y
git commit: df1376651d496484d341d374c3d2566a089b1969
git describe: v5.0.14-96-gdf1376651d49
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.0-oe/bui=
ld/v5.0.14-96-gdf1376651d49

No regressions (compared to build v5.0.14)

No fixes (compared to build v5.0.14)


Ran 24978 total tests in the following environments and test suites.

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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-fs-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
