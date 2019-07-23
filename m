Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64686C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 04:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECB02229A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 04:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E311kO1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfGWEJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 00:09:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38962 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfGWEJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 00:09:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so26778883wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 21:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+AEy0A1U3bDIt426sx3FptCy+IyQIvQzzikjslkeuhc=;
        b=E311kO1pCEwMLgLW8p32jUkqQOjQ9ZoxegskYz6+JpTLlAudw1HLUYbCumdlFFhvlN
         kknZAMeF/KHxiSf9QsA6fQbR+l+hHeS1KJrxuFayMjWeUjRw/vRMm1JeHS+yFatZIVtD
         iBjLtMlVQU2dN2EOMpK58+tFiAC2ZYilQAZ70uh+1pz3Ryqb91hawquXEbV//jqi+a8v
         PetHF5ohrQ4BFuL1d4cQtT3tqa0gkhsy6nSts16PwfrMnLXOBgp+f87TyuCUbmR9CLsB
         8vUkxyOvq5Wjxf8LYsqRq78Lbadeg2mgJu1/x+x87LVeyafSxluHqsAfIBCFQm3FL0P0
         uyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+AEy0A1U3bDIt426sx3FptCy+IyQIvQzzikjslkeuhc=;
        b=TgDftPAFT25MQQHcjN0C34phwnbbgrSO/8yrhFyOAQa479sgCAzroQCpX1jt4Mslce
         WtJxyPEW4LHQ9QxpjHR3tH+YBPaR5rJFT12IpYjCP4t2vnn72dl/1/8/qNtYhudvwCd8
         9h+7kkC02rYDyQOhYHHoHLdE8jRL2yZ7UO0SVBqQ0ZHPWK1CVPUGMQ9byNCodPB61Qa0
         dLi003yUr09x6gpIl/w42EC3ODdIr1qo/bcr6iingimwFMQABxi4pMK/gBlA50eHUx32
         pixA9vRj/8kE3XbNkZUF2GNyndWDv5c/9yjyarQUOGqob4XvVrO96WEcrPr4RSmb/RNG
         u2Dg==
X-Gm-Message-State: APjAAAUrqo0d6qA8f5bOPmaAjLMWXRFty7CnemUf5QVX37+fkA0/Ji8/
        kVNKRgpRJtDbsPR3KMSDPstH1p1PAqfj8WhxktCOng==
X-Google-Smtp-Source: APXvYqwuDiAxsLbuVgRtZCmC5Njj4s+XxHj+VdwIPWtFY080q1KB1qHh/tqWkr0COKq0eaQWs5bNyFofmnAAy93Bavo=
X-Received: by 2002:a1c:dc07:: with SMTP id t7mr69039790wmg.164.1563854978031;
 Mon, 22 Jul 2019 21:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-3-john.stultz@linaro.org> <20190718100654.GA19666@infradead.org>
In-Reply-To: <20190718100654.GA19666@infradead.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 22 Jul 2019 21:09:25 -0700
Message-ID: <CALAqxLX1s4mbitE-_1s1vFPJrbrCKqpyhYoFW0V6hMEqE=eKVw@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] dma-buf: heaps: Add heap helpers
To:     Christoph Hellwig <hch@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>,
        Rob Clark <robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 3:06 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +void INIT_HEAP_HELPER_BUFFER(struct heap_helper_buffer *buffer,
> > +                          void (*free)(struct heap_helper_buffer *))
>
> Please use a lower case naming following the naming scheme for the
> rest of the file.

Yes! Apologies as this was a hold-over from when the initialization
function was an inline function in the style of
INIT_WORK/INIT_LIST_HEAD. No longer appropriate that its a function.
I'll change it.

> > +static void *dma_heap_map_kernel(struct heap_helper_buffer *buffer)
> > +{
> > +     void *vaddr;
> > +
> > +     vaddr = vmap(buffer->pages, buffer->pagecount, VM_MAP, PAGE_KERNEL);
> > +     if (!vaddr)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     return vaddr;
> > +}
>
> Unless I'm misreading the patches this is used for the same pages that
> also might be dma mapped.  In this case you need to use
> flush_kernel_vmap_range and invalidate_kernel_vmap_range in the right
> places to ensure coherency between the vmap and device view.  Please
> also document the buffer ownership, as this really can get complicated.

Forgive me I wasn't familiar with those calls, but this seems like it
would apply to all dma-buf exporters if so, and I don't see any
similar flush_kernel_vmap_range calls there (both functions are
seemingly only used by xfs, md and bio).

We do have the dma_heap_dma_buf_begin_cpu_access()/dma_heap_dma_buf_end_cpu_access()
hooks (see more on these below) which sync the buffers for each
attachment (via dma_sync_sg_for_cpu/device), and are used around cpu
access to the buffers. Are you suggesting the
flush_kernel_vmap_range() call be added to those hooks or is the
dma_sync_sg_for_* calls sufficient there?

> > +static vm_fault_t dma_heap_vm_fault(struct vm_fault *vmf)
> > +{
> > +     struct vm_area_struct *vma = vmf->vma;
> > +     struct heap_helper_buffer *buffer = vma->vm_private_data;
> > +
> > +     vmf->page = buffer->pages[vmf->pgoff];
> > +     get_page(vmf->page);
> > +
> > +     return 0;
> > +}
>
> Is there any exlusion between mmap / vmap and the device accessing
> the data?  Without that you are going to run into a lot of coherency
> problems.

This has actually been a concern of mine recently, but at the higher
dma-buf core level.  Conceptually, there is the
dma_buf_map_attachment() and dma_buf_unmap_attachment() calls drivers
use to map the buffer to an attached device, and there are the
dma_buf_begin_cpu_access() and dma_buf_end_cpu_access() calls which
are to be done when touching the cpu mapped pages.  These look like
serializing functions, but actually don't seem to have any enforcement
mechanism to exclude parallel access.

To me it seems like adding the exclusion between those operations
should be done at the dmabuf core level, and would actually be helpful
for optimizing some of the cache maintenance rules w/ dmabuf.  Does
this sound like something closer to what your suggesting, or am I
misunderstanding your point?

Again, I really appreciate the review and feedback!

Thanks so much!
-john
