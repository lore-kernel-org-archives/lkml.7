Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09F6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBC1214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oi8gezfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfCMLyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:54:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40897 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfCMLyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 07:54:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id w6so1270104ljd.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 04:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n9EllKBuZWUbkZnYRvegGl+5s2u/ealCvhFggRPwsuo=;
        b=Oi8gezfcO9ch/F1qHAWL6LggVprVR6VqynKW5M4hwVjAF5qgYRhFB99WQeVdLTYi78
         l53rSKArs3xeMfk8gOyMJzvlplRDPJkBG7YNhLGZW0zqhk1bAQnesXrGNrAXYc3KIu9b
         hfZs3rVcDY0oR8zyHffYlH+ZZ1Ww8dVPYy6uqkdMMOl9CeNgS4rWYVvBKFc62PH90YaE
         9vSqY6gA8KY86V6MBZ/2hsHjoSTniIRY7h/bVvfgDitj/X9BR7e9YPwLTjNnDrwyUM2W
         SGptVt8lcqkwXIHOYbWE3znyY5p0T2C3VHoTFo0fTYTcMCRgmuXoElrqqoncW62S/2Vy
         3wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n9EllKBuZWUbkZnYRvegGl+5s2u/ealCvhFggRPwsuo=;
        b=pVEnTAhnGdt83sMyYzVSsI4w84MpXO9lcLZmlKXCxA7ovXVy5pEZlCdO1EbH0su90J
         QctnYknie7u4ne0beje7mJRr+5N1gHQXONGOOVghtqjI7+nXquRtUvIzQT02RPCFUpiM
         ZemrwFDhkeVN4BPl2bdcZuLSCIsQAFKOovREhYwi+8uK+zwlQMdA7BgxpquMyzeE0J4j
         9TQNCNy3hJNjrRWYkrieBIFI0Fx7BNvZUDucSiXTak/W/3kpADLJXdg2c/J9d/ULtaGm
         lt06ShGJa5jn4JHjawV+f9D7eCd1flNoTMxeCw3P4f5EiEywWaSCDvyEgOEkeQfDPY+H
         c6/A==
X-Gm-Message-State: APjAAAUGL/1LPvMw78qjAsPcijGwGWY7nd8BF8J6esjr5sTMq9lZ23Qz
        fP1Qgjb5+QJ1jqFID3LuMOOpIJLc6ArO+XCGClQFIw==
X-Google-Smtp-Source: APXvYqyrWrUCTiF73EaOgEuPbV6iwsvupTq9cmcCzg0pIvFI9/orhpnLAROofMsaNAKvaK6XKenZ+L1fHvGIBkaEDsU=
X-Received: by 2002:a2e:5cc1:: with SMTP id q184mr22615305ljb.123.1552478061445;
 Wed, 13 Mar 2019 04:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190312170347.868927101@linuxfoundation.org>
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 13 Mar 2019 17:24:09 +0530
Message-ID: <CA+G9fYsiYKYuXMzBog_g+6-KdDk+CQo=Y533WFRkC-GceaQW-g@mail.gmail.com>
Subject: Re: [PATCH 4.20 000/171] 4.20.16-stable review
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

On Tue, 12 Mar 2019 at 22:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.20.16 release.
> There are 171 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Mar 14 17:02:23 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.20.16-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.20.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.20.16-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.20.y
git commit: dcd2fdc8ae00bd293344e99ba5de929e565ac4f2
git describe: v4.20.15-172-gdcd2fdc8ae00
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.20-oe/bu=
ild/v4.20.15-172-gdcd2fdc8ae00

No regressions (compared to build v4.20.15)

No fixes (compared to build v4.20.15)

Ran 15192 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm

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
* ltp-fs-tests
* ltp-open-posix-tests

--=20
Linaro LKFT
https://lkft.linaro.org
