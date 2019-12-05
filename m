Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA283C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 05:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC0E224F8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 05:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7nMAjCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfLEFe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 00:34:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36175 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfLEFe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 00:34:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so2044300ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 21:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4d4KuCqg8CRegbSOX7zWEHceC3dDbXRSmaznQ3aXEw8=;
        b=B7nMAjCmAkgrUFa6g2ZFBlC01MXKVbTqNbTOJ58im7MfH6FdGiqfTnrKtABJkxCv/Z
         Fy74CehmSdP9gMQYQXLcPTrcWOvzhsAquiiM2N9eaVyR4zbmeTenlH6M41wGvAFuHjGO
         EYUuGISdr8bpvTBvleGIv9JMSTaTxvjNBpi7lcDqnew9yE4CFfRy9ZQ/3LWdYcXR+90+
         7FgiqJC0mMHS/VbbHpUQKXmNOTh46EdqiAWR27dnWY+aLKY5wocr4V/IjFiBhKc2lLwL
         2HNmCquxQu8tISO0guizZ7PzhSiX5/pIpiahcZZABF/MPL00Jdh38ACSfQiBok7wyekb
         Np0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4d4KuCqg8CRegbSOX7zWEHceC3dDbXRSmaznQ3aXEw8=;
        b=Q+V9YCKtAtmyMdCFlkfRA0UXXX3e1f0/NHmQUmcWqUUZim6Js8N43NIoaEGZtlbzUs
         xcn5woP8fc8vEk3YqiV3alt6xzCINOChWcy2VsB40cbkZb4yNonUcKsP2Btga/VWO7aK
         xkEX2T31oLLSYdGbhXzFvT/DHRjgOeZpIXSE04yGRq1jZvtTvJZCSUiJ5DeP5oJEyzW7
         Wca3J0h2iqbzWQdKY3XcJkH9BVCGop7eTqn0VVXID5sy7hKhtn5CSL15/nH8oMhEDuQ4
         1/xk8lEpApPZk0W3z+dMSYikDXiPF4UiKq9pjtU6XYTbfNbHbI7KvTFrX5xvvOItqgJk
         HvEg==
X-Gm-Message-State: APjAAAVfOrmVD12qhX3k1OacvfxykBOiqSRT4RkExI8/7haMofEhewzY
        u28DR88l3QryXpPpb5JtS8StnnhoeFsz9BOY3u+63w==
X-Google-Smtp-Source: APXvYqz7D/ENxvC0PRTWwmkFCRrDs6dhTZtl0nUIe996I1Ebb0FvCfPwB1Fr9oedBA2E7cObvUl+nCR0SMl9zJUSJlU=
X-Received: by 2002:a2e:854c:: with SMTP id u12mr4028797ljj.135.1575524094457;
 Wed, 04 Dec 2019 21:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20191204175308.377746305@linuxfoundation.org>
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 5 Dec 2019 11:04:43 +0530
Message-ID: <CA+G9fYtQrOE0_dU259OpMtffd5dtC+-Z+hrDtZ=HQgUXi=_zcQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/125] 4.9.206-stable review
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

On Wed, 4 Dec 2019 at 23:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.206 release.
> There are 125 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 06 Dec 2019 17:50:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.206-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.206-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: eedf6ee6d6ccee71e628b172e33ef860e05e6bb2
git describe: v4.9.205-126-geedf6ee6d6cc
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.205-126-geedf6ee6d6cc


No regressions (compared to build v4.9.205)

No fixes (compared to build v4.9.205)

Ran 23412 total tests in the following environments and test suites.

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
* prep-tmp-disk
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
