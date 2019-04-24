Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58490C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A3A218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117300;
	bh=QekyWZAhOPZzvaSp+TpBc5QrjScxB96Ut8nEEEKO8lM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d5/aHPVOWZ+nKz7gRtvxKIsahEret+C76hvm7Q27SOUSU2ZOvRQ4Pgdm15ocbgU+5
	 MUy8ASoBMf1hbmW6NWjV/4lOe+PHg07TVvwHwmzme0s3/DKPQRpF+SDpV2vPf5lS9h
	 XKZQc85KsXwr1UgxRf/reQxXZPA4KzAXGpYLPNLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbfDXOsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732418AbfDXOsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:48:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4254221903;
        Wed, 24 Apr 2019 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117295;
        bh=QekyWZAhOPZzvaSp+TpBc5QrjScxB96Ut8nEEEKO8lM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GobAp00sU9aSHsgo2uI0VIHmMe8aPm/dFA59nRDS4OTkpbHOQuRmTqsyWu02czaqG
         BZjLBvC6Z1nKER+6xvrjs6goMf2yEad7BqNbT2m3DfK5rAdUlbL5x27dHclhFJvME1
         nzGoSsDzyDhlxXLuIhDOQV8ilW4uLdPEIgSN1H18=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 26/35] net: hns: Fix probabilistic memory overwrite when HNS driver initialized
Date:   Wed, 24 Apr 2019 10:47:00 -0400
Message-Id: <20190424144709.30215-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424144709.30215-1-sashal@kernel.org>
References: <20190424144709.30215-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit c0b0984426814f3a9251873b689e67d34d8ccd84 ]

When reboot the system again and again, may cause a memory
overwrite.

[   15.638922] systemd[1]: Reached target Swap.
[   15.667561] tun: Universal TUN/TAP device driver, 1.6
[   15.676756] Bridge firewalling registered
[   17.344135] Unable to handle kernel paging request at virtual address 0000000200000040
[   17.352179] Mem abort info:
[   17.355007]   ESR = 0x96000004
[   17.358105]   Exception class = DABT (current EL), IL = 32 bits
[   17.364112]   SET = 0, FnV = 0
[   17.367209]   EA = 0, S1PTW = 0
[   17.370393] Data abort info:
[   17.373315]   ISV = 0, ISS = 0x00000004
[   17.377206]   CM = 0, WnR = 0
[   17.380214] user pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
[   17.386926] [0000000200000040] pgd=0000000000000000
[   17.391878] Internal error: Oops: 96000004 [#1] SMP
[   17.396824] CPU: 23 PID: 95 Comm: kworker/u130:0 Tainted: G            E     4.19.25-1.2.78.aarch64 #1
[   17.414175] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.54 08/16/2018
[   17.425615] Workqueue: events_unbound async_run_entry_fn
[   17.435151] pstate: 00000005 (nzcv daif -PAN -UAO)
[   17.444139] pc : __mutex_lock.isra.1+0x74/0x540
[   17.453002] lr : __mutex_lock.isra.1+0x3c/0x540
[   17.461701] sp : ffff000100d9bb60
[   17.469146] x29: ffff000100d9bb60 x28: 0000000000000000
[   17.478547] x27: 0000000000000000 x26: ffff802fb8945000
[   17.488063] x25: 0000000000000000 x24: ffff802fa32081a8
[   17.497381] x23: 0000000000000002 x22: ffff801fa2b15220
[   17.506701] x21: ffff000009809000 x20: ffff802fa23a0888
[   17.515980] x19: ffff801fa2b15220 x18: 0000000000000000
[   17.525272] x17: 0000000200000000 x16: 0000000200000000
[   17.534511] x15: 0000000000000000 x14: 0000000000000000
[   17.543652] x13: ffff000008d95db8 x12: 000000000000000d
[   17.552780] x11: ffff000008d95d90 x10: 0000000000000b00
[   17.561819] x9 : ffff000100d9bb90 x8 : ffff802fb89d6560
[   17.570829] x7 : 0000000000000004 x6 : 00000004a1801d05
[   17.579839] x5 : 0000000000000000 x4 : 0000000000000000
[   17.588852] x3 : ffff802fb89d5a00 x2 : 0000000000000000
[   17.597734] x1 : 0000000200000000 x0 : 0000000200000000
[   17.606631] Process kworker/u130:0 (pid: 95, stack limit = 0x(____ptrval____))
[   17.617438] Call trace:
[   17.623349]  __mutex_lock.isra.1+0x74/0x540
[   17.630927]  __mutex_lock_slowpath+0x24/0x30
[   17.638602]  mutex_lock+0x50/0x60
[   17.645295]  drain_workqueue+0x34/0x198
[   17.652623]  __sas_drain_work+0x7c/0x168
[   17.659903]  sas_drain_work+0x60/0x68
[   17.666947]  hisi_sas_scan_finished+0x30/0x40 [hisi_sas_main]
[   17.676129]  do_scsi_scan_host+0x70/0xb0
[   17.683534]  do_scan_async+0x20/0x228
[   17.690586]  async_run_entry_fn+0x4c/0x1d0
[   17.697997]  process_one_work+0x1b4/0x3f8
[   17.705296]  worker_thread+0x54/0x470

Every time the call trace is not the same, but the overwrite address
is always the same:
Unable to handle kernel paging request at virtual address 0000000200000040

The root cause is, when write the reg XGMAC_MAC_TX_LF_RF_CONTROL_REG,
didn't use the io_base offset.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
index 51e7e9f5af49..70de7b5d28af 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
@@ -129,7 +129,7 @@ static void hns_xgmac_lf_rf_control_init(struct mac_driver *mac_drv)
 	dsaf_set_bit(val, XGMAC_UNIDIR_EN_B, 0);
 	dsaf_set_bit(val, XGMAC_RF_TX_EN_B, 1);
 	dsaf_set_field(val, XGMAC_LF_RF_INSERT_M, XGMAC_LF_RF_INSERT_S, 0);
-	dsaf_write_reg(mac_drv, XGMAC_MAC_TX_LF_RF_CONTROL_REG, val);
+	dsaf_write_dev(mac_drv, XGMAC_MAC_TX_LF_RF_CONTROL_REG, val);
 }
 
 /**
-- 
2.19.1

