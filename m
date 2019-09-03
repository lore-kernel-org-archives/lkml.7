Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C57C41514
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E6923774
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3t1McXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfICQGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:06:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35777 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfICQGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:06:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so8613853pfw.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tqiMeM8TceesmPz2bTRikxBBQDBEs3u6ayncNAD+gSk=;
        b=e3t1McXM+B7+qPx+6xlw63jz2BIyLqfLkwAuPUpZ/KBlMqhABGIuIsh/P2+qg4fL3G
         e68oPxPeHi8vjpPuXdOVgYVl7iyc9re3mqNsfOKETT5TLTMCJariudPc5aEYUvdJIMIr
         8GsII5RUZLQEHyo9d62A4LFpgd69nti5zrZ7Fp+W993mrs8mrA6NQAypayAo89Qeh692
         oYxKPcTw6O0k6WJPPZjWHpbXrBkjaz6giJxa+GF34nICobYKGyS0s0tAEw8F6vxQbAFt
         t6J97R9xlt3Cwo1btDvuXlruov3D0WO6G2ERLjOiOc9McIhcixZ4rT8uvKQxri0cBUNW
         EbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tqiMeM8TceesmPz2bTRikxBBQDBEs3u6ayncNAD+gSk=;
        b=T4RjVVqz+Z27kqbOegeiVS7asxunzVlxZMJQjQ/0YR7MF1btP5tD5k2mpgkQnJyUMJ
         EwILUEHv9WGaoxdka8oS2xBsMLXx/OvT9z5CciPqN3qB8AnoXpnFi8GQrMF52gFax3Go
         kt9FAzSMuFA5bEokb4eV+/NQwSOK35WXlzCQc0ClUzg5U81ctWYyVOpsxxEUJid0tGHu
         0O9s4SuMSOUPq34Ob6gJdfPi6SAJ3mWOxm7KinWTxhA6WEizSMdx0DpNp4Lci+VcvCa+
         fWlNR0ADRPzKxtlf1uB05Eaxs5EG9J0xIX1mTdxvjqQy6vReQQoi03f2klYvSbYKU0Pk
         vUkQ==
X-Gm-Message-State: APjAAAUFla/id66/FCcX5gA/EY0VDL9okQl0w19a1vxTXZT/wI4mWTur
        tvIpRSSTmP3rIjHhn0aGynI=
X-Google-Smtp-Source: APXvYqylZr4jbswujqwYAo39xphsMw3eAgJhDESJUjXAsNJEvXeRyMT0McdB5r6QPlWEFyI3l5Gd5g==
X-Received: by 2002:a63:2903:: with SMTP id p3mr16265577pgp.306.1567526799745;
        Tue, 03 Sep 2019 09:06:39 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id t11sm18501567pgb.33.2019.09.03.09.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 09:06:39 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 5/5] mm, slab_common: Make initializing KMALLOC_DMA start from 1
Date:   Wed,  4 Sep 2019 00:04:30 +0800
Message-Id: <20190903160430.1368-6-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903160430.1368-1-lpf.vector@gmail.com>
References: <20190903160430.1368-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc_caches[KMALLOC_NORMAL][0] will never be initialized,
so the loop should start at 1 instead of 0

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 mm/slab_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index af45b5278fdc..c81fc7dc2946 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1236,7 +1236,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 	slab_state = UP;
 
 #ifdef CONFIG_ZONE_DMA
-	for (i = 0; i <= KMALLOC_SHIFT_HIGH; i++) {
+	for (i = 1; i <= KMALLOC_SHIFT_HIGH; i++) {
 		struct kmem_cache *s = kmalloc_caches[KMALLOC_NORMAL][i];
 
 		if (s) {
-- 
2.21.0

