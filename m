Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B451BC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800E4206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="UFZoz3sj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfE1PJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:09:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35916 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfE1PJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:09:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id s17so20650965wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 08:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75ZL3pIfL3dGmPPRYb+LTkSC/IF0uVMpALzsYtJ/Ivw=;
        b=UFZoz3sjTsHrA2xQmESKW39Nxo5Fa9hoR5CkiAVdhUyGaT9djQIWGKLIy24BjWoMhn
         K3tpd7Fp7oIFh0VEzwLfFyHBUuQ6LGfJd73M5r1Rr3jwjKiAdQU1CEOJsss1MAnnB1WD
         p/Hv3sD3DqPJM2PF/Hum9DRlyzCbe5fpESfOnaTJg7ysuviNM+G9YVPL1IjIKanYNTk5
         inVGV4JeKSP4/LdWrkX/IfQdyUnF7loVHf1FdpHrRWUZhBSgFl91I9mFmG+LqJy8w2fv
         TEh0B4LVW93Nd3eA0+pjd9IFJPkSxweCWKY0jL6QM67aioIN5k5WDe1CXforWh/aiaTS
         5ftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75ZL3pIfL3dGmPPRYb+LTkSC/IF0uVMpALzsYtJ/Ivw=;
        b=Q+rJWYHdfntfKEGaZQ44p6NY297JK5CTwpNpRlnZGMnBm2TTVwTsGFbX0QM27qtj8W
         YScdxumYwsp7WuqZ6MrpIqDQGl4RsqbPb+4s5Py9kOMBfbb4RR9YFuF6SIdmBwQU66xX
         N9A6VVw2TiZKKcf/HqVYUJlmOYvsdHdp6BdxuVobDOadVn0EUcvQryGVHzRGwLYHodHi
         j/qPNyHLGAq/0r6UkIJ+9hVv5roCulVOiqxxVH8fJgXfbzRCEJuOpvM5iGEiKMA+dzYY
         5eC+qcM6mVdCn/Yl8MqZaXiiD6T6vyoFDM4ebrchfE3O+dmTdfcuaeShI7cZAODBl73U
         nB+Q==
X-Gm-Message-State: APjAAAX8/ZPKs8y7smXyxA0AERzwcSCksL4YTKYIAwuBeyQCSpYnVkOJ
        OklhV/aIAUxYPfPx5DtunftvdRZiv3Q=
X-Google-Smtp-Source: APXvYqz7XvXIaJHz2/ebZiHNj271t0NW9547U92SYQlC6lRwF512nztTw3ES99AKxnDI5IpihSkt6g==
X-Received: by 2002:adf:c506:: with SMTP id q6mr17196082wrf.219.1559056185144;
        Tue, 28 May 2019 08:09:45 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:203:fc05:dec:5003:37b1])
        by smtp.gmail.com with ESMTPSA id o8sm12457966wrx.50.2019.05.28.08.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 08:09:44 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Alessio Balsini <balsini@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] sched/deadline: Minor typos in dl_entity_overflow comment
Date:   Tue, 28 May 2019 16:08:40 +0100
Message-Id: <20190528150840.65581-1-balsini@android.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two non-critical typos in the documentation of the dl_entity_overflow
function:
- "rather then" --> "rather than";
- "in such way that" --> "in such a way that".

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 kernel/sched/deadline.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 43901fa3f2693..9b3987b74ca64 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -769,7 +769,7 @@ static bool dl_entity_overflow(struct sched_dl_entity *dl_se,
 }
 
 /*
- * Revised wakeup rule [1]: For self-suspending tasks, rather then
+ * Revised wakeup rule [1]: For self-suspending tasks, rather than
  * re-initializing task's runtime and deadline, the revised wakeup
  * rule adjusts the task's runtime to avoid the task to overrun its
  * density.
@@ -780,7 +780,7 @@ static bool dl_entity_overflow(struct sched_dl_entity *dl_se,
  * Therefore, runtime can be adjusted to:
  *     runtime = (dl_runtime / dl_deadline) * (deadline - t)
  *
- * In such way that runtime will be equal to the maximum density
+ * In such a way that runtime will be equal to the maximum density
  * the task can use without breaking any rule.
  *
  * [1] Luca Abeni, Giuseppe Lipari, and Juri Lelli. 2015. Constant
-- 
2.22.0.rc1.257.g3120a18244-goog

