Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793B1C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6782171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SqzGa+39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfETVpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:45:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33381 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfETVp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:45:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17so7421536pgv.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 14:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YUHf7q9iXWCEikBJqRLDYPHkxe+K1g9F0jzW6WB16Gw=;
        b=SqzGa+39RXJrEiK/aoV7RYVpMOaf6+ADD2GKSHjU5EM9Ck0hSAnWM8ba4z4W+qf3yW
         h5WCMgI9wyUBhVx7XvvC2hBF+aqmsrvvAM9tp/XVqYg9PfsayruOhj7Ef2Ar9EfT8Y9/
         GDU5QBHSyO9SMMRWu0IcsnnuCMUPLv0WRWae8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YUHf7q9iXWCEikBJqRLDYPHkxe+K1g9F0jzW6WB16Gw=;
        b=mChHvh1R7TA+80BRkezQ7tuDhPId3peo9tNUyb1ih3W6F+D58fHhZMTy1uiWiTI6ne
         c4djOBZK7CBQIsRdLAaWeV5Qo+rvNlOm+N4uzFTnFXSN+fIXXKVFG38pjmR4ZeXe+xbx
         pvGn6q2/Mr5KosWxe43uIkMFjQQVOGNsrWtLSWYSM+BUR5CRmk56J4Ai0knFdf+G6SMR
         11LwoUgY+kShC7+Oe60XjQ3gFo8/lb2GYwomJXjuIegQMAE/THWPWLtPrw7hG46GvlHA
         H+Iv1AyTvM49VB+jTHgj2O+QoQaoButWxI+MFbekQ4MrOvu6ZEBNhxCnS710nRBwzKYP
         PIdQ==
X-Gm-Message-State: APjAAAV9StLIZREq7C7d6n1D2YDl47AixmxcyNCVizkbrJkgA3SxulXG
        t9ktutKwlBQd2zwppw18DFD1aA==
X-Google-Smtp-Source: APXvYqyAn4JGhQApOJaJtFSbuuE0hhasC10/gDCL+x2kZA0QSCoJ0zh1W4xStnAS0gUMwwQVOJ7gkA==
X-Received: by 2002:a63:2248:: with SMTP id t8mr34282895pgm.358.1558388728012;
        Mon, 20 May 2019 14:45:28 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id d186sm27681331pfd.183.2019.05.20.14.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 14:45:27 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Michal Hocko <mhocko@suse.com>, Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/failslab: By default, do not fail allocations with direct reclaim only
Date:   Tue, 21 May 2019 05:45:14 +0800
Message-Id: <20190520214514.81360-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When failslab was originally written, the intention of the
"ignore-gfp-wait" flag default value ("N") was to fail
GFP_ATOMIC allocations. Those were defined as (__GFP_HIGH),
and the code would test for __GFP_WAIT (0x10u).

However, since then, __GFP_WAIT was replaced by __GFP_RECLAIM
(___GFP_DIRECT_RECLAIM|___GFP_KSWAPD_RECLAIM), and GFP_ATOMIC is
now defined as (__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM).

This means that when the flag is false, almost no allocation
ever fails (as even GFP_ATOMIC allocations contain
___GFP_KSWAPD_RECLAIM).

Restore the original intent of the code, by ignoring calls
that directly reclaim only (__GFP_DIRECT_RECLAIM), and thus,
failing GFP_ATOMIC calls again by default.

Fixes: 71baba4b92dc1fa1 ("mm, page_alloc: rename __GFP_WAIT to __GFP_RECLAIM")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 mm/failslab.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/failslab.c b/mm/failslab.c
index ec5aad211c5be97..f92fed91ac2360a 100644
--- a/mm/failslab.c
+++ b/mm/failslab.c
@@ -23,7 +23,8 @@ bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 	if (gfpflags & __GFP_NOFAIL)
 		return false;
 
-	if (failslab.ignore_gfp_reclaim && (gfpflags & __GFP_RECLAIM))
+	if (failslab.ignore_gfp_reclaim &&
+			(gfpflags & __GFP_DIRECT_RECLAIM))
 		return false;
 
 	if (failslab.cache_filter && !(s->flags & SLAB_FAILSLAB))
-- 
2.21.0.1020.gf2820cf01a-goog

