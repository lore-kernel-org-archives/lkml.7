Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE4CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047CF20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fItgmMtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfCGKNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:13:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37555 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfCGKNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:13:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id x10so8584766wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 02:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lY5fme3k/AIN047HEtN16Hcq0nFOQyFwzBciIshWG10=;
        b=fItgmMtQYoRoAlSj4omNm/jYeERMEeY/EFrHZg53IaUQgWUPuRb/xap32+6XrbjKjA
         u6fzu3Awl8PIV6fVudBjS+plRt97qIuliwV9VUoceLyUATA3OkNcJHV/oZbYnUdJJKKr
         mBNtRboVw39EU5LKh/LnlOTBCpFqVzvva1byMElwWnt97vPM/1R6O1ZRGTuN0+NpnReQ
         j/HQJ/0oQAI/jbSe2e60XAydql/bpYIB2FgcIYKiEwMj2Ap6oNnI5v4X7lq+XqVFUBuX
         zKJ0QJwAVKuc7aIKjix4R8NG6PpHF6KcGECCZ9nHj69ZYJyltQ0MXX/f5IJK+TM7Ospg
         /u1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lY5fme3k/AIN047HEtN16Hcq0nFOQyFwzBciIshWG10=;
        b=E+4qbDaZmONgyHAYj0iXO2PqBmBKYNV7NruU64D7o8tz+SyF8F+TB3vanppxO02hiS
         fd/3uX+Lvihr+u35XKZsnmw9jJNTUf5tgy+NMm4VYbc+kg1qxAqdnNogLmQgdVuBj4Q+
         rdfv2M4YYc2ApeAw1n7iXnHSMehGYfflCbYbxWBvhvIXW9OMl1Wwci3R2gsICpErJaYa
         olGjPtqStiLOay4pGHwSTDKwQuFhn1NLN6dc5qvDaYvYC5ZAg5R7oh+2zhfmnDSzoy3u
         VJCFTHBOHX4bnhIe1WSMPeavbZ2xNduHYp0hzvhRIQdBppNaFItJKpCXnIzDMMvOQpR2
         L9Hg==
X-Gm-Message-State: APjAAAXjmePwUBC0JBYys+CZJmSQ7gWeCyjbdehcCLyb/to3c2qgMyMl
        fCZh4LwiVU7qmu3+Nswdotph2g==
X-Google-Smtp-Source: APXvYqxRoejhENWyuJzvrTe0w3e1gs5qp0+Co+BnpaPnNhE7CLd8pqebJCnjyhPaTnlGEpyf5kOfcg==
X-Received: by 2002:a1c:f70c:: with SMTP id v12mr5035977wmh.19.1551953601216;
        Thu, 07 Mar 2019 02:13:21 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id n9sm3529767wmi.33.2019.03.07.02.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 02:13:20 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        ktadakam@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/8] misc: fastrpc: take into account of overlapping buffers
Date:   Thu,  7 Mar 2019 10:12:27 +0000
Message-Id: <20190307101229.7856-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307101229.7856-1-srinivas.kandagatla@linaro.org>
References: <20190307101229.7856-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Argument buffers that are passed could be derived from a big buffer,
and some of the arguments buffers could overlap each other.
Take care of such instanaces.

This is optimization that DSP expects while sending buffers
which overlap. So make the DSP happy doing it.

Without which DSP seems to crash.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 112 +++++++++++++++++++++++++++++++++++------
 1 file changed, 98 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 209f3e63f660..17bbb017bb08 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of.h>
+#include <linux/sort.h>
 #include <linux/of_platform.h>
 #include <linux/rpmsg.h>
 #include <linux/scatterlist.h>
@@ -104,6 +105,15 @@ struct fastrpc_invoke_rsp {
 	int retval;		/* invoke return value */
 };
 
+struct fastrpc_buf_overlap {
+	u64 start;
+	u64 end;
+	int raix;
+	u64 mstart;
+	u64 mend;
+	u64 offset;
+};
+
 struct fastrpc_buf {
 	struct fastrpc_user *fl;
 	struct dma_buf *dmabuf;
@@ -156,6 +166,7 @@ struct fastrpc_invoke_ctx {
 	struct fastrpc_map **maps;
 	struct fastrpc_buf *buf;
 	struct fastrpc_invoke_args *args;
+	struct fastrpc_buf_overlap *olaps;
 	struct fastrpc_channel_ctx *cctx;
 };
 
@@ -300,6 +311,7 @@ static void fastrpc_context_free(struct kref *ref)
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	kfree(ctx->maps);
+	kfree(ctx->olaps);
 	kfree(ctx);
 }
 
@@ -321,6 +333,55 @@ static void fastrpc_context_put_wq(struct work_struct *work)
 	fastrpc_context_put(ctx);
 }
 
