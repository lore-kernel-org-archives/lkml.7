Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4640EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15126206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7NbUBcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbfJHLvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:51:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33766 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbfJHLvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:51:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id r5so24837354qtd.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 04:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TP0fuYtSeZDOT7CrZEihsRgw5tOuh/8kOVD2u7lNDTk=;
        b=n7NbUBcWkVFWs+SNEwxjt2F/wAULZ8WYp6vM1sr8jzMVnzGQBAUaUwdbXY7YB1I/hI
         2An88SwgNSk9ss7fOYeCvQ3oGI8JzXhLJyW7yJ+h6F5JIPK5FF+HvDwMwDKxQ40i1/c1
         TTuI5D3HAX79cKWrvg14Izzuly3WQLKm29/qyCSPn0iJIw6JuZW28NOdjtz4U9Uws3xP
         JXMXI3A2XaXqDlWQ0jP+oXJw89H/94k4Shd7DW5lZGw0H7us0ArtCDym0zX5Ejf2X9CZ
         62CzjaDm6cv/om+O1A4EUz0/cr+/YOF3xGIcpXKJeUuoXhekEzdYP5vYkVu8tH2Y+t5Y
         rxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TP0fuYtSeZDOT7CrZEihsRgw5tOuh/8kOVD2u7lNDTk=;
        b=DrRM3bU37cXbPGecUUIpqdQyJZu6soGzdQm7xvuODOKtyzZdD6W9V3ajUxBMCeETL1
         IWqwFo+Bztofk8bM6UeFCwHbsMd8biZDmUXEGoMsrJkG8FlRn4eLwT9dxLZQR66Xoh02
         uvnQizfAkQ5DKx5jLnBBRXkgVJZS6ngE6zGM8inV5xjC1BOXR6DnvcvDb1d3QEV6Aij/
         P5GOhQDfRen5UqgDGmF0JckUo5O+qemdRXK5L5Lfwyk0ZXi7sxgIFIVHZquFJfsyFTXz
         KDGpJudF57C1SJJEw3YI2+aea3mVRNkYOYiEtnvvY4Veyy9yNwus1y6kuWgW/OOSPdQ/
         NIXA==
X-Gm-Message-State: APjAAAXeI9fNwr3ZA1AOTFlNRUVFMEi2KJSrPCtjlFYahZG8DVT3s21h
        iuFU15Gzp0KLtmQmx68O9vdvt+GT3BDCag==
X-Google-Smtp-Source: APXvYqwAnQv5oYaT67RRjPtBW6WIjMuNwzonJT372UgMKyREbq2IqlSwhJ/AzDCWkGdXAMv4byeyUQ==
X-Received: by 2002:a0c:e90e:: with SMTP id a14mr32637560qvo.184.1570535466036;
        Tue, 08 Oct 2019 04:51:06 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x12sm12289720qtb.32.2019.10.08.04.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 04:51:05 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 8 Oct 2019 07:51:03 -0400
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: ehci-pci breakage with dma-mapping changes in 5.4-rc2
Message-ID: <20191008115103.GA463127@rani.riverdale.lan>
References: <20191007073448.GA882@lst.de>
 <20191007175430.GA32537@rani.riverdale.lan>
 <20191007175528.GA21857@lst.de>
 <20191007175630.GA28861@infradead.org>
 <20191007175856.GA42018@rani.riverdale.lan>
 <20191007183206.GA13589@rani.riverdale.lan>
 <20191007184754.GB31345@lst.de>
 <20191007221054.GA409402@rani.riverdale.lan>
 <20191007235401.GA608824@rani.riverdale.lan>
 <20191008073210.GB9452@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191008073210.GB9452@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 09:32:10AM +0200, Christoph Hellwig wrote:
> On Mon, Oct 07, 2019 at 07:54:02PM -0400, Arvind Sankar wrote:
> > > Do you want me to resend the patch as its own mail, or do you just take
> > > it with a Tested-by: from me? If the former, I assume you're ok with me
> > > adding your Signed-off-by?
> > > 
> > > Thanks
> > 
> > A question on the original change though -- what happens if a single
> > device (or a single IOMMU domain really) does want >4G DMA address
> > space? Was that not previously allowed either?
> 
> Your EHCI device actually supports the larger addressing.  Without an
> IOMMU (or with accidentally enabled passthrough mode as in your report)
> that will use bounce buffers for physical address that are too large.
> With an iommu we can just remap, and by default those remap addresses
> are under 32-bit just to make everyones life easier.
> 
> The dma_get_required_mask function is misnamed unfortunately, what it
> really means is the optimal mask, that is one that avoids bounce
> buffering or other complications.

I understand that my EHCI device, even though it only supports 32-bit
adddressing, will be able to DMA into anywhere in physical RAM, whether
below 4G or not, via the IOMMU or bounce buffering.

What I mean is, do there exist devices (which would necessarily support
64-bit DMA) that want to DMA using bigger than 4Gb buffers. Eg a GPU
accelerator card with 16Gb of RAM on-board that wants to map 6Gb for DMA
in one go, or 5 accelerator cards that are in one IOMMU domain and want
to simultaneously map 1Gb each.
