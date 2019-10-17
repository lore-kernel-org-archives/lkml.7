Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837E7FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5641C2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aTsjheut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437097AbfJQNuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:50:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33684 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436795AbfJQNuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:50:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id a22so2676585ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p6nZR/9Zua3DBUg48vEj5YlDbRJuasAgse2qjxSDyG0=;
        b=aTsjheutNHe5MwDJvJZW4RNku/5SRLLaXe5w4XHpTIunmwpx0T1oQxsgApN7PjaE55
         P+2kTxXDA3TzYOCqyv1TcPQ9kmJ4oSZFTB/5+wzforLM4VJcoLH0o5jLyzqISi/atUWx
         y+DIw60egJgWRN/TCadXJ2covwHR2iyzOUKnqgqzt7t7hEK7LpS2rDxhz+WWaPJFMAOz
         sFv3MUCzbwuhXfseGJlwasKHDA+tnMsuYsHGl2rCCkn4GaI4nVMqQs/4zihAFp4VBYrZ
         dCGpkMS5y4CIMWBK8SuE55wpK1teF5WTE/f/DW2gMzZBSPE6uFX89wUjM0IORfVAOvxv
         Pwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p6nZR/9Zua3DBUg48vEj5YlDbRJuasAgse2qjxSDyG0=;
        b=L/KNyuMpoWJ67TLVfDkK17KklhYzOzfJ/HznSYQpzzns2hGFvu3VGZMTw67ZdbECib
         7xTTluah2WiyEinyd3F0n/GRC6rCuF9BLhv/t7p07sx25RWLEoG1Q8PBNBOcsRVSp0F9
         vik5f0ip4sLDhpSJUf25hPB4uzmlefylLHegnJzRO5sNahu8WLy6V/0BQL72wy+OaXQF
         ZWgNzRs1EV8pCdcti12MUKivJcj7AiwBHEVVPogCe20TDvnAq6ylRZ9pk9V5yU7Tk7bo
         OTCGEWctot+NiNKBoLbyKmXCLxkTb7jemmWsgt+wcr/Rib/bFw2nzU9ZlkDgRb4v44sO
         BtqA==
X-Gm-Message-State: APjAAAUNsGviKIvOTS0pkd8Vp5CUgPwZ4igJCWoPgRA4YvryRRtaq78w
        bewjR5CnJxhPeOXsGNj1dgj1AjBG69y8ilAjBxydZg==
X-Google-Smtp-Source: APXvYqxsLEekNjXlvonl6W01f55s+jm+722adMbT3F4aVqSq4V3+hFuNs1+zd8cN0Wu8IFzcPvF/owb36ZacegEECbk=
X-Received: by 2002:a2e:85cf:: with SMTP id h15mr2712280ljj.141.1571320249772;
 Thu, 17 Oct 2019 06:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191016214805.727399379@linuxfoundation.org>
In-Reply-To: <20191016214805.727399379@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 17 Oct 2019 19:20:38 +0530
Message-ID: <CA+G9fYvnW2RGuz0nkkfQdxpFc=8ftSEXmiS7Vz_B2H9RsParXQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/81] 4.19.80-stable review
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

On Thu, 17 Oct 2019 at 03:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.80 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri 18 Oct 2019 09:43:41 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.80-rc1.gz
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

kernel: 4.19.80-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 99661e9ccf9206876ca8f509555b7b0d3e45cc13
git describe: v4.19.79-82-g99661e9ccf92
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.79-82-g99661e9ccf92


No regressions (compared to build v4.19.79)

No fixes (compared to build v4.19.79)

Ran 23644 total tests in the following environments and test suites.

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
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
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
* ltp-fs-tests
* ltp-ipc-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
