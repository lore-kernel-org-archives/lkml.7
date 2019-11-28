Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC7AC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDB721774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="da4NAHVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfK1O6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:58:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46831 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfK1O5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:55 -0500
Received: by mail-lj1-f194.google.com with SMTP id e9so28812198ljp.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L4hA4zEJWHs66Lwy24heYdX9pI+8KbPTU8eYDZ/QqTY=;
        b=da4NAHVb4/ZNRDjdsIzpZ6eBC190ajJKLA6grEN7ZG5F7RsAa84POPBq4Y87Q7auQm
         xRGGWr7p+8MbKeInnDDiu3EQ3GpQftYCTE4bdeQYkVNsMzUes1Xtm6O1Ec6zmFv7bnSN
         0yOz/L6VHetbifeISQ2w0sf4c+jZoGTDGlfoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L4hA4zEJWHs66Lwy24heYdX9pI+8KbPTU8eYDZ/QqTY=;
        b=NFT0yuXyTqg1pyI747rpBEV3gSfcJq+aHOk6NSNXBnCdx7249ZyM1Fzr83ygOoXxgt
         /J0pZTq1AOU+ihjDWWNRpRg25Jsg6ixWi4yidppEQbPWhIpnJJT71LkolpyRVWEv2PqM
         XrmvA3eZG0WuFgiIDyFSt4HdWP9/yMUm3v657zhiOZrPkIpcmx/56sSLywNySzCr6CiT
         5WL2i1nGp0Yu8FTbPSDvOgRYtsc1HGjdNRkOeXqN9fcGMVngB/r+nVLGkJ+7i16sXtt8
         +oBT84MRvZKiVBoOMFS/HeneW+2UTQRkIN1vEJ3iNd65ttQOs0XOEyYw2HtE/3RsHIF2
         zaDw==
X-Gm-Message-State: APjAAAUeVNLZ7ELoxWf52BCoNQGLbmg5sXoWSpCOWupo3V72hB+IEulK
        /GcV7b01KxHdLOOn4cmYH+nj9g==
X-Google-Smtp-Source: APXvYqwfABDko30317bMIKZ2QbVVstLAKjVquLP+ohBUzZYK0IJWt98nEGubG91JvI6olW9Wy2yv3g==
X-Received: by 2002:a05:651c:32a:: with SMTP id b10mr7947026ljp.132.1574953073001;
        Thu, 28 Nov 2019 06:57:53 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:52 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 36/49] soc: fsl: qe: make cpm_muram_free() return void
Date:   Thu, 28 Nov 2019 15:55:41 +0100
Message-Id: <20191128145554.1297-37-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
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

Reviewed-by: Timur Tabi <timur@kernel.org>
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

