Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00096C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB87217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909359;
	bh=9zGqA4B1g3QaGU2Z3GNj3bpJbbI4yM4ggpfpcP+YiR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r0gFtM7H10QqRcMt/1lWEPpUMx7UnznSoX4s/Wzjjy9AAvFpn+HIChhUL+OniHbCF
	 mmILy72x43Uirz4Mo/5OKtFmZrClYwXSwJJJIBu3PF5UTeRAqLr9YqEQAl77J6fKXG
	 waYYjOplSJr/5Xs1yY9sbRS9Gr4m30/4rIdNT/NI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbfC3B3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730890AbfC3B3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:29:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6755217F5;
        Sat, 30 Mar 2019 01:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909352;
        bh=9zGqA4B1g3QaGU2Z3GNj3bpJbbI4yM4ggpfpcP+YiR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LROa4g4JSL035ZAGDJpq/X2Fk9KVLo0tUBQn0ywl0dq7XL5k5HFHc3/VPPFbiwp4V
         Ue5b34VmXCJ7uWNGo5+/vUEj6qdp3JRt2pk8oPbyziu30x8m1ID3Je/cKxnUAXOA4B
         v4u6OOSm3ATs89RomavweeEIgu6p/3XGBF0mBAkI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matias Karhumaa <matias.karhumaa@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 13/57] Bluetooth: Fix debugfs NULL pointer dereference
Date:   Fri, 29 Mar 2019 21:28:06 -0400
Message-Id: <20190330012854.32212-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330012854.32212-1-sashal@kernel.org>
References: <20190330012854.32212-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matias Karhumaa <matias.karhumaa@gmail.com>

[ Upstream commit 30d65e0804d58a03d1a8ea4e12c6fc07ed08218b ]

Fix crash caused by NULL pointer dereference when debugfs functions
le_max_key_read, le_max_key_size_write, le_min_key_size_read or
le_min_key_size_write and Bluetooth adapter was powered off.

Fix is to move max_key_size and min_key_size from smp_dev to hci_dev.
At the same time they were renamed to le_max_key_size and
le_min_key_size.

