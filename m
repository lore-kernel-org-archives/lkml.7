Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FD4C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2342080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZKcVwSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393008AbfITOjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:39:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42203 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388683AbfITOjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:39:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id c195so5210749lfg.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 07:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=94dTaQlxfmOLNaxOx5v2ZNWhpUPaHaSXDE601HqQIqc=;
        b=GZKcVwSmzEOfkfxUnBUilWyJFMqqKIAgoaEgEir/OsL7kPNuT/XkOZ2Xw2x/KWpPIi
         zBQj1koy5626C19f7a5q0g525xtKId98JiNysye6s4z6N2GMb1D+8kkmB3pGFwjku8A2
         Frhj19dN2VAzHanMfdGJncniOjFoKs3TrZfwzrENgBE1vFnEgdzpa4VdlhO1oW4X58NI
         0sX06YtkJH3K9vdeuwdrIhvTQULINBvz8i/9ziVISTElaACqBi4smiLGs1R0Wvm5Oo/J
         dxdxJzM03eqNAfz3/xZGBslRWyBieIRXiU01IADJWygNp0aUe1fGRHXbZsvaPGD013Uh
         k7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=94dTaQlxfmOLNaxOx5v2ZNWhpUPaHaSXDE601HqQIqc=;
        b=Xe7/xEiOL/9kImuuHEBGD7CYfi2Q4GnrqTR0U8xl9Bv0Sop7b6L+hQFMAoIdgtPsNW
         fLyWb7GLEBNwVgJKyv0vwotTRhLjouyjcel/cP/3l0U65BJdBJkz/v5ZudhYdySDCLRv
         GCVZluULDlD0wJ/8ws4Y0FGtfx/BXDFrUr8NICQ6KoXK3h/B677pVU6tVmn6j4RccKSd
         KJ+vYo5Q9pQx9COL5p5azypnfxW9UT3ZuIBkfh3TSQ1RvMek1rwZiEoYZdoFw+SVcTrP
         GXc8PEB0epg1EjelK/xftwQWW7iotjTrfS3o86eFk3Fprx/8HJf6NJKcujiNSrp9gDvV
         aRgg==
X-Gm-Message-State: APjAAAVcDXSSvLUhO9o48qtsGZiYVvGEZAiMT74qrOnkMs978nA+5+mw
        6niV8BCfyghkYeyeV0RA1DJqvyaoAjv0/E1k9TS73A==
X-Google-Smtp-Source: APXvYqyqbRuGkPj6OFmTuU8uJfNfEhKPx31JWIHMJC5OyWZR2rX71kcR+MpjiiB/VDo1Vs2o0KX7/TgFKT9IULwE0Uk=
X-Received: by 2002:a19:ef05:: with SMTP id n5mr8799713lfh.192.1568990386202;
 Fri, 20 Sep 2019 07:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190919214819.198419517@linuxfoundation.org>
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 20 Sep 2019 20:09:35 +0530
Message-ID: <CA+G9fYvk=2Akfp1Xj=Xk6Q4UykQLQQVh5+Gv3TOwA0NiP-RgEw@mail.gmail.com>
Subject: Re: [PATCH 5.2 000/124] 5.2.17-stable review
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

On Fri, 20 Sep 2019 at 03:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.2.17 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 21 Sep 2019 09:44:25 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.2.17-rc1.gz
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

kernel: 5.2.17-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.2.y
git commit: 690411952b3d8cab079b16af04292f93643bb864
git describe: v5.2.16-125-g690411952b3d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.2-oe/bui=
ld/v5.2.16-125-g690411952b3d


No regressions (compared to build v5.2.16)


No fixes (compared to build v5.2.16)

Ran 22493 total tests in the following environments and test suites.

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
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
