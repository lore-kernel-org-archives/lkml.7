Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA38CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C31F21721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qzBWPnA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbfJ1Q2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:28:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730753AbfJ1Q2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Sa3P8nLwwlTZwyaRaz0s2YzXRegwMv9tr7o9w4K0q3o=; b=qzBWPnA0XzM1xaxsIShT31ME5
        A3BnPkqOCf8XCWTUeaR6IQwDXfcdx+lYNJlfk2tXFnrHm/BMTZz+UCZVrsQFb49pHQyrhzvErbOGH
        sYSq3tNE8IK8iUGQ2WwKpnHbCBmOzKUkXaQN/iZGzxoJgIZFBRM11XeUUKyynEBf3lQjKGWHnRY6Y
        E8ixajlOv6yLmiwzcUY3oXZtE2ToA8RIOy/t/Z24+7Wv/tHDBRoJE+VrPhgKPpLCMbimKhIUMhGmC
        LjmYqrp13SV5UBV1V27ocmcIgOdw1KM0+8WH9vtUznT9S/rvsMwmuRHRnzojOdQeNoNAkeUaXmWsS
        EVvq6M+jg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP7sO-0004uZ-9Z; Mon, 28 Oct 2019 16:28:16 +0000
Date:   Mon, 28 Oct 2019 09:28:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ming Lei <ming.lei@redhat.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scatterlist: Speed up for_each_sg() loop macro
Message-ID: <20191028162816.GA17182@infradead.org>
References: <20191025213359.7538-1-sultan@kerneltoast.com>
 <20191028141734.GD29652@ziepe.ca>
 <20191028161848.GA32593@sultan-box.localdomain>
 <20191028162320.GF29652@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028162320.GF29652@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 01:23:20PM -0300, Jason Gunthorpe wrote:
> This testing is making assumptions about how 'nr' is used and the
> construction of the sgl though
> 
> If any chains are partially populated, or for some reason the driver
> starts at a different sgl, it will break. You'll need to somehow
> show none of those possibilities are happening.

And there is nothing forcing a particular layout, there just happens
to be a layout that the generic allocator gives you.  I'm not even
sure the original patch handles the SCSI case of small inlines segments
properly.