BUG: unable to handle kernel NULL pointer dereference at 00000000000002e8
PGD 0 P4D 0
Oops: 0000 [#24] SMP PTI
CPU: 2 PID: 6255 Comm: cat Tainted: G      D    OE     4.18.9-200.fc28.x86_64 #1
Hardware name: LENOVO 4286CTO/4286CTO, BIOS 8DET76WW (1.46 ) 06/21/2018
RIP: 0010:le_max_key_size_read+0x45/0xb0 [bluetooth]
Code: 00 00 00 48 83 ec 10 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 48 8b 87 c8 00 00 00 48 8d 7c 24 04 48 8b 80 48 0a 00 00 <48> 8b 80 e8 02 00 00 0f b6 48 52 e8 fb b6 b3 ed be 04 00 00 00 48
RSP: 0018:ffffab23c3ff3df0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00007f0b4ca2e000 RCX: ffffab23c3ff3f08
RDX: ffffffffc0ddb033 RSI: 0000000000000004 RDI: ffffab23c3ff3df4
RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffab23c3ff3ed8 R11: 0000000000000000 R12: ffffab23c3ff3f08
R13: 00007f0b4ca2e000 R14: 0000000000020000 R15: ffffab23c3ff3f08
FS:  00007f0b4ca0f540(0000) GS:ffff91bd5e280000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000002e8 CR3: 00000000629fa006 CR4: 00000000000606e0
Call Trace:
 full_proxy_read+0x53/0x80
 __vfs_read+0x36/0x180
 vfs_read+0x8a/0x140
 ksys_read+0x4f/0xb0
 do_syscall_64+0x5b/0x160
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Matias Karhumaa <matias.karhumaa@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         |  2 ++
 net/bluetooth/smp.c              | 23 +++++++++--------------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0db1b9b428b7..1dfb75057580 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -259,6 +259,8 @@ struct hci_dev {
 	__u16		le_max_tx_time;
 	__u16		le_max_rx_len;
 	__u16		le_max_rx_time;
+	__u8		le_max_key_size;
+	__u8		le_min_key_size;
 	__u16		discov_interleaved_timeout;
 	__u16		conn_info_min_age;
 	__u16		conn_info_max_age;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 74b29c7d841c..a06f03047717 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3084,6 +3084,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->le_max_tx_time = 0x0148;
 	hdev->le_max_rx_len = 0x001b;
 	hdev->le_max_rx_time = 0x0148;
+	hdev->le_max_key_size = SMP_MAX_ENC_KEY_SIZE;
+	hdev->le_min_key_size = SMP_MIN_ENC_KEY_SIZE;
 	hdev->le_tx_def_phys = HCI_LE_SET_PHY_1M;
 	hdev->le_rx_def_phys = HCI_LE_SET_PHY_1M;
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 73f7211d0431..a1c1b7e8a45c 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -88,9 +88,6 @@ struct smp_dev {
 	u8			local_rand[16];
 	bool			debug_key;
 
-	u8			min_key_size;
-	u8			max_key_size;
-
 	struct crypto_cipher	*tfm_aes;
 	struct crypto_shash	*tfm_cmac;
 	struct crypto_kpp	*tfm_ecdh;
@@ -720,7 +717,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 	if (rsp == NULL) {
 		req->io_capability = conn->hcon->io_capability;
 		req->oob_flag = oob_flag;
-		req->max_key_size = SMP_DEV(hdev)->max_key_size;
+		req->max_key_size = hdev->le_max_key_size;
 		req->init_key_dist = local_dist;
 		req->resp_key_dist = remote_dist;
 		req->auth_req = (authreq & AUTH_REQ_MASK(hdev));
@@ -731,7 +728,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 
 	rsp->io_capability = conn->hcon->io_capability;
 	rsp->oob_flag = oob_flag;
-	rsp->max_key_size = SMP_DEV(hdev)->max_key_size;
+	rsp->max_key_size = hdev->le_max_key_size;
 	rsp->init_key_dist = req->init_key_dist & remote_dist;
 	rsp->resp_key_dist = req->resp_key_dist & local_dist;
 	rsp->auth_req = (authreq & AUTH_REQ_MASK(hdev));
@@ -745,7 +742,7 @@ static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
 	struct hci_dev *hdev = conn->hcon->hdev;
 	struct smp_chan *smp = chan->data;
 
-	if (max_key_size > SMP_DEV(hdev)->max_key_size ||
+	if (max_key_size > hdev->le_max_key_size ||
 	    max_key_size < SMP_MIN_ENC_KEY_SIZE)
 		return SMP_ENC_KEY_SIZE;
 
@@ -3264,8 +3261,6 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 	smp->tfm_aes = tfm_aes;
 	smp->tfm_cmac = tfm_cmac;
 	smp->tfm_ecdh = tfm_ecdh;
-	smp->min_key_size = SMP_MIN_ENC_KEY_SIZE;
-	smp->max_key_size = SMP_MAX_ENC_KEY_SIZE;
 
 create_chan:
 	chan = l2cap_chan_create();
@@ -3391,7 +3386,7 @@ static ssize_t le_min_key_size_read(struct file *file,
 	struct hci_dev *hdev = file->private_data;
 	char buf[4];
 
-	snprintf(buf, sizeof(buf), "%2u\n", SMP_DEV(hdev)->min_key_size);
+	snprintf(buf, sizeof(buf), "%2u\n", hdev->le_min_key_size);
 
 	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
 }
@@ -3412,11 +3407,11 @@ static ssize_t le_min_key_size_write(struct file *file,
 
 	sscanf(buf, "%hhu", &key_size);
 
-	if (key_size > SMP_DEV(hdev)->max_key_size ||
+	if (key_size > hdev->le_max_key_size ||
 	    key_size < SMP_MIN_ENC_KEY_SIZE)
 		return -EINVAL;
 
-	SMP_DEV(hdev)->min_key_size = key_size;
+	hdev->le_min_key_size = key_size;
 
 	return count;
 }
@@ -3435,7 +3430,7 @@ static ssize_t le_max_key_size_read(struct file *file,
 	struct hci_dev *hdev = file->private_data;
 	char buf[4];
 
-	snprintf(buf, sizeof(buf), "%2u\n", SMP_DEV(hdev)->max_key_size);
+	snprintf(buf, sizeof(buf), "%2u\n", hdev->le_max_key_size);
 
 	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
 }
@@ -3457,10 +3452,10 @@ static ssize_t le_max_key_size_write(struct file *file,
 	sscanf(buf, "%hhu", &key_size);
 
 	if (key_size > SMP_MAX_ENC_KEY_SIZE ||
-	    key_size < SMP_DEV(hdev)->min_key_size)
+	    key_size < hdev->le_min_key_size)
 		return -EINVAL;
 
-	SMP_DEV(hdev)->max_key_size = key_size;
+	hdev->le_max_key_size = key_size;
 
 	return count;
 }
-- 
2.19.1

