Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F32BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566D92082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QN3qg+f3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfLQHXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:23:52 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46781 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfLQHXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:23:51 -0500
Received: by mail-lj1-f196.google.com with SMTP id z17so9675960ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 23:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7yp6TAUsIdw8thMlsv0tuyq0zRY28WxHtDGJ74bxq0I=;
        b=QN3qg+f3x5JpQWErRTa862dvXKNu6gxHlZ+FESaGnE6Xb+e8Xb3F1sDZe87OjT50FW
         ZLArPkMwUDLXv7VCB1t8pdH7nJVQul/tuiVOrdYRrXr6tF3BDPCX9wA8cGtV50j+9mWc
         gDzPUdQe/AgNtRcf0uSn+aOB38d3/uk2tP2v6tuQsGmf2eOTkBF1mB4vBauNqo9vwD79
         CWCpm8MY7lun2qW3Q1rmgi3FiPAnE2Z147jwDq9S6ZJ4Ie5D7RxWni5Zrx/ZSeto6esk
         IKI0hk7ZwemuymcgbKD+J8UYgykNZ1tMKLIc6lKmVaoPnqPuEMuSyRLGoceYZ2A7GUmS
         NRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7yp6TAUsIdw8thMlsv0tuyq0zRY28WxHtDGJ74bxq0I=;
        b=KI5ZLhUASWZJCObVMVsD9aor2AD+7YUeCZq3n5mElNMronU3MqFGzJhxMmcJDqaBai
         txUjqMfpeX3yAGaeEi9ZltilD5Z3lXkBUaOIM4ajHNn1kwkwOu0/a3UjGE/EAAjtJwjz
         rOGv/00qAQTkAJw9tLKRFk4gu6ftgdP0vBQVHmug5yYhcImwy4burQNmLYjuZCTksKIm
         BWdHm4exFmuLrm9p2so6Z81jGYAP0lyTMWqfrJG15jLukQggufZzf4mLH08Affkru4Q2
         tUTieLt22g9R7Ner+GICf62F6W/isJ5yFZYj/aymwxrAx/bsvFSwrsFDEDVaiL3vatx/
         yOUw==
X-Gm-Message-State: APjAAAXml7bmR7zNhOcPcuLXBvGr0LOQt1GhCYPo6A1hftBc5d1eiDGB
        s0+tZt30OO9hOWqV+OCfW1bNTkWsSqUNiA2Ijos3pQ==
X-Google-Smtp-Source: APXvYqzTDT0UQWOlnr2jnIK0vU9LiTLc5RAuWqmhQ8p/g3C2TSCDZOYT03VvOey6hLsgvq2WYf8OylaCmvLTrz35Kvc=
X-Received: by 2002:a2e:8316:: with SMTP id a22mr611055ljh.141.1576567428790;
 Mon, 16 Dec 2019 23:23:48 -0800 (PST)
MIME-Version: 1.0
References: <20191216174811.158424118@linuxfoundation.org>
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 17 Dec 2019 12:53:37 +0530
Message-ID: <CA+G9fYt-=ZbHLEEn8VisqAN9ry6rj_Vc-7yFr+bVn3uTwhCxqQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/177] 5.4.4-stable review
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

On Mon, 16 Dec 2019 at 23:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.4 release.
> There are 177 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 18 Dec 2019 17:41:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.4.4-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: fffa88522363708152669b9ff7cab0ebaa937d39
git describe: v5.4.3-178-gfffa88522363
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.3-178-gfffa88522363

No regressions (compared to build v5.4.3)

No fixes (compared to build v5.4.3)


Ran 22162 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15
- x86

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* libgpiod
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
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-mm-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
