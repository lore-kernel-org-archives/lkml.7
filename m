Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ECEC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 05:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10F721479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 05:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MCghoAVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfDTFdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 01:33:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37610 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfDTFdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 01:33:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id o19so5335915lfl.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 22:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vbh88o/bwMJfvOcVqGplo3mL6oW5w1CqC89NgPg1h+Y=;
        b=MCghoAVSwp/AMvIt7/KymAK6/WdCIQZ1Hk1LeX+bpZT0+rAjRbuPEhOb7YcU9VBr52
         PtY2exUGArTqzZTavvMr38nFdvRWj5UPKpTTSQXNdjgRQTC7XivGIUp2v7hwyH77U4Re
         NwhfIEBZzy+LiZAjMNtDGUItDvjnNKR5gmAY4LZMKcobAlf89NRKZONmVkX+cjODE9WF
         97GwRUx1LeeVMZR+sPTE9NDF7uiJZwPYGwDljYN/5EVQi7YouZkLzqRAPYWXw8gv57WX
         jIxX/veXvhSLlPThjCzmSIb1f8No8XLPSYp9l0Bm52RE/pbV16k8cMT49XzMyor6Tswz
         SQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vbh88o/bwMJfvOcVqGplo3mL6oW5w1CqC89NgPg1h+Y=;
        b=PDft16salXm5LQU+0s+4HK7k2oi7+TFRVDRRBD96sniTbLd0SZ+ugRbNh/TQh8ZLcm
         HRMPqOFGr1E5zb9sEmqAWYJtUQkOTgQMRKQRdDkZm8UFGDgr84HKRKO00Z6LxxsMRcqY
         1A9msLu8AkhuPVVF6qUqu+9VNHRi0Byq2RiWNmwk8U0yLTDplU8YiF5IhQMhhlLEIY5p
         gGoGGOYEP/S84d63cvzXfF77lRVoIWI1r7fX3g0bU+fzxXSoVHoATlPkuHnsLV+6k2+e
         +j0dxPRGso/rLnorwksjg+HZz7uUHuQkfc8QiEpxEz68pPZYzEr3hMzyYBLG1OsIhzob
         A6Aw==
X-Gm-Message-State: APjAAAX8DYtjwQgZkXraLMlJTxXWsxQMsh0PuEn72T8ERp5Hn2pK1gcs
        5cNORzJXrxYC+hj+Fna5t+E4IuRlAr9hIdzf116nV0lxB8o=
X-Google-Smtp-Source: APXvYqwGP7rUFabJ8kRXHAlzS2LM+GoyyGmbO5qmpUn7TLwpf7/nmrTUNviaN7UdzFxrq4R8A+7jDwjipg7MD/WgNsA=
X-Received: by 2002:ac2:5455:: with SMTP id d21mr4061737lfn.60.1555738410112;
 Fri, 19 Apr 2019 22:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190418160437.484158340@linuxfoundation.org>
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 20 Apr 2019 11:03:19 +0530
Message-ID: <CA+G9fYtyC2PyfwhPZ3m6=brXqMm9YaN5dZ74UjQ=mVoB=VS0Qg@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/110] 4.19.36-stable review
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

On Thu, 18 Apr 2019 at 23:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.36 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Apr 20 16:03:29 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.36-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.36-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: e409a9a7917997e4aa9b49cd5c445208696ee1cf
git describe: v4.19.35-111-ge409a9a79179
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.35-111-ge409a9a79179


No regressions (compared to build v4.19.34-102-ge4f859c2cd83)


No fixes (compared to build v4.19.34-102-ge4f859c2cd83)

Ran 23730 total tests in the following environments and test suites.

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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native

--=20
Linaro LKFT
https://lkft.linaro.org
