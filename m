Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78412C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4297A2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGE4gGNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfCRROb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:14:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39128 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfCRROZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:14:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id l7so4975308ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HaLe2Fm/HSsgq2B+G3J+Okkz8oHEC9mba+2qfpzgELI=;
        b=eGE4gGNW9FEHFcOzPcRxVP1kPKhpHJXf/y5zNGnj8R0HcWc15sEKz9axP3cwibV1dY
         +K8n/Wk8xvP/B/wqwpBBgalz/zkGJ1VQRun9oLn98LJiwpKzwsLanbZBDIRghMvW4nKX
         5btOiSAttOE7fYWBSRN5K1HswxtIVL9w5vA8e/trNz8q8e5bl/VycS5uKscVhwtTlfm+
         gpGLMCuN/A5SCiqZmzBtHGdhM1tlOyNhr2M3LVe43J7aw76n8nVYy8brxTUl8RNLWnzj
         IXTAKtSrmPCJkZEGZUbc8c4t04WSP6/2xqHtcEr6Ye9yNpmODE65AcyWpdgqB25kzB/g
         8gLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HaLe2Fm/HSsgq2B+G3J+Okkz8oHEC9mba+2qfpzgELI=;
        b=gwqiynHtcLW2D0uaDXxSjqju5myQvBqa0asrbHF3PgBX6B7t05upd8lj+R6rNQaKcU
         yW9U0BJsK7FAj9EISYzIb930hmEz0BmwdW+P9zaiUyxUlFMe5rdrnmWfdN2+sk/6Mg3E
         RvZA3hw4aMzGqAyqHYOFLpIqIIvorOCWOukWQl0h8rl+EgMp9rwufkRtLbZ0MVrGweKD
         HrJLn83scwmJN7M9zRXeqEWVxKzQnwg4uDcjWzTRSRuc9d+UhTVb8ebOCF8eaN7cu9Sm
         osSSOKRRhXZezhhhhMEC2ohnYe/n950rkreBrxUhrZbmQmdWhNtRo4OLPumLDzPjN5ta
         yyKg==
X-Gm-Message-State: APjAAAX9f9Sz8XMIxsFB1+kKdIFNCUQFH6gRL0jjcytR8HZAibFbqKyf
        Cu8Kb2iRD940yyPTRHA7uOzJQcjLeOQonradA9Df+Aa4TOM=
X-Google-Smtp-Source: APXvYqzzsLH/5jgkjuO+m0mN07DJN6ig4MoGZG10p7pS+iTUwK6yf+Ee5cBt5ksEX7nx81WD5/o/9TQAnhfvJN+fMZA=
X-Received: by 2002:a2e:9597:: with SMTP id w23mr4258065ljh.111.1552929262576;
 Mon, 18 Mar 2019 10:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190318084013.532280682@linuxfoundation.org>
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 18 Mar 2019 22:44:11 +0530
Message-ID: <CA+G9fYud+K6C8OPxbs_EJn0hAN2f4Ljnvtw_zoPL40=EjVpU7w@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/52] 4.19.30-stable review
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

On Mon, 18 Mar 2019 at 15:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.30 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 20 08:39:59 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.30-rc1.gz
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

kernel: 4.19.30-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 80fa0a60fe1b921d079c6ce09b0271123ea9af4d
git describe: v4.19.29-53-g80fa0a60fe1b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.29-53-g80fa0a60fe1b


No regressions (compared to build v4.19.29)

No fixes (compared to build v4.19.29)


Ran 23142 total tests in the following environments and test suites.

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
