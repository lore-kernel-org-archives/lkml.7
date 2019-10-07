Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5350FC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15466206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCiFdYvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbfJGXyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 19:54:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41284 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbfJGXyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 19:54:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id p10so14524805qkg.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 16:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l7uk+TuX8xcNELmLR9qeK5X9Q2/Bic3Tz0aa0W2A1hY=;
        b=HCiFdYvXOSqeOtj5K4V/JNiwdx4BiK0KAGsjuPZ8/TTnE2ROIi7R8/uj1Vf7hKW918
         gWfe/d23b7PTukkWtNCp4JKxvVqSeVSJLcd7Tyw+Pf0kKtxlJM8DkVP0bLAXIrqgL576
         ckNwIy2z9kYyTvClhxXAGoKuG22lwxhN1T+BlglmD++HV/kErE6WfHpCG4u4IECTJWmT
         N+GjPeF2xl4Yqca0vNEsKlWlrwHec+PeGIjGbkyGMtskg9osU9nZR0BQ+mX3NsY1NyLO
         hDsETVE9HifARkHx3nli2/zvAHqNBUaRx6EO9C9AAmNfAtQwgVEzy8Y1VCuxeu5DZp8M
         xVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=l7uk+TuX8xcNELmLR9qeK5X9Q2/Bic3Tz0aa0W2A1hY=;
        b=ceo4eO5UYJSqwei4BZ4a6HN9NpcKlozBvyOHXPUsSmXflKywqhkgLFjIBe9pLFZzNB
         IXUu7fN7kbBZezabwX/faKfbJYDs2oxSN6nTCUFk2m5WgRTt+BJjMznD6drHb67cFc+L
         T+omJKlDJg6EPcNf+7egsaG1/0p/Io0hDrRBSwigdPBvWXDISx0LXLf3vzY3VaQVieD+
         RqpWJIFvHa4u5DpyMpPlQv6Lj4LRJ5qrycEd+s249yYFAEWnqKu/WkhX+ccHINNRfTBl
         wRi8askBfp1NyEprd6T4Fn1jvftLidSyMN2gFQQZlIWq4pdelO7LJ4qti+JKOAWrJjcf
         TmDQ==
X-Gm-Message-State: APjAAAU9mEvdBCN2fMe8pzhWLSuRT0QUr16qmUdYOqamKU0XLOLLQxXZ
        QXm9aonMJEMT7LXuRbnNp5t95UlhqypJ1A==
X-Google-Smtp-Source: APXvYqxf6CG7C9LSPP5LAlElSppMcPsSNjsEHo103FdqDFHCydAwBkp1nvj6OCDdkxU+Mq76iCcEqQ==
X-Received: by 2002:a37:4a54:: with SMTP id x81mr26240146qka.292.1570492444597;
        Mon, 07 Oct 2019 16:54:04 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p53sm9027670qtk.23.2019.10.07.16.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 16:54:04 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 7 Oct 2019 19:54:02 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: ehci-pci breakage with dma-mapping changes in 5.4-rc2
Message-ID: <20191007235401.GA608824@rani.riverdale.lan>
References: <20191007022454.GA5270@rani.riverdale.lan>
 <20191007073448.GA882@lst.de>
 <20191007175430.GA32537@rani.riverdale.lan>
 <20191007175528.GA21857@lst.de>
 <20191007175630.GA28861@infradead.org>
 <20191007175856.GA42018@rani.riverdale.lan>
 <20191007183206.GA13589@rani.riverdale.lan>
 <20191007184754.GB31345@lst.de>
 <20191007221054.GA409402@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191007221054.GA409402@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 06:10:55PM -0400, Arvind Sankar wrote:
> On Mon, Oct 07, 2019 at 08:47:54PM +0200, Christoph Hellwig wrote:
> > On Mon, Oct 07, 2019 at 02:32:07PM -0400, Arvind Sankar wrote:
> > > On Mon, Oct 07, 2019 at 01:58:57PM -0400, Arvind Sankar wrote:
> > > > On Mon, Oct 07, 2019 at 10:56:30AM -0700, Christoph Hellwig wrote:
> > > > > On Mon, Oct 07, 2019 at 07:55:28PM +0200, Christoph Hellwig wrote:
> > > > > > On Mon, Oct 07, 2019 at 01:54:32PM -0400, Arvind Sankar wrote:
> > > > > > > It doesn't boot with the patch. Won't it go
> > > > > > > 	dma_get_required_mask
> > > > > > > 	-> intel_get_required_mask
> > > > > > > 	-> iommu_need_mapping
> > > > > > > 	-> dma_get_required_mask
> > > > > > > ?
> > > > > > > 
> > > > > > > Should the call to dma_get_required_mask in iommu_need_mapping be
> > > > > > > replaced with dma_direct_get_required_mask on top of your patch?
> > > > > > 
> > > > > > Yes, sorry.
> > > > > 
> > > > > Actually my patch already calls dma_direct_get_required_mask.
> > > > > How did you get the loop?
> > > > 
> > > > The function iommu_need_mapping (not changed by your patch) calls
> > > > dma_get_required_mask internally, to check whether the device's dma_mask
> > > > is big enough or not. That's the call I was asking whether it needs to
> > > > be changed.
> > > 
> > > Yeah the attached patch seems to fix it.
> > 
> > That looks fine to me:
> > 
> > Acked-by: Christoph Hellwig <hch@lst.de>
> 
> Do you want me to resend the patch as its own mail, or do you just take
> it with a Tested-by: from me? If the former, I assume you're ok with me
> adding your Signed-off-by?
> 
> Thanks

A question on the original change though -- what happens if a single
device (or a single IOMMU domain really) does want >4G DMA address
space? Was that not previously allowed either?
