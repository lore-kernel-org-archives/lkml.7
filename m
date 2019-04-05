Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E3BC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43E320651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JnNnH1Dh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbfDERaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:30:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48590 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731654AbfDER3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:29:02 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35HSxMH063310;
        Fri, 5 Apr 2019 12:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554485339;
        bh=uFCOQADwaq6+SkPcWh4kCk5t+sjlrFYsqr7Zct2ZekI=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=JnNnH1DhB9rdikInOQbaO9CAzjNnFafX12gCB0WsKtDSSptI0Qzn4GaY+DyfDzU/1
         3C9KgoAajnTsfu72rWgPBSDajrj8BNAeqdjpZK+SycUdLeQ+MzW0WtumD87lWsrcWR
         5mIVklhxpcej6pAgTmvRkNp6BU5RREHWkiUPRrvk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35HSx9A096255
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 12:28:59 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 12:28:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 12:28:59 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35HSsuV095744;
        Fri, 5 Apr 2019 12:28:59 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arvid.brodin@alten.se>,
        <a-kramer@ti.com>
Subject: [PATCH net 08/14] net: hsr: fix placement of logical operator in a multi-line statement
Date:   Fri, 5 Apr 2019 13:31:30 -0400
Message-ID: <20190405173136.18050-9-m-karicheri2@ti.com>
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

In a multi-line statement exceeding 80 characters, logical operator
should be at the end of a line instead of being at the start. This
is seen when ran checkpatch.pl -f on files under net/hsr. The change
is per suggestion from checkpatch.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/hsr_forward.c  | 8 ++++----
 net/hsr/hsr_framereg.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 71ffbfd6d740..c4dfc2966f62 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -61,8 +61,8 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 		return false;
 
 	/* Correct ether type?. */
-	if (!(ethHdr->h_proto == htons(ETH_P_PRP)
-			|| ethHdr->h_proto == htons(ETH_P_HSR)))
+	if (!(ethHdr->h_proto == htons(ETH_P_PRP) ||
+	      ethHdr->h_proto == htons(ETH_P_HSR)))
 		return false;
 
 	/* Get the supervision header from correct location. */
@@ -327,8 +327,8 @@ static int hsr_fill_frame_info(struct hsr_frame_info *frame,
 		/* FIXME: */
 		WARN_ONCE(1, "HSR: VLAN not yet supported");
 	}
-	if (ethhdr->h_proto == htons(ETH_P_PRP)
-			|| ethhdr->h_proto == htons(ETH_P_HSR)) {
+	if (ethhdr->h_proto == htons(ETH_P_PRP) ||
+	    ethhdr->h_proto == htons(ETH_P_HSR)) {
 		frame->skb_std = NULL;
 		frame->skb_hsr = skb;
 		frame->sequence_nr = hsr_get_skb_sequence_nr(skb);
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 1929a8dfd292..1571ac101757 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -187,8 +187,8 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct sk_buff *skb,
 
 	/* Everyone may create a node entry, connected node to a HSR device. */
 
-	if (ethhdr->h_proto == htons(ETH_P_PRP)
-			|| ethhdr->h_proto == htons(ETH_P_HSR)) {
+	if (ethhdr->h_proto == htons(ETH_P_PRP) ||
+	    ethhdr->h_proto == htons(ETH_P_HSR)) {
 		/* Use the existing sequence_nr from the tag as starting point
 		 * for filtering duplicate frames.
 		 */
-- 
2.17.0

