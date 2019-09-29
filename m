Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EF3C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CEB21882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765627;
	bh=E0iVFmk+TRTizMteFaTgSFFwpthtzug2PEHrve24fWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mSn8LqyMfyXg+hibmm1WWSvrFBdL1HFNDLjjyPaRef4Z7mRy5RklGYT93CGUUUXl8
	 9W6IJjrN1UrojtxF+8O1KuymrNayu94NDmwLwYckQgkfQMr8bf3sYKm/Dr+lhTmGN0
	 OOHClMAs20syJfAR+fQoXuZFv4TDRChWs8zz736g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfI2OA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729142AbfI2OAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:00:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F87A218AC;
        Sun, 29 Sep 2019 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765617;
        bh=E0iVFmk+TRTizMteFaTgSFFwpthtzug2PEHrve24fWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FtjtwoxLTPIvmT8JX+00xnUx5LU9lqUyjASGBUit7fprtunqbhXG2Vj8Kh8uea7xD
         Dp3/ybXOgYIELXPasyTEk44UXAievWb0V4vvQUOzbD/nV7E4aSMFGG+lahejDsvznl
         ZaB3QfLu2jpNjJb+2i7iln5QhZuH9pQxawMf48Ps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 01/45] Revert "Bluetooth: validate BLE connection interval updates"
Date:   Sun, 29 Sep 2019 15:55:29 +0200
Message-Id: <20190929135024.751205303@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135024.387033930@linuxfoundation.org>
References: <20190929135024.387033930@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Holtmann <marcel@holtmann.org>

[ Upstream commit 68d19d7d995759b96169da5aac313363f92a9075 ]

This reverts commit c49a8682fc5d298d44e8d911f4fa14690ea9485e.

There are devices which require low connection intervals for usable operation
including keyboards and mice. Forcing a static connection interval for
these types of devices has an impact in latency and causes a regression.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c  | 5 -----
 net/bluetooth/l2cap_core.c | 9 +--------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 17c50a98e7f78..9e4fcf406d9cd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5588,11 +5588,6 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_UNKNOWN_CONN_ID);
 
-	if (min < hcon->le_conn_min_interval ||
-	    max > hcon->le_conn_max_interval)
-		return send_conn_param_neg_reply(hdev, handle,
-						 HCI_ERROR_INVALID_LL_PARAMS);
-
 	if (hci_check_conn_params(min, max, latency, timeout))
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_INVALID_LL_PARAMS);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 32d2be9d68585..771e3e17bb6a3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5297,14 +5297,7 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	if (min < hcon->le_conn_min_interval ||
-	    max > hcon->le_conn_max_interval) {
-		BT_DBG("requested connection interval exceeds current bounds.");
-		err = -EINVAL;
-	} else {
-		err = hci_check_conn_params(min, max, latency, to_multiplier);
-	}
-
+	err = hci_check_conn_params(min, max, latency, to_multiplier);
 	if (err)
 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
 	else
-- 
2.20.1



