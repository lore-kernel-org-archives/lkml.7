Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F78C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5612A208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfD0PQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:16:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34188 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727669AbfD0PPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:38 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP38-0000zQ-KE; Sat, 27 Apr 2019 16:15:34 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2i-0004SM-VA; Sat, 27 Apr 2019 16:15:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        "Manfred Schlaegl" <manfred.schlaegl@ginzinger.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.980685267@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 059/202] can: dev: __can_get_echo_skb(): fix bogous
 check for non-existing skb by removing it
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>

commit 7b12c8189a3dc50638e7d53714c88007268d47ef upstream.

This patch revert commit 7da11ba5c506
("can: dev: __can_get_echo_skb(): print error message, if trying to echo non existing skb")

After introduction of this change we encountered following new error
message on various i.MX plattforms (flexcan):

| flexcan 53fc8000.can can0: __can_get_echo_skb: BUG! Trying to echo non
| existing skb: can_priv::echo_skb[0]

The introduction of the message was a mistake because
priv->echo_skb[idx] = NULL is a perfectly valid in following case: If
CAN_RAW_LOOPBACK is disabled (setsockopt) in applications, the pkt_type
of the tx skb's given to can_put_echo_skb is set to PACKET_LOOPBACK. In
this case can_put_echo_skb will not set priv->echo_skb[idx]. It is
therefore kept NULL.

As additional argument for revert: The order of check and usage of idx
was changed. idx is used to access an array element before checking it's
boundaries.

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Fixes: 7da11ba5c506 ("can: dev: __can_get_echo_skb(): print error message, if trying to echo non existing skb")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/dev.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -425,8 +425,6 @@ EXPORT_SYMBOL_GPL(can_put_echo_skb);
 struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	struct sk_buff *skb = priv->echo_skb[idx];
-	struct canfd_frame *cf;
 
 	if (idx >= priv->echo_skb_max) {
 		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
@@ -434,20 +432,21 @@ struct sk_buff *__can_get_echo_skb(struc
 		return NULL;
 	}
 
-	if (!skb) {
-		netdev_err(dev, "%s: BUG! Trying to echo non existing skb: can_priv::echo_skb[%u]\n",
-			   __func__, idx);
-		return NULL;
-	}
+	if (priv->echo_skb[idx]) {
+		/* Using "struct canfd_frame::len" for the frame
+		 * length is supported on both CAN and CANFD frames.
+		 */
+		struct sk_buff *skb = priv->echo_skb[idx];
+		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+		u8 len = cf->len;
 
-	/* Using "struct canfd_frame::len" for the frame
-	 * length is supported on both CAN and CANFD frames.
-	 */
-	cf = (struct canfd_frame *)skb->data;
-	*len_ptr = cf->len;
-	priv->echo_skb[idx] = NULL;
+		*len_ptr = len;
+		priv->echo_skb[idx] = NULL;
+
+		return skb;
+	}
 
-	return skb;
+	return NULL;
 }
 
 /*

