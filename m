Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FC6CA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C5520684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FEpZaar+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408183AbfJXCVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 22:21:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37256 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406401AbfJXCVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:21:36 -0400
Received: by mail-io1-f66.google.com with SMTP id 1so16191150iou.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 19:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=CEeGqPLdVUFK4E06K5s/BvyTM+3EASX/NmNd4HF1T9E=;
        b=FEpZaar+jSSTBS+hrgkAzEdE7BMeFjNOy7oYHopbJI4TEaEwSQiVvXb05T/RKJ9NAf
         p0DSaxCHcZSKsbL5eMt0ItoZiNMkIeBqdgPKRfAmYGU0ie/ll6LUH6Qpzuna7qFpZgQ9
         T2gV73fh+v1aiuzlYjqVH7WpTOK1/wTt7D7ZgN0sYV8taQXpYYPLetjaOvp1E8e/7AOE
         TBhQqXzFaMaqPFOXpJO2ViujCYdHgytLpWdKPIidgQdAYQuGMaOLgIKGFuJ3q/fRzef8
         Yt8Fuuefw5LEJVvYiCzwqVeUqpz/Zxt9rAXuRBBG4KJxV1g8Jqtl5EaF7x98qiFBtuDX
         xArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=CEeGqPLdVUFK4E06K5s/BvyTM+3EASX/NmNd4HF1T9E=;
        b=VzsH8v8icsAA0BjV4BzWwqF0f/BqZoXoGNY3Y00AjEQYhmdjkQDVHpUSmms3xxm5YD
         nBeOJU+VmHR99yTy+cyOrHuvoOOlHqU6goP9tV7zEcM7xutiPB7LDC8hPOkEa9k54xDu
         WbM21d/VUXe+RwB68dMXWFDpB3jhDG+hthTzwvACcHvjGGn0mplYZGqDkA9kBZwZ7CgT
         8k+9hIjk9meIJ35C00iw0cZqLxavUcIxM3PkiVFa+Cs/MuCqxMmAvmtU3IELk6Gbz/LH
         heO9tabGPwPpBeK5h7LKK+ut3BqiQ+Dfet++5s+DAM/jGNNzBtp0+9pkQW6VClTtekUe
         qHuw==
X-Gm-Message-State: APjAAAXd1H7CCmze1JsF1QGq6Dzbf4J/ZxjUZfNPXT5f3OVqSS/GmfpW
        x12kz1R3uHNDCEcohzBeMxjFqg==
X-Google-Smtp-Source: APXvYqx71s63VEhqiPVPbIhY1cTYRrDBWEpf69L+HML/ZjJbZ6FsqUB3r7FRKD5BfxOr14jh7bZ51g==
X-Received: by 2002:a02:741a:: with SMTP id o26mr12718541jac.48.1571883694883;
        Wed, 23 Oct 2019 19:21:34 -0700 (PDT)
Received: from localhost (67-0-11-246.albq.qwest.net. [67.0.11.246])
        by smtp.gmail.com with ESMTPSA id 133sm6324555ila.25.2019.10.23.19.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 19:21:34 -0700 (PDT)
Date:   Wed, 23 Oct 2019 19:21:32 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alan Mikhak <alan.mikhak@sifive.com>
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] irqchip: Skip contexts other supervisor in plic_init()
In-Reply-To: <CABEDWGzeTLk7POWUkU1vJfyxGwjzOzWK-1_RAq7rR1wRh5hTFg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1910231917340.2470@viisi.sifive.com>
References: <1571847755-20388-1-git-send-email-alan.mikhak@sifive.com> <alpine.DEB.2.21.9999.1910231152580.16536@viisi.sifive.com> <CABEDWGzeTLk7POWUkU1vJfyxGwjzOzWK-1_RAq7rR1wRh5hTFg@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019, Alan Mikhak wrote:

> On Wed, Oct 23, 2019 at 11:54 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> > On Wed, 23 Oct 2019, Alan Mikhak wrote:
> >
> > > Modify plic_init() to skip .dts interrupt contexts other
> > > than supervisor external interrupt.
> >
> > Might be good to explain the motivation here.
> 
> The .dts entry for plic may specify multiple interrupt contexts. For example,
> it may assign two entries IRQ_M_EXT and IRQ_S_EXT, in that order, to
> the same interrupt controller. This patch modifies plic_init() to skip the
> IRQ_M_EXT context since IRQ_S_EXT is currently the only supported
> context.
> 
> If IRQ_M_EXT is not skipped, plic_init() will report "handler already
> present for context" when it comes across the IRQ_S_EXT context
> in the next iteration of its loop.
> 
> Without this patch, .dts would have to be edited to replace the
> value of IRQ_M_EXT with -1 for it to be skipped.
> 
> I will add the above explanation in a v2 patch description, if it
> sounds reasonable.

Thanks, that explanation sounds good; and sounds like Christoph will 
flow with this change as well.  So with the description expanded as 
you plan to, feel free to add an

Acked-by: Paul Walmsley <paul.walmsley@sifive.com> # arch/riscv 


- Paul
