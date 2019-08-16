Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8162C3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B172089E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kueoEIA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfHPCxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:53:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45620 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfHPCxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:53:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so2181057pgp.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 19:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PV4Y2GS/UKkV9mmp2RyNU73hYsBVNlUw9/FLpkqOMOc=;
        b=kueoEIA1lOTWWLvj3OCilRsnT688/xt7NAqY5O3GcwDZ8WCJ9Dv5orDKZmoxrX7SKV
         CTqc5I1HVuTd5nfvowZLldeSDuBYC+cy5YFTfk69iJoNeQb7tmwcNN320cwyIu8qIvAb
         m3wgEFyC1as8OV7qgt+dYqSwQTGdjSYx42mPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PV4Y2GS/UKkV9mmp2RyNU73hYsBVNlUw9/FLpkqOMOc=;
        b=WcrMjenIJjBEkveOL+cqUSQwGhwFagv0RfhIB/+FyxFnM7xBCnoKvG2YtMwpWHJEqj
         uPMgl6Tm8NvNI97sbHPPrTUg2YILzHgmv2G1KuAUSfip5lJP0kVXIW+yFYGLVBjp9HCA
         l2VRC/vygbIIaD5kwqKxw7XlqTSjsFBpGZ2mZ1nNJAYlTXChimSHQWrTnVp6lUBopnzN
         g1yF61KzVmRcLbWn2IW2ltWGWPAPwe91BMfjysM75yNf2Wsvbxd/NjE5h/sGL0SALHWO
         SuVxXJeR1+sjRLURyiXVDlybadVkTmROHB1z9S42WauRRm4VybcVF5+M4iIq15b2z7Ip
         uxCQ==
X-Gm-Message-State: APjAAAWmDFugLgJ5/2X6CiPxrkPI8/VmCLSptSg6FR9nFiqkkvAotvip
        jGO44WzN/g8AZIwzSOTfcuA8xtP2/XU=
X-Google-Smtp-Source: APXvYqwZiZUHFMwCP5u7bsPOAFqQNVPhbXQFQMl/+8LdbccYtvysuawnk3kH1VC++pxK267JDyiYRA==
X-Received: by 2002:a62:fb15:: with SMTP id x21mr8828810pfm.233.1565924019251;
        Thu, 15 Aug 2019 19:53:39 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id v14sm4181258pfm.164.2019.08.15.19.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 19:53:38 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        frederic@kernel.org
Subject: [PATCH -rcu dev 2/3] rcu/tree: Fix issue where sometimes rcu_urgent_qs is not set on IPI
Date:   Thu, 15 Aug 2019 22:53:10 -0400
Message-Id: <20190816025311.241257-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190816025311.241257-1-joel@joelfernandes.org>
References: <20190816025311.241257-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes I see rcu_urgent_qs is not set. This could be when the last
IPI was a long time ago, however, the grace period just started. Set
rcu_urgent_qs so the tick can indeed be stopped.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 322b1b57967c..856d3c9f1955 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1091,6 +1091,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	if (tick_nohz_full_cpu(rdp->cpu) &&
 		   time_after(jiffies,
 			      READ_ONCE(rdp->last_fqs_resched) + jtsq * 3)) {
+		WRITE_ONCE(*ruqp, true);
 		resched_cpu(rdp->cpu);
 		WRITE_ONCE(rdp->last_fqs_resched, jiffies);
 	}
-- 
2.23.0.rc1.153.gdeed80330f-goog

