Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E4CFA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C5321928
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TQPiVPXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436874AbfJPUAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:00:55 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32995 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436861AbfJPUAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:00:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id x134so24009917qkb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nna15T41FBOo8C0ScgrwWvHxD4xBB4A7rtr2LOcD0mg=;
        b=TQPiVPXa6rC+kc21T5AmnzQtQWNyHeLwcYOGqGygHSZ+fqUC6+tQeXq3H2/srTI5dS
         vEw9EaypNQQzPeKXsH3RHjmh5y5cLcTDAGhFTQsAIZKI0loaphdsKgusgX5SZkJWrqGS
         uuLke5b1StwZolCe2CpSrX0/fu/GGKG4aO0epbNKb4IEVQ1gFJv03fvfP90Fhb8UHFko
         DRJPJixDzGdMtrAvKc8A5+QSj0H2JImxJYrtOOTwV63s74TYwqaw5sEq9kOU/Rz6HwFX
         J5ESQ9FSmQS2P3y4sK73jjdbXN3u3rRc4rk6pEcv618j9wqmw8xpOwqQuSsHU0s7+oDZ
         B5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nna15T41FBOo8C0ScgrwWvHxD4xBB4A7rtr2LOcD0mg=;
        b=F/aEHXUVNbO6e5q5Ph/+ujMVWqhCujV+yKUfcurKSl5aL0MPdMvgwWOM6MiZwjEupg
         JZIzzyi8g54gb+KBvZiVjA46/VRi9wQW+CqahBgOtfLXiu3V1II1CvKIBpYLbMp3vO5j
         aHrOSpUvmsJtHDuZCc8d8S0wbSprP/uisUCTsIFHdSa8sZRWLsDuCf6qba+RbVZgFOEv
         a9rNLscnwEkxFQvHA8GmazGFr2kD+Co9mWmIVBR+tpQGcWxAEg6YHLOsBSdY958ZiREX
         COrtsg+6b3Xs3abLjG4ioGmC+081D3/8sSK66w2FUA8M9t73kkPEnVinnLCQTbvQI+zp
         WiVQ==
X-Gm-Message-State: APjAAAVQnJ1KmTyh5Ck+XiuFyjbrQRxmuVF47DWpzfgOLaT5mYnh3tAq
        iDvGv/e5bMztTFg058ChEV20nA==
X-Google-Smtp-Source: APXvYqwwc0v2zGWdRcDisHGnJhHRf8p5mNSEZfi0uPD1ZI7/TTBqwIA/aASx5yQlegVlk/zNFWbPjg==
X-Received: by 2002:a37:ef04:: with SMTP id j4mr43731174qkk.482.1571256051867;
        Wed, 16 Oct 2019 13:00:51 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c204sm13342030qkb.90.2019.10.16.13.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:00:51 -0700 (PDT)
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
Subject: [PATCH v7 09/25] arm64: hibernate: add PUD_SECT_RDONLY
Date:   Wed, 16 Oct 2019 16:00:18 -0400
Message-Id: <20191016200034.1342308-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
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

