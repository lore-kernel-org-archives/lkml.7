Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92166C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686872080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WdYnLT+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfFZOpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:45:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40699 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZOpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:45:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so1763527lff.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N+6gyYOIX1iLLQ6EUiMMl4KP0ddsOthUBAUBxo+bC18=;
        b=WdYnLT+Kt4GrW0q3Ff1ispHKtr478y9h1PSa08e+AKIdeeI5ytbNvTEO1nD5srU1Hl
         yRvxlSJSRyNgNss3QYAKbtgWvLEWt55tR0JCIKN+DjxH1tkT4sWazEngy1UEDBaa3jMy
         eO1BT69VGZYz0SJS4zlQGUv7nIY4X7Aupj8I0yupblAZh3qaoi+gq7bwja0Tq0obKybc
         HAUqM7bnyAo3n+LDLDpj35bp2bFbTHfqiJKcHVsby2EZIeNtkv3xSRPrj2JTEt6oHYf+
         6C6PFTi/1Xi1mpoM7cdjwBQ4mzCmUfU+zRcWcs8V1RLD1sJIxJ4SA9M+6RCNyld2kmEl
         4LUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N+6gyYOIX1iLLQ6EUiMMl4KP0ddsOthUBAUBxo+bC18=;
        b=QWkJtIV2rbikv38gn+/zRbR/brjgRnvm24xakE4RURMZ85UE2NNyiqJ8bXuU9Rltoo
         CJu7BTF1Ngzr0dPzKwD70B0fIuP1orP9oSTKzuD2JDijnWMNpreUU2swFW8Jp7tEWuAP
         ElSZoQm+oj+/hGbxH2ou/1KeyPZvZiDONQXoOnmUkDu8W4fuTlBHyLaD7UGIP0jzk7po
         GnHrimpH8i2PSTcyrFmRnuSk2vMpVJBEEmjSDL0eaeLccsetOlhyga0bZHT8cPhJMc1F
         oVbF0+yRHNtw/akGwiNgPQGunAVZKSZYjeEUe1XPnz8chl5bDaDwNvA6PnHl6ylELcJI
         RGtA==
X-Gm-Message-State: APjAAAUNymi0tTBDugcYVx4OZkuXLM8/vM0cciDh4uyFK4XyjOHS4jz+
        WGrejfdMaQUkqX0qf863v5ZPPvceVNk0amKSNyLngw==
X-Google-Smtp-Source: APXvYqzIYABUDHv5h8uBMgqOxiOV1B61xnp7XE5VctCxEa1O2V7S15aJux8JuUZYE2Ab8jp/iIPdIJkd7zQEy05SDkY=
X-Received: by 2002:a19:671c:: with SMTP id b28mr2988270lfc.164.1561560318946;
 Wed, 26 Jun 2019 07:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190626083606.248422423@linuxfoundation.org>
In-Reply-To: <20190626083606.248422423@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 26 Jun 2019 20:15:07 +0530
Message-ID: <CA+G9fYuaw+eZsGn=cOUWObmf4ZupjBd4U=w34s9k730O+dZjwg@mail.gmail.com>
Subject: Re: [PATCH 4.14 0/1] 4.14.131-stable review
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

On Wed, 26 Jun 2019 at 14:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.131 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri 28 Jun 2019 08:35:42 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.131-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.131-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 2f84eb215456bfd772fc0d9efc8446a66a3faa1b
git describe: v4.14.130-2-g2f84eb215456
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.130-2-g2f84eb215456


No regressions (compared to build v4.14.130)

No fixes (compared to build v4.14.130)


Ran 23880 total tests in the following environments and test suites.

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
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
