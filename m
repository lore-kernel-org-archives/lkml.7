Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8436C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946D9214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BetvwZcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404758AbfHHTRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:17:35 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:53389 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404592AbfHHTRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:17:32 -0400
Received: by mail-qt1-f201.google.com with SMTP id q9so7151982qtp.20
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 12:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=n1rPGE45Vv9PYSBQo+gbqrqUGU7GHu12P6zmiT4Upy8=;
        b=BetvwZcgg5rNPJoqNeBgcvBGbhDS13ZMG1CCVJ7AZati0UfVO4XB58q1n82c37gTkd
         9G5d+yrEmKkbJ3aewSVlZDSmbT0l4AMxbQ1t1qyFh3qQi15vgA9JD0ah3zYbvkvmbhN5
         /xSBubMffiViT7Wq0nqlrCgcwO9Y7G8ZBb06kxz8ams8CEtLZz+ivBzJPl/whqLSCOR7
         tsg34prHitTZZbYOQdA+cJ//Heyt4UN5AJ9M8zFtnvwKgjQbAce/hMawmytuvp+71Byh
         QqTAS9RLJkYkZYWThJGRKP1lioh5PoF2QcTlshSMtXMTeb+3krcwhRcPGokwp98LwxG5
         x7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=n1rPGE45Vv9PYSBQo+gbqrqUGU7GHu12P6zmiT4Upy8=;
        b=n9LoaBbQut//lXfICCFA9EzQ6bPb4jobH0XjUruWk8Nl/vWSh2Z2feG6nuJB0FmnrF
         ViH75cq29OYOEH2O3jwWvHb0W9Q+3Md1iu7vQ/x2b50PelaCFd08/TQEvAWdFxC32Zeo
         9cCznWxTFPLMR7xQiz1w+tt+g2DT81O5FkDV6FF+C1hoigfpQN+a6K5UOwVAk5T4KvlH
         Ug9OzmNYFqRaIP40CQbueuVmgAf6woqp0adXNA+IX4qKoNl7EaHFDO5BkaN6ZUrOq0NE
         aV9vfRKsrN64dTvNl/YS05JslTXbMhZXQPLvs6TGyPANbVYDRE06vGVkmKipbh3Z6pjV
         Pmkw==
X-Gm-Message-State: APjAAAWGqiaPYAWsVMtoAYdsdZUiV9ogoMMtCH3PzggxAvhZYJcAorz/
        d8UpY+1ttTvvXdvRqEg9eWpU5LMuOg==
X-Google-Smtp-Source: APXvYqxlMMdwKW0gDRzyHxtAqpr9SUDwCZ62ezy0CtTcCaxDe5YgFegRMAjnXHjWXfcEWwepVmelhECkQw4=
X-Received: by 2002:aed:3b30:: with SMTP id p45mr7076254qte.84.1565291850598;
 Thu, 08 Aug 2019 12:17:30 -0700 (PDT)
Date:   Thu,  8 Aug 2019 12:17:26 -0700
Message-Id: <20190808191726.65806-1-yabinc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH] coresight: Serialize enabling/disabling a link device.
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
 drivers/hwtracing/coresight/coresight.c | 8 ++++++++
 include/linux/coresight.h               | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 55db77f6410b..90f97f4f99b2 100644
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
@@ -315,10 +320,12 @@ static void coresight_disable_link(struct coresight_device *csdev,
 		nr_conns = 1;
 	}
 
+	spin_lock_irqsave(&csdev->spinlock, flags);
 	if (atomic_dec_return(&csdev->refcnt[refport]) == 0) {
 		if (link_ops(csdev)->disable)
 			link_ops(csdev)->disable(csdev, inport, outport);
 	}
+	spin_unlock_irqrestore(&csdev->spinlock, flags);
 
 	for (i = 0; i < nr_conns; i++)
 		if (atomic_read(&csdev->refcnt[i]) != 0)
@@ -1225,6 +1232,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
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
2.22.0.770.g0f2c4a37fd-goog

