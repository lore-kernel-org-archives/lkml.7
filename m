Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B9AC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A4B207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0LGMOO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389686AbfJDPMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:12:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45001 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389086AbfJDPMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:12:31 -0400
Received: by mail-io1-f66.google.com with SMTP id w12so14202212iol.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 08:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cWRdLiwQJAJJAJeYx45YFgevjCqiCyRsVMde8/zsJ6A=;
        b=f0LGMOO+QGwV68JTQXruh+AqnwraIvphJ9rXbYuICywU3+WNjjBoC5yX90kY20UaPG
         oorPZEkmRyvxkFAIJVNimLUYleYdudogrG58Vz0F1YYs94ESlt4sD/JkVZRfJxZHaenT
         NRo2seZ06B71stP4w2Tk9nLWSOCbJ0ymeQ9TdDMGU9En/VrkRmrgL/E9P5gd58qGb5dN
         N4gLewWqvEji28X4e78L7waSh5spQL6DGGDA+lVJAzy/74nCl0K3F/nU/729hPgX+QBH
         WxbHVGsf6mI/0G2+jeJE5JDN01gVUGzDFFf+EB3oTlgLGZjcgE9bWSjcKaE4lnhy8UWe
         80Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cWRdLiwQJAJJAJeYx45YFgevjCqiCyRsVMde8/zsJ6A=;
        b=l5tk5El+x9zGDxG+Jaff79Y1VE93Mp1ils5sedx8u3Un4DLY2GR8T2TFecu19DYASa
         IekCTNZthcGgxxgAe9EOgrNaKxzjtjTir0JWG8ZPf8mpd//LI1rihTCndjBmCJZtM2Wt
         H5j2Bl9BXwDneTztPJxgU/ySHqiQLwj+iAk7NHTncqlsQ4qmJRddJ9JssEASiPmwBAab
         SZGukS66ci8O1n8UuGxdEUkB5syrUbxBMaT0LvQS6PzES/8meXJfyC6aWDKCc1yRHuZM
         6+KKjONVfCRYzm+M3t5EGFjLyuCsv4HhcKUYexEm9P/lxPlOIj2rolmSXflZ9unelYft
         YZ8A==
X-Gm-Message-State: APjAAAV4tfHM5epR+BbkaWd2W+O3jCpn8xjhSC+xVg44D7W/QNYCmWhR
        aNBNHzWN9/9/cOwIDNNQCTRUcg==
X-Google-Smtp-Source: APXvYqxqIXCzfNNEjTBNMu5NySqCyk/eRVksf1vOt8+a3Fv6hjdsOkifkyV9BcOCqt/nTTJdnhh7FQ==
X-Received: by 2002:a5e:df04:: with SMTP id f4mr13760675ioq.192.1570201950070;
        Fri, 04 Oct 2019 08:12:30 -0700 (PDT)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id l82sm4099655ilh.23.2019.10.04.08.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 08:12:29 -0700 (PDT)
Date:   Fri, 4 Oct 2019 10:12:28 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/211] 4.19.77-stable review
Message-ID: <20191004151228.25fe3upo5jncvyme@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20191003154447.010950442@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 05:51:06PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.77 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 05 Oct 2019 03:37:47 PM UTC.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.77-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.19.y
git commit: 319532606385c7221dfbfba6f857bd03e97e20d0
git describe: v4.19.76-212-g319532606385
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.76-212-g319532606385

No regressions (compared to build v4.19.76)

No fixes (compared to build v4.19.76)

Ran 22570 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* network-basic-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
