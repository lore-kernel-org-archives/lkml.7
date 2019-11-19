Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA97C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FCA223E4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mFRwwHY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfKSSmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:42:31 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35982 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfKSSma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 13:42:30 -0500
Received: by mail-yb1-f194.google.com with SMTP id v2so9080695ybo.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 10:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cw9hmUFUpPDtGIf4ZvNwZherqaE16lyUPhATjc2UW8s=;
        b=mFRwwHY6StmSnUWkP3ZLCHb8OcaGmUWq1x7shOaRQQG9At1cubvDVORGAOaT8M8Vh/
         cZwgoj6BocPF0zBGvSAQvR8g+OwFMjGhRlYc/rUXVdRp5gDMMzKPN5praX+I8GkFeWXd
         G/7ntaYG7l+bK/c/zMP0drU/7lsIONWAK5XLi53bMv+vlKGTHbNRvHXWsmFD88GLHsrH
         3ozyQ8lsNWG+9UgawgabPwxXfWQ9I/s+HY6+4BQvfhBTl6qTkM9Ezde68hh4r53sZo7Q
         lQ90LVO0UXoG4CerWweFfufvt7rQlykp+G8jVIXImTv2Wbi3gkD1FQilI+KovFYms+qm
         2IJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=cw9hmUFUpPDtGIf4ZvNwZherqaE16lyUPhATjc2UW8s=;
        b=n+4v+7xqfScQSWV7iYRhWwDekr2ugdjY8NUlmA3NbHDt7ZCTgY4D91YVFMLRPDpghh
         eet0BfFocyl7GVhaB4cWsB1NqDscz8M1ykHCBHIWMZ5T4ff2Ej4LHRL5OSCaePh7WyAD
         B4IzMocz574Ehn6cs30/vVlWcPkHlEHKjxXhkRW5a0UXUJ5ZQvZEpdFF94wxpR/pg5RW
         9qwhx3wTSOoN6EZod1LbxlsC8J1GsTMAcGY0tRCfNB/bLJ6yg2Zo4b3J5MhTIFW0NrQd
         rDj5yvRZtFmsqp1DxmknV3vMc5qH9giumj8nbJmG2AufzdWqGKFNAZnBSBd6kiiV2Fdx
         HIDQ==
X-Gm-Message-State: APjAAAXJkwqWIY/9Fu6UidPKCVAqd2JR59T0fbQypj5E22JMCBiaM6km
        Xi9eq4U3Z4iKK0r5cZMnMWOkDw==
X-Google-Smtp-Source: APXvYqzxE7v3sBwfQKdl5+1DU+yYdx09BZ7CHGTzmEHH59c5RAwDwrgcN/q5SMbrgIwbHX6TLLUxKg==
X-Received: by 2002:a25:8c1:: with SMTP id 184mr30591025ybi.440.1574188948487;
        Tue, 19 Nov 2019 10:42:28 -0800 (PST)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id z16sm9768236ywj.93.2019.11.19.10.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 10:42:27 -0800 (PST)
Date:   Tue, 19 Nov 2019 12:42:26 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/239] 4.14.155-stable review
Message-ID: <20191119184226.h4dxnoxtbeclppdz@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20191119051255.850204959@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 06:16:40AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.155 release.
> There are 239 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.155-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: 086940936515491724d7d237c38c1a85e6309ed5
git describe: v4.14.154-239-g086940936515
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.154-239-g086940936515

No regressions (compared to build v4.14.154)

No fixes (compared to build v4.14.154)

Ran 24215 total tests in the following environments and test suites.

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
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

-- 
Linaro LKFT
https://lkft.linaro.org
