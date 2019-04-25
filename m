Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B6DC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DF9214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LrsaIVHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfDYF0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:26:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35990 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbfDYF0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:26:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id l6so4189020ljb.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 22:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZqrnuBYTaaY8syoPhX9eR5gol4bj2h9xnq4EpWuGaPg=;
        b=LrsaIVHMkk9u5Xc+2w1+9CC1P0LpYNyiwu8/f79vTyQhbQd9rKIuEPKsHd0yCOvYKD
         5GRcBORNoz4VENMPSJo5MlmGx/LTUQSw7MzcWyiascSbhD50nsCs6KpQzITozgfdJpgc
         f0GenyGWPf/g18GC5CWLbO9q2+LrFVFd39L+WGWo52Bxuw+9t/l4Xc8aM+zquV8KSOGX
         73EmZ7CcJdLsITOEYWZW6X5hBLnxGQtoUjQEtthjILzAWBSBirWOuEGedbTRiZ4OapKq
         wmfn0aGb/HI4PoIt71EZYjh4NwgZgpacFvtrgQaBJvW9ap+FBbor1G90QVWxMp/2O/kY
         Gf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZqrnuBYTaaY8syoPhX9eR5gol4bj2h9xnq4EpWuGaPg=;
        b=CIu0KpF4QqoMYPXJQmej0QacZL/CE+FT5HKItQmXo7VaK7BFoDPR/of8a/EjLXj+0/
         0Kl1+ZrPfRxM1WNbMhuGsRqIHHsFBskcivVLhbmeiWaeKAVPgNkdcOvXEOBjJfYs1dbc
         ux0PEcSSWdp7ZVpZMSS3S4x8VW+waCxzq4SP+l7NjktSL6Gm0GLH1yvTtj7JyrY4UW/h
         igPCcEX2iXPY4LYiUxnvPTTVbc0NpSjsAwNgG2e9yCLnYmcgmW/Cu1Co1tg9LJ4tSe2S
         eEnmUqVR8m+BQu0JCobpf21bVTiCsISxnub0HxvaXSHzVZAj3bQHHl/pF8WC9JFELLoV
         /0sg==
X-Gm-Message-State: APjAAAUWCL3JXWRP6mTDaQXEWgc8ggAWTAhgWbUr/+NgR0p06OIiFmK/
        1BcH+hpBGEGOKFW+NcGvQb/qciPunaHF7BJKm/ktQA==
X-Google-Smtp-Source: APXvYqwEmabGXyc5wb8/VHcO67GMik/bLZSBpnNfx1E5kWpKV7weplTVh8GSsWSHERb43Gg5bRRjZSxKjMLmeZsWKZM=
X-Received: by 2002:a2e:9993:: with SMTP id w19mr4326087lji.111.1556169968824;
 Wed, 24 Apr 2019 22:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190424170924.797924502@linuxfoundation.org>
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 Apr 2019 10:55:54 +0530
Message-ID: <CA+G9fYsNWE=qd1aZJ+cUhaZEzB3KP5d6CWmB7O_bKJFXG3vf3A@mail.gmail.com>
Subject: Re: [PATCH 5.0 000/115] 5.0.10-stable review
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

On Wed, 24 Apr 2019 at 23:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.0.10 release.
> There are 115 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri 26 Apr 2019 05:07:37 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.0.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.0.y
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

kernel: 5.0.10-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.0.y
git commit: 058cd3811b12d43363fbf20f6c7963e67b4802c6
git describe: v5.0.9-116-g058cd3811b12
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.0-oe/bui=
ld/v5.0.9-116-g058cd3811b12

No regressions (compared to build v5.0.9)

No fixes (compared to build v5.0.9)

Ran 25039 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2600
* kselftest
* libgpiod
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
