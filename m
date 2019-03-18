Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F4BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0D9214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901249;
	bh=OK8NdKKlfwWklIJhavrwq5cyYsbRz/CBPE5q8uVm1fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jyx2bgG/fVgiu+rqofTqLxIzc7mzHVKSA6NyFzf8hIbYJCdAedoPk6RmEKfCAprig
	 IcaV4YJd5jCMtQK6qqGuU0BEOyv+vm7fWRBNycVPu5QIOiB4biRH+grSsD3pvPO+We
	 jfmjq2Cr0RvF3HZFeIlGJ2gemGee7vELBvNUsuZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfCRJ12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbfCRJ1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:27:25 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 498762083D;
        Mon, 18 Mar 2019 09:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901243;
        bh=OK8NdKKlfwWklIJhavrwq5cyYsbRz/CBPE5q8uVm1fE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1MbLCO7oyOSkMgPsjxIRXHntcNpbJ3i2Ihsw8HOg/F8JiPfZDR6bjaZjxXXsAt1Ge
         vrXnP2dN/vmXsdQCjhR8QlWaKthn8GalwP2XWUHTp48lvgSS8Ha6TbdrHz6iiV/1/t
         Q0T8mEvaHPISrv8b1MBlXTroMjHFtoUGR5ynFU2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandru Herghelegiu <aherghelegiu@bitdefender.com>,
        =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 29/43] vsock/virtio: fix kernel panic from virtio_transport_reset_no_sock
Date:   Mon, 18 Mar 2019 10:24:21 +0100
Message-Id: <20190318083716.728432293@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083715.877441740@linuxfoundation.org>
References: <20190318083715.877441740@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Adalbert Lazăr" <alazar@bitdefender.com>

[ Upstream commit 4c404ce23358d5d8fbdeb7a6021a9b33d3c3c167 ]

