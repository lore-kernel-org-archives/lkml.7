Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3754BC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B3B21852
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="oSAgnCbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389340AbfIPPlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:41:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33985 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbfIPPlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:41:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id q203so452877qke.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2u752yS3oLnDaYH6yTgBbPOp6ynQQ7UEDYNUBRkEYzU=;
        b=oSAgnCbhD4qDdHEm2xKg8gd+frd0gplSiPL7p871e/IbQ3Xl+AoJriMi48+WtFfMiH
         Er7h6Ina/mwJDFGre4pqWP4axz9nWEaIsC0Mhg4jWWlTxJLjxt2PTXBMZIrdR7ueylMQ
         JjnBypKA663HUGsAUZdZa+CJSiDEk7HeQOtW8iN1K2wpYE6VphkL0B7aNMOaXbqeI4fq
         g7hWJaYnXgwqAaotMNT3gfqh6eze7k6/zlkaN/LbASqJE+8AKlLGIYlLCCa69g0youHX
         5nbYx0F2ArTT0i4inpzgu4YzObm7Q/JOwgvXXPrTcIMrcswjP8l3AOMi6LPSITs/lgVR
         ZhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2u752yS3oLnDaYH6yTgBbPOp6ynQQ7UEDYNUBRkEYzU=;
        b=Y8zIUrKw4mhAoSrdvRSd4LtzYLlDf+k804ZmPeT76rpAlDeig5lNXW2FJiNhZf8snu
         xHQzBiD0ajzeWIFLxxrWQanAdtc7uGzkuAVuZ1EKuNP0uX+z6zGrMmXEnIKfsyCakIe+
         obkxBVsun8yYVmXrhhH904/aoyylt9ScPvFSw9SzN661tSC1ICuCZ+4jbvvI6v9Wt5Qt
         riMZt7m4IIOWZjdgetbwS7KrT66m28SArTTM8UWsymfvkn7JobEwihKTsJO1+zTNjT4k
         GVjWC2MEed4jhmuLK+dOBD9K9E5b8iiqtNjHVFsSG0n/IEIgjKXLhJWMFNRSzPpRiWVd
         PJjQ==
X-Gm-Message-State: APjAAAWBheP0xGCLnk0/7bAsT52I9FvNHaGOqj5+glb7sFPx/3ULv63l
        KfZcKRrFg5Yc+AW6gkEqtePakg==
X-Google-Smtp-Source: APXvYqxNJDHhdXo/lPdcN5eN3wfR3/ruQiO+FQksjwQu3q6+KQ4rkXWYO3AyeTVSdow3GMBnLY3bCg==
X-Received: by 2002:a37:aa02:: with SMTP id t2mr643049qke.154.1568648461865;
        Mon, 16 Sep 2019 08:41:01 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o28sm3162570qkk.106.2019.09.16.08.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 08:41:01 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/memcontrol: fix a -Wunused-function warning
Date:   Mon, 16 Sep 2019 11:40:53 -0400
Message-Id: <1568648453-5482-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mem_cgroup_id_get() was introduced in the commit 73f576c04b94
("mm:memcontrol: fix cgroup creation failure after many small jobs").

Later, it no longer has any user since the commits,

1f47b61fb407 ("mm: memcontrol: fix swap counter leak on swapout from offline cgroup")
58fa2a5512d9 ("mm: memcontrol: add sanity checks for memcg->id.ref on get/put")

so safe to remove it.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/memcontrol.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9ec5e12486a7..9a375b376157 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4675,11 +4675,6 @@ static void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
 	}
 }
 
-static inline void mem_cgroup_id_get(struct mem_cgroup *memcg)
-{
-	mem_cgroup_id_get_many(memcg, 1);
-}
-
 static inline void mem_cgroup_id_put(struct mem_cgroup *memcg)
 {
 	mem_cgroup_id_put_many(memcg, 1);
-- 
1.8.3.1

