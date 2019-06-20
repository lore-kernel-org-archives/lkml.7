Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E000C48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD4B206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="esuVGuPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfFTTBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 15:01:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39972 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfFTTBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 15:01:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so4284839qtn.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 12:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fxS7BF5YnKVYas/qowRkmGk4FPNWJ865a8LlJ7jJcM4=;
        b=esuVGuPHL56ybvaqOi4wr1sfCwyi7F90uFQQg9tDD7rakbJPt06CIihYvU6E/v7e+I
         uENQ4kzNchpmVv/XoVJiEEgg378BnrefimklEXz6CAeEB311DR3h8OgJjMntqg4AoGmi
         tCa7K0JPelfWIG5PvLB+98Sg0cEYB5XPVyjpvIiLjStcU4LZ7t3vbLUYjlTCNkRXFHIT
         ecPYI7BNUFg0LIRkX/JlHlb6+HXYysZkx8gm54zyBF88Bz2MDiqMSyQCsK0hOVv4L958
         nP76/otkB76YZk9ir5BcKU7vVwQXXZWENpXaQeFy0FRIwaiisCKVarXEjd78H0mYBEqL
         X0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fxS7BF5YnKVYas/qowRkmGk4FPNWJ865a8LlJ7jJcM4=;
        b=Nv6TqZm7D3btL2x688XDva7COn4KWM2+2Qv1hV6IRDzm5jUiZF9zU4Ov7m74wyoK2h
         kxp+BhgEky3E3drZwH5p3aFDyW4UXunReAj4pjAFGJ7fDw4n72wbbkSLzLVmK/QVJ58j
         ysX8BndJmS8cPiVr2Ql7XEZZGHrdUs4pwBcVju9K3T3p6XcWp1dsUePF8MFC003ETkda
         /vbZjGpDUZTvKK0DS0Bzdw0RrlbW1AjfOaGMLylm02PrqHaTorH0+bpx/DNUBxayumtg
         a7Uwq/OcRmM4dPp+KZwY2d+tAI/x2bGh8diDeXZt4ta8OouU/9BsltUzWYCEfOj1T2rB
         RxVg==
X-Gm-Message-State: APjAAAVlJ1M0bs3uem18cwhhRE/vunr1ajaZ2tnsHgmorSjQS5g+BdWc
        9zcga8+l2TL6dk7XvQ0IOItK1g==
X-Google-Smtp-Source: APXvYqysIE3Ly6ZIllbwREVHhww7QCrn4Q3w2CO3KTEKsTltsmi4QX8G1yOr8xqJrrtRaWd1Y93z4Q==
X-Received: by 2002:a0c:add8:: with SMTP id x24mr41689584qvc.167.1561057267285;
        Thu, 20 Jun 2019 12:01:07 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k58sm279904qtc.38.2019.06.20.12.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 12:01:06 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     glider@google.com, keescook@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/page_poison: fix a false memory corruption
Date:   Thu, 20 Jun 2019 15:00:49 -0400
Message-Id: <1561057249-7493-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit "mm: security: introduce init_on_alloc=1 and
init_on_free=1 boot options" [1] introduced a false positive when
init_on_free=1 and page_poison=on, due to the page_poison expects the
pattern 0xaa when allocating pages which were overwritten by
init_on_free=1 with 0.

It is not possible to switch the order between kernel_init_free_pages()
and kernel_poison_pages() in free_pages_prepare(), because at least on
powerpc the formal will call clear_page() and the subsequence access by
kernel_poison_pages() will trigger the kernel access of bad area errors.

Fix it by treating init_on_free=1 the same as
CONFIG_PAGE_POISONING_ZERO=y.

[1] https://patchwork.kernel.org/patch/10999465/

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/page_poison.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/page_poison.c b/mm/page_poison.c
index 21d4f97cb49b..272403b992d3 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -68,22 +68,26 @@ static void check_poison_mem(unsigned char *mem, size_t bytes)
 	static DEFINE_RATELIMIT_STATE(ratelimit, 5 * HZ, 10);
 	unsigned char *start;
 	unsigned char *end;
+	int pattern = PAGE_POISON;
 
 	if (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY))
 		return;
 
-	start = memchr_inv(mem, PAGE_POISON, bytes);
+	if (static_branch_unlikely(&init_on_free))
+		pattern = 0;
+
+	start = memchr_inv(mem, pattern, bytes);
 	if (!start)
 		return;
 
 	for (end = mem + bytes - 1; end > start; end--) {
-		if (*end != PAGE_POISON)
+		if (*end != pattern)
 			break;
 	}
 
 	if (!__ratelimit(&ratelimit))
 		return;
-	else if (start == end && single_bit_flip(*start, PAGE_POISON))
+	else if (start == end && single_bit_flip(*start, pattern))
 		pr_err("pagealloc: single bit error\n");
 	else
 		pr_err("pagealloc: memory corruption\n");
-- 
1.8.3.1

