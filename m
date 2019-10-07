Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADFEECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568C620684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjeOuYoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfJGQRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:17:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37818 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfJGQRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:17:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id k32so11465762otc.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 09:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5NNDRGuw4E8tRqLZeKUWfA9igqLooVyNgv87qkHao28=;
        b=EjeOuYoSqmZwiYeNfUd2qY/pS0xWLxanV0/rTSFD1mRhKgPNxPmwontZA2gaD2cN88
         jbtL4AWa8HdsQHt0OLz/hQIqbmQsq1fCWB27fP2lTtVbjU6EMt5CQd/OqlRjpv0TNUHn
         19qoA67i7mf4UozSL3EMiiemI1eDXmkgU7o9uBTHL1n9Uu6gkFTEPbnbqLfFU5vKyqgb
         ftHbM6fTFkZBLt7m61JMTLfjoWD5qU6muyBrlVcU147g1SXkh6y9WXhWWf65buqhizDx
         kBtuy6m9QKgEWbr1hepQku5VcMPAlLKoynYzCS0AxsPw+rJNW49eNs5jAuWym5Bx95iM
         vaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5NNDRGuw4E8tRqLZeKUWfA9igqLooVyNgv87qkHao28=;
        b=qWFKHvOeaNPuo0RwiTifMVqU4mmavbdh9Ov43bBKKlMJVIKNFX6CfYl/nImygHHl+N
         1YEcZU5X11vifgbmyfAFj13SYFsxL8/1UhZg0fK2wJAxYMtki5FU/5U21OMfBtxw246N
         KSikkJUxWr9yQVPPqq8R2KlhSI03/UREUUyH7FQObGo3hDcz3lhrvsFgqhc/stkrtFdo
         Uv5kM+yljoUq5xSTStho3rJBmJpgn1RhXYb5vBKhExj5lfVMO9jaRCkBLZ6RM3IyQW5x
         FwVIIswrC7C4958WKGnS8o1/Q93pK752TDCEOOmV4XUoE+icSP/KMiWyqWkH4ytctWmW
         DqRw==
X-Gm-Message-State: APjAAAUUBUMM2O+k7Luw9y/UAbdg/igToLyuaQEVG84cwRPOtoE0f9KC
        0IcAtNA8F84yh5xK08wKVdsDCw==
X-Google-Smtp-Source: APXvYqwcVDFwBD5fp/rl02Ofcf0tHjvUnX6Lz7ZmFDDl3APADQwmgA0AJImMmk/i2iaBzEhwJ4vB/w==
X-Received: by 2002:a05:6830:17c1:: with SMTP id p1mr22329586ota.188.1570465035651;
        Mon, 07 Oct 2019 09:17:15 -0700 (PDT)
Received: from [192.168.17.59] (CableLink-189-218-29-211.Hosts.InterCable.net. [189.218.29.211])
        by smtp.gmail.com with ESMTPSA id b4sm4336346oiy.30.2019.10.07.09.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 09:17:14 -0700 (PDT)
Subject: Re: [PATCH 4.19 000/106] 4.19.78-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20191006171124.641144086@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Message-ID: <79dfbd7b-ca99-b286-04d3-dec24d5eb73a@linaro.org>
Date:   Mon, 7 Oct 2019 11:17:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191006171124.641144086@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


On 10/6/19 12:20 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.78 release.
> There are 106 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue 08 Oct 2019 05:07:10 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.78-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Patch "udp: only do GSO if # of segs > 1" updated net/ipv[46]/udp.c and the kselftest that goes with it. The system detected a failure in net/udpgso.sh this time as we are running kselftests 5.3.1, which currently includes a now-outdated version of this test. As soon as 5.3.5 is released, we'll upgrade kselftests and this test will pass again.

Because there's no regression (i.e. it passes with the updated test), there is nothing to worry about here. The same can be said of the 5.2 and 5.3 release candidates.


Summary
------------------------------------------------------------------------

kernel: 4.19.78-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.19.y
git commit: 61e72e79b84d3a2519ad88c10964d7e4fa11ef1d
git describe: v4.19.77-107-g61e72e79b84d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.77-107-g61e72e79b84d

No regressions (compared to build v4.19.77)

No fixes (compared to build v4.19.77)

Ran 21962 total tests in the following environments and test suites.

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
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none


Greetings!

Daniel Díaz
daniel.diaz@linaro.org


-- 
Linaro LKFT
https://lkft.linaro.org
