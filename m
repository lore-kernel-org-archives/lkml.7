Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCE7C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C187B20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dyO6nWGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfGPE6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 00:58:00 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54087 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfGPE57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 00:57:59 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 71BE0581;
        Tue, 16 Jul 2019 00:57:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 16 Jul 2019 00:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=SuEgE+L8xMm3Mly0DfRGwh3ZCrBzT
        Wh6utlTQgfTteo=; b=dyO6nWGgGOQD37tisW9PUE+f4G/QSvkiU+Pg+WFSdXglK
        fekt0cdZ7E88u0z8AO8TqwD85+MSNnfk4fJhwe8Hlf9Ix+0f26Pe5wpReAwE3Gs2
        ohg9D5f5d2KKTIdJZrLQM12fHGLkDdmYEzaYt/s2MYw8x9bHLu0VomAEkUDr3LZG
        XrYXYONf2S7CBG1hiNgrWdQPtHs5HnuqhAmtSrYbNecokW9mg53yCE+ph+HQtuMv
        4YyX/h8b5E4oJNRcui5JSCC4yPnulRKYlhM5aaA8VvdctIK15oxCBNHSLi5IVK4K
        02cORbbdAhhgu3iGwJ+nd0Y4Vz07uEX0Rq1JEhnRg==
X-ME-Sender: <xms:U1ktXSoua7xhjOJaXO1-FzH9beo_tsN9ye09MtCF_zVMuXh-8gyXxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrheelgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkgggtugesthdtredttddtvdenucfhrhhomhepuegvnhhjrghmihhn
    ucfuhhgvrhhmrghnuceosggvnhhjrghmihhnsegsvghnshhhvghrmhgrnhdrihhoqeenuc
    fkphepuddvledrudeiuddrvddvledrleeinecurfgrrhgrmhepmhgrihhlfhhrohhmpegs
    vghnjhgrmhhinhessggvnhhshhgvrhhmrghnrdhiohenucevlhhushhtvghrufhiiigvpe
    dt
X-ME-Proxy: <xmx:U1ktXXnBt5R05clrAqJuD-ck_DiTR9rhsov0LfoaAqHL2bEGub1zkA>
    <xmx:U1ktXcRoi2XpNP7uurWUbaK6eQkgAhQxyeQxn3fwLzBBd-wDn6-yzA>
    <xmx:U1ktXZDr4S1oTfbvCe2VIZKEIT_o25PMVp7XTs36IRxleGsKkpnm4w>
    <xmx:VFktXS6CElwKM3ER2q2EeXWfnqGunD8-kLS9t3GDFsZ3thLawkAjPQ>
Received: from valkyrie-mobile.localdomain (resnet-netreg-351.dynamic.rpi.edu [129.161.229.96])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6C183380087;
        Tue, 16 Jul 2019 00:57:55 -0400 (EDT)
Date:   Tue, 16 Jul 2019 00:57:55 -0400
From:   Benjamin Sherman <benjamin@bensherman.io>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: change alignment to match parenthesis
Message-ID: <20190716045754.fivh5n44bybe2uce@valkyrie-mobile.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change indentation to match parentheses.  This complies with the Linux
kernel coding style and improves readability.

Signed-off-by: Benjamin Sherman <benjamin@bensherman.io>
---
 drivers/staging/vt6656/rxtx.c    | 10 +++++-----
 drivers/staging/vt6656/usbpipe.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 9def0748ffee..4e9cfacf75f2 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -287,12 +287,12 @@ static u16 vnt_rxtx_datahead_g(struct vnt_usb_send_context *tx_context,
 		buf->duration_a = vnt_get_duration_le(priv,
 						tx_context->pkt_type, need_ack);
 		buf->duration_b = vnt_get_duration_le(priv,
-							PK_TYPE_11B, need_ack);
+						      PK_TYPE_11B, need_ack);
 	}
 
 	buf->time_stamp_off_a = vnt_time_stamp_off(priv, rate);
 	buf->time_stamp_off_b = vnt_time_stamp_off(priv,
-					priv->top_cck_basic_rate);
+						   priv->top_cck_basic_rate);
 
 	tx_context->tx_hdr_size = vnt_mac_hdr_pos(tx_context, &buf->hdr);
 
@@ -325,7 +325,7 @@ static u16 vnt_rxtx_datahead_g_fb(struct vnt_usb_send_context *tx_context,
 
 	buf->time_stamp_off_a = vnt_time_stamp_off(priv, rate);
 	buf->time_stamp_off_b = vnt_time_stamp_off(priv,
-						priv->top_cck_basic_rate);
+						   priv->top_cck_basic_rate);
 
 	tx_context->tx_hdr_size = vnt_mac_hdr_pos(tx_context, &buf->hdr);
 
@@ -655,7 +655,7 @@ static u16 vnt_rxtx_ab(struct vnt_usb_send_context *tx_context,
 	u8 need_ack = tx_context->need_ack;
 
 	buf->rrv_time = vnt_rxtx_rsvtime_le16(priv, tx_context->pkt_type,
-			frame_len, current_rate, need_ack);
+					      frame_len, current_rate, need_ack);
 
 	if (need_mic)
 		head = &tx_head->tx_ab.tx.mic.head;
@@ -1036,7 +1036,7 @@ static int vnt_beacon_xmit(struct vnt_private *priv, struct sk_buff *skb)
 
 		/* Get Duration and TimeStampOff */
 		short_head->duration = vnt_get_duration_le(priv,
-						PK_TYPE_11B, false);
+							   PK_TYPE_11B, false);
 		short_head->time_stamp_off =
 			vnt_time_stamp_off(priv, current_rate);
 	}
diff --git a/drivers/staging/vt6656/usbpipe.c b/drivers/staging/vt6656/usbpipe.c
index ff351a7a0876..d3304df6bd53 100644
--- a/drivers/staging/vt6656/usbpipe.c
+++ b/drivers/staging/vt6656/usbpipe.c
@@ -216,7 +216,7 @@ static void vnt_submit_rx_urb_complete(struct urb *urb)
 		}
 
 		urb->transfer_buffer = skb_put(rcb->skb,
-						skb_tailroom(rcb->skb));
+					       skb_tailroom(rcb->skb));
 	}
 
 	if (usb_submit_urb(urb, GFP_ATOMIC)) {
-- 
2.22.0

