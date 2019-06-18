Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E145C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBAF2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ndvLQD4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfFRGm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:42:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35830 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFRGm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:42:56 -0400
Received: by mail-lj1-f196.google.com with SMTP id x25so2291052ljh.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 23:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lgpzRv5/vynNFVxE3s7Hk+KSeLSqjof34qro8UmBm8o=;
        b=ndvLQD4k5zwfsFqkCbpeU/GdORiZuLt2tQGPpLggKjVnArKNlOlBe01TuLIDNUq31V
         YDKYozo8e5N0MIWhExz6KSZh5eu2+kcH5NWyGnXBlECDSH5Y+fIDPGDHQO1ZCI9gE6lS
         uRnU62oK5BRiTw29kLb5SU/3z/yCyljtzmHvh5DFJ+SfwbQoT33keMUVnET74f7coWSU
         xm04O86GOb1XopcpqRZz08BElMK4i0EaaO5bb+LQGPppA9yhmFzr7XFDCJAuv8wWzrcX
         pAyUlw0Xjgt7m07w4e3fiL3NDYoYRZUzQNL7ayeS+BDw7s+n2ydNPhTMTPWKv1+pnW+q
         fY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lgpzRv5/vynNFVxE3s7Hk+KSeLSqjof34qro8UmBm8o=;
        b=P6jynHYA6GW0ljkj3I7bpiJ+xFISycb1knZcqq6dHWFD8OFED02ZkOaxXVMXtqwqdN
         enwdNtIkoHe3xhsB0E9BgxGEskzwgGhm7w7Bz7MIB8RUYq9pietduHE2bCMxScbKgcTn
         ugoxLyIN7OW+CcsyZEEg+zGmIY4kQNprtaT6C09CeERVgzdJCJv4RBTCc98BYqQLqrvu
         V/yRV7s5ZPC3XlFJPNyYD2+O2Wmg2FermmF2etCigrhtNuxgBcv/syi3KE7JQQsKF/N8
         mEOI/vrmUqsbAznoQp94PnPzinykZRXbmO8+ofNZReGYuBi+V6Vy5dNXILaYETCtk002
         zfSQ==
X-Gm-Message-State: APjAAAWHP6dC0ufSmY6TA7ba0uSZLHPw7xaU/oH4ml/BNzCwjRyOMMNV
        fwMyxlEelfjTq4moE0fZg6IwlkKbudua0K9+VoOGKg==
X-Google-Smtp-Source: APXvYqysx31qoiT/uxvMzQli9uOZPuPw935uTXzuZMOOepVzmNXRBmm8ahGu34wMTrts4UWwpQRpMCKlnOxf9U4V5Bo=
X-Received: by 2002:a2e:8495:: with SMTP id b21mr20543162ljh.149.1560839768102;
 Mon, 17 Jun 2019 23:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190617210745.104187490@linuxfoundation.org>
In-Reply-To: <20190617210745.104187490@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 Jun 2019 12:05:57 +0530
Message-ID: <CA+G9fYueq_CFv59aYSguU_yq_nd9zwpcpnJKrqVtx_VOCSZ+9A@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/53] 4.14.128-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 at 02:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.128 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 19 Jun 2019 09:06:21 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.128-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

NOTE:
Backported patch media: v4l2-ioctl: clear fields in s_parm
fixed v4l2-compliance test case VIDIOC_G-S_PARM

Summary
------------------------------------------------------------------------

kernel: 4.14.128-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 16102d7ed8409bff0d3b105d08bb2ca26343c539
git describe: v4.14.127-54-g16102d7ed840
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.127-54-g16102d7ed840

No regressions (compared to build v4.14.127)

Fixes (compared to build v4.14.127)
------------------------------------------------------------------------
  v4l2-compliance:
    * VIDIOC_G-S_PARM

Ran 22198 total tests in the following environments and test suites.

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
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
