Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAB3C4CEC5
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 00:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C06208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 00:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rt4uWEX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390769AbfINAIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 20:08:01 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:44751 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388667AbfINAIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 20:08:00 -0400
Received: by mail-qk1-f201.google.com with SMTP id x77so34831857qka.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 17:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lp1ovS/BiJIimm2KkXbVRdqzH3DGx1lv+fcqWa50ZBQ=;
        b=Rt4uWEX1WC7qsSkLnMn+ja/K/Z3LuRUh6r6DRsPyhmXDfrHb/YriCW9u2abhjk3VxE
         bxtxaY2Tp7jiu+zQxe96ddm2u+q4E64QCoBM3NhEhMdMZ55Jr7T3N+faJlXo8PveLQp8
         kgcQNWh4O+jcf95NBm8xdqd/NVgkWSn4vxVpwIEqVHINNAMIScoyEFUs+9THwDEPC9D0
         C7h35JMQcp+Xb8IXk1bDu2CcML0EFrI+65MLL8ju5FQTuReB/suY9v5BcpjwMdq+iahb
         5A5DXIbsceoB3nj8e8SXZqwdXH/d57EzYDAYurm8Ataj6pN05YrcFH624rF1ek2xNINK
         u9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lp1ovS/BiJIimm2KkXbVRdqzH3DGx1lv+fcqWa50ZBQ=;
        b=F+Hk7ek0yeH3AhOftqURgiogp0xf/upYuGVgY5arL7l5s3HbvCkoIOrqYd+z5N1UWZ
         D0thg45He2Un4PyJMeC4q7XODS4ZWVsvhAmZbDPr/LvWQYNKiZu3D+yCfVfHqUmvULcz
         QorN+3myuORdYnxLA6M6tfSKUem5e5P+dmSA5I2ikmL/xh2z4rL/XpLJBeAv8BZjKN0Z
         kKYZgVhU+7nxbrFYziBg7hXL+FvA9LLCxS4CTzX4MBO8v+Dke+DycBDmo+TDEjuWepso
         YmEHhZkFnpc0QEu03exKTivieQdQa6GEsd3W5um0aD2zyHEN4R+Q/aXjf7KxRB/GdT8z
         FDRA==
X-Gm-Message-State: APjAAAVZDe86jFPoRI91K1F0HOrXFUtm+6Ojl6gl83k6qjXrp1ISX/zy
        z4XdyG47C91N8ul0Qlv8Hd6py0FZHWQ=
X-Google-Smtp-Source: APXvYqwKncMAj8DEWm2CqFKi79/Wj4WIkkjQ3ekD9OmGLxgKFlWGWM7Vgnh3PbbPWsDEl1d9IrDcRnTxLF0=
X-Received: by 2002:a0c:f8ce:: with SMTP id h14mr22188070qvo.2.1568419677790;
 Fri, 13 Sep 2019 17:07:57 -0700 (PDT)
Date:   Fri, 13 Sep 2019 18:07:42 -0600
In-Reply-To: <20190912023111.219636-1-yuzhao@google.com>
Message-Id: <20190914000743.182739-1-yuzhao@google.com>
Mime-Version: 1.0
References: <20190912023111.219636-1-yuzhao@google.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [PATCH v3 1/2] mm: clean up validate_slab()
From:   Yu Zhao <yuzhao@google.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function doesn't need to return any value, and the check can be
done in one pass.

There is a behavior change: before the patch, we stop at the first
invalid free object; after the patch, we stop at the first invalid
object, free or in use. This shouldn't matter because the original
behavior isn't intended anyway.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/slub.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8834563cdb4b..445ef8b2aec0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4384,31 +4384,26 @@ static int count_total(struct page *page)
 #endif
 
 #ifdef CONFIG_SLUB_DEBUG
-static int validate_slab(struct kmem_cache *s, struct page *page,
+static void validate_slab(struct kmem_cache *s, struct page *page,
 						unsigned long *map)
 {
 	void *p;
 	void *addr = page_address(page);
 
-	if (!check_slab(s, page) ||
-			!on_freelist(s, page, NULL))
-		return 0;
+	if (!check_slab(s, page) || !on_freelist(s, page, NULL))
+		return;
 
 	/* Now we know that a valid freelist exists */
 	bitmap_zero(map, page->objects);
 
 	get_map(s, page, map);
 	for_each_object(p, s, addr, page->objects) {
-		if (test_bit(slab_index(p, s, addr), map))
-			if (!check_object(s, page, p, SLUB_RED_INACTIVE))
-				return 0;
-	}
+		u8 val = test_bit(slab_index(p, s, addr), map) ?
+			 SLUB_RED_INACTIVE : SLUB_RED_ACTIVE;
 
-	for_each_object(p, s, addr, page->objects)
-		if (!test_bit(slab_index(p, s, addr), map))
-			if (!check_object(s, page, p, SLUB_RED_ACTIVE))
-				return 0;
-	return 1;
+		if (!check_object(s, page, p, val))
+			break;
+	}
 }
 
 static void validate_slab_slab(struct kmem_cache *s, struct page *page,
-- 
2.23.0.237.gc6a4ce50a0-goog

