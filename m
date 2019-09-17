Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891B0C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A8F206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Hn+RD0jb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfIQP2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:28:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:58067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfIQP2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568734087;
        bh=xOABybTvLNTgC0pVDHyPN0REpqj9J8uMvgXkOvpgudQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Hn+RD0jbzGu2VW+GjRxUpQ0Zq6qnDU7J4sw6yht8+HWu8+J0zdXuNayZXvYdXJ89F
         rKb1U1K+H6heTT7B4uvvKrind1HBKQC8Dicp4mOoBRHxaMdBmdSA2tEvV52qJOhKWR
         6CdtIfbysRFmvJrWJuW4nnEe91MNrYkKkDbWwuh0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.10.6] ([109.40.64.60]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lb4vZ-1hm8re0DpR-00kiqg; Tue, 17
 Sep 2019 17:28:07 +0200
Subject: Re: threads-max observe limits
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20190917100350.GB1872@dhcp22.suse.cz>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=xypron.glpk@gmx.de; keydata=
 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 Eg==
Message-ID: <38349607-b09c-fa61-ccbb-20bee9f282a3@gmx.de>
Date:   Tue, 17 Sep 2019 17:28:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917100350.GB1872@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rAfndEla5Ut5QhzYl7qlm4XCsBLLgDUqsaroSUXubEkg8ARNLxV
 c04KaMm3lBRTofO9qBsmMBvvg3gJay4RV/3desA8h1nNicDFqaglVFfNwpksBgoN4wjEhic
 1QbYpQ32fvz+BxpdayANy8u9m96m16eEAecy/hbqN9UoGD7kmhmJk5CgNLY/KtZdfaZTHA2
 iELfhj7IqANEpOsEVyPBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gIAZ/BtZXxQ=:DjfCXpOomMtKXCymQWQJa8
 kEMtp8DFbq5UOhqJVPMS/7ak4wYt3ZBTh57KIIXEjV9vyhkx5/8duw/tL+9cGrSymEt9TscqZ
 GIJJhnLgnjN9tJH3umHXh8ZTm2l1TLMXn9JVFthw4z8tl7xU5QtyZfW29/2JEbQ3Lr5EUSjpy
 HsV1kJP9J5I0323rAin06MDMgE4fbOfEWDG6Y2Hwk56k6He/p+a70+YaB5Z6HbYqk1ctgK4Yc
 6BvrkaQtH1F9MEXJVWCEWuXwd39cnY32peTg2UU78Cqsc94w8AHTGzGF/gHV5s1iGoDh2M6q1
 8GjD9TguJEaECbOWCrx+aJjR3gsgVLnwnTTOic9cWwBxmMNCdp9jdOe6mQ5/MrwVWqn0gi8fx
 34WXRodZGQ5EhU0afA4Aq6i2OpessZRyN0x0cF9crZzZQKViZm0W0jWhoYz28P9Zhvk5RSPr5
 GI4KuptZWdYllA/VLBhM1bl9zNwnGkoptKkdFWp5q9zQ2sHWGw2MviwMzNZSyOhwMmycXrr1J
 VKKLIPnfaKIGDAa+VtniNK0R1JkJUTqzrHOal+7SlVgHHru5prJbwbBkKRyqq6hL8YuESAeEV
 y6SJHuvfpeiTnn8Awcm7pJ6moaTFUwstyxuQ3zFgfMQZzR9Fgl1zVnHv1e9mBiwceUvwsZdHq
 9i2G6I31aS4yF//fB+pdx/H8zjk/QK52mml6TPAvE+yuzF873LwHCsz1M0K8wHmbXmh0NtNdd
 akMYVm1/Jz0q93M8UNC4Ng2ngcNO/Vi/aq4NK9nn+Br0rt02iz1wk8hmfdR08xdMlOu3N8cLh
 cEyHndH9UT4CIKgRJqTuI8ll9ij3tkemQ64NTThE4J+O6C4X9oJDPZr3K8FNeKtq5Wm1O16WC
 AB2yJRlk0iDQZCuOpiSqIytYSrnclvTk2zK+4THdCJnLxLU2vXTB5LsmDWFFrMvShXC7XIQ1T
 UQC+DQSXAIOqtBZn+l0BevAVau8QvEObxZxx89mYMkGgrwSEduaIyExS7Khmpz1vVIRdyO4/4
 xDQYqS5NXI8MdMa7PD+aQMil6FwSRBeLzxooPfDXnbuBv9gQm1u6OmWkdg2mTXUlb7LJnmYTK
 rRqGMAbMPlvkjWCoUUUw58OqXN8Ls7iUkD4jr9oDE57vwOBYsItVzM+oCQiGLfcxHM2mcXzlc
 OM0lBgdAlGVkWWbStsy36TKQIeicN/rw9IJ7yWZD/6780oSj3XpL3qP3lxpuMDiK4lwY5l4BD
 T56HWytV/mPlXb8vVMLJiSwB8uH0CH5QJPXcl2S37MENlT8/zgQPLFNb6lmI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/17/19 12:03 PM, Michal Hocko wrote:
> Hi,
> I have just stumbled over 16db3d3f1170 ("kernel/sysctl.c: threads-max
> observe limits") and I am really wondering what is the motivation behind
> the patch. We've had a customer noticing the threads_max autoscaling
> differences btween 3.12 and 4.4 kernels and wanted to override the auto
> tuning from the userspace, just to find out that this is not possible.

set_max_threads() sets the upper limit (max_threads_suggested) for
threads such that at a maximum 1/8th of the total memory can be occupied
by the thread's administrative data (of size THREADS_SIZE). On my 32 GiB
system this results in 254313 threads.

With patch 16db3d3f1170 ("kernel/sysctl.c: threads-max observe limits")
a user cannot set an arbitrarily high number for
/proc/sys/kernel/threads-max which could lead to a system stalling
because the thread headers occupy all the memory.

When developing the patch I remarked that on a system where memory is
installed dynamically it might be a good idea to recalculate this limit.
If you have a system that boots with let's say 8 GiB and than
dynamically installs a few TiB of RAM this might make sense. But such a
dynamic update of thread_max_suggested was left out for the sake of
simplicity.

Anyway if more than 100,000 threads are used on a system, I would wonder
if the software should not be changed to use thread-pools instead.

Best regards

Heinrich

>
> Why do we override user admin like that? I find it quite dubious to be
> honest. Especially when the auto-tunning is just a very rough estimation
> and it seems quite arbitrary.
>
> Thanks
>
