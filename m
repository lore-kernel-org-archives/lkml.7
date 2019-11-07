Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53637C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284AC218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cIm6jVZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389538AbfKGRk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:40:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfKGRk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dLNx8yX02Kzj1oRWP3mQD5vnGq79lBQ8cwVKhpycAZU=; b=cIm6jVZ03X0FF3ZUZEVUBNxG2
        TzFrLwgk9odu/08Us6Nlkwas9WZ15XFdpPT2mAfyh3/Q3/Jfr87m38La8EyX3BRe/M5B+OsKGdj78
        bLUUAIvM0bNRoeNsydjx3SfAzM8kAGyt4E78aHVnQkSQwU3ifXbxIotnL525AOyqb3r2IXzsDv0K5
        DgvUNXavRIyemwxa8KPa9J6lWpHc9hTtoDxV+ZQrBpoU5JEDCWfOy4WXKCChV1Xw2SXz+QHiTWoLC
        i6PvhObHRRkUQS7SizmzKHusOkrT5aoQyK6Winw83d4cMSqk05qzHLFHvvtU3ShbRr5DoB3Q9XZhg
        sk/4vf4xw==;
Received: from [2001:4bb8:184:e48:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSllt-0002NX-Tu; Thu, 07 Nov 2019 17:40:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        openrisc@lists.librecores.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: provide in-place uncached remapping for dma-direct
Date:   Thu,  7 Nov 2019 18:40:33 +0100
Message-Id: <20191107174035.13783-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series provides support for remapping places uncached in-place in
the generic dma-direct code, and moves openrisc over from its own
in-place remapping scheme.  The arm64 folks also had interest in such
a scheme to avoid problems with speculating into cache aliases.

Also all architectures that always use small page mappings for the
kernel and have non-coherent DMA should look into enabling this
scheme, as it is much more efficient than the vmap remapping.
