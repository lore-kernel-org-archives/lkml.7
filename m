Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9955CCA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6964B21D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BrDaV6e5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfKDJ62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:58:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46252 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfKDJ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 04:58:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id b3so10485176wrs.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 01:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=A8BaA51G7E0NuLYNihqbtlcJ9Y7+alqjRVepHAHLBmg=;
        b=BrDaV6e5i5vscg0RZjArHGnp85vXI7HBidGVQU4XfDed1jBLLwtq23rl+r4djHdbmw
         gZN2uH9rjlKhnmL5BpM01A3Qno/GirFRekFQv++FCnS1HIiPBKCmAbhs5VCkpY5cpZVN
         4txXYq7R/2TyJy5kVThviy6eA+MRQyCmeiqkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=A8BaA51G7E0NuLYNihqbtlcJ9Y7+alqjRVepHAHLBmg=;
        b=mqUjJFDzoFFtpn6IBGSnX5FDg0oybW7HZ2HkC49WzycURZjFWiXIFnU16D1mUtabKm
         zXA+IjMevz7YKUfVwyzfHDTclXVyVY3iImfGMxX5dZlWBEFBNy5cPuU0KIIDgdD7dOZ+
         LzYG3rKG0RqHDPN/UPUdUPiXewA2AYo9brN+JjZv3VpX0qbZXBAUA5uoEY4Zq9PcFoyH
         9q1rskIwAqkzuHghCXfTVSUKWSI7l7cwVywMeQlcR1F7DNR+1pP9jhaMeEJ+9KADA0m8
         ngew8c6xCqkbcjGTNpsr5wQG9TVXzE+DLbzf/qey2EBSfrO3vLqBx7yiqVJVE2JEDOrs
         Z/gA==
X-Gm-Message-State: APjAAAXYEcznmuHcBl30/Hpb9rtJfYzXk6QGPlKxPyblVSdmZh6owMTT
        utqbbvN9bm2/9VWHiMeIsHsdDw==
X-Google-Smtp-Source: APXvYqx9gMlx/nBYQFJiLnGM9utCwN2hlK4THSUfl6NdFdMdlr5+BJ1KBbr5s2fd9PdJySs05lgvLw==
X-Received: by 2002:a5d:5587:: with SMTP id i7mr22853426wrv.289.1572861506141;
        Mon, 04 Nov 2019 01:58:26 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id f8sm15010707wmb.37.2019.11.04.01.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 01:58:25 -0800 (PST)
Date:   Mon, 4 Nov 2019 10:58:23 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>, Yue Hu <huyue2@yulong.com>,
        dri-devel@lists.freedesktop.org, "Andrew F . Davis" <afd@ti.com>,
        Hridya Valsaraju <hridya@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pratik Patel <pratikp@codeaurora.org>
Subject: Re: [RFC][PATCH 0/2] Allow DMA BUF heaps to be loaded as modules
Message-ID: <20191104095823.GD10326@phenom.ffwll.local>
Mail-Followup-To: John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>, Yue Hu <huyue2@yulong.com>,
        dri-devel@lists.freedesktop.org, "Andrew F . Davis" <afd@ti.com>,
        Hridya Valsaraju <hridya@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pratik Patel <pratikp@codeaurora.org>
References: <20191025234834.28214-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025234834.28214-1-john.stultz@linaro.org>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:48:32PM +0000, John Stultz wrote:
> Now that the DMA BUF heaps core code has been queued, I wanted
> to send out some of the pending changes that I've been working
> on.
> 
> For use with Android and their GKI effort, it is desired that
> DMA BUF heaps are able to be loaded as modules. This is required
> for migrating vendors off of ION which was also recently changed
> to support modules.
> 
> So this patch series simply provides the necessary exported
> symbols and allows the system and CMA drivers to be built
> as modules.
> 
> Due to the fact that dmabuf's allocated from a heap may
> be in use for quite some time, there isn't a way to safely
> unload the driver once it has been loaded. Thus these
> drivers do no implement module_exit() functions and will
> show up in lsmod as "[permanent]"
> 
> Feedback and thoughts on this would be greatly appreciated!

Do we actually want this?

I figured if we just state that vendors should set up all the right
dma-buf heaps in dt, is that not enough?

Exporting symbols for no real in-tree users feels fishy.
-Daniel

> 
> thanks
> -john
> 
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Pratik Patel <pratikp@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yue Hu <huyue2@yulong.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: dri-devel@lists.freedesktop.org
> 
> John Stultz (1):
>   dma-buf: heaps: Allow system & cma heaps to be configured as a modules
> 
> Sandeep Patil (1):
>   mm: cma: Export cma symbols for cma heap as a module
> 
>  drivers/dma-buf/dma-heap.c           | 2 ++
>  drivers/dma-buf/heaps/Kconfig        | 4 ++--
>  drivers/dma-buf/heaps/heap-helpers.c | 2 ++
>  kernel/dma/contiguous.c              | 1 +
>  mm/cma.c                             | 5 +++++
>  5 files changed, 12 insertions(+), 2 deletions(-)
> 
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
