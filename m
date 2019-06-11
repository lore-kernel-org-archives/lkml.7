Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AEBC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB8920652
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tZm05BCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389798AbfFKOH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:07:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40148 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387683AbfFKOH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jwVSRVYpHoI+ZWo4MBq+1xKy3s947GP/tfP5zSWOihQ=; b=tZm05BCtFnROyHuy+UdTBO27s
        nwZqB51QgVq3veDuwxxZ9RsTyvV9tu+goRJlRmvlfU7fBlfyJA0IfHb1sGIEw5Guo4RCLQeheW2Ng
        +PmQXJ+uxE2ES1zCbmkTRCGNfA92g4nNmxQRcm+zI8DnUb3KD0nxOVHoUkdMMjWKhO8Krsf1h+u1m
        L6cjG+1OygWSiNapaKwuyx3JRNNuv6zj+YG4WfqA11TD1sZvd6Im5yni3ST5F8tAEjpMdTzQ0dClU
        wpxlbo2kBABvvoVl6XhSkKflygsn2wOz7Z780aeGhgDRi2OAEXZ3fpPnmmO7kIfI3WCpXJrtSE3/P
        JSD/8VaIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hahQr-0000sf-1G; Tue, 11 Jun 2019 14:07:25 +0000
Date:   Tue, 11 Jun 2019 07:07:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linuxppc-dev@ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Question - check in runtime which architecture am I running on
Message-ID: <20190611140725.GA28902@infradead.org>
References: <CAFCwf11EM9+NDML9hQmk9-rPzSmDmAyVLW+qOfs6h62dGK6H9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf11EM9+NDML9hQmk9-rPzSmDmAyVLW+qOfs6h62dGK6H9A@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 03:30:08PM +0300, Oded Gabbay wrote:
> Hello POWER developers,
> 
> I'm trying to find out if there is an internal kernel API so that a
> PCI driver can call it to check if its PCI device is running inside a
> POWER9 machine. Alternatively, if that's not available, if it is
> running on a machine with powerpc architecture.

Your driver has absolutely not business knowing this.

> 
> I need this information as my device (Goya AI accelerator)
> unfortunately needs a slightly different configuration of its PCIe
> controller in case of POWER9 (need to set bit 59 to be 1 in all
> outbound transactions).

No, it doesn't.  You can query the output from dma_get_required_mask
to optimize for the DMA addresses you get, and otherwise you simply
set the maximum dma mask you support.  That is about the control you
get, and nothing else is a drivers business.
