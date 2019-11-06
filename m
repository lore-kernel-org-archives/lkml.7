Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4947FC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078DE217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NbEcbyZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfKFFaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 00:30:08 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:45657 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfKFFaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 00:30:07 -0500
Received: by mail-qv1-f65.google.com with SMTP id g12so939291qvy.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 21:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aDDk07eKG9qEhLhrH+Zk15TBEiXJzk1xwv/XlIHf5XM=;
        b=NbEcbyZKAqBEi+a+8d9bkLXrYAJLYaPLD0f+r0EtlUbZI2FeFMgowh36hKRbjtc9t0
         5jeaePfvePCdgI8aU4XftyMrv6hFjgj5wvEa096MfJB1kQzB3kBCM/kTXw0/2b9untvd
         +AsuCEHEFpKyJs2Rq5zqBPs4KmTm4hzW7Z4wghoXRPO8bAzjefaR/50xzd12Fyrx2Id/
         tkEINnPKnxtml4Danynnn8LkPsK/GbD6yJ64BU+vM4ThImtYtF3pBxBbko0Q4uAd3Por
         q1cM94zNGc6JpS5vpSpEH9tBbXU0lTJ94vKR9OBEclLRxJ/wH1c7Hjf7B6q7UWY5uRw4
         8cFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aDDk07eKG9qEhLhrH+Zk15TBEiXJzk1xwv/XlIHf5XM=;
        b=U2FgxhHjGwFRxcNA5Jhe/eKJXZ1qKPHeISHWBW6QdziMyheMUNvgG5Z1Sd/tqtcDqR
         1Bu0bUq1fj6I/EdnU+Vr+GKdlTjlkqgfK9xjh/lt3AaAUW29UdHO0mJ7NQ0eepZMGq5w
         N4vbIgW65WkRk6yzWriKHPBEDjVpZNRytuLJ/b6UwHGXnjOHXKEyb6CgT0gZw7X53XPE
         wkK5EgTGGTq/4GgBhqKT6bKwNiXs2rcRoj3c27PPhYJpFPoYWtaR7EcB8b3ej3mXEvxR
         v2akuPw+Zdz+gb+ny4Z6a+GqRzCMFgFdomys5mfi7e9cz1/nlz8E8aKXRLTJE2jLioJJ
         /kYw==
X-Gm-Message-State: APjAAAVgqAh+Y+lHpjPbuiUlzxlPYJoEMsV5NxUpk+Gv+o8vG0u2ahwz
        xOGHXXOtR39FBegrHe1hTrobsA==
X-Google-Smtp-Source: APXvYqw1TTnYH8qWCLEj/NWTwXRqc7I2dZ0XoiNZgRsm5w7NGcJsha2s0EQoOUy4+VxMDiivAmwW+A==
X-Received: by 2002:ad4:4e2c:: with SMTP id dm12mr673283qvb.195.1573018206535;
        Tue, 05 Nov 2019 21:30:06 -0800 (PST)
Received: from ovpn-124-162.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n20sm12483453qkn.118.2019.11.05.21.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 21:30:05 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     andi@firstfloor.org, acme@kernel.org, mark.rutland@arm.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] perf/core: fix unlock balance in perf_init_event
Date:   Wed,  6 Nov 2019 00:29:35 -0500
Message-Id: <20191106052935.8352-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -next commit "perf/core: Optimize perf_init_event()" [1] introduced
an unlock imbalance in perf_init_event() where it calls "goto again" and
then only repeat rcu_read_unlock().

  WARNING: bad unlock balance detected!
  perf_event_open/6185 is trying to release lock (rcu_read_lock) at:
  [<ffffffffb5eb4039>] perf_event_alloc+0xbb9/0x17f0
  but there are no more locks to release!
  other info that might help us debug this:
  2 locks held by perf_event_open/6185:
  #0: ffff888526780b50 (&sig->cred_guard_mutex){+.+.}, at: __do_sys_perf_event_open+0x6ee/0x1460
  #1: ffffffffb866b4e8 (&pmus_srcu){....}, at: perf_event_alloc+0xab8/0x17f0
  Call Trace:
   dump_stack+0xa0/0xea
   print_unlock_imbalance_bug.cold.40+0xb1/0xb6
   lock_release+0x349/0x4b0
   perf_event_alloc+0xbcf/0x17f0
   __do_sys_perf_event_open+0x1e2/0x1460
   __x64_sys_perf_event_open+0x62/0x70
   do_syscall_64+0xcc/0xaec
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

[1] https://lore.kernel.org/lkml/20191022092307.425783389@infradead.org/

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cfd89b4a02d8..8226d6ecdb86 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10307,7 +10307,6 @@ static struct pmu *perf_init_event(struct perf_event *event)
 			goto unlock;
 	}
 
-	rcu_read_lock();
 	/*
 	 * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
 	 * are often aliases for PERF_TYPE_RAW.
@@ -10317,6 +10316,7 @@ static struct pmu *perf_init_event(struct perf_event *event)
 		type = PERF_TYPE_RAW;
 
 again:
+	rcu_read_lock();
 	pmu = idr_find(&pmu_idr, type);
 	rcu_read_unlock();
 	if (pmu) {
-- 
2.21.0 (Apple Git-122)

