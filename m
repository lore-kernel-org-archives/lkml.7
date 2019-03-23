Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A22C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 05:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BE921900
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 05:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q6BllB9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfCWFsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 01:48:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37886 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfCWFsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 01:48:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id v13so3741080ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hNHwW4zXjbykXR5OecZx62TvoPe88Gmr3/yz/pktusM=;
        b=q6BllB9mbPpU8WZbwio8CASBFEO6riYvdxJ1R1JKTxlUmn51E4BI9AK/F6VDmBKsu7
         q6qk/paweDEgn0hB3zPHD/Y+l2xKUJ8w8ScREmaCRmXjDX83tdIJi5eOthZ6od2PW1jr
         iLKY7Xmlk1eJwnDkL66zTKQZRAF4zsTtOlUgw2tkZ5SP3q+eT4CluKUGNFpqDBzz6miD
         TNSD9LmLxzg1+pEf8eBJcUlEuFCYJIJWz2GZWGPtLikiVom1le7tDUwhqdTAJxVaneBj
         tZsd0Ow0JKmbVq170JRMOkPDm1p5jxCPewYLykKUqSoNPpu1EL0LOQho209SC5T8crgO
         Pqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hNHwW4zXjbykXR5OecZx62TvoPe88Gmr3/yz/pktusM=;
        b=c/7VYw8viuoR7UEPELxz7UUW9qqliA4+p4qVYNct/V4wmndn6fkOCZAznmTx6VNluW
         XBAS73pWR8YaASCeQD/v+Pn5sHbJbb+dajwFTBnNp206++ssqOJLBuN7F7oNVnScJzW6
         N81lAT7u7iiPytwKKvNzDpKUCZ77Z7+lNo98GplItedZKlqZVk6FhCAB4ka7p1u0BGYS
         Zc7cxnC0VymeaZbynnlVQV2oKM5kdmGQU6WJOagDPuzNVoUPaKpo8a+bJGRoJanZ7iEP
         lZbIo48alp2sZv6jhggzpnrDdZTdTHY5r/0EOx+8d8B9zOFbKR+Rn/pL4BrAkEcpYRBD
         SgOQ==
X-Gm-Message-State: APjAAAW8HL+PjInYXwVOVLj00NpMX9y7MC8V+1ge+lie1Tj5sg3eRKDk
        oJ+/q2VMuToOlsE+hl8sxU7iG3GMgWSIdmwtjcjYTA==
X-Google-Smtp-Source: APXvYqwQEPi97PR1jmha3pjstudFrIP+j0cPLjYzJlZPA/0pHoSc5a5dWvW0ckOwhNNGWxjKzFODFxkIrJMPkqRVNYk=
X-Received: by 2002:a2e:5bdb:: with SMTP id m88mr5653112lje.9.1553320083276;
 Fri, 22 Mar 2019 22:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190322111258.383569278@linuxfoundation.org>
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 23 Mar 2019 11:17:52 +0530
Message-ID: <CA+G9fYuzz8rkvdVMk+D2qm0pF5sFVmSbq+ad7434N_xe6D94yw@mail.gmail.com>
Subject: Re: [PATCH 5.0 000/238] 5.0.4-stable review
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

On Fri, 22 Mar 2019 at 17:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.0.4 release.
> There are 238 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Mar 24 11:11:13 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.0.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.0.y
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

kernel: 5.0.4-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.0.y
git commit: 6a3b25ca97204a3891527d88b6691b362fee82c8
git describe: v5.0.3-239-g6a3b25ca9720
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.0-oe/bui=
ld/v5.0.3-239-g6a3b25ca9720

No regressions (compared to build v5.0.3)


No fixes (compared to build v5.0.3)


Ran 23161 total tests in the following environments and test suites.

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
* boot
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
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
