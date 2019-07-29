Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AC6C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4332171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428542;
	bh=qH/dvaMAX7TlCmF1Q9+lHFYVWEHaHq5SWRfl7w0ltes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OLbfqu+QX+98Ib2O1EiJWRAKsM5vcTIXBZC8uykaBrjf6MLRz8Bru2Uvr2dKTEB4f
	 Zyq3ZGX31OwrVul9ciRYmX/7gNiLmFEaMkVubUIOYmFWrosRrYsv0DgjMkKmmNZqyO
	 H2OeGWMivhVXFcjkkro2q+pRQzSjcV+FNInk6SlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfG2T3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:29:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730046AbfG2T25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:28:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C33812070B;
        Mon, 29 Jul 2019 19:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428536;
        bh=qH/dvaMAX7TlCmF1Q9+lHFYVWEHaHq5SWRfl7w0ltes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PNuBXDz/ZxFtOPlbAtgIMEnVkQkTkzzFDhGzTMp1b9iAPpCoaOgL63kbBQxUL6s6s
         DL2jk7Z6poKLFdfuCFN8WEo/y184DYhzEvR28lxTvBor7O56FoIEfRHxC5ia2S72Q5
         VyO+Lpf24uMz5Vbt2M59bpOAewrp8OIL7+aBcYgg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Carey Sonsino <csonsino@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 100/293] Bluetooth: validate BLE connection interval updates
Date:   Mon, 29 Jul 2019 21:19:51 +0200
Message-Id: <20190729190832.302531195@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c49a8682fc5d298d44e8d911f4fa14690ea9485e ]

Problem: The Linux Bluetooth stack yields complete control over the BLE
connection interval to the remote device.

The Linux Bluetooth stack provides access to the BLE connection interval
min and max values through /sys/kernel/debug/bluetooth/hci0/
conn_min_interval and /sys/kernel/debug/bluetooth/hci0/conn_max_interval.
These values are used for initial BLE connections, but the remote device
has the ability to request a connection parameter update. In the event
that the remote side requests to change the connection interval, the Linux
kernel currently only validates that the desired value is within the
acceptable range in the Bluetooth specification (6 - 3200, corresponding to
7.5ms - 4000ms). There is currently no validation that the desired value
requested by the remote device is within the min/max limits specified in
the conn_min_interval/conn_max_interval configurations. This essentially
leads to Linux yielding complete control over the connection interval to
the remote device.

The proposed patch adds a verification step to the connection parameter
update mechanism, ensuring that the desired value is within the min/max
bounds of the current connection. If the desired value is outside of the
current connection min/max values, then the connection parameter update
request is rejected and the negative response is returned to the remote
device. Recall that the initial connection is established using the local
conn_min_interval/conn_max_interval values, so this allows the Linux
administrator to retain control over the BLE connection interval.

The one downside that I see is that the current default Linux values for
conn_min_interval and conn_max_interval typically correspond to 30ms and
50ms respectively. If this change were accepted, then it is feasible that
some devices would no longer be able to negotiate to their desired
connection interval values. This might be remedied by setting the default
Linux conn_min_interval and conn_max_interval values to the widest
supported range (6 - 3200 / 7.5ms - 4000ms). This could lead to the same
behavior as the current implementation, where the remote device could
request to change the connection interval value to any value that is
permitted by the Bluetooth specification, and Linux would accept the
desired value.

Signed-off-by: Carey Sonsino <csonsino@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c  | 5 +++++
 net/bluetooth/l2cap_core.c | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 363dc85bbc5c..3d2f64a6d623 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5089,6 +5089,11 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_UNKNOWN_CONN_ID);
 
+	if (min < hcon->le_conn_min_interval ||
+	    max > hcon->le_conn_max_interval)
+		return send_conn_param_neg_reply(hdev, handle,
+						 HCI_ERROR_INVALID_LL_PARAMS);
+
 	if (hci_check_conn_params(min, max, latency, timeout))
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_INVALID_LL_PARAMS);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0c2219f483d7..4dc1db85a9c2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5287,7 +5287,14 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	err = hci_check_conn_params(min, max, latency, to_multiplier);
+	if (min < hcon->le_conn_min_interval ||
+	    max > hcon->le_conn_max_interval) {
+		BT_DBG("requested connection interval exceeds current bounds.");
+		err = -EINVAL;
+	} else {
+		err = hci_check_conn_params(min, max, latency, to_multiplier);
+	}
+
 	if (err)
 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
 	else
-- 
2.20.1



