Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3531ECA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C65208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="IDDK+UpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfJaWQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 18:16:05 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33926 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfJaWQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 18:16:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id e14so10689539qto.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 15:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rvzKkNDnFw8WgEsEEsv1HzkDI4bs5dlMd1q1SJlSRv8=;
        b=IDDK+UpMUsRWxn79to0tss/Udaa2EnOB3HfpzeuN+sK1qCRI5FyV/QzNzsS7OOr9+w
         uexitjcUSu0EToVQtruGvGYqrTR3Zb8B6WiuY/oo5A4TeAEwktQqtNARmn+yIH0G91km
         oY7J0NjnqjXoh0wGiX0SOOS0uzfMuCztFNMqXuPNw1JhqDcS/b2ufzSuUMZP4GZIf6ot
         QwGxWRb5o9XIekockwk6hdk/UxsQw18QyS37rDT3xWJSGLm5WH8hCVqEkqpW5L24+P5i
         wDzYtit4hSwUHd07pXrCCjkerLSZbVegytzILb2WJM48locQzG/1EwyYMDqL9T/E7o8W
         c1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rvzKkNDnFw8WgEsEEsv1HzkDI4bs5dlMd1q1SJlSRv8=;
        b=JXpKKZSSNdH2XtQgzH0Y7JQUEMy4Tk3A6l2wakmFllG1HuQnfD5JSRmK6OaUWHETrF
         rih/3r16AOLhm0HzEYx1Xt9P1NJSbwcDehvo39E0FlT3rVANzuU5lOYxgHSCZljxQy2N
         Vuq9pOfLe9GYvaMweVgW/LCeFeGaf/8QSNYgxM50NrxeVM4Tjmx8Jj1nh1b2hb1BN+01
         ye0rLqinJjLvtPel2vNNgCZEaFuBwRuuOG29KWCkSgdTBaVct5Mpe/HNeHGfz2nHeDzn
         fZLOrvTNpniM2RrDzDAp73/+dKHp/+ZUdkXCCZhkiZ+wNpY7WcNczXLDYyzcAVqBTh+V
         CgQg==
X-Gm-Message-State: APjAAAUPjItHR6hGwfZWr+0is0NwvtDzPlKkGY/zZf28IIwWE8vgKosh
        6EE/X0h3ep6oYUUrG02aGngs8zoI2Sc=
X-Google-Smtp-Source: APXvYqyUuLqB0cI+w53Vd93MAjEXiqViJpN4Vahcb11eeMP6ArsUp/aFprEaAG5BZjXBK3yNn7GvDQ==
X-Received: by 2002:ac8:866:: with SMTP id x35mr7645846qth.90.1572560164030;
        Thu, 31 Oct 2019 15:16:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::c357])
        by smtp.gmail.com with ESMTPSA id x12sm2151101qkh.96.2019.10.31.15.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:16:03 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] kernel: sysctl: make drop_caches write-only
Date:   Thu, 31 Oct 2019 18:16:02 -0400
Message-Id: <20191031221602.9375-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the drop_caches proc file and sysctl read back the last
value written, suggesting this is somehow a stateful setting instead
of a one-time command. Make it write-only, like e.g. compact_memory.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 31ece1120aa4..50373984a5e2 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1474,7 +1474,7 @@ static struct ctl_table vm_table[] = {
 		.procname	= "drop_caches",
 		.data		= &sysctl_drop_caches,
 		.maxlen		= sizeof(int),
-		.mode		= 0644,
+		.mode		= 0200,
 		.proc_handler	= drop_caches_sysctl_handler,
 		.extra1		= SYSCTL_ONE,
 		.extra2		= &four,
-- 
2.23.0

