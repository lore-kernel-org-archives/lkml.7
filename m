Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5952DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30780215A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mGd9NCPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfK1A2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 19:28:09 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42075 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfK1A2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 19:28:08 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so18593564lfl.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 16:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vUTSULFNkXa63hLT0LoUe/dpIVtN+osB6R0TFxVC0AA=;
        b=mGd9NCPU356ywtaPjV7VswYGYOThPIdwvUuAn4BHT8qHBcb7Y3U8V1fXZkP9cxXK4W
         SYHQ5TI9c23u1N4IwTufFcQguYP/r2Iwgsbi0/PiGjr1Ltg8YZgVS6gXDyk23npcW2xp
         8yPvJxdrx474+N5M8rKrPANKzaeJ2zC0PYv92Tzj1/SVUKLXhMzdWlCIld/ZrBENxaLm
         INyDB43cv11RsozsgvUaQkV8ps/jHcV1QmfF4cbvUrrM/XcgGLuZhLvXiaqHy5Kxv5xR
         2V8+8tw59ImN+1gAWfZejUJetvxHag8934lDCtdme+bbaNPasStNNG0Drr/1q0oD+/vw
         1TLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vUTSULFNkXa63hLT0LoUe/dpIVtN+osB6R0TFxVC0AA=;
        b=pX0pEZyWIjI02RZl/wrFuoclvsO81NSSM9rB3xN9bdPwNI+JshrAHPf4fByFxXoi/y
         0dJi1T2eaOc1kjmi6hG0dqAmii0T1r2N8o6sx9qm9je6GlfcQwzGyq2IqPoksLlJYW9q
         7hAW4A1ik95K9zdFWE5eeviBNUmZjpJtjGR5fduaBFznLYviu8EhNGxbTChScM/xiD4B
         9q5np24A83scmjXt4vD0rBKjXppS5JUEQ5qgzvjBBqoC1s5g3nVuHNiUPgjz+MoDsvSt
         BNoZbRTNNvbkyI5a/cihlytB13AW/06Y32cK7J+ZhSfQFheaAtQ87VokJD3JLriWrLCt
         KVog==
X-Gm-Message-State: APjAAAUlDpnFspDfwgwb/QrSVg3dkXgU7BCFvnnomQ00SRs2EN0vqtxB
        yeaqA6EKlGi2854c2/UysCjvVjdkgTcPOpNFmc4/Z4Cbm+M=
X-Google-Smtp-Source: APXvYqwpmb8XE+iNo9uoIQ0XJlsBc8SUSwa3YkH4q38p/AEKg+F7GraOPtYQYZbXWwISunA3LNtNKapmNqvCztk/N88=
X-Received: by 2002:ac2:4102:: with SMTP id b2mr30863468lfi.16.1574900886440;
 Wed, 27 Nov 2019 16:28:06 -0800 (PST)
MIME-Version: 1.0
References: <20191127203114.766709977@linuxfoundation.org>
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Wed, 27 Nov 2019 18:27:55 -0600
Message-ID: <CAEUSe7_KTY_06epzsXW0LFLVASOiLaFb0ZgRg+4bE2kjQXnEZA@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/306] 4.19.87-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org,
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

Hello!


On Wed, 27 Nov 2019 at 14:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.19.87 release.
> There are 306 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 29 Nov 2019 20:18:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.87-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

We're seeing this build failure on 4.19 (and 4.14) on x86 32-bits:
> In file included from /srv/oe/build/tmp-lkft-glibc/work-shared/intel-core=
2-32/kernel-source/include/linux/export.h:45:0,
>                  from /srv/oe/build/tmp-lkft-glibc/work-shared/intel-core=
2-32/kernel-source/include/linux/linkage.h:7,
>                  from /srv/oe/build/tmp-lkft-glibc/work-shared/intel-core=
2-32/kernel-source/include/linux/preempt.h:10,
>                  from /srv/oe/build/tmp-lkft-glibc/work-shared/intel-core=
2-32/kernel-source/include/linux/spinlock.h:51,
>                  from /srv/oe/build/tmp-lkft-glibc/work-shared/intel-core=
2-32/kernel-source/arch/x86/mm/cpu_entry_area.c:3:
> In function 'setup_cpu_entry_area_ptes',
>     inlined from 'setup_cpu_entry_areas' at /srv/oe/build/tmp-lkft-glibc/=
work-shared/intel-core2-32/kernel-source/arch/x86/mm/cpu_entry_area.c:209:2=
:
> /srv/oe/build/tmp-lkft-glibc/work-shared/intel-core2-32/kernel-source/inc=
lude/linux/compiler.h:348:38: error: call to '__compiletime_assert_192' dec=
lared with attribute error: BUILD_BUG_ON failed: (CPU_ENTRY_AREA_PAGES+1)*P=
AGE_SIZE !=3D CPU_ENTRY_AREA_MAP_SIZE
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                       ^
> /srv/oe/build/tmp-lkft-glibc/work-shared/intel-core2-32/kernel-source/inc=
lude/linux/compiler.h:329:4: note: in definition of macro '__compiletime_as=
sert'
>     prefix ## suffix();    \
>     ^~~~~~
> /srv/oe/build/tmp-lkft-glibc/work-shared/intel-core2-32/kernel-source/inc=
lude/linux/compiler.h:348:2: note: in expansion of macro '_compiletime_asse=
rt'
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>   ^~~~~~~~~~~~~~~~~~~
> /srv/oe/build/tmp-lkft-glibc/work-shared/intel-core2-32/kernel-source/inc=
lude/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_asse=
rt'
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                      ^~~~~~~~~~~~~~~~~~
> /srv/oe/build/tmp-lkft-glibc/work-shared/intel-core2-32/kernel-source/inc=
lude/linux/build_bug.h:69:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>   BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>   ^~~~~~~~~~~~~~~~
> /srv/oe/build/tmp-lkft-glibc/work-shared/intel-core2-32/kernel-source/arc=
h/x86/mm/cpu_entry_area.c:192:2: note: in expansion of macro 'BUILD_BUG_ON'
>   BUILD_BUG_ON((CPU_ENTRY_AREA_PAGES+1)*PAGE_SIZE !=3D CPU_ENTRY_AREA_MAP=
_SIZE);
>   ^~~~~~~~~~~~

Bisection points to "x86/cpu_entry_area: Add guard page for entry
stack on 32bit" (e50622b4a1, also present in 4.14.y as 880a98c339).

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
