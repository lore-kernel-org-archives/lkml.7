Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA445CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 05:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67F9222CC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 05:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2ArurjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfJSFh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 01:37:59 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34081 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfJSFh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 01:37:59 -0400
Received: by mail-ot1-f65.google.com with SMTP id m19so6815809otp.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 22:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZD1rhZmQDM/H+GbTbYnSSIXxS9iO4DRfvqaZaVLmHA=;
        b=I2ArurjZWxXb7+XpLicdsV0rlFMZFv7gBdh8euQxI0hZMDcpnlpIoJZu5ltMe9sWnb
         DMG+2YBnDafJ9umzHpMqXhkhj8pHS4XAOZ0TDHp/p4y+cMp1hx3IHzeWCuB39zcqgjfj
         msjJ1LArDkb6x6lsD8lb1dJ5GD204iI8auQKUnK539L4cpwBf/8UM1kNERPkdY+d/W66
         P3H41YvHbbcfSy2/P+MzhkN72fgSNkI1nzurPybrCZqAzztSOhcEaDbR09FqlasCoovs
         kXvovL0pU9ESneKb2ZJioZPYRBxw23HwTU2ZRSGD1TRQR7AgDrGP6LcPUVNL0U7swV7S
         YbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZD1rhZmQDM/H+GbTbYnSSIXxS9iO4DRfvqaZaVLmHA=;
        b=MGz3klqk/U4ql3NJwldrXaGHq6H1HE4Z31ojwhiBwc66UXC9jk8jhC4jxlmUqD6yFD
         /LBhxSqo39wSs0bHPec7Ydz1uCEU1Apni3OtfgigVE3xHJbEeJPc97WcrgWdPvz99rda
         T3xUg3fzoTzrshBLW7uQne9zp7LRT4cmjQ6h600RLgmfzMtWgbaSvdPmw14cyHzPEqAk
         UNIJ1Ixx/L/OYMUhD1G37T63ojHVeFZAHgA1LnQRYx2HedsRxszfBefbj/ckEc+kvPqg
         3ZkBFTYVzd7KIshjVW5JKs85rtrcSqmS0gx1dc9Ifm2A0yivC5rnCNJhDJr6+RhXzOrO
         b6hw==
X-Gm-Message-State: APjAAAWJCDl6CihsCDP2hkuJoV8VmYh+IOwbqyvJAEpB0gxm2HFwD8pB
        sU2Ltj0jcPO4IxEubywHkBqIGg6xHFXF7o3M2WE=
X-Google-Smtp-Source: APXvYqxWRplW90eHZs/5G1y76NalbYYyDOet1jwKXgcM26aLqw7XHltBJMnUYIgx0qdZyyIcHCdpk3LqAa+mZJoGEFY=
X-Received: by 2002:a9d:6e1a:: with SMTP id e26mr10354403otr.307.1571463478507;
 Fri, 18 Oct 2019 22:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191012122918.8066-1-mayhs11saini@gmail.com> <95842b81-c751-abed-dd3f-258b9fd70393@arm.com>
In-Reply-To: <95842b81-c751-abed-dd3f-258b9fd70393@arm.com>
From:   Shyam Saini <mayhs11saini@gmail.com>
Date:   Sat, 19 Oct 2019 11:07:47 +0530
Message-ID: <CAOfkYf7iEe8A0gFB6XG2RDfkHxQtdM_CUZFnsZADedsyMAm8+A@mail.gmail.com>
Subject: Re: [PATCH] kernel: dma: Make CMA boot parameters __ro_after_init
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>, iommu@lists.linux-foundation.org,
        Christopher Lameter <cl@linux.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Sorry for the late reply.


> This parameters are not changed after early boot.
> > By making them __ro_after_init will reduce any attack surface in the
> > kernel.
>
> At a glance, it looks like these are only referenced by a couple of
> __init functions, so couldn't they just be __initdata/__initconst?

yes, You are right it is only used by __init calls and not used anywhere else.

I will resend the updated version.

Thanks a lot for the feedback.


> > Link: https://lwn.net/Articles/676145/
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Christopher Lameter <cl@linux.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Shyam Saini <mayhs11saini@gmail.com>
> > ---
> >   kernel/dma/contiguous.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index 69cfb4345388..1b689b1303cd 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -42,10 +42,10 @@ struct cma *dma_contiguous_default_area;
> >    * Users, who want to set the size of global CMA area for their system
> >    * should use cma= kernel parameter.
> >    */
> > -static const phys_addr_t size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
> > -static phys_addr_t size_cmdline = -1;
> > -static phys_addr_t base_cmdline;
> > -static phys_addr_t limit_cmdline;
> > +static const phys_addr_t __ro_after_init size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
> > +static phys_addr_t __ro_after_init size_cmdline = -1;
> > +static phys_addr_t __ro_after_init base_cmdline;
> > +static phys_addr_t __ro_after_init limit_cmdline;
> >
> >   static int __init early_cma(char *p)
> >   {
> >
