Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA35C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56152147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EuvZBJXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfDDAeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:34:24 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:43553 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbfDDAdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:54 -0400
Received: by mail-it1-f202.google.com with SMTP id m192so683025ita.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H3HRoHYDWMArQkaxv1MNV9sbVAN4QTLQDsX3m+S9eoU=;
        b=EuvZBJXktt6F0ubAptUi55XvRrS0bKkJnnv1U/zgt6sGHkb46NdO1QZ+G9sI+ZkhfA
         JelD4bF/2Pj/hihb+SKHwlJ8aIjjC7e63Pu3qmQ3SlJe54ayQ6S9xdyfaTuT1jP09UZQ
         p5n1e8v2LdA/LRCQEeXI2QKFxaPLp8FNAWrgShmJIxnE1H6AkZMQwuPTyOGlFYMSR0nh
         NoyORJSv21az9frVzup98ATuqYeUtUG0Av2bSGPCU2zcN9wclGUw3JzELE6GzV1KxhFy
         l5/lV4gzrWlUE08BglDw/kUo6esP+LKLYEMhsER7SVRCEC7kdasgVUQWuHjLBMDqKmDc
         8qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H3HRoHYDWMArQkaxv1MNV9sbVAN4QTLQDsX3m+S9eoU=;
        b=XN1BZLOi27A77JDN6EwuCAzNzANdVhPbXnFLq61oLpDlgcBeBnPNzGhUvK6TrLbm48
         N5gN8Hn/nu/4Fxo3J0a+ciTj/GiqnBEQSz55oHRWXXW5vDffuYpSFc754dDZQ3vtU3HU
         pzJi5p/1Yc64+NVQj3GNy8O/VOjt11ZkWg1JWhUElmo1Et0dLXo/aKqMaNreTTh69tsi
         bZYoi3RPUC1CTR6QNjmAKV4M9rLUzJmV1vugfDzsS8XYGyw/fjUORROI0SAN8ypjzwn1
         Ys6YGDZEGa4HtBSwvmlYmGe9TDMys510E9tojdUKZYVqQ6gMxJKezLVtg9Yn/drqaQJD
         2X7w==
X-Gm-Message-State: APjAAAW1vB+zicUVO8A8/jdNzM98z6zYQli1eD+dZELQURB8i2D2xoGu
        7Sznbf4OJRUjE95bXK4H+8hO4T++Xis5kR50i66MkQ==
X-Google-Smtp-Source: APXvYqx2eKKhEOnybJeNgu76/wWUtSGW35RuZ+QQ32lRZx5l58gboRDh908+pCXmRC8kk88E8Ad7UHpBCodo1958l2JfVg==
X-Received: by 2002:a24:7f52:: with SMTP id r79mr581420itc.33.1554338033807;
 Wed, 03 Apr 2019 17:33:53 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:45 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-24-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 23/27] Lock down perf when in confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow the use of certain perf facilities that might allow userspace to
access kernel data.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 kernel/events/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3cd13a30f732..6ad3d83c091c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10461,6 +10461,12 @@ SYSCALL_DEFINE5(perf_event_open,
 			return -EINVAL;
 	}
 
+	if ((attr.sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    kernel_is_locked_down("PERF_SAMPLE_REGS_INTR",
+				  LOCKDOWN_CONFIDENTIALITY))
+		/* REGS_INTR can leak data, lockdown must prevent this */
+		return -EPERM;
+
 	/* Only privileged users can get physical addresses */
 	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
 	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-- 
2.21.0.392.gf8f6787159e-goog

