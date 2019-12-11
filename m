Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDD0C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81221214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077763;
	bh=6WqnEtZcpwKMN0AGFQmDNkvleWZEMRKj16Ms18ORuJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MwP86u+tAIY3CDbEGSyHY86B0eoC7+1CahA9ykEYiEi1a4tzzdW37ynN2e0WSqiKV
	 3zNXeG+VyNXMuRhTTxcQQqgj1x0r2xB4B4lu+9Ifm1c9p3B8yPQsff1FYkRZiXHBKH
	 2tpuNqnD3VupTkUhRtVLusSAxIy4wUqMebMolQfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbfLKPWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:22:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730932AbfLKPWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:22:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDCA32073D;
        Wed, 11 Dec 2019 15:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077758;
        bh=6WqnEtZcpwKMN0AGFQmDNkvleWZEMRKj16Ms18ORuJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OUPB/BFmaj87I02qMYj8qb4d/1ysIcAJgFmQb0QjI+WHDVd6ncsBNfIQs4h+NtCt4
         GUu9x7azBlDgD7/7zPmwCiLBRr4bkLL4JGqq/T8IjItQDUdhpDGqP5I4CvZQhMrGub
         +ILG41JVBjIwn34/xIOIliPFZEIOvh6idTvFGg+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 160/243] mtd: fix mtd_oobavail() incoherent returned value
Date:   Wed, 11 Dec 2019 16:05:22 +0100
Message-Id: <20191211150349.965520027@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 4348433d8c0234f44adb6e12112e69343f50f0c5 ]

mtd_oobavail() returns either mtd->oovabail or mtd->oobsize. Both
values are unsigned 32-bit entities, so there is no reason to pretend
returning a signed one.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mtd/mtd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index cd0be91bdefa5..035d641e8847c 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -386,7 +386,7 @@ static inline struct device_node *mtd_get_of_node(struct mtd_info *mtd)
 	return dev_of_node(&mtd->dev);
 }
 
-static inline int mtd_oobavail(struct mtd_info *mtd, struct mtd_oob_ops *ops)
+static inline u32 mtd_oobavail(struct mtd_info *mtd, struct mtd_oob_ops *ops)
 {
 	return ops->mode == MTD_OPS_AUTO_OOB ? mtd->oobavail : mtd->oobsize;
 }
-- 
2.20.1



