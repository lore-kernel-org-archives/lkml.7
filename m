Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B7BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB77321927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbfISB1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 21:27:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbfISB1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 21:27:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5638E307D971;
        Thu, 19 Sep 2019 01:27:23 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-19.phx2.redhat.com [10.3.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7B3460F88;
        Thu, 19 Sep 2019 01:27:18 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, sgrubb@redhat.com,
        omosnace@redhat.com, dhowells@redhat.com, simo@redhat.com,
        eparis@parisplace.org, serge@hallyn.com, ebiederm@xmission.com,
        nhorman@tuxdriver.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak90 V7 19/21] audit: check cont depth
Date:   Wed, 18 Sep 2019 21:22:36 -0400
Message-Id: <8cb68e43b55b1b0a021710402ded89444edaf13c.1568834525.git.rgb@redhat.com>
In-Reply-To: <cover.1568834524.git.rgb@redhat.com>
References: <cover.1568834524.git.rgb@redhat.com>
In-Reply-To: <cover.1568834524.git.rgb@redhat.com>
References: <cover.1568834524.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 19 Sep 2019 01:27:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set an arbitrary limit on the depth of audit container identifier
nesting to limit abuse.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.c | 21 +++++++++++++++++++++
 kernel/audit.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/kernel/audit.c b/kernel/audit.c
index 848fd1c8c579..a70c9184e5d9 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2667,6 +2667,22 @@ int audit_signal_info(int sig, struct task_struct *t)
 	return audit_signal_info_syscall(t);
 }
 
+static int audit_contid_depth(struct audit_cont *cont)
+{
+	struct audit_cont *parent;
+	int depth = 1;
+
+	if (!cont)
+		return 0;
+
+	parent = cont->parent;
+	while (parent) {
+		depth++;
+		parent = parent->parent;
+	}
+	return depth;
+}
+
 struct audit_cont *audit_cont(struct task_struct *tsk)
 {
 	if (!tsk->audit || !tsk->audit->cont)
@@ -2785,6 +2801,11 @@ int audit_set_contid(struct task_struct *task, u64 contid)
 			rc = -ENOSPC;
 			goto conterror;
 		}
+		/* Set max contid depth */
+		if (audit_contid_depth(audit_cont(current->real_parent)) >= AUDIT_CONTID_DEPTH) {
+			rc = -EMLINK;
+			goto conterror;
+		}
 		if (!newcont) {
 			newcont = kmalloc(sizeof(struct audit_cont), GFP_ATOMIC);
 			if (newcont) {
diff --git a/kernel/audit.h b/kernel/audit.h
index 89b7de323c13..cb25341c1a0f 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -231,6 +231,8 @@ struct audit_contid_status {
 	u64	id;
 };
 
+#define AUDIT_CONTID_DEPTH	5
+
 /* Indicates that audit should log the full pathname. */
 #define AUDIT_NAME_FULL -1
 
-- 
1.8.3.1

