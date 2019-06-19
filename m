Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E991FC43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 23:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA962085A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 23:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1it1Ete"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfFSXZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 19:25:25 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:42647 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfFSXZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 19:25:25 -0400
Received: by mail-yb1-f202.google.com with SMTP id c3so1075485ybo.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 16:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2Xe5CNu50mksX/zEQQqGlLiWQgOuxvE/hS5GIpxigKA=;
        b=g1it1EteZ/NGeK69zsjfHOTg9qZMabcBis5hFjOrlB2l+EFid2XH43a/H1Q98WQaN4
         EuaSsBaTPlqXmMYUHUth9G/bMVvlH6pFOoOKmzO5ypBeVy38P7a0Es8xFNAKHTRaabbw
         8raai+S+rVgHmvNm9WwaNFbh3CDbHzBDR0yc8D2i20C+AGY93ETkj7ecEaSTfenjJLSd
         fcu2WQVp0NMDR3iKV/rnrn6v8WivwS78j6PGG20RxN0RiXWs5GoTqxJGDi9W1+QRi9g4
         d0z67gIh/nncaGZD0tfYFyUqwU/UD9ePElOit5dKhGB4YOjiUpRTPlAbsW+SCWdDRbSB
         Q3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2Xe5CNu50mksX/zEQQqGlLiWQgOuxvE/hS5GIpxigKA=;
        b=GHIjonJGXzCeASrOjdVNl9Db7O5wUH5+1esSTd06K7Y/o4szikWYdd7WaaTiehguV4
         O+RqkA3GGs7Aq1X8Djo6mAaGpAMWKGoHutoF40wY+TuT4vcCgLbblTCfZBm4MlkMWbSy
         TJZPnt6QjkHz+dBY4NwW/JZcb5TtjWxrH+sCE418MSpjrybQVlGds4yYrElIIEd1XB8T
         4StsfGbZEKlwBJkaRp5iao8R2fuIINBApgxCj0+8nn1yyGNcNoab1SVq0z0O9TJcAsN7
         GsC1xBCTK2al35KZpQqrSzSyGyIfxFogG8F1Hznedu+5UDEY8/g9QGp3B9huiS2Oi9ze
         7hvQ==
X-Gm-Message-State: APjAAAXq6twPQyx9wMOrQjQ4odeVPTk3OHIEZH0xp2xTcJBZ9XBhyEWl
        7Adf6BoMnIy4CqYVJZScbmrq7Qlwvo3Prw==
X-Google-Smtp-Source: APXvYqx0Ajd3n7T85uM4Bzn0REZs50Wj6xVympn1t8+jBERmV3VKWhN1SE1iCxw29OAeOkbSedQJqpGRdieoww==
X-Received: by 2002:a0d:c485:: with SMTP id g127mr43382535ywd.405.1560986723899;
 Wed, 19 Jun 2019 16:25:23 -0700 (PDT)
Date:   Wed, 19 Jun 2019 16:25:14 -0700
Message-Id: <20190619232514.58994-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] slub: Don't panic for memcg kmem cache creation failure
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently for CONFIG_SLUB, if a memcg kmem cache creation is failed and
the corresponding root kmem cache has SLAB_PANIC flag, the kernel will
be crashed. This is unnecessary as the kernel can handle the creation
failures of memcg kmem caches. Additionally CONFIG_SLAB does not
implement this behavior. So, to keep the behavior consistent between
SLAB and SLUB, removing the panic for memcg kmem cache creation
failures. The root kmem cache creation failure for SLAB_PANIC correctly
panics for both SLAB and SLUB.

Reported-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/slub.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 6a5174b51cd6..84c6508e360d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3640,10 +3640,6 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 
 	free_kmem_cache_nodes(s);
 error:
-	if (flags & SLAB_PANIC)
-		panic("Cannot create slab %s size=%u realsize=%u order=%u offset=%u flags=%lx\n",
-		      s->name, s->size, s->size,
-		      oo_order(s->oo), s->offset, (unsigned long)flags);
 	return -EINVAL;
 }
 
-- 
2.22.0.410.gd8fdbe21b5-goog

