Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EE7C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCA12070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQ5wYg1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKVXuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:50:40 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43554 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfKVXuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:50:40 -0500
Received: by mail-ot1-f66.google.com with SMTP id l14so7679291oti.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 15:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ALhOX9bvLAcdp/C539wZRqIa+oQXGsCsKzdUYMuKILI=;
        b=UQ5wYg1hpxc+H4BgqUuu1YMWaG0R6gPgB9Z4+TWQs+mTOpQl1v6nuESdqQ8JSLD3s2
         yRHBxfyvpqkimj+4aghZICM4E/h9p8vqL538+amf/HiZDYXPzfng5JgfdtQvC1kT5Tqt
         tr63T0IQPFuE/tVYt+CG0vtXc9jeAA79XyhV/Jo0/VmgnyHuHDZ8gjRr75q2zC8WodX6
         5R3eL5cyA93T9yLHffcvZe4kH9B/lgzF9H+brW445Afw+gNuGHmToBVmCjkwpTbxUhSv
         Va/HtLnGnoBNerxJAi/ppKrQYSiLNk0Xj0hP5nw44hkgKjtou6/B5E+bWpe1ncWvRnpf
         gAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ALhOX9bvLAcdp/C539wZRqIa+oQXGsCsKzdUYMuKILI=;
        b=s1SAyDxck6yg4ESB3qb2Ialh/tcMqGd/gl65Zr24ih+f2mqUwubDLcoZbpPp7J2yX5
         pKbT/I2hHqYASdbkVu4i1WZKCkPiJp8l+dXut7ANkp5Zqu3rIn9HMpAVL7aIujgGYpRT
         zEFw6aTI1Yg2uNJb+MASH4uj/Qk7BqnHd8n10QKqQcWXogYyDtLTcFPPX0/EgcMsl0wg
         laQ/YeFRSV/dYJfClDGn4Jx5DoYQF1gDcbqHna1Lmaw1haQEjIsv9xzxPE+lJhNs/uMA
         CVWcIh2VJN1EmIJKRPCsl8Ms62Na/zfZsvt0GWxFrLXKFwt/rOm0qlKPBR78XJ73xwpb
         e/pw==
X-Gm-Message-State: APjAAAXjizO8rpbl7Ywaf/qH8yJQzPJzSOhHnBYClC3E11+gQ/2kLYaI
        K6NyDGQ16PcKZz2anZUKQVu4nA==
X-Google-Smtp-Source: APXvYqza1rzxT15BvQrbn02TtGuD2AOKH7JtOLQ6HhFxtSVImsHNodVkn+5+aIz/0PPY5R696IZQjQ==
X-Received: by 2002:a05:6830:8b:: with SMTP id a11mr13272232oto.244.1574466637958;
        Fri, 22 Nov 2019 15:50:37 -0800 (PST)
Received: from [192.168.17.59] (CableLink-189-218-29-211.Hosts.InterCable.net. [189.218.29.211])
        by smtp.gmail.com with ESMTPSA id l20sm2537792oii.26.2019.11.22.15.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 15:50:37 -0800 (PST)
Subject: Re: [PATCH 4.19 000/220] 4.19.86-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20191122100912.732983531@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Message-ID: <9478f941-a840-7aa7-8ea5-b1570e3bccd2@linaro.org>
Date:   Fri, 22 Nov 2019 17:50:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11/22/19 4:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.86 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 24 Nov 2019 09:59:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.86-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.86-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.19.y
git commit: 2582c18680a83bdf438bc174d58fcb026bf366d8
git describe: v4.19.85-221-g2582c18680a8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.85-221-g2582c18680a8


No regressions (compared to build v4.19.85)

No fixes (compared to build v4.19.85)

Ran 24294 total tests in the following environments and test suites.

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
* linux-log-parser
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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
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
