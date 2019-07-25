Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584D3C41517
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 04:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314F322BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 04:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dy6x7El4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390272AbfGYE6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 00:58:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36655 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390204AbfGYE6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 00:58:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id i21so46701079ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 21:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9+NOmu0ZAGYhLycHrK5M664LA1VOSDREzqpm8uExcCI=;
        b=Dy6x7El4IxH6xxqwSIXwk8PVp3iArZQnLOPaatzWbQol5FXPSiRD+mSzToWtfeBy43
         0qOrR6FwUd1VSYlZT8ljRjbi/p0S+oxpx6zOyQEIYkn4QIiANBECJejUmcWhCmFmCE8g
         Pkk6Ib6ZsllRiLQviQOuRpoWy7LLAQQ4Sp01AD4kMXRltwrtr/9p2e21Kt+iYMXMjCSR
         CQTaAVL4RfprKmQyeSzOkJMLu7egFIspCG30UuvrQDngDclsfkbPkQyUvb4cYW55Alrg
         9OyR9QVIjFWxIEqOQ/CQoLr7MA0O5TjPfhQSX8TxrDIWAVGGroubmE0oaAU7/c23esID
         xT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9+NOmu0ZAGYhLycHrK5M664LA1VOSDREzqpm8uExcCI=;
        b=ciAmNZ3NVROP3QceBqkG8/JYzjDVaPnea+1PfHNOR5kpQSKzm9rNtB6X7Ukj3V/OQ7
         op4SfPeINyI/HrhubiCKOVvfD3qQmjphkFVnwnN6WBEwLogohMTcHypLxZeFAODsxoq9
         7T9KwPgNwQi2XeqCtjkfVNLTEs55n05hL19BuyWZEp3aeF8eZtHxdRdQB+k4ONpJAq1J
         NJdDVOh17vbdtLYUWcTQ33YO2BQH+iqHrSbHj24EFCXQ0FlnNWHicahIronMnwzGstQE
         wA+YLTd8pmMNj6xX2JhQFAgtnL/9Dt3r9vtBhYbcVqT8n2a68oFZz5uM98/NgpBo7gH6
         Hb8g==
X-Gm-Message-State: APjAAAUwoaifK18WUML34c31h2qcfy3OdiRNy/FShj0yQEXsy3LZOXkV
        ecjj8uXjUqGk9fPldRSG3Vj1JHwHzro0EcKpwmpY4w==
X-Google-Smtp-Source: APXvYqxCxXvzfSrCzd2T3BmPanalQe0AYZIjpjc3wJQbiJzoSwhJm8/FAOCzsW6b++2SD0th2VtkctElnJkmZZvQwlY=
X-Received: by 2002:a2e:9b4a:: with SMTP id o10mr8836705ljj.137.1564030709205;
 Wed, 24 Jul 2019 21:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190724191724.382593077@linuxfoundation.org>
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 Jul 2019 10:28:16 +0530
Message-ID: <CA+G9fYvwq2n_uzR8H6Vh+2zQEvn7t9LRFxahb-1bzm5uE1B5Pw@mail.gmail.com>
Subject: Re: [PATCH 5.1 000/371] 5.1.20-stable review
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

On Thu, 25 Jul 2019 at 01:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.1.20 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri 26 Jul 2019 07:13:35 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.1.20-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.1.20-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.1.y
git commit: 21e90543f836d29dae6ec06215a6e52419913d7b
git describe: v5.1.19-372-g21e90543f836
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.1-oe/bui=
ld/v5.1.19-372-g21e90543f836


No regressions (compared to build v5.1.19)

No fixes (compared to build v5.1.19)

Ran 22773 total tests in the following environments and test suites.

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
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
