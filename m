Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D228EC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BB020657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfFQLut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:50:49 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:43430 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfFQLut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:50:49 -0400
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id Rnql2000j3XaVaC01nqmYk; Mon, 17 Jun 2019 13:50:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcq9t-0001Ul-TG; Mon, 17 Jun 2019 13:50:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcq9t-00019x-QS; Mon, 17 Jun 2019 13:50:45 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Geoff Levand <geoff@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ps3_gelic: Use [] to denote a flexible array member
Date:   Mon, 17 Jun 2019 13:50:44 +0200
Message-Id: <20190617115044.4406-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flexible array members should be denoted using [] instead of [0], else
gcc will not warn when they are no longer at the end of a struct.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/toshiba/ps3_gelic_net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.h b/drivers/net/ethernet/toshiba/ps3_gelic_net.h
index 3ecddb72f45aa80f..051033580f0a6f9e 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.h
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.h
@@ -301,7 +301,7 @@ struct gelic_card {
 	 */
 	unsigned int irq;
 	struct gelic_descr *tx_top, *rx_top;
-	struct gelic_descr descr[0]; /* must be the last */
+	struct gelic_descr descr[]; /* must be the last */
 };
 
 struct gelic_port {
-- 
2.17.1

