Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F394CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C888120679
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bvgunk/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387750AbfHFQGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:06:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387741AbfHFQGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4qKgBQZXWXwTBeUsDVCjJZkYmTExx287iM57Vyx6Y0w=; b=Bvgunk/17so9cVPFtrFvb/oAYe
        utWSSLH8JHbMNSIEnE52z7hb3mMGYEuLsxBPJwPNcL85QDt9s3oMn/8gSdfDI94Vl68ZYF6E2HTmh
        2CSuFc5mHOZpxHvRiBi4XMp/D2Nrz/C5Z8Sd+68h66wQQUEBe8/zuz5nTWImH5N9TH0oaGS0xmLSr
        nQm2HdXrYj1F4tz1jpUu7FGHbc5wwvCOeuDFImiYrzCOcbAZwn5cH6Dcbl32haJzzjJbE8rUkWbeV
        ySHWE4hYGGUpoGRQw0UfImuDAtA/m93vnOxClQ7CeTYmpjAOngizf1+aQKrmD52wW3gMGr5CLn1Md
        UerXxonw==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv1yn-0000dn-PQ; Tue, 06 Aug 2019 16:06:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] mm: allow HMM_MIRROR on all architectures with MMU
Date:   Tue,  6 Aug 2019 19:05:51 +0300
Message-Id: <20190806160554.14046-14-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806160554.14046-1-hch@lst.de>
References: <20190806160554.14046-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There isn't really any architecture specific code in this page table
walk implementation, so drop the dependencies.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 56cec636a1fc..b18782be969c 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -677,8 +677,7 @@ config DEV_PAGEMAP_OPS
 
 config HMM_MIRROR
 	bool "HMM mirror CPU page table into a device page table"
-	depends on (X86_64 || PPC64)
-	depends on MMU && 64BIT
+	depends on MMU
 	select MMU_NOTIFIER
 	help
 	  Select HMM_MIRROR if you want to mirror range of the CPU page table of a
-- 
2.20.1

