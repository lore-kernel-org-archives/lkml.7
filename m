Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E0CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A5520657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="T5mf2+ws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfDDSrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:47:19 -0400
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:9134 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729534AbfDDSrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1554403636; x=1585939636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=s0PUqhGkoz41xMwFJ9MN7fXIc6AGNGce4vVIgmUvUzw=;
  b=T5mf2+wsHJnEAkUeMX5Ef5N5kLJhb6G6gPmtmvBUGI4q7XoswM6EPWjx
   eH0CCxOELI4uSCU+yOWDyhfRwrO+3N6MpbdI0bd/XwFqNjsD/Nl6RZQgw
   EaoXh4YhrYqJ2BjrFAyTcn/peP18unHj7fwB22t97RkpQWqxT748przdk
   Q=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GGAQDGT6ZchyWd50NlHQEBBQEHBQG?=
 =?us-ascii?q?BZYFnghUnjQmlIIFnDgEBhGwChU4iOBIBAQMBAQkBAwIBAQIQAQEBFQkIKS+?=
 =?us-ascii?q?COikBgmgCAQMSFVIQUVcZIoMAgXaiEz0Cb4EBiQcBAQGBazOKL4EwhmuESIF?=
 =?us-ascii?q?XP4ERg1CELWSFFAOKVogHkw0HAoJPBJEnAhiUTy2fEgIEAgQFAhWBZiCBWHC?=
 =?us-ascii?q?DPIIWDgmBAQECjTkhATKQaAEB?=
X-IPAS-Result: =?us-ascii?q?A2GGAQDGT6ZchyWd50NlHQEBBQEHBQGBZYFnghUnjQmlI?=
 =?us-ascii?q?IFnDgEBhGwChU4iOBIBAQMBAQkBAwIBAQIQAQEBFQkIKS+COikBgmgCAQMSF?=
 =?us-ascii?q?VIQUVcZIoMAgXaiEz0Cb4EBiQcBAQGBazOKL4EwhmuESIFXP4ERg1CELWSFF?=
 =?us-ascii?q?AOKVogHkw0HAoJPBJEnAhiUTy2fEgIEAgQFAhWBZiCBWHCDPIIWDgmBAQECj?=
 =?us-ascii?q?TkhATKQaAEB?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa4.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Apr 2019 13:47:15 -0500
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34ISMQ5043163;
        Thu, 4 Apr 2019 14:47:15 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 2rnn028y88-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 14:47:15 -0400
X-LoopCount0: from 10.173.37.27
X-IronPort-AV: E=Sophos;i="5.60,309,1549951200"; 
   d="scan'208";a="337561727"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     linux-usb@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hayeswang@realtek.com,
        sjg@google.com, campello@google.com,
        Ryan Hong <Ryan.Hong@Dell.com>, Crag Wang <Crag.Wang@dell.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH v2 2/2] r8152: Refresh MAC address during USBDEVFS_RESET
Date:   Thu,  4 Apr 2019 13:46:53 -0500
Message-Id: <1554403613-5970-3-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554403613-5970-1-git-send-email-mario.limonciello@dell.com>
References: <1554403613-5970-1-git-send-email-mario.limonciello@dell.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=841 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms it is possible to dynamically change the policy
of what MAC address is selected from the ASL at runtime.

These tools will reset the USB device and expect the change to be
made immediately.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/net/usb/r8152.c | 50 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index dc1bfff..6d63dcb 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1220,43 +1220,55 @@ static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
 	return ret;
 }
 
-static int set_ethernet_addr(struct r8152 *tp)
+static int determine_ethernet_addr(struct r8152 *tp, struct sockaddr *sa)
 {
 	struct net_device *dev = tp->netdev;
-	struct sockaddr sa;
 	int ret;
 
 	if (tp->version == RTL_VER_01) {
-		ret = pla_ocp_read(tp, PLA_IDR, 8, sa.sa_data);
+		ret = pla_ocp_read(tp, PLA_IDR, 8, sa->sa_data);
 	} else {
 		/* if device doesn't support MAC pass through this will
 		 * be expected to be non-zero
 		 */
-		ret = vendor_mac_passthru_addr_read(tp, &sa);
+		ret = vendor_mac_passthru_addr_read(tp, sa);
 		if (ret < 0)
-			ret = pla_ocp_read(tp, PLA_BACKUP, 8, sa.sa_data);
+			ret = pla_ocp_read(tp, PLA_BACKUP, 8, sa->sa_data);
 	}
 
 	if (ret < 0) {
 		netif_err(tp, probe, dev, "Get ether addr fail\n");
-	} else if (!is_valid_ether_addr(sa.sa_data)) {
+	} else if (!is_valid_ether_addr(sa->sa_data)) {
 		netif_err(tp, probe, dev, "Invalid ether addr %pM\n",
-			  sa.sa_data);
+			  sa->sa_data);
 		eth_hw_addr_random(dev);
-		ether_addr_copy(sa.sa_data, dev->dev_addr);
-		ret = rtl8152_set_mac_address(dev, &sa);
+		ether_addr_copy(sa->sa_data, dev->dev_addr);
 		netif_info(tp, probe, dev, "Random ether addr %pM\n",
-			   sa.sa_data);
-	} else {
-		if (tp->version == RTL_VER_01)
-			ether_addr_copy(dev->dev_addr, sa.sa_data);
-		else
-			ret = rtl8152_set_mac_address(dev, &sa);
+			   sa->sa_data);
+		return 0;
 	}
 
 	return ret;
 }
 
+static int set_ethernet_addr(struct r8152 *tp)
+{
+	struct net_device *dev = tp->netdev;
+	struct sockaddr sa;
+	int ret;
+
+	ret = determine_ethernet_addr(tp, &sa);
+	if (ret < 0)
+		return ret;
+
+	if (tp->version == RTL_VER_01)
+		ether_addr_copy(dev->dev_addr, sa.sa_data);
+	else
+		ret = rtl8152_set_mac_address(dev, &sa);
+
+	return ret;
+}
+
 static void read_bulk_callback(struct urb *urb)
 {
 	struct net_device *netdev;
@@ -4263,10 +4275,18 @@ static int rtl8152_post_reset(struct usb_interface *intf)
 {
 	struct r8152 *tp = usb_get_intfdata(intf);
 	struct net_device *netdev;
+	struct sockaddr sa;
 
 	if (!tp)
 		return 0;
 
+	/* reset the MAC adddress in case of policy change */
+	if (determine_ethernet_addr(tp, &sa) >= 0) {
+		rtnl_lock();
+		dev_set_mac_address (tp->netdev, &sa, NULL);
+		rtnl_unlock();
+	}
+
 	netdev = tp->netdev;
 	if (!netif_running(netdev))
 		return 0;
-- 
2.7.4

