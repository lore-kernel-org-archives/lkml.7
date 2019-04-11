Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB08C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116B5217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jgGu0IY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfDKHKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:10:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfDKHKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vlNlrI34Zr5Cyj2P1lmGJ+yO6NGkQWFQi0XBAP+2ijY=; b=jgGu0IY0G/vEsxzn5hYzHaa8e
        79HaBZJ4gJDjsFVlt/6mchybQk298ebWb/26Z0EdLnAurYKP+OvYJWCXBsHqexsw9TLZfrPb1EwwK
        t+IiInms0cZbUqhT7Ub42R7z/P9avaHtloXmcvdSU+b0vKFfC+4MlCQFS7XMOkcdTl6EBSh5uxAGP
        boQR+AxF9EIkNEalCLtFdh8oP7h4pxmuE8WDWd5YUKqcR5qSkkrFtDL2TyoRWi2g9O4TySdoG5H91
        TqyEC7EMGngZbeB20Pl3jWx+6oCS1w75oqyw8RhORDxFO1T2T9r33+FpWtFuMKc5dE7S8/oKvt+6r
        3coP3k6Ow==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hETqc-0006mr-NM; Thu, 11 Apr 2019 07:10:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: get rid of dma_max_pfn
Date:   Thu, 11 Apr 2019 09:09:46 +0200
Message-Id: <20190411070948.29564-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I though I got rid of all non-highmem, non-ISA block layer bounce
buffering a while ago, but I missed the MMC case.  While I still plan to
also kill off the highmem bouncing there I won't get to it this merge
window, so for now I'd like to make some progress and move MMC to the
DMA layer (swiotlb or arm dmabounce) bouncing for addressing limitations
and kill off the dma_max_pfn helper.
