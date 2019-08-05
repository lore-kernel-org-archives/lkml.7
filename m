Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2CCC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080652067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lJc/miCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfHEIB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:01:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEIB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9C8BalNHtgcMpImxrnOhx7BfTEOVdkXTrjPSmrzHY1w=; b=lJc/miCU9VChJUuc3X35x4rbP
        UsPENE26leGH/y10sD6gJC6gfDd8wOyNBx6q8qCcYJdpzuy0LaNyfk6wo/ebbjq951Qu8+AdbM5sH
        yawOAdRIGDYeIoynYesWF5SN8ZmUHhW8xgMqta6RlXnV+OsRhmWioixd9/HPog9I1pdVALdfFPPxv
        7fYv3+w6gurV55Nd880nPBrPBCtzAT9YulYKUsqb2GMCITJmJ3ppRgUyP8d5QbbSWwgW9p+R2B8y+
        T4uvJJ9sbIdRDdnY2yUSsUszxZwcaUNdCBnGnOEgp8qVTR8dEj8c09HeJlLU6ZrYW8mdGX3rFDJB4
        GUc+lIiuw==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1huXwC-0003Lv-6m; Mon, 05 Aug 2019 08:01:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Shawn Anastasio <shawn@anastas.io>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: fix default dma_mmap_* pgprot v2
Date:   Mon,  5 Aug 2019 11:01:43 +0300
Message-Id: <20190805080145.5694-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

As Shawn pointed out we've had issues with the dma mmap pgprots ever
since the dma_common_mmap helper was added beyong the initial
architectures - we default to uncached mappings, but for devices that
are DMA coherent, or if the DMA_ATTR_NON_CONSISTENT is set (and
supported) this can lead to aliasing of cache attributes.  This patch
fixes that.  My explanation of why this hasn't been much of an issue
is that the dma_mmap_ helpers aren't used widely and mostly just in
architecture specific drivers.

Changes since v1:
 - fix handling of DMA_ATTR_NON_CONSISTENT where it is a no-op
   (which is most architectures)
 - remove DMA_ATTR_WRITE_COMBINE on mips, as it seem dangerous as-is
