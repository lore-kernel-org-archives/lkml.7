Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E654C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C622182B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SwS6Bxof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfEUKip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:38:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33809 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfEUKip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:38:45 -0400
Received: by mail-lf1-f65.google.com with SMTP id v18so12701783lfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 03:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/HwzJ2AjXIeE5fsfrwG3gSV+GvTQIpLldaXWuHgQcN8=;
        b=SwS6BxofMQlJ3KtGeWkkXfv/uPret6RUl6uR040BI+WLU+WR6kyKSpqkXu1Kcq3w5u
         fB/CVBMtuWPU1Mkgqpy5KSQXGXxUgL1uFCehYHHIwCUv/NUwxt8TIvML08vluYQwYvWh
         OtN8oq2AnpE3fiDxhG9SjY4u8cuXNnUv2F/1OXXrtbIl1Ak6GV1NuvmK+5GKwHeaHlbt
         GGup96HZjBaFdmCdYsAGn3FRH3MZhi6HVfQ/bxRdW/MidCnWyLAZEf1n9RAJyYF0RbAO
         FxIm2zscCgEgj7aa9LXIpkS9VOqwBPJ1WCGK8C6VN8qF9WkLz1/P5akbowS9fXHB/IxH
         NrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/HwzJ2AjXIeE5fsfrwG3gSV+GvTQIpLldaXWuHgQcN8=;
        b=hN7v+RAUZ6FVzO7QYCrYTlfVMWwlqfO9tC65JnP0aGSquGef5BTGUIrcc6q3MVTqYO
         PqZyoEJlT7I9QWKs0ak/mntaFN5XBUY+kGAASbLOvspSZvkM9M1r/P1tVgzV0lxERHj9
         ySfuN8XDPv9e72QpFViCbt2fiRj/y4r3XlftLBcdB/mhPWgx3qvvFxTjB/kwtYP+w2ZQ
         eCpoQ/I+AkxqHtj8rIhIKu6Ag20zrL3FDiRe7wjclXdc4SziZtAdxBGuerPvCn+3COSg
         fdIjQBI/91TDnuVD1y/Rga8edo4sYhK46I+Al43eC1Nwbn4DSadgkViZqFEKCeTZVAWU
         ijqA==
X-Gm-Message-State: APjAAAWzgMFn3LxnC2PXZF0rH13ErQQJQ1RYp6iaihLKIxJatsW7rzfe
        vT2ys1G/8ipFpNlQ9bYpoCTM+8GljZPTM8tmrxT+lFq3YVI=
X-Google-Smtp-Source: APXvYqyBfQ0MOaJ6vL3o7YaTQiEePRTO5JQIELaO+d1PWWZJ3440xMJR4l0YWpbbNf5nhBHv7lRxlbin2oq1KpgIKEw=
X-Received: by 2002:a19:f80d:: with SMTP id a13mr25505147lff.78.1558435123624;
 Tue, 21 May 2019 03:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190520115231.137981521@linuxfoundation.org>
In-Reply-To: <20190520115231.137981521@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 May 2019 16:08:31 +0530
Message-ID: <CA+G9fYvuMxinio=Uxq7=aoqLH7a7Twgsnha9GrNzWF-sZZBsuA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/63] 4.14.121-stable review
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

On Mon, 20 May 2019 at 17:49, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.121 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 22 May 2019 11:50:54 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.121-rc1.gz
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

kernel: 4.14.121-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: ffedd7fd95e8d03834094434754a33dbc060770d
git describe: v4.14.120-64-gffedd7fd95e8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.120-64-gffedd7fd95e8

No regressions (compared to build v4.14.120)

No fixes (compared to build v4.14.120)

Ran 23544 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- i386
- juno-r2 - arm64
- qemu_arm
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
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
