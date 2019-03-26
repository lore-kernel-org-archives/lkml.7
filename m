Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D78C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4942075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XOX2axUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbfCZQj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:39:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44251 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbfCZQj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:39:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id h16so7259807ljg.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eo09IaXnRShpsVlTFRkf2fadMKrCgS2sKiQsRnWf48I=;
        b=XOX2axUhHos2mOxc1jbgmGi2LOZg5ZnnC5Nz7ZnYJEDAvlLuPRaDE4jOwVci+aoz77
         FXSRDuFb4z+tYQSTUW79Hhu6SzQRgTaC/JEWt3c0IeGva5zPOpQV7JoOex4q8YkYVFss
         UKPcAG9veBxtsWu3dHS6z+CiVSntUVi2n/Ri6QSCyHV/L+tBGrbbIHYZRwkJ9fdT8K+x
         wSDGVwqZsoG+FzG3hX0hqQCdB5fS2fhVVtedepjnU0rjyaylAfRRCDZSk62KSTp6RG9t
         /bAX+rj4m/kSYnNZyfh1Hja6GeB4bFLJyMpLJZ5sq6oJE27JxkaaAw+2QDhrGLcSQnQV
         CPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eo09IaXnRShpsVlTFRkf2fadMKrCgS2sKiQsRnWf48I=;
        b=sKR5iya2w3VAmD8GhfrB4JDX6ban4Feu6rTrOPKgME6bsw1Ym3S+xWKmSsBggVeajv
         fheAUR2MYPP7Lv9kTiai1YkIRHnNWQdh8Y4D3fyM1WxfCxcOfhphcGApYNDJ4lt9K7hV
         iweiU7TI9Y/re1YuQAKWXAXORpprwIULTMKKH0NI536k1QD+RzfYLf7eKCtSdHEx8c/y
         BJ+FJfbUU5vmjeJ3AgL8HMxpOSW2U5ezRQFkXIahg/rPFCIGQQ4SFKuViyMPGqBFPO0+
         n7+fg9S4AXwS/nN1+TPc2Pu0kDRGPxX+DHY8EiC3HqVcOe8kHBzDgu4VxJjkiM0P+s6I
         nvXQ==
X-Gm-Message-State: APjAAAVQ3jnN76GfG4SnPqAQsy3MisE/iJ0dd3vH4ih7O64bEjzH1O24
        4sTgcN7CvrkCZE+hG5OQ5hMEJvlzcE/aT9qu+YdWaA==
X-Google-Smtp-Source: APXvYqwbCvCQYhWKUAB4s44G2h9p/tJ0Y0ZJetn660ckDzGHtCZVeKETbV0F6z5LJsAa+lfBPAfq/DhGgGDtmW0sL94=
X-Received: by 2002:a2e:9597:: with SMTP id w23mr12058323ljh.111.1553618395012;
 Tue, 26 Mar 2019 09:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190326042649.889479098@linuxfoundation.org>
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 26 Mar 2019 22:09:43 +0530
Message-ID: <CA+G9fYthncHa1vt3L2JSL0kt+SWeb1vGmtZwokqbrbqtQh-abA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/41] 4.14.109-stable review
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

On Tue, 26 Mar 2019 at 12:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.109 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Mar 28 04:26:32 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.109-rc1.gz
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

kernel: 4.14.109-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 4bb6d9c67e49d5301e6341b32ab5d72354e821d6
git describe: v4.14.108-42-g4bb6d9c67e49
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.108-42-g4bb6d9c67e49

No regressions (compared to build v4.14.108)


No fixes (compared to build v4.14.108)

Ran 22897 total tests in the following environments and test suites.

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
* perf
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
