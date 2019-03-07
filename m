Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25A3C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836D920840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="npNbQ9ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfCGSxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:53:15 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33712 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCGSxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:53:14 -0500
Received: by mail-qt1-f195.google.com with SMTP id z39so18375855qtz.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=p/uycB6wwfQ9mpJ/cDj3nrD1aSO5NRmGJ7t1JhstDM8=;
        b=npNbQ9ugg6BqXhBShFoxcI+GsIl/fQL1QQiivFdQuXTzcRUGxcFBOnos1rPrqOcUGZ
         LpkY8q7OeZ3u/jLDGFI/8r0tIdwcF5zyhjcZWU+ryrwQKbz64WJoswuqcgOs4CUHTFtC
         dwnK7AXsVkVipwWteXZBUzl6ojcGHfXjpr4nYNV5oBbRYe3jcn+xMH0IaqALsvmJnuCa
         RvKS76TIqHjNR9CkiOP9V9iNNQXcV4niHNxVQq3vwmCDvpWLMtTat1aI0+ysmKUVfypQ
         qcBWRpQgKdyhCZRIQ9G2JzzIhI41U5fnxDzBOllsFQ+1lAhsX4OucCWzjXwQmHK607we
         v4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p/uycB6wwfQ9mpJ/cDj3nrD1aSO5NRmGJ7t1JhstDM8=;
        b=AlFxLECHzpNaA34rJjt7NydfTgSrbCaNACy9rsrWYTDDRpSNnHYSyPvg06fsYOEf63
         xKHi0l7YzYzS79ji7Vdsnz5r+7XDPmuk0wNW8PWU8GWBW/pdpKARIa/Ywr+WugcjsHOf
         N2IIzcTdW2M+LlOC/w5kcsxfwmuBuO5odvUcFmrSJktmlqfKSuIbPtHP2XUQYA1iUR/o
         5GMOWZ7+CSxRv+8jstaeTBayq9USLLwyFodYug4PBAr7+4DVSNnkcj6IOrumC/7nj7Ky
         WA2O+9ATqxeEJrZ5IaQweQroQQF8Lm0W1AaAKE8jrR8Q5pv1wDapK/6BSEMmFI4pLGaI
         82eg==
X-Gm-Message-State: APjAAAV6zmKMDPnQdKexHeRXKD58NRINa8vhSd9ViUpg//ZuTPYWx5vA
        hdCVZCSwYvCDhwE3cwMN+9QhkQ==
X-Google-Smtp-Source: APXvYqzGLcM4sdL4fQMyRvzu7ZEKQ3Jrxk7x05or0Uat2bPqh6vF/YVXkc6OhqMJ9BzxmD4BoExgEg==
X-Received: by 2002:ac8:22d1:: with SMTP id g17mr11423320qta.30.1551984793227;
        Thu, 07 Mar 2019 10:53:13 -0800 (PST)
Received: from ovpn-121-103.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x6sm2514892qtr.9.2019.03.07.10.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 10:53:12 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] kasan: fix variable 'tag' set but not used warning
Date:   Thu,  7 Mar 2019 13:52:44 -0500
Message-Id: <20190307185244.54648-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_tag() compiles away when CONFIG_KASAN_SW_TAGS=n, so make
arch_kasan_set_tag() a static inline function to fix warnings below.

mm/kasan/common.c: In function '__kasan_kmalloc':
mm/kasan/common.c:475:5: warning: variable 'tag' set but not used
[-Wunused-but-set-variable]
  u8 tag;
     ^~~

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/kasan/kasan.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 3e0c11f7d7a1..3ce956efa0cb 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -163,7 +163,10 @@ static inline u8 random_tag(void)
 #endif
 
 #ifndef arch_kasan_set_tag
-#define arch_kasan_set_tag(addr, tag)	((void *)(addr))
+static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
+{
+	return addr;
+}
 #endif
 #ifndef arch_kasan_reset_tag
 #define arch_kasan_reset_tag(addr)	((void *)(addr))
-- 
2.17.2 (Apple Git-113)

