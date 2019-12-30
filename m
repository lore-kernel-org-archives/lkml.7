Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB86CC2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 15:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21DB20663
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 15:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="REdtk3oL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfL3Pbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 10:31:52 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43979 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfL3Pbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 10:31:52 -0500
Received: by mail-yb1-f196.google.com with SMTP id v24so14196210ybd.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 07:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VgN0f74n93tGTgkhfr9FTqN9kiv7Wh194Tbtr5XNZxw=;
        b=REdtk3oLqsPRcejY05tSBV5c+6tvc7x4TXn/QxI9SJCRI+pw164OqmhiAVu940MMb9
         2Y/LSfRlwNBFI2N54i4JhheP/x7HByLpeS7DmsOk5EX2PjyzVNdcsg8qKpWpaHV9fLOH
         UbyMu2LccqM74QVRakPL8NagG1AMoTw81edwkeupikEP9M2I1c1ScvpEijD8WYM+xZsv
         WCzQLb5D5G2YlhS3twaeVuIV4u3qSc+0xeN5zVGyVZw0a3ttfn4AXX06Vi5uvvItdUBP
         9+P8A8mOEf2KQKmZ9h7V2VGIo1qv7Pkdvz3ilGj9kW04MfQceFi330dkw6YJmuJ/YXJf
         aEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=VgN0f74n93tGTgkhfr9FTqN9kiv7Wh194Tbtr5XNZxw=;
        b=aK8r8AEHLIbSiW2osS9b/McDC2HSxFxnGJZiOWbZLtqCXjMN0WcG/N/G9sTjEcRct/
         GVlnD+Mh7SVKHodBO0nPNAtYsCUURMZA+nKtPgOEhfZyROrLAsVpzZRmevk19HrO+f+r
         LZCYz1nz8yK6coayitSGwsT3kuK8zEdzRhx7sIJYtyjqHyJ3IJvcxPpDF89D7nIuTvcT
         mu+BrHQ+gU7Z+aL4SROhENK+ZbYC85GPEl410hR9+rUyX5fvRk90dLwFENn7S1cRuFzL
         nz+XHgXAH0VbJ7WWQNBYwpMsHxrUj6UPt9qOyjymj+2VCpPx6Z18LaCG4zqq5VIupIgf
         rP5g==
X-Gm-Message-State: APjAAAVuVk9/An9LmSYNQ9wSa+dSiS9zm0+6Ix6Yp98ZrPHsJFrQl/02
        tMxFSQfu9Q1JiIZ/5Hg81pvVoYRHysQ=
X-Google-Smtp-Source: APXvYqyKKgPiOr0yig1s9K6Iz9OxWZJxWuOq+WrgTqnhEirqV4q5aqJ0f2LUZh3N1cV8pXe7PbbGBw==
X-Received: by 2002:a25:3346:: with SMTP id z67mr47756636ybz.423.1577719911387;
        Mon, 30 Dec 2019 07:31:51 -0800 (PST)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id l200sm18265425ywl.106.2019.12.30.07.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 07:31:50 -0800 (PST)
Date:   Mon, 30 Dec 2019 09:31:49 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/219] 4.19.92-stable review
Message-ID: <20191230153149.po3ovtiuiqjywmj3@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20191229162508.458551679@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2019 at 06:16:42PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.92 release.
> There are 219 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.92-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.19.y
git commit: 798b10a6009db6f4b1baf1b3f76b844b46bfee32
git describe: v4.19.91-220-g798b10a6009d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.91-220-g798b10a6009d


No regressions (compared to build v4.19.91)

No fixes (compared to build v4.19.91)

Ran 24318 total tests in the following environments and test suites.

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
* ltp-fs-tests
* network-basic-tests
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
