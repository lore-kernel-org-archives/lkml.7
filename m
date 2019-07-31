Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB3AC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2191D206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FkJBduK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfGaNqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:46:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46405 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfGaNqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:46:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so66528209qtn.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8f2ucm94N3RAHWXp2XYv1ymSM73yXUEwnSMo5qDl8Gc=;
        b=FkJBduK7o2U9DkS56fiFYacXOe0s7mfPx9W0zVWXLGIoBYvxPS2C2Ogl6X1ZM5uZB4
         cNBAvSNVe+z5s06SyzfhFcV2RMEo+4pQRXPG6a+ptBnkhXvLwFhmgz0gt+BJW3wJbihR
         nQ+IC+gD8EKjLqqM8uUq0xBkQAcLq2ShOD+pLbe7omO5lVwVExK79k9jyXMHHP9ALfdG
         HN5osGJO/3roRO/n8DH2DeHGHAjojwdQ4gDaHzxo6r6GRyDbZlbArnEjESad9OoMyJV3
         prsq8zmDCb3fv9cBiBkmI//oNrGrN1yzBD8iF6WSFS37+kW8o3ZD2SB4jdrbHoccKKeQ
         LE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8f2ucm94N3RAHWXp2XYv1ymSM73yXUEwnSMo5qDl8Gc=;
        b=Rd/tAgkPCnDjANS9gkIjxVtZbISdpM5ZDbSRNbzfiaQ6BtMmWhOzpXBwSvAgfTx6Ej
         xMeiqjaWOTylHRu3eNEfOExFZ+SzyckKzg156Op9O+ZexcJB76EoHMTk0LdtmTEq8I5K
         ANA7rLDsLTVmnfy8azCBvsI4TKOezziBYxi7zKc0qpWYIVRIjts1b05KUyYrLG4AVMdv
         Tljpu6i7FKdcOIe3ik+r58FwB8rxbEC/+T8a/jm8kS+8Ms4dxhn6xYV4PEDxOGqF1V/l
         Iv4cewm2Ha2FDj6xvQyt6m20UNmAANb57C0v33VargO8YlBt3cDFpuqTZgi6TiCQH4Yw
         XfGg==
X-Gm-Message-State: APjAAAVWTWXpTAAatxvV1X4pRWvhCYO+HMS2WrvNoUaL8S3JH9z1SxS6
        Q4RVl2bzerFHSHI1EIgG7xOZbg==
X-Google-Smtp-Source: APXvYqwYN2nhY1spLQvC2zasTrz/bvKwBvV9enaVBBRDKUn7AFldOujCtq9CUvaY4BxZgE1L7GHd6A==
X-Received: by 2002:ac8:2af8:: with SMTP id c53mr88215379qta.387.1564580775668;
        Wed, 31 Jul 2019 06:46:15 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a67sm31086281qkg.131.2019.07.31.06.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 06:46:15 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     miles.chen@mediatek.com, mhocko@suse.com, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/memcg: fix a -Wparentheses compilation warning
Date:   Wed, 31 Jul 2019 09:45:53 -0400
Message-Id: <1564580753-17531-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit ("mm/memcontrol.c: fix use after free in
mem_cgroup_iter()") [1] introduced a compilation warning,

mm/memcontrol.c:1160:17: warning: using the result of an assignment as a
condition without parentheses [-Wparentheses]
        } while (memcg = parent_mem_cgroup(memcg));
                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
mm/memcontrol.c:1160:17: note: place parentheses around the assignment
to silence this warning
        } while (memcg = parent_mem_cgroup(memcg));
                       ^
                 (                               )
mm/memcontrol.c:1160:17: note: use '==' to turn this assignment into an
equality comparison
        } while (memcg = parent_mem_cgroup(memcg));
                       ^
                       ==

Fix it by adding a pair of parentheses.

[1] https://lore.kernel.org/linux-mm/20190730015729.4406-1-miles.chen@mediatek.com/

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 694b6f8776dc..4f66a8305ae0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1157,7 +1157,7 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
 	do {
 		__invalidate_reclaim_iterators(memcg, dead_memcg);
 		last = memcg;
-	} while (memcg = parent_mem_cgroup(memcg));
+	} while ((memcg = parent_mem_cgroup(memcg)));
 
 	/*
 	 * When cgruop1 non-hierarchy mode is used,
-- 
1.8.3.1

