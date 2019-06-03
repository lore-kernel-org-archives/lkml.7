Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C60C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73680279DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qRpvohLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfFCNAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:00:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36199 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfFCNAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:00:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id u12so9198566qth.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 06:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3GBqMlRpDEXUxoNuOv2KJmSc/xPoPHNnhUlLhJex3iE=;
        b=qRpvohLTlPZJtR683hLmpaceRRjgivOD7Qdxswo9AK3rCsZyhInoMNvg0MsixJln+e
         TlyWuqKIprzhJSBpu7VW7Ai3O0w6md4UFUK9O6p8PFuioGZzP8fe2slXed7viXXwBUq8
         Y8XhSxIXXLpkHTzyNdThVvS7JBLoQF2t7eQhkHaSBZzo1V+1QyNh41EB2/2S7QWNhlAu
         gEpVgNyHuF1hbJabqjrZVSqcB7LnvFpcE3v59DwSKN45RAMxZM45AK1yxE4Ny5eal8aE
         30BD1xGivWvImdcaZ0oq29YyZFCdpj0JvRaTPYCwCeUlXAcalg1fOpkEpPprYyFXYvaL
         z1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3GBqMlRpDEXUxoNuOv2KJmSc/xPoPHNnhUlLhJex3iE=;
        b=A3+BHMkk7/sSGxhO8u+94/GMfhJTQp9CLkgLNVrfr49u7cU2koKxF6EHJftRAIFtkC
         HGm4B2NJS7pUFh67GnMpwFjiqpQwBB5iuLF7rG2owYIS9K2aLV91TqtYNk4MAkf8vki4
         y+kdseDilEqNx9DzFnHiQbH/ImA4YkzL9hP1iTwYXk8Br9j7FDyush1vKTQFX21HGObl
         Tn7bidplW7wVuQVwF17nzXQ7cb1u79vGFoKR5D+XDAYiExOJZ2cjGskvUusO6WvUuupP
         Uu5C5kTL7viuNuSXxRHeI4rpcN7G9sGokvFksB4eyXPYrnugrs1uv0I6otTWbImcyXip
         dN0w==
X-Gm-Message-State: APjAAAWwCzm3WiIZT0g1GOgYZUExuxJmJDxCWjElcBJYEP49CKuR9Z4f
        IAUH1IW+P9cefKmZYUiBl9K43g==
X-Google-Smtp-Source: APXvYqxMGyxbNzIAbxCU1eT0jwI7g02vzWvwWUKWs4q4Fiy4qO9njcKSHrfVKSyAcz6xwSSAxcZVTw==
X-Received: by 2002:a0c:a066:: with SMTP id b93mr21181034qva.140.1559566800256;
        Mon, 03 Jun 2019 06:00:00 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i4sm9417138qti.62.2019.06.03.05.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 05:59:59 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     jroedel@suse.de
Cc:     akpm@linux-foundation.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] iommu: replace single-char identifiers in macros
Date:   Mon,  3 Jun 2019 08:59:43 -0400
Message-Id: <1559566783-13627-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few macros in IOMMU have single-char identifiers make the
code hard to read and debug. Replace them with meaningful names.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/linux/dmar.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index f8af1d770520..eb634912f475 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -104,12 +104,14 @@ static inline bool dmar_rcu_check(void)
 
 #define	dmar_rcu_dereference(p)	rcu_dereference_check((p), dmar_rcu_check())
 
-#define	for_each_dev_scope(a, c, p, d)	\
-	for ((p) = 0; ((d) = (p) < (c) ? dmar_rcu_dereference((a)[(p)].dev) : \
-			NULL, (p) < (c)); (p)++)
-
-#define	for_each_active_dev_scope(a, c, p, d)	\
-	for_each_dev_scope((a), (c), (p), (d))	if (!(d)) { continue; } else
+#define for_each_dev_scope(devs, cnt, i, tmp)				\
+	for ((i) = 0; ((tmp) = (i) < (cnt) ?				\
+	    dmar_rcu_dereference((devs)[(i)].dev) : NULL, (i) < (cnt)); \
+	    (i)++)
+
+#define for_each_active_dev_scope(devs, cnt, i, tmp)			\
+	for_each_dev_scope((devs), (cnt), (i), (tmp))			\
+		if (!(tmp)) { continue; } else
 
 extern int dmar_table_init(void);
 extern int dmar_dev_scope_init(void);
-- 
1.8.3.1

