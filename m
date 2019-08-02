Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CFDC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DD3206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gkBG/nsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404768AbfHBVIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 17:08:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43220 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfHBVIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 17:08:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id w17so31041543qto.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 14:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9NIIaoQDA9kYkrN6ojAWfKEQLlIq3Ym3D7SRrnB2/eo=;
        b=gkBG/nskL7Ggm/hovOQPmbJA7M2IQHtyK1DmYHRcwwHZTjiNrVHZQEhdQnTiqRSf9n
         33nMpWaXV1lr7o6GYi/Cdug/Y24LvK6WMKNFGvM69pUAQ597RiQhq4w8UTWVFlLH8j/j
         zZanALJzF45ePOm4It8SU7ESVxPABFEzHFWDE0kkLHFpM+cY7wNk/xJD1bKo3MQ7Rf5n
         FTh3BDnhIEHfRVfuk+VoqDAmQIiLBc80ujKe3LP65DfIuNF+LwWW0S1EdtuccVYklcMZ
         l3F/eaQcuroAhKPaSXCSkeBfrC9iplFgAZmvW2W+mLlocXKBjCAOC01rLo6AOI+LCqAo
         kadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9NIIaoQDA9kYkrN6ojAWfKEQLlIq3Ym3D7SRrnB2/eo=;
        b=D9AOOkJwQl7+D6AtLH4jZ0cMqGSl+Luhvlm+rZLK7H3BoKZgMdaST2TK+X5gWKdfEQ
         5RMvn2MG5NdMuK9MB9MmZzAlBELAtgvx6zFk5YlBXbn8H3eAtTRETUjpOWku6S/F7vwI
         FkMMMiN3NhCi33vOr3IohpkKizxjfwvi9tsSplRCcw3PyjuqhfkdbRT86dyAvuJsMyUT
         2KxwRbXWY38rMVH0ePUzrPMgAznc+B7lkov6K2h0FXwte0IG2nW+rVFTH8vxb5LcGcMY
         zyKjzmggQ9V0Fr3Kofl69IWbeEZley6afLQMxk823NJYA4PiUXVeA2/1y7ri3aXLquFe
         1Lyg==
X-Gm-Message-State: APjAAAU6oyXUv96e4tRolrLY/qlDZbqmC2kNQQ2gVAzau9KJRKAxr2gt
        oSNfanpL1nJ3h1JzeMQ81ZC7jw==
X-Google-Smtp-Source: APXvYqx98q11ve5u5ss92wDlkOo+LN9fHXWBmOAGa0/ZdWOJvm4hOs19zMHPqGwyfLmgJk63/0Uqhw==
X-Received: by 2002:a0c:fa8b:: with SMTP id o11mr99691618qvn.6.1564780109664;
        Fri, 02 Aug 2019 14:08:29 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f20sm29011362qkh.15.2019.08.02.14.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 14:08:29 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     will@kernel.org, catalin.marinas@arm.com
Cc:     rrichter@cavium.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] arm64/prefetch: fix a -Wtype-limits warning
Date:   Fri,  2 Aug 2019 17:08:04 -0400
Message-Id: <1564780084-29591-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit d5370f754875 ("arm64: prefetch: add alternative pattern for
CPUs without a prefetcher") introduced MIDR_IS_CPU_MODEL_RANGE() to be
used in has_no_hw_prefetch() with rv_min=0 which generates a compilation
warning from GCC,

In file included from ./arch/arm64/include/asm/cache.h:8,
                 from ./include/linux/cache.h:6,
                 from ./include/linux/printk.h:9,
                 from ./include/linux/kernel.h:15,
                 from ./include/linux/cpumask.h:10,
                 from arch/arm64/kernel/cpufeature.c:11:
arch/arm64/kernel/cpufeature.c: In function 'has_no_hw_prefetch':
./arch/arm64/include/asm/cputype.h:59:26: warning: comparison of
unsigned expression >= 0 is always true [-Wtype-limits]
  _model == (model) && rv >= (rv_min) && rv <= (rv_max);  \
                          ^~
arch/arm64/kernel/cpufeature.c:889:9: note: in expansion of macro
'MIDR_IS_CPU_MODEL_RANGE'
  return MIDR_IS_CPU_MODEL_RANGE(midr, MIDR_THUNDERX,
         ^~~~~~~~~~~~~~~~~~~~~~~

Fix it by making rv_min=1.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f29f36a65175..7d15cf6d62c1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -883,7 +883,7 @@ static bool has_no_hw_prefetch(const struct arm64_cpu_capabilities *entry, int _
 
 	/* Cavium ThunderX pass 1.x and 2.x */
 	return MIDR_IS_CPU_MODEL_RANGE(midr, MIDR_THUNDERX,
-		MIDR_CPU_VAR_REV(0, 0),
+		MIDR_CPU_VAR_REV(0, 1),
 		MIDR_CPU_VAR_REV(1, MIDR_REVISION_MASK));
 }
 
-- 
1.8.3.1

