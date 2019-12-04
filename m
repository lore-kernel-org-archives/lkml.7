Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB83C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19732073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="eEEYwLt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfLDQBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:01:16 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44559 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfLDP7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:59:55 -0500
Received: by mail-qk1-f196.google.com with SMTP id i18so319269qkl.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6DRAyEoCdK9TxqUcwf0g9TjRPNHmo9zs5TUoFziJ0k0=;
        b=eEEYwLt+hTbJHjZGXJOIHGoPV0UOvx1ZeURkx2R1nB3SsUBlIZE7ADgEwdPuTABwpE
         OOgeTioPRVrMb2bxe2hhM/Z9LPps7Xv03urwLflHmlURAqG19XK1s8aQB5nBf7zQn9s6
         AyEPd7zWZPyVjUA5naRYTpULbhhDs6YPFIrudc6FUPrqMbWXg6EVSuW0i4I3rqVlowzh
         COgxpK6U2JG6C+1eAy8zApzt++TssEuYpwypz1qDrRM7QgkRvgJTLErze5NA00L0n5z3
         fX8SMm/wVy54kstNl85WdK5lUxhSNWdaQnzWXrMcIi/esJ6Jq5SYHeuV76kHwxGrHsWi
         EedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6DRAyEoCdK9TxqUcwf0g9TjRPNHmo9zs5TUoFziJ0k0=;
        b=Cf2x53QobMPOfSz4gQ3+j7h4kMG+qNQrpiFXDWeYvdqdKXyQhrkyl+sDsf9RVxb6/F
         Lw4mX4m+x9QGhWmnvQZL/EtuiE4LHLmy5XgFXCa9wreQaPAuCqY4Tq/z/cCwdTY9rexI
         7VzLs/H2ajnWRQllulp3CzQBxaRYxd/CBkPZF2A/STlnv7R8FgGhCI5YHo70W1fVO3jT
         w1vWEyrv81i87r83wHU/98854pN2gwVG9beisB2NVnFfCGELvsseLBedHGRFI0+9btXJ
         Lro3h/dqX89r1K+3Q/bn2gG1TN/DO/+p9WG3gXGCExa04tVn4ODg+hstwzlivvSN0eHu
         Bvtw==
X-Gm-Message-State: APjAAAWlzZay99Wx3n7IcYkxFGowblT9d9hZttV/qm0eKmA1FekJrgt3
        5Lw9r8nHfPlytpH9w6X3JgUmYQ==
X-Google-Smtp-Source: APXvYqzjqDF0GY/1r5NyS3ngkq9gMg1MFDDPeIew1JMCjQUzGwF2bXi71E0HuqqkCdtpx38zKJY0jQ==
X-Received: by 2002:a05:620a:201d:: with SMTP id c29mr3583282qka.91.1575475194082;
        Wed, 04 Dec 2019 07:59:54 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id w21sm4177585qth.17.2019.12.04.07.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:59:53 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de
Subject: [PATCH v8 09/25] arm64: hibernate: add PUD_SECT_RDONLY
Date:   Wed,  4 Dec 2019 10:59:22 -0500
Message-Id: <20191204155938.2279686-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is PMD_SECT_RDONLY that is used in pud_* function which is confusing.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Acked-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 arch/arm64/kernel/hibernate.c          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index d9fbd433cc17..9961c7cee9c5 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -110,6 +110,7 @@
 #define PUD_TABLE_BIT		(_AT(pudval_t, 1) << 1)
 #define PUD_TYPE_MASK		(_AT(pudval_t, 3) << 0)
 #define PUD_TYPE_SECT		(_AT(pudval_t, 1) << 0)
+#define PUD_SECT_RDONLY		(_AT(pudval_t, 1) << 7)		/* AP[2] */
 
 /*
  * Level 2 descriptor (PMD).
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 1ca8af685e96..ce60bceed357 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -436,7 +436,7 @@ static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
 				return -ENOMEM;
 		} else {
 			set_pud(dst_pudp,
-				__pud(pud_val(pud) & ~PMD_SECT_RDONLY));
+				__pud(pud_val(pud) & ~PUD_SECT_RDONLY));
 		}
 	} while (dst_pudp++, src_pudp++, addr = next, addr != end);
 
-- 
2.24.0

