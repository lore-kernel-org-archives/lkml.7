Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165D2C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BC72084B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSiZ9ryU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfDIUmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:42:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44356 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfDIUmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:42:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id i2so54613pgj.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 13:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sYulyXaI7Uj8GSoqvA2uW1vc0SDvMHpF+QEc51ENGHE=;
        b=NSiZ9ryUDdrElEcYnzw7WbykzUIgayk2nGgnyCGlrZjDkut3b6U877F/JwWGpUUNtH
         hxxJkXaMQpbc26hCvpSQ8lFe8AJ3lI6+L8nj6H9MCT1NzAYeBD7W8FUL6GP53ymqtZP3
         TiZ1BAojyvAB7gxQWmRlpcj9nLInWUyo0QCnKcAx2vgzbQ6It6sWO1/TAX79QXcjLQd2
         mEBPNyGKAzVlvYE/F0Y05Cv2ZfFGpgSWTVK0IkMGWNXJUq6C/KgLnczJznDSwMsTAZNU
         clygQmv05zy4YG27JsJk/HSD447mLusQ9iZUT5maMoioP3WIvpjfTprEKWsfAuYdJkoM
         3Icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sYulyXaI7Uj8GSoqvA2uW1vc0SDvMHpF+QEc51ENGHE=;
        b=AfKypgq0dwHbTWTT7ZK3ir5DyWiUtpyiwBduTzGS8s0t3xugtukrUjhLzo8Une6Lln
         nB4QswTPqqekyDUbeTgys6hEqcuzfwHBWGutDRQtvR5FgNTfPEDoWI1pbw1OVKFu7ltO
         guKn1jrtpARKkO9YBvRq8Tyvm6k/IZJit60SyUybUvigcJMA0YJsvTHwASkgdrdCp6QA
         DrhntQBaMwFtYqyIU9Y65oTLu+fFeqFQAzxGwYEbbSaHPtLubQ8ldQ3yYBOf0/jzaXZk
         1wtK/BvIH5Xh8f472js4HzTAWCVs1dQHzDkL+8Cwxl1TEZzZkOb31eIKGLSl+qWrss7I
         ormg==
X-Gm-Message-State: APjAAAXm3k7Hmovk8vNYjXUPBAnENAhvfWxtozmcTGsr+aaRoKyB/eoK
        dpdUpAMu8mTb8zCtxGkNq1k=
X-Google-Smtp-Source: APXvYqzT7aKUXo1Q/ik5LV53iMiaZGo1vWMAsc+RvCO01XSSOr+8IaRHwlQgEoe7u1fz/ng8l2PDOg==
X-Received: by 2002:a62:524e:: with SMTP id g75mr38215472pfb.106.1554842533403;
        Tue, 09 Apr 2019 13:42:13 -0700 (PDT)
Received: from localhost ([2601:648:8303:5c60:c8e:2174:1596:cf63])
        by smtp.gmail.com with ESMTPSA id q10sm41301926pgh.93.2019.04.09.13.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 13:42:12 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        "David S. Miller" <davem@davemloft.net>, Tejun Heo <tj@kernel.org>,
        Willem de Bruijn <willemb@google.com>
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpumask: fix double string traverse in cpumask_parse
Date:   Tue,  9 Apr 2019 13:42:08 -0700
Message-Id: <20190409204208.12190-1-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov <ynorov@marvell.com>

cpumask_parse() finds first occurrence of either \n or \0 by calling
strchr() and strlen(). We can do it better with a single call of
strchrnul().

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 include/linux/cpumask.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 147bdec42215..2b87f35c586c 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -633,8 +633,7 @@ static inline int cpumask_parselist_user(const char __user *buf, int len,
  */
 static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
 {
-	char *nl = strchr(buf, '\n');
-	unsigned int len = nl ? (unsigned int)(nl - buf) : strlen(buf);
+	unsigned int len = (unsigned int)(strchrnul(buf, '\n') - buf);
 
 	return bitmap_parse(buf, len, cpumask_bits(dstp), nr_cpumask_bits);
 }
-- 
2.17.1

