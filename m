Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C57C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 03:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7FD2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 03:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6iTtQpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfCMDc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 23:32:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40733 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfCMDc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 23:32:29 -0400
Received: by mail-lf1-f66.google.com with SMTP id u68so331956lff.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 20:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BFUVRCQAWJhON1xckcUMCTZnBS1rkoZa5AweudgvSbs=;
        b=s6iTtQpq8wnn/AYvnFrYM0S1x8rE3juvWosXaaHAEz2KEeZylh1+doazmrcgd8iclW
         H9uMvdsDT6mcADJ4Kgy2DiFEN9NG5pExOR/8OHs3enOxVce4drF75PSfLIRcioTsmVlI
         mHdB4Lie40ejMbg6hhBpWfrut1eYA+Zau9PBBYjOP01VM4TLMSEc5XGvnHW22SgTwjTl
         gf3cY1rraozDRzmRYimtMPy8IZi8NlJrOC75mcwoS1AiFC9pWJ7fhtYZOmzXA22Tvvuh
         JOIDzT6pRFJjx+PgKDJxjSsfdnETs7p/gDbDfAOhH70MTxZ9KTSdf/BJdd+n1wnYWqPg
         X7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BFUVRCQAWJhON1xckcUMCTZnBS1rkoZa5AweudgvSbs=;
        b=hcDPWxoCv+O1g1vkX41S/T7DxUoJ/CUuAsXEFkFNpHqMBiSPCTMk36VfeWGsaaIkDV
         j9hdJdumRDvCK6HTrMnfOa0gjrSzGXqW7BWR1yErwO76xAGqTgnHHwapIXcSbS9u2Fm/
         is5KdGuuCVb9o4IoffN9qLGAkLG1DNUZspgkM1GKaNsXKKxYibw+7zeogwdwu8CU4FX1
         shyh/zYH4LKwXrcyR5388jltzWGCcYZp2fMS4yNdkZv1Il6OhP38ucnWah6w1SRlRLE+
         LOL5PMgMxNTJIS7L30vHdEm1g7/jniZeAFweJGYBl80zCgAyoRZ5e1gu4wewFehEMxHJ
         yQzQ==
X-Gm-Message-State: APjAAAWBczsNiDGdC2XD8nD3xGHflidgTShuLOqVXZ8HjX2bxMnkJb0B
        xrG/4dw3s6tU5cDAaV8BFQAx7qupxurG9Dbe3/PSiQ==
X-Google-Smtp-Source: APXvYqwtU5MQFUd78zA5PhIKDXcJuZr9s9UJ+/9jFbD1heqlLsi4laEPzVTqisUAFew5dJMqKB2bESuag/ZwfKVP7ac=
X-Received: by 2002:a19:d581:: with SMTP id m123mr14677093lfg.57.1552447946705;
 Tue, 12 Mar 2019 20:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190312171034.530434962@linuxfoundation.org>
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 13 Mar 2019 09:02:14 +0530
Message-ID: <CA+G9fYuPh6TvGaQ=MTQD+U6aLqfarkfMsT02YQchZfTxREKz7Q@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/96] 4.9.163-stable review
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

On Tue, 12 Mar 2019 at 22:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.163 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Mar 14 17:10:06 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.163-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.163-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 605129cbbd389949c754d0a23ce49030adae8f17
git describe: v4.9.162-97-g605129cbbd38
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.162-97-g605129cbbd38

No regressions (compared to build v4.9.162)

No fixes (compared to build v4.9.162)

Ran 22654 total tests in the following environments and test suites.

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
