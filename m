Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB6CC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10232073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D1JWQWqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfLDTL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:11:56 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36236 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfLDTLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:11:55 -0500
Received: by mail-lf1-f67.google.com with SMTP id n12so458017lfe.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 11:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JYuqMASZpiTe5nuiGY93MH6O0/HdXIaFU15wVqM7e9k=;
        b=D1JWQWqNFljOCLqlZW2gu9wWPuOlND9c9MnAhvPP3jVIFgam6A39PXzihi8Qt4VTqm
         hTeuKHG81pakLfV7aqlfciEBXe+6dAcFC8VoTOmzBMXQs/LtT/J3CJwxuSifLa3oaw+x
         pB3w9G5bQQWuxY8rARr8pNP8mqx+REMLTQ+8QSU5OtyJPolDrG7f2VHVoMmZpJ5aG9I6
         OnufAoPZpyhc860plE3xH0M5g/Ew/zpoaAadgonQOFHgE3vP2J6CGrJdCdMk7d4V68x+
         K+SeACmxrIwenNfvHI0oz0jqBnp0UEuj/J2BvDtntY6E0WSAzJVwxeadvdC19gmlzq71
         pj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JYuqMASZpiTe5nuiGY93MH6O0/HdXIaFU15wVqM7e9k=;
        b=lOMVk+wH8BfIfaN1x644eiQfKmd3YIHRbarNVQRW/q6xcpCaDovna/1JaH5rMnLejD
         8/Rc6YMkwLHSbs10ubcY/KAIgVKQOW3FiMZwitV8qz0v6zONVvqA+mCSPdC9u4MTxBPn
         dt2qvpzQ80gJAnT6rSPZP6Gmb7OHGUqWTR1DYG3NYYvcG08v7joxQEBlY86erqtqvWw2
         E9IETGo9JPohp5X9kCCaeRpHZ40O1LRFxd5wBKbqmq1aVwjyOZY8VgLzdPoBdNQb9xQm
         /ja4FFEtmsS1BHEVkypkOtDypQV9lrXB3DZDFOYbfqKkxuw1e7Wlx75+LsPutmMiYDWA
         qXqw==
X-Gm-Message-State: APjAAAUf+GPSJaXb0lzsQLqKC3/VfeayFL0jWWxjgn2lHZAEiKrmkvSC
        Xw55kRITzBAKZ9twm4MfJQV50sCfq4AJEZN5i8F1PA==
X-Google-Smtp-Source: APXvYqw9yp5+BS+JOuXjIZQucnuG7GqzCi20RPTauPFIxq2vEXvlXKZihUVuZuEM4l35uFfuGxig6bYiTWk4oeHdWjg=
X-Received: by 2002:a19:5057:: with SMTP id z23mr3018046lfj.132.1575486713192;
 Wed, 04 Dec 2019 11:11:53 -0800 (PST)
MIME-Version: 1.0
References: <20191203223427.103571230@linuxfoundation.org> <79c636e7-145b-3062-04a3-f03c78d51318@nvidia.com>
 <20191204112936.GA3565947@kroah.com>
In-Reply-To: <20191204112936.GA3565947@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 5 Dec 2019 00:41:41 +0530
Message-ID: <CA+G9fYtba3Hhd7QikcWSEjYK0mwGBNuaXctnO5f1COsRP7qkSw@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/321] 4.19.88-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for letting me know, I'll go drop this one and push out a -rc2
> with that removed.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.88-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: ba731ec12c667db0f1f85e4bfe11387587feb243
git describe: v4.19.87-322-gba731ec12c66
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.87-322-gba731ec12c66


No regressions (compared to build v4.19.87)

No fixes (compared to build v4.19.87)

Ran 21276 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* build
* kvm-unit-tests
* libhugetlbfs
* linux-log-parser
* ltp-containers-tests
* ltp-commands-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-sched-tests
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* perf
* v4l2-compliance

--=20
Linaro LKFT
https://lkft.linaro.org
