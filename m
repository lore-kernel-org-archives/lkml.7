Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE95C2D0DD
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A07206E4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0z0zRhl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfLaPQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 10:16:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51190 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfLaPQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 10:16:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so2074205wmb.0;
        Tue, 31 Dec 2019 07:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0zRWwdtgruTsO81wWfn/rafYXouQTO9qf/YHoNcQKSg=;
        b=S0z0zRhln0SWWToB7rd1sTzBK1Q0sJoKJJ8RyrzuC/4V0mC12RPg/7QW8RMXT9jj1E
         ZRtFd8N5PIQGRh7qogmCxO2UkWokTdGwnHS58gdSacAJlcaL//rM1S21TJ5iYMvaCmfS
         b0eAn6+cZttsSZ6hTeWKx5M95/5kvMrQsR+loeP5rp2AAI8wSskpfWctEgwpn+LVb6rW
         UaGuU9nSq66NZ7eqGQ639ytAkURC4v9AwbFbsN0tWs6n/GIFbYUXYL2aCepyUuHNnWhz
         WKjARW6L5l6HVzA7nNj5y+8g+Xt//Rd8Y4wniZiX43AGeI8ekLxhd10qij29nMkcWRdg
         nV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0zRWwdtgruTsO81wWfn/rafYXouQTO9qf/YHoNcQKSg=;
        b=RkoEHL2OCV0nGZPpHBDchujo+46eDfRUMmQtfE1ILYsCFOBNvtA7w9UpClEOwI8mxC
         ukz4DcAWWQR1FSJ1FEtvn34r235JUS5Fvmyv0e6f/KTvH7+S+TNoF98hfJEu/Vfq9BXi
         +R/F9tkHxMSv8awdQO+fhTfwnB/2ESIJ8YBwudPn78MTRVAgaB/V2xVNOe6yJBRxvX4Z
         xylP3sztRh25O9JoP7fcaSif7YJDzWzpxv3ywzAijOy6bsHROjA0cvUOP0uwL8A10xeo
         lyOSD3BxO6Y+LNLBF3HpR/2qa/PoK4+zkSdx/rnxPEljFtEZ55Jnhzjrhaomxts43dwv
         t/3g==
X-Gm-Message-State: APjAAAUg0m2RiasY+0Jg3Rc4eXo39/iQI50KrKn23QGqHpwKYgnPShXq
        tOngSRRxnf6cTqtXkIqxiaHbebnGx68=
X-Google-Smtp-Source: APXvYqzmV8T8DEjiqy7yS+WPrHQvB2YMMSM5zouLY+QLAICDLLBA94+i1woaLjQZBNDYIAPS+lGAyQ==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr4689270wmi.149.1577805362111;
        Tue, 31 Dec 2019 07:16:02 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:45f9:d1e3:14f9:8ba2])
        by smtp.gmail.com with ESMTPSA id e12sm49228468wrn.56.2019.12.31.07.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 07:16:01 -0800 (PST)
From:   sj38.park@gmail.com
X-Google-Original-From: sjpark@amazon.de
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>,
        SeongJae Park <sj38.park@amazon.de>
Subject: [PATCH 2/7] doc/RCU/listRCU: Fix typos in a example code snippets
Date:   Tue, 31 Dec 2019 16:15:44 +0100
Message-Id: <20191231151549.12797-3-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191231151549.12797-1-sjpark@amazon.de>
References: <20191231151549.12797-1-sjpark@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Signed-off-by: SeongJae Park <sj38.park@amazon.de>
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

