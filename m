Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6209C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986F22171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yeu28Y/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404991AbfHIDVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 23:21:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38384 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbfHIDVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 23:21:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id r9so90778487ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 20:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=msEHT0iv566xvf+vfMcGL2ig2A7ZI1+K3ZvkoXORsXQ=;
        b=yeu28Y/HVFnVOJpo0PmViLj53in91wGhXbdhDpm0Lxf20TkJHrP0rDvKE0ENrT7i9g
         +NsxCSeiu2cb9cgFoN632kaSccSm5pC4PCE4IQfHvqHQxHeDcsSKZ2812hSNE4r6BA76
         pwBFIpVWHDG6+kN5joAifP8UaK4/srYMYruCxT1MbghmeKOecY1sHWiYvd32npHYN/l9
         661mkEogmCmyEqP1uy7I4DO14+Plv4z30DWBwZTLx+mnT0paxrU9T59rf6wbDVZVSbGP
         q6i9ix7cvTOgxLOt5SNLHJlL/bL6aGMwNFajW4+mirf1Q0M5LwEFpNgkhKbQKsey7pcO
         a9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=msEHT0iv566xvf+vfMcGL2ig2A7ZI1+K3ZvkoXORsXQ=;
        b=XV/zHshkQJZtWxA7011R/Lz6vpymL6hY+QBJoGGHmd8W54xfwEW6QDnOoXz5o+OVPl
         AOJFk9qmK9RscI1fRlUMlHEjfFbha1SaZhO2SguGO9teaKnAdNl3pRKDvTFpPdCYd16r
         D1PHE786qgUtPRKkFs4wU/M+app8y8pqwSgq897jyD68cxMK2FqMR63cfdKQQdtHgnnD
         coEm8e23bMfTErxK2nmRfDKDgqtFlOpyi162rvMWWMoIJKq7nxGi9q3vso7FmAALM/rM
         ABF37hQTlvUKRfo8TGs3UnFHNzODnDnI4Zel2AhXyasAL3UlTKu/oChUSuYYf4Tdb5yV
         gjWQ==
X-Gm-Message-State: APjAAAVjOx7wvLEcXGmuTjjeP9G8GZl6AMtWBZ//QVxGkmK6+9r6XkEA
        ONt17s6HXrxGhVapxUYSAEwMbYdFP74E2aDtehFTW29u1QJ23A==
X-Google-Smtp-Source: APXvYqxTtAKv4kkyenJgwEgxe75lkiGyiF4zxBFZFw9N98GBv1cf9aftyNYCWMS3dEp3l+tAM8ZrVTrcGF84oUP4Md4=
X-Received: by 2002:a2e:8559:: with SMTP id u25mr709400ljj.224.1565320861762;
 Thu, 08 Aug 2019 20:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190808190453.827571908@linuxfoundation.org>
In-Reply-To: <20190808190453.827571908@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Aug 2019 08:50:49 +0530
Message-ID: <CA+G9fYvkMFfbBPd_VV89Cme1VtQk6hcZ22a6Qi4p+dKV0CbW3w@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/45] 4.19.66-stable review
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

On Fri, 9 Aug 2019 at 00:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.66 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 10 Aug 2019 07:03:19 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.66-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.66-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: d43238541496ae2b216aaac84e0933bb06eeb0a6
git describe: v4.19.64-128-gd43238541496
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.64-128-gd43238541496


No regressions (compared to build v4.19.64)

No fixes (compared to build v4.19.64)

Ran 23168 total tests in the following environments and test suites.

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
* libgpiod
* libhugetlbfs
* ltp-cap_bounds-tests
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
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-timers-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-commands-tests
* ltp-fs-tests
* ltp-math-tests
* ltp-syscalls-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