+#define CMP(aa, bb) ((aa) == (bb) ? 0 : (aa) < (bb) ? -1 : 1)
+static int olaps_cmp(const void *a, const void *b)
+{
+	struct fastrpc_buf_overlap *pa = (struct fastrpc_buf_overlap *)a;
+	struct fastrpc_buf_overlap *pb = (struct fastrpc_buf_overlap *)b;
+	/* sort with lowest starting buffer first */
+	int st = CMP(pa->start, pb->start);
+	/* sort with highest ending buffer first */
+	int ed = CMP(pb->end, pa->end);
+
+	return st == 0 ? ed : st;
+}
+
+static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
+{
+	u64 max_end = 0;
+	int i;
+
+	for (i = 0; i < ctx->nbufs; ++i) {
+		ctx->olaps[i].start = ctx->args[i].ptr;
+		ctx->olaps[i].end = ctx->olaps[i].start + ctx->args[i].length;
+		ctx->olaps[i].raix = i;
+	}
+
+	sort(ctx->olaps, ctx->nbufs, sizeof(*ctx->olaps), olaps_cmp, NULL);
+
+	for (i = 0; i < ctx->nbufs; ++i) {
+		/* Falling inside previous range */
+		if (ctx->olaps[i].start < max_end) {
+			ctx->olaps[i].mstart = max_end;
+			ctx->olaps[i].mend = ctx->olaps[i].end;
+			ctx->olaps[i].offset = max_end - ctx->olaps[i].start;
+
+			if (ctx->olaps[i].end > max_end) {
+				max_end = ctx->olaps[i].end;
+			} else {
+				ctx->olaps[i].mend = 0;
+				ctx->olaps[i].mstart = 0;
+			}
+
+		} else  {
+			ctx->olaps[i].mend = ctx->olaps[i].end;
+			ctx->olaps[i].mstart = ctx->olaps[i].start;
+			ctx->olaps[i].offset = 0;
+			max_end = ctx->olaps[i].end;
+		}
+	}
+}
+
 static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 			struct fastrpc_user *user, u32 kernel, u32 sc,
 			struct fastrpc_invoke_args *args)
@@ -347,7 +408,15 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 			kfree(ctx);
 			return ERR_PTR(-ENOMEM);
 		}
+		ctx->olaps = kcalloc(ctx->nscalars,
+				    sizeof(*ctx->olaps), GFP_KERNEL);
+		if (!ctx->olaps) {
+			kfree(ctx->maps);
+			kfree(ctx);
+			return ERR_PTR(-ENOMEM);
+		}
 		ctx->args = args;
+		fastrpc_get_buff_overlaps(ctx);
 	}
 
 	ctx->sc = sc;
@@ -380,6 +449,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	list_del(&ctx->node);
 	spin_unlock(&user->lock);
 	kfree(ctx->maps);
+	kfree(ctx->olaps);
 	kfree(ctx);
 
 	return ERR_PTR(ret);
@@ -598,8 +668,11 @@ static u64 fastrpc_get_payload_size(struct fastrpc_invoke_ctx *ctx, int metalen)
 	size = ALIGN(metalen, FASTRPC_ALIGN);
 	for (i = 0; i < ctx->nscalars; i++) {
 		if (ctx->args[i].fd == 0 || ctx->args[i].fd == -1) {
-			size = ALIGN(size, FASTRPC_ALIGN);
-			size += ctx->args[i].length;
+
+			if (ctx->olaps[i].offset == 0)
+				size = ALIGN(size, FASTRPC_ALIGN);
+
+			size += (ctx->olaps[i].mend - ctx->olaps[i].mstart);
 		}
 	}
 
@@ -637,12 +710,11 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	struct fastrpc_remote_arg *rpra;
 	struct fastrpc_invoke_buf *list;
 	struct fastrpc_phy_page *pages;
-	int inbufs, i, err = 0;
-	u64 rlen, pkt_size;
+	int inbufs, i, oix, err = 0;
+	u64 len, rlen, pkt_size;
 	uintptr_t args;
 	int metalen;
 
-
 	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
 	metalen = fastrpc_get_meta_size(ctx);
 	pkt_size = fastrpc_get_payload_size(ctx, metalen);
@@ -665,8 +737,11 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	rlen = pkt_size - metalen;
 	ctx->rpra = rpra;
 
-	for (i = 0; i < ctx->nbufs; ++i) {
-		u64 len = ctx->args[i].length;
+	for (oix = 0; oix < ctx->nbufs; ++oix) {
+		int mlen;
+
+		i = ctx->olaps[oix].raix;
+		len = ctx->args[i].length;
 
 		rpra[i].pv = 0;
 		rpra[i].len = len;
@@ -690,16 +765,25 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 						 vma->vm_start;
 
 		} else {
-			rlen -= ALIGN(args, FASTRPC_ALIGN) - args;
-			args = ALIGN(args, FASTRPC_ALIGN);
-			if (rlen < len)
+
+			if (ctx->olaps[oix].offset == 0) {
+				rlen -= ALIGN(args, FASTRPC_ALIGN) - args;
+				args = ALIGN(args, FASTRPC_ALIGN);
+			}
+
+			mlen = ctx->olaps[oix].mend - ctx->olaps[oix].mstart;
+
+			if (rlen < mlen)
 				goto bail;
 
-			rpra[i].pv = args;
-			pages[i].addr = ctx->buf->phys + (pkt_size - rlen);
+			rpra[i].pv = args - ctx->olaps[oix].offset;
+			pages[i].addr = ctx->buf->phys -
+					ctx->olaps[oix].offset +
+					(pkt_size - rlen);
 			pages[i].addr = pages[i].addr &	PAGE_MASK;
-			args = args + len;
-			rlen -= len;
+
+			args = args + mlen;
+			rlen -= mlen;
 		}
 
 		if (i < inbufs && !ctx->maps[i]) {
-- 
2.21.0

