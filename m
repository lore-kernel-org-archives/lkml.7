Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C9AC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE796208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUQkz0RV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfFZSl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:41:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36559 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZSl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:41:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id r6so3594490oti.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 11:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yIpLLMiOCfG2MiFukhq5qX52A4+hCLbECODORKcuk7A=;
        b=YUQkz0RVu0HkZ6Sdo4KpFKDYXa3n+4TLgqd+n4oJRUDSqdZhbSMSzFJGIaK7ETngyq
         EBxSW0T0Y9I184Abr7wuTdBEjCjyzyQtilpk9goYmb0fqW1/HHiWbLuViEGRoEpv1xpu
         1D3l+py00dKGwWW6CABpUpdEw3AgPhcPVezifBRhfxZR4b69Nq6S01J8H+VaeUcOTMgJ
         je4K98JwVeFF7eAs6id4+u9nZolsrCNL+P0guFNyQTXkKoZzX61jK4NHORSTUVhHVxHn
         6LH95CtLIBPMCZNXxA53DAvmadwpqBJBKSscJejsfhgoSfnJGzccEbbG+elaNsXt2hQQ
         oogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yIpLLMiOCfG2MiFukhq5qX52A4+hCLbECODORKcuk7A=;
        b=c3l3z6lSzmkUvwP9Gn1RamtKodx5W8gCZqNe3edKIGoDrTp5ywBZHWnIMczFs2m/mS
         YDb0+zJe7y2nrVb8fvMKB2PfPEpae/FC0oyqPRF4JxsnyOUFyjR02Q0ScRmykQTGm0/8
         Rc/DI8uN4dIuh/58E7sjdyCLd/3XUIs4UCg0P9ErBiQTWQ3IM8qKjHewUPLwwzw7W897
         qRwa/BHPDr3Pcc/d5v9RXjQSU6gvNP96rYetwa4R5954V3wzjI6FQPnb+7vJopTTKr/0
         Z0zzv/cxPiRICZLqY/lMEVtYKyaywslV0FyDhptJ2d6iFgaH5E/Pn2PSp9NnprWUHJAZ
         fzGw==
X-Gm-Message-State: APjAAAUNrE+Uf2e/bw/LXckjMWu2dz6E1HEy6hmuP6VEKBWyGB5sd4N/
        fwrm1rGBaSWh33uZDtsc5e+w6w==
X-Google-Smtp-Source: APXvYqzG5Y9S36q7hdj8Bcc+nz/t90AEMgPUWC6Ktii7hopDkbO4G0qV0aTvRPrqV2OGX0Y6lc1zQA==
X-Received: by 2002:a9d:6746:: with SMTP id w6mr4591948otm.222.1561574487525;
        Wed, 26 Jun 2019 11:41:27 -0700 (PDT)
Received: from [192.168.17.59] (CableLink-189-218-29-147.Hosts.InterCable.net. [189.218.29.147])
        by smtp.gmail.com with ESMTPSA id v203sm7565968oie.5.2019.06.26.11.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 11:41:26 -0700 (PDT)
Subject: Re: [PATCH 4.4 0/1] 4.4.184-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190626083604.894288021@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Message-ID: <c59e14e9-f44e-1c70-2484-a58fdc3dc0d1@linaro.org>
Date:   Wed, 26 Jun 2019 13:41:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190626083604.894288021@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 6/26/19 3:45 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.184 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 28 Jun 2019 08:35:42 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.184-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.184-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.4.y
git commit: 5f1824292521531d662f05e2e24275767d18c0c4
git describe: v4.4.183-2-g5f1824292521
Test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.183-2-g5f1824292521


No regressions (compared to build v4.4.183)

No fixes (compared to build v4.4.183)


Ran 20117 total tests in the following environments and test suites.

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
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* prep-tmp-disk

Summary
------------------------------------------------------------------------

kernel: 4.4.184-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.184-rc1-hikey-20190626-477
git commit: de92183312a3d85ab8b3516096a61210a4e9f458
git describe: 4.4.184-rc1-hikey-20190626-477
Test details:
https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4-oe/build/4.4.184-rc1-hikey-20190626-477


No regressions (compared to build 4.4.184-rc1-hikey-20190624-475)


No fixes (compared to build 4.4.184-rc1-hikey-20190624-475)

Ran 1549 total tests in the following environments and test suites.

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


Greetings!

Daniel Díaz
daniel.diaz@linaro.org

-- 
Linaro LKFT
https://lkft.linaro.org
