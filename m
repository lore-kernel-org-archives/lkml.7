Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89B5C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA6621774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BiUszVfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfK1O6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:58:05 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42529 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfK1O55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id e28so4648983ljo.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Bun68+vGX0cpO8gva8KbJU3Sj9L3G/suxA//a5o0RU=;
        b=BiUszVfH4xD7TeJbkxiZNgcYZYOIlp+5P2RR1S2/Rw4kQ+d9IE9N4RrFlOWACnk7Ws
         VF2RmylZqWUGDJz4rHvV+iwDq4ISPLeUCaV7NiLCQBFZALMu33LIJqYp/YDL+Jp5UhJA
         wSTZVT532Z+h6FFEsGS5Q1g2A5XNjVwix2Dc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Bun68+vGX0cpO8gva8KbJU3Sj9L3G/suxA//a5o0RU=;
        b=jmNY+Tk6lZKQv6bjYozAW7oh2oBNH/mgnpGz6PCzuG2hS7AoYvWcBWrVvgmUv+9eY5
         USnzolFTQNlil4HF04CXjhDDCZs8DGsf2V3kdtWRLYOXqzPs9diKzYQ9Jem0hd0y+ywU
         OHdQe7IUejgXQX1e6o/vb6i4I/bxLTTqWCraIHOr/0npOxIcynjnvDWqASWfzUtCZgKD
         igwUviEdEIdZJIxGha5TIiZKNhU9zRaLMrxGJAWSDqs2Gc1eNqEX+zBcekBtnLPTF6Za
         0hwUI3YeucUJF2jNUlBWgBAG3O0Q1RzlddUmt0gCyeP6a4BhdJ0gaSpac3/oZMhzBkHA
         TtvA==
X-Gm-Message-State: APjAAAXSANxg1hb9sG4hm2Cji/kWYjA4mrrHqPE0JDVg51ddGeBFnZuD
        n3j8ivciPalwNpQxGDOZ2ALJyA==
X-Google-Smtp-Source: APXvYqwaGl/+nUJyEvEWFx2+e9Z1DYPyhWNpmKm+QNrRw4gHEm8FZ1KH1eJwfl5J9bgJnXga5KzIdQ==
X-Received: by 2002:a2e:8855:: with SMTP id z21mr36010930ljj.212.1574953075288;
        Thu, 28 Nov 2019 06:57:55 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:54 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 38/49] soc: fsl: qe: drop broken lazy call of cpm_muram_init()
Date:   Thu, 28 Nov 2019 15:55:43 +0100
Message-Id: <20191128145554.1297-39-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
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

Reviewed-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
index 48c77bb92846..dcb267567d76 100644
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

