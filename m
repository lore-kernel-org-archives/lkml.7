Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA9DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB9A216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="AV9pCfKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfHUSc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:32:26 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37730 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbfHUScX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:32:23 -0400
Received: by mail-qk1-f194.google.com with SMTP id s14so2735743qkm.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 11:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Yf2fYsGWmgnnQqiDNWCmPXM/COSxiztPqOnwojagYFM=;
        b=AV9pCfKUsiawZGUWx3hjjiRiURb24lZoFSDXVLZDUm4ii8r2zEff9xP3F8HWOaVnz9
         7549slyFfkoTf49vracJw6NGvjRE2I54NYncbRXZcR1oT4pt/TZPRNeLfWLPTbmVwO8F
         n7ch3vRDnihAKBNzxR+zskyPitFluivKs5ODI9V9heJTCJPtTK4/QtWPi4+3DwLKUNRT
         Ddl0fN20/xgUuhQ9ptEy7RCSMz9vHuZdIP44a9kJkCkXj62MP15VWMrI7KKNnj77vDxt
         e7amT1uwjq8BKEy8vADVY2I1/fKnJ/He5LBqUadvT2iXTqPPl1M5nCnRd3cBKM8veD0g
         FnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yf2fYsGWmgnnQqiDNWCmPXM/COSxiztPqOnwojagYFM=;
        b=St7uqgn3ABhV5Oi3dfBzBeGP0FoBunRhPJialNOxtQIvDlGGqnjMOKLsEWa80bcGVt
         Gxl4UB85tXaz7CpI5qSHDzwDPKUsu3vSKXqdIMEQmWkQ1wsr3qVEOh7qAh6rhtEHIPy0
         Siud1Pt5YYPXUrfKlEzuvX7fJHsc7gb8SXzUsx0fBrgB5pCx1TV6DRRfp7eIg5TJuqJl
         b4uo/usvdKtHCi8dXK+JoVuVwl3xQoKq9qP1Sr0AyJeO3L6E7/vOTMJ8wCPSPJW7ThC4
         nBfwfWzCxsOuZUpcg77PD8bysZ0Nej8ZH0FbcocA/Pucr7s/ud2NbO5pd19r6uf1Fwa/
         WC3A==
X-Gm-Message-State: APjAAAVV4DyuVEnOpDP9iG3b+E70t3AcumIIH0iT66kvhLxWi8yAzGBM
        XfrshT2p80HO6bxOmNHzazZGVA==
X-Google-Smtp-Source: APXvYqyonOE9Pa9E8IpTB2dIML7UFPRfxTQ79CX7u/hfje5VCjkBAXfDiMf191JorFAgip6FOT91+Q==
X-Received: by 2002:a37:395:: with SMTP id 143mr33533257qkd.317.1566412342049;
        Wed, 21 Aug 2019 11:32:22 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q13sm10443332qkm.120.2019.08.21.11.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:32:21 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v3 11/17] arm64, trans_pgd: add PUD_SECT_RDONLY
Date:   Wed, 21 Aug 2019 14:31:58 -0400
Message-Id: <20190821183204.23576-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190821183204.23576-1-pasha.tatashin@soleen.com>
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thre is PMD_SECT_RDONLY that is used in pud_* function which is confusing.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 arch/arm64/mm/trans_pgd.c              | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index db92950bb1a0..dcb4f13c7888 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -110,6 +110,7 @@
 #define PUD_TABLE_BIT		(_AT(pudval_t, 1) << 1)
 #define PUD_TYPE_MASK		(_AT(pudval_t, 3) << 0)
 #define PUD_TYPE_SECT		(_AT(pudval_t, 1) << 0)
+#define PUD_SECT_RDONLY		(_AT(pudval_t, 1) << 7)		/* AP[2] */
 
 /*
  * Level 2 descriptor (PMD).
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 7d8734709b61..efd42509d069 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -138,7 +138,7 @@ static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
 				return -ENOMEM;
 		} else {
 			set_pud(dst_pudp,
-				__pud(pud_val(pud) & ~PMD_SECT_RDONLY));
+				__pud(pud_val(pud) & ~PUD_SECT_RDONLY));
 		}
 	} while (dst_pudp++, src_pudp++, addr = next, addr != end);
 
-- 
2.23.0

