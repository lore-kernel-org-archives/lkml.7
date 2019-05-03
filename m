Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADD7C04AAA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0872089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MbypdYe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfECGzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:55:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41515 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfECGzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:55:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so4341630lja.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 23:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8uvEev8OEJSKiqMfUu7nupOCG5+qPkoDHo3MegtTKpc=;
        b=MbypdYe3hHevkcNm3qZEX6SiMkB/0T4Kq9NaFnMcm1oNtt/iri3njYzkp03+TNZTiE
         765v5ZERux8jDdHOVimnbUvv5WoKZZmIZ35ZXqd7fOldJuG8tPaocoITMs4e592t3gEM
         SrH23pCEzmSn5BFzfTHZZVKjPSrDIERerkIiX7pUIsgvYRsy4FHO7pNp5V+FpmVBv8k5
         GeEdZFgPvoHFF4OB+B0yHXB8m4xTS93zywNU2VO4Qoa3ICE3TXECsUlQLDbu7MS+j5n0
         yRi5wZUvVhl7s2zmsMscheQi0onIor5BhVgaZix0133mry66fXQv+Pmnc67cS36bHhaa
         s2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8uvEev8OEJSKiqMfUu7nupOCG5+qPkoDHo3MegtTKpc=;
        b=RR5GBThEbygAhLm4Vdr+gahEDpsUp80kKos7570yicz3Y3NVamum2LTOoJ8WcXbXE7
         2e+znw10TQNAnYZDWL/vJeTjJ8UVYQxZWjZlS0pWYkmANnnL1yJfABuVU30xjWHjCCal
         aYhazZacLoggAZ0bpZWoMX9UV+b+4dZIy4mGRfzPRyttVR4UeuJUqBHrr22uPPv+F1eo
         DaE+Xd5CUM1TX3ikPWDEXR3wuo31I4OO9aKgKhs+i4TAbhoiFEBkBPxErb9X+b2VIl/g
         oYx4HgUTsn4vEaCpoweAeQuhzpOHK7BssjvMo4t/pMuNaiIbMlDspd92lk1G5OEtAUvL
         EuSA==
X-Gm-Message-State: APjAAAXP6+KkDWH3uAGUWgVmOVlKMan/ZY2ti23SIY7a3nmtLuXq2rSP
        eb+s+GPF1y5MMFW+EI1kBnxKEnJMWltg0Mr0xph7Mg==
X-Google-Smtp-Source: APXvYqy3oHrQEAy0Ec5a/CDBI12pjIJj9AddzOAKNi7WumWeUmoV5tEG0ZZARs4J+XJm26mAejLWkix6cvcn2OjUIMA=
X-Received: by 2002:a2e:9689:: with SMTP id q9mr4005261lji.194.1556866539449;
 Thu, 02 May 2019 23:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190502143323.397051088@linuxfoundation.org>
In-Reply-To: <20190502143323.397051088@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 3 May 2019 12:25:28 +0530
Message-ID: <CA+G9fYspsUatix7BpCnwzDLkLEO+VkZs4JJh3mmkN+XEzSynvA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/49] 4.14.116-stable review
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

On Thu, 2 May 2019 at 20:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.116 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 04 May 2019 02:32:06 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.116-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
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

kernel: 4.14.116-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: a4aa5bff075214a024ba945abb791813e33860ac
git describe: v4.14.115-50-ga4aa5bff0752
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.115-50-ga4aa5bff0752

No regressions (compared to build v4.14.115)

No fixes (compared to build v4.14.115)

Ran 21683 total tests in the following environments and test suites.

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
* kvm-unit-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
