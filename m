Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9D2C4646B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A5121670
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Aohv65Mb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfFTUq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:46:28 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39796 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFTUq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:46:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id i125so2891560qkd.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 13:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=v3gUffz2IC2GMolPqjySsy2Kwzf7mwg82ps+ceby41o=;
        b=Aohv65MbEoHXAZa6OvGoj/bIyvVXaDCncWUVf0OOF+5Ah1AG5Flc04T3N+WFtbxgUB
         LKymfgom2KGLdWKqSRSkd+OVtL9sBC9zx/4EnPMgDTQVRckRTtCZcUMJPlqKNm4UVm9v
         RRxMLde2cYzkcSwppx+gGUOA1uPikt2fuKaR917PB0RkXnQabO3Ce7Kcxi5KVmRc0zEf
         eizRWfW2UldeQmdjJnCAwQFk0KAbT9KqpyC0wcappD3UgdziroR31Al4iwPYHXyRFiVa
         2s/I7DrLsMGj/JBADXzu9V7XjYYdWnBDpq0/Y0AW1FnicdQ5hWPrY0eZ9I9Ao0MM+7BX
         2Y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v3gUffz2IC2GMolPqjySsy2Kwzf7mwg82ps+ceby41o=;
        b=Dien/ojdPAnoFyBW8v7GIUgCTDNxb1vLg5AM7loSLjzMCt9SR648TadCj5HDiYPxEg
         y9HapYh3Jrj+2QGySra8bNUfOvU/LGVVig9c9F+AsXljbLOQwnaEceR3s86EGXY2dJgW
         wcHdYqNImkITctlCs782pwaTFMjXh1aNHIlZWORm1PxSGxZpeyQwBSHaHPVpazOogUdt
         sqvWA+MGS4nxNUEPgF+ErRXknQ9+rgc6mfrxWnxCSfppZUpGQXM1IgJ4mrNC9rWXTu7g
         Bf2XURaP5mlqFeHBKSr9Vzz/aXh7MbCqvHbyKtxPYKQ/XsUbaewbDliryISYMRzQVxtM
         4Tfg==
X-Gm-Message-State: APjAAAXHiKr/ztTyIAxRESyEfuE6sdbACn7Inbbvnn1wPM2G7MELFL7V
        d6EZV/Xbbs1gnqMK7EjhEg5B3g==
X-Google-Smtp-Source: APXvYqzyfrjqPqTMiYyIVosdegH1JYfwr2xtFpaCUBsRfDf1JKSqQ4KL9I9svwAdNC30pMVcDa1RSg==
X-Received: by 2002:a37:9d1:: with SMTP id 200mr58987821qkj.306.1561063587503;
        Thu, 20 Jun 2019 13:46:27 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f3sm468647qkb.58.2019.06.20.13.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 13:46:26 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     glider@google.com, keescook@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] mm/page_alloc: fix a false memory corruption
Date:   Thu, 20 Jun 2019 16:46:06 -0400
Message-Id: <1561063566-16335-1-git-send-email-cai@lca.pw>
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

Fix it by switching the order between kernel_init_free_pages() and
kernel_poison_pages() in free_pages_prepare().

[1] https://patchwork.kernel.org/patch/10999465/

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: After further debugging, the issue after switching order is likely a
    separate issue as clear_page() should not cause issues with future
    accesses.

 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 54dacf35d200..32bbd30c5f85 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1172,9 +1172,10 @@ static __always_inline bool free_pages_prepare(struct page *page,
 					   PAGE_SIZE << order);
 	}
 	arch_free_page(page, order);
-	kernel_poison_pages(page, 1 << order, 0);
 	if (want_init_on_free())
 		kernel_init_free_pages(page, 1 << order);
+
+	kernel_poison_pages(page, 1 << order, 0);
 	if (debug_pagealloc_enabled())
 		kernel_map_pages(page, 1 << order, 0);
 
-- 
1.8.3.1

