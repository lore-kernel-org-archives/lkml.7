Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB5AC4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 06:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884622081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 06:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2Ey5b3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCIGmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 01:42:04 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38461 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfCIGmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 01:42:04 -0500
Received: by mail-lf1-f66.google.com with SMTP id k136so5485716lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 22:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sk/8pA/sLnOJ4GgTi/s8ahIwTBPr5d0RSuBzB1QwcIs=;
        b=l2Ey5b3iqZyTB0K9Dg9AIkTqKugnOfd80sICpo5xCfcXiT9L/WLGzfQYkKUkuroPDm
         ICe7A6y05rGNNX3XN0rWCdGquNgVK4Q72eVxYk7kwnbqVKei7Ea3Vdecd6XpgbqYiciG
         hjKPIGQnNrtWcITK839ArvAdUw5mcb0YSH/oZ1uj2ZWjU+OrPf7m5ol7YrJBiPOATw0w
         U32OtVLJC25+9ZNv2VHPm/Ou8UnNPkXmUUhbMRgs5rso6kYqqATDfYyib2k87ShVt6CB
         XnVm+Cwor063wGYhR32hzsnp/FXFgF+Hx5LuFVvwioYjR8wm2ea5r8NQOjDTWhn7Dk2o
         WXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sk/8pA/sLnOJ4GgTi/s8ahIwTBPr5d0RSuBzB1QwcIs=;
        b=YxsmxZop5WLxZXPYNbXOTBQV/UPEM0TIyqmmdfFLN5wgzsk8AWR20R4FhCwzKd23Db
         oi8GNprWhaB8a8h4SjNYeTzg+KBnuH0w5+31B7aeL7OJzTqzwvL6fduxD6IzXMe0E2fy
         dIanmx1PhoxvBVqgwo6YON7rI3/k16WtXmo8dMIORpLSVjKquHSozLC0KqvdPDmjO38B
         8+c8MfgW1dewZzAtte6dpWYGJE6bxVPoAxZYeplNrBjSEu1dUZq9z3kI7g+Gdp6HKnGh
         oApR7WR7v/UzAgiP5lNQqyl0xxZaF9TnydkMCn4pCf0Y8Ls+ixOOEVlpbpsan7SdzzWY
         Lf9Q==
X-Gm-Message-State: APjAAAXICXSNRzd/ZshM1d7j+5BQHgnIQestyZiJYT3FrVfs4wtRw5Fk
        8hBY6UoJr0CISEyo5hM5ahaie6BW1Ev/ONZxzaPEHA==
X-Google-Smtp-Source: APXvYqz1znzkI5kNdaXtKovcx55DpIzVpMWzzBssNx5wq8jsbUyQH7O/XSrR3d6zMzIp2UFuu4ffrsmy3F0a+ktCSFI=
X-Received: by 2002:a19:57c6:: with SMTP id l189mr364061lfb.0.1552113721662;
 Fri, 08 Mar 2019 22:42:01 -0800 (PST)
MIME-Version: 1.0
References: <20190308124910.696595153@linuxfoundation.org>
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 9 Mar 2019 12:11:50 +0530
Message-ID: <CA+G9fYtAc2tWvurS0CLD9nYS67mSY=A_mQf=Sv6SfDtXHNcdOQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/68] 4.19.28-stable review
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

On Fri, 8 Mar 2019 at 18:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.28 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Mar 10 12:48:45 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.28-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
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

kernel: 4.19.28-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 838c866ce1705a8e395223329e59c4db2eaf78d8
git describe: v4.19.26-148-g838c866ce170
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.26-148-g838c866ce170


No regressions (compared to build v4.19.26)

No fixes (compared to build v4.19.26)



Ran 21748 total tests in the following environments and test suites.

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
