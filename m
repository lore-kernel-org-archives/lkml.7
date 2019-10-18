Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120CACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC83C2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCSqmO2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502949AbfJRS1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:27:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46602 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502485AbfJRS1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:27:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so7219481wrv.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lO2StNiS2UHCj8+9SsvqSbVKFte3Dujsk2JYdGhstd0=;
        b=mCSqmO2XSWm/BFp+YC0O5sy6vJ4J9PotAhn5xpwkgbLUAOKLOjfiuMwaNP4IM5w77D
         1S15TG8+HjOpw2soOliWnJE23GXyYl2TXYvWNZArL9GbV9beblrMKFHKZdicosRbE4fq
         yp47axUjsA6baFIHyOPPi3/rWce8BrLV6v0ZzfuMzwDU7prEK6y90itiERMCUMZV/lMu
         m9sJHdbbrS7aaHwvAfm2Uk4/Y36IHrBd+TkMqVp8Kgr9XjSui6C2usRZeEb1khK3depA
         U8LSiLkppE1IwqCCKIY5Nt4HDOBkjfuqMc4CQnwdfb+Grr1qOSqeYO3yF2hjUZY/LLGH
         TFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lO2StNiS2UHCj8+9SsvqSbVKFte3Dujsk2JYdGhstd0=;
        b=Yfj/kkZXH4tIxu8rwwx1aSnupf38Rl/6Jy4p73fybz7jTtxE9x4KyAaT0MWJqM1iXj
         BsJ5DhUXiKHCs1+xoktxYCcq29L6HlPmqDTL6aQ/Vc9P3qXGF28gsAw1UcExSGjvXXiX
         YbCjGEiGNdl+3EtZ5DO0lvqw//5UOsriHrlpszeZRHEPaXhHUmAXWN2M4Dm+6c2Q4avt
         Jc/TrzVpI5pKwYUFt0uyqB02G9XLfdDczNJbVDqISZWg/e+Xk/1LqFpEycgliTIfP1EA
         DV0/NIigViaDCB5T8f4lBop3H9H4Np0Yn3kp3LWZsntJPiT8a+Rvxwm5mOtP4iPHxuZB
         T6Sw==
X-Gm-Message-State: APjAAAU3/dJAjlzTBxCkOr/Er7f8C9QZrefbOlOdWhzRU1794p1IN35v
        QgIOc1ku+ZoZJ3GxCbPYOhHZBBqhwlmYub7WuQO5pg==
X-Google-Smtp-Source: APXvYqy02V7JvYjspbL2KqGV67KwG+Nwl8JcMdFE4sjvajWRC5F41fOItfkNZW2vQ9MumjE8aMqtnrumrcIePCpePlw=
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr9338121wrr.50.1571423224434;
 Fri, 18 Oct 2019 11:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191018052323.21659-1-john.stultz@linaro.org>
 <20191018052323.21659-2-john.stultz@linaro.org> <20191018111832.o7wx3x54jm3ic6cq@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20191018111832.o7wx3x54jm3ic6cq@DESKTOP-E1NTVVP.localdomain>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 18 Oct 2019 11:26:52 -0700
Message-ID: <CALAqxLUVLP0ujB0SHyWHMncRMHkBvVj1+CpBgGUD8Xg3RexQ8w@mail.gmail.com>
Subject: Re: [PATCH v12 1/5] dma-buf: Add dma-buf heaps framework
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 4:18 AM Brian Starkey <Brian.Starkey@arm.com> wrote:
> On Fri, Oct 18, 2019 at 05:23:19AM +0000, John Stultz wrote:
>
> As in v3:
>
>  * Avoid EXPORT_SYMBOL until we finalize modules (suggested by
>    Brian)

Heh. I guess it has been awhile.  :)

> Did something change in that regard? I still think letting modules
> register heaps without a way to remove them is a recipe for issues.

So yea, in recent months, work around Android with their GKI effort
has made it necessary for ION heaps to be loadable from modules. I had
some patches in WIP tree to enable this, and in the rework I did
yesterday for the CMA module trivially collided with parts, and
forgetting the discussion back in v3, I figured I'd just fold those
bits in before I resubmitted for v12.

If it's an issue, I can pull it out, but I'm going to be submitting
module enablement for review as soon as the core bits are queued, as
its going to be important to support for Android to switch to this
from ION.

thanks
-john
