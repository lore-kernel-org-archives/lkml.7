Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2234C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF76206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="G8rAEk4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfGaUGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:06:09 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35904 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfGaUGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:06:09 -0400
Received: by mail-vs1-f67.google.com with SMTP id y16so47116550vsc.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xmPjjmmf4+gFo5kALeeHuZbdpMAsYz3IH/3r3H4+9ag=;
        b=G8rAEk4u8bQFqyZvsdRqDU+I5cYozB4lVT2OE2OcGrXZSPpFoi5VRmJiZuBXbPE7Ps
         t89Kb/cgo/PjpoU0beaAKd8TU84LTlL6EjaDhdQQZWxW8obpVyuKeMAu0RkePO59Ghcf
         jfujlAw6IkDEyzp6vuamu/1K8k2YZwfdHVPIMpzCIuSV2ew8+1Q8U1hQ/i4FQnYKAX/m
         ofq3/saeJxblLG3EK1CLbK8Ky4WjImDfrE87wrzFIkDBbFsjbAQW1V1leQAqpFQI77SG
         xMaiNn9WTWax+ELQ1xPCNwmzXZS6idZh9LRnZP7N2YGkwme0I/gHURd4mIp1iqsifxOT
         wMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xmPjjmmf4+gFo5kALeeHuZbdpMAsYz3IH/3r3H4+9ag=;
        b=JXTHIWBihcLpOSmdzBOGfIJ+Q5Z3ZiVtd/LenPPecIXr3GWRXMgD0LB3nE+KlrJLyR
         lDrUhdWzEupHMv+d+LSwaoAx8Dyr7E7FNAdzwsGwbJf+KK3jHitjvO3K29WGUfwteS7j
         UJSxvwzvzxCxEE9ihdQt55j5n8La4YzUaswkhFkMpcmaVOobwUWzrXgxb5KKIb16CP/l
         f494+uK9713jNEKeTVoK1ec93YQIdMvfrzvmDEkgv8Rj61PRQPFyST1A/+3zM0/f2/nD
         wswxE1xtX5fGAdoc95FcmhpkNAZLYc9z2/OCmxmlWhnUl9m9s3bTXeRjVIahfCcA9VIk
         JYzQ==
X-Gm-Message-State: APjAAAUHEzq8mvKbhGgdD54SK+KnkKaP/FjqO4Q/zqfIGobZ2dvrhURJ
        iL+abxl3VZ0UTI074iQEzGkYhQ==
X-Google-Smtp-Source: APXvYqwDFXXJKVaaRLQNlrqo/ycvYqOMZDQRyXsC9KjeEADy44EzhJcvaxN6b4K4kmpA/leb8BQa2A==
X-Received: by 2002:a67:fc50:: with SMTP id p16mr81886754vsq.79.1564603568705;
        Wed, 31 Jul 2019 13:06:08 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id e3sm12703871vsp.6.2019.07.31.13.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 13:06:08 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     catalin.marinas@arm.com
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] arm64/mm: fix variable 'pud' set but not used
Date:   Wed, 31 Jul 2019 16:05:45 -0400
Message-Id: <1564603545-14776-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC throws a warning,

arch/arm64/mm/mmu.c: In function 'pud_free_pmd_page':
arch/arm64/mm/mmu.c:1033:8: warning: variable 'pud' set but not used
[-Wunused-but-set-variable]
  pud_t pud;
        ^~~

because pud_table() is a macro and compiled away. Fix it by making it a
static inline function and for pud_sect() as well.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/include/asm/pgtable.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 3f5461f7b560..541cb4a15341 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -447,8 +447,15 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				 PMD_TYPE_SECT)
 
 #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
-#define pud_sect(pud)		(0)
-#define pud_table(pud)		(1)
+static inline bool pud_sect(pud_t pud)
+{
+	return false;
+}
+
+static inline bool pud_table(pud_t pud)
+{
+	return true;
+}
 #else
 #define pud_sect(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
 				 PUD_TYPE_SECT)
-- 
1.8.3.1

