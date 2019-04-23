Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B501EC282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B88F218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LtyH4QvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfDWQb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:31:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45604 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbfDWQb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ePxLfWKock4PACAGTbvmsL8Pnjci4PixztM3T0bsi38=; b=LtyH4QvIN08otoXLUaGeZuPhN
        QSCV3kXT4nvKtfKNSK15GhTXYk7NDM+GmqpdbfMURnW5OPRQCmf1FNl+cXpAQzh8MKra7gg6BnacP
        gqp7v7R1snYBxfaV/CcNbF9TREITByzN0J6ZeUpLo1ZXSAu7MlDSJKh54YrvvTVWsS0Q3yKx2vwNo
        soKI0pudMF1DAAfXAU2v0iZ5n9WGy7fCL/8rEToZO3AiKcenhZrRdxrwIXpXkW4yFQQ2h5bs+RAGQ
        PGeKSjapTeCY1uHbd8Nq8DsMR4/zeNhAV+E5eLvCgvOmyvqZcXVyhQ8PubE0XYYcqWYGi0++YaTyW
        +6+Nv4P3Q==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIyKL-00041e-9v; Tue, 23 Apr 2019 16:31:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: two small nommu cleanups
Date:   Tue, 23 Apr 2019 18:30:57 +0200
Message-Id: <20190423163059.8820-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

these two patches avoid writing some boilerplate code for the upcoming
RISC-V nommu support, and might also help to clean up existing nommu
support in other architectures down the road.
