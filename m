Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D02C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC13F20661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V9NFCvdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfLDNDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:03:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfLDNDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VAw+exV6zFNd79GLsJ/i683SHwBX9ctSDVhWZEuWOOo=; b=V9NFCvdSmtkVG2Erzr/1Lg4wA
        WPk5PvNGR+PQCfY+6HS/6i3CBsIjfOt6+DqPNrwPgGaILBpaSAkNwQZfiGFUaB395Bw1IhWlq6RUz
        R3w7Z94R6RpKPBBGEzWa8KS1dfIgd1C1Sqg6a8HFsNgQcP9hE3s1/ufXIdaFr81MhT0h+YzUlQleV
        pPyNAzssNUd0iT3dSLt71WgPiSL/hnwhYhosH3jrPywToVGSq96EJXlYPYLtqlQZLCnHn2wF1vf2J
        R3oHrIsvK2sKKA3k0Eh2MY75cpD1mqJu3LQ6Zr0I/MDcGmpgTRK90NOWRIy6E6duNqMMR5OJigo7m
        AACJbWy5A==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icUJi-000462-KO; Wed, 04 Dec 2019 13:03:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: make dma_addressing_limited work for memory encryption setups v2
Date:   Wed,  4 Dec 2019 14:03:37 +0100
Message-Id: <20191204130339.22804-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this little series fixes dma_addressing_limited to return true for
systems that use bounce buffers due to memory encryption.

Changes since v1:
 - take SWIOTLB_FORCE into account
