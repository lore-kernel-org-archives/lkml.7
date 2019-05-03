Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A97CC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBD6205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LGpe7H9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfECHEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 03:04:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34144 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfECHET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 03:04:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id s7so4390451ljh.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 00:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EG+yERdoJo9BLN7VabMPjS/nhRf3hDC8H2zgWdVktco=;
        b=LGpe7H9N9gdqKsRij55UyDvK5Rz+ixPQVDW1H/qYkdHeHuY3jhh09f0gQQ195p9wkb
         pX8613oVMrUuuZMY4JMkArMfBaKJpqxlM0I8tccr81pWlgQDCi8DQ2H39cToPGeKXst1
         IpP+QfbmXoxFUetvnqHMHvKv5HcPqul6pZ9aD801QMD957aJ6+OsSJTslsN3GQkoRX7S
         MdNbIkcoU3Ahy6RBN7wUxx8506d2FpsuGwNu7ds2szkresDza3tCfSdGTplM+sxKXFpL
         0acmupA4eBxXOVA4Hnd/ExVduePWSJgprEHM6PRvouaqUuGJ1hbCmNwovDo4PMJXWO5J
         klyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EG+yERdoJo9BLN7VabMPjS/nhRf3hDC8H2zgWdVktco=;
        b=oebq6asvzcy4ljUMySBrejPgunW0P3jjmqA/Ld8G+xZalTLkhHvFPS0d1UlVakHTTx
         OJBogdcVlVnlSmtg6iMQ1G5yVd1f7z1UkOApBY4CIWawhc3fyx1tJgwP58+T3UXR3ncf
         WZ+miiMzajo2+WDk4L7oFuPrL/uEYyENtQduJd70jw9fTZ+6TB5h76YzO2uWQx49B59X
         DTLc1ekHG3ReQg1n2xYsdCAn1Vrei0v/vxGpyo6WzGO4hecv4YP9BpdYALtMKdLpmokP
         fZ/YU3HGfms2glTjPcNZRiceOGhtsnrNM5R/H8CI1+vC47yeEAIyQTdYWiwnDUCWb/yG
         7pOw==
X-Gm-Message-State: APjAAAV63TmIpVgsF96jGDIvQOSDcB0nMoxaaDlKPSr6gZJ6KmJJGpWH
        1+eIePKvK45OVmx4Q/icM9hhYWnqVOtumagVx8ROoA==
X-Google-Smtp-Source: APXvYqw2h0hfR6f/SutSl8UZyA/nX5xNrB5MvVv2JMKYKFlUPlT8FlMO7B40W8tltBw/xkLvewH1ZBVuO0ndV4skS7Y=
X-Received: by 2002:a2e:8186:: with SMTP id e6mr4405169ljg.136.1556867057291;
 Fri, 03 May 2019 00:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190502143314.649935114@linuxfoundation.org>
In-Reply-To: <20190502143314.649935114@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 3 May 2019 12:34:06 +0530
Message-ID: <CA+G9fYsQdQRoC9d-eV90=09eY_ZHc06cByoDbgmi_WoxHUL05Q@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/32] 4.9.173-stable review
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

On Thu, 2 May 2019 at 20:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.173 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 04 May 2019 02:32:02 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.173-rc1.gz
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

NOTE:
v4l2-compliance test kernel crash fixed by,

Hans Verkuil <hverkuil@xs4all.nl>
    media: vivid: check if the cec_adapter is valid

Summary
------------------------------------------------------------------------

kernel: 4.9.173-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: d35bcd0923041bd98c18947041f8929b2fb12674
git describe: v4.9.172-33-gd35bcd092304
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.172-33-gd35bcd092304


No regressions (compared to build v4.9.172)

No fixes (compared to build v4.9.172)

Ran 18302 total tests in the following environments and test suites.

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
* v4l2-compliance
* kvm-unit-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
