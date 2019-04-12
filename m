Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79501C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CCF20651
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nIWY84tu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfDLGto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:49:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49576 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfDLGto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 02:49:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3C6hlpR027871;
        Fri, 12 Apr 2019 06:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=b7woYrl63pNzcetbuxkWEBWjxuHs1pmlo0Ddo71dyWQ=;
 b=nIWY84tu+RXJHdzCGV6r64TEivap4dNZvCegmI4gRHq+X8s2Y4oU7kWuFuZU016DjV0d
 U508suIxDuzw0uS5AngC+pZtpmbA6gPgGFAI7WYo/nL6UC5afA7kxXVg/+0pHcepCUpS
 okEsJpo0eXXywsIPhOXKZaHL3WywFCLdOPr67t8zyZEHcG1WuVN1HFMAVdTGdoCHbSEG
 vnedqQk8pguK8+AbnVED+ArPl1fsxk377ekC0x0kJs7eYeQFTAYfFzNqJKP2NzRHyAAL
 HdP4VkFJ9SCebx78Juxu68HHBBKR+ZnUp0xLW56BZHD1V6OwqMVjoo5j+iFS4wzaVvoN Tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2rpmrqmmu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 06:49:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3C6m94s189407;
        Fri, 12 Apr 2019 06:49:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2rt9uq0pjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 06:49:35 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3C6nYDd018876;
        Fri, 12 Apr 2019 06:49:34 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Apr 2019 23:49:33 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, wei.liu2@citrix.com,
        paul.durrant@citrix.com, davem@davemloft.net, joe.jin@oracle.com,
        junxiao.bi@oracle.com, jie.l.li@oracle.com
Subject: [PATCH 1/1] xen-netback: add reference from xenvif to backend_info to facilitate coredump analysis
Date:   Fri, 12 Apr 2019 14:53:24 +0800
Message-Id: <1555052004-31855-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904120046
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904120046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During coredump analysis, it is not easy to obtain the address of
backend_info in xen-netback.

So far there are two ways to obtain backend_info:

1. Do what xenbus_device_find() does for vmcore to find the xenbus_device
and then derive it from dev_get_drvdata().

2. Extract backend_info from callstack of xenwatch (e.g., netback_remove()
or frontend_changed()).

This patch adds a reference from xenvif to backend_info so that it would be
much more easier to obtain backend_info during coredump analysis.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/net/xen-netback/common.h | 18 ++++++++++++++++++
 drivers/net/xen-netback/xenbus.c | 17 +----------------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/net/xen-netback/common.h b/drivers/net/xen-netback/common.h
index 936c0b3..05847eb 100644
--- a/drivers/net/xen-netback/common.h
+++ b/drivers/net/xen-netback/common.h
@@ -248,6 +248,22 @@ struct xenvif_hash {
 	struct xenvif_hash_cache cache;
 };
 
+struct backend_info {
+	struct xenbus_device *dev;
+	struct xenvif *vif;
+
+	/* This is the state that will be reflected in xenstore when any
+	 * active hotplug script completes.
+	 */
+	enum xenbus_state state;
+
+	enum xenbus_state frontend_state;
+	struct xenbus_watch hotplug_status_watch;
+	u8 have_hotplug_status_watch:1;
+
+	const char *hotplug_script;
+};
+
 struct xenvif {
 	/* Unique identifier for this interface. */
 	domid_t          domid;
@@ -283,6 +299,8 @@ struct xenvif {
 	struct xenbus_watch credit_watch;
 	struct xenbus_watch mcast_ctrl_watch;
 
+	struct backend_info *be;
+
 	spinlock_t lock;
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index 330ddb6..41c9e8f 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -22,22 +22,6 @@
 #include <linux/vmalloc.h>
 #include <linux/rtnetlink.h>
 
-struct backend_info {
-	struct xenbus_device *dev;
-	struct xenvif *vif;
-
-	/* This is the state that will be reflected in xenstore when any
-	 * active hotplug script completes.
-	 */
-	enum xenbus_state state;
-
-	enum xenbus_state frontend_state;
-	struct xenbus_watch hotplug_status_watch;
-	u8 have_hotplug_status_watch:1;
-
-	const char *hotplug_script;
-};
-
 static int connect_data_rings(struct backend_info *be,
 			      struct xenvif_queue *queue);
 static void connect(struct backend_info *be);
@@ -472,6 +456,7 @@ static int backend_create_xenvif(struct backend_info *be)
 		return err;
 	}
 	be->vif = vif;
+	vif->be = be;
 
 	kobject_uevent(&dev->dev.kobj, KOBJ_ONLINE);
 	return 0;
-- 
2.7.4

