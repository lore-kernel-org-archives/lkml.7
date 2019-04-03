Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDF9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 23:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698EB214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 23:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uvpQS/sO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDCXEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 19:04:12 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:39152 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDCXEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 19:04:11 -0400
Received: by mail-ua1-f74.google.com with SMTP id v5so112531ual.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 16:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FIYtD+2JyCBUBuNMFC53VJ5k0K3Im0wqDkI3BMTr5U0=;
        b=uvpQS/sOp0F4/7auZRIGbkWQpb4Wu8lNLSbaYPYCQuDPuIIctcQEg03f3TKnxmS6oc
         HIFMCKzdOSuYNWqcl4Q5VsHjWov71kLFC/b63Qv6PAQ8+ff4JsaOWb7nhC6oOs/yMv3m
         7ptIBR4Elsi28SMZ4ujXt9e1T/lE8er+N6aJiBgec0jowELLZWn8CsCciFPO29CUehhO
         QE93VHLSn35s1N/muma+UvtJHhlXyABdQl4DR6Xtkuzl/4S93zPjUMak0/M9thzI8WB4
         dxZ5+ezMY/TZeQ+EUFqedh6wDmNDeB+acwnkx9cmnwd6R4un0VFKkASUgPCboUcbwYX7
         bFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FIYtD+2JyCBUBuNMFC53VJ5k0K3Im0wqDkI3BMTr5U0=;
        b=HB1o/gFGIEmLTAJVUBS/4lKohh7PfRpDLV9jz2wXf36svloaCaR1SIeQw4mq3PHPmp
         pIcPfbVVkfWc93UYaeFpAFNqEpEFujKbTMBRlWzwlQwKEjMwVGPmL+L7eswHG6XGKM1x
         BQcgIEM08b4nrJqeMKkVCTNkYm3J3w9//P09gx4NArEBW+4S67PhSUUZmS9F5ndudDH5
         FtnRO3LL3x+NQ/01WdOPOgbfD0EhRYBDNvvRC5E3FwlkndtzQ3cZC+mZ7e3UsUrtM4uQ
         7ooKu8V3Gju7uHLdCrNKDRaNxjfhOoHpHj5lmnuotEvyMcv+NH3Q7nCczshWRhslEVHL
         SJRQ==
X-Gm-Message-State: APjAAAWE9Cj5TQeS6aZoeTF9QO0R81HN02KQRXtDTV7Dp5taSZSxx9GE
        QfpUE1EfyXj9gFR2jrDNjy+O3epImz5Cdg==
X-Google-Smtp-Source: APXvYqy1PMXMI6wCgoB3VtttZE7088hUGNlmYgd43KczFB7Djpq0uyuRl6RMQbtubKmtTmjoiFdpGn7FvVzx5A==
X-Received: by 2002:a1f:318f:: with SMTP id x137mr330065vkx.9.1554332650639;
 Wed, 03 Apr 2019 16:04:10 -0700 (PDT)
Date:   Wed,  3 Apr 2019 16:03:54 -0700
Message-Id: <20190403230354.117915-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] cgroup: remove extra cgroup_migrate_finish() call
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callers of cgroup_migrate_prepare_dst() correctly call
cgroup_migrate_finish() for success and failure cases both. No need to
call it in cgroup_migrate_prepare_dst() in failure case.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 kernel/cgroup/cgroup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3f2b4bde0f9c..f219c195a9a5 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2602,7 +2602,7 @@ int cgroup_migrate_prepare_dst(struct cgroup_mgctx *mgctx)
 
 		dst_cset = find_css_set(src_cset, src_cset->mg_dst_cgrp);
 		if (!dst_cset)
-			goto err;
+			return -ENOMEM;
 
 		WARN_ON_ONCE(src_cset->mg_dst_cset || dst_cset->mg_dst_cset);
 
@@ -2634,9 +2634,6 @@ int cgroup_migrate_prepare_dst(struct cgroup_mgctx *mgctx)
 	}
 
 	return 0;
-err:
-	cgroup_migrate_finish(mgctx);
-	return -ENOMEM;
 }
 
 /**
-- 
2.21.0.392.gf8f6787159e-goog

