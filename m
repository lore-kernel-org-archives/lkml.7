Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954FBC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F98C2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355925;
	bh=dBKTBp4Y90n9IM8zCNQpuRicgQbRgTNZFaadSdecgzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dg4pdqexAO6jsW76qkGxBy106vrG+iimtxv4yXCCtB16/GqG6MQKv0m171CeLUMu7
	 pfTmHcoSH5I/MnqQNBBEuHpAVEQPFSY0LXmHFglAZlbd0OzO/eiEaTsViC23K8DkQR
	 1niaYPbG7W1nddejVnG+yJybT9sZMoIkPA/AdBHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfDOTSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729656AbfDOTLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:11:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D09C2218A1;
        Mon, 15 Apr 2019 19:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355475;
        bh=dBKTBp4Y90n9IM8zCNQpuRicgQbRgTNZFaadSdecgzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ye0Xz3A4vdwjnJBAdzK5BzLwTIaHjnnhjcNXrAcX5ky0katFOQsfnuBGcId4N1FVV
         38j2YNVDS2rFp25o7F0d7Xos+vu4QD8KKWNlieG+iLpEIVIlj3ouB0qEBVL8H6+5b6
         LshYZ+gchR3Q+I1t1kmjifyRkLZUwz5v44iqqAJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matteo Croce <mcroce@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 035/117] net: thunderx: fix NULL pointer dereference in nicvf_open/nicvf_stop
Date:   Mon, 15 Apr 2019 21:00:05 +0200
Message-Id: <20190415183746.809664298@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2ec1ed2aa68782b342458681aa4d16b65c9014d6 ]

When a bpf program is uploaded, the driver computes the number of
xdp tx queues resulting in the allocation of additional qsets.
Starting from commit '2ecbe4f4a027 ("net: thunderx: replace global
nicvf_rx_mode_wq work queue for all VFs to private for each of them")'
the driver runs link state polling for each VF resulting in the
following NULL pointer dereference:

