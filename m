Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADE0217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c7qBc9iR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfHEH4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:56:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43434 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfHEH4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ifkk164wSodRUe+DyhW0NyzCEeL1GFBRdhMoo+ncAoI=; b=c7qBc9iRJLkZb/+Hrc7vzTp9A
        aIFiXx+1TD4IPx7FHWBk8vk4RUrJDS1GBc9L/3h0ZeHIDVDICAJ8GgUfsBApHTZnkbOYLM7m43+pg
        4NQXS6w9FfoGDs69bx2XKICVGSXCr5s7G5vcIzVWdGVltWBQlLvVzi1YJvOaCAKC1xb2G6btvSIOR
        aMkuRhufCncdzCyPzSuvoomAPfCkS7unfisV/zdMJnV8rc+kyjmFy05eM0GBkNuHtP8gDpH6efKhi
        F6a8lPszxMM8wD+FTgSmj6zQfHNqaTLQcP6qONVdGdDVo8z/up1nPwwvQYYVEbCE16nPWDqN5r/5l
        jERjME66A==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1huXrF-0000xJ-5I; Mon, 05 Aug 2019 07:56:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Roger Quadros <rogerq@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: arm swiotlb fix
Date:   Mon,  5 Aug 2019 10:56:36 +0300
Message-Id: <20190805075637.5373-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

my commit to add swiotlb to arm failed to initialize the atomic pool,
which is needed for GFP_ATOMIC allocations on non-coherent devices.
These are fairly rare, but exist so we should wire it up.  For 5.4
I plan to move the initilization to the common dma-remap code so it
won't be missed for other architectures.
