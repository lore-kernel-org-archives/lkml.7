Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE04C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB9B20700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfC1SGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:06:50 -0400
Received: from gateway30.websitewelcome.com ([192.185.149.4]:43991 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbfC1SGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:06:50 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 9C9E12C9A8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:45:33 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9Z5phTupM4FKp9Z5ph0n33; Thu, 28 Mar 2019 12:45:33 -0500
X-Authority-Reason: nr=8
Received: from [189.250.117.246] (port=37558 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1h9Z5o-003Byr-Q2; Thu, 28 Mar 2019 12:45:33 -0500
Date:   Thu, 28 Mar 2019 12:45:31 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] iavf: use struct_size() in kzalloc()
Message-ID: <20190328174531.GA17630@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.117.246
X-Source-L: No
X-Exim-ID: 1h9Z5o-003Byr-Q2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.117.246]:37558
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

size = sizeof(struct foo) + count * sizeof(struct boo);
instance = kzalloc(size, GFP_KERNEL)

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL)

Notice that, in this case, variable bufsz is not necessary, hence it
is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 4569d69a2b55..78340b297dab 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3353,7 +3353,7 @@ static void iavf_init_task(struct work_struct *work)
 	struct net_device *netdev = adapter->netdev;
 	struct iavf_hw *hw = &adapter->hw;
 	struct pci_dev *pdev = adapter->pdev;
-	int err, bufsz;
+	int err;
 
 	switch (adapter->state) {
 	case __IAVF_STARTUP:
@@ -3423,10 +3423,9 @@ static void iavf_init_task(struct work_struct *work)
 	case __IAVF_INIT_GET_RESOURCES:
 		/* aq msg sent, awaiting reply */
 		if (!adapter->vf_res) {
-			bufsz = sizeof(struct virtchnl_vf_resource) +
-				(IAVF_MAX_VF_VSI *
-				 sizeof(struct virtchnl_vsi_resource));
-			adapter->vf_res = kzalloc(bufsz, GFP_KERNEL);
+			adapter->vf_res = kzalloc(struct_size(adapter->vf_res,
+						  vsi_res, IAVF_MAX_VF_VSI),
+						  GFP_KERNEL);
 			if (!adapter->vf_res)
 				goto err;
 		}
-- 
2.21.0

