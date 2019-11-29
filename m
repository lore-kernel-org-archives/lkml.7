Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD46C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64A4217BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sh5xZc0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfK2IyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 03:54:20 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40597 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfK2IyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 03:54:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id s22so12106592ljs.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 00:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4cIdzPem1gtTXrJfo2HafRoTCZRg5FNv5NypT6qP45U=;
        b=sh5xZc0HwFEOqs7cDdnGBQgbaeliG0TskKpvg+mwd4TC21KSG2qJ/o+imPQXc6NWG6
         yuRvf2zqJy38q5WSSxIc9fdihJHQU2pYdLKSW61stgQlkMTRuUzoUCk6XXgIKwxz/ZY4
         4rTZDgMnnVV3HVPzqWIK0bAOZgqTk6t5VxoMUGNnDgLm078nn20Bipn52oF5rb35d4Zx
         WT2IXY64UN6YFzZr1/RrDbW5cvy5IYP7esrM7kUJzPKX4oCduuCFMcx94gzixd5PM7qh
         pWNblWuTGHM+MrP+TR0lsDqEvELeq0ck1PlctY9UiRzEniK94N2mJG3RQ/MhVfiPG+fg
         lRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4cIdzPem1gtTXrJfo2HafRoTCZRg5FNv5NypT6qP45U=;
        b=noICd4t44lwbYO/ETmhXIcsxAMBCMMQ5rDnAe4YsTUXN67esCyhsr0EKIRqa16o1cC
         Dk+1JqHWicOtZ3JUKgceI/jR3ZSE+SGxHHnt7pPuL6VqeKODpQScTNlzd2gLDlXzRVb/
         PPlOEt8/kbUcX0LWqVyHFaS9gaTNfEidY7iGXSKpiAjtHcCsN9NjnH9JEfq2u6H95g2T
         aocskRmnVnyg/4E4/TpsmV9p3uTUQomup7P0NE9Jr4K63ByBuuSSk0E8l4sBRRSmAK/z
         nMjZWSdCYde2qY6dCMl9iJuWOUNleeXmS/JCqZjGUEXQQDR/SEIeNcfXnHzUVgc6lW7Z
         Q/+w==
X-Gm-Message-State: APjAAAXLiMw7eJiMaxPIbmLIVramf+0k6E9Y0gifzAgNS1pc8NymJ2u9
        0ZWlKeGiMN8xPjHLg28oNCESa6rJNeS1CMMZtJPfmg==
X-Google-Smtp-Source: APXvYqyt+7PQVsnFlfoRnd/SSRNCt5JxFY7QCWPcBAiJ7bkcleAU7YSSvhv9WR+7iwmYdFhc3x1cmkttsKVYTTRvJsU=
X-Received: by 2002:a2e:a0c6:: with SMTP id f6mr69283ljm.46.1575017657691;
 Fri, 29 Nov 2019 00:54:17 -0800 (PST)
MIME-Version: 1.0
References: <20191127203114.766709977@linuxfoundation.org> <CA+G9fYuAY+14aPiRVUcXLbsr5zJ-GLjULX=s9jcGWcw_vb5Kzw@mail.gmail.com>
 <20191128073623.GE3317872@kroah.com>
In-Reply-To: <20191128073623.GE3317872@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 29 Nov 2019 14:24:06 +0530
Message-ID: <CA+G9fYtPJLNVvXapfr1vtpH=T6MxU7NY_Kac-T7U31w-kQu62A@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/306] 4.19.87-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        jouni.hogander@unikie.com, "David S. Miller" <davem@davemloft.net>,
        lukas.bulwahn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2019 at 13:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:


> Now queued up, I'll push out -rc2 versions with this fix.

Results from Linaro=E2=80=99s test farm.
Regressions detected on i386.

i386 build failed on 4.19 and 4.14

In function 'setup_cpu_entry_area_ptes',
    inlined from 'setup_cpu_entry_areas' at arch/x86/mm/cpu_entry_area.c:20=
9:2:
include/linux/compiler.h:348:38: error: call to
'__compiletime_assert_192' declared with attribute error: BUILD_BUG_ON
failed: (CPU_ENTRY_AREA_PAGES+1)*PAGE_SIZE !=3D CPU_ENTRY_AREA_MAP_SIZE
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
include/linux/compiler.h:329:4: note: in definition of macro
'__compiletime_assert'
    prefix ## suffix();    \
    ^~~~~~
include/linux/compiler.h:348:2: note: in expansion of macro
'_compiletime_assert'
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:45:37: note: in expansion of macro
'compiletime_assert'
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~

Bisection points to "x86/cpu_entry_area: Add guard page for entry
stack on 32bit" (e50622b4a1, also present in 4.14.y as 880a98c339).


Summary
------------------------------------------------------------------------

kernel: 4.19.87-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 63633b307be0161e7bd6f854a28d7d9fa05f69ef
git describe: v4.19.86-309-g63633b307be0
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.86-309-g63633b307be0

Regressions (compared to build v4.19.86)
------------------------------------------------------------------------

i386:
  build:
    * build_process


No fixes (compared to build v4.19.86)


Ran 18913 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-dio-tests
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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-fs-tests
* network-basic-tests
* kvm-unit-tests
* ltp-open-posix-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
