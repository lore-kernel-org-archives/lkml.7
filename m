Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD36C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987AD2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oav8mtDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfHNNqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:46:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbfHNNqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RmX8WjIupDdnINeFjwa1Y0zzdLqr8cYRTyEmffBOcmQ=; b=oav8mtDciXTWkq/r2god3JxID
        k2qVomfIwQb70tmiSUMOe8ww4/LGHcbYaN5ZhYo8G0o04CtjY4DKG9lz6Eir6idNuDN+23SK+bVq5
        jbMicth+DKqO+DHmRPE+trfuMeX515LryxzeseVdGMop8aMzN+EiN8DOwJmkmn44ZLIbch02MBYl8
        agnKWYT3dBQoKdCiCLYlF1gnu8RTCC8gGyP7OqJM4jE1lNrUPYOYM/iCbyNvuhFUy1Ask6j3M1Ack
        9gI0mii+pNm5aAB2w4x6W6qNPHVjcvmkxxR0smER+EI11tW+3PUsZXQ4makNhZEhpv6F+FQH1tWo8
        yp75P0fQQ==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxtbV-0003Z3-UA; Wed, 14 Aug 2019 13:46:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: convert sh to the generic dma remap allocator
Date:   Wed, 14 Aug 2019 15:46:14 +0200
Message-Id: <20190814134615.29442-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rich and Yoshinori,

can you take a quick look at this patch that moves sh over to the
generic DMA remap allocator?  I've been trying to slowly get all
architectures over to the generic code, and I'd like merge this one
for 5.4 now that it has been posted a handful of times without any
feedback.
