Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBB5C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C4920673
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSVqKmJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfHLT5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 15:57:30 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:53249 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfHLT5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 15:57:30 -0400
Received: by mail-pl1-f201.google.com with SMTP id y22so61695454plr.20
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 12:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5GNCPkMMbCZ3HJHDz62HBb2xsYps2/ATdm0Eu79x0Cc=;
        b=rSVqKmJ5mu4NSSE+/diGDw+cA4jm4cUJ/0cofc87KVgJiI0hlVlnDylK9lWYoYd5JY
         YnKAy5uzwUW8ZdD36aZrfwI8KHdJ/L2wOZ/+UmW1roZOjGh/fVi9Mp+b0U6SGPIBkjWf
         kccl9phzs2wgdYasHuVvB/qFMwsI1ZLohbpAacZ5jWUBh7rbeL+FZcGWtseN8nPh3eju
         Jo73aWHk+77xGg4J67NvEhZtKsjFZNnJecqA2EIb3j7UFXvrOSpB1+Ge5xBJD35NEEdf
         rr4+dCJdLv0QqUXFOrKjSOD6BNoX6upELIRZzZK1hnRirQ9Iq/Yb0UGHlVjawfsojobw
         0Ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5GNCPkMMbCZ3HJHDz62HBb2xsYps2/ATdm0Eu79x0Cc=;
        b=Ve2IHIVXxiXXbqiD18wVNW5Eby9Lv8B3ozvDIGIorO39AnSJPh4QPgzNoWWljmbN1x
         kQTu0KH0C9Mju6v2rG2gRv0qgmjl0WyqqBl5jbvbtNYW0h0bJiB6NJR3XM7tU+dVcftB
         yrR0AJ5mYX1UBca1ZxbedIhJnvFskA+PXy0ww9Cyh5PQZAp9Gr1o3UIKAbY08d1KGwre
         hM6jKks5pu20ol8g8HVx55n8ktTt4ja0aFZB+6lz8WqzrwqcZl/ZktlHWS3OZld2BrNM
         0StB7mm46WvGwyk28AaY13nq2zpOyLzVB4Vr+RYv7rNa7HbFxjpJglMp7WWr3mFzpbg8
         wUpw==
X-Gm-Message-State: APjAAAUGgmAdKxy3Qv1S1Y9ukcE3kx/hXIzHdO45wgxLL3TNzn0NCjdZ
        IL/PHpAyo093EsagKjyMvWIGjcsC1g==
X-Google-Smtp-Source: APXvYqxBt5V2UNHkAs2bWNvKFJgjtO4oF5Zc/GfbLWJRd4JRuCJBH394zibvcdFEg21WL8/QpyCECSidpkA=
X-Received: by 2002:a63:204b:: with SMTP id r11mr31496394pgm.121.1565639849123;
 Mon, 12 Aug 2019 12:57:29 -0700 (PDT)
Date:   Mon, 12 Aug 2019 12:57:25 -0700
Message-Id: <20190812195725.11793-1-yabinc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v3] coresight: Serialize enabling/disabling a link device.
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

Fixes: a06ae8609b3d ("coresight: add CoreSight core layer framework")
Signed-off-by: Yabin Cui <yabinc@google.com>
---

v2 -> v3: extend lock range to protect csdev->enable for link devices.
          Add fixes tag.

---
 drivers/hwtracing/coresight/coresight.c | 12 +++++++++++-
 include/linux/coresight.h               |  3 +++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 55db77f6410b..c069ada151b8 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -256,6 +256,7 @@ static int coresight_enable_link(struct coresight_device *csdev,
 	int ret;
 	int link_subtype;
 	int refport, inport, outport;
+	unsigned long flags;
 
 	if (!parent || !child)
 		return -EINVAL;
@@ -274,17 +275,20 @@ static int coresight_enable_link(struct coresight_device *csdev,
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
 
 	csdev->enable = true;
+	spin_unlock_irqrestore(&csdev->spinlock, flags);
 
 	return 0;
 }
@@ -296,6 +300,7 @@ static void coresight_disable_link(struct coresight_device *csdev,
 	int i, nr_conns;
 	int link_subtype;
 	int refport, inport, outport;
+	unsigned long flags;
 
 	if (!parent || !child)
 		return;
@@ -315,16 +320,20 @@ static void coresight_disable_link(struct coresight_device *csdev,
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
 
 	csdev->enable = false;
+	spin_unlock_irqrestore(&csdev->spinlock, flags);
 }
 
 static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
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

