Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1972FC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46132084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="taCxqgYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389556AbfJDPCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:02:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42881 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389156AbfJDPCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:02:12 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so14150729iod.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JAJK2XALN+YQwkDwAo9tKgPVnZvZxR3QQ1xm5Fa4nJY=;
        b=taCxqgYvoikHMGYuCXwSDyuETahZJkG/d4G01fEKzViiNXjye3GaE1ndgHk3RWbcdZ
         +ZlJud9e7tTdNFLDzevrVVJ+Llc2eOlcom9vAkGDvoRbamhHADiiIev2nWuCba64mEqN
         ip20KvMIGEs33X+FCWT5S5NFLM1dO2ndNrzwB9LrYZX3bMPJynEvjjrcZOy6FxZEz7B7
         SsQHjPWeaejRURlcaaCuZDpgEnQmaMYzRnI9/8PAO3KUzZ/wf0gH61RVmBEGQ/z8TbOc
         qjwj9J2T7etCS+TcPEudv/8qkOHE2k5EuwvdrgBAQwyHqjcg7bhWcRb8R+wWSpH7B7Lw
         HS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=JAJK2XALN+YQwkDwAo9tKgPVnZvZxR3QQ1xm5Fa4nJY=;
        b=f+2maX49Uuta4yqIK8H73FKuZorDBVM+uh0XEaHdj7Df2mRhWDmaFPS7AJaN0bFKX3
         H3DTh7s9Ddu45ngPiZCykFSl9aa+2+kammqdhYrAREdYfsCV63pBMfMfhdCy1bwXEuo6
         zhzoNZ5iwkbQEI/iBlfXOX/OJVT3jfwLCw1maAZdg9ZHqz4tJfJ7T4JgqmzKyouhvrcF
         yy2thdSihJtb4K2XsyScQ39a89gpKLt6pyszQZ7u1B5skCNuW4hZrmldVu5NbHhvvzmr
         zn+Qnldl5APXAc+LnfpcQNdfeEY+/n0ddYe3rhWviCTPICru1tjcF66caVh9xbmZCgFR
         wAfw==
X-Gm-Message-State: APjAAAVCFgIRKwD84rR/sXjhuegfLpjtwJWtMjHYQCVhvp0KpU9dRSSD
        UBvGcXq7LGq5CsTYQl0isI9eXQ==
X-Google-Smtp-Source: APXvYqw3bIOr+Hpti+aQtA50fHOghoDG7Gg4+0cua7kIpn5iEIKjZEA8XjzitBd6WC6ke3JWxF/w9g==
X-Received: by 2002:a92:d14b:: with SMTP id t11mr15285576ilg.126.1570201330394;
        Fri, 04 Oct 2019 08:02:10 -0700 (PDT)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id b24sm2060348iob.2.2019.10.04.08.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 08:02:03 -0700 (PDT)
Date:   Fri, 4 Oct 2019 10:02:02 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.4 00/99] 4.4.195-stable review
Message-ID: <20191004150202.bulscl2nj7ky5vlf@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20191003154252.297991283@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191003154252.297991283@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 05:52:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.195 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 05 Oct 2019 03:37:47 PM UTC.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.195-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.4.y
git commit: 9a8d8139a7e557ce81c19f467a2a873371e3deba
git describe: v4.4.194-100-g9a8d8139a7e5
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.194-100-g9a8d8139a7e5

No regressions (compared to build v4.4.194)

No fixes (compared to build v4.4.194)

Ran 18728 total tests in the following environments and test suites.

Environments
--------------
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* network-basic-tests
* perf
* prep-tmp-disk
* spectre-meltdown-checker-test
* kvm-unit-tests
* v4l2-compliance
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

Summary
------------------------------------------------------------------------

kernel: 4.4.195-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.195-rc1-hikey-20191003-572
git commit: 3f7eeb94b05eb384e0c0cee76d6446f60aba646f
git describe: 4.4.195-rc1-hikey-20191003-572
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4-oe/build/4.4.195-rc1-hikey-20191003-572

No regressions (compared to build 4.4.195-rc1-hikey-20191001-571)

No fixes (compared to build 4.4.195-rc1-hikey-20191001-571)

Ran 1523 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

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
* ltp-timers-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance

-- 
Linaro LKFT
https://lkft.linaro.org
