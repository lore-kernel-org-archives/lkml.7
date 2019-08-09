Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F801C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39327208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wEoB7tUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfHIVpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:45:44 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:56955 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHIVpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:45:43 -0400
Received: by mail-pl1-f202.google.com with SMTP id o6so58164701plk.23
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 14:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6tkFczY/dvkkIFEc1rtR6Zc8LvZ9pSwYHPfa/X0Paso=;
        b=wEoB7tUZTCW5+AS5NImPnh1gGOxb1EwZw4FOWS8Kc/dFOzqKipvTD8X2nUqgQhU+k4
         eRok0zGoilfIAi7gZS5+da+uS1CxgtR7v9eEH4Nrr9s4YGJFh9/VkIK40nplbLwagTQ9
         N5l7slKvKREmdveVoJqNBT0mSNN3h922j/reIAysk+8ieUYLVBTzy9z7mryF3oma93PS
         961HyDaifASIWVYvhCo0cGV3yAe8gsjsjVrUSCSIITDX3t0poWrjbIK5OSi0z1lp2Xjr
         U8OGoWqNC4bkquCCoeZyNLoQwrUImwZlYA8fc9QaJJmZOakgFEP6Ulxqi+fJG/v2L9bC
         nPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6tkFczY/dvkkIFEc1rtR6Zc8LvZ9pSwYHPfa/X0Paso=;
        b=NG6J9/Y13lvLjdiBdqCxPIquaRg5/RsvrYkIxUV1oUy0ZmFQ3dn45u3sfkr/ghr+HS
         scb4jeQP2HMalg6Cg9WGztQznvKBa1Mrr/U+DqxuQC9EoAvvT6v2XpocVckiQFKPfwCT
         CZn8tv4iNoip4/EE4UR9PHbolosovaTF3rCs5FN8V87MtsLVuvFwH7LTVmF7V9L/zw/i
         OPDxgSHPaIkTminoNn73Wkndbl05+5IMHKFL6sRd2Q/rjLmPyFBAhu0I9bgeOah7ETsf
         rLNT0TvswBPsBusIPCvhIE+8iX2bnxp0i1TdNODYEqljZg7VNxUIig7BrwT4WQUt7xfb
         9mOA==
X-Gm-Message-State: APjAAAVrqqCvZoWFTfg8x6bTeZ4iPK4+stzpwiCOZ+TN/tVyNfoSe7hL
        9LsSJOi1ckj+oBP1esvkATxzYIcgvQ==
X-Google-Smtp-Source: APXvYqzFEh7O8qf2o48Fv33K5IsiswwPvBLa5bi275a3dGlUPo7TR41h1n+PjPOmFKM8497I52qf9ZqFlWQ=
X-Received: by 2002:a65:6497:: with SMTP id e23mr18570776pgv.89.1565387142462;
 Fri, 09 Aug 2019 14:45:42 -0700 (PDT)
Date:   Fri,  9 Aug 2019 14:45:38 -0700
Message-Id: <20190809214538.29677-1-yabinc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v2] coresight: Serialize enabling/disabling a link device.
From:   Yabin Cui <yabinc@google.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When tracing etm data of multiple threads on multiple cpus through perf
interface, some link devices are shared between paths of different cpus.
It creates race conditions when different cpus wants to enable/disable
the same link device at the same time.

Example 1:
Two cpus want to enable different ports of a coresight funnel, thus
calling the funnel enable operation at the same time. But the funnel
enable operation isn't reentrantable.

Example 2:
For an enabled coresight dynamic replicator with refcnt=1, one cpu wants
to disable it, while another cpu wants to enable it. Ideally we still have
an enabled replicator with refcnt=1 at the end. But in reality the result
is uncertain.

Since coresight devices claim themselves when enabled for self-hosted
usage, the race conditions above usually make the link devices not usable
after many cycles.

To fix the race conditions, this patch adds a spinlock to serialize
enabling/disabling a link device.

Signed-off-by: Yabin Cui <yabinc@google.com>
---

v1 -> v2: extend lock range to protect read of refcnt in
coresight_disable_link().

---
 drivers/hwtracing/coresight/coresight.c | 12 +++++++++++-
 include/linux/coresight.h               |  3 +++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 55db77f6410b..e526bdeaeb22 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -256,6 +256,7 @@ static int coresight_enable_link(struct coresight_device *csdev,
 	int ret;
 	int link_subtype;
 	int refport, inport, outport;
+	unsigned long flags;
 
 	if (!parent || !child)
 		return -EINVAL;
@@ -274,15 +275,18 @@ static int coresight_enable_link(struct coresight_device *csdev,
 	if (refport < 0)
 		return refport;
 
+	spin_lock_irqsave(&csdev->spinlock, flags);
 	if (atomic_inc_return(&csdev->refcnt[refport]) == 1) {
 		if (link_ops(csdev)->enable) {
 			ret = link_ops(csdev)->enable(csdev, inport, outport);
 			if (ret) {
 				atomic_dec(&csdev->refcnt[refport]);
+				spin_unlock_irqrestore(&csdev->spinlock, flags);
 				return ret;
 			}
 		}
 	}
+	spin_unlock_irqrestore(&csdev->spinlock, flags);
 
 	csdev->enable = true;
 
@@ -296,6 +300,7 @@ static void coresight_disable_link(struct coresight_device *csdev,
 	int i, nr_conns;
 	int link_subtype;
 	int refport, inport, outport;
+	unsigned long flags;
 
 	if (!parent || !child)
 		return;
@@ -315,14 +320,18 @@ static void coresight_disable_link(struct coresight_device *csdev,
 		nr_conns = 1;
 	}
 
+	spin_lock_irqsave(&csdev->spinlock, flags);
 	if (atomic_dec_return(&csdev->refcnt[refport]) == 0) {
 		if (link_ops(csdev)->disable)
 			link_ops(csdev)->disable(csdev, inport, outport);
 	}
 
 	for (i = 0; i < nr_conns; i++)
-		if (atomic_read(&csdev->refcnt[i]) != 0)
+		if (atomic_read(&csdev->refcnt[i]) != 0) {
+			spin_unlock_irqrestore(&csdev->spinlock, flags);
 			return;
+		}
+	spin_unlock_irqrestore(&csdev->spinlock, flags);
 
 	csdev->enable = false;
 }
@@ -1225,6 +1234,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	csdev->subtype = desc->subtype;
 	csdev->ops = desc->ops;
 	csdev->orphan = false;
+	spin_lock_init(&csdev->spinlock);
 
 	csdev->dev.type = &coresight_dev_type[desc->type];
 	csdev->dev.groups = desc->groups;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index a2b68823717b..dd28d9ab841d 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/perf_event.h>
 #include <linux/sched.h>
+#include <linux/spinlock.h>
 
 /* Peripheral id registers (0xFD0-0xFEC) */
 #define CORESIGHT_PERIPHIDR4	0xfd0
@@ -153,6 +154,7 @@ struct coresight_connection {
  *		activated but not yet enabled.  Enabling for a _sink_
  *		appens when a source has been selected for that it.
  * @ea:		Device attribute for sink representation under PMU directory.
+ * @spinlock:	Serialize enabling/disabling this device.
  */
 struct coresight_device {
 	struct coresight_platform_data *pdata;
@@ -166,6 +168,7 @@ struct coresight_device {
 	/* sink specific fields */
 	bool activated;	/* true only if a sink is part of a path */
 	struct dev_ext_attribute *ea;
+	spinlock_t spinlock;
 };
 
 /*
-- 
2.23.0.rc1.153.gdeed80330f-goog

