Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44072C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B76B214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kcbeO50J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfKLN2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:28:06 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33067 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfKLN2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:28:05 -0500
Received: by mail-oi1-f195.google.com with SMTP id m193so14762720oig.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 05:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xgS1y/QHvwCZ5sjpMxBy7mjRARQgXnaQTp3ERHXATik=;
        b=kcbeO50JEcdNg0Pw0LEC6np76Jdau2Kt/RVNxJqhN+Zm1BftSorl81kFxfhsvq14Pz
         qMdBYXP/n1FC0bUG9YYZOAcoohj9pEI3/GA7gBrff40WbbLiCtZ3+/O3frpQ5zuNi9U6
         2oDn9K4EtmKjhcumjwFRRYmSojuQFXE06sCWt0/u92D5H8qD1Kek7uGsVe2H6GzN37WR
         IGfkkKYbZc2EMvromBeXID4CmmdoOcJIm6XUELSmBZsVC/1Pws2gf5+z36UMrRy3FKVH
         Sby2HoK2ElNJnTMjw9QxTVJYS9ebVIZkV8GjOhReUgkvd2xBq/hPgK6uy/ItN8cm7y7G
         l3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xgS1y/QHvwCZ5sjpMxBy7mjRARQgXnaQTp3ERHXATik=;
        b=bqjQ0V6j8kXL/08MJwbBxAcDU1J91jgFIu8ljV5gkSPY55NA1sd7NTQJIItSFG+1yM
         SxniD4dwIWv7muvNSAVYHSXj/OLmECTtDzJuXaygecGMp0QJI6Sa6WyCiXIzPJZhUGb+
         p4PO71WX88i8f2NJnhjRQSlX8WK50CB6Fb4SCd5RCQFkRmsXjWikDqdIMw2R+jZGDgdk
         vJIrGEgWm8Iw+SMkVvddnvHSQp96gJukw07Pbv5T8BoQKUVJDHohqq9c50JTOisLEPBs
         hFny4SdtFY4ziJIfVi1ulFJf3h7MOEm8Am/evqOpX6sQfIVMJVIcTg2cj3n5AzauJdap
         SOeQ==
X-Gm-Message-State: APjAAAUwPoNQ1ZSaH3ppozjGGHzj/qOV6wEEz3UZ6hhcb3mB43Mbjmpa
        ylDEUx0jVqdzocxdYLJqy2EOXmplgkaLxmE852cM/g==
X-Google-Smtp-Source: APXvYqx6P4E8F+B6CNZl1GqtAqaB2TmVKdqSNhAm/eGudHq4qNyeJOK+tD1sUL3CMxIHEHIpsgYEcQ8Q9q7Cq2ChHjE=
X-Received: by 2002:aca:b10b:: with SMTP id a11mr4107736oif.138.1573565284430;
 Tue, 12 Nov 2019 05:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20191111181246.772983347@linuxfoundation.org> <20191112052741.GA1208865@kroah.com>
In-Reply-To: <20191112052741.GA1208865@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Nov 2019 18:57:53 +0530
Message-ID: <CA+G9fYuf=WM_uEnixJmd7mx8LWy3THgVEcZu5H4yfD-U1thqQQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/43] 4.4.201-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019 at 11:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Nov 11, 2019 at 07:28:14PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.201 release.
> > There are 43 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 13 Nov 2019 18:08:44 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.201-rc1.gz
>
> -rc2 is out:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.201-rc2.gz

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.201-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: ca1d1b5f0f2acd3d552c3c74f44d984d06f2d595
git describe: v4.4.200-43-gca1d1b5f0f2a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.200-43-gca1d1b5f0f2a


No regressions (compared to build v4.4.200)

No fixes (compared to build v4.4.200)

Ran 19919 total tests in the following environments and test suites.

Environments
--------------
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-none
* prep-tmp-disk
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
