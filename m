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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA07C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EDA21744
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fd7LSQWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgAFTTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:19:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33360 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgAFTTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:19:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id d139so12582528wmd.0;
        Mon, 06 Jan 2020 11:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zeP0eN1dUE1xzDIlU/IUQAQU1O+6HgpYq6pFUmIIuMk=;
        b=Fd7LSQWRINPNLb/VBtgPeEZtoKSP6R+vwS8lVCQFMpkGsKHLgBHjGY06+QfeXADO0I
         VXT5VFO6ZlwJO66g4dWgqMGxU1U/kfy+YPCYBuLVcOA+wkTOsNIxWdWhzcovTNC5CkMb
         7+5eBfKl8XYyhnc0U1d8h/lQxK0NqFOjdQCHewk2Et3qC+kMCIFMlyMWHbBkMXOGVFT7
         wMW74bJvd0g1m7k2JHfN27fjzhtDcGqlZ0U/0gBVxoVpXA0v9QWYwB+SypvKyUj9zcpT
         JtCJfYXUkOOCC83tvy8bau8DANcFqjWx/cgAv1oAF2RmI7NumYDF0joOGE0O1OTSRSll
         m5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zeP0eN1dUE1xzDIlU/IUQAQU1O+6HgpYq6pFUmIIuMk=;
        b=GywX+1oD7oR3+qrVMo5prSU5WUhWP9r2w5pmPuw8NIRIvuW4TDEdcmvrxo4HYFeLk6
         6dmBcjDgBV8ib3KflhdA0vL2AX1H6ZnTNkAK9AGDYP/iIwz+A+6oVRyWrh66ISB49IrM
         ouo4kBeF5qZuNr13gd7RPuyUgv2JtkM96r4nEN7/9rZexDavrewi0KkmUpkhWZ0kjC/z
         PzvOyitQaZRVHrV92yHIN37yFXwC3VrxorDuIR4s1JGaL5hBeSpxBLC9WdRcart16e/l
         bd4zqrZW0xaYEniR4juyc1GyHGFd7N1cNjlkS8cQGbKtWYVNYt9DEyVbtD5bIZphD8o3
         aDZg==
X-Gm-Message-State: APjAAAWBI6eY/sVn6uNCqli6aog6zPoCDvGGublGNoAC3gQYrMZxAlN9
        0/R+OxGNQweQgyaqwcSjPU0=
X-Google-Smtp-Source: APXvYqz/pL+s4nunEAAnflBlpILs+ijTd1HLdhvuPtJjt5Nwy+P/KhoWwS3p9BTQOQM8N2grZ4VN6g==
X-Received: by 2002:a05:600c:2290:: with SMTP id 16mr37939668wmf.93.1578338352548;
        Mon, 06 Jan 2020 11:19:12 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:74f9:b588:decc:794d])
        by smtp.gmail.com with ESMTPSA id o4sm72041756wrx.25.2020.01.06.11.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 11:19:11 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, madhuparnabhowmik04@gmail.com,
        sj38.park@gmail.com, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2 2/7] doc/RCU/listRCU: Fix typos in a example code snippets
Date:   Mon,  6 Jan 2020 20:18:47 +0100
Message-Id: <20200106191852.22973-3-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106191852.22973-1-sjpark@amazon.de>
References: <20200106191852.22973-1-sjpark@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

