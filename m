Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F78C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E6F2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556118012;
	bh=AoPO4MTVU1qmifn1GeWJngGod9fvtCqvhwWiaAFIKqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MN6XSDTX6vFLfSchHzkJdRpB/6A7wMKlXi4DaznYqJzTvXIqPtraww4x6Oj9HVVnz
	 27JaVUZBp3FSYwXirY0MnoH6cmqkPg/CflbswnayI4iGEsWa/JfFvEXzCUmbBv2+2L
	 zAvjLVbAtvNXzrSDjXHhEnkRObSI+VEf0t1jS+Xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbfDXPAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730764AbfDXOd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:33:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1934D2089F;
        Wed, 24 Apr 2019 14:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116438;
        bh=AoPO4MTVU1qmifn1GeWJngGod9fvtCqvhwWiaAFIKqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vPqywQ9lGifvefYotoT+Rxt5opKGijwhtl4Nbm/NzAwz04EaxkOoXJ9G3Nul2xZBg
         zUP8Qy4KZLBdvjh8Obmvpzfp5sFRArLavjGyg5G3DzwKJ6e3PZbjL6XUTnN38BHzJd
         +LUqStJrfRlRvuwPdCH6Nnbfq2G2lUTNAj8AZUbc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 07/66] ARM: OMAP2+: add missing of_node_put after of_device_is_available
Date:   Wed, 24 Apr 2019 10:32:41 -0400
Message-Id: <20190424143341.27665-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

[ Upstream commit 30645307e5d2c8a4caf978558c66121ac91ad17e ]

Add an of_node_put when a tested device node is not available.

The semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
identifier f;
local idexpression e;
expression x;
@@

e = f(...);
... when != of_node_put(e)
    when != x = e
    when != e = x
    when any
if (<+...of_device_is_available(e)...+>) {
  ... when != of_node_put(e)
(
  return e;
|
+ of_node_put(e);
  return ...;
)
}
// </smpl>

Fixes: e0c827aca0730 ("drm/omap: Populate DSS children in omapdss driver")
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/arm/mach-omap2/display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 1444b4b4bd9f..439e143cad7b 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -250,8 +250,10 @@ static int __init omapdss_init_of(void)
 	if (!node)
 		return 0;
 
-	if (!of_device_is_available(node))
+	if (!of_device_is_available(node)) {
+		of_node_put(node);
 		return 0;
+	}
 
 	pdev = of_find_device_by_node(node);
 
-- 
2.19.1

