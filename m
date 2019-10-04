Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9A0C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405AD215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CtKslxz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbfJDRvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:51:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36450 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbfJDRvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:51:14 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so15390533iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=t/5LvydB/9xiYrPTtx28So261ri5H7GhB96fZQX0xSk=;
        b=CtKslxz+C1oTEwWYf8uaYwhkIa5v8rvZ02D7hyyUcjyXHtPIlWOKrhtLnWCAnXLW6p
         xMgbQ7BuDmxwmI1VuxYZ6fOSpBEu/OyyzUsn61IyXoi5IhkJW1A1U/XekU8wh+vy2ujD
         QZe7xO8Els0gXy9OgjAaM4nvK5+pBbXa5go5Mvs5r/tt+yq3mYydfrAt4TiXBBU8YCS9
         879BKhob1bfdE7P5ojctaKythp4z15olVqJ98ukULzrpWQ3sySlIzBA9AcMjKgYIQ1RV
         egMlneWX+BEPm2BBesTwGrZrBr3ttzXg1AXVrFwhs5iQIJD4ExwzCp0qU+PGZn6ROrjI
         LZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=t/5LvydB/9xiYrPTtx28So261ri5H7GhB96fZQX0xSk=;
        b=K3VD4DxnaY2w3AfNbpmecbkxdvadxmOU8B2ZKN4oBo2ZwuGQaTs4zM/SnVlSwbJTsS
         /+18LjjW8OW308GWgTCMkUhOjwfDVBe9PC9xHP0R6JyMPJpmN3RfKOG/FiW3+ZT2YnUP
         DFxKuANIgiauDmXgzKTYSNAC7ktyIcqQ53zEr2vBAFsQ1O8sG9dawXIrwjKLDBI5gYPO
         OEhhCSf2gd7G7pVsk/Hbqf5FOQUVJm2AIqFuDbrCcbClVBQ7PoB6J4F5UZ6vd4Tsjzdw
         4TOX/4lpFK/eDNFsIpVNgTiXx4HDNdQEKobHj8SI+NGydOkSPR1wo2RipEJV7IIi12vj
         F/AA==
X-Gm-Message-State: APjAAAXT4L51MRsej6OXUNm39ufzPkszq2buHKd/sFEt/arElb/fH4px
        CmU+75dbBw4fy8I80UxvZrUboA==
X-Google-Smtp-Source: APXvYqyBk0lISp4cVtDmgk4GMmqtcC6j5ZroXBpltvKkivQQq5TrNSZDPwBACfs5ApOdmGvk+qw4Cw==
X-Received: by 2002:a92:844b:: with SMTP id l72mr1137706ild.275.1570211473074;
        Fri, 04 Oct 2019 10:51:13 -0700 (PDT)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id b11sm3041379ilr.87.2019.10.04.10.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 10:51:11 -0700 (PDT)
Date:   Fri, 4 Oct 2019 12:51:11 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.14 000/185] 4.14.147-stable review
Message-ID: <20191004175111.434wgtyscv647mql@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20191003154437.541662648@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 05:51:18PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.147 release.
> There are 185 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 05 Oct 2019 03:37:47 PM UTC.
> Anything received after that time might be too late.

There's a regression listed below that happened while running 'modprobe
vivid' on db410c. We've investigated it and are unable to reliably
reproduce it. It happens less than 1% of the time, so it is very
unlikely to be a regression. The detailed log can be found at
https://lkft.validation.linaro.org/scheduler/job/950199#L1545 and we
will continue to investigate and try to narrow down the problem so that
we can report it coherently.


Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.147-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: b99061374089a66c2dd55bbea3299a602a4f0891
git describe: v4.14.146-186-gb99061374089
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.146-186-gb99061374089

Regressions (compared to build v4.14.146-18-gf0e4f7af6713)
------------------------------------------------------------------------

dragonboard-410c - arm64:
  v4l2-compliance:
    * modprobe-vivid

No fixes (compared to build v4.14.146-18-gf0e4f7af6713)

Ran 22696 total tests in the following environments and test suites.

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
* ltp-timers-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-fs-tests
* ltp-syscalls-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

-- 
Linaro LKFT
https://lkft.linaro.org
