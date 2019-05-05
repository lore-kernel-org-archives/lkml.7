Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B103C04AAA
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 03:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B44A206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 03:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZH5WKxUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfEEDAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 23:00:47 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52411 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfEEDAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 23:00:47 -0400
Received: by mail-it1-f194.google.com with SMTP id q65so13887458itg.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 20:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G4iZWqtZZ7jaci6ZyuRTiU8FosRtJL9T3C24CbNPhlY=;
        b=ZH5WKxUQjYoswCUP0rGzjMRNhjJaoSeXvrVs0vo9HEU34HqZqS+Lzm/Ij2O8R/hat4
         Bh95fMA385Ifimnjvzf0511kh7Az/NSce8NuLGd4c9NRjMvgDhpWfLkEz350lHWs8Kku
         ymf5+Rw/Oj8S5IZ8+C13H+MrICUkIrHpL+sGcuotUWj8fDxa2ztL/7/zmvgco7jo14td
         TGREzpCodtgMkq0CeiWYxQoxIYh5i9lrQmf3xIBbvx5k1Bj8L23yw2+iw0QusKz1jQ4k
         SFYdqMuC95PVO5lRe5v6QqAMla3kQATpF6c8+x6iOsAArT2JJ3pk/osTqZlPClBDlrqg
         WRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=G4iZWqtZZ7jaci6ZyuRTiU8FosRtJL9T3C24CbNPhlY=;
        b=MyHOdF9vORLWl1+kuenCx3P4PtXBm49ldVjSYxhUiI/FEcO6jllwWRaUoIu1tu7S9n
         TBkE5ay544Bl/6QHDTVIigJJ15EnOIfHVZuMf+4h1yFQbXgudf8WxGWs3O5Yf7lopVkA
         k3C8h3FWz54JWi0HVDD9baXfMD7iOHZ3ajKJfiQ/7YqCXOjeLkFgokt5PLKmg8ZA3zvo
         jPr1SMK1bc9mFMDTm2ImOF6jPGGje2/QVVvXDBkt4QfPy7tR395A0UVmPD8dre6ugu68
         /ne3ZISZTlUa5E806DBjDFN6bgmSW36VpyUXwAseOqKVGhlcytFs5RjHRK3xtxnfR264
         D6QQ==
X-Gm-Message-State: APjAAAWrRVSce2j33dL1Vbhx2FjKjyWEcJ6iny8g+FGhZuj3xVeW9n+b
        RNLII0uVysoeWSApF35zCBu1BA==
X-Google-Smtp-Source: APXvYqyYWCy5AxS36kOFSkhDGuEAf4IuOHM4EqWDiGEliobQ3oKdmwmlZDfQJe2XK2uJh4P+E48sRg==
X-Received: by 2002:a02:950a:: with SMTP id y10mr14019876jah.26.1557025246360;
        Sat, 04 May 2019 20:00:46 -0700 (PDT)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id x74sm3291803itb.33.2019.05.04.20.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 May 2019 20:00:45 -0700 (PDT)
Date:   Sat, 4 May 2019 22:00:44 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/23] 4.19.40-stable review
Message-ID: <20190505030044.q3dlgd5bhfx5txmf@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20190504102451.512405835@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190504102451.512405835@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2019 at 12:25:02PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.40 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon 06 May 2019 10:24:19 AM UTC.
> Anything received after that time might be too late.


Results from Linaro’s test farm.
Regressions detected.

Summary
------------------------------------------------------------------------

kernel: 4.19.40-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.19.y
git commit: b0d6421bd85515e878edcf33121a818666df7749
git describe: v4.19.39-24-gb0d6421bd855
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.39-24-gb0d6421bd855

No regressions (compared to build v4.19.38-73-gdb2d00a74567)

No fixes (compared to build v4.19.38-73-gdb2d00a74567)

Ran 25058 total tests in the following environments and test suites.

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
* kvm-unit-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
