Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1091DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 05:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55B720896
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 05:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="da/oMqQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfCWFdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 01:33:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35664 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfCWFdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 01:33:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id t13so3722332lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=euUAmfxkyY2g2prS2yCU6S3BJ8zc7rbBi6Ajx1zv5HM=;
        b=da/oMqQfhk2OrDHNj43jWsZlsxtzACDvjplBrF+XYDbFH4MxurN+P4HZzJJwZISmnQ
         OMt/suD34b1bBnhpLmcbj4757/n6RVTBACGCFfvgt3QdzKBxSxEOJID/1haE8K9zg+Uu
         68udobyqR60cLM+Z1/QtmA1CHnPG56q50xkY6Jdc3AkakR74x/zTuvGDq/rW1Mqp8d28
         Ab0zzmMaHu8ZnwDGWd2/90+Oq6VGm8gwSxVvjzZx1+sbO2uMvbR0+JKm28SC1+FVxvZ2
         R/tiXyi874v/UciXm4kZOqZX5ACyvP5fJgSdOEOXeTGfxxrK4Pk4KSbBoppxUJxZLegG
         zTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=euUAmfxkyY2g2prS2yCU6S3BJ8zc7rbBi6Ajx1zv5HM=;
        b=njQAcvc1XYLCU+/9HaQRAyYOecP5GVZ6zydln0kolpRhV5SlJY/DLEqiQguwYwc67o
         BIVsrPs4Phb4deswpM7d1VDkH2LsZjqGEn+OY//lg29WefY3YsQ74Re1XrHcLIE3EwER
         qAi+a/mXNSSOcutK1R3RrjkQb3+aFqTiN/cYpyRXrYXW3dmAFhsWD8NU+hhrIXu5w20k
         EzKQc/qXh8KucOADEQur6qHZVnk11O9tbawKKvXI7GsCTakeXT5hKic62pO07pN1x8d/
         NF7o2jprvMDDi62lsDz4bhZo6i0LChZZaVp7ioBdRy7lX+MLHGK8dteEEn2lNyy+Lztq
         Xcbw==
X-Gm-Message-State: APjAAAXZIUC4MsTn9imqJo4m7MtIId3oMRff9vSjGaxjlovmnJXGrutn
        +8fqcNufHew9UiogifVJQ6cR/udtbSP/MSZo5WhFdEilq/Y=
X-Google-Smtp-Source: APXvYqzljuIQUBx3fsWEnNV6qUEMTrySmO0i2n1NQ+W6+j/57k2MmlxTOc8/okeevRsQHAenFjwBWfCb+/VNYQNmwzk=
X-Received: by 2002:a2e:5bdb:: with SMTP id m88mr5626575lje.9.1553319217003;
 Fri, 22 Mar 2019 22:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190322111241.819468003@linuxfoundation.org>
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 23 Mar 2019 11:03:25 +0530
Message-ID: <CA+G9fYuyLc7XDFPZ8mZW6zM2vQr8aCzCOc2jbmE-WhRbN-uWMg@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/183] 4.14.108-stable review
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

On Fri, 22 Mar 2019 at 17:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.108 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Mar 24 11:11:06 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.108-rc1.gz
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

kernel: 4.14.108-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: f85b59a43475b5bcca299c897549d4aff496dda2
git describe: v4.14.107-184-gf85b59a43475
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.107-184-gf85b59a43475


No regressions (compared to build v4.14.107)

No fixes (compared to build v4.14.107)


Ran 22886 total tests in the following environments and test suites.

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
