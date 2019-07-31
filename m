Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4C6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEA62171F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ofZWWtS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfGaUim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:38:42 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34513 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfGaUil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:38:41 -0400
Received: by mail-vs1-f65.google.com with SMTP id m23so47260443vso.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=L4Tl5485GNCbBNzPALyO9jFAKxSVUDo2VTt4y0HMbAc=;
        b=ofZWWtS5ZWqQtpc9yer1nhq6viqjcYncIAGy4woJNgEe24OrmcTyAuaPYbJud1ZPxS
         d8NxLYzD0QA/XYfFmCJ5vzqkytrW9aCNOZpa0YxpDMyG6HQvHi6W7s3tWQB3YgHd2ayz
         TRa1ga5Ghsnm7qCRWcXY9mXYD3b/NnkpGhgoKIc8UTiTy6tHKNAcpUdepziwSrv7yZJa
         EqAIbxsyZBOJhRkxvvRJI+OwkWzOYuvpQ9ZwRxE3WSuLxrHTSDZXDLu3TOeSFqbaGWYw
         c2wkGNBWMOYw8WiiboqENEhtuNH4/4u1g9oDjnDnhBUKgJUbq3j48HWJLXHf5KebtJ3y
         QL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L4Tl5485GNCbBNzPALyO9jFAKxSVUDo2VTt4y0HMbAc=;
        b=qoKjriee48SSIQ18kgo3o7jLDlU/ZNjfXZZi8a4c7mfy+e38JXEofUkGqfP7yOHMtV
         S1zt9Xa8VylyfluJMvt7wprsnuf0hLXZrgxv2M0BhSzam3UoI0xQS0vvpdk55AYoHqEk
         kfE484EbGTtlbVzat14l8oKleWsihU5Zz3V8q8QvmQRrCc3Lhw/uc6vqtkrIIpWlEXWH
         D/9/cTJ6khlX7jpljso1tA+/7lcbuJyl+Th8yzXRxH0Kd8HJyaXSQMpc91DOZV+oeqL9
         KKUttU6nPyIAz6VX8XbbV5ILbzxzJGGw4iwpk8s/KwhGo8AeZ8yVOI9qw3m1sjeFztrL
         iCyA==
X-Gm-Message-State: APjAAAX9MHxecU6kt3QylJ+v3HMIQMsQ5OF9Gjgdsnaw5JP9MmpjRP86
        hwa9tsN5WFcFEWF2vLxOfgXcBw==
X-Google-Smtp-Source: APXvYqwtVnkE/nTu9d2ervMPefdplu+skmjsj9M8Fn84HuBzn/RmQ72eprdarhaEmYf1cGiaCI4ygA==
X-Received: by 2002:a67:1281:: with SMTP id 123mr69227162vss.10.1564605520701;
        Wed, 31 Jul 2019 13:38:40 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k7sm18697069vkk.48.2019.07.31.13.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 13:38:40 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     andreyknvl@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] arm64/mm: fix variable 'tag' set but not used
Date:   Wed, 31 Jul 2019 16:38:18 -0400
Message-Id: <1564605498-17629-1-git-send-email-cai@lca.pw>
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

Fix it by making __tag_set() a static inline function.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/include/asm/memory.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b7ba75809751..9645b1340afe 100644
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
-- 
1.8.3.1

