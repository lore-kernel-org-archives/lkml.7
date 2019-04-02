Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3F7C10F05
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033262070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ygoqpdgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfDBC52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:57:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39875 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbfDBC51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 22:57:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id m13so7790761lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 19:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vnkkHQ6JnEHa6sPpsGYIAaGoDeGy+d/EAddSxYO1sd0=;
        b=Ygoqpdgty9RoQ1vCd7uM61Cx4hU1+vBqBxok5cYobjDRzXa8+LdbMCyusXok/a4vNj
         aThcSZSSX4tTHdJp3capSPCzrtAfA0AXFH7KShyrWymwLfEvL91oL2HEK+msf74POPyr
         Khgo3+uBXsMtq4VBtN/MKkfPLCdr12BTpNP84ozJ5GS9Wkn7oDnCX8GMW0DEDT6qBxCV
         TgwMqKmuM4ab0Z99dQqgDWoD8w7mMQ+TOMJRkNCtMZxp0Qmsfwp3J3jdAefshe0suSAX
         GU2ClR8AIcQ2MCAGMnOOyQQWQiSPbjfCy0z09WqFnEagrNYWR1OyUfGc0BvAeo1YYFRo
         fBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vnkkHQ6JnEHa6sPpsGYIAaGoDeGy+d/EAddSxYO1sd0=;
        b=sp1Hpo9MQr6GDN3VeG5xzLInG4wKDosDr5iHrGd+PKf5cso/036zPVktFgvW6eq/KK
         bePA7sX+i9hocq26o4tT9ieYDvpu7AcnGXCwWFbzCx0Ef3CI6t1Q41sa5gIT31RpE2dN
         5VCveXiXiDgDCVKvDiJOWQCksF0G76WEUtauztds7EpAFsuS33TuY7Oa+rR9D+q3U9u4
         TH1dFcUp92YglH8e6G9AG+HhEUFcqJ71MXhPBNgEOfkdgpYDef70i0H+1Vqsofp1Ry7d
         VodZG+O2nGdRop0I001/4h7WBqKElhXh7pmYtZCAu8Ie+e5Zbs69cq10OfwLmIRCJChV
         5XfQ==
X-Gm-Message-State: APjAAAVtFaOzCRCYbcl5nIaXQawi2bai+StHGXvv2Y4CNMoQudxtGHBH
        0JHjV6cwBrqHAOoHW5u5flG/zZMTUO16tU5B6eZZtA==
X-Google-Smtp-Source: APXvYqwY1qLIqoGLA+6YPzNloAWA+HDaehgrQ2fPYFjuWuvNf9fX81N3k4zV8s9C5FL0oRHLMrRd5rhaIQGi+DsTuLE=
X-Received: by 2002:ac2:514a:: with SMTP id q10mr33902919lfd.17.1554173845121;
 Mon, 01 Apr 2019 19:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190401170051.645954551@linuxfoundation.org>
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 2 Apr 2019 08:27:14 +0530
Message-ID: <CA+G9fYtCkD72f80Q8OpHdGF7NCZK0GYL65m_ZJ9q3aAv_+5qOg@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/131] 4.4.178-stable review
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

On Mon, 1 Apr 2019 at 22:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.178 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Apr  3 16:59:39 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.178-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
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

kernel: 4.4.178-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: d83f26e3dc56e1998cf85b7d35bf5c5819f03215
git describe: v4.4.177-132-gd83f26e3dc56
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.177-132-gd83f26e3dc56

No regressions (compared to build v4.4.177)

No fixes (compared to build v4.4.177)

Ran 17065 total tests in the following environments and test suites.

Environments
--------------
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-timers-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-syscalls-tests
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.178-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.178-rc1-hikey-20190401-414
git commit: 2d75babf7185cfb2ecd3c49eb62339fbf6e01ae1
git describe: 4.4.178-rc1-hikey-20190401-414
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.178-rc1-hikey-20190401-414

No regressions (compared to build 4.4.178-rc1-hikey-20190401-413)

No fixes (compared to build 4.4.178-rc1-hikey-20190401-413)

Ran 3008 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

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

--=20
Linaro LKFT
https://lkft.linaro.org
