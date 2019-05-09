Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85515C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A60020578
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428019;
	bh=+MeY4MgWJ4dyuu9ZqGGVbumkiUOWOv10xp0i2fvugKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BHlnTF9OPX6q012mPyRuADBY9979HKLc119TounAPFtlBaK1pnFy2a+kxK/WYLOHb
	 b1UakSR+kUW7BGKBakhWJy0vHqrbiX9kmA+wC5d8QTNHobuvFvEzEvC9SfnhzVvrAr
	 1T5Ui2gpGSuUkjLGvMdlo6ZQZCvcaf2/D2vyYVGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfEISxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbfEISxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:53:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE09720578;
        Thu,  9 May 2019 18:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557428013;
        bh=+MeY4MgWJ4dyuu9ZqGGVbumkiUOWOv10xp0i2fvugKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=up2j3GlecNp4ZxCG+16ZFmDXzApFyVBEJDQH1mrTYxUZ1hlrKcEHngZh8H4f2ctCP
         Qk5xPc053GLZmtaVjoXsHMP+yf1SCPAc/cwTe4R2fFM/8GASCOS5XtbY7U8yiL5KL1
         3ihS3qyaXlclDR/G0x4JJAlZwtsjHwUrGeImlgOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 5.0 89/95] Bluetooth: Fix not initializing L2CAP tx_credits
Date:   Thu,  9 May 2019 20:42:46 +0200
Message-Id: <20190509181315.467602708@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181309.180685671@linuxfoundation.org>
References: <20190509181309.180685671@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit ba8f5289f706aed94cc95b15cc5b89e22062f61f upstream.

l2cap_le_flowctl_init was reseting the tx_credits which works only for
outgoing connection since that set the tx_credits on the response, for
incoming connections that was not the case which leaves the channel
without any credits causing it to be suspended.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org # 4.20+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bluetooth/l2cap_core.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -510,12 +510,12 @@ void l2cap_chan_set_defaults(struct l2ca
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_set_defaults);
 
-static void l2cap_le_flowctl_init(struct l2cap_chan *chan)
+static void l2cap_le_flowctl_init(struct l2cap_chan *chan, u16 tx_credits)
 {
 	chan->sdu = NULL;
 	chan->sdu_last_frag = NULL;
 	chan->sdu_len = 0;
-	chan->tx_credits = 0;
+	chan->tx_credits = tx_credits;
 	/* Derive MPS from connection MTU to stop HCI fragmentation */
 	chan->mps = min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_SIZE);
 	/* Give enough credits for a full packet */
@@ -1281,7 +1281,7 @@ static void l2cap_le_connect(struct l2ca
 	if (test_and_set_bit(FLAG_LE_CONN_REQ_SENT, &chan->flags))
 		return;
 
-	l2cap_le_flowctl_init(chan);
+	l2cap_le_flowctl_init(chan, 0);
 
 	req.psm     = chan->psm;
 	req.scid    = cpu_to_le16(chan->scid);
@@ -5531,11 +5531,10 @@ static int l2cap_le_connect_req(struct l
 	chan->dcid = scid;
 	chan->omtu = mtu;
 	chan->remote_mps = mps;
-	chan->tx_credits = __le16_to_cpu(req->credits);
 
 	__l2cap_chan_add(conn, chan);
 
-	l2cap_le_flowctl_init(chan);
+	l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
 
 	dcid = chan->scid;
 	credits = chan->rx_credits;


