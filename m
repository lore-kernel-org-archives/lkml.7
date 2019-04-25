Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA33C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519FF218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="q1nfNOEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfDYJR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:17:57 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:3488 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728164AbfDYJRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:17:53 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3P8uclB024832;
        Thu, 25 Apr 2019 11:17:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=E4OJ6ruljLisNJcmxAqdZd1iuQsXRd0SslgNNjwngII=;
 b=q1nfNOEFe/6X4IJLbWKg1HhuBNbSMtH2biDzpp7yIBnl8i1GOA3F5RcCLlkZU84mGCGB
 4nnppOHP+7ZLSnOarBixjtGzdHnuCwLtpKR2jUiUDezh8ES89P4UEQaszfmmtfKB0bkW
 9jEuYsEfz0QH5ImrRlZa4YoSGC9PE0WyzmrdQi32jdbabx4aaq5i1mDKnSU90V9vfx/P
 v096XvoXZ1cWay+xTinjLkCI+66VwE7UzsmhBLs6g77tWDLOWG3/qE8xtVbZarhoQ5Lm
 8aap77lN7fq8H9Q8RPIW8J/ZuoJ4s8etmfZ/dDY65hAMy0SZGf2vGMb3X+jXtP7xwSdB tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ryrvxjq4c-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Apr 2019 11:17:33 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8C67F31;
        Thu, 25 Apr 2019 09:17:32 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5894D1615;
        Thu, 25 Apr 2019 09:17:32 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Apr
 2019 11:17:31 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Apr 2019 11:17:31
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 2/6] hwspinlock: allow sharing of hwspinlocks
Date:   Thu, 25 Apr 2019 11:17:19 +0200
Message-ID: <1556183843-28033-3-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556183843-28033-1-git-send-email-fabien.dessenne@st.com>
References: <1556183843-28033-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation does not allow different devices to use a
common hwspinlock. Offer the possibility to use the same hwspinlock by
several users.
If a device registers to the framework with #hwlock-cells = 2, then
the second parameter of the 'hwlocks' DeviceTree property defines
whether an hwlock is requested for an exclusive or a shared usage.
If a device registers with #hwlock-cells = 1, then all the hwlocks are
for an exclusive usage.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 Documentation/hwspinlock.txt             | 10 ++--
 drivers/hwspinlock/hwspinlock_core.c     | 82 +++++++++++++++++++++++++-------
 drivers/hwspinlock/hwspinlock_internal.h |  2 +
 3 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/Documentation/hwspinlock.txt b/Documentation/hwspinlock.txt
index ed640a2..e6ce2dd 100644
--- a/Documentation/hwspinlock.txt
+++ b/Documentation/hwspinlock.txt
@@ -54,9 +54,11 @@ Should be called from a process context (might sleep).
   struct hwspinlock *hwspin_lock_request_specific(unsigned int id);
 
 Assign a specific hwspinlock id and return its address, or NULL
-if that hwspinlock is already in use. Usually board code will
-be calling this function in order to reserve specific hwspinlock
-ids for predefined purposes.
+if that hwspinlock is already in use and not shared. If that specific
+hwspinlock is declared as shared, it can be requested and used by
+several users.
+Usually board code will be calling this function in order to reserve
+specific hwspinlock ids for predefined purposes.
 
 Should be called from a process context (might sleep).
 
@@ -368,11 +370,13 @@ of which represents a single hardware lock::
 	* struct hwspinlock - this struct represents a single hwspinlock instance
 	* @bank: the hwspinlock_device structure which owns this lock
 	* @lock: initialized and used by hwspinlock core
+	* @refcount: number of users (when shared)
 	* @priv: private data, owned by the underlying platform-specific hwspinlock drv
 	*/
 	struct hwspinlock {
 		struct hwspinlock_device *bank;
 		spinlock_t lock;
+		unsigned int refcount;
 		void *priv;
 	};
 
diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index 2bad40d..53afdeb 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -25,6 +25,8 @@
 
 /* radix tree tags */
 #define HWSPINLOCK_UNUSED	(0) /* tags an hwspinlock as unused */
