Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A304C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089FE21D7E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213240;
	bh=Bg1NB1Okm9z6Vy/N4uGACFmVAuYujxub6R0M02NRtRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hjpijci61xaf7xljqLmqf/QIFSYaukv1Qcv4ZTa8oSVP58XMn3zMOaUC7VLXsddvi
	 Z2d3AScWyGWzYfh0CjrTpWGxkd83y1103KOvwwgfNKPGVP0Y3yEw4OsVRjdMam0Q+x
	 ME4K4C+pjqqDlyIfNgrDOR0VEmy8UYwAEmTIttkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbfKHLkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:40:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388776AbfKHLkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:40:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEF0221D7E;
        Fri,  8 Nov 2019 11:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213235;
        bh=Bg1NB1Okm9z6Vy/N4uGACFmVAuYujxub6R0M02NRtRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6FHxKOHhap1OYwyP6XjZEjgBR0mDIu2IX7eHKXHQppP2N0+UhycbgD7Y+tEeEwzn
         BSTZP8MDSgx8SkoIA1Y2N3NYzfchweD6PMHW0Z7P6R4BLvMSoUNy9moNX3ZrnT/X4n
         ktBfSMJvkF9TuNGSp0YsDiBYiSqjMHjPFNYcGUrA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 105/205] of: make PowerMac cache node search conditional on CONFIG_PPC_PMAC
Date:   Fri,  8 Nov 2019 06:36:12 -0500
Message-Id: <20191108113752.12502-105-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit f6707fd6241e483f6fea2caae82d876e422bb11a ]

Cache nodes under the cpu node(s) is PowerMac specific according to the
comment above, so make the code enforce that.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 3f21ea6a90dcb..f0dbb7ad88cf6 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2066,7 +2066,7 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
 	/* OF on pmac has nodes instead of properties named "l2-cache"
 	 * beneath CPU nodes.
 	 */
-	if (!strcmp(np->type, "cpu"))
+	if (IS_ENABLED(CONFIG_PPC_PMAC) && !strcmp(np->type, "cpu"))
 		for_each_child_of_node(np, child)
 			if (!strcmp(child->type, "cache"))
 				return child;
-- 
2.20.1

