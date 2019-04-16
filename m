Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57174C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A73020868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LxXjuT84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfDPSYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:24:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfDPSYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ADF99MA7v+f8m79E2m71xhkBIBG70cxv/tDPmw5+Luw=; b=LxXjuT84vZuLDh1tec0oD1nUn
        qTgK2fLmsaMiqLmk1rUmL3PWrOUg6Zr6DtZS6fVwLfBHHT2WoTSuEd8yTiOcE7iZeRuAc9YaD0E3W
        8GNTc/DWsdJjg4wEkVjSNf19wCjrXuWwofV5i1/wS8Kafz0dCDH9XmFnbr9X1Jrcmva0Da2bzDz5x
        o9oTCR2/+74ZzrYdMhvWMH/ewiDFrN9bl3IFGwN0orryMh2C3Du7uSZjtjBuDNrx2UT0ow7drOHG5
        g1vYrGSLdaxjR5/vpSYCaT6uDjIhoKzcIw+ainIJdCz7c3WMvnjsdh1bLrlTjrCz4KGt/RnFUv4LT
        jHQcDSohQ==;
Received: from 213-225-15-255.nat.highway.a1.net ([213.225.15.255] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGSkf-00075X-HT; Tue, 16 Apr 2019 18:24:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: fix SG list handling in the sparc32 iommu driver
Date:   Tue, 16 Apr 2019 20:23:38 +0200
Message-Id: <20190416182347.18441-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

this series fixes some long standing bugs in the sparc32 iommu driver,
mostly the lack of handling of large sglist offsets in the map_sg
method, but also a few other smaller bits.  These now show up all the
time do some block layer changes in linux-next.
