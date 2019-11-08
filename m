Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EBCFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEA52085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ghv2Fitd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfKHND0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:03:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38915 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbfKHNCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:17 -0500
Received: by mail-lj1-f196.google.com with SMTP id p18so6130885ljc.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VA9GbHfmKtODbCm0QoKaPVG8lLjwOAvz4Dj0Clq1FXQ=;
        b=ghv2Fitdi+5CpOHryA/uKu7tvP1mIrcR7EQ6Boj2/RIU2+jYku8qiRim9NlU1bMI9t
         jibRIInuK9ovNCl4B0NJGdUU3ySNR4YSeno58I0x0vbag1VAvxIje3y/7NhG3ERCFGnp
         ox4wBxv0EYbYTQMQ1MAeNcI4UNMBZJ7Jq/bJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VA9GbHfmKtODbCm0QoKaPVG8lLjwOAvz4Dj0Clq1FXQ=;
        b=pJHdIPGQR2n8o1TSZTJqRmSa4by7rSU4Hnm5FnVGxOifkiukaVv3z3gCuopTNkS2zl
         LOZhfB86iU7yQRYo2nOaBq0p/xxUqIZfdjw6orDO8Qo8dEqzoMvI/rh/h5563fQbjjUq
         gUuqg25dfUWSze2fPFHLk91bJvAoXXZhQ0F3JiBJ7dQJjpYCwDYjPeZz73kGDZ5yZMcH
         rTX6JGqA2EDxKAii4B1yStDoYzdNcj/U8bWK5hh4C2thx7iaJUZtSRhmTj898nQxBiXS
         dO8nyTnA9OItAGbzMEzZJ2lx4tSMjYTRpyzOibGeMr9vpS37oJTh5I4OpPG0iMqEjW7+
         0Knw==
X-Gm-Message-State: APjAAAW2/QGO1kqAHa0t7aq+oWlPOMCDcEU+FfcXV8j2HsueMmkKYLJL
        0yeQ8TF/CtdUr89cqG460bVM0w==
X-Google-Smtp-Source: APXvYqyoMqCjl5BXnYcK2ml6PASxOb4ksaKGHBnk0QjLBR1ADRWrjlHrHrSVaMf4Baj7cALCi+3dFg==
X-Received: by 2002:a2e:9119:: with SMTP id m25mr6927156ljg.24.1573218135990;
        Fri, 08 Nov 2019 05:02:15 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:02:15 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 38/47] soc: fsl: qe: refactor cpm_muram_alloc_common to prevent BUG on error path
Date:   Fri,  8 Nov 2019 14:01:14 +0100
Message-Id: <20191108130123.6839-39-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
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
index feb33ec1c3d6..bc9b436684df 100644
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

