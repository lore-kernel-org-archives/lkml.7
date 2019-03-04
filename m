Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44AEC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E46720663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ScEgJ3ej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfCDTJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:09:47 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35912 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCDTJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:09:47 -0500
Received: by mail-lj1-f194.google.com with SMTP id v10so5311994lji.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 11:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qZFaEdY13RHUg8EmQJTJ9ahjSDsHelgXoC/UPR8bB3c=;
        b=ScEgJ3ejyHyKUKbvemMdo3h46MQn2d4AwZOzBWMSqiRmJt7LdMAg+g5e58nXRT3joZ
         AvDHfUJnqIJJXq8a9nLpzP6WXz195/r83FBGmKn2qSKb/ktpkmK2AtnuaJzMMWnCpell
         iRtRtycFwlRNJjYi3mDkI7xedhSyB6ENug8nwP6zPTwHeGaQ5Hhm07fXpZnjchadTRod
         vfMvK8cj5wtv0VUQ5bzvKyDwhawJl3pO2nsVuHfiNladmFij5oXy6dObNTOXw5y8fbYr
         PAj7Z8Ym+CP1vWYwG9tcFrVxjj4Phijyp1P6tXsVh1dpQSDFBgUg6LsK5tiGZuvaAD65
         NDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qZFaEdY13RHUg8EmQJTJ9ahjSDsHelgXoC/UPR8bB3c=;
        b=VGmDuxKu3dWHGN/NcC/X59vLA4oew1lUqWV/9WKWUNrh1zkZZYyT9zDCavJnTqv8s1
         JtvkCS6/OaKDIMrny42gjchdOyonC53RctLYNfq5z7IJwwIR88Awxs38f5fVa6ubQQ7a
         l+YS8k8WS83iEx9P5n6l0YKaPzYSF5QeABiPAIH68KhYCIFCiapJSU0OvCZ9v8Ik/poP
         Y0ynR2XxwkJW+tgPmvSPYYCJX0wtgOvVI3QgkTE+M1fBwHriz2HzEqDoZM4XJ3pqbrqs
         GAOY9w9cwegrWO6s2Q/+7SM0d71RdsjfQmjDl9xLGwcJnGOXaqEAPO7hrQ5/KzrNjtdL
         Z/HA==
X-Gm-Message-State: APjAAAWocictCoR9g+2JsUpMgGKnEgD3n0KvAvHVdbOw4HIPepc+dJdB
        r8D5+7GsM9/VDCgV83tGPRw2AFU95bDkKmk1SLqTQQ==
X-Google-Smtp-Source: APXvYqzWi71tG8Lo0doidHC0hcxOiiECCSMXBobuWMELcqJ4eaOGlBqdskW1t0q69QpCzw4Ja4l/8COTVAdNV+Zm3wI=
X-Received: by 2002:a2e:312:: with SMTP id 18mr12398761ljd.114.1551726584901;
 Mon, 04 Mar 2019 11:09:44 -0800 (PST)
MIME-Version: 1.0
References: <20190304081625.508788074@linuxfoundation.org>
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Mar 2019 00:39:33 +0530
Message-ID: <CA+G9fYuy7nF+_DnU-Ea+cRZmerarF0hRpKKWfef6o34rqXfGmQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/78] 4.19.27-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2019 at 13:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.27 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar  6 08:16:00 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.27-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.27-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: eac8c143089a600e29ec1a328945cd39e5e83cb1
git describe: v4.19.26-79-geac8c143089a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.26-79-geac8c143089a


No regressions (compared to build v4.19.26)

No fixes (compared to build v4.19.26)


Ran 21762 total tests in the following environments and test suites.

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
* boot
* install-android-platform-tools-r2600
* kselftest
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
* ltp-dio-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
