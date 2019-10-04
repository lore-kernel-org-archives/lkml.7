Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC258C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994E3222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VHCChoz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbfJDSxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:53:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37788 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730928AbfJDSwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:52:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id l3so9974344qtr.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nna15T41FBOo8C0ScgrwWvHxD4xBB4A7rtr2LOcD0mg=;
        b=VHCChoz0fROYiFF3E2hiGeINxfvJE7JQlXXzOJLd54akzbItA1+2rUzr4DI2djJ9O5
         Hyca0gHi/BmtqWzaux8ehDmfQ1GQp6qxgoGtldtG8PBTLXRXEw1mFAwqJcbvoPQ/L/MV
         b4QlOJB3QwU6EgG1nTI/SDmgwYuIGf0zvGu+jUWUpxSEFWz/Lo4IuyDOCCbcPAqreAzp
         rUhodhHLR+4SY72e+9jzUO7EZbvvOu+iqjKQe/fIzZE9uwz0R13jwGpyOKt8BvQ5FjZ3
         lKVmqELSCurVOwUZEKX5HmoOjjr1q/nYg8Cg0T6S+5qXTBzGv8rqKY71guAQ73XZA4U7
         73CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nna15T41FBOo8C0ScgrwWvHxD4xBB4A7rtr2LOcD0mg=;
        b=n+w2jDKhfeP1sZE80mmecatIFHbozkIymr8kX1LxIuE16sW9n7rWGN4xMpmv+MzDTa
         yneN9Dyj1RpeMDWWg1ffAh3emzgJO77JABPLP0F/Vm/4xE1FwP7GL2SNGhRZ56t2BpnW
         gBOt6aRG6bTxMrE0tb7RZiSkpqcKVz6proCWSn3L8qr6xKaJbY+ser7TCtF8P4PIg1Nz
         PGi3RIDux+/fl+ZBQptv/dGBkgbO1ki3HcJvQyF3+SOonVZbzwbMiwiX85KJVBojeAml
         PbYUkIG46t2DMZ65pIipDuGs1t2GA+l2bKj56nMvsw3xbtiU/gP5Ka3Eq5XJmrwuypSd
         9RAg==
X-Gm-Message-State: APjAAAVoE0imod96VfGVCMkX1h9MufWM2gpKL/SsKjNIgWps7d2QoIyi
        Cx59mUP21C8FwtSza0K7vn3Cnw==
X-Google-Smtp-Source: APXvYqyNbFmYvCagLzsifj1RuTq8tuyaOwA4jFplBgyym0KPw1b7isWuxXmSyyHyKvb+tYw7MVrpqg==
X-Received: by 2002:ad4:418c:: with SMTP id e12mr15569947qvp.70.1570215167250;
        Fri, 04 Oct 2019 11:52:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id p77sm4042514qke.6.2019.10.04.11.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:52:46 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v6 07/17] arm64: hibernate: add PUD_SECT_RDONLY
Date:   Fri,  4 Oct 2019 14:52:24 -0400
Message-Id: <20191004185234.31471-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004185234.31471-1-pasha.tatashin@soleen.com>
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
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
index 3df60f97da1f..756a1dfb4f55 100644
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
2.23.0

