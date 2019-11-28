Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E664C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 06:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3146215E5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 06:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lIw46c8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfK1GVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 01:21:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37929 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfK1GVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 01:21:51 -0500
Received: by mail-lj1-f194.google.com with SMTP id k8so16605449ljh.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 22:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jGpGxpC/wXWKh1C0/wBKFzSJF3Qe61l1DK5ccrhGvrI=;
        b=lIw46c8sEh+S5n6n9HdGJrBBIpXd62YZNYBvqi/xV0hgqMHG2ExA4L1LozZoBPLa5y
         dK8FNwPTwQS+PHs5WDKS3GZqDr5gNrtZg5G5kGBXbM9HdpFKq8OSx5VePntx4OBLqvCX
         4NTtN1ApKyuFqki2PDWnrdTjjuZlzkiDUd7eWWSPfeBTJlye6er3Oac3o/fyNSgn5KF7
         YAZEENqdcAcSEv6dzSWrH3qWRN1P6LGoMXLYbf4iNnpQe8itknFJX6yu3qVzew4Kll3i
         J8qwqAdRGHEiF3qYrfS3pG7NDpoSVJgzsrSA1nF9AaFAl0gWcpRNnwiFW9e0cFTV1rT5
         Dnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGpGxpC/wXWKh1C0/wBKFzSJF3Qe61l1DK5ccrhGvrI=;
        b=ou3SplMe4bseL/3ixPlTr+hWUxjpsOH5V7jJ3fMeq+NC8MnPKqhSaUzqvPIL6kwu1d
         MOtwVRsODslbRj8vy534OgZyFL0FMC987kVZrbf2iClNycyXLJQGWNywymY5QiY3Kmvx
         chL66brToMTA+6FwCQZ39wUKCjSbgyLpJ4LYll0pXPrBhdnWleE0TdYyPqzwtP+2q3Mz
         1BohXZKYNjna976R1v2fnjNyc8AmYxhwAhuPGCAQrwl2YbxYpjzMR0kj7NyLBfg7QNLc
         fpxe/gUEzb/HVG82agw/4c7IIWxSjvixtKuDw49PeBNux5MHebCWqqpmak0p4Z0jsfSK
         /Yig==
X-Gm-Message-State: APjAAAXROuWCU+aWX1JyaVf3j48Xu2QWb/3xYh8KJTrL7HPd0LpX8R5w
        LK7ob+523oFHDl8UoHYvwDbHcYpG5qhl4NpT4IT1eg==
X-Google-Smtp-Source: APXvYqwkoBIjjv7fpkao3bfuld82KnBgOsLVb6dusFS/gVBJO4fpnHDQPkBAT7sgWsM/Xvw4Z8BfHvWbRuT42v6C1JM=
X-Received: by 2002:a2e:7202:: with SMTP id n2mr29985958ljc.194.1574922108978;
 Wed, 27 Nov 2019 22:21:48 -0800 (PST)
MIME-Version: 1.0
References: <20191127203049.431810767@linuxfoundation.org> <CA+G9fYtFNKTYiqm0Bvk_nqBTjsRMKTtNxr6PhE8YaDXFjqwhYQ@mail.gmail.com>
In-Reply-To: <CA+G9fYtFNKTYiqm0Bvk_nqBTjsRMKTtNxr6PhE8YaDXFjqwhYQ@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 28 Nov 2019 11:51:37 +0530
Message-ID: <CA+G9fYsuM-ALP_EtoFEzJiia26QnUvuKWsH0b-vi43Sp++es6A@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/211] 4.14.157-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        jouni.hogander@unikie.com, "David S. Miller" <davem@davemloft.net>,
        lukas.bulwahn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Kernel BUG noticed on x86_64 device while booting 4.14.157-rc1 kernel.


The problematic patch is,
>> Jouni Hogander <jouni.hogander@unikie.com>
>>    net-sysfs: Fix reference count leak in rx|netdev_queue_add_kobject

And this kernel panic is been fixed by below patch,

commit 48a322b6f9965b2f1e4ce81af972f0e287b07ed0
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Nov 20 19:19:07 2019 -0800

    net-sysfs: fix netdev_queue_add_kobject() breakage

    kobject_put() should only be called in error path.

    Fixes: b8eb718348b8 ("net-sysfs: Fix reference count leak in
rx|netdev_queue_add_kobject")
    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Cc: Jouni Hogander <jouni.hogander@unikie.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>



> Regressions (compared to build v4.14.156)
>
> [    2.777657] BUG: unable to handle kernel NULL pointer dereference
> at 0000000000000090
> [    2.785487] IP: kernfs_find_ns+0x18/0xf0
> [    2.789408] PGD 0 P4D 0
> [    2.791941] Oops: 0000 [#1] SMP PTI
> [    2.795424] Modules linked in:
> [    2.798474] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.14.157-rc1 #1
> [    2.804906] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.2 05/23/2018
> [    2.812288] task: ffff8e09ee250000 task.stack: ffffa0f900028000
> [    2.818200] RIP: 0010:kernfs_find_ns+0x18/0xf0

<trim>

> [    3.108995] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x00000009
> [    3.108995]
> [    3.118161] Kernel Offset: 0x1c400000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>
> Full test log,
> https://lkft.validation.linaro.org/scheduler/job/1026224#L793
>

--
Linaro LKFT
https://lkft.linaro.org
