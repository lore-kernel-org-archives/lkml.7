Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57647C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B9F2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384727;
	bh=RWaQefVK8ASVG6pbqzbUIqMWiTGMpl6fvlxtzPjJeq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mTuBMQfoIBnHhPu/1JkbsEKctR3/NRFPl7mc31O3VTjve6urQEelT4yz26vg/r8Yn
	 wufQL1QexPQrElwZLIcDbgIjygM1WFr7rx9Cgu45aLQuQJUPh0Nsy+htBH72cJNnuq
	 4BFWb1cgnpvk0+u2kjWNgqlnvIxjlIKFkoQuE7nA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfJFR6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729460AbfJFRbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:31:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 748C92133F;
        Sun,  6 Oct 2019 17:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383103;
        bh=RWaQefVK8ASVG6pbqzbUIqMWiTGMpl6fvlxtzPjJeq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGMzrf+QwPoBbqyEAyNWT7R0ZN1yPdTB1je6RIt69uYTSCnTIKvmThtUdS+6OR4gv
         85PlgqFaC92oiZJSE5G1YnkQRDY1IKH1/PjCqt6wah1Vaw7PW/X05J59UYpClG2+aW
         46uIhRiHzIsSrT2/X3O6Q/hlFjH0A1820PtHIUWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 044/106] clk: sprd: add missing kfree
Date:   Sun,  6 Oct 2019 19:20:50 +0200
Message-Id: <20191006171142.943793763@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171124.641144086@linuxfoundation.org>
References: <20191006171124.641144086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

[ Upstream commit 5e75ea9c67433a065b0e8595ad3c91c7c0ca0d2d ]

The number of config registers for different pll clocks probably are not
same, so we have to use malloc, and should free the memory before return.

Fixes: 3e37b005580b ("clk: sprd: add adjustable pll support")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Link: https://lkml.kernel.org/r/20190905103009.27166-1-zhang.lyra@gmail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sprd/pll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sprd/pll.c b/drivers/clk/sprd/pll.c
index 36b4402bf09e3..640270f51aa56 100644
--- a/drivers/clk/sprd/pll.c
+++ b/drivers/clk/sprd/pll.c
@@ -136,6 +136,7 @@ static unsigned long _sprd_pll_recalc_rate(const struct sprd_pll *pll,
 					 k2 + refin * nint * CLK_PLL_1M;
 	}
 
+	kfree(cfg);
 	return rate;
 }
 
@@ -222,6 +223,7 @@ static int _sprd_pll_set_rate(const struct sprd_pll *pll,
 	if (!ret)
 		udelay(pll->udelay);
 
+	kfree(cfg);
 	return ret;
 }
 
-- 
2.20.1



