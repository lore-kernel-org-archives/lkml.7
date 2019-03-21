Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA36C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11DE21916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RqkinUCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfCUWxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:53:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39430 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfCUWxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W8zFbZx08eherb8dRc7aZvBbLLEfcxzKmd++R0qND+g=; b=RqkinUCQbbYTvcgj8WzBZVr/x
        gLusipgjWPtmPecgWaFg5V9j2jqD7ceSeNp3JbrUiWAN+kKlf61hEcLnNTaZWMoic2eYZYSTKClrU
        5UTTQya5X+y8E1hRkiSW//SgHrr6kKIH9ue5YlV1HhYMZLKP7qWQrU9UPzJ5IwsIMRIYiLIq0xoKQ
        SdUOwVK48oYCiy8A7+/izYOdU89p2H3Q7Lk46JHfOkV4ZmEJVuIZcKpWCWiRO1cLF7tOb47CFCUiL
        yvc+E2LglPeRDu26uIze7NInkyGSspGQKbGRiExnFx8axPnmbX5sUAR/HK3WnHeuFjqNQZHCXDlQC
        zJzHIgbHA==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76YQ-0007iu-Lq; Thu, 21 Mar 2019 22:52:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: remove NULL struct device support in the DMA API
Date:   Thu, 21 Mar 2019 15:52:28 -0700
Message-Id: <20190321225235.30648-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We still have a few drivers which pass a NULL struct device pointer
to DMA API functions, which generally is a bad idea as the API
implementations rely on the device not only for ops selection, but
also the dma mask and various other attributes, and many implementations
have been broken for NULL device support for a while.

This series removes the few remaning users that weren't picked up in
the last merge window and then removes core support for this "feature".

A git tree is also available at:

    git://git.infradead.org/users/hch/misc.git dma-remove-NULL-dev-support

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-remove-NULL-dev-support
