Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5918DC32792
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 01:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BCE2075C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 01:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GoCWqM+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfJABKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 21:10:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34358 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfJABKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 21:10:04 -0400
Received: by mail-io1-f67.google.com with SMTP id q1so43523875ion.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 18:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xFqMMrxKCXMcslhu2zfrfyc9kzsAj4fkLS/MuTxAVCg=;
        b=GoCWqM+Zz28lLl7ajwAjgTEGFgbWcFOaTkW/9kfPzn3ZKMDKdFEwWUEgtVqEmW5+Pi
         ErIPeoSxLdk0VNNMEgp7WCEpXgfIZ9Iu4xKFiPQX1Oaw6ZkXByS82++7SuP/f+MLNqXN
         zDAOXw/ZpOoCVQkF1ZW1GC9lREvyrIOsRIsYUA4bdQtGE0OsJMZruuKEwqOJmuW6OEV9
         Fwqi5J0yg/bWw8N5yoZlnOwYstfw+N6N49JWq0FpL0Zo1NGoM6ej1ILOQbFpgLGf/IaN
         /r/a1fcjk3XZdTXwG1s+teX8GPGjc59nd4kBxlj9wpJpuLQmOLfPH25JDvplApc74V0E
         J22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xFqMMrxKCXMcslhu2zfrfyc9kzsAj4fkLS/MuTxAVCg=;
        b=lEQ8rrqS/O84hUicEb/h2vJf0oyZAMMU1waptqqM1PBIHzEK8pKR5OwJwgp9Rv+EHV
         hGwcH+/fdcrESBU5uw0XTkp742+gq1uSV46Fh8MSSNtB6KhemGeXHhx8jMqnwM2VMkqr
         699LL8r/9Kt2bA8sZxuvUyDf/81YTLEPo8ROBPRUxPF16JTRdxTJSdm1p9+8sBk0xlTI
         lKGz2cbGnfg5pWd0diQd6UPa0rzyDb5hOX1CMlLjepvG4oco69QotGQqbSi0KMdXzTGz
         vNjPgwwUn3Ve6DKpjyuswcA15eRv2QJlbSadpRvbI9PU/MaPT+Bjkc4i5Z1mpKLPgmfV
         U/kA==
X-Gm-Message-State: APjAAAV/TP9EwaqNEvho9m0R9Pfz8I6VnzhKs4qUFiqjOOLE1nQkB6Os
        u2PE67rTKGs1e2c169MGmCqLjw==
X-Google-Smtp-Source: APXvYqzBqe/7Btoa9l4E24FJ5bN7lZw5IRrcfs9ELCo59g1KOKAhywDl9om7oE3rrVuUuEPsKgVvIA==
X-Received: by 2002:a6b:5002:: with SMTP id e2mr2357878iob.15.1569892203998;
        Mon, 30 Sep 2019 18:10:03 -0700 (PDT)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id i4sm4400169iop.6.2019.09.30.18.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 18:10:03 -0700 (PDT)
Date:   Mon, 30 Sep 2019 20:10:02 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.2 00/45] 5.2.18-stable review
Message-ID: <20191001011002.jswwgiol6e24knvs@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20190929135024.387033930@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190929135024.387033930@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 03:55:28PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.2.18 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue 01 Oct 2019 01:47:47 PM UTC.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.2.18-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-5.2.y
git commit: 70cc0b99b90f823b81175b1f15f73ced86135c5b
git describe: v5.2.17-46-g70cc0b99b90f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.2-oe/build/v5.2.17-46-g70cc0b99b90f

No regressions (compared to build v5.2.17)

No fixes (compared to build v5.2.17)

Ran 22166 total tests in the following environments and test suites.

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
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-open-posix-tests
* network-basic-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

-- 
Linaro LKFT
https://lkft.linaro.org
