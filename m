Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA942C46460
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C379B266DC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mfMHxozq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfFCTjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:39:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39417 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFCTjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:39:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id p24so8066452lfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 12:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FjKMKafJPNSzzF96aT2nsNeS2hHaobs9e//3gcK6RSM=;
        b=mfMHxozqqRo0/DOOEOpVB0znuv77DF+RW8mPyf7/LMM+SJojeJoI6qlBymGZBqXHj+
         +44O56j2yLRjye4jy3erFy6vzeD7+y1FcBR/ao3/LaEpjITMZ/kKrhndyuIH+etF5oHF
         EnMfvjui/vlyrWADCihBWi6VJXRTkUB/UjnJNC/tauO1v3O4OAPJhChJk0pdOMq5JL6i
         ZYRq0HgMxaFFL0CqwlKB9pgZ3bglmHZ16W5/C3Pab6Zp1ZOcW2M9Ibm9KCi6MqJOh7Re
         H57sA19EzTsZdXEhait0Fvgf3IzqeQQUQ+j9lxdSJcR/Jas9eQeAMQy1yLcOfTqSSoow
         Y+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FjKMKafJPNSzzF96aT2nsNeS2hHaobs9e//3gcK6RSM=;
        b=ZP+/agUvcaTAU11yUW5OcMFIC7SwxRMUcb5hXDkJDBWgSyg5inq5Bj8qltMc43Lmk3
         fblCI4GtnMq1wPKNe3j90etdGlYk0jr7e06P6WApS7cQZFPrv8nGuCwh7SUR6V5GHB8T
         g4sEMd2dYKZrq02IvdGKtKu4gq/l+ClqkzFLKKyzXc0KBcG/TODhs9KBvFUT4pUZD1e7
         rJy6ece6E29C3jb5KBkhJExnI5A6E3EgKLOHNmXZyB+pNVU0tQQCQoqk3j4NAyD2R1d2
         3gmyGA93gfVW13qMU7KksvXMLcB/Yo0uLImzvCldSKFgIYcb2LlX1MXi7GW31QNy1Cf9
         ERqQ==
X-Gm-Message-State: APjAAAV2OTajDAe8vyVVHvHufZB4ZisHQjTXjcoZSqAwziloIz3QY3LR
        bkOAeJG7vQNyIcdpP5pno16DDB+GrOJPVYIhSIaFYg==
X-Google-Smtp-Source: APXvYqyepVof4nsv11l5V6D1MXk0qbquEmwmwRWOODKz1MgRCOkMoyY5G3SQoKG9hfPayWMWdBfVOithmU3nmRo+VOI=
X-Received: by 2002:a19:671c:: with SMTP id b28mr14428438lfc.164.1559590780413;
 Mon, 03 Jun 2019 12:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190603090308.472021390@linuxfoundation.org>
In-Reply-To: <20190603090308.472021390@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 4 Jun 2019 01:09:29 +0530
Message-ID: <CA+G9fYvP4qARGC7PHMcFyObXOqBpoZ1d4+fptD+J8vV8SyuOGA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/32] 4.19.48-stable review
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

On Mon, 3 Jun 2019 at 14:45, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.48 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 05 Jun 2019 09:02:49 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.48-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.48-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 322f4070727b6cedd9f682203efe5b910b4daceb
git describe: v4.19.47-33-g322f4070727b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.47-33-g322f4070727b

No regressions (compared to build v4.19.47)

No fixes (compared to build v4.19.47)

Ran 25273 total tests in the following environments and test suites.

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
