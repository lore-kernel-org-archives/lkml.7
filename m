Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7F8C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 08:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61F62173C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 08:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T46e9N54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfHKIF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 04:05:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfHKIFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 04:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SRihJ2JCOubb4xOLvkiaXfqbtokLoWesn+Hfy8/Vu0Q=; b=T46e9N54SMpr4GBv9pEwtOISh
        8/dhFXd16JGfmcLf2eLpHpf42sr2Bl89BbcsVn78EvBYavRPWjJnCCfr61VUbbd7pC0bJSI3dXBiK
        RNwWWO7xpA1SustKupCRocJIOMXxD4ifjurw05OKz/wk9fvh+CB6DwzdKjAPt0wss6bImBTMAZwgw
        iGT4dCCWVxHYAwsvPKv7gMFJ4ba6oyPfmBeNFsECPn7X2j9bXyRWwTuXJblluWLjH2gc3ZRQZHmFa
        bRegtSVX/8coTJsg53ce9JsZyT0FA5FzCeKMKV/4665rURUx3jNb9GTGLf+uOIZEcgX74HKJ1M1Uf
        voPPGPSSA==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hwir0-0001uh-74; Sun, 11 Aug 2019 08:05:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Gavin Li <git@thegavinli.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Geoff Levand <geoff@infradead.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olav Kongas <ok@artecdesign.ee>,
        Tony Prisk <linux@prisktech.co.nz>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: next take at setting up a dma mask by default for platform devices
Date:   Sun, 11 Aug 2019 10:05:14 +0200
Message-Id: <20190811080520.21712-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this is another attempt to make sure the dma_mask pointer is always
initialized for platform devices.  Not doing so lead to lots of
boilerplate code, and makes platform devices different from all our
major busses like PCI where we always set up a dma_mask.  In the long
run this should also help to eventually make dma_mask a scalar value
instead of a pointer and remove even more cruft.

The bigger blocker for this last time was the fact that the usb
subsystem uses the presence or lack of a dma_mask to check if the core
should do dma mapping for the driver, which is highly unusual.  So we
fix this first.  Note that this has some overlap with the pending
desire to use the proper dma_mmap_coherent helper for mapping usb
buffers.  The first two patches from this series should probably
go into 5.3 and then uses as the basis for the decision to use
dma_mmap_coherent.
