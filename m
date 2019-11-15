Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A469AC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 20:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB8D2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 20:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Fae3n/Du"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKOULt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 15:11:49 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36460 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfKOULt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 15:11:49 -0500
Received: by mail-qk1-f193.google.com with SMTP id d13so9113808qko.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 12:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rK+VrpxQV4ZTcM3wBx6WIAo16VtCG97yuNEHzYaGRMU=;
        b=Fae3n/DuTYTPRHB4hSz3cMXShYJQZSWaZ4R8pe8ItWpRUgKDRs22e+z3iKUqdTs2St
         r4G9QamAQcxlLYvzs2fII7SPvTkl+qu97rE/XURhL/zMW+FABXHZCDFF6n54HpE1ehoL
         BxBrzXgtmlRJZhtOh/RDFfuE9Q5hSFWvLgD1tyYTeOn/0+g3CPu46H0tBBMQXWOU6f64
         HagAQS8mVQrLugSBdLnqFmr8PYpwX5Iq8Rj0v2pCgy6g20clMPQhdhtxJSFLgm/0cyPL
         8au7DIzvzxqx9258O4VoWmfPV+0XPl+YUCPeP/iCiWXr0xYWfyi8XnFZRsaV2g32P2WG
         8wsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rK+VrpxQV4ZTcM3wBx6WIAo16VtCG97yuNEHzYaGRMU=;
        b=nQDjrZi+3hhPB48nhfHaa/MIlKt/dqLkI/qnA3RK9j04sZ1Vf3Cn/7KsyXr2ByLT6J
         /HOz7dcpHsWtwx5eGxU2JNfrASrWuECb9Zip/ubDCxcPzA2T9QxFCZQBwhn/oOErjwUX
         b/9sn7b56muAC22KmQDPC+KsYclmDbZjJO5hVfnVtWbwLDIKg/i41zXD0SGOSzXV7QyE
         bjLFEGl/ObqC3qUfoipXNa5cKqiKKylR/utyVDT2zB42LHQXO+kO6CU/VHeDrqM5XC9C
         XDC6ZPDpfkjayTiYricxEsil0vWSENNkUpdqkATfnTgeNmK2fxyR7hVzATaXdhD6CrMX
         8hHw==
X-Gm-Message-State: APjAAAWUvxKR2RS6q2H+pZR4mUzPBapU7/oh9eLf7vsiM4XvFZbmBQlH
        U+KqisQ0L2K0NqPEQtBtI4+Qmg==
X-Google-Smtp-Source: APXvYqy2bx2+1MOm/glZSsmaCtGCM9fsuPgPSsBrYLKN2mvBXXRw/H0R5/+8kgJE1cbHuIVx77qz1w==
X-Received: by 2002:a37:a5d3:: with SMTP id o202mr13122947qke.283.1573848707981;
        Fri, 15 Nov 2019 12:11:47 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m13sm4612267qka.109.2019.11.15.12.11.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 12:11:47 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, surenb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] mm/vmscan: fix some -Wenum-conversion warnings
Date:   Fri, 15 Nov 2019 15:11:37 -0500
Message-Id: <1573848697-29262-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -next commit "mm: vmscan: enforce inactive:active ratio at the
reclaim root" [1] introduced some Clang -Wenum-conversion warnings,

mm/vmscan.c:2216:39: warning: implicit conversion from enumeration type
'enum lru_list' to different enumeration type 'enum node_stat_item'
[-Wenum-conversion]
        inactive = lruvec_page_state(lruvec, inactive_lru);
                   ~~~~~~~~~~~~~~~~~         ^~~~~~~~~~~~
mm/vmscan.c:2217:37: warning: implicit conversion from enumeration type
'enum lru_list' to different enumeration type 'enum node_stat_item'
[-Wenum-conversion]
        active = lruvec_page_state(lruvec, active_lru);
                 ~~~~~~~~~~~~~~~~~         ^~~~~~~~~~
mm/vmscan.c:2746:42: warning: implicit conversion from enumeration type
'enum lru_list' to different enumeration type 'enum node_stat_item'
[-Wenum-conversion]
        file = lruvec_page_state(target_lruvec, LRU_INACTIVE_FILE);
               ~~~~~~~~~~~~~~~~~                ^~~~~~~~~~~~~~~~~

Since it guarantees the relative order between the LRU items, fix it by
using NR_LRU_BASE for the translation.

[1] http://lkml.kernel.org/r/20191107205334.158354-4-hannes@cmpxchg.org

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: use NR_LRU_BASE/NR_INACTIVE_FILE per Johannes.

 mm/vmscan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 122b3920aaa4..c8e88f4d9932 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2213,8 +2213,8 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
 	unsigned long inactive_ratio;
 	unsigned long gb;
 
-	inactive = lruvec_page_state(lruvec, inactive_lru);
-	active = lruvec_page_state(lruvec, active_lru);
+	inactive = lruvec_page_state(lruvec, NR_LRU_BASE + inactive_lru);
+	active = lruvec_page_state(lruvec, NR_LRU_BASE + active_lru);
 
 	gb = (inactive + active) >> (30 - PAGE_SHIFT);
 	if (gb)
@@ -2743,7 +2743,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	 * thrashing, try to reclaim those first before touching
 	 * anonymous pages.
 	 */
-	file = lruvec_page_state(target_lruvec, LRU_INACTIVE_FILE);
+	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
 	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
 		sc->cache_trim_mode = 1;
 	else
-- 
1.8.3.1

