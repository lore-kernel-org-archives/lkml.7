Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6695BC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36ED421721
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CgcPD0qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfH3G3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:29:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfH3G3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7yhlWg6egM/dV5ihEVYnfI6KRgGSnwmGepLG69PL6tQ=; b=CgcPD0qjdRGWkLkectVZWJjSD
        tDbwLX7U2fS+zq2cI9MXZ9AvkhMH5Qw3eR+zJKna2fLHHNuEa6PC6NvUqIqEFIbU10av+d0TMGJtk
        noK+GE4nkoNJxYMC5i1FYni62tqxpcWb2Tk5FcnivFPF5j+zc0jcEry1GyuGfEJ/if/QruocunM1Q
        XVyy021lBtr9MBHHndaKSaNyL+UvsU9Ryj7fnBEhlA/nB33vd8O60JVFwStyXSBEwrVZildCMQh+o
        YMREX8u6Y3PAgqu655rM8bC+U685uj3mU7Gr58MY17jQ4972omlfljgs19Jidpk7fNldecMxotC4x
        0KO8elXTQ==;
Received: from [93.83.86.253] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3aPY-0002ok-0S; Fri, 30 Aug 2019 06:29:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: cleanup vmap usage in the dma-mapping layer
Date:   Fri, 30 Aug 2019 08:29:20 +0200
Message-Id: <20190830062924.21714-1-hch@lst.de>
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
it to userspace in procfs to better understand the mappings.
