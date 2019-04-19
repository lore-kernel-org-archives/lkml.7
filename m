Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9AAC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5803320643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="mcYybduG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfDSStH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:49:07 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:49760 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfDSStG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:49:06 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 9BC5374E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 15:10:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ed2hw2GhHst7 for <linux-kernel@vger.kernel.org>;
        Fri, 19 Apr 2019 10:10:00 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 71890F2D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 10:10:00 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id v11so7146858itb.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 08:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=heZMTrXK8yMYnPBX0J6luSX1OYpenKN39rpGD2b6xog=;
        b=mcYybduGKD6t/GHU9UpwjNHuaq/J5MOlHl1AnHkI7xBe7TZcTqXdOEPRIdG08W6qQA
         IzTSRjBelu/r0fciczxjS9SKd3O4l1SqTA/30M+aEVCCZb4OE/Fd1HMJuWg1+AgInU2k
         yI1MLyB9ixa6SFIQ/xCcvUriPpIx+EjB0pNyA331wUGkukXpb6At7zdEUfPfd8dXBg3p
         LJVbZ9Hvmz0PgyLjzDpciy3rX6md/KkREEttSMNpQb+Bdy2ivUDUhrIDXFSlQOo6O4hP
         4VzPQ6z0FznT9fXDv80pcAWZ+CFjkrj4lBovI3i2isuwo4t9W5PNTWzCk5n3dMAEmpvW
         SEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=heZMTrXK8yMYnPBX0J6luSX1OYpenKN39rpGD2b6xog=;
        b=enWsIpJ9AAGocye+csHemHWw74jhtz2BRqUg7YsTHW9ntX5+foVq6sDBnXKaRr30f1
         9PEfjBGs5XVyIz+t9tfv9sVUi9yvm8x3VBueUz+JE7gx7z0D4Pp3oE6d1iHz58eba1sZ
         44SAP5hMr4zFWdWgURAiBIxzfqQ4rkvRXpjAIDa70FTTPAE+fIoBgygvVEnKSWKpDvmg
         GjkFFTeb5fX33OXgh2H4GaRuY6xMmlRk9rwoW0R/bpwb+qjwCxNZc2S8qDvBYMZcFloy
         VXsTEyF5QbqfCP3wItBC5+cQ/X0Yk459hQwHQubZ9kVS1qR5FP/Arm4r14tQg9hKoLZ8
         bEZg==
X-Gm-Message-State: APjAAAXaUM08ZU6EqW04D42R/ztJdSFrKFQI/v5gQka9cJxxF0bbhi+5
        kQ14iR9YZuBdH0dzKrBJ0d2VRe7cWKc6WIwXpet2hMWdxC4727mC/tXqPo4uH0G8n54yes0zIq+
        zWEIVR2o4KYxSZr9JV4ueQW6ZCtcs
X-Received: by 2002:a02:6209:: with SMTP id d9mr3090688jac.34.1555686600034;
        Fri, 19 Apr 2019 08:10:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxis8ezIQ+Vr5Tp2X/s63yFpoh5uoAFbTIgcDVHLDxOODQxlXa84NdaYDHEb2VlzceWeFPrFA==
X-Received: by 2002:a02:6209:: with SMTP id d9mr3090671jac.34.1555686599829;
        Fri, 19 Apr 2019 08:09:59 -0700 (PDT)
Received: from cs-u-cslp16.dtc.umn.edu (cs-u-cslp16.cs.umn.edu. [128.101.106.40])
        by smtp.gmail.com with ESMTPSA id k203sm1557638itb.0.2019.04.19.08.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 08:09:59 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com (moderated list:AUDIT SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] audit: fix a memory leak bug
Date:   Fri, 19 Apr 2019 10:09:47 -0500
Message-Id: <1555686587-13866-1-git-send-email-wang6495@umn.edu>
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
 kernel/auditfilter.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 63f8b3f..923b858 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1114,22 +1114,28 @@ int audit_rule_change(int type, int seq, void *data, size_t datasz)
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
+
 		err = audit_add_rule(entry);
 		audit_log_rule_change("add_rule", &entry->rule, !err);
 		break;
+
 	case AUDIT_DEL_RULE:
+		entry = audit_data_to_entry(data, datasz);
+		if (IS_ERR(entry))
+			return PTR_ERR(entry);
+
 		err = audit_del_rule(entry);
 		audit_log_rule_change("remove_rule", &entry->rule, !err);
 		break;
+
 	default:
-		err = -EINVAL;
 		WARN_ON(1);
+		return -EINVAL;
 	}
 
 	if (err || type == AUDIT_DEL_RULE) {
-- 
2.7.4

