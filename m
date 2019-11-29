Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156B7C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 18:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE32621736
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 18:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZ7BIhgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfK2Ssd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 13:48:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35565 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfK2Ssc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 13:48:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id j6so23935416lja.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 10:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QcqoECSYUxhYpSdN4wxMXBNEGCg39mo2IFh0nw6OKSQ=;
        b=jZ7BIhgm8UD72PSplPNHz0eyDEVCVP5JMySvDokGjNSX+z5vDPQmPoeDGTLjwXiV9F
         EFnZgkvXyj6Qpq0NfPlBPKTwf2Le3DGB7/40nlUQ1m5BTk1+jeNbqXMWaFErdAVXl+gk
         9ILn86Uv/Mt7uH6h+6yxEyoI3mhdm8CnnfYFjh9hI+zADEerHm8n/28lIiXMWLIL0UF3
         KMzh14KuX1CieIVz+uYIsMy9O3iN6O4Boo+kAs8gawbAjRWeHtgfcDwtxjyioFdEXS+G
         /Tip0pH9AUYIWDGDcp9iZpCYbFFNn6MyWMje7rWqedlJnVMSY2f+vkf3SgXdKPO2dQvg
         7xFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QcqoECSYUxhYpSdN4wxMXBNEGCg39mo2IFh0nw6OKSQ=;
        b=t2ysBzS5By7QyC8v5mILj05aL0dt41FR8gtuFEk7exIXudNQyK2sB+4IYXiduhGUAt
         wguxaPFZ3PjaMDkNhV6LO9ty6PuiaOarLwIvUTpzYD/UbLyva/mT1DiyXsxJSgukRyk1
         Zjk8rWknYo1Ub28Oz8vEsX6pU8pAeXGugLV6A+WbX5EZneBY8Dm6zeE5CB6y3HQvx/x/
         obTJlNGm+5PUlxjExrH667tO1E6XPzcu1bQvHDHJAc/Qd8GxVYAsaFekvv3JsjBtCThU
         DjDFL//YzG+5iopX98jQz6Ll9SkuoLSkHS5Enj9Dd65WU32qvFHa2eGkvXzu/b+SzEf9
         gopw==
X-Gm-Message-State: APjAAAXgejg4r44LklZ6BCxrorWfgW2H97Natd0pLkxl2Xtmt1lUt+HE
        xYtTHz4PSnHY+xMvkrej75caxEPmO56TzAlomnvrbg==
X-Google-Smtp-Source: APXvYqyvVrld8vyHgVdXiWcIMSoaNJOGFRE9mApbWiRASu/dsO82pQLDOtIdNyuCNYdsR7YSY+JdGmc1XpHxEIio6Hg=
X-Received: by 2002:a2e:9b8f:: with SMTP id z15mr10137lji.20.1575053309059;
 Fri, 29 Nov 2019 10:48:29 -0800 (PST)
MIME-Version: 1.0
References: <20191127203049.431810767@linuxfoundation.org> <20191129103637.GA3692623@kroah.com>
In-Reply-To: <20191129103637.GA3692623@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 30 Nov 2019 00:18:17 +0530
Message-ID: <CA+G9fYsUTrzt+q+D-wFagqVQFn+voP4dM7HdY+F+UxQx7c1pXg@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/211] 4.14.157-stable review
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

On Fri, 29 Nov 2019 at 16:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 27, 2019 at 09:28:53PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.157 release.
> > There are 211 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 29 Nov 2019 20:18:09 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.157-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> > and the diffstat can be found below.
>
> I have released a -rc3 version now:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.157-rc1.gz

you mean -rc3 link,
https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.157-r=
c3.gz

> that should have the i386 issues fixed, as well as all other reported
> issues.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.157-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 36dea990ac35ede053b2c69d91cc480b19fbb7dd
git describe: v4.14.156-205-g36dea990ac35
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.156-205-g36dea990ac35

No regressions (compared to build v4.14.156)

No fixes (compared to build v4.14.156)


Ran 24559 total tests in the following environments and test suites.

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
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
