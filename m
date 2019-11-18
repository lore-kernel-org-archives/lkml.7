Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F005BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44CD2068D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Rct02fRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfKRLZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:25:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35733 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfKRLYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id 8so18379058wmo.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eE07ibGSDrEk6FGW5gzY56tX8GUaE+lcVDXiPEzKSX8=;
        b=Rct02fRbEV75Q68bIBJnNMzHc2dQompqDFFv9haZQOUWM9Lvn4Mq8BNiD1zfZD+J/6
         epPCO8pxqXOY4dqGXzavSIAp7alvhE+YUzcbnZRmd3AgorgJrbU9IOStLtIpKTMhQh4s
         ARaj8jMTLks1vZPiYZ4PuL7eWSvpabN1VfSCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eE07ibGSDrEk6FGW5gzY56tX8GUaE+lcVDXiPEzKSX8=;
        b=g6vMSzkM/Bbn1r9am2gXuEXrD4Qw9coVE3C91Axeut8yl0ukeBNU/NgPfwWLLgKWRd
         qG2zS2CEwMpVZcphwcwp4HL8Fgu+XVL83EOBAKkCrUydy82AbEkV7d9Zfw30IHHAhRBh
         qOGwfmPOO8cjx51O8H397XbeIzDplXAlhbT6S0f+XBOi61vcQqqb7ynSbg0Vx2XcToJI
         tPn0ErjuI6aG7l6kMrDO9RE4CZ+2IVySZSMJcMKXTOyg4NNtQMjd8mjXgLmhlJxVMMB9
         j6KZ4vZbN0iMXWnZvmpeto+TLAwLrPvqDZs2avwxpIiIkrySQZnwyj+zdREGPtb59PQh
         2YlQ==
X-Gm-Message-State: APjAAAXahDVOjQ9INiyp6Tt9qPLjyQa37RMlPo8RSIiqG8VX3mvX/9bO
        EJI2qv+DX+XRtg+fLg+7ichyMw==
X-Google-Smtp-Source: APXvYqyA4aLZb9WhkWPOJwV8B2AwkWpU3y58LlCtzGy5k1rBPDFTwthAyOojKHmhWtaSRCahOyGBuQ==
X-Received: by 2002:a1c:6144:: with SMTP id v65mr29456811wmb.53.1574076258820;
        Mon, 18 Nov 2019 03:24:18 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:18 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 36/48] soc: fsl: qe: make cpm_muram_free() return void
Date:   Mon, 18 Nov 2019 12:23:12 +0100
Message-Id: <20191118112324.22725-37-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
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
index 84c90105e588..962835488f66 100644
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

