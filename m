Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E264ECA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F09217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="drzNa+/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfJ1WYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:24:09 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36399 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ1WYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:24:09 -0400
Received: by mail-oi1-f195.google.com with SMTP id j7so7320580oib.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 15:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r2oZkcbSPejQY7cz80oHS9fpmT93sVGHDU0X3tx1u58=;
        b=drzNa+/Dszlh/bn18l5YMKuFsawU1IqoJickE5gJYg70HnGq1M35FAzxLHS885Xcqh
         a+575bpErnIGrxVE/hbeXohi75WuBFQtWAjN0r+P3LJDQyM7jePUOeu8MGopEUMjjH/t
         DFBj0RF+IXv1eK/hpFNw+oWywiRPpZNF1LLO7SJ71U1QqG0+1is+uXX2da0kENDk4wsq
         Jrl3k7Ia+cYxTUEYQvywZ6SgEN3jAZ78e6z4vj4RbFunhJRg7r6lxkNQ8/L0S/plVXx0
         qzrLqryUAjNcA6vYvOj/NhY3TPBll3NbICSMdNEamTD3RzWWuZ4GCDNvmKvhRwaHu7UO
         HOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r2oZkcbSPejQY7cz80oHS9fpmT93sVGHDU0X3tx1u58=;
        b=giZDg7J9vq+8jCRDc0SWqVbHfGgVX/orz8nRH8Av0b8HCN2u1Ah3ljvk6c//oXiAst
         93ofHfEPwonDi0FAJXdevnqtt0zVsPdPLiXH3zWJfY780uMdLAV3m2/0GTrDGLPk0vKJ
         dHKq/ELyto3m93K0BrWilWaMiTZY76fEdreO5QJsq11+GSfXAF5H119NWCbRNnizEDZv
         qRnou0uEo5URXDWx5Ai0tuSFULaq+tAuy0hp3h33fbWaq0ms5+55ZB7SFmPy3MHKCSbF
         112oC/2VsjZSfUrxPuL0fPfioriKtDHMk7i168KNetwSciLXRw6e+Xox0n841ruB0mNS
         5s/A==
X-Gm-Message-State: APjAAAUW1Pr1qVjyXT16QvhqZW8wSLqbPBjZABxPtjNCrj491w6FAG2d
        bT1hIG08DnENuJwZeA+RPmSPqghcmsfdv+xzk0gobg==
X-Google-Smtp-Source: APXvYqwnzz+cE9Sm5n4t9XdS6VL/NqxXZYddSpQ/iGURH0y0OzEDe7qOi50WKmaRadslXLCPhh1klrU3egyz/LefQbQ=
X-Received: by 2002:a05:6808:113:: with SMTP id b19mr1232160oie.169.1572301447788;
 Mon, 28 Oct 2019 15:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191025234834.28214-1-john.stultz@linaro.org>
 <20191025234834.28214-2-john.stultz@linaro.org> <20191028074642.GB31867@infradead.org>
 <CALAqxLXqLUpew9XptiXZGodf5M3qyNmD-D1-2CHZ9PRfPTBRRQ@mail.gmail.com>
In-Reply-To: <CALAqxLXqLUpew9XptiXZGodf5M3qyNmD-D1-2CHZ9PRfPTBRRQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 28 Oct 2019 15:23:57 -0700
Message-ID: <CALAqxLVW8KQVKwu=AY5Hkv7m9_L6djDy8h0se46MA+t_9_CCgg@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] mm: cma: Export cma symbols for cma heap as a module
To:     Christoph Hellwig <hch@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yue Hu <huyue2@yulong.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 11:39 AM John Stultz <john.stultz@linaro.org> wrote:
> On Mon, Oct 28, 2019 at 12:46 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Fri, Oct 25, 2019 at 11:48:33PM +0000, John Stultz wrote:
> > >  struct cma *dma_contiguous_default_area;
> > > +EXPORT_SYMBOL(dma_contiguous_default_area);
> >
> > Please CC the dma maintainer.  And no, you have no business using this.
>
> Sure thing. And I'll look again to see why I was needing to pull that
> one in to get it to build.

Ah. So looking a bit closer, I'm needing this due to my using
dev_get_cma_area()  to get the default cma area for the dmabuf
cma_heap.

Do you have a suggestion for how to get a reference to the default CMA
area without exporting dma_contiguous_default_area? Would it be
preferred to move dev_get_cma_area() into the .c file and
EXPORT_SYMBOL_GPL that function?

thanks
-john