[   56.169256] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
[   56.178032] Mem abort info:
[   56.180834]   ESR = 0x96000005
[   56.183877]   Exception class = DABT (current EL), IL = 32 bits
[   56.189792]   SET = 0, FnV = 0
[   56.192834]   EA = 0, S1PTW = 0
[   56.195963] Data abort info:
[   56.198831]   ISV = 0, ISS = 0x00000005
[   56.202662]   CM = 0, WnR = 0
[   56.205619] user pgtable: 64k pages, 48-bit VAs, pgdp = 0000000021f0c7a0
[   56.212315] [0000000000000020] pgd=0000000000000000, pud=0000000000000000
[   56.219094] Internal error: Oops: 96000005 [#1] SMP
[   56.260459] CPU: 39 PID: 2034 Comm: ip Not tainted 5.1.0-rc3+ #3
[   56.266452] Hardware name: GIGABYTE R120-T33/MT30-GS1, BIOS T49 02/02/2018
[   56.273315] pstate: 80000005 (Nzcv daif -PAN -UAO)
[   56.278098] pc : __ll_sc___cmpxchg_case_acq_64+0x4/0x20
[   56.283312] lr : mutex_lock+0x2c/0x50
[   56.286962] sp : ffff0000219af1b0
[   56.290264] x29: ffff0000219af1b0 x28: ffff800f64de49a0
[   56.295565] x27: 0000000000000000 x26: 0000000000000015
[   56.300865] x25: 0000000000000000 x24: 0000000000000000
[   56.306165] x23: 0000000000000000 x22: ffff000011117000
[   56.311465] x21: ffff800f64dfc080 x20: 0000000000000020
[   56.316766] x19: 0000000000000020 x18: 0000000000000001
[   56.322066] x17: 0000000000000000 x16: ffff800f2e077080
[   56.327367] x15: 0000000000000004 x14: 0000000000000000
[   56.332667] x13: ffff000010964438 x12: 0000000000000002
[   56.337967] x11: 0000000000000000 x10: 0000000000000c70
[   56.343268] x9 : ffff0000219af120 x8 : ffff800f2e077d50
[   56.348568] x7 : 0000000000000027 x6 : 000000062a9d6a84
[   56.353869] x5 : 0000000000000000 x4 : ffff800f2e077480
[   56.359169] x3 : 0000000000000008 x2 : ffff800f2e077080
[   56.364469] x1 : 0000000000000000 x0 : 0000000000000020
[   56.369770] Process ip (pid: 2034, stack limit = 0x00000000c862da3a)
[   56.376110] Call trace:
[   56.378546]  __ll_sc___cmpxchg_case_acq_64+0x4/0x20
[   56.383414]  drain_workqueue+0x34/0x198
[   56.387247]  nicvf_open+0x48/0x9e8 [nicvf]
[   56.391334]  nicvf_open+0x898/0x9e8 [nicvf]
[   56.395507]  nicvf_xdp+0x1bc/0x238 [nicvf]
[   56.399595]  dev_xdp_install+0x68/0x90
[   56.403333]  dev_change_xdp_fd+0xc8/0x240
[   56.407333]  do_setlink+0x8e0/0xbe8
[   56.410810]  __rtnl_newlink+0x5b8/0x6d8
[   56.414634]  rtnl_newlink+0x54/0x80
[   56.418112]  rtnetlink_rcv_msg+0x22c/0x2f8
[   56.422199]  netlink_rcv_skb+0x60/0x120
[   56.426023]  rtnetlink_rcv+0x28/0x38
[   56.429587]  netlink_unicast+0x1c8/0x258
[   56.433498]  netlink_sendmsg+0x1b4/0x350
[   56.437410]  sock_sendmsg+0x4c/0x68
[   56.440887]  ___sys_sendmsg+0x240/0x280
[   56.444711]  __sys_sendmsg+0x68/0xb0
[   56.448275]  __arm64_sys_sendmsg+0x2c/0x38
[   56.452361]  el0_svc_handler+0x9c/0x128
[   56.456186]  el0_svc+0x8/0xc
[   56.459056] Code: 35ffff91 2a1003e0 d65f03c0 f9800011 (c85ffc10)
[   56.465166] ---[ end trace 4a57fdc27b0a572c ]---
[   56.469772] Kernel panic - not syncing: Fatal exception

Fix it by checking nicvf_rx_mode_wq pointer in nicvf_open and nicvf_stop

Fixes: 2ecbe4f4a027 ("net: thunderx: replace global nicvf_rx_mode_wq work queue for all VFs to private for each of them")
Fixes: 2c632ad8bc74 ("net: thunderx: move link state polling function to VF")
Reported-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Tested-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/cavium/thunder/nicvf_main.c  | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 503cfadff4ac..d4ee9f9c8c34 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1328,10 +1328,11 @@ int nicvf_stop(struct net_device *netdev)
 	struct nicvf_cq_poll *cq_poll = NULL;
 	union nic_mbx mbx = {};
 
-	cancel_delayed_work_sync(&nic->link_change_work);
-
 	/* wait till all queued set_rx_mode tasks completes */
-	drain_workqueue(nic->nicvf_rx_mode_wq);
+	if (nic->nicvf_rx_mode_wq) {
+		cancel_delayed_work_sync(&nic->link_change_work);
+		drain_workqueue(nic->nicvf_rx_mode_wq);
+	}
 
 	mbx.msg.msg = NIC_MBOX_MSG_SHUTDOWN;
 	nicvf_send_msg_to_pf(nic, &mbx);
@@ -1452,7 +1453,8 @@ int nicvf_open(struct net_device *netdev)
 	struct nicvf_cq_poll *cq_poll = NULL;
 
 	/* wait till all queued set_rx_mode tasks completes if any */
-	drain_workqueue(nic->nicvf_rx_mode_wq);
+	if (nic->nicvf_rx_mode_wq)
+		drain_workqueue(nic->nicvf_rx_mode_wq);
 
 	netif_carrier_off(netdev);
 
@@ -1550,10 +1552,12 @@ int nicvf_open(struct net_device *netdev)
 	/* Send VF config done msg to PF */
 	nicvf_send_cfg_done(nic);
 
-	INIT_DELAYED_WORK(&nic->link_change_work,
-			  nicvf_link_status_check_task);
-	queue_delayed_work(nic->nicvf_rx_mode_wq,
-			   &nic->link_change_work, 0);
+	if (nic->nicvf_rx_mode_wq) {
+		INIT_DELAYED_WORK(&nic->link_change_work,
+				  nicvf_link_status_check_task);
+		queue_delayed_work(nic->nicvf_rx_mode_wq,
+				   &nic->link_change_work, 0);
+	}
 
 	return 0;
 cleanup:
-- 
2.19.1



