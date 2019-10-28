Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92F9CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982C321721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9XRu8s6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfJ1SjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 14:39:15 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34789 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfJ1SjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 14:39:14 -0400
Received: by mail-ot1-f65.google.com with SMTP id m19so7554811otp.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 11:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/gAhBlJb+sh0KhEN82c+Z4PpNrmxIydwqif6hZnM8oQ=;
        b=W9XRu8s6F/9TsFLHTcSQDb0Nv6pnIBlAVPHEIvO+0sRufsrPexDNntaTTDpMZkYUFo
         HPcrYBHpRf+ThMx5LF2vxZRrxrnvJBpc4Sqnihoe1cxFGg+lLl92BzCZvB5gPmy64oYx
         C1JVb5DYpmh6hT5M6smONPWDfCNxR+oiqBdKNQHXRCbonDeA8mQAlBm+G5c0IvbXpuED
         fhS+aVBYsHYn5SNgUF7cgHJNxZpIvtVB/Y6vQ+MwZhPqdFpje6OesPLagLI4Ug6Q/VKZ
         St6ztLOs3ojRqUZcTMIsSv2G7wbLOqTEMiKQ8LS2IyugyXUoJaGkFPbT/4mu9lCwKV9t
         3T4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gAhBlJb+sh0KhEN82c+Z4PpNrmxIydwqif6hZnM8oQ=;
        b=J6KxMha9uGq2zdNwNJgp11X2mcvIRgjugDny+oj7Hae9DepV19wCWt908ntDmfE2Cx
         MLGu3so1crnbLWfRK5ptmUYG9nV16/hNq5Un715le1VSV0MkDxN7mUcmZ7jBg29/g95B
         L5sMXnMzhioCKyHO05kidNZ4D0+8b2x0rXOjO97D9gVaSa1HgmnyjkCovA0MQ7mZRyvx
         MyuogKZI/wYkiJj8xpvb504twUafLfDQWNE5WTywGfEe8Up2PLByEiQVcu/Oe3xKsc5R
         mOg19TSr776BFqthIGuNCH2GP7I29MwhzMwA5/ykKYZEO3oi5uTAvTc6DchCaLfsDxqJ
         6sZQ==
X-Gm-Message-State: APjAAAXlo7t36nnEwtjNZEnwYYC21mNyLY0DPVT1rvvMvduLUC/Li7dG
        AHrrCKOr+ewVpj6J669wlg9zYbpuiwhTIpXXGbgh0w==
X-Google-Smtp-Source: APXvYqyKEfwJb0l2DG8kqTlFCipDkABRVU0HfqUzj9xcr2+jKGtaVuiLUsrnqfOOo9Jq/Rny/0uW2EQPeSc+7gts5vI=
X-Received: by 2002:a9d:5a0b:: with SMTP id v11mr15027479oth.102.1572287953644;
 Mon, 28 Oct 2019 11:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191025234834.28214-1-john.stultz@linaro.org>
 <20191025234834.28214-2-john.stultz@linaro.org> <20191028074642.GB31867@infradead.org>
In-Reply-To: <20191028074642.GB31867@infradead.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 28 Oct 2019 11:39:03 -0700
Message-ID: <CALAqxLXqLUpew9XptiXZGodf5M3qyNmD-D1-2CHZ9PRfPTBRRQ@mail.gmail.com>
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

On Mon, Oct 28, 2019 at 12:46 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Oct 25, 2019 at 11:48:33PM +0000, John Stultz wrote:
> >  struct cma *dma_contiguous_default_area;
> > +EXPORT_SYMBOL(dma_contiguous_default_area);
>
> Please CC the dma maintainer.  And no, you have no business using this.

Sure thing. And I'll look again to see why I was needing to pull that
one in to get it to build.

> Even if you did, internals like this should always be EXPORT_SYMBOL_GPL.

Certainly! My mistake here!

Thanks for the feedback!
-john
