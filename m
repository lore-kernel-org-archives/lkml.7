Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EC6C2D0DC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDED4206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVethCqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfLaPQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 10:16:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51198 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfLaPQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 10:16:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so2074345wmb.0;
        Tue, 31 Dec 2019 07:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dDOXvXXB7UzDluxKr8AnFvkjJq1L4DGq2Yh5s/+W6X8=;
        b=KVethCqCsS2rv3qeNDDWAsQ5dktDNvJFIQIA4QGigzIw/E++LDUXtjXw7EvnaZz1hj
         /HGlS/MuA1X/M3PV0LdgA0JF0FYwDegXIKFnNrI9uncovqu6gTSWn16jOJumpB5U8aut
         RdjkFQYkhuFLhQ9IWUGIsCmVm30stijBFbMOoR9RjrtjS2qSZyFtZQ5sjzGLGOm3vPyh
         p89qWytWSaFJQznIM6CSu9FsKqtw0u1NWv/pS5Qv7zWHJ4AxTm50VZvT/RTO06+846kl
         bNso9VHY/qClMJKvAprtre5rHG5Wkfa9MmYi3EqRzFUq93dHkq9uqewFIOydksUm6pio
         3Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dDOXvXXB7UzDluxKr8AnFvkjJq1L4DGq2Yh5s/+W6X8=;
        b=MWdOFIcFib4MR96RfoRc9a+L/QaYSHU+OHMODOo8wJvq4Q9gowjq/P//K7MFl/oj5K
         neiEnZk1iL7Kb5PHHQ37wKzpkFVYxyaQ7t0cj3Zk9aIUmxyDqLQEvmAuGNw+QsxDvhb4
         CFwHz+Rkd6970tXV6F1j5ZsiZ38/eSM9AXRjub6QPBM9+wPeaPN/5lFogzEbbh6cwJJB
         /b3SJ3pJtnXltZK76A2CT9OH2HMiylgFxQ8XMjLUjiUZPvhqPZFdp+PKzItNmwpqVLS4
         kp+WvIZ1mzjdIxQBvoQ+zYuhsj0gNfPRay8NHYVFPj1AIR5/OQ0hKhz3aLXpWToDoSfh
         qHrQ==
X-Gm-Message-State: APjAAAXObD5P6TKVQxFnq9DebTAhVMxeL28UouTtg+psjHjmtA8Pbufw
        RyeRE94oFPFDjIPpNR08xBhEdCBuZ84=
X-Google-Smtp-Source: APXvYqzxLZzNTX1kqD+faeyhHx8/Eo7zx7odEP/ZX8DJ0zQbFLgZaI+w9/6CsoEUlEwvgq+9hNB3dw==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr4866687wmg.110.1577805367417;
        Tue, 31 Dec 2019 07:16:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:45f9:d1e3:14f9:8ba2])
        by smtp.gmail.com with ESMTPSA id e12sm49228468wrn.56.2019.12.31.07.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 07:16:06 -0800 (PST)
From:   sj38.park@gmail.com
X-Google-Original-From: sjpark@amazon.de
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 6/7] doc/RCU/rcu: Use https instead of http if possible
Date:   Tue, 31 Dec 2019 16:15:48 +0100
Message-Id: <20191231151549.12797-7-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191231151549.12797-1-sjpark@amazon.de>
References: <20191231151549.12797-1-sjpark@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/RCU/rcu.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index 2a830c51477e..0e03c6ef3147 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -79,7 +79,7 @@ Frequently Asked Questions
   Of these, one was allowed to lapse by the assignee, and the
   others have been contributed to the Linux kernel under GPL.
   There are now also LGPL implementations of user-level RCU
-  available (http://liburcu.org/).
+  available (https://liburcu.org/).
 
 - I hear that RCU needs work in order to support realtime kernels?
 
-- 
2.17.1

