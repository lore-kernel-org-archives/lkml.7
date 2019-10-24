Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15782CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 06:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73B220856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 06:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571899881;
	bh=DnRBALn0RfvzQiMNXfIVe6k9Dne1oXyPUFgICGigH0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=k+j/dN75hgSpKbor6NZejmjYazGh5Rdrjix/lTm97DYL+F+CO4uuXgUrdmk0JEIFs
	 uAQnEE0dRpA2KcVKHdqhHKdQdj1KDlCFl5IOW6GVWlKI29B4CeFGjhu1ZOp2ATqncL
	 tYKetRBqoXqZfx7P69hewPWubXKmJziYSjz2Ccgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437822AbfJXGvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 02:51:20 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:53639 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390631AbfJXGvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 02:51:20 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iNWxp-0001iX-Si; Thu, 24 Oct 2019 08:51:18 +0200
Date:   Thu, 24 Oct 2019 07:51:16 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        alan.mikhak@sifive.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net
Subject: Re: [PATCH] irqchip: Skip contexts other supervisor in plic_init()
Message-ID: <20191024075116.48055961@why>
In-Reply-To: <20191024013019.GA675@infradead.org>
References: <alpine.DEB.2.21.9999.1910231152580.16536@viisi.sifive.com>
        <mhng-aefb3209-29c4-46db-8cf2-e12db46d9a6e@palmer-si-x1c4>
        <20191024013019.GA675@infradead.org>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: hch@infradead.org, palmer@sifive.com, paul.walmsley@sifive.com, alan.mikhak@sifive.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 18:30:19 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Oct 23, 2019 at 03:07:10PM -0700, Palmer Dabbelt wrote:
> > > > +		/* skip contexts other than supervisor external interrupt */
> > > > +		if (parent.args[0] != IRQ_S_EXT)
> > > >  			continue;  
> > > 
> > > Will this need to change for RISC-V M-mode Linux support?
> > > 
> > > https://lore.kernel.org/linux-riscv/20191017173743.5430-1-hch@lst.de/  
> > 
> > Yes.  
> 
> For M-mode we'll want to check IRQ_M_EXT above.  So we should just
> merge this patch ASAP and then for my rebased M-mode series I'll
> fix the check to do that for the M-Mode case, which is much cleaner
> than my hack.

Does this need to be taken as a fix, potentially Cc to stable? Or is
that 5.5 material?

	M.
-- 
Jazz is not dead. It just smells funny...
