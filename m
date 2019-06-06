Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48298C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE70208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="BawoU+DL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfFFN66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:58:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35213 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfFFN65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:58:57 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so2753560qto.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 06:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uYUP0WvJ8OVS3p9Pt4OYtUrTIoCYyxeTlVr1HS9+PVI=;
        b=BawoU+DL761/Zz0pvNB6yfVLELjpaY9MrjtJ0ekcgITb2LHMm4DTA2HU38p+oKSvXR
         rSFXzn+w3C05cINtZPNzeEV1ew7Vq1ZglQak8DyZPuzo4AIMlWRpyes9S/pMbCpTNnVH
         xcxNXEPpDaDBd4QRoOowoLwwOQom/8GW7sCbWMScLXCYaSJXhHnjMqbkOFNFKWPO9fV2
         ilP3PSW4ionpHoc4SD3idfYN04JrvqI3PopNdU6+fSYe39X5yumAU1/J+S0yGA7Ez72F
         nGieJwobbaK1j6EcqQM9I0V4OAk98A7kFe9C5ixNzgKwiP/R1c4dALSlCUKOJraptUrz
         0+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uYUP0WvJ8OVS3p9Pt4OYtUrTIoCYyxeTlVr1HS9+PVI=;
        b=SRL9CbdX5awVY500lC6x4SEZ6uE0r1t/+UY3Q+Yool0JHTCg1jAMBtKVQxg7c+XIHL
         toQV1pCtVtElX1CrSoZQWmTczEKmjvL3L0fxn6cp/gxMYVr9pdWSUlKj11W9bnlbrq9U
         bDUC1pXfFts/oqrF/awfaET//fpPdciFjjCPg8N0xUWPEj3esKcl/J9WNhtpyiTG7YRg
         ADuMf8LBjYCU95I4AUs40xhxFkxVNzJn5BSUhui+G0gj2Ge7wf3OzfwjBgOApM8I5a8t
         M1ZNHk1TwHOfA9j5IJnx3fQP528WB/pKD9KhIf28EGl3aiI0+ClNe4jXJZwiMvAGfON0
         +8ig==
X-Gm-Message-State: APjAAAXbQrMdmbTDwfe057WhIsBw0NItxMkIfYmd9lIw+mtyK6aZQRI+
        VIoH5SwOj/uWiOex8tQPKgDoTQ==
X-Google-Smtp-Source: APXvYqyk9fFSY8mn2x/l3b8QgjpGyHo8ZJJqsmgAk74ri7d+TLveq7JP/0BgDvBCA7rhpkjJLK6EGg==
X-Received: by 2002:a0c:acba:: with SMTP id m55mr39733792qvc.52.1559829536685;
        Thu, 06 Jun 2019 06:58:56 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d38sm1369241qtb.95.2019.06.06.06.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 06:58:55 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] powerpc/cacheflush: fix variable set but not used
Date:   Thu,  6 Jun 2019 09:58:13 -0400
Message-Id: <1559829493-28457-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The powerpc's flush_cache_vmap() is defined as a macro and never use
both of its arguments, so it will generate a compilation warning,

lib/ioremap.c: In function 'ioremap_page_range':
lib/ioremap.c:203:16: warning: variable 'start' set but not used
[-Wunused-but-set-variable]

Fix it by making it an inline function.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/include/asm/cacheflush.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index 74d60cfe8ce5..fd318f7c3eed 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -29,9 +29,12 @@
  * not expect this type of fault. flush_cache_vmap is not exactly the right
  * place to put this, but it seems to work well enough.
  */
-#define flush_cache_vmap(start, end)		do { asm volatile("ptesync" ::: "memory"); } while (0)
+static inline void flush_cache_vmap(unsigned long start, unsigned long end)
+{
+	asm volatile("ptesync" ::: "memory");
+}
 #else
-#define flush_cache_vmap(start, end)		do { } while (0)
+static inline void flush_cache_vmap(unsigned long start, unsigned long end) { }
 #endif
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
-- 
1.8.3.1

