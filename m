Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E6DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901E9218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117305;
	bh=+TLaHvVK8hSBaxB4JDXAcW+L1n7Le56CPjAToyc8LyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wRHoRrbIoF6RlTCBtlyzdMwxMlCcFm7Qdg07fsA1xv47XADLaSrFyrby8G4ONiIoD
	 b5Cn1bgMV9UKrYaO7h1wecJWDEiNb7t/wyZJtg8reHVdf5kEAwPzIByUWzSoU69M1/
	 8amceTewmCydHKL56aLvlV8B4bGsX3S95HojV93g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbfDXOsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:48:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732418AbfDXOsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:48:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16A7F218FC;
        Wed, 24 Apr 2019 14:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117299;
        bh=+TLaHvVK8hSBaxB4JDXAcW+L1n7Le56CPjAToyc8LyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g4bBqiRGmutqZWte/QUMktXIX6B3erJDzvxHw09N6YVNoGX3pj5fGaUUZ7VCxFKnV
         hWvm02tGS+CWnNelRiSt/HeQK6ESBFf0BU79a7pUy101z8fYPd6F4R+4pNtMSQiwPU
         MMb/A5aaDmr3LP03PJLmmF2euMEUlsC30zLpLnMM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 27/35] net: hns: fix ICMP6 neighbor solicitation messages discard problem
Date:   Wed, 24 Apr 2019 10:47:01 -0400
Message-Id: <20190424144709.30215-27-sashal@kernel.org>
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

[ Upstream commit f058e46855dcbc28edb2ed4736f38a71fd19cadb ]

ICMP6 neighbor solicitation messages will be discard by the Hip06
chips, because of not setting forwarding pool. Enable promisc mode
has the same problem.

This patch fix the wrong forwarding table configs for the multicast
vague matching when enable promisc mode, and add forwarding pool
for the forwarding table.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/hisilicon/hns/hns_dsaf_main.c    | 33 +++++++++++++++----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index 7e82dfbb4340..7d0f3cd8a002 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -2743,6 +2743,17 @@ int hns_dsaf_get_regs_count(void)
 	return DSAF_DUMP_REGS_NUM;
 }
 
+static int hns_dsaf_get_port_id(u8 port)
+{
+	if (port < DSAF_SERVICE_NW_NUM)
+		return port;
+
+	if (port >= DSAF_BASE_INNER_PORT_NUM)
+		return port - DSAF_BASE_INNER_PORT_NUM + DSAF_SERVICE_NW_NUM;
+
+	return -EINVAL;
+}
+
 static void set_promisc_tcam_enable(struct dsaf_device *dsaf_dev, u32 port)
 {
 	struct dsaf_tbl_tcam_ucast_cfg tbl_tcam_ucast = {0, 1, 0, 0, 0x80};
@@ -2808,23 +2819,33 @@ static void set_promisc_tcam_enable(struct dsaf_device *dsaf_dev, u32 port)
 	memset(&temp_key, 0x0, sizeof(temp_key));
 	mask_entry.addr[0] = 0x01;
 	hns_dsaf_set_mac_key(dsaf_dev, &mask_key, mask_entry.in_vlan_id,
-			     port, mask_entry.addr);
+			     0xf, mask_entry.addr);
 	tbl_tcam_mcast.tbl_mcast_item_vld = 1;
 	tbl_tcam_mcast.tbl_mcast_old_en = 0;
 
-	if (port < DSAF_SERVICE_NW_NUM) {
-		mskid = port;
-	} else if (port >= DSAF_BASE_INNER_PORT_NUM) {
-		mskid = port - DSAF_BASE_INNER_PORT_NUM + DSAF_SERVICE_NW_NUM;
-	} else {
+	/* set MAC port to handle multicast */
+	mskid = hns_dsaf_get_port_id(port);
+	if (mskid == -EINVAL) {
 		dev_err(dsaf_dev->dev, "%s,pnum(%d)error,key(%#x:%#x)\n",
 			dsaf_dev->ae_dev.name, port,
 			mask_key.high.val, mask_key.low.val);
 		return;
 	}
+	dsaf_set_bit(tbl_tcam_mcast.tbl_mcast_port_msk[mskid / 32],
+		     mskid % 32, 1);
 
+	/* set pool bit map to handle multicast */
+	mskid = hns_dsaf_get_port_id(port_num);
+	if (mskid == -EINVAL) {
+		dev_err(dsaf_dev->dev,
+			"%s, pool bit map pnum(%d)error,key(%#x:%#x)\n",
+			dsaf_dev->ae_dev.name, port_num,
+			mask_key.high.val, mask_key.low.val);
+		return;
+	}
 	dsaf_set_bit(tbl_tcam_mcast.tbl_mcast_port_msk[mskid / 32],
 		     mskid % 32, 1);
+
 	memcpy(&temp_key, &mask_key, sizeof(mask_key));
 	hns_dsaf_tcam_mc_cfg_vague(dsaf_dev, entry_index, &tbl_tcam_data_mc,
 				   (struct dsaf_tbl_tcam_data *)(&mask_key),
-- 
2.19.1