+#define HWSPINLOCK_EXCLUSIVE	(1) /* tags an hwspinlock as exclusive */
+#define HWSPINLOCK_SHARED	(2) /* tags an hwspinlock as shared */
 
 /*
  * A radix tree is used to maintain the available hwspinlock instances.
@@ -291,7 +293,7 @@ EXPORT_SYMBOL_GPL(__hwspin_unlock);
  * @hwlock_spec: hwlock specifier as found in the device tree
  *
  * This is a simple translation function, suitable for hwspinlock platform
- * drivers that only has a lock specifier length of 1.
+ * drivers that only has a lock specifier length of 1 or 2.
  *
  * Returns a relative index of the lock within a specified bank on success,
  * or -EINVAL on invalid specifier cell count.
@@ -299,7 +301,8 @@ EXPORT_SYMBOL_GPL(__hwspin_unlock);
 static inline int
 of_hwspin_lock_simple_xlate(const struct of_phandle_args *hwlock_spec)
 {
-	if (WARN_ON(hwlock_spec->args_count != 1))
+	if (WARN_ON(hwlock_spec->args_count != 1 &&
+		    hwlock_spec->args_count != 2))
 		return -EINVAL;
 
 	return hwlock_spec->args[0];
@@ -322,11 +325,12 @@ of_hwspin_lock_simple_xlate(const struct of_phandle_args *hwlock_spec)
 int of_hwspin_lock_get_id(struct device_node *np, int index)
 {
 	struct of_phandle_args args;
-	struct hwspinlock *hwlock;
+	struct hwspinlock *hwlock, *tmp;
 	struct radix_tree_iter iter;
 	void **slot;
 	int id;
 	int ret;
+	unsigned int tag;
 
 	ret = of_parse_phandle_with_args(np, "hwlocks", "#hwlock-cells", index,
 					 &args);
@@ -361,6 +365,37 @@ int of_hwspin_lock_get_id(struct device_node *np, int index)
 	}
 	id += hwlock->bank->base_id;
 
+	/* Set the EXCLUSIVE / SHARED tag */
+	if (args.args_count == 2 && args.args[1]) {
+		/* Tag SHARED unless already tagged EXCLUSIVE */
+		if (radix_tree_tag_get(&hwspinlock_tree, id,
+				       HWSPINLOCK_EXCLUSIVE)) {
+			ret = -EINVAL;
+			goto out;
+		}
+		tag = HWSPINLOCK_SHARED;
+	} else {
+		/* Tag EXCLUSIVE unless already tagged SHARED */
+		if (radix_tree_tag_get(&hwspinlock_tree, id,
+				       HWSPINLOCK_SHARED)) {
+			ret = -EINVAL;
+			goto out;
+		}
+		tag = HWSPINLOCK_EXCLUSIVE;
+	}
+
+	/* mark this hwspinlock */
+	hwlock = radix_tree_lookup(&hwspinlock_tree, id);
+	if (!hwlock) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	tmp = radix_tree_tag_set(&hwspinlock_tree, id, tag);
+
+	/* self-sanity check which should never fail */
+	WARN_ON(tmp != hwlock);
+
 out:
 	of_node_put(args.np);
 	return ret ? ret : id;
