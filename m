Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA63C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 05:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9216A21655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 05:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ga4yxtjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfLLF3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 00:29:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36744 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfLLF3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 00:29:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so797610ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 21:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0onU7gVBFHeq7m2PLrQb4rE7g9Cdls/YcARoJxqQZoI=;
        b=ga4yxtjFyobGLmpt6nUXe+vKPDmcBpo+Oa+ePkkrrwEtHlYCij1VYeYIoKPzPS5LB9
         rjUeSbNzN/qEuRfieM6EPYqQLixxBM30sgiwtwIXFdtur06H673NQNtY1Uw6Gk6EQpH1
         y/s5ddTuejuECIutiOgC7akr5NCzsBKYm7IeesuHCAO2xbF2m1cUU2rJ4G95J2+7Ji5e
         R68lsP4qTBUKakHfXlXZSmscQxnpc9qXue5TCxVv8E6xPKke19OYMeefcqpyAcmx/FRJ
         IDhElqNUFmwyM+DPjHqKu0LJU6F/OYpmRMt0taNNj5j5dhUBipkdODapRENIPmSEgpqP
         s2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0onU7gVBFHeq7m2PLrQb4rE7g9Cdls/YcARoJxqQZoI=;
        b=C5Nv0unsiHlySf0ir/hQsZfdQWOWGzamS5icFvg2Q9ih9MRzHrb8V25ttTChJdmPNk
         DqpqqT8X1RFdXSff9hycbpDUW61ylocQ/MvG2bHzlvMUoneOtI1MN/PpNcTtC0C2GwQA
         qyxtk8pAh39a9CHt4sN3zXhM1e4T60YjOSSiKRWcq/iSAX55UMdE/sDBV5aD8Dd3OyaY
         MO65tjcCYrf1rr2b63mwJHzR7gAzWHIU5MWYH+8JgwZa8eGSvOfYY+pAXszZGtPI7uKG
         vzaO+/+JgInuAHQ8AM+ftUX8I/sYJGfwGBFzaO/NdER2NS5nMvauMUES+Un9GeUGLGs4
         rzSg==
X-Gm-Message-State: APjAAAViovvUeaC8RTRQX3l5qPaVEHbbbOc+lcBrE63dh+jHzq3mTgu7
        usP2lt6QxIxwFFemTt9knuDgWiFCG4/inttAOTxBkw==
X-Google-Smtp-Source: APXvYqyAi8Y/18qIYbhHxpG5xltgaOPyxUWdx8tLUS0muB40MfO/04uqosm6BUTKxuHVGg7aeT9jHuEH7RoEta9akvM=
X-Received: by 2002:a2e:a0c6:: with SMTP id f6mr4526081ljm.46.1576128547783;
 Wed, 11 Dec 2019 21:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20191211150221.977775294@linuxfoundation.org>
In-Reply-To: <20191211150221.977775294@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 12 Dec 2019 10:58:56 +0530
Message-ID: <CA+G9fYsnFnAimAAusrOYtOphC9fnXbwjvi1St0hQFdHKbVZdgg@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/92] 5.4.3-stable review
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

On Wed, 11 Dec 2019 at 20:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.3 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 13 Dec 2019 14:56:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.3-rc1.gz
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

kernel: 5.4.3-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 6b42537b2c8927366737f1d297ae4e91fdeba6ea
git describe: v5.4.2-93-g6b42537b2c89
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.2-93-g6b42537b2c89


No regressions (compared to build v5.4.2)

No fixes (compared to build v5.4.2)

Ran 23952 total tests in the following environments and test suites.

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
* linux-log-parser
* ltp-containers-tests
* ltp-cve-tests
* ltp-fs-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-cpuhotplug-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-open-posix-tests
* ltp-sched-tests
* ltp-syscalls-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests

--=20
Linaro LKFT
https://lkft.linaro.org
