Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB804C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85507206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483019;
	bh=pBD8D54Jh+aAZ584Gec2gIdMiQfp2n7SefwZdXpySxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b7cG0xCY06O8iH2AoOckNJgbglM7U44Jf7I2Iv4FCA2nXDPZ+S3uGnMWgT8wqT/i0
	 5oqkk0zyDfvosgpOzDQSi5HS6v+14TEaJfud8W+C7Dl18lfduUOo7fVBgJA425H0jh
	 Nu0gmxfSDncvqCP/9eLWKA2VHUbiPt0aY/s7Wm2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfLDSKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:10:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729763AbfLDSKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:10:14 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7878E20674;
        Wed,  4 Dec 2019 18:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483013;
        bh=pBD8D54Jh+aAZ584Gec2gIdMiQfp2n7SefwZdXpySxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UjgYreU687s0kGO9I0YzU+OHZ7K/QDn9afyrCZFuWTZ14LK1JcjZAzkM9IE7bF0IB
         uoeu/xjfpKtYHutmnBH/r/xd0QiKYIuPNvza3ZqcNQQ+Wc/A/BdZtGVs2msZakJSCz
         RBtHshN4q3HeuESfCI2UfBKppf6RLSTy2rLGQHag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 017/125] parisc: Fix serio address output
Date:   Wed,  4 Dec 2019 18:55:22 +0100
Message-Id: <20191204175317.366024596@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

[ Upstream commit 785145171d17af2554128becd6a7c8f89e101141 ]

We want the hpa addresses printed in the serio modules, not some
virtual ioremap()ed address, e.g.:

 serio: gsc-ps2-keyboard port at 0xf0108000 irq 22 @ 2:0:11
 serio: gsc-ps2-mouse port at 0xf0108100 irq 22 @ 2:0:12

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/serio/gscps2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index ecba666afadb7..cca26e6f38b36 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -382,9 +382,9 @@ static int gscps2_probe(struct parisc_device *dev)
 		goto fail;
 #endif
 
-	printk(KERN_INFO "serio: %s port at 0x%p irq %d @ %s\n",
+	pr_info("serio: %s port at 0x%08lx irq %d @ %s\n",
 		ps2port->port->name,
-		ps2port->addr,
+		hpa,
 		ps2port->padev->irq,
 		ps2port->port->phys);
 
-- 
2.20.1



