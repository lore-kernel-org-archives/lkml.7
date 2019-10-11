Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5612DECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A83E20640
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lt7Yz68T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfJKIK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:10:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfJKIK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3Qe2lZY4ZZrWpv+4LF899RtGu/VaZYr/ykWfcEi0R6M=; b=lt7Yz68TrZMqWMcyEn5RSTbot
        ZdeUJ4MsI9CEM7qsxCqfbr0mYX/3fVtIU+Su8MhykCJNbGRV193gMolOew4Q43UhiemzfOBCRGzPR
        UG7vLYDu6AqG5f2UeG6HEAAKw3Bdy/cB3CYStk8v2L2WHUaO4kzVdnfayRsgaHPN7+TPg1KICm9F3
        huFkJe18MZATPw5Dsr2Ly9vugTjHeWOMcA/s9U6MTO2Lz5mhqero5xH6ujc5KqK6ZXFjSUM2awE30
        UjJuJKd3dPhG+z3GM9OB/Zhir6UyiCEZRcvHMyF5O8Rq0gsQ2IEx4PAQ0sBS156/enjvTCXrZDeyw
        gXV4kn78Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIq0l-0008KH-Ui; Fri, 11 Oct 2019 08:10:55 +0000
Date:   Fri, 11 Oct 2019 01:10:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Omer Shpigelman <oshpigelman@habana.ai>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] habanalabs: support vmalloc memory mapping
Message-ID: <20191011081055.GA9052@infradead.org>
References: <20191010140615.26460-1-oshpigelman@habana.ai>
 <20191010140950.GA27176@infradead.org>
 <AM6PR0202MB338206146804E2E2BC18C67FB8940@AM6PR0202MB3382.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR0202MB338206146804E2E2BC18C67FB8940@AM6PR0202MB3382.eurprd02.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 07:54:07PM +0000, Omer Shpigelman wrote:
> The is_vmalloc_addr checks are for user pointers and for memory which was allocated by the driver with vmalloc_user.

This does not make any sense whatsoever.  vmalloc_user returns a kernel
address, it just does a GFP_USER instead of GFP_KERNEL allocation, which
is just accounting differences.

> > > Mapping vmalloc memory is needed for Gaudi ASIC.
> > 
> > How does that ASIC pass in the vmalloc memory?  I don't fully understand
> > the code, but it seems like the addresses are fed from ioctl, which means
> > they only come from userspace.
> 
> The user pointers are indeed fed from ioctl for DMA purpose, but as I wrote above the vmalloc memory is allocated by the driver with vmalloc_user which will be mmapped later on in order to create a shared buffer between the driver and the userspace process.

Again, you can't pass pointers obtained from vmalloc* to userspace.  You
can map the underlying pages into user pagetables, but is_vmalloc_addr
won't know that.  I think you guys need to read up on virtual memory 101
first and then come back and actually explain what you are trying to do.
