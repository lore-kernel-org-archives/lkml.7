Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF15C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0857221771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="JgiuAeAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfK1O6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:58:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36947 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfK1O6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:58:00 -0500
Received: by mail-lj1-f196.google.com with SMTP id u17so1465163lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=06uKXQqvrr0zZOJsLmQ0X59rlZ+fACJwVhesQKP6zWk=;
        b=JgiuAeArS47wsHZWM0BK/bezVFi7ZvWamm9FoPUC9tdZMXp4VCy5jWfx2t686hMUOy
         VybX+a/F0IKQZSS1QHbM5u49tyQhqGGkkQnWZHi/zYpbIT20YQl0gPFiNwUmHSxFIuiI
         9dTQWrvv9HWzBW01vfuUWbyvYrzaWvZFOcIyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=06uKXQqvrr0zZOJsLmQ0X59rlZ+fACJwVhesQKP6zWk=;
        b=IbOB36sGBLHMnhD0Frz/IVmqLR4kXWUy15VWDZSlbw8Q8ChXRI1xqOzxjn7MbSZLO8
         eDQ9rsqv+uvSfxEp6WWFgme3r717S7C+0Fd9xxIqdfdQHGBiC4bKzVTatFKPfFqR0KLy
         7S9l5ztxCBz9OwmjSRQPej2FblMy7WdBruYWsm6d5dp8sohkDBDZMjCYVBWx4sHu5wR/
         /RA389oNiroXS+SwABCgt/6nPZZUyqTsJcUrLhzGhx6j+guoC7UemJFP+uhDmKqckOUQ
         C80PKw8deYqNs3DAFkRZ+G0QwORLynJYe32m8Ng79T+T9ngTqSgyMApMmLPWkVe67JR4
         0qPw==
X-Gm-Message-State: APjAAAVwMiOPsGM4J0nZiQDUDfh1VQ5JSUR8S2kI9z2BovhS+ygL/2Wk
        ROffhG3Da7udluq7cqAj30B6AMeGCjy/g3F7
X-Google-Smtp-Source: APXvYqyK7wVR6d3zwjKZ2mFM/WM8Cw60uivy1/bMNQ6D4J5Uyd1DQ6s5FG/7hVfz49aG1uqyrcyxDw==
X-Received: by 2002:a2e:2a43:: with SMTP id q64mr35566264ljq.242.1574953076393;
        Thu, 28 Nov 2019 06:57:56 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:56 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 39/49] soc: fsl: qe: refactor cpm_muram_alloc_common to prevent BUG on error path
Date:   Thu, 28 Nov 2019 15:55:44 +0100
Message-Id: <20191128145554.1297-40-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
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

Reviewed-by: Timur Tabi <timur@kernel.org>
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

