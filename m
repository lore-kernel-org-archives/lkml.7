Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374EDFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0931F2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="fk496dIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfKHNCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:02:20 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44310 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbfKHNCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id g3so6104829ljl.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SSxgB5KIjK5mxonoS/fefEEoV3TflMkJtsEIHhJIAiQ=;
        b=fk496dIkjJfWH0puX1BW4RjJCK7c9+JJhG6U1/TBsTulBpHSVx/cGc7sFqAR1iTMdP
         3zAZ/TuYQluQEe1pVxIJkHHxw9OOzJCOlbYv+gbMR/iAwaLh7N8FW415kYYBe+C4WJ5A
         /Kx/gFiuFB5pPYGCEIG3XIPCX/uSVcJG6J9u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SSxgB5KIjK5mxonoS/fefEEoV3TflMkJtsEIHhJIAiQ=;
        b=b7ueBRLwvJo6WfgbsAVeqKqAb+ZJGws08DjtGCGoVunD1BHp/wzCxY5mVgZRoZ+V6n
         eg8J1wR3yPm+BriwnzBzQAAqWFTS75ypoAxnRYUH37vWhfoeCAlCwElf9xmaR7B+zYyf
         qb46hLqkgoqkEuuAOM7FhGdWyKhTJl2KX0+QxINrtqatlir1OnIqyUSmeE/hCzlQbEjj
         HxFHoITaGmTxZ2jqurHp5EfqFnHqem1svP8wMPArNJaACeVvTh0LdlYqevvslmnh5WIj
         ObInYcLVKF9jFGN8RVWgTWpvCSdMFJbRuOpp+F48PsPovj6sZD9jE9OF3VF1/HJFYsJs
         0JYQ==
X-Gm-Message-State: APjAAAVPvPYYvuRvJWvzC9ZQ4y7r5b+KN1WqzkuZuJEq3fg9rxaOnx7/
        uU7t4XM8HabcdXtPa300pnw30g==
X-Google-Smtp-Source: APXvYqyN3aQ4nQtTkau8BsbSSPycHGak0w9LA6qtdzQsU05epYq+dRlpxU2naE9iUDHNYf8Cdc+Wdg==
X-Received: by 2002:a2e:98c6:: with SMTP id s6mr6115616ljj.235.1573218132535;
        Fri, 08 Nov 2019 05:02:12 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:02:11 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 35/47] soc: fsl: qe: make cpm_muram_free() return void
Date:   Fri,  8 Nov 2019 14:01:11 +0100
Message-Id: <20191108130123.6839-36-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody uses the return value from cpm_muram_free, and functions that
free resources usually return void. One could imagine a use for a "how
much have I allocated" a la ksize(), but knowing how much one had
access to after the fact is useless.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_common.c | 3 +--
 include/soc/fsl/qe/qe.h        | 5 ++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
index 50be59678903..ea9bef1d2c77 100644
--- a/drivers/soc/fsl/qe/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -170,7 +170,7 @@ EXPORT_SYMBOL(cpm_muram_alloc);
  * cpm_muram_free - free a chunk of multi-user ram
  * @offset: The beginning of the chunk as returned by cpm_muram_alloc().
  */
-int cpm_muram_free(s32 offset)
+void cpm_muram_free(s32 offset)
 {
 	unsigned long flags;
 	int size;
@@ -188,7 +188,6 @@ int cpm_muram_free(s32 offset)
 	}
 	gen_pool_free(muram_pool, offset + GENPOOL_OFFSET, size);
 	spin_unlock_irqrestore(&cpm_muram_lock, flags);
-	return size;
 }
 EXPORT_SYMBOL(cpm_muram_free);
 
diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index f589ae3f1216..e282ac01ec08 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -99,7 +99,7 @@ int cpm_muram_init(void);
 
 #if defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE)
 s32 cpm_muram_alloc(unsigned long size, unsigned long align);
-int cpm_muram_free(s32 offset);
+void cpm_muram_free(s32 offset);
 s32 cpm_muram_alloc_fixed(unsigned long offset, unsigned long size);
 void __iomem *cpm_muram_addr(unsigned long offset);
 unsigned long cpm_muram_offset(void __iomem *addr);
@@ -111,9 +111,8 @@ static inline s32 cpm_muram_alloc(unsigned long size,
 	return -ENOSYS;
 }
 
-static inline int cpm_muram_free(s32 offset)
+static inline void cpm_muram_free(s32 offset)
 {
-	return -ENOSYS;
 }
 
 static inline s32 cpm_muram_alloc_fixed(unsigned long offset,
-- 
2.23.0

