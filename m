Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA1AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6D3218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jo1am6NX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfCTUuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:50:02 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45444 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfCTUuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:50:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id z76so15030779qkb.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vKMs+vGKtn6uWWX3EIKMHp5IS2yH54+J/gVXjWcLaZM=;
        b=jo1am6NXmh62DCNOoIRIZQFeCEpQzG9AM3T2gRtKC3HxT/sWZoL3LQhuR6Zxsf2NGW
         f8NfSPfp/AEDG8Mpv8MqvZC/wU6zQgOEXOFKOfzKNQHnTj1BPYfOZC4xiYti+1uKt9Ut
         9O7/4rDm7enXSCwk5a9zr4/2Z4/xgIoQeXOMML6YOZbGqKpnu/sKkjA9KaFoKRQrXNnk
         fEGM5uiB7kxiUla3AEJDSWTOCJT0a8T9hsu1W2+y8V/qigpZucLtNm+3Dhz0nzdJcesk
         Kpouss9sb/XjFOANjQe4G7OWug96I4zPu5Ut4NaNw0XGHlKxPluK4fDr57GbgNXRCtCS
         NOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vKMs+vGKtn6uWWX3EIKMHp5IS2yH54+J/gVXjWcLaZM=;
        b=jkI5K+EWfJhZy0pJx74kKBgozq8Lh9N8lJ+d++M6Wkzqgt+5uVk5CuuNaoWqXYfNsx
         OkTTQfSadAmus5nvZs3QM2NKR79vsce2D/BrzhubNxiau2RRwXU9M5rwAPY2BES7ts7T
         nTFdXcpsH+UNcbYdpYvZTbqa8fxLXdTadS7q3hBE5iLdUeup8FcAg06kL7KwAHGDL6ye
         WOt3TdsY67gm4Xql7swfJsr3+312RumfhWazKPDvwDZRtnXieB3IGJv2sOZWlSYTJ42R
         JS/aVbw9wO6yvU4/u0FNiMs0RoJa3/wuiI6UPVMSqglZ9V+5vraMMAU6Dwjy71NmDWdF
         P8hA==
X-Gm-Message-State: APjAAAWSRcwOQz/cimILsad5uKQf3p1yd4C2gvLnPQtx85rZd1yXYRYb
        ChIw4dgHPC8sR0418cJSD1ubOA==
X-Google-Smtp-Source: APXvYqyK8pMu34MHAiJ9lTIZlVL32AxB4ryVVjnGoBBMBKpGFq/oUuvraCi8U9UCRJOcsrOFw80xaA==
X-Received: by 2002:ae9:ec19:: with SMTP id h25mr8585387qkg.122.1553115000939;
        Wed, 20 Mar 2019 13:50:00 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g65sm1709700qkf.52.2019.03.20.13.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:50:00 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>,
        stable@vger.kernel.org
Subject: [RESEND PATCH] mm: fix a wrong flag in set_migratetype_isolate()
Date:   Wed, 20 Mar 2019 16:49:41 -0400
Message-Id: <20190320204941.53731-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to has_unmovable_pages() takes an incorrect irqsave flag instead of
the isolation flag in set_migratetype_isolate(), it causes issues with
HWPOSION and error reporting where dump_page() is not called when there
is an unmoveable page.

Fixes: d381c54760dc ("mm: only report isolation failures when offlining memory")
Cc: stable@vger.kernel.org # 5.0.x
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/page_isolation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index bf4159d771c7..019280712e1b 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -59,7 +59,8 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
 	 * We just check MOVABLE pages.
 	 */
-	if (!has_unmovable_pages(zone, page, arg.pages_found, migratetype, flags))
+	if (!has_unmovable_pages(zone, page, arg.pages_found, migratetype,
+				 isol_flags))
 		ret = 0;
 
 	/*
-- 
2.17.2 (Apple Git-113)

