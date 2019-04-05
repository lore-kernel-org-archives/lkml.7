Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B8EC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4DD20989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j1+BcZqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbfDER3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:29:03 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39404 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731312AbfDER3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:29:01 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35HSw5R084537;
        Fri, 5 Apr 2019 12:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554485338;
        bh=7vl9QsZBI7rn+nw2qyaZwcXLNHVDgEKsBckiOI+Th+4=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=j1+BcZqNycYi1PNy6HRGj9KASmAer+QzVP3UE/BiurnRDxhLsYxgTNy3UkZY0CQS5
         Ha6hf56zWxBpYHdEDl/PYs9JX6n3zZDAeq8Sz1/KPkkk80TPGtzgMGyuyITbP/N9OE
         Xf8ocKOjAtvOdsMSUiUluEQyTidYukKvG0/LDBK0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35HSwRH095593
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 12:28:58 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 12:28:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 12:28:57 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35HSsuS095744;
        Fri, 5 Apr 2019 12:28:57 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arvid.brodin@alten.se>,
        <a-kramer@ti.com>
Subject: [PATCH net 05/14] net: hsr: fix lines that ends with a '('
Date:   Fri, 5 Apr 2019 13:31:27 -0400
Message-ID: <20190405173136.18050-6-m-karicheri2@ti.com>
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

This patch fixes function calls that ends with '(' in a line.
This is seen when ran checkpatch.pl -f option on files under
net/hsr.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/hsr_device.c | 7 +++----
 net/hsr/hsr_main.h   | 5 ++---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 0aea1bd09526..567c890f08a5 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -254,10 +254,9 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 
 	hlen = LL_RESERVED_SPACE(master->dev);
 	tlen = master->dev->needed_tailroom;
-	skb = dev_alloc_skb(
-			sizeof(struct hsr_tag) +
-			sizeof(struct hsr_sup_tag) +
-			sizeof(struct hsr_sup_payload) + hlen + tlen);
+	skb = dev_alloc_skb(sizeof(struct hsr_tag) +
+			    sizeof(struct hsr_sup_tag) +
+			    sizeof(struct hsr_sup_payload) + hlen + tlen);
 
 	if (skb == NULL)
 		return;
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 3504f0647942..1b640731d705 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -84,9 +84,8 @@ static inline void set_hsr_tag_path(struct hsr_tag *ht, u16 path)
 
 static inline void set_hsr_tag_LSDU_size(struct hsr_tag *ht, u16 LSDU_size)
 {
-	ht->path_and_LSDU_size = htons(
-			(ntohs(ht->path_and_LSDU_size) & 0xF000) |
-			(LSDU_size & 0x0FFF));
+	ht->path_and_LSDU_size = htons((ntohs(ht->path_and_LSDU_size) &
+				       0xF000) | (LSDU_size & 0x0FFF));
 }
 
 struct hsr_ethhdr {
-- 
2.17.0

