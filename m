Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64127C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D4C20873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gc5dmIpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389898AbfJDPfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:35:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38503 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389884AbfJDPfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:35:50 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so14474909iom.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dROkjRhuJBueSR+dDq1NoT4P1fIz/YTzmwLwTy/DezM=;
        b=Gc5dmIpC08P2H+lwgac88JMU2dPhythpOQCpcuiCzCtd9a9VKfD/odxhiT2p7kgicq
         gOH2BfK0YV+NVQwVYgVlQYFLxXZ1pdIoYNK3u061GLn037F9XhLbxOpy7IG+t2+AIu3X
         RwHn0MBy/z02qkNoV+gMHTpiRE5T43dZd12aV2Rw59ygnpT1MMwkjhr5oKZDsPa5U6in
         x/MhOyTGPZut/CpthoBp+iu96Ee25EH7UoquLn55HuOHatF0VyPWuR2r9ypN4Dx1KuKZ
         dev8pg+0Fq+pCAnuRb//VQrK/5C1XolzsCLZil0HzMDRmA2WFYTl63nLeoSxnj/AgjLc
         LrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dROkjRhuJBueSR+dDq1NoT4P1fIz/YTzmwLwTy/DezM=;
        b=UPDgftfdtyqi1rslzp6gUEMeBi839J5RqNOr34EqKAWXkQt8Dj9xwmiOQpFPq/FrPY
         FFWsfE11tBqvD/dVTQ9dZiUaLz9LvEJ2RNQNZtoQeC2RBzzAoIRckSZMLu1KOGQ7WxEu
         vU2oxiqYEBYiZXtz7855t8dS2q1AyGtidqU8EbYYDoLzsRd8XhW5M+fgb3DnkyFPY4Yb
         cpboH8T5Z2+CL+k9Yfl7xCdx7uQpdc6ebswFCjKGQqLiq0UBBOIajCucv995rRUVJWRK
         FC7Hta8YjYmf+M47X4xNShVkCnms7TIyE1msZLRudEBz4JUuP+i6BP11lnWJsttrDO6B
         M1lg==
X-Gm-Message-State: APjAAAU5sBvUIHoMZagHJnffyR7plC4tjUcOYFj0KP78RAkI1AX9TI6T
        ZyvNjDPoPdFB3aoorv12ltKW7pjc6Co=
X-Google-Smtp-Source: APXvYqxT9dLwW/IsgbIqQruWVLrIRJuQcWSKVe1jRBBbxUJtKDMZKHkYVRVJgClWB6dE3tX5oT0c7g==
X-Received: by 2002:a92:d789:: with SMTP id d9mr12547406iln.144.1570203347723;
        Fri, 04 Oct 2019 08:35:47 -0700 (PDT)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id 17sm2217420ioo.21.2019.10.04.08.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 08:35:46 -0700 (PDT)
Date:   Fri, 4 Oct 2019 10:35:46 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 5.2 000/313] 5.2.19-stable review
Message-ID: <20191004153546.fnyclkhmkzjzllii@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20191003154533.590915454@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 05:49:38PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.2.19 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 05 Oct 2019 03:37:47 PM UTC.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.2.19-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-5.2.y
git commit: 2c8369f13ff8c1375690964c79ffdc0e41ab4f97
git describe: v5.2.18-314-g2c8369f13ff8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.2-oe/build/v5.2.18-314-g2c8369f13ff8

No regressions (compared to build v5.2.18)

No fixes (compared to build v5.2.18)

Ran 24453 total tests in the following environments and test suites.

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
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-timers-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-dio-tests
* ltp-io-tests
* ltp-syscalls-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
