Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EC7C31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F0F2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qQtAGKQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfFNOou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:44:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37892 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfFNOot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gc779D5myAKPsSuqw4+NRIl28cUlcRu7tNhq+zRZKgI=; b=qQtAGKQlN2ng22ft9to7mr8IN
        QfvqOVt+lf871hiViIsORHRqNbzfic95Bg4xrBEGTbmJQo+lzijFeBl54HcsFkXKekELmZ4+FU7mI
        zn521NSvWZ+TrjrMRlwzs/TgYfQzo8YchyTjEwP7ZBtg+7TnJ1a8zu3tOghcAZjQH6Cs3i4Q0PdVH
        T5izGhMoXafR+ZzHsn39ZVY2VdW1aWBrAWKRE0E1QH1Ek75OP5agoHdsOj9QbeHgyKRllM8aTe2GM
        121pmf1WOvB4uQrdVQQBoof5Kqf4AxAgYtIgzDmEhOKAtoFUo5eeNXFu5scMqW4STadNi6vevVupQ
        L5e+8415A==;
Received: from 213-225-9-13.nat.highway.a1.net ([213.225.9.13] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbnRU-0005pD-SO; Fri, 14 Jun 2019 14:44:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: handle "special" dma allocation in common code
Date:   Fri, 14 Jun 2019 16:44:24 +0200
Message-Id: <20190614144431.21760-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,,

this series ensures that the common dma-direct code handles the somewhat
special allocation types requested by the DMA_ATTR_NON_CONSISTENT and
DMA_ATTR_NO_KERNEL_MAPPING flags directly.  To do so it also removes three
partial and thus broken implementations of DMA_ATTR_NON_CONSISTENT.  Last
but not least it switches arc to use the generic dma remapping code now
that arc doesn't implement any special behavior.

