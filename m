Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F38C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD792080C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LejEUzoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbfHAOrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:47:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46818 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfHAOrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:47:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id r4so52131217qkm.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 07:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=230s3ChFPRc4aRDJM4ggG97b31ayoZtf71ejiTiSkjo=;
        b=LejEUzoEVFEhSDCDH1H8Ri6NTYd+EQ93Bl/JO+hFoztUU8LZE/3ThN3ckZztuH/w1v
         9ZBKE0O7YssDOoH1hgL0JQ0pwQ4Tviu5kZ5YskORAs0iZ0+ltBuEKKnhLwhVfoBLyPfz
         d3Etk+ubEBLubY4IdfrS7mP66VUO9gIN8dQBHoQiV1U2dwuvTnBOWlcfbBMbBry5Emjx
         BZLpm9BLNXjMfjYY2AXpHp2FMBW9IHG9JC/MUR6Ray/aqbZgZs+McxqDbeFLvx96PlRU
         4vTWs2/AXl3PmmsA6wFbYZsVzZ/sHRBXrzLSDZRCzYvlG5U6RnMQCkeKXlij42mY/v7e
         ORuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=230s3ChFPRc4aRDJM4ggG97b31ayoZtf71ejiTiSkjo=;
        b=M3Ag7Y8Fqkfd+8NzExCvNare0SrGT8gzavhCGW3lJ0QGBlR/IIk8/8BR+ouIncXcsU
         1mOlbpRJsZUo8s9KiTTj76ACXQ/+GjHGc/AimaiUyRzLJw8nnAJ8r4g942/C+TydhNkm
         LqwQRtbWliSGo5Rvi3JEn/ptWI4ayReH07AlD83eI4dNGBiawWCtvWh+MdNZ4CSvpuUy
         kFcb6NSdgHGcK+CEs5HxLDJcTyW9gho5P7zMrQhT5yay71pUtyxC60bFofjT82eZllXu
         1nCj5iQvH+kn65mENvR02IG8WSahWEBj9vd9dVJ1LiDR22HUc273lnCDXmcp2qiWmTvf
         0Tkg==
X-Gm-Message-State: APjAAAWUWJwn0CZB5TRfxeRD3Jgvk2ZuDDQPkLwau1ysv/2T8vZle9LT
        n9crlDKdsE5amKh3j2BFGd7i8A==
X-Google-Smtp-Source: APXvYqwHfUt80l0BXUJpBGTFwk3Bd4gQ46/mlKzXrLecWYywA/07oGtfuHM8Qz7nWtC7/qhxbBwNVA==
X-Received: by 2002:ae9:e30d:: with SMTP id v13mr83907407qkf.148.1564670859058;
        Thu, 01 Aug 2019 07:47:39 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s11sm29605818qkm.51.2019.08.01.07.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 07:47:38 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     andreyknvl@google.com, aryabinin@virtuozzo.com, glider@google.com,
        dvyukov@google.com, linux-arm-kernel@lists.infradead.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] arm64/mm: fix variable 'tag' set but not used
Date:   Thu,  1 Aug 2019 10:47:05 -0400
Message-Id: <1564670825-4050-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_KASAN_SW_TAGS=n, set_tag() is compiled away. GCC throws a
warning,

mm/kasan/common.c: In function '__kasan_kmalloc':
mm/kasan/common.c:464:5: warning: variable 'tag' set but not used
[-Wunused-but-set-variable]
  u8 tag = 0xff;
     ^~~

Fix it by making __tag_set() a static inline function the same as
arch_kasan_set_tag() in mm/kasan/kasan.h for consistency because there
is a macro in arch/arm64/include/asm/kasan.h,

 #define arch_kasan_set_tag(addr, tag) __tag_set(addr, tag)

However, when CONFIG_DEBUG_VIRTUAL=n and CONFIG_SPARSEMEM_VMEMMAP=y,
page_to_virt() will call __tag_set() with incorrect type of a
parameter, so fix that as well. Also, still let page_to_virt() return
"void *" instead of "const void *", so will not need to add a similar
cast in lowmem_page_address().

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Fix compilation warnings of CONFIG_DEBUG_VIRTUAL=n spotted by Will.

 arch/arm64/include/asm/memory.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b7ba75809751..fb04f10a78ab 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -210,7 +210,11 @@ static inline unsigned long kaslr_offset(void)
 #define __tag_reset(addr)	untagged_addr(addr)
 #define __tag_get(addr)		(__u8)((u64)(addr) >> 56)
 #else
-#define __tag_set(addr, tag)	(addr)
+static inline const void *__tag_set(const void *addr, u8 tag)
+{
+	return addr;
+}
+
 #define __tag_reset(addr)	(addr)
 #define __tag_get(addr)		0
 #endif
@@ -301,8 +305,8 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define page_to_virt(page)	({					\
 	unsigned long __addr =						\
 		((__page_to_voff(page)) | PAGE_OFFSET);			\
-	unsigned long __addr_tag =					\
-		 __tag_set(__addr, page_kasan_tag(page));		\
+	const void *__addr_tag =					\
+		__tag_set((void *)__addr, page_kasan_tag(page));	\
 	((void *)__addr_tag);						\
 })
 
-- 
1.8.3.1

