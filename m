Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6F2C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F022214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rgH/6eCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfIQOfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:35:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34129 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbfIQOfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:35:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id j1so4728366qth.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=w1n37j4W3WBasnt2XIfLYiJPlLaXIhc4CUnkt5PWajA=;
        b=rgH/6eCY+b/er+zh8gkhbaB/5JPfPp9/mmEJZckL5J98G151Yqc6wqaI4kUD1JRQod
         SJcA7ksRNHRgFm+KdKTJM3+J7E1I74PmW5XgDaMv2FRrrBj9qr97g58GdMzpziF06aa8
         ydYgkh0TkQeKAQbMhVx5CcuwvDROa2KkNLI4xa+3wCM8EcD6QeSEgHzPE3fpnIRrd8Nw
         rfQxHfz4BT4UDaPr/2HjZgA68l8Tvv1cRYpeWNO+Zj9VxS6BOc3/DcfS5BLb/tA59RPF
         aP3ojEVCDnwYU4YWX9gwbHdnxuyqnDqfw7ikIWkoJpXGqIE6Ynrtdrx3vQw5K26ru4B6
         DMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w1n37j4W3WBasnt2XIfLYiJPlLaXIhc4CUnkt5PWajA=;
        b=B3wk9ZPffG1u2rqAH2JGnproZ4lK4gZcAUVO8hk1PHJXXAQFS086HamLTo7iNd0NdX
         b/j5RQiA2PVcKL56JPs2XAVZEOOofUDCXHB83/KZEZMZtMSzWGjY6bzWApURH1lD4wAo
         EGfKFaxkne0WLdLXSj0RsQRUxDfw409pNB+uaJxUXTDRadSk5BICU/TYw39WX9vdqJgY
         subCxtKP7ZQbZhh+c/fGxe8Ia43c1l184KtzUuAuWG4orlVp9mWTjPWmO4UJ5geLKP+v
         gVUIBEbFiTol889aqm7wMiQgvBZxBTTUU1Qh8zdbLnAX2yqh+SEjgM/67vkohCuC8bo7
         aYWA==
X-Gm-Message-State: APjAAAXhgOxstGkVOfTd0eI/Wp43+2AsXgmFomAmZnKQz1T1zricZ85D
        j2CsGERb/CxMA/Gm29XkObanmA==
X-Google-Smtp-Source: APXvYqwcaKUYrjpnB+WlcTjBqlkAUrODWyXnraVpWmsn3tSTofdYFgs0clXEhFjENsxJ6M6sAPK9Hg==
X-Received: by 2002:ac8:7b2e:: with SMTP id l14mr4000591qtu.11.1568730910911;
        Tue, 17 Sep 2019 07:35:10 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v12sm1641563qtb.5.2019.09.17.07.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 07:35:10 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] sched: fix an unused function "node_cpu" warning
Date:   Tue, 17 Sep 2019 10:34:54 -0400
Message-Id: <1568730894-10483-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang reports a warning,

kernel/locking/osq_lock.c:25:19: warning: unused function 'node_cpu'
[-Wunused-function]

due to osq_lock() calls vcpu_is_preempted(node_cpu(node->prev))), but
vcpu_is_preempted() is compiled away. Fix it by converting the dummy
vcpu_is_preempted() from a macro to a proper static inline function.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/linux/sched.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f0edee94834a..e2e91960d79f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1856,7 +1856,10 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
  * running or not.
  */
 #ifndef vcpu_is_preempted
-# define vcpu_is_preempted(cpu)	false
+static inline bool vcpu_is_preempted(int cpu)
+{
+	return false;
+}
 #endif
 
 extern long sched_setaffinity(pid_t pid, const struct cpumask *new_mask);
-- 
1.8.3.1

