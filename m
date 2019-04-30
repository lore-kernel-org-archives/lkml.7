Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C36C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0525721670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="baoWPhmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfD3LBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:01:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfD3LBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PAuk9r9abU+3dCJ7MGM4b0v1HEZtMK1t3kVmT53GYTk=; b=baoWPhmm7krqFeob9riojtfuO
        CYckS+yO4JyaBL3bHVkCqG90pyiYW52H+sbi63c3dAbKAIZ/ILLKhekzKXYE1/beWP+Qjn2c8zIjc
        OwmTY/zEDh1LIDSGkFjwgTFvnsdP4HpVOpvY6XZYXdnrRdl5pwABT1MBFbLMtpP8GoIisqD5hZjhf
        QEKNB5lmBx/6adfw1Dka4bg2huZeFLXdefqqRBAnSU9w554+5WFMKuJOwlZnd3x8FSdMwWI9O01Fu
        SBNuZa/oC5RnLerY55f0/oU1wPwHV/FQk9Et3pIwJlrz69/UhWRHmlSbRpiYK8j5pPLham6Fzz95b
        tr1KcrGIw==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLQVZ-0000GR-R4; Tue, 30 Apr 2019 11:01:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        Michal Simek <monstr@monstr.eu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: provide generic support for uncached segements in dma-direct
Date:   Tue, 30 Apr 2019 07:00:25 -0400
Message-Id: <20190430110032.25301-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

can you take a look at this series?  It lifts the support for mips-style
uncached segements to the dma-direct layer, thus removing the need
to have arch_dma_alloc/free routines for these architectures.
