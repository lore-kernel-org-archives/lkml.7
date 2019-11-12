Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6FDC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9042214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ULkqAdQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfKLN0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:26:33 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35045 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfKLN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:26:32 -0500
Received: by mail-ot1-f65.google.com with SMTP id z6so14280718otb.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 05:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h7gNuS9p6cP0bmIhvsGxMeUDxcBC1KUmMQ3LFSAd6gw=;
        b=ULkqAdQFNZo3jskXqOoy1RAlkyzRdK6kMQK5jZEbuOQs23b00AYK8O262HJehfJ+f0
         eiWBYZK0TNPfN2d0Nryvqb0GBOnpYqrU3bu4RbE9S4PcxrxLrTk9oQjEnzcwnk6udXY4
         qe13l5l9/GnRfepfIMEApxF8YFawxqJGiglz1u7VFhDSNp9Zg+XPGIFpWY55BDE7pOQd
         1WnKq3WOrp+gT48gqEZuZjviVJxnTJZAJ1wW/fZsU/6OgZ49ke0F2OeMoXoqO8c3+ZAm
         VgN04hIZ+afoDgeg6EAx2svgVVuC0zengnNQYo+gusn4EmxDMYxNlboHzyubPG2UmfB8
         Bjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h7gNuS9p6cP0bmIhvsGxMeUDxcBC1KUmMQ3LFSAd6gw=;
        b=a8GNednXNH3kKv6asJ6TMrloB7MCYmCe2oOmBu3y5vPP2kbqHqJaktYXTR1SOaUlqZ
         AsDMwCa+bBC3YKjn+DrqTH81fzvWVjNCq05P/z86vW6m8FAYwWZfRGqQIncoYJF/d0uq
         wn5MBeC4Y3EAraN05QISOJfrSkybr24zmoWxyn202eLN5x/NrtS5RiOIsktxpgFXOT2a
         i1f4Woia7/9AhzTNBTi9hYkUlMXaROd+tCP8URF66T94kbz8O7v+bQ+JyWwmew4LmSjQ
         6M282h7SYI30dBfI1MKx//SFvS8HBsWXErUTJDKh2Qzgml3hcGWH/IYq3YPoWzIJ9j4L
         JEXQ==
X-Gm-Message-State: APjAAAUVBo+7klyKIGVw8/JYwcH+abayu4wJ4d7uQ1YtwpHV8rdJh0Il
        EdVvLnjJ50jFzRPbqAPiHn9xgpLxczKB2wNn7gIHzQ==
X-Google-Smtp-Source: APXvYqzkCDMR3BU1iW92LaoBF5oRAgEq1nnEl6n9d+XmKrd7Vs0fILuL5Poq1Zt5hVQ/4Do0bVZCH+/64Xp1J1Wozgc=
X-Received: by 2002:a9d:458a:: with SMTP id x10mr24581645ote.365.1573565191496;
 Tue, 12 Nov 2019 05:26:31 -0800 (PST)
MIME-Version: 1.0
References: <20191111181421.390326245@linuxfoundation.org> <20191112052822.GC1208865@kroah.com>
In-Reply-To: <20191112052822.GC1208865@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Nov 2019 18:56:20 +0530
Message-ID: <CA+G9fYto_RmYZo_bet1GijYGQ5TfPxJ9WpyfzU1PWw5vnPqjZw@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/105] 4.14.154-stable review
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

On Tue, 12 Nov 2019 at 11:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Nov 11, 2019 at 07:27:30PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.154 release.
> > There are 105 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 13 Nov 2019 18:08:44 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.154-rc1.gz
>
> There is now a -rc2 out:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.154-rc2.gz

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.154-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: fc7e45ae100f042a6f3e1cb7bf47c487b2d5bf3e
git describe: v4.14.153-105-gfc7e45ae100f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.153-105-gfc7e45ae100f

No regressions (compared to build v4.14.153)

No fixes (compared to build v4.14.153)

Ran 24216 total tests in the following environments and test suites.

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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
