Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98480C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B9421903
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wrERNdA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfGVPLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:11:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39288 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfGVPLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:11:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so13527184pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=okW2ZRllj1UmKp04aEFvJhWydriFCMDOSg9DK6KAQaA=;
        b=wrERNdA+k3qS3VTOu/hN4vusaATGstfPhZIORk2Dy9VxFSHX2bgxeEdSe8p6U0/EAv
         +TXWdeDvyTIgsJ4XbeVIw+X09pvmBoQ3ajv70KQJYEhdDYwDidbw8LYOGhlJQL3xwb+s
         IOpT++HqYP41y78gpqHYg5CYNIhrDoO62Gfot61zR6PWkMAqweRs35n3muoJfpFP5YSp
         L9zChQWF00xKxHH7Z9eLKQhAvJmvACNyIsEGIQtl4pxeUoip+l2MRBlQXFsTZTvI3dYU
         q+bDyjaWjSPhcLl81BiJs13VqpI+EZAevtwToHpvbTk/s9Ojfxg13Un8ZgmxCf08h8xE
         4jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=okW2ZRllj1UmKp04aEFvJhWydriFCMDOSg9DK6KAQaA=;
        b=cbMTq3/d9txO4yk2Sq6ASX4LUl7IyuA2E10a0LIrAxCcpreU43MdOAZ2cssdiCR1hZ
         Qww1xG+pLzC+XLWC1SJrUAcbjUUu+XkImrHRiSoy5ETSnF7g2IJYapLaZqMjH80q2amm
         DSvJvU/HO+X09BhDz8GKTJxJYvs11QjS82zgHkoZ1S25QsaotMEGZcERBDHlux2qnXBo
         HWXeQEHlevHbyk049JB9mXM5mEucHEiacUmLUr9yrz2IyKmFCnZhXJbkcAHxQE/HmR4o
         rlDIKwEoqsW39lUUOt43df2LNiDTDnFDWP2Fg/WMqu6xTeHZHO6XJVPeSPlIFBF2h3Av
         STPQ==
X-Gm-Message-State: APjAAAXUy/tFrRZRodF+1bPlW+215DbjUeRthv18ShvMtWP4gdUP/j6i
        Nsvp+Sk7PHJAwivqrfkS9qLvUw==
X-Google-Smtp-Source: APXvYqyUMggcpHvQEIWA1uz/HQ0m+BWgq/e/QrwPKl6dVDM71u87KBblZBgc9PooMtK9Xla5oXXYZw==
X-Received: by 2002:aa7:8189:: with SMTP id g9mr755670pfi.143.1563808274042;
        Mon, 22 Jul 2019 08:11:14 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n140sm41835626pfd.132.2019.07.22.08.11.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 08:11:13 -0700 (PDT)
Date:   Mon, 22 Jul 2019 08:12:34 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] firmware: qcom_scm: fix error for incompatible pointer
Message-ID: <20190722151234.GJ7234@tuxbook-pro>
References: <20190719134303.7617-1-minwoo.im.dev@gmail.com>
 <7ea51e42-ab8a-e4e2-1833-651e2dabca3c@free.fr>
 <20190722093059.GA29538@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722093059.GA29538@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22 Jul 02:30 PDT 2019, Christoph Hellwig wrote:

> On Mon, Jul 22, 2019 at 10:38:55AM +0200, Marc Gonzalez wrote:
> > > In file included from drivers/firmware/qcom_scm.c:12:0:
> > > ./include/linux/dma-mapping.h:636:21: note: expected ‘dma_addr_t * {aka long long unsigned int *}’ but argument is of type ‘phys_addr_t * {aka unsigned int *}’
> > >  static inline void *dma_alloc_coherent(struct device *dev, size_t size,
> > >                      ^~~~~~~~~~~~~~~~~~
> > > ```
> > > 
> > > We just can cast phys_addr_t to dma_addr_t here.
> > 
> > IME, casting is rarely a proper solution.
> 
> *nod*
> 
> ptr_phys probably should be a dma_addr_t.  Unless this driver is so
> magic that it really wants a physical and not a dma address, in which
> case it needs to use alloc_pages instead of dma_alloc_coherent
> and then call page_to_phys on the returned page, and a very big comment
> explaining why it is so special.

The scm call takes physical addresses (which happens to be 1:1 with DMA
addresses for this driver).

This allocation started off (downstream) as a simple kmalloc(), but
while the scm call is being executed an access from Linux will cause a
security violation (that's not handled gracefully). The properties of
dma_alloc is closer, so that's where the code is today.

Optimally this should be something like alloc_pages() and some mechanism
for unmapping the pages during the call. But no one has come up with a
suitable patch for that.


But there's a patch from Stephen for this already (not doing a
typecast).  Apparently I missed merging this, so I'll do that.

https://lore.kernel.org/linux-arm-msm/20190517210923.202131-2-swboyd@chromium.org/

Regards,
Bjorn
