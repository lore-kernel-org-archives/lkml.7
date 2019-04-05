Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C957C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E8120651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hTfCem0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbfDER3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:29:13 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56332 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731710AbfDER3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:29:06 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35HT3GV131024;
        Fri, 5 Apr 2019 12:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554485343;
        bh=QfKLSOWpaNEAmUiFaUOcU4SMCjMPov4tmkM4IrTqZgA=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=hTfCem0b3sOeedFAhoLkLYnREXd/aBCpn2YHISMasVZAfl62uFSj39CK4XDlorKBE
         kaU/HPClBvCMo4i0fhksmBOdYQAIu6xSuOxoLLHUjkqsCnSo0ybcfuYUqb7LaU4Hqd
         z4kep1U9y7Fics/gexiPFHkahOsFjExLEYzt0YBU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35HT3pH097042
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 12:29:03 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 12:29:02 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 12:29:02 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35HSsub095744;
        Fri, 5 Apr 2019 12:29:02 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arvid.brodin@alten.se>,
        <a-kramer@ti.com>
Subject: [PATCH net 14/14] net: hsr: Fix node prune function for forget time expiry
Date:   Fri, 5 Apr 2019 13:31:36 -0400
Message-ID: <20190405173136.18050-15-m-karicheri2@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190405173136.18050-1-m-karicheri2@ti.com>
References: <20190405173136.18050-1-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Kramer <a-kramer@ti.com>

HSR should forget nodes after configured node forget time expiry based
on HSR_NODE_FORGET_TIME. As part of hsr_prune_nodes(), code checks to
see if entries are to be flushed out if not heard for longer than forget
time. But currently hsr_prune_nodes() is called only once during device
creation. Restart the timer at the end of hsr_prune_nodes() so that
hsr_prune_nodes() gets called periodically and forgotten entries are
removed from node table.

Signed-off-by: Aaron Kramer <a-kramer@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/hsr_framereg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index a3cc30ac8a5a..9fa9abd83018 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -405,6 +405,10 @@ void hsr_prune_nodes(struct timer_list *t)
 		}
 	}
 	rcu_read_unlock();
+
+	/* Restart timer */
+	mod_timer(&hsr->prune_timer,
+		  jiffies + msecs_to_jiffies(PRUNE_PERIOD));
 }
 
 void *hsr_get_next_node(struct hsr_priv *hsr, void *_pos,
-- 
2.17.0

