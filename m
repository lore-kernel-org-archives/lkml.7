Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E79C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11882073D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ufuXmQiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfLLSds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:33:48 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47048 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730291AbfLLSds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:33:48 -0500
Received: by mail-ot1-f66.google.com with SMTP id g18so2938987otj.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 10:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2JEzjDTXigw8nTAlF070YiTxXmoqt0fiFaSaJYbD0m0=;
        b=ufuXmQiynKIhlryP/nAuUMz1QU6Dn2EbSsneTbWxFV91i8ZR8GVxkgzVfIhq68Om8y
         hZaMhuc6jD81PgDVsrdWfixKWiTEuKjXPE/5CHJaZUWxSV7jkCMMGPXZf4hIFze5QZkO
         Fe3pjnG9MZcRSiXX4h03BqXwfQg5esIhN7SCPPU15/RLVn6EdXc6q2IYbirqdEBqqtoV
         1X9u1y1J9sUpVlXTASC3w8oWerK5SQ+bzRCcq3/3Y5XHac6VuhEuHceHyOxTc4prEj7a
         WAjtXFAQLlSYUigoSI+ks/o15KvvRt2eFWxG1vFmFAoGlg7coj4s4E6cU8GcoMDRCYBm
         fl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2JEzjDTXigw8nTAlF070YiTxXmoqt0fiFaSaJYbD0m0=;
        b=PzhIWBf/+wh4xPbYgfjLBu44VvMQ4UYE0J8sFU1FTqgcVQyPoAZy3ovPXDLS75Q3jH
         /DPVQwlm3EKFj/KevC/QCNKm9QaSy/AYRpITYfSZVmwCJ8IrtZpMpR3eckJlALKWaQdB
         /iu68BAPrqgHMMb7SeCB+iLvtgUu2CGr3IQ6MgjdlwwI1lGC0IALsKiAdCgm08vEgKbR
         CrEvexR+L4v2rBOJGHTWXMB4msvxzMxiXaaGa+8CpFJl7R1/w/N1yireLzDlhSSNPeYb
         zhmye5huydhLraXE30WOJEAbI8vLCJri6tAqNCho3BBdtMV30C1pekSm4EHAH7u9OZ4J
         QN6w==
X-Gm-Message-State: APjAAAUY7WnAmbZ7/LYYLBEjFslGjQw3WFBZXiKHQvdaLJU2oShiQx4g
        fzM/1Q/1Wwu6RKyKIrkbklUzoBOftgpb8A/lxq059A==
X-Google-Smtp-Source: APXvYqweGtmWP/9RDwqqztjyBmVQhQCTFC0RrVREpzH+hWNkdDn380L8OObmNOa7PFyEM3JGNhguvUUT5fLg37ssxCk=
X-Received: by 2002:a05:6830:1097:: with SMTP id y23mr9499165oto.332.1576175627329;
 Thu, 12 Dec 2019 10:33:47 -0800 (PST)
MIME-Version: 1.0
References: <20191203172641.66642-1-john.stultz@linaro.org>
 <20191203172641.66642-2-john.stultz@linaro.org> <b3e979ab-0c95-4e16-6399-9bed09e08a7b@ti.com>
In-Reply-To: <b3e979ab-0c95-4e16-6399-9bed09e08a7b@ti.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 12 Dec 2019 10:33:36 -0800
Message-ID: <CALAqxLV5XwrJU2psx_ALFK1q9ZTaLTGRD9dgQhGQ5v=ojfyE+w@mail.gmail.com>
Subject: Re: [RESEND][PATCH v16 1/5] dma-buf: Add dma-buf heaps framework
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 8:52 AM Andrew F. Davis <afd@ti.com> wrote:
> On 12/3/19 12:26 PM, John Stultz wrote:
> > +#define DMA_HEAP_IOC_MAGIC           'H'
> > +
> > +/**
> > + * DOC: DMA_HEAP_IOC_ALLOC - allocate memory from pool
> > + *
> > + * Takes a dma_heap_allocation_data struct and returns it with the fd field
> > + * populated with the dmabuf handle of the allocation.
> > + */
> > +#define DMA_HEAP_IOC_ALLOC   _IOWR(DMA_HEAP_IOC_MAGIC, 0x0,\
> > +                                   struct dma_heap_allocation_data)
> > +
>
> <subsytem>_IOC_
>
> Seems more common for the internal numberings and such, what the user
> calls is more often (espesially in DRM and DMA_BUF):
>
> <subsytem>_IOCTL_<function>
>
> This is really just another naming nit but becouse this one really *is*
> ABI then getting our prefrence right is a must, up to you here.

So yea, Sumit has already pulled these into drm-misc-next, so this
feedback is just a few days too late.

But it's not a bad suggestion, so if you want to submit a tack-on
patch to drm-misc-next I suspect we can, try to pull it in.

thanks
-john
