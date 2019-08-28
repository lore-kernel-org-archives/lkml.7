Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A706C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1393F22CF4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="itwtnkWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfH1FAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 01:00:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42346 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfH1FAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 01:00:22 -0400
Received: by mail-lj1-f195.google.com with SMTP id l14so1301776ljj.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 22:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qf5g/tYp3YFrTIzqEBilUnxPZLxUd4p7Te79zHq65DQ=;
        b=itwtnkWIWqG+1NxMjL0TcmCSJeOj/xX1vwvpmYbTf0yIf08TMYWlhLpVuN/kzjVpXz
         c54xuxP1iVa1MpONtKFpWaHIVTpWbJzR9gkJ0GhuWlxYBD8SidnNP6VDIYhB5BEMRhRI
         +/gsah0hHpwSIM0zF9YjtcWWHKga2oLbTpG+Uz6GCbhSe7u0pkYmvgSYWKMO4X3RBLzQ
         zTJfGXDFdb0Af7ASMAB0ciGQ2rEQ+3xezuIyQdHis9CSJKw4uwiX6LUA2AJkL7j05BHH
         cVkG4jy6DZyKzaYMcLgZEAikOLZe8/zpVO0JBZNPgWXYRWRw4b+j7NOhXR2U8dM7UJAz
         ZHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qf5g/tYp3YFrTIzqEBilUnxPZLxUd4p7Te79zHq65DQ=;
        b=BjExBWC308lvMEBPFztHlN95JFOHTqRuD96InMCDHh2rWYq7m4/MnOzO4LoZFjkLJi
         noolOKcjLGE6FQ6QpAUScbMtmK3Odjsu5r5HkNdJsgaK1TYGMb6yZeBy1Z2IRPUKLJI+
         ZjyXmlfz5g7NpopNDsQwn6Z5jERyaPcYkmWJQORfEm4iBCO6t2dYqAzTlHtVV2rVloAO
         L5yOiupyt2s8/PecsVjpd66xpZ4cSeQ3CW+CUP9/LHcQBIKnZCkYsDg1qKKumYitkAqj
         XzZA8p56Jj8UH1Pn+ZqIqWQOzSxt5BXGb8R2UT3JNTnUDK5pUBK1Hc0mS03kX61IbGEA
         z2vA==
X-Gm-Message-State: APjAAAWv+ELEgG4L7KZGONms8YW8gF4er430Npicuxm32XMTJR9Ffpru
        v7eurD33/PZfrSu+VQyTj/0LE6h57sPqJR2PTPq5Cg==
X-Google-Smtp-Source: APXvYqx0uanWUxL9fw4n+GU/fNME8gQB50Kpu7FBsrzLpXxZP5UcNrwnA49fDGbqmxH6IA+7KZmO+TQ2+iHHE0CETgM=
X-Received: by 2002:a2e:800a:: with SMTP id j10mr922530ljg.137.1566968420829;
 Tue, 27 Aug 2019 22:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190827072738.093683223@linuxfoundation.org>
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Aug 2019 10:30:09 +0530
Message-ID: <CA+G9fYtmHsr8XWvmSLy9QKvF37KfZ4v+T1VnRy2uhpE0HB4Ggg@mail.gmail.com>
Subject: Re: [PATCH 5.2 000/162] 5.2.11-stable review
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

On Tue, 27 Aug 2019 at 13:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.2.11 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu 29 Aug 2019 07:25:02 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.2.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.2.11-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.2.y
git commit: 9f631715ffe68666bbe4c5f7ad0dfc1ed387e1a1
git describe: v5.2.10-163-g9f631715ffe6
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.2-oe/bui=
ld/v5.2.10-163-g9f631715ffe6


No regressions (compared to build v5.2.9-135-gf7d5b3dc4792)

No fixes (compared to build v5.2.9-135-gf7d5b3dc4792)


Ran 24414 total tests in the following environments and test suites.

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
* ltp-fs-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
