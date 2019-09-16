Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D459C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD777206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="KTotiNMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390340AbfIPS06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:26:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43249 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfIPS05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:26:57 -0400
Received: by mail-qt1-f194.google.com with SMTP id c3so997789qtv.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 11:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aGLQbvl4lzQC5/TXbcMtzuY6cM2BuLvsBEnb8j57QAk=;
        b=KTotiNMcVlc2ur9IJSCApV52NW7xHvYTihJBLgnlipxQNoOT4b8tescPp0QB8sZ/7C
         xkiTVYZeKdkgYXCT2/Pc/cN7SlweWaPPKXiUnVQ6cfWR2i8+8OSP5lNR/x+sNTOEo3b7
         yjsYsbjOt8CYKHaXt76xDhPwHbFKzSlEkdIaMtqyGIDJNUp6eGLux13Xtosm8r3v0YbQ
         5TOpo1Lw79HZXW2iVWSGgcGhw4nRCQ7YMgKZa3xPHcbW55humIWRzzPf1p5m9KBOI5Q5
         PaJUGXsIfgbHda+pRnOEIVQaXPuQ2PWDDnLt9i59cEpr9ilwaSnAWieqdcGUYG5YMqbA
         kVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aGLQbvl4lzQC5/TXbcMtzuY6cM2BuLvsBEnb8j57QAk=;
        b=SarFJ/pobo4i5vpamzHFdCin2rqLsHxUBI84H1r0w8LNGuabPbp1RJ06PhrivfNK8F
         ktzjl6aGBkpzHB0VpfwiyWecq+OSCGYP3lBtS6osN2sEBS6ukebS5zjqeowu2W1rr7bb
         4rqpaDTa8rehOCOCGzruHI4Rxl0IN3Qd6GRo5pcaGdwO3BTk2D4Y7kgWqld4j8x1E32+
         zcJC4TvM2WsR276ETcTZjGhrNO7pFPiH32UXn/877weAXn95Bb/wbXRAe9pVhN13Z0DV
         zP0mHMHQqzfLxYUscoRkBLRNyhyc7niBwBtHQj3RHSpLsHBRCpntsxsN7aqQJGjg+I99
         CJDQ==
X-Gm-Message-State: APjAAAXC8EPt2AYLizktV0Kgtrx6j2c2bYNs83xvv7pPzqmDQkAEBkvs
        lyS9XcfGWGk7Bpd18rQQVzw99g==
X-Google-Smtp-Source: APXvYqz/I3HacN6FvkNZuh2Cn0GSGQRoiZWNIsCw+eVru8DTNDt8Rk9HRURFzC9KiNHUGdAZXxm3+w==
X-Received: by 2002:aed:3903:: with SMTP id l3mr1044065qte.165.1568658416581;
        Mon, 16 Sep 2019 11:26:56 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i1sm1012700qkk.88.2019.09.16.11.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 11:26:55 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     ngupta@vflare.org, sergey.senozhatsky@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/zsmalloc: fix a -Wunused-function warning
Date:   Mon, 16 Sep 2019 14:26:48 -0400
Message-Id: <1568658408-19374-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_zspage_inuse() was introduced in the commit 4f42047bbde0 ("zsmalloc:
use accessor") but all the users of it were removed later by the
commits,

bdb0af7ca8f0 ("zsmalloc: factor page chain functionality out")
3783689a1aa8 ("zsmalloc: introduce zspage structure")

so the function can be safely removed now.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/zsmalloc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index e98bb6ab4f7e..24179cfe8784 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -476,10 +476,6 @@ static inline int get_zspage_inuse(struct zspage *zspage)
 	return zspage->inuse;
 }
 
-static inline void set_zspage_inuse(struct zspage *zspage, int val)
-{
-	zspage->inuse = val;
-}
 
 static inline void mod_zspage_inuse(struct zspage *zspage, int val)
 {
-- 
1.8.3.1

