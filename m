Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68871C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F40C2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UnmENT/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389583AbfJDPHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:07:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35639 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388802AbfJDPHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:07:45 -0400
Received: by mail-io1-f66.google.com with SMTP id q10so14306659iop.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H1tE0Tk0zvkxOuvcO9AJzSAbKgb4wOfbPAlGpreJplg=;
        b=UnmENT/6ip+zJ0ZDV1IM9vwMCa5IluK20GCPlJeP7UQ0OLOlE/iB4yLBNoh+7p4Dcb
         R0K1OjXbvc78E1NWyTQqZOcdX30jzfKuyigIcMAOF9H487XPvLtKcTBU4qxtgUC3KY31
         fG2QJxjZhJXgD2G8EzqHxP9hUNEvZN68rA5dNdYJhk55EI9gtYXNqnln3dpU5+p+yLBx
         hrWWYWLp0NlB+1tNfHI1mSfgUWkZMzlCAFYmJhWQ1zr4zB9Xo1m5HVBQmwGgMAhDD/TT
         BOnmdsmH9o3VCJcq48BOAc9lEjD0e9albz9YzXSrVGV44cij4HS/ZwtJyuNg4kPgsHJo
         RsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=H1tE0Tk0zvkxOuvcO9AJzSAbKgb4wOfbPAlGpreJplg=;
        b=DFDjibzaTwEhbct4/5JLcqaMUIQSsfJVDjxpyvRQ6npajqem0Na+lCVVCLZP3H+QTj
         ro66zRt3EcyE47q/xUgAH1Mexk/6Vh6F2EUp1sPe4dvPRkBF34rWIuNAPqH5TxX/pU0j
         B6pxmfdYTwObqBqhgT8mTl7lSITYBPGfsYVxUR/WnguZBmU26GmPuomOs7rtj/9h1gxM
         hpN0d9p7Gzh0bGlFbaOrs4spfoH+izqPtRM/rTJUMHNHqTkfV7zyRUpzPfbrqIBQ4yhD
         I1fsTVDn8cDJJ2hG+nC1RhMUVZ+uG4aOm1jwSSkrnsbRO05PpHoX4Ud86Z9bR3fdwODQ
         8LxA==
X-Gm-Message-State: APjAAAXgIN9RWiKWQuu6VDZnNuCC6w35H0YMufsbveFsXgx/G7u/TZ43
        VWj35JFSukvEqTIDxqHvBNpMTw==
X-Google-Smtp-Source: APXvYqyR/bA+KuWHIUGA5CFsIuFF2BpCp6wbrXIVItCxVyx5eRVpBY7kkzYbcyIPyGbg3ML2H+ekBQ==
X-Received: by 2002:a5e:c709:: with SMTP id f9mr13414228iop.118.1570201664547;
        Fri, 04 Oct 2019 08:07:44 -0700 (PDT)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id v17sm3500537ill.76.2019.10.04.08.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 08:07:43 -0700 (PDT)
Date:   Fri, 4 Oct 2019 10:07:43 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/129] 4.9.195-stable review
Message-ID: <20191004150743.iy36yintuszrw5zc@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20191003154318.081116689@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191003154318.081116689@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 05:52:03PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.195 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 05 Oct 2019 03:37:47 PM UTC.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.195-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: c1fc114556201dc059e2c202e99eac038af8495e
git describe: v4.9.194-130-gc1fc11455620
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.194-130-gc1fc11455620

No regressions (compared to build v4.9.194)

No fixes (compared to build v4.9.194)

Ran 23331 total tests in the following environments and test suites.

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
* network-basic-tests
* ltp-open-posix-tests
* prep-tmp-disk
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

-- 
Linaro LKFT
https://lkft.linaro.org
