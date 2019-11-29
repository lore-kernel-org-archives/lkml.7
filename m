Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C74C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 20:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A369C215A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 20:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kc8Otn3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfK2UPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 15:15:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35151 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfK2UPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 15:15:47 -0500
Received: by mail-lj1-f193.google.com with SMTP id j6so24145506lja.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 12:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jhZvoDjmgkpHHMF+KaBCVGZLWSODhI6Cp1SDmKy5n6g=;
        b=kc8Otn3w+mPUSmbMZnemXFI+l3gqZvEB+zv8oRiNy3deNDc9KH9oib48NMu1hsuodj
         LBZ8xv0i9z4N9N0EU8eQaDDO9nIGoNQu3aYt1HPm5UHmU5yG228iNqA1MRgLR+V1di25
         e6/Y1y7y1zXfiSP82sr71TzaLy+9Mq2TvGqtcDArdocMAshi+/lIw/BAAgzkaiF2Im4s
         z0y9RF6JaTLL14brV6epmtWqfD3YlHr6mpmm0UVd1vo2Ywv6aeLSrlT0o2kkjZZbY7RX
         S6Y/0L0/jgGijFuk6UqzzXwoVj2r4OFxfRnUOsXpShjame4g37d1InZzIwWGQqQlI+Zb
         jK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jhZvoDjmgkpHHMF+KaBCVGZLWSODhI6Cp1SDmKy5n6g=;
        b=PS3voNl5mvqp1ETncCyulu/va9p6DWfnkJF5aK52Hr3+tWfG4IfNWIGjwcka/63w88
         EPLtbxgdfV0rCVICFzGVNDgpM6f92fJ+BwpCLvpUu8nmj6AeQrPJhqsrghZYIomM04Hy
         zB1N3ZFL+ytymKbL/UW03c6v3x9sMjMVo8yVgBbRmvXTIU7WHG8IbKb5touAtwrmWU6Z
         n7P4K7mZVzQceNX7vOeyh9TUFSsysFArNUBOGK+j7Ua2jRT3QvkaRlt0x5BWq7YPX9ac
         ILbyMWlAFSmEmHtdkVb53kVHrQIiIb0cVKSQpgsrHzAyc+OxsjuE+Rz1qJSgIBowBOJV
         SYgw==
X-Gm-Message-State: APjAAAVibqTNlRZkqdUlxXg7JhyzaF8eL3OSqJUG6GfCsr09cPYmxDwu
        9esIN9UGAODy7z9bFQnfuRWZnunifbi62lPk44CWNQ==
X-Google-Smtp-Source: APXvYqx2C+o8YntToEJno8TL8bhR1vVdixkzkQFJY6cb2gx2TvLSubrRSHpKRq496oPNCjbEmhDFs8wS+8KtjBrckns=
X-Received: by 2002:a05:651c:299:: with SMTP id b25mr39527265ljo.195.1575058545402;
 Fri, 29 Nov 2019 12:15:45 -0800 (PST)
MIME-Version: 1.0
References: <20191127203114.766709977@linuxfoundation.org> <20191129103724.GB3692623@kroah.com>
In-Reply-To: <20191129103724.GB3692623@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 30 Nov 2019 01:45:34 +0530
Message-ID: <CA+G9fYuVJi8McvpWq4177hzAjF_n-CNwQeWJB9S1YN4p9E=EZQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/306] 4.19.87-stable review
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

On Fri, 29 Nov 2019 at 16:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 27, 2019 at 09:27:30PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.87 release.
> > There are 306 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 29 Nov 2019 20:18:09 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.87-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
>
> I have released -rc3 now:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.87-rc3.gz
>
> that should have the i386 and all other reported issues fixed.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.87-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: cc82722f8f1b05c10e62b80951b3950e453fcb88
git describe: v4.19.86-299-gcc82722f8f1b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.86-299-gcc82722f8f1b

No regressions (compared to build v4.19.86)

No fixes (compared to build v4.19.86)


Ran 23167 total tests in the following environments and test suites.

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
* libhugetlbfs
* linux-log-parser
* kselftest
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
