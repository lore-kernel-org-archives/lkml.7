Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B43C4646C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD501206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUeMHhIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfFYAoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 20:44:04 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40721 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbfFYAoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 20:44:04 -0400
Received: by mail-lf1-f65.google.com with SMTP id a9so11348002lff.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 17:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CqsSVwEbnPYR+CbblI/s5YoLiQL9z41UI6Zu+9qXwWs=;
        b=OUeMHhIm9MlrApudaCrTYD9zzrqDiS9ycnwcJlloFn/q2MLeodWmMItZXDp4Vg4Gyh
         v8MezQ0whTrozGzNjjxhqvsbl3ZCOFQ2O2aT0vmXRFBO75XiazhaETouEjuCuONqc1S/
         2WaE+Ic0oAothA6zinx7PtO/apd1i6c4Y2XVFEQqENkYXeOxqv5c3jB7OEWcqg9YnTvT
         tH8NEz6ijfLClwj/pF2k01xXMyw6/zdf1wHAEjKYjt53eiQll7PfzhW7Xx9EaF2WoSKP
         QxILUfPaeSk7UWL6JrkNgLx2aUz+BqNSqR4G68KIXeapdbwG1KZ1O3cU39WswOZgsqZ2
         DAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CqsSVwEbnPYR+CbblI/s5YoLiQL9z41UI6Zu+9qXwWs=;
        b=uCSNpLR3VOWibqiLVBWn7nd0H7fV+ysAN5VryYMoAGGotSNH3QvRungRKZ5eWmNZOs
         dNaF5CZTnJX9fTVbak6z/DL7DjFiiF125air2c3eKhcBSWW0QKuILy/qePoF4zGCdU2G
         3BPidnypKj0BP1xxS8rWdY3H7C9xEAbQmqIhug3CDrl72cBDOOLA8h5dZcXdF1cAqnxg
         S0a+v4abA2hguzt8ivWKsIWPYwfu2xEbdXNJuDOCYIY50LUW3QU312U+gvaGQkvp7/KU
         xH98El6q3mTt3qtvhbdoFBI36kvEy9QDb306s2Bgn/sM/3fFTZbra8JvAyMiihaALZgr
         yAFA==
X-Gm-Message-State: APjAAAUQjVP5k6/e2oTJHuEV1nF9Ex4xu49lOmtfSiWe3iifugRi7c0f
        Ai/uvOMJGCy2IUVKwTsihTKomCnzdRoQXG0Mz4Z6ZA==
X-Google-Smtp-Source: APXvYqzzem/0Ye5O7fzYnTekrmrIgKpQ2UbojNG5AXpf/0bao9mx7yxd442XtUHharIhnZ53stYUrmPodJW+QoA81/M=
X-Received: by 2002:a19:488e:: with SMTP id v136mr8494494lfa.192.1561423442252;
 Mon, 24 Jun 2019 17:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190624092313.788773607@linuxfoundation.org>
In-Reply-To: <20190624092313.788773607@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 25 Jun 2019 06:13:50 +0530
Message-ID: <CA+G9fYuD6Enko_srw4NFPC_FsUPaLauLN4pp=AgxH6r-kaZ9Aw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/90] 4.19.56-stable review
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

On Mon, 24 Jun 2019 at 15:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.56 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 26 Jun 2019 09:22:03 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.56-rc1.gz
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

kernel: 4.19.56-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: d8e5ade617e917a499d5d59b24e19e71f80886a8
git describe: v4.19.55-92-gd8e5ade617e9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.55-92-gd8e5ade617e9


No regressions (compared to build v4.19.55)

No fixes (compared to build v4.19.55)

Ran 25252 total tests in the following environments and test suites.

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
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
