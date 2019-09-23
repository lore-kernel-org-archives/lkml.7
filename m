Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE39DC11FF7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829E1206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="LwEAxQjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502735AbfIWUe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:34:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43611 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502724AbfIWUe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:34:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id v27so2544391pgk.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nna15T41FBOo8C0ScgrwWvHxD4xBB4A7rtr2LOcD0mg=;
        b=LwEAxQjMu7W1QVZ23k/g1S4Eyx/tFZWSFOlnPakoYnP0ZAU2dmXFAKO2Oxrbqk1VaX
         AfgCnMNHzL9+qHkNVurT7ZHFnvl4gqQXCtMOx1UyGRVHrhSxv9+npn68KE8GC7IT+RRe
         SmLG9/jB22QvYfRuUHH82/bA6S9fNOUiYGPTxCFxiHwjEU4rXZsEjXnLQsfgv+gclC7b
         BD1+Q3J8Jry4/pY7Bz4mzVK5LteVKPXJkGwjkNv08PKILtB+xRyQ1C9cCMUZZroxQmy5
         0cFI7Ks3jDLpcpzUqeRn7R7xXfc84q8H5qJoaryaJ8zt4fmCPEkoTA40UJ1vjXj2y2et
         d8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nna15T41FBOo8C0ScgrwWvHxD4xBB4A7rtr2LOcD0mg=;
        b=Ks7NuD4uGY57nMFqYwyXvA0oG3Nm0ZIdR+0Dl/3/XulM0kzX8DIIDEafGQN1R2Ls4F
         36m0zP4z3p2a4s3Rht+1NYnxjug2HkmnDotgIWv9L5DOLoW685CwYzo4tJRuDvkIknXD
         MUmoyl3A8IJL0JR32KfWVf2pZS+7jycGeSmN8MsYkygh7F7KLi/SAqk4Wh2NubUEHOyM
         Tp3l9iqpshKKasydJTUOgMakXAP49+90e6tZvitEVDP4vshx22K6iRNqh/tnFGQ7jXCD
         fLejxsy2fuqwMHJ9e5l7g2jSb84/cNBAflG7R2ZrvIntjqTflVkpyrAf3PoPaRhcUQAb
         jIdA==
X-Gm-Message-State: APjAAAXm2Y5VjGcMR08fCwijBDR99ZRrrjap54slLz9ebZjV2pkISU2w
        usnO8pRtTEBjul23CJSv3eedzw==
X-Google-Smtp-Source: APXvYqwnL0GEjIshKzO5kl0urcaVAH5d910rW/z2mm7V4txKhm3HL8CIVxbIbYZBpIjpI74fhCfRHw==
X-Received: by 2002:a65:5543:: with SMTP id t3mr1763983pgr.242.1569270895507;
        Mon, 23 Sep 2019 13:34:55 -0700 (PDT)
Received: from xakep.corp.microsoft.com (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n29sm12798676pgm.4.2019.09.23.13.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 13:34:54 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v5 07/17] arm64: hibernate: add PUD_SECT_RDONLY
Date:   Mon, 23 Sep 2019 16:34:17 -0400
Message-Id: <20190923203427.294286-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190923203427.294286-1-pasha.tatashin@soleen.com>
References: <20190923203427.294286-1-pasha.tatashin@soleen.com>
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

