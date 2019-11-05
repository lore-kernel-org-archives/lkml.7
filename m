Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907CACA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605B42190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vI7sjVF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbfKEGo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:44:29 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34489 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfKEGo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:44:28 -0500
Received: by mail-lj1-f194.google.com with SMTP id 139so20489478ljf.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 22:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ay1Ixq6cBI3gofXGdK3vO7GoRuVXJrG/NFv3pprP5dY=;
        b=vI7sjVF0tlXBMi9wFmmvp5jnbgV3s3+rlj1FKrSklCwVdBQLtS4zdWwRuCR1W8jxw6
         iakRD2RSwsIHs0/h3XGlwMlHYcQx8vvKYPT7AQqX7PsCqpI5Uf85uNsT8EBn1nhNXr5y
         ji3p7eK3lyib14HVww8nQfG+hsoPnVf6bWyZMEAj9B9Wh83QNrJHHp01bjsYkmeSrxDh
         UwDlKglGkAK2dUDVs+Ej5IKrfl5fUpB/4tKHWeLqWEX6V8D4QBoZDHkduAA7CDD9/8Ng
         CxgXB8ejQVyEnFMUaTlgZtrnKE8ljlv00pex3TMSVYk3O1vEYV4LKlLVvNyCjVD8COVo
         eN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ay1Ixq6cBI3gofXGdK3vO7GoRuVXJrG/NFv3pprP5dY=;
        b=lLBST6sXXDPZ5SCVGFnAN3NyR0X2fCYs3f/7FIGA2crLVNruZiSc6yPpX7l8yO4MpY
         G9LiVPOhgL7uAg6XpsLkhX9TVoChf6yFvku7qW30JDZ6g3Hh9FNKSBz7w8VytdV0nVfG
         KeK9FTqI29zFAXtvys2YJFL2VXdX8ckYon6hjkl6l7yLJIpJH6eMOHaPv8q4R1+AaZhg
         uQTHcQ2h6VLiajA5vTOCSQMI2L7I9/hYguz/tL1mGRhWBQwtJCPx2iAxemmlB2NP0QF8
         pK+TfYsXbx6+/Vf3s3W/2mfnQDmqyo8unwsVoMbgjyM7B4JwysEVsNZZxqKPy7x09uOh
         Ttog==
X-Gm-Message-State: APjAAAUcKL/EXDRI+0DvKckohOm0kDkAgK0ydATYrxQBecbdcpWA0cFY
        oZrvTUt2/oTvrYwWRx6JCUExBhjUcdvgqi5HNXp0BA==
X-Google-Smtp-Source: APXvYqyFVApwX5OvBrSu/2aPO3qVvjflJUgzMfUvgSM0MHuLQvf0xNwpsrlKLH9dBEjYAntXuviZrViRrV2wRgMuUAg=
X-Received: by 2002:a05:651c:87:: with SMTP id 7mr1499687ljq.20.1572936266619;
 Mon, 04 Nov 2019 22:44:26 -0800 (PST)
MIME-Version: 1.0
References: <20191104211830.912265604@linuxfoundation.org>
In-Reply-To: <20191104211830.912265604@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Nov 2019 12:14:14 +0530
Message-ID: <CA+G9fYv5K7S6VgKO8vjmKUeb3RwHi56deGfqzoJMUJEvkPvfGA@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/46] 4.4.199-stable review
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

On Tue, 5 Nov 2019 at 03:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.199 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 06 Nov 2019 09:14:04 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.199-rc1.gz
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

kernel: 4.4.199-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 1e0d280e1f8dbd21a713507c208e2ed524c18257
git describe: v4.4.198-47-g1e0d280e1f8d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.198-47-g1e0d280e1f8d

No regressions (compared to build v4.4.198)

No fixes (compared to build v4.4.198)

Ran 14764 total tests in the following environments and test suites.

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
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kselftest
* kvm-unit-tests
* ltp-open-posix-tests
* install-android-platform-tools-r2600

--=20
Linaro LKFT
https://lkft.linaro.org