Previous to commit 22b5c0b63f32 ("vsock/virtio: fix kernel panic
after device hot-unplug"), vsock_core_init() was called from
virtio_vsock_probe(). Now, virtio_transport_reset_no_sock() can be called
before vsock_core_init() has the chance to run.

[Wed Feb 27 14:17:09 2019] BUG: unable to handle kernel NULL pointer dereference at 0000000000000110
[Wed Feb 27 14:17:09 2019] #PF error: [normal kernel read fault]
[Wed Feb 27 14:17:09 2019] PGD 0 P4D 0
[Wed Feb 27 14:17:09 2019] Oops: 0000 [#1] SMP PTI
[Wed Feb 27 14:17:09 2019] CPU: 3 PID: 59 Comm: kworker/3:1 Not tainted 5.0.0-rc7-390-generic-hvi #390
[Wed Feb 27 14:17:09 2019] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[Wed Feb 27 14:17:09 2019] Workqueue: virtio_vsock virtio_transport_rx_work [vmw_vsock_virtio_transport]
[Wed Feb 27 14:17:09 2019] RIP: 0010:virtio_transport_reset_no_sock+0x8c/0xc0 [vmw_vsock_virtio_transport_common]
[Wed Feb 27 14:17:09 2019] Code: 35 8b 4f 14 48 8b 57 08 31 f6 44 8b 4f 10 44 8b 07 48 8d 7d c8 e8 84 f8 ff ff 48 85 c0 48 89 c3 74 2a e8 f7 31 03 00 48 89 df <48> 8b 80 10 01 00 00 e8 68 fb 69 ed 48 8b 75 f0 65 48 33 34 25 28
[Wed Feb 27 14:17:09 2019] RSP: 0018:ffffb42701ab7d40 EFLAGS: 00010282
[Wed Feb 27 14:17:09 2019] RAX: 0000000000000000 RBX: ffff9d79637ee080 RCX: 0000000000000003
[Wed Feb 27 14:17:09 2019] RDX: 0000000000000001 RSI: 0000000000000002 RDI: ffff9d79637ee080
[Wed Feb 27 14:17:09 2019] RBP: ffffb42701ab7d78 R08: ffff9d796fae70e0 R09: ffff9d796f403500
[Wed Feb 27 14:17:09 2019] R10: ffffb42701ab7d90 R11: 0000000000000000 R12: ffff9d7969d09240
[Wed Feb 27 14:17:09 2019] R13: ffff9d79624e6840 R14: ffff9d7969d09318 R15: ffff9d796d48ff80
[Wed Feb 27 14:17:09 2019] FS:  0000000000000000(0000) GS:ffff9d796fac0000(0000) knlGS:0000000000000000
[Wed Feb 27 14:17:09 2019] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Wed Feb 27 14:17:09 2019] CR2: 0000000000000110 CR3: 0000000427f22000 CR4: 00000000000006e0
[Wed Feb 27 14:17:09 2019] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[Wed Feb 27 14:17:09 2019] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[Wed Feb 27 14:17:09 2019] Call Trace:
[Wed Feb 27 14:17:09 2019]  virtio_transport_recv_pkt+0x63/0x820 [vmw_vsock_virtio_transport_common]
[Wed Feb 27 14:17:09 2019]  ? kfree+0x17e/0x190
[Wed Feb 27 14:17:09 2019]  ? detach_buf_split+0x145/0x160
[Wed Feb 27 14:17:09 2019]  ? __switch_to_asm+0x40/0x70
[Wed Feb 27 14:17:09 2019]  virtio_transport_rx_work+0xa0/0x106 [vmw_vsock_virtio_transport]
[Wed Feb 27 14:17:09 2019] NET: Registered protocol family 40
[Wed Feb 27 14:17:09 2019]  process_one_work+0x167/0x410
[Wed Feb 27 14:17:09 2019]  worker_thread+0x4d/0x460
[Wed Feb 27 14:17:09 2019]  kthread+0x105/0x140
[Wed Feb 27 14:17:09 2019]  ? rescuer_thread+0x360/0x360
[Wed Feb 27 14:17:09 2019]  ? kthread_destroy_worker+0x50/0x50
[Wed Feb 27 14:17:09 2019]  ret_from_fork+0x35/0x40
[Wed Feb 27 14:17:09 2019] Modules linked in: vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common input_leds vsock serio_raw i2c_piix4 mac_hid qemu_fw_cfg autofs4 cirrus ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops virtio_net psmouse drm net_failover pata_acpi virtio_blk failover floppy

Fixes: 22b5c0b63f32 ("vsock/virtio: fix kernel panic after device hot-unplug")
Reported-by: Alexandru Herghelegiu <aherghelegiu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
Co-developed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/virtio_transport_common.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -662,6 +662,8 @@ static int virtio_transport_reset(struct
  */
 static int virtio_transport_reset_no_sock(struct virtio_vsock_pkt *pkt)
 {
+	const struct virtio_transport *t;
+	struct virtio_vsock_pkt *reply;
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(pkt->hdr.type),
@@ -672,15 +674,21 @@ static int virtio_transport_reset_no_soc
 	if (le16_to_cpu(pkt->hdr.op) == VIRTIO_VSOCK_OP_RST)
 		return 0;
 
-	pkt = virtio_transport_alloc_pkt(&info, 0,
-					 le64_to_cpu(pkt->hdr.dst_cid),
-					 le32_to_cpu(pkt->hdr.dst_port),
-					 le64_to_cpu(pkt->hdr.src_cid),
-					 le32_to_cpu(pkt->hdr.src_port));
-	if (!pkt)
+	reply = virtio_transport_alloc_pkt(&info, 0,
+					   le64_to_cpu(pkt->hdr.dst_cid),
+					   le32_to_cpu(pkt->hdr.dst_port),
+					   le64_to_cpu(pkt->hdr.src_cid),
+					   le32_to_cpu(pkt->hdr.src_port));
+	if (!reply)
 		return -ENOMEM;
 
-	return virtio_transport_get_ops()->send_pkt(pkt);
+	t = virtio_transport_get_ops();
+	if (!t) {
+		virtio_transport_free_pkt(reply);
+		return -ENOTCONN;
+	}
+
+	return t->send_pkt(reply);
 }
 
 static void virtio_transport_wait_close(struct sock *sk, long timeout)