@@ -483,6 +518,7 @@ int hwspin_lock_register(struct hwspinlock_device *bank, struct device *dev,
 
 		spin_lock_init(&hwlock->lock);
 		hwlock->bank = bank;
+		hwlock->refcount = 0;
 
 		ret = hwspin_lock_register_single(hwlock, base_id + i);
 		if (ret)
@@ -625,7 +661,7 @@ static int __hwspin_lock_request(struct hwspinlock *hwlock)
 {
 	struct device *dev = hwlock->bank->dev;
 	struct hwspinlock *tmp;
-	int ret;
+	int ret, id;
 
 	/* prevent underlying implementation from being removed */
 	if (!try_module_get(dev->driver->owner)) {
@@ -642,13 +678,18 @@ static int __hwspin_lock_request(struct hwspinlock *hwlock)
 		return ret;
 	}
 
+	/* update shareable refcount */
+	id = hwlock_to_id(hwlock);
+	if (radix_tree_tag_get(&hwspinlock_tree, id, HWSPINLOCK_SHARED) &&
+	    hwlock->refcount++)
+		goto out;
+
 	/* mark hwspinlock as used, should not fail */
-	tmp = radix_tree_tag_clear(&hwspinlock_tree, hwlock_to_id(hwlock),
-							HWSPINLOCK_UNUSED);
+	tmp = radix_tree_tag_clear(&hwspinlock_tree, id, HWSPINLOCK_UNUSED);
 
 	/* self-sanity check that should never fail */
 	WARN_ON(tmp != hwlock);
-
+out:
 	return ret;
 }
 
@@ -742,9 +783,9 @@ struct hwspinlock *hwspin_lock_request_specific(unsigned int id)
 	/* sanity check (this shouldn't happen) */
 	WARN_ON(hwlock_to_id(hwlock) != id);
 
-	/* make sure this hwspinlock is unused */
-	ret = radix_tree_tag_get(&hwspinlock_tree, id, HWSPINLOCK_UNUSED);
-	if (ret == 0) {
+	/* make sure this hwspinlock is unused or shareable */
+	if (!radix_tree_tag_get(&hwspinlock_tree, id, HWSPINLOCK_SHARED) &&
+	    !radix_tree_tag_get(&hwspinlock_tree, id, HWSPINLOCK_UNUSED)) {
 		pr_warn("hwspinlock %u is already in use\n", id);
 		hwlock = NULL;
 		goto out;
@@ -777,7 +818,7 @@ int hwspin_lock_free(struct hwspinlock *hwlock)
 {
 	struct device *dev;
 	struct hwspinlock *tmp;
-	int ret;
+	int ret, id;
 
 	if (!hwlock) {
 		pr_err("invalid hwlock\n");
@@ -788,30 +829,35 @@ int hwspin_lock_free(struct hwspinlock *hwlock)
 	mutex_lock(&hwspinlock_tree_lock);
 
 	/* make sure the hwspinlock is used */
-	ret = radix_tree_tag_get(&hwspinlock_tree, hwlock_to_id(hwlock),
-							HWSPINLOCK_UNUSED);
+	id = hwlock_to_id(hwlock);
+	ret = radix_tree_tag_get(&hwspinlock_tree, id, HWSPINLOCK_UNUSED);
 	if (ret == 1) {
 		dev_err(dev, "%s: hwlock is already free\n", __func__);
 		dump_stack();
 		ret = -EINVAL;
-		goto out;
+		goto unlock;
 	}
 
 	/* notify the underlying device that power is not needed */
 	ret = pm_runtime_put(dev);
 	if (ret < 0)
-		goto out;
+		goto unlock;
+
+	/* update shareable refcount */
+	if (radix_tree_tag_get(&hwspinlock_tree, id, HWSPINLOCK_SHARED) &&
+	    --hwlock->refcount)
+		goto put;
 
 	/* mark this hwspinlock as available */
-	tmp = radix_tree_tag_set(&hwspinlock_tree, hwlock_to_id(hwlock),
-							HWSPINLOCK_UNUSED);
+	tmp = radix_tree_tag_set(&hwspinlock_tree, id, HWSPINLOCK_UNUSED);
 
 	/* sanity check (this shouldn't happen) */
 	WARN_ON(tmp != hwlock);
 
+put:
 	module_put(dev->driver->owner);
 
-out:
+unlock:
 	mutex_unlock(&hwspinlock_tree_lock);
 	return ret;
 }
diff --git a/drivers/hwspinlock/hwspinlock_internal.h b/drivers/hwspinlock/hwspinlock_internal.h
index 9eb6bd0..c808e11 100644
--- a/drivers/hwspinlock/hwspinlock_internal.h
+++ b/drivers/hwspinlock/hwspinlock_internal.h
@@ -35,11 +35,13 @@ struct hwspinlock_ops {
  * struct hwspinlock - this struct represents a single hwspinlock instance
  * @bank: the hwspinlock_device structure which owns this lock
  * @lock: initialized and used by hwspinlock core
+ * @refcount: number of users (when shared)
  * @priv: private data, owned by the underlying platform-specific hwspinlock drv
  */
 struct hwspinlock {
 	struct hwspinlock_device *bank;
 	spinlock_t lock;
+	unsigned int refcount;
 	void *priv;
 };
 
-- 
2.7.4

