Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A73CA9ED5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBED206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W21Wph0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfKEG1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:27:11 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33145 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfKEG1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:27:10 -0500
Received: by mail-lf1-f68.google.com with SMTP id y127so14160213lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 22:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W9D+1G60WFt/ifO88MXlbmnG2NsKLbtzguboTP/BcHU=;
        b=W21Wph0o5MnmbzChDlLpXW5zDUyZl5Ul0oWUAj15Lrfc6oNOkZkt7pbsag+20eelYr
         ScxAtGtcF8o20A+a6i3DwV20jVZ/bRQHT09G71XS2fFZ/xQgGgx4GwC+pdEcAk2vJLu4
         5M4MnP00yvEs/GrhQFab5MZo2PGkrFl4CnpQqRFywrsZMZTYAQcd3Dx+sI2KuoqRwMnT
         +8qEc+WJva4W9yezeTHYMNJ7mfkzYAdsKgzzNA3SOxou5GQweM0Qbd4P+fwhWu2PoQKs
         5h4NrQCoskEK2nXddg6eV6RFImL2GFOyN7ysqQEDTJrX/cZ7t0FSjQ1HEthjinY/ox3k
         cLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W9D+1G60WFt/ifO88MXlbmnG2NsKLbtzguboTP/BcHU=;
        b=oRth9j1+ZBGWEd2bRkSfX1UMIwsjfmLbi4UPAH2n1X9uzCPRUtDsFda7UEFsPoZqzl
         8vfFwq7vc2kBLpE90Zn5oTQMiWR5QNkL3/SDgryTuILkOdfHAwy6+9dJkmF/LwNl63sR
         +JAhRGoVeCDW/XKx4oTx1NSEnS0SQew7ajrTVrpsZdYjJkEDuYlRRfdgZ/LQYzl2RklC
         CEQrveL272ICtwpIsqtBNw7CcStQZtwXP4BzXE3kZOhbAxHoXLu7ABSi55PIkZNs3Uer
         GlxKceGNnlHz34CKNKKZZ+ztGePZJ/+SGvTPWiYmJWPs0tr28rKUz1h9UIXMuIYcLuCk
         PiMw==
X-Gm-Message-State: APjAAAVE4I/dii7lWXq/EJJqe9EsPOgTyUn7fOeoKLM1R6tgVvQaqfcb
        FLYnnU+PuiSyyIBsfptGYkAaTYG0UkMw/3X8MKr0fg==
X-Google-Smtp-Source: APXvYqzIDp3IacxrzvTOBlzew7ZDXmAMg72NkYErri/ebyzTeaSbdiW4CYmi2ki3F6fX8YWi43pvPqS/VMMr2jkE5TE=
X-Received: by 2002:ac2:5930:: with SMTP id v16mr656873lfi.67.1572935228350;
 Mon, 04 Nov 2019 22:27:08 -0800 (PST)
MIME-Version: 1.0
References: <20191104212140.046021995@linuxfoundation.org>
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Nov 2019 11:56:57 +0530
Message-ID: <CA+G9fYsVHLWFEV7Tc+_EAgH1QGDrN8OBUK54rK_48bnZ=JLJNQ@mail.gmail.com>
Subject: Re: [PATCH 5.3 000/163] 5.3.9-stable review
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

On Tue, 5 Nov 2019 at 03:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.3.9 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 06 Nov 2019 09:14:04 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.3.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.3.9-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.3.y
git commit: 75c9913bbf6e9e64cb669236571e6af45cddfd68
git describe: v5.3.8-164-g75c9913bbf6e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.3-oe/bui=
ld/v5.3.8-164-g75c9913bbf6e

No regressions (compared to build v5.3.8)

No fixes (compared to build v5.3.8)

Ran 24209 total tests in the following environments and test suites.

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
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
