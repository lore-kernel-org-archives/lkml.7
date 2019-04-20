Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA39C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 01:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C586B21479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 01:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="cG8pngzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfDTBtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 21:49:45 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:49034 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfDTBto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 21:49:44 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 1A7FBF5B
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 01:49:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7E9F2F36Ytsi for <linux-kernel@vger.kernel.org>;
        Fri, 19 Apr 2019 20:49:42 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id E8065FAA
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 20:49:42 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id i188so7094384iti.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 18:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VD3QLDEKv4lm43LR9cpeRD2KnELDpgq8zEURp/4WidA=;
        b=cG8pngzzE9RUp9M8mxr6kCt5YzrE4T1j9DPcQRmoYenliAck9iv+nORd/RwNFqaUY9
         F2jaWIOINXOfawbODjr2QoP+3av9LFq2/Wsh0wspPQMKZBdpqBw4ZDTYKJu7i4rp6aFq
         FRZ0/t/vnrwfthtQRD/Gxp6dX+D28j+VRAJv28nsAHf3wfU4olYrDX0TDPEjKRgJ63l3
         zsGWZjRvfQZMFZGIDD7GHMXlHlvaWfdK8wjqkAPqYL9TT5oadFRgVXrn/eEycZaWDA/U
         SH4F2j9cg0rOE+z4b0WCHppApa1iGZtJqw7U6RpcPAH/yW/aa+DxNbQZkxdqSy6TpsP/
         PKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VD3QLDEKv4lm43LR9cpeRD2KnELDpgq8zEURp/4WidA=;
        b=d5W8DlIOsh1J3BPNVz8mHazDJqZ+sLubVWEdmSaOOHP3xrPiGKrErZNqC6wGoirlmf
         wKIN/EG1GdMEf4FOqMAtVL1iwdcnVOu/GAGzQmzoy90dHSaTDyZHqzVojX2KKTKAszIP
         oy+T8myTTPXIVu5Fx8dYjpjcUQmR9OuE2GGmXkSLq3n6k3RBLdDvk13lOLJS4lB5Hn1f
         qGb0z8eUuYa04IgsiZsvYxlrC7lwHzAm1+a268/4kQW5rnDagH3Qv0/yNPIMeyvWfyfV
         DC/rEcU4PQWFh5E8hhl4F26em0emBhxppTodvLuHFjU9tMK4if3AMoYioKQXFHigNcc1
         MjfQ==
X-Gm-Message-State: APjAAAW1nYjjc6ACKrg8pu7IijRtCfZbipJZa9DcgzWg/lmiBsYtA00H
        xDmKLGDa+iRSbjToWCoyFCSBbTHNLPxW1iVpUFX2jzfiD2wJ0jF49abUuHWF4Gh1VAQNiSNYBA2
        p4nIxcRmVhTAamOQhAS7vQIuM+3kK
X-Received: by 2002:a6b:e009:: with SMTP id z9mr4513180iog.127.1555724982335;
        Fri, 19 Apr 2019 18:49:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz6OoGF2CHX3mLxLBU+p+ZiOhiQ1JedjaYq4YVq2MrWlUHS0/pCWh3mRxsFiQiug6v38dp1Sg==
X-Received: by 2002:a6b:e009:: with SMTP id z9mr4513176iog.127.1555724982175;
        Fri, 19 Apr 2019 18:49:42 -0700 (PDT)
Received: from cs-u-cslp16.dtc.umn.edu (cs-u-cslp16.cs.umn.edu. [128.101.106.40])
        by smtp.gmail.com with ESMTPSA id x187sm3113380itb.39.2019.04.19.18.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 18:49:41 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com (moderated list:AUDIT SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] audit: fix a memory leak bug
Date:   Fri, 19 Apr 2019 20:49:29 -0500
Message-Id: <1555724969-15300-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In audit_rule_change(), audit_data_to_entry() is firstly invoked to
translate the payload data to the kernel's rule representation. In
audit_data_to_entry(), depending on the audit field type, an audit tree may
be created in audit_make_tree(), which eventually invokes kmalloc() to
allocate the tree.  Since this tree is a temporary tree, it will be then
freed in the following execution, e.g., audit_add_rule() if the message
type is AUDIT_ADD_RULE or audit_del_rule() if the message type is
AUDIT_DEL_RULE. However, if the message type is neither AUDIT_ADD_RULE nor
AUDIT_DEL_RULE, i.e., the default case of the switch statement, this
temporary tree is not freed.

To fix this issue, only allocate the tree when the type is AUDIT_ADD_RULE
or AUDIT_DEL_RULE.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 kernel/auditfilter.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 63f8b3f..3ac71c4 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1114,22 +1114,24 @@ int audit_rule_change(int type, int seq, void *data, size_t datasz)
 	int err = 0;
 	struct audit_entry *entry;
 
-	entry = audit_data_to_entry(data, datasz);
-	if (IS_ERR(entry))
-		return PTR_ERR(entry);
-
 	switch (type) {
 	case AUDIT_ADD_RULE:
+		entry = audit_data_to_entry(data, datasz);
+		if (IS_ERR(entry))
+			return PTR_ERR(entry);
 		err = audit_add_rule(entry);
 		audit_log_rule_change("add_rule", &entry->rule, !err);
 		break;
 	case AUDIT_DEL_RULE:
+		entry = audit_data_to_entry(data, datasz);
+		if (IS_ERR(entry))
+			return PTR_ERR(entry);
 		err = audit_del_rule(entry);
 		audit_log_rule_change("remove_rule", &entry->rule, !err);
 		break;
 	default:
-		err = -EINVAL;
 		WARN_ON(1);
+		return -EINVAL;
 	}
 
 	if (err || type == AUDIT_DEL_RULE) {
-- 
2.7.4

