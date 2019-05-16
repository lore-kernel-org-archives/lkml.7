Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607BAC04E87
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9342070D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GTW/fJD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfEPB55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:57:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41800 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfEPB54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 21:57:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so1539609lja.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 18:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IBkvWkfjbo2qhlfdTqhbC3Z8epUXswTdb3LlL4ihZQk=;
        b=GTW/fJD50G4i93ASZPIJ8j7jisA4gxQEkpi3pOeJMwZmkLnFE9vaJwOay3xrlYbeOb
         Sa28FHESKBdZ5mTV+pwhIijvqNRpeQOFEXnKkV402zC/L09tj8Dq3CbGk9llFXrU9XSM
         0TSwswhCsFlz0Qqw+2Rq+0iGsbTO91aDjQf0egzGhlTIPsGAMRgH0QGEYLlzLefrxAAk
         mTpT90gmYUItC1mod7CEEwJ8RlEWR+QexsWGBh9sozEcPYzQRlklA+JwgmFQ8ZID2doH
         KD2LXPjATScr2URA5lBsPbdsiWZmcrARzwJsYycxLjMaK6hevhR4vr8swivMgzwirUZm
         7hfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IBkvWkfjbo2qhlfdTqhbC3Z8epUXswTdb3LlL4ihZQk=;
        b=I8W4hboMQXlJwBjsERV/koD5VZcfzYrjWEex6V07TcLNIa8sd2BEhEGxIgyUGIqD2P
         tb5JTH592yMZoEocTXlFij7hVK4TdVSyAqRywLKVfRjVHhK5OQIFNhSWMD88Ot3C+SM6
         DgUlLuj57z+TrIaV8c8CxqzWRNQbA1jXtM0SmfI5j5z7l37rwdcvq78bKo7PRpAE8SCt
         5CZSxF0X2h2U/hhJ7g5bGolT8o0RVzKqo5yy+bdNXgrSa53nqo20OZpS7ueHw5ihIm0g
         O0WeoE6BuqlaiKGc67oLak2fvvwhxtBQuHBozGodIz7IcpsBjAh4qPJCKcoc/xj0tgvu
         itdQ==
X-Gm-Message-State: APjAAAVQIJGNoH9UN+FkIpATm/M3PdoR+Yc/rALbyG/kvnN2T+1WZuX+
        sVnPR9EjcOlbyKkpw5dKFVXpeVJum9y7Ib9C/d9QnA==
X-Google-Smtp-Source: APXvYqwLavl5xqcrY4wECeWHxyMenU5o/VgW46ojJJBdtWMUqQj5/mlqtcpa/UMsQNQErRG/93zcbkxVTPWOBdhgSDs=
X-Received: by 2002:a2e:8583:: with SMTP id b3mr23688152lji.136.1557971874021;
 Wed, 15 May 2019 18:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190515090659.123121100@linuxfoundation.org> <20190515181705.GB16742@roeck-us.net>
 <20190515182427.GA26029@kroah.com> <20190515183729.GA2978@kroah.com>
In-Reply-To: <20190515183729.GA2978@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 May 2019 07:27:42 +0530
Message-ID: <CA+G9fYt0u15cKi-dEk7yW=6mTZvbRrvh=y4UWjo+SF+fPN2EvQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/115] 4.14.120-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Thu, 16 May 2019 at 00:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 15, 2019 at 08:24:27PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, May 15, 2019 at 11:17:05AM -0700, Guenter Roeck wrote:
> > > On Wed, May 15, 2019 at 12:54:40PM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.14.120 relea=
se.
> > > > There are 115 patches in this series, all will be posted as a respo=
nse
> > > > to this one.  If anyone has any issues with these being applied, pl=
ease
> > > > let me know.
> > > >
> > > > Responses should be made by Fri 17 May 2019 09:04:39 AM UTC.
> > > > Anything received after that time might be too late.
> > > >
> > >
> > > mips:malta_defconfig, parisc:defconfig with
> > > CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dn:
> > >
> > > In file included from crypto/testmgr.c:54:0:
> > > crypto/testmgr.h:16081:4: error:
> > >     'const struct cipher_testvec' has no member named 'ptext'
> > > crypto/testmgr.h:16089:4: error:
> > >     'const struct cipher_testvec' has no member named 'ctext'
> > >
> > > and several more. Commit c97feceb948b6 ("crypto: testmgr - add AES-CF=
B tests")
> > > [upstream commit 7da66670775d201f633577f5b15a4bbeebaaa2b0] is the cul=
prit -
> > > aplying it to v4.14.y would require a backport.
> >
> > Already dropped.  I'll push out a -rc2 as you aren't the only one that
> > hit this...
>
> -rc2 is pushed out now, thanks.

4.14.120-rc2 test results report,

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.120-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 76f297797325042039484d833822c683d6335075
git describe: v4.14.119-115-g76f297797325
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.119-115-g76f297797325

No regressions (compared to build v4.14.119)

No fixes (compared to build v4.14.119)

Ran 23545 total tests in the following environments and test suites.

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
* spectre-meltdown-checker-test
* v4l2-compliance
* perf
* ltp-open-posix-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
