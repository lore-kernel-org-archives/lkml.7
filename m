Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB149C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33A32071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SQ27AJZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfKVXuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:50:08 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43528 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfKVXuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:50:08 -0500
Received: by mail-ot1-f68.google.com with SMTP id l14so7678551oti.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 15:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t57slOuWwliy5KRFy4MHilj06UwBXFBw1JnSZThbwak=;
        b=SQ27AJZA0dBzR7SLv5npKwSrM/Yo13QQCamlQa+DyBw4taXqRcGha/YqnL9jfe9c5K
         YsMBIr2VdEi+NNvbHZpi5SOtNQBbIbD1V/XK4rZ0xbMmzfSg9kEVwPh6CTM/ynHSNfRQ
         8I7hwWxznPV0rN9hatPsycbjVQli/Qo51OTGjAp0851ZxYLthWQN+AnNcfarzJscxAHn
         tpiZ9KJYNAxxrRjzsnLbaT1KcLlKippnrzJgrCAeL//Fn25yVRGBv+uZT2b2vfOPudov
         NemkGmNC6dO2oL3lndbbywp+DC4QZR210K6FdBu35UmV56jIXTXBjolaprKKvbTc0smG
         v0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t57slOuWwliy5KRFy4MHilj06UwBXFBw1JnSZThbwak=;
        b=HfK+8hC8C07ivIOcNgLDfL4Z65/Sb+EHFTTZb9tuwWAQaso+jaliDjV+RptCkIrMrs
         eT6tpm9K8nJ4wuqQ+rczgvvkEGj5cJCafn2DrG2HxD3XadcHG8dydCfqrZyqcW4/m2v5
         URK4TYf+iJ0uE5W174u2MO7zmw1XOQ4ZzlHP6HqRqaFmj0rPcx/VZsTbpeoHd83RQD3F
         sIL42vnA2NLxgsustFwO8qO9xlZq98QiMinmlMQPLeMYfLlZ25vi/iujvKogsXg3iZyL
         JgPZgoWNI1kH6Web3NChW1K4wukC2ST4N+l+JmftfdCYtYfFYvn1vLTLBjcPSPT2fOKP
         cR3g==
X-Gm-Message-State: APjAAAX+K7oeaiEZem0kQNy/fgRJfffpe/Laz4uAUQ5CjOlY1nMhN7Ky
        Ye1ByQTp83dlF7AkdUtifvuJXw==
X-Google-Smtp-Source: APXvYqwgNdTHZbdXEp7O5/QHtBZBfhqBa6CHQs2leQEMKGnwJCZYpJbLB7obLx5C4hPtOGXdgYomxQ==
X-Received: by 2002:a9d:6144:: with SMTP id c4mr12368918otk.53.1574466607035;
        Fri, 22 Nov 2019 15:50:07 -0800 (PST)
Received: from [192.168.17.59] (CableLink-189-218-29-211.Hosts.InterCable.net. [189.218.29.211])
        by smtp.gmail.com with ESMTPSA id h39sm2781332oth.9.2019.11.22.15.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 15:50:06 -0800 (PST)
Subject: Re: [PATCH 4.9 000/222] 4.9.203-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20191122100830.874290814@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Message-ID: <d8954989-12a5-9b81-48bc-941b5df768c5@linaro.org>
Date:   Fri, 22 Nov 2019 17:50:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11/22/19 4:25 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.203 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 24 Nov 2019 09:59:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.203-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.203-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: c2ff777d9ae88f46236e8fdb9654a87b0468b28b
git describe: v4.9.202-223-gc2ff777d9ae8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.202-223-gc2ff777d9ae8


No regressions (compared to build v4.9.202)

No fixes (compared to build v4.9.202)

Ran 23946 total tests in the following environments and test suites.

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
* prep-tmp-disk
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite


Greetings!

Daniel Díaz
daniel.diaz@linaro.org


-- 
Linaro LKFT
https://lkft.linaro.org
