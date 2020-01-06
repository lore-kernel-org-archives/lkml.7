Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77129C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F5D2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1g+/l8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgAFUIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:08:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42165 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgAFUI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:08:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so51073279wro.9;
        Mon, 06 Jan 2020 12:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F2cYtzodL9YV1EN0v6Lt+0C7d2wI63L5Ti7WB64sdNw=;
        b=E1g+/l8W5UpNIDqkgKEFYfjkT7MLJrnRJ45k5ZOt7ZPLY/rbiKiZ55Ge5l8zAhc6q0
         SE/19jmrOiZTGZ6bvbS6fY2ghbGMrdWAggj4BawE9bKxMBlAllBov9UyNaHdUYWouUAJ
         1WXWhq/vS6QmOXozI5p4AVcyQrKeQo2tRf0wRhm5hTlCtYHPa9a+tDMq2iCQ0i3MaTpW
         EuOXBx7JBwvxR+yITqZ/TQeMzX1VSJxy2f2NYmqFNwY6w9BAcvlHvZa5gY2x5z0v/iSd
         +fbwvmK0u88rCWoZx1wqTd+Lx8vO+XR/DKHTkA6aETJxsvI3qUXurM45Q9un53BiqL+n
         yRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F2cYtzodL9YV1EN0v6Lt+0C7d2wI63L5Ti7WB64sdNw=;
        b=oD/juFbeXv4MPARZ2xpd9fZNH1OQ976+g79K3RCC/kVR9hd8cpykfZDCmb0lbxript
         50m5/EwwIXcWBAswM6RqMnbpV7k4K3AG+uxOBXLkskU2OA3QrzYX+qFegH8q87IqKQ2O
         jQyol03Dh/2Uq2pzIhK7khHL9RuyZTut+lQ9IQEnY3ub/LnRzjk/T+VLnhcl+8tprtu5
         Gda493LwdOFxBgodBIvhcut41/HuqIigtiFsH7ilJbEcbBGUkEUXdrRLHbfT7ZhKWnQC
         ehwW06XkRewBSuSGMAUVTTjClGpZo0yYzpUUjyAvgyAJvCHCrOmSTW/j3dY9W19LBZeM
         hYhg==
X-Gm-Message-State: APjAAAWJTxBwuV8KTWpfd6yXNauvQGqnkkNVM01s3apuv6wk0BxF6Wlo
        Q5cG0Iw+qkLSvUMFNUOJYhA=
X-Google-Smtp-Source: APXvYqzAr+PY6eXwyS4I6TtUEcARBjR00PvgGyLI7ehmIfPGTrpvRbxubZxMleBEinzO3iGpsSPlow==
X-Received: by 2002:a5d:65c5:: with SMTP id e5mr104548540wrw.311.1578341305876;
        Mon, 06 Jan 2020 12:08:25 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:74f9:b588:decc:794d])
        by smtp.gmail.com with ESMTPSA id t190sm23836982wmt.44.2020.01.06.12.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:08:25 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, madhuparnabhowmik04@gmail.com, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v3 2/7] doc/RCU/listRCU: Fix typos in a example code snippets
Date:   Mon,  6 Jan 2020 21:07:57 +0100
Message-Id: <20200106200802.26994-3-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106200802.26994-1-sj38.park@gmail.com>
References: <20200106200802.26994-1-sj38.park@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/RCU/listRCU.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
index 55d2b30db481..e768f56e8fa3 100644
--- a/Documentation/RCU/listRCU.rst
+++ b/Documentation/RCU/listRCU.rst
@@ -226,7 +226,7 @@ need to be filled in)::
 		list_for_each_entry(e, list, list) {
 			if (!audit_compare_rule(rule, &e->rule)) {
 				e->rule.action = newaction;
-				e->rule.file_count = newfield_count;
+				e->rule.field_count = newfield_count;
 				write_unlock(&auditsc_lock);
 				return 0;
 			}
@@ -255,7 +255,7 @@ RCU (*read-copy update*) its name.  The RCU code is as follows::
 					return -ENOMEM;
 				audit_copy_rule(&ne->rule, &e->rule);
 				ne->rule.action = newaction;
-				ne->rule.file_count = newfield_count;
+				ne->rule.field_count = newfield_count;
 				list_replace_rcu(&e->list, &ne->list);
 				call_rcu(&e->rcu, audit_free_rule);
 				return 0;
-- 
2.17.1

