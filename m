Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5095C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF74205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GFvtK0jF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407664AbfFLGxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 02:53:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407244AbfFLGxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 02:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xgUX4NVL92gkxOqiTvw1J9XqeyQ+MJXpugSZPm13AZs=; b=GFvtK0jFohgoH84MW52pkyI40
        R1zEfRmP4a24R6XxrcvPT3RRZbLFUlUtEPxsULpUAaAK5nCVL8Sz4cA+wGpXZQLudidQvzYR6dqkg
        89yQXiFkJzeTJdX/YYYJ56lXLo7Vk7rvNbee/3ocS7fbGmRvhLPyyxwLW15FdZIKkNpcEiWvDopqf
        T5QXYgcpiInC9kdOYDQXsM2QV5ii8Ur0ZT715wd7lQ4es8wB89/njfaF11nBFSWsohi1P3z+9BFJ3
        OAbEfmPM0p4yE9eul8AJt2Eav6KrJtgquUD1xJPHnz2v0ox9BgG1BUWkq/2M7rQLshhgGHGEbLL31
        JxdnZzHKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hax8E-0000qt-4p; Wed, 12 Jun 2019 06:53:14 +0000
Date:   Tue, 11 Jun 2019 23:53:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, linuxppc-dev@ozlabs.org,
        Christoph Hellwig <hch@infradead.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
Message-ID: <20190612065314.GA28838@infradead.org>
References: <20190611092144.11194-1-oded.gabbay@gmail.com>
 <20190611095857.GB24058@kroah.com>
 <20190611151753.GA11404@infradead.org>
 <20190611152655.GA3972@kroah.com>
 <CAFCwf13A73AxKzaa7Dk3tU-1NDgTFs4+xCO2os7SuSyUHZ9Z3Q@mail.gmail.com>
 <CAFCwf134nTD4FM_9Q+THQ7ZAZzGxhs15O6EheaRJMqM5wxi+aA@mail.gmail.com>
 <CAOSf1CE82uVVni638jkJJpQ7XLXX+HdD7xuB7Wv-f8mn=SBMeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSf1CE82uVVni638jkJJpQ7XLXX+HdD7xuB7Wv-f8mn=SBMeg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 04:35:22PM +1000, Oliver O'Halloran wrote:
> Setting a 48 bit DMA mask doesn't work today because we only allocate
> IOMMU tables to cover the 0..2GB range of PCI bus addresses.

I don't think that is true upstream, and if it is we need to fix bug
in the powerpc code.  powerpc should be falling back treating a 48-bit
dma mask like a 32-bit one at least, that is use dynamic iommu mappings
instead of using the direct mapping.  And from my reding of 
arch/powerpc/kernel/dma-iommu.c that is exactly what it does.
