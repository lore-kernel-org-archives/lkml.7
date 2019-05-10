Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A51AC46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C37A20896
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rgvp/g01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfEJQ1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:27:47 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35004 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbfEJQ1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:27:46 -0400
Received: by mail-it1-f193.google.com with SMTP id u186so10182050ith.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 09:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dwsQYTgRQ8BYL9lrVKDZnIaHxE5TwPvQtNVTe6VpCdg=;
        b=rgvp/g01rzulkRL3t7YHZVubsFTgMJksr9jvMPY+t1w3Qdzt92Iy2IzcrZJvZVdU4D
         z0qsfZ8n6Lh5qif/nQmACSQRcCZxMYORuyJ7eVv5Qc0ZmrLhJylfoqGfa1P0VGQwsYP4
         kZYBRFYirehv1oz2bmSueR603vBEd2yKyZcI79OBF2eCy21pbTqJS+htt0fCnTPlxsrp
         qURWwJVMQ3/I+K0gqfKIQ9UOc9/C6bxaUQhQBq2+PIwxznppQojzfeGN9g4y5dFgVRPn
         wRHNv3my8lhwKfKbWIJDiCwI2XcPbuQu9IMuAwMHBuCsqbrYhCG0dGfPa586XE3S2XdN
         2gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dwsQYTgRQ8BYL9lrVKDZnIaHxE5TwPvQtNVTe6VpCdg=;
        b=N+p3kWjJd2HTcDeSei2HZZRhnqno0T0z7owIyPcDEKw3DcrLgxl/rYhKIQm4x6lfHX
         gJCrJFTJak6gkOgUiSLl3oZi6EEASyFCfQ6dVBFTVVKMD/FGrxlR2ZPuTqStqk8nKGVh
         OIIatlGPvS9YVe4CTlQiUJX6fQZsSf7cV2gCGaeI+/MZZhUMMSPIdgy1ewy+JnoNEQNx
         qikPd6yuelEEJYeP+Y/DRQ80P7ZNPtECceL6tqapoHpV1mZ/4KuJcXjQ+ZBoTpBVebny
         Qdhw15vewQfTv8IPIPxtJcjxs5KWWaQZjRIwHT3v6lFW4hHa2FCai93qtsYCJ8A4gUBO
         DyBA==
X-Gm-Message-State: APjAAAW1UZ5p56srCgSOuLzzsmEXUUffIYGQdMe2/2HD3knRxdKut6lR
        Tq1He0GcwqGGpVqKjvIywzkAGPLaby4=
X-Google-Smtp-Source: APXvYqzrZHrVx0W2YeZtFelykIMUeX3nCZZxOp2ooGYqxvaxFDrEVwSkJ9B0DqIcvLSML4IbRqKXVg==
X-Received: by 2002:a24:1cc4:: with SMTP id c187mr8576782itc.107.1557505665599;
        Fri, 10 May 2019 09:27:45 -0700 (PDT)
Received: from localhost (c-73-24-4-37.hsd1.mn.comcast.net. [73.24.4.37])
        by smtp.gmail.com with ESMTPSA id e84sm2465744ita.12.2019.05.10.09.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 09:27:44 -0700 (PDT)
Date:   Fri, 10 May 2019 11:27:43 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.1 00/30] 5.1.1-stable review
Message-ID: <20190510162743.3m2psuvcugfqyt44@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20190509181250.417203112@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190509181250.417203112@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 08:42:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.1.1 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 11 May 2019 06:11:35 PM UTC.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.1.1-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-5.1.y
git commit: e4f05f7add176a1379bcd3e582b0ca615cf58000
git describe: v5.1-31-ge4f05f7add17
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.1-oe/build/v5.1-31-ge4f05f7add17

No regressions (compared to build v5.1)

No fixes (compared to build v5.1)

Ran 23855 total tests in the following environments and test suites.

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
* ltp-fs-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
