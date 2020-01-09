Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9D3C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8B62072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbgAIMXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:23:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:35272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729266AbgAIMXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:23:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9BD19B2180;
        Thu,  9 Jan 2020 12:23:44 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Paul Burton <paulburton@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] MIPS: SGI-IP27: Fix node_distance
Date:   Thu,  9 Jan 2020 13:23:29 +0100
Message-Id: <20200109122331.4109-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

node_distance must return values starting from 10 up to 255. 10 means
local, 255 unreachable.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/sgi-ip27/ip27-memory.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 563aad5e6398..a0c717662eb1 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -148,25 +148,25 @@ static int __init compute_node_distance(nasid_t nasid_a, nasid_t nasid_b)
 		} while ((brd = find_lboard_class(KLCF_NEXT(brd), KLTYPE_ROUTER)));
 	}
 
+	if (nasid_a == nasid_b)
+		return LOCAL_DISTANCE;
+
+	if (router_a == router_b)
+		return LOCAL_DISTANCE + 1;
+
 	if (router_a == NULL) {
 		pr_info("node_distance: router_a NULL\n");
-		return -1;
+		return 255;
 	}
 	if (router_b == NULL) {
 		pr_info("node_distance: router_b NULL\n");
-		return -1;
+		return 255;
 	}
 
-	if (nasid_a == nasid_b)
-		return 0;
-
-	if (router_a == router_b)
-		return 1;
-
 	router_distance = 100;
 	router_recurse(router_a, router_b, 2);
 
-	return router_distance;
+	return LOCAL_DISTANCE + router_distance;
 }
 
 static void __init init_topology_matrix(void)
-- 
2.24.1

