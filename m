Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9175BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4B32080F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413233;
	bh=GIM1rBHGL//1MEi1HpkGhR+sbhN+5rBTbBl27q9aGcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=asiFXVlrjkiGLBZnYfuDA3FNeBEoIsodi05clLsi7HiiwfUWfGnx3mxyBGLEoK3QX
	 uDAmvCG6vBLFSXnKjFxiHF5WjgnBs3BdoNmBwhG+vB4aJEnQHcWhBhjDc4frLSva0m
	 6IJbK8AZQmL20FrVjfOvmzDTk6ZKM0l337/voM54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfLCWrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728674AbfLCWrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:47:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF01320803;
        Tue,  3 Dec 2019 22:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413229;
        bh=GIM1rBHGL//1MEi1HpkGhR+sbhN+5rBTbBl27q9aGcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=toSWmjIEGfW0yAPJDt8oWP+8of1PFQU73wegVlamjCMONcOsqTu9nPuYrAII9C2L/
         xnMJpDJkqLPlCGEoxR2nBWBqGS0zGGJuWS0ObVyu7c9Z87x6AnV9Oxr/pWXzBmxpTD
         /byDZNcXDt20DssmpvCEvqgU2u568usLR+Rj7O9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 041/321] net: mscc: ocelot: fix __ocelot_rmw_ix prototype
Date:   Tue,  3 Dec 2019 23:31:47 +0100
Message-Id: <20191203223429.248755444@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>

[ Upstream commit 17fdd7638cb687cd7f15a48545f25d738f0101e0 ]

The "read-modify-write register index" function is declared with a
confusing prototype: the "mask" and "reg" arguments are swapped.

Fortunately, this does not affect callers so far. Both arguments are
u32, and the wrapper macros (ocelot_rmw_ix etc) have the arguments in
the correct order (the one from ocelot_io.c).

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mscc/ocelot.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.h b/drivers/net/ethernet/mscc/ocelot.h
index 616bec30dfa3f..3d8c6f38e76b9 100644
--- a/drivers/net/ethernet/mscc/ocelot.h
+++ b/drivers/net/ethernet/mscc/ocelot.h
@@ -541,7 +541,7 @@ void __ocelot_write_ix(struct ocelot *ocelot, u32 val, u32 reg, u32 offset);
 #define ocelot_write_rix(ocelot, val, reg, ri) __ocelot_write_ix(ocelot, val, reg, reg##_RSZ * (ri))
 #define ocelot_write(ocelot, val, reg) __ocelot_write_ix(ocelot, val, reg, 0)
 
-void __ocelot_rmw_ix(struct ocelot *ocelot, u32 val, u32 reg, u32 mask,
+void __ocelot_rmw_ix(struct ocelot *ocelot, u32 val, u32 mask, u32 reg,
 		     u32 offset);
 #define ocelot_rmw_ix(ocelot, val, m, reg, gi, ri) __ocelot_rmw_ix(ocelot, val, m, reg, reg##_GSZ * (gi) + reg##_RSZ * (ri))
 #define ocelot_rmw_gix(ocelot, val, m, reg, gi) __ocelot_rmw_ix(ocelot, val, m, reg, reg##_GSZ * (gi))
-- 
2.20.1



