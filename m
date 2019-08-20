Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB5FC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D274722DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566308751;
	bh=rd0midM+fouZB0dzMrcNPStzVAWBkSIQq5tNYTB2CSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=151yvCBMPndkjjDW/zonLsOw59B8F2JZjfwhNBuyaST9/Xmd/jFtwKEio6o33CnVg
	 +MzrvIETadr6ekZOpmM88FVh8uFh1N3JebFwoK921vha/Vsu8Vp7Vus9JQ6VvS/YCu
	 3iWsnGOUH5VGGg+gyRFsiAtMXfjlXlirErQZtH2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbfHTNm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730620AbfHTNmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:42:25 -0400
Received: from sasha-vm.mshome.net (unknown [12.236.144.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 513CD233A2;
        Tue, 20 Aug 2019 13:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566308544;
        bh=rd0midM+fouZB0dzMrcNPStzVAWBkSIQq5tNYTB2CSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DXry7cIsB7dt9VYep62ke7IoJekU3r1HFv+T00Z/fn4U1mW1H970yl0bokUOfww71
         tm2XAKiPAt0NbdOcbNUspSrjAPH7PVqb95p/o5y6GxIiVSxtVabgu1b+gF4ZIWZVAa
         RimI0dF1Y2I6EJFYcWkJM7qTF3+Mrzd3vTEw4Vbw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 12/27] soundwire: cadence_master: fix definitions for INTSTAT0/1
Date:   Tue, 20 Aug 2019 09:41:58 -0400
Message-Id: <20190820134213.11279-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820134213.11279-1-sashal@kernel.org>
References: <20190820134213.11279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 664b16589f882202b8fa8149d0074f3159bade76 ]

Two off-by-one errors: INTSTAT0 missed BIT(31) and INTSTAT1 is only
defined on first 16 bits.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190725234032.21152-15-pierre-louis.bossart@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/cadence_master.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index d3d7de5a319c5..70f78eda037e8 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -96,8 +96,8 @@
 #define CDNS_MCP_SLAVE_INTMASK0			0x5C
 #define CDNS_MCP_SLAVE_INTMASK1			0x60
 
-#define CDNS_MCP_SLAVE_INTMASK0_MASK		GENMASK(30, 0)
-#define CDNS_MCP_SLAVE_INTMASK1_MASK		GENMASK(16, 0)
+#define CDNS_MCP_SLAVE_INTMASK0_MASK		GENMASK(31, 0)
+#define CDNS_MCP_SLAVE_INTMASK1_MASK		GENMASK(15, 0)
 
 #define CDNS_MCP_PORT_INTSTAT			0x64
 #define CDNS_MCP_PDI_STAT			0x6C
-- 
2.20.1

