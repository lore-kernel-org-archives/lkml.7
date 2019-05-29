Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A58C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3032417A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="UhncK3Mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfE2UhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:37:04 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34938 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfE2UhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:37:00 -0400
Received: by mail-it1-f194.google.com with SMTP id u186so5824599ith.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=w7QPz7ZUite4KQfIp7TZRJYqHCEy0azpYC8zotwj3aE=;
        b=UhncK3MfkWQhhoi44cKLjqaFgHLu2C8g9GJkFZZqwaJlpR4wcL6BkY2tjIlxo1iuSl
         ZnOXkHy4mpopanhjBVapZoH3y4SON8r0AYh3DWjwkA9+in65XsUcA4sVQD36RBLv7D4X
         dNld6gjzllBmpSJeZ33jxoAVPn5O5hP1YohUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=w7QPz7ZUite4KQfIp7TZRJYqHCEy0azpYC8zotwj3aE=;
        b=kMjS4tLgnG297F6hWskf/6wrMcjwYiubWxwZrV3hS3QoNhYp1KMx25xuDORpHmfqOh
         r5BqKY6iHAO+/GNmFOthpjPlGRnt75h/qokCRpC18Mj+N5BfOqKfqQDg1d3qeAZ8+GVR
         K89MkmP0IFBbskH0paUBo3vCuACsOFs6l0sOvlSwZQXPfrBnDR1mqdI1NsG8wIM5/qUE
         qhO4HouTDpuha+51gmPELXE8zMojsSaYzqyKeUHbNNEQBmb0LF3xUur79VwB9+YnkLpb
         CpA7c6CvqvjVw6by9yG3vhj1F/pkfX1WNLR7ipRce5xwU8ZF9oN6cwWpJvrHzCrubMqv
         LIXQ==
X-Gm-Message-State: APjAAAVwP1T0MMUWshC71Aitly180j1QXUimFbWzb6upvdpUJSq0zhE5
        bc/nBKzsrWgUKERpDRWPW5hFsA==
X-Google-Smtp-Source: APXvYqxMfar33fZsb1BeuXBdfhOiXnx/e/4XdmoZ9vN+LbXRJX2/n6D3E6TpV/B4V9KQTi4gPDzafg==
X-Received: by 2002:a24:9ac7:: with SMTP id l190mr180119ite.100.1559162219277;
        Wed, 29 May 2019 13:36:59 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id c185sm181127itc.17.2019.05.29.13.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:36:58 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v3 02/16] sched: Fix kerneldoc comment for ia64_set_curr_task
Date:   Wed, 29 May 2019 20:36:38 +0000
Message-Id: <fde3a65ea3091ec6b84dac3c19639f85f452c5d1.1559129225.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4778c48a7fda..416ea613eda8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6287,7 +6287,7 @@ struct task_struct *curr_task(int cpu)
 
 #ifdef CONFIG_IA64
 /**
- * set_curr_task - set the current task for a given CPU.
+ * ia64_set_curr_task - set the current task for a given CPU.
  * @cpu: the processor in question.
  * @p: the task pointer to set.
  *
-- 
2.17.1

