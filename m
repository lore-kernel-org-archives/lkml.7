Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC04DC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89009218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355111;
	bh=oKuL5OXx79C5VC0peP1Acr/HXEk2N3z0dbkjcbCTuh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cS2s5AwTjvITr7eyNbX/PIOlPikQtkKv62RxXLCkaOMEVUyLElX3DBD+vax/2f/yr
	 rOQJkK/VMrJoDSEa29so4uMrfvNGyoYGjx705e08wwC3wfLjwUaOeDZ7WlSf3lEYoX
	 MjVQtFc6QDget7Lv/p5lw4vgZMFyu3hA7uZPSwBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfDOTFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729105AbfDOTFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:05:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57815218A1;
        Mon, 15 Apr 2019 19:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355105;
        bh=oKuL5OXx79C5VC0peP1Acr/HXEk2N3z0dbkjcbCTuh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I+u1x0yGthLp6FRr9n0ysJfaHuDSqTs6gLOMJB57ux/XmwvfGGvGZUvcSELZhDxKT
         XqVuantpubCWA4k4P8UPu7YVqfNqsvBDyOuJuymGmYs1deaKcF6tSkG3ABZ28Wlrjn
         TvUaEhpXrSfMdVrXalkLlFpWasfsBzI5RDCuhBes=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 005/101] ibmvnic: Fix completion structure initialization
Date:   Mon, 15 Apr 2019 20:58:03 +0200
Message-Id: <20190415183740.637750957@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit bbd669a868bba591ffd38b7bc75a7b361bb54b04 ]

Fix device initialization completion handling for vNIC adapters.
Initialize the completion structure on probe and reinitialize when needed.
This also fixes a race condition during kdump where the driver can attempt
to access the completion struct before it is initialized:

Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc0000000081acbe0
Oops: Kernel access of bad area, sig: 11 [#1]
LE SMP NR_CPUS=2048 NUMA pSeries
Modules linked in: ibmvnic(+) ibmveth sunrpc overlay squashfs loop
CPU: 19 PID: 301 Comm: systemd-udevd Not tainted 4.18.0-64.el8.ppc64le #1
NIP:  c0000000081acbe0 LR: c0000000081ad964 CTR: c0000000081ad900
REGS: c000000027f3f990 TRAP: 0300   Not tainted  (4.18.0-64.el8.ppc64le)
MSR:  800000010280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]> CR: 28228288  XER: 00000006
CFAR: c000000008008934 DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 1
GPR00: c0000000081ad964 c000000027f3fc10 c0000000095b5800 c0000000221b4e58
GPR04: 0000000000000003 0000000000000001 000049a086918581 00000000000000d4
GPR08: 0000000000000007 0000000000000000 ffffffffffffffe8 d0000000014dde28
GPR12: c0000000081ad900 c000000009a00c00 0000000000000001 0000000000000100
GPR16: 0000000000000038 0000000000000007 c0000000095e2230 0000000000000006
GPR20: 0000000000400140 0000000000000001 c00000000910c880 0000000000000000
GPR24: 0000000000000000 0000000000000006 0000000000000000 0000000000000003
GPR28: 0000000000000001 0000000000000001 c0000000221b4e60 c0000000221b4e58
NIP [c0000000081acbe0] __wake_up_locked+0x50/0x100
LR [c0000000081ad964] complete+0x64/0xa0
Call Trace:
[c000000027f3fc10] [c000000027f3fc60] 0xc000000027f3fc60 (unreliable)
[c000000027f3fc60] [c0000000081ad964] complete+0x64/0xa0
[c000000027f3fca0] [d0000000014dad58] ibmvnic_handle_crq+0xce0/0x1160 [ibmvnic]
[c000000027f3fd50] [d0000000014db270] ibmvnic_tasklet+0x98/0x130 [ibmvnic]
[c000000027f3fda0] [c00000000813f334] tasklet_action_common.isra.3+0xc4/0x1a0
[c000000027f3fe00] [c000000008cd13f4] __do_softirq+0x164/0x400
[c000000027f3fef0] [c00000000813ed64] irq_exit+0x184/0x1c0
[c000000027f3ff20] [c0000000080188e8] __do_irq+0xb8/0x210
[c000000027f3ff90] [c00000000802d0a4] call_do_irq+0x14/0x24
[c000000026a5b010] [c000000008018adc] do_IRQ+0x9c/0x130
[c000000026a5b060] [c000000008008ce4] hardware_interrupt_common+0x114/0x120

Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index c8704b1690eb..a475f36ddf8c 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1888,6 +1888,7 @@ static int do_hard_reset(struct ibmvnic_adapter *adapter,
 	 */
 	adapter->state = VNIC_PROBED;
 
+	reinit_completion(&adapter->init_done);
 	rc = init_crq_queue(adapter);
 	if (rc) {
 		netdev_err(adapter->netdev,
@@ -4569,7 +4570,7 @@ static int ibmvnic_reset_init(struct ibmvnic_adapter *adapter)
 	old_num_rx_queues = adapter->req_rx_queues;
 	old_num_tx_queues = adapter->req_tx_queues;
 
-	init_completion(&adapter->init_done);
+	reinit_completion(&adapter->init_done);
 	adapter->init_done_rc = 0;
 	ibmvnic_send_crq_init(adapter);
 	if (!wait_for_completion_timeout(&adapter->init_done, timeout)) {
@@ -4624,7 +4625,6 @@ static int ibmvnic_init(struct ibmvnic_adapter *adapter)
 
 	adapter->from_passive_init = false;
 
-	init_completion(&adapter->init_done);
 	adapter->init_done_rc = 0;
 	ibmvnic_send_crq_init(adapter);
 	if (!wait_for_completion_timeout(&adapter->init_done, timeout)) {
@@ -4703,6 +4703,7 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	INIT_WORK(&adapter->ibmvnic_reset, __ibmvnic_reset);
 	INIT_LIST_HEAD(&adapter->rwi_list);
 	spin_lock_init(&adapter->rwi_lock);
+	init_completion(&adapter->init_done);
 	adapter->resetting = false;
 
 	adapter->mac_change_pending = false;
-- 
2.19.1



