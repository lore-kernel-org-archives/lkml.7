Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BE7C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D2124DB4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WA4XuLy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfFDGzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:55:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfFDGzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 02:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bxnoQG0ijuRDsL2dBIq1SQiaI/rZFtwyO7A8d4rEqxc=; b=WA4XuLy/pL0N5n09h+1lolxMj
        TUAhYXwjnwJJZyUxgnxzMPFg9I0NuRJAZAKLgr8jViYrmseCTyQIfNxRTLIKFw4zzxV1qG3bFI3ik
        DtsIfrbtE7c3vD+/ooSOMNk6jgC17JuriYfaysroA4hLy/C3aJcWBamfH7RoGUNBQ1q9h91jrDgdX
        PKRZbvnnXTz4XSlxMFrkwsa9ngEKk8wh/vlIqQkA5chsCkL4HSSkUT0MuLM93NQ+JZ0DMq85h1gIe
        X1WIoNFTb6iFitzENGlzBXr2XXuRr0BW+XL3sUIyA0+D2oRQNHSU5ZeGwH38Y0Xwg0ViQd3Z2upBt
        JimL+peNg==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY3Lf-0002ih-2y; Tue, 04 Jun 2019 06:55:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: cleanup vmap usage in the dma-mapping layer
Date:   Tue,  4 Jun 2019 08:55:01 +0200
Message-Id: <20190604065504.25662-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the common DMA remapping code uses the vmalloc/vmap code to create
page table entries for DMA mappings.  This series lifts the currently
arm specific VM_* flag for that into common code, and also exposes
it to userspace in procfs to better understand the mappings, and cleans
up a couple helpers in this area.
