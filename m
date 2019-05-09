Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398F6C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE5520578
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428194;
	bh=wRPFeyce9M4vuMa0CFMDtgaGsnXeBo/NOGwadyRg36E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uzAk2yjmYMaYLdXnRutaY4CG0kR1Hy7S6d6jTq2RKtflmzJzMqCPtFffbu+xx3zV/
	 mPavPgaYcoezIQSD0ts59n2hAMJ84JWfdK3SPOkJJtBM6bPh9IBB9LH65gypXz1v0w
	 /VWdTRTsfDGT4pQDOmPBaMwkNHDxqgqwd8WQ/N0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfEIS4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728655AbfEISy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:54:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6409204FD;
        Thu,  9 May 2019 18:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557428097;
        bh=wRPFeyce9M4vuMa0CFMDtgaGsnXeBo/NOGwadyRg36E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=htVXjRPdqMkG87c4KRn+A7yw66ktSVaO8XtZVPi+f8tlBnmes+O424Qpq4Vh+Au/V
         7Q5MooLBcRsP/chF5INkWC5nVVpixBbRZMd58qa5SCTAoIZmytM/tFBlSD2WUkb5uM
         i91yJYvwb/pCndqr3KS/Hi7urxgXKVfsnmeeplMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 5.1 24/30] Bluetooth: Fix not initializing L2CAP tx_credits
Date:   Thu,  9 May 2019 20:42:56 +0200
Message-Id: <20190509181256.147670995@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181250.417203112@linuxfoundation.org>
References: <20190509181250.417203112@linuxfoundation.org>
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
@@ -5532,11 +5532,10 @@ static int l2cap_le_connect_req(struct l
 	chan->dcid = scid;
 	chan->omtu = mtu;
 	chan->remote_mps = mps;
-	chan->tx_credits = __le16_to_cpu(req->credits);
 
 	__l2cap_chan_add(conn, chan);
 
-	l2cap_le_flowctl_init(chan);
+	l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
 
 	dcid = chan->scid;
 	credits = chan->rx_credits;


