Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD538C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C1020857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Da5Kawzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfKRLYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:24:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52354 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfKRLY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id l1so16933537wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KgiJMcSuN2IAx9Zm1/LolJRzS4II+K1np/uTCuIzrY4=;
        b=Da5Kawzye9nyinII5RcMGqIuWzaAHWpv8eWE10YEgTbOS2e7pdA1XEymDYI7XSx+Oy
         oU+qEkQDsm+hUgEwTwbTVoXCqcpxvJLWUl/oy2ljyegaTwrtwexyGLRkkdd1lWFbrLoG
         20iK32zcAbZlor6bFpAzxEtWoAzNhktt+/apI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KgiJMcSuN2IAx9Zm1/LolJRzS4II+K1np/uTCuIzrY4=;
        b=h3ZEOzJh3z7Ef44PAsdIzInxTDvmWJSkEMXwJ11Y3+WsNATEWiX2Op6MFTuD+GPV3R
         TtkKj/hio4z9wKpFfGasOhHpEbHvEvMY8FVoEgiJm/LdjmocEaKZsqUnJXQajh9mTatc
         KErbXi1TwQkC+/D45CBzYklHDUXYmtMln/WxTo5Ag+WHRq3qKEgaY8Vsrw10vRpE5PgT
         m7CpPAc3PASNvwQAD+qZOqed0SoHo37iHfu804ksjqqWA5EMmpDFWxFVNWaqBsO7zgy2
         a3dbBepBPWlet2/K9oeMMlYVKEPjCQAcBeij9wa4zgAgTtqlvixALHp98Rmln5ACPpAb
         rxlA==
X-Gm-Message-State: APjAAAWVTC6qrSvmivy5YK3oXba2hE4PGyFeqZkQ7rkvBNf0Rnad+f+1
        peyYiMTH5d/WAg9b7D00SJalkg==
X-Google-Smtp-Source: APXvYqx+sxov+O09urgAEctG0UgafcxBahdIb2LRrufCvHUYipe4rzdjWcB17x3lyxf+DQyswtdBig==
X-Received: by 2002:a05:600c:2054:: with SMTP id p20mr29850985wmg.177.1574076263632;
        Mon, 18 Nov 2019 03:24:23 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:23 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 39/48] soc: fsl: qe: refactor cpm_muram_alloc_common to prevent BUG on error path
Date:   Mon, 18 Nov 2019 12:23:15 +0100
Message-Id: <20191118112324.22725-40-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kmalloc() fails, we try to undo the gen_pool allocation we've
just done. Unfortunately, start has already been modified to subtract
the GENPOOL_OFFSET bias, so we're freeing something that very likely
doesn't exist in the gen_pool, meaning we hit the

 kernel BUG at lib/genalloc.c:399!
 Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
 ...
 [<803fd0e8>] (gen_pool_free) from [<80426bc8>] (cpm_muram_alloc_common+0xb0/0xc8)
 [<80426bc8>] (cpm_muram_alloc_common) from [<80426c28>] (cpm_muram_alloc+0x48/0x80)
 [<80426c28>] (cpm_muram_alloc) from [<80428214>] (ucc_slow_init+0x110/0x4f0)
 [<80428214>] (ucc_slow_init) from [<8044a718>] (qe_uart_request_port+0x3c/0x1d8)

(this was tested by just injecting a random failure by adding
"|| (get_random_int()&7) == 0" to the "if (!entry)" condition).

Refactor the code so we do the kmalloc() first, meaning that's the
thing that needs undoing in case gen_pool_alloc_algo() then
fails. This allows a later cleanup to move the locking from the
callers into the _common function, keeping the kmalloc() out of the
critical region and then, hopefully (if all the muram_alloc callers
allow) change it to a GFP_KERNEL allocation.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_common.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
index dcb267567d76..a81a1a79f1ca 100644
--- a/drivers/soc/fsl/qe/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -119,23 +119,21 @@ static s32 cpm_muram_alloc_common(unsigned long size,
 	struct muram_block *entry;
 	s32 start;
 
+	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
 	start = gen_pool_alloc_algo(muram_pool, size, algo, data);
-	if (!start)
-		goto out2;
+	if (!start) {
+		kfree(entry);
+		return -ENOMEM;
+	}
 	start = start - GENPOOL_OFFSET;
 	memset_io(cpm_muram_addr(start), 0, size);
-	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
-	if (!entry)
-		goto out1;
 	entry->start = start;
 	entry->size = size;
 	list_add(&entry->head, &muram_block_list);
 
 	return start;
-out1:
-	gen_pool_free(muram_pool, start, size);
-out2:
-	return -ENOMEM;
 }
 
 /*
-- 
2.23.0

