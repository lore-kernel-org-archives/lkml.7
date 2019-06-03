Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE50EC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 23:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C116626402
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 23:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfFCXYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 19:24:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:27685 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfFCXYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 19:24:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 16:24:12 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jun 2019 16:24:11 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hXwJG-000E3q-Tu; Tue, 04 Jun 2019 07:24:10 +0800
Date:   Tue, 4 Jun 2019 07:23:11 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Xue Chaojing <xuechaojing@huawei.com>
Cc:     kbuild-all@01.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        luoshaokai@huawei.com, cloud.wangxiaoyun@huawei.com,
        xuechaojing@huawei.com, chiqijun@huawei.com, wulike1@huawei.com
Subject: [RFC PATCH] hinic: hinic_rx_configure() can be static
Message-ID: <20190603232311.GA26152@lkp-kbuild15>
References: <20190603043536.4970-1-xuechaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603043536.4970-1-xuechaojing@huawei.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 7e8a92c6b00c ("hinic: add LRO support")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 hinic_main.c |    2 +-
 hinic_port.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index 175fe53..530a205 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -372,7 +372,7 @@ static void free_rxqs(struct hinic_dev *nic_dev)
 	nic_dev->rxqs = NULL;
 }
 
-int hinic_rx_configure(struct net_device *netdev)
+static int hinic_rx_configure(struct net_device *netdev)
 {
 	struct hinic_dev *nic_dev = netdev_priv(netdev);
 	int err;
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_port.c b/drivers/net/ethernet/huawei/hinic/hinic_port.c
index c1947b2..1783bd3 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_port.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_port.c
@@ -466,8 +466,8 @@ int hinic_set_max_qnum(struct hinic_dev *nic_dev, u8 num_rqs)
 	return 0;
 }
 
-int hinic_set_rx_lro(struct hinic_dev *nic_dev, u8 ipv4_en, u8 ipv6_en,
-		     u8 max_wqe_num)
+static int hinic_set_rx_lro(struct hinic_dev *nic_dev, u8 ipv4_en, u8 ipv6_en,
+			    u8 max_wqe_num)
 {
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
 	struct hinic_hwif *hwif = hwdev->hwif;
@@ -494,7 +494,7 @@ int hinic_set_rx_lro(struct hinic_dev *nic_dev, u8 ipv4_en, u8 ipv6_en,
 	return 0;
 }
 
-int hinic_set_rx_lro_timer(struct hinic_dev *nic_dev, u32 timer_value)
+static int hinic_set_rx_lro_timer(struct hinic_dev *nic_dev, u32 timer_value)
 {
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
 	struct hinic_lro_timer lro_timer = {0};
