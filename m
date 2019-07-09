Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE04C606D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C7E21707
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivQT/HrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfGIGFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:05:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33984 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGIGFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:05:23 -0400
Received: by mail-lf1-f66.google.com with SMTP id b29so12575656lfq.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 23:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5p/Ypntm+UKqFnZMbiWidCBnXiU+3vJU5d81wWVv+bI=;
        b=ivQT/HrUvAob1nEkK1cbp3u0Bdhsca8ZMDadJnOyv/EHiNYfIeuLrCVt8uija0bybg
         QKb5gVIKX4olx0PECE+dv0rt1a4u8FF5UWucwqmFUf+gwQo+sVJBxnj3pZ1d755AteVw
         of2Zo6Y9zsjfc+wSu9EJZWU5nWxHfkP9h8pEKiYWWzgHvNxkFmKjOjIokeXLNLd/sQld
         3a6XD5a4KxY0nDHDEJuoGC4XGQtZ6oTlKVSxiEfp+LP0C3KhJzJe0CjSxlYUR09G0N1Y
         b5AmajujjJgg7TV3AkfpMeZKVz97djJUg2aeeh5aXGnpKQ8c7Thn2yb4MaMErEkXPPDP
         YMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5p/Ypntm+UKqFnZMbiWidCBnXiU+3vJU5d81wWVv+bI=;
        b=VzFf2Kz1I3qa36K6U7aJWXrYyTlNzrmhiCHkgfsV/386MlY3y5IJOH1LI1aV1WEsKc
         ApEV8J3ENpwok5rtCuWOhECTZvFbWTTQ57+JvakQmrdmUEZk9YVHdH3YGJDvkh3w65TD
         jVgWo/OMu/63l9vS8VaBtj6M0W+P7pofcuKz50kx8vqQmNiiY9B/zKIjDQiz86V1FPOW
         lsg5BlJTD7AjeYTlwuCii0dXFDxJtYmNGlmFIpvNkERGs7J0XgJmVkolZaWndsTzo46a
         Er1fpNX+i1IDm/8OAJHR6kYFKqpiU1PTPnGCSUhKIbp3RsW3UJSAn4qqtbW0J56ggVLo
         +1XQ==
X-Gm-Message-State: APjAAAUYbGEYZ98MOkWMPNC0uXpdwrDmYlDoHvz5e4otmCC8FY3Kff7w
        c1BGBsoNuCbjpdHY+gb3KXmhqjpSgB1Nabu+bIzuTw==
X-Google-Smtp-Source: APXvYqxr6h3p0MEpBmCK2a2naaPu6wGjyTe6pKsSCuF0bXO0PXx4TaRwclUjkfetX9DkNoi5+601IKek2pgFT+HWOj4=
X-Received: by 2002:a19:ed0c:: with SMTP id y12mr10381390lfy.191.1562652321390;
 Mon, 08 Jul 2019 23:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190708150513.136580595@linuxfoundation.org>
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 9 Jul 2019 11:35:10 +0530
Message-ID: <CA+G9fYuezVnMi38XsefeJNUN3zJVvMMhhmmrBfAqDYsfeJ0L+g@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/73] 4.4.185-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019 at 20:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.185 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 10 Jul 2019 03:03:52 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.185-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.185-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 1ef1d6e05dcd8a34ef188796843b380d0d4e4408
git describe: v4.4.184-74-g1ef1d6e05dcd
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.184-74-g1ef1d6e05dcd


No regressions (compared to build v4.4.184)


No fixes (compared to build v4.4.184)

Ran 13253 total tests in the following environments and test suites.

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
* kvm-unit-tests
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
* install-android-platform-tools-r2600

Summary
------------------------------------------------------------------------

kernel: 4.4.185-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.185-rc1-hikey-20190708-490
git commit: 3eb4ca56f74f0d93a73c81efd51db5765842bd1b
git describe: 4.4.185-rc1-hikey-20190708-490
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.185-rc1-hikey-20190708-490


No regressions (compared to build 4.4.185-rc1-hikey-20190708-489)


No fixes (compared to build 4.4.185-rc1-hikey-20190708-489)

Ran 148 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* libhugetlbfs
* ltp-containers-tests
* ltp-ipc-tests

--=20
Linaro LKFT
https://lkft.linaro.org
