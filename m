Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD6CC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510B5222CE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="E2itMeYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbfKHNCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:02:24 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37909 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbfKHNCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:16 -0500
Received: by mail-lj1-f195.google.com with SMTP id v8so6133402ljh.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nGAR/RezFR3p4yZ/WuemAtPhyGpYuWvNUP10WcDqxdQ=;
        b=E2itMeYzpcpcvPiEYcR7QgT0vf86pgTt+txJLe4ypE1iKN4ygJjlMfIdTBHaIbca7l
         8TpMr7BlmS1pHXW8Lc8yrYYMbrYpZ6OWxpbB6h/El0hJa3CJ4u+D0CSxshybjUOT8noF
         QvazWxYu0noVka+ujfegXunMpmQNGUILv+4L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nGAR/RezFR3p4yZ/WuemAtPhyGpYuWvNUP10WcDqxdQ=;
        b=WW5hWoY/g2nw3gOCy8FCRQPRcV5NZ3qt5TRqRsmAM1LFrMfcBfMhN26RFZ2/Spp1Mt
         WFTJ3pqg/UWMvJJwLzu5XuAwu0rnNYnGDGzDGrJ4wwxsAXyQyUoQSSYpX6lKRXMEigcO
         h4LB6YL3RstCZaovIYMExHBeYMZGemNWBlCpTFJo1ot+C/jjHjoYDjIvlgqWb3m370v8
         4pNL+zR70J7br1Kb6mzE8m2bupCKpkeltbROKwjkngubXoWxNIRQgYDFCRVxkf1gm++g
         UJkY5AIMR6tivld2/xQ/2psYH2LYyMGs8EbEjj0NpWwmal5O1VySUMWGXxYP/kTMb8YC
         7QMQ==
X-Gm-Message-State: APjAAAUSY0fa9WJgJalIujTs8/yom1ti8zPjZ5hC41hEGzMdFKveoUap
        qTGZyH/Se5s5uOYyHXHnu+LrjA==
X-Google-Smtp-Source: APXvYqxRVlzGHosXYr2fWpCL9TuHFktXGiL0j9+nCag9bKeXu8pwMfcJUWqBOjQJYoqb1ThzLR2FBQ==
X-Received: by 2002:a2e:9b4b:: with SMTP id o11mr6798538ljj.252.1573218134744;
        Fri, 08 Nov 2019 05:02:14 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:02:14 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 37/47] soc: fsl: qe: drop broken lazy call of cpm_muram_init()
Date:   Fri,  8 Nov 2019 14:01:13 +0100
Message-Id: <20191108130123.6839-38-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpm_muram_alloc_common() tries to support a kind of lazy
initialization - if the muram_pool has not been created yet, it calls
cpm_muram_init(). Now, cpm_muram_alloc_common() is always called under

	spin_lock_irqsave(&cpm_muram_lock, flags);

and cpm_muram_init() does gen_pool_create() (which implies a
GFP_KERNEL allocation) and ioremap(), not to mention the fun that
ensues from cpm_muram_init() doing

	spin_lock_init(&cpm_muram_lock);

In other words, this has never worked, so nobody can have been relying
on it.

cpm_muram_init() is called from a subsys_initcall (either from
cpm_init() in arch/powerpc/sysdev/cpm_common.c or, via qe_reset(),
from qe_init() in drivers/soc/fsl/qe/qe.c).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
index 4437f4e14d2c..feb33ec1c3d6 100644
--- a/drivers/soc/fsl/qe/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -119,9 +119,6 @@ static s32 cpm_muram_alloc_common(unsigned long size,
 	struct muram_block *entry;
 	s32 start;
 
-	if (!muram_pool && cpm_muram_init())
-		goto out2;
-
 	start = gen_pool_alloc_algo(muram_pool, size, algo, data);
 	if (!start)
 		goto out2;
-- 
2.23.0

