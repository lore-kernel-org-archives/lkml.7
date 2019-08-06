Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED01BC0650F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 02:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B9A20717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 02:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G5in/5gS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbfHFC4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 22:56:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41002 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730900AbfHFC4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 22:56:09 -0400
Received: by mail-lf1-f68.google.com with SMTP id 62so54836177lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 19:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fUbewNNWBu8KxHxIxmY/jB338Bct994oQhtq8xv2Fuo=;
        b=G5in/5gSFRYg8ditk3q110p+ZMAT55Wb2kKlEjEC8bhtOdiwYBIfWQsFZrVfZtdgmz
         9Jnd6OY0S1xpK+lO/mu6osGp4lf2MZ4zYtnaKnJ3WHcl8VaQgKrIytG9kLU41R7e0yD9
         4xY1WF0b0fKruJcc9fwpcvi66EbHChfmC7PBdUeMzY/yAwkVPr+dMUJ8yU+SnAmeIPg2
         b3mXViVeutvQZMUYcLYgJnwhOd5D9gglAmOmlvZZH7COh4WAAriW5QGlIqUBmiACSYRe
         TFC8qL0aOjavs3P5QYly5hE8YmKUaKPPhx3ZiFYgiyUPyEpqAwpcafaHm50HUAM+u+UY
         BIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fUbewNNWBu8KxHxIxmY/jB338Bct994oQhtq8xv2Fuo=;
        b=Qkms232F+aCR9sYxl7fo4V76cKnCBT3rQggIfCBXw1kuq1GdNLQm0EjjT80j90QDVw
         OGacXCVD2wXhlD4Mgge6yTshVUXqT8SKDKgq4Ndw7EMr5UL1VfcaruSCk0iOFAepNSaN
         ztrwjIpol6TOoqsNlWCiyMuBvr5jnHGcmW9lCmlibTjNJqCvsN8B1JJyqW13EYLsdFni
         2N+d1yK9SisTtSO54E0PsBvAG9oQotw5WhzjWXqifKJpSo+y8BL2uxKAQKy7IjIcxMcg
         Z3fsdiVdEL7c7haJ5FPMSmRA3BsVjzGdxOiXC3s2L897tqa1Bk3jtKGQ2hucwo8/zrBn
         E5ug==
X-Gm-Message-State: APjAAAX1NG89y4afg9ygHSQ6v2T8pz5Yxiicz9gjrj8dze+2YdjLFH4t
        beUKbuZJsjdJSiWtO2p7lgwnOwn42/yprF2xZijbGQ==
X-Google-Smtp-Source: APXvYqzcjRgHMf9fRhFjMaTNQW1G44RsNIx3V5RrUyXOxU8YCPZ8vv8WVyEtWYcLMgdZKT58Xha4h2DLtOGp/8ULRFs=
X-Received: by 2002:a19:750b:: with SMTP id y11mr516966lfe.99.1565060166813;
 Mon, 05 Aug 2019 19:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190805124924.788666484@linuxfoundation.org>
In-Reply-To: <20190805124924.788666484@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 6 Aug 2019 08:25:55 +0530
Message-ID: <CA+G9fYsZn1BT46yDjxMi1=HDSmc_Kdrw2ZwcZ8MD6+RZUBS5Og@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/42] 4.9.188-stable review
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

On Mon, 5 Aug 2019 at 18:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.188 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 07 Aug 2019 12:47:58 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.188-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.188-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 228fba508ff1bf754e9bc4b3e72a327620ffacf2
git describe: v4.9.187-43-g228fba508ff1
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.187-43-g228fba508ff1


No regressions (compared to build v4.9.187)

No fixes (compared to build v4.9.187)


Ran 23616 total tests in the following environments and test suites.

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
* prep-tmp-disk
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
