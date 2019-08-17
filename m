Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1968FC3A59D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B1D21019
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="K3uh07Qn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfHQCrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 22:47:21 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39917 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfHQCqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:46:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so8217031qtu.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 19:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RGtrOUupW4z37ipmqcLJyB3m7q6WPq+p9ucEiFhnLcg=;
        b=K3uh07Qn3TrpcWz7z/N+EGQbeyvKel3p7LpHgPxW5XHEjHN0nGfMdgMxXJEwmCcG6B
         nhWCIGqiH1BVHTBUWPfRA9ND8m+l/2KTafHuxqDij7+QKz/6GZD6bCgPhsJWTHE4AHiI
         6QuEh9K7DIQ65DSCwGlbOOE6+FpfL41IRKJgh1HQ6gIEoUzJizo4TtnYl8fFrxPVcgT6
         I/Rh6DFEQ9kD9MkGVP+CrWhb4fozfe+U3YNn6UXqxmwHpiDRJHemP2SO4pOJXNXrs2EC
         j/tgcGrskD3ABV484TSaBLkoWfzEkalgsgMt+pLjBW9D4bLY1lQad/JI8NYEodMP3lxH
         z25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RGtrOUupW4z37ipmqcLJyB3m7q6WPq+p9ucEiFhnLcg=;
        b=sISP9WV9+qszcw6G2tqAkQOmPkI3hT7klwKlgQnlxG3LSO3GADo/S05SndKB0QR4Pv
         ibVCSRn0e6AOECUOMZCOE4a+M4iDsy300DQrM//94vy8Ffpycs10QjNu9a8JQP0IOSc7
         hr22sVCoxuCI+hq5fqT3jXhoc26dN0/LUSraAHZBg92c8HRVTfmwddJ/aK/QW8n6E3I5
         8WyMC4jhdLAFcziBwy59SwY4a9fItFdLgvoYKXkhq3/VBvKoqPBo81t/gLZuRshIGJsn
         ydz7A6lI0Mu2BzVlk3CpSZeLqPxaIJFSB3RlFZNfRwl3V8StkIHyuXgoDQJLL1j5svQZ
         RZvQ==
X-Gm-Message-State: APjAAAUdaMjeu/nCZ5t01W+UhAbU3fNjK3nKvpV9sYVvG/ogo2ca3sIv
        E5sV+y72AwLxQehhODcCzyuWAw==
X-Google-Smtp-Source: APXvYqxHWuJZxhJoL32IA5dYdauUAj5ZZIoyQiY5axJ7rJ6tklLVzo2+3JJMyaLqd0hjiXW2rE1ZaQ==
X-Received: by 2002:a0c:b786:: with SMTP id l6mr3917888qve.148.1566010002583;
        Fri, 16 Aug 2019 19:46:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o9sm3454657qtr.71.2019.08.16.19.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 19:46:42 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org
Subject: [PATCH v2 08/14] arm64, trans_table: add PUD_SECT_RDONLY
Date:   Fri, 16 Aug 2019 22:46:23 -0400
Message-Id: <20190817024629.26611-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190817024629.26611-1-pasha.tatashin@soleen.com>
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is PMD_SECT_RDONLY that is used in pud_* function which is confusing.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 arch/arm64/mm/trans_table.c            | 2 +-
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
diff --git a/arch/arm64/mm/trans_table.c b/arch/arm64/mm/trans_table.c
index 634293ffb54c..815e40bb1316 100644
--- a/arch/arm64/mm/trans_table.c
+++ b/arch/arm64/mm/trans_table.c
@@ -138,7 +138,7 @@ static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
 				return -ENOMEM;
 		} else {
 			set_pud(dst_pudp,
-				__pud(pud_val(pud) & ~PMD_SECT_RDONLY));
+				__pud(pud_val(pud) & ~PUD_SECT_RDONLY));
 		}
 	} while (dst_pudp++, src_pudp++, addr = next, addr != end);
 
-- 
2.22.1

