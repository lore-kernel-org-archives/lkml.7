Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A93C32753
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CF02080C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389947AbfHAWna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:43:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732753AbfHAWna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:43:30 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MfdGE109336;
        Thu, 1 Aug 2019 18:43:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u486f1qxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:43:01 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71MftMv110195;
        Thu, 1 Aug 2019 18:43:01 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u486f1qxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:43:01 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71Mefsw012581;
        Thu, 1 Aug 2019 22:43:00 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 2u0e87h6x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:43:00 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MgxTG29098390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:42:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C41DB2078;
        Thu,  1 Aug 2019 22:42:59 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 184A6B2077;
        Thu,  1 Aug 2019 22:42:59 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:42:59 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1EC8816C9A4D; Thu,  1 Aug 2019 15:43:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 6/8] driver/core: Convert to use built-in RCU list checking
Date:   Thu,  1 Aug 2019 15:42:56 -0700
Message-Id: <20190801224258.16679-6-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801224240.GA16092@linux.ibm.com>
References: <20190801224240.GA16092@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This commit applies the consolidated hlist_for_each_entry_rcu() support
for lockdep conditions.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 drivers/base/base.h          |  1 +
 drivers/base/core.c          | 10 ++++++++++
 drivers/base/power/runtime.c | 15 ++++++++++-----
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index b405436ee28e..0d32544b6f91 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -165,6 +165,7 @@ static inline int devtmpfs_init(void) { return 0; }
 /* Device links support */
 extern int device_links_read_lock(void);
 extern void device_links_read_unlock(int idx);
+extern int device_links_read_lock_held(void);
 extern int device_links_check_suppliers(struct device *dev);
 extern void device_links_driver_bound(struct device *dev);
 extern void device_links_driver_cleanup(struct device *dev);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 636058bbf48a..32cf83d1c744 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -68,6 +68,11 @@ void device_links_read_unlock(int idx)
 {
 	srcu_read_unlock(&device_links_srcu, idx);
 }
+
+int device_links_read_lock_held(void)
+{
+	return srcu_read_lock_held(&device_links_srcu);
+}
 #else /* !CONFIG_SRCU */
 static DECLARE_RWSEM(device_links_lock);
 
@@ -91,6 +96,11 @@ void device_links_read_unlock(int not_used)
 {
 	up_read(&device_links_lock);
 }
+
+int device_links_read_lock_held(void)
+{
+	return lock_is_held(&device_links_lock);
+}
 #endif /* !CONFIG_SRCU */
 
 /**
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index b75335508d2c..50def99df970 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -287,7 +287,8 @@ static int rpm_get_suppliers(struct device *dev)
 {
 	struct device_link *link;
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held()) {
 		int retval;
 
 		if (!(link->flags & DL_FLAG_PM_RUNTIME) ||
@@ -309,7 +310,8 @@ static void rpm_put_suppliers(struct device *dev)
 {
 	struct device_link *link;
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held()) {
 		if (READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND)
 			continue;
 
@@ -1640,7 +1642,8 @@ void pm_runtime_clean_up_links(struct device *dev)
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.consumers, s_node) {
+	list_for_each_entry_rcu(link, &dev->links.consumers, s_node,
+				device_links_read_lock_held()) {
 		if (link->flags & DL_FLAG_STATELESS)
 			continue;
 
@@ -1662,7 +1665,8 @@ void pm_runtime_get_suppliers(struct device *dev)
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held())
 		if (link->flags & DL_FLAG_PM_RUNTIME) {
 			link->supplier_preactivated = true;
 			refcount_inc(&link->rpm_active);
@@ -1683,7 +1687,8 @@ void pm_runtime_put_suppliers(struct device *dev)
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held())
 		if (link->supplier_preactivated) {
 			link->supplier_preactivated = false;
 			if (refcount_dec_not_one(&link->rpm_active))
-- 
2.17.1

