Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DF5C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC94206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BysVrUrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390974AbfIER2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 13:28:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41411 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732114AbfIER2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:28:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id o101so2986253ota.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 10:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rvxhz/yZn3Q6gffoeTZfDbAQbCY2o417WdMfyCdYfwE=;
        b=BysVrUrxN2Ic2U/5iDjXNWtThXsAm6YEkR2Jl85TAdYbz+BzkSonVuazaTqYhIrlEX
         K8yseMGhiLWjxVZn6synTJjWQqjlJ8siPG8OnOtPp1H9Y16tDO8l7T+JyvvV5TFhTXET
         p+uquYvdPHcI4+tIs9fiZ3AOwYiEDEy8Hee22YgjWdf4HYhXsMqZ1noANRVvfynYUmjN
         l3hXIO2G9iMytdrvOsh0dFghpIT9Bk6WJYxD98P88ihP0ucKPEgzdlRiOo3U2L2/N00Z
         4E46gGd5ZKHN0zqH+TvyWzWHvCKtL25vM5aGtmiGuSzG5OAn0Ge8KlkWZcRQJGez8rjQ
         qd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rvxhz/yZn3Q6gffoeTZfDbAQbCY2o417WdMfyCdYfwE=;
        b=HB6pZi39ql/RoGtGVfl31lufpt7n+8QNOs7BYtrAUdo3WDfIo2PV+oCOMYT4i82NMa
         q/+N6mabfI88SDUHPOyuIuBgH6Hi88SVheG07xFHl5ENsclqgKyUUJAmSOXCp17wrlXo
         2NOjoJ8REzLGwROGPGhU/K6V5Tyr1m4gxrsJdtPOR1TTG0Tvu1srcBzEFWqiLdrC1Y5/
         0/7JLMFTs5dCOeY4Q5sezAAQYC/uSuSksb3gbh468bXKOM8WY7XtXu6CuxK9tLAbjCpT
         7E8qSMzBTZFTTnan5qDduveJKbKG9hp537nDNCWzgXrSHk/OnCeeM+cTbGCxgpwpUeWX
         IwHw==
X-Gm-Message-State: APjAAAXqw+h5BHoOLu9EYh+5serogaUdlHexKLY70W4GJff0USTHfp6i
        xrCL8Mqw3xiYZRfWGg0xK3cjHg==
X-Google-Smtp-Source: APXvYqz/91EHGft9Fe79Ic7vI/myhTxvO9F1v+a1xayigzLWg0brqIfhJDtZ1RtiCXcsw3NfkODt6A==
X-Received: by 2002:a9d:2af:: with SMTP id 44mr3726300otl.130.1567704528092;
        Thu, 05 Sep 2019 10:28:48 -0700 (PDT)
Received: from [192.168.17.59] (CableLink-189-218-29-211.Hosts.InterCable.net. [189.218.29.211])
        by smtp.gmail.com with ESMTPSA id o1sm663677oic.50.2019.09.05.10.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 10:28:47 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/93] 4.19.70-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190904175302.845828956@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Message-ID: <d91fb6fc-df04-0dd5-4e15-a951eeee7fc5@linaro.org>
Date:   Thu, 5 Sep 2019 12:28:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 9/4/19 12:53 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.70 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 06 Sep 2019 05:50:23 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.70-rc1.gz
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

kernel: 4.19.70-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.19.y
git commit: b755ab5041366b954c39bd97caa982539e0d1223
git describe: v4.19.69-94-gb755ab504136
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.69-94-gb755ab504136


No regressions (compared to build v4.19.69)

No fixes (compared to build v4.19.69)

Ran 25004 total tests in the following environments and test suites.

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
* spectre-meltdown-checker-test
* ltp-fs-tests
* network-basic-tests
* perf
* v4l2-compliance
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
