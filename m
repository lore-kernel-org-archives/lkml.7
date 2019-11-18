Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6A8C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBE22068D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="J+Cxwki/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKRLXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:23:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42663 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfKRLXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:23:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so18979626wrf.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KoynnpqyM2T+oZqn3mX12olVYK6D1zjkp8rnCkTSUvs=;
        b=J+Cxwki/d2vafcsbRwzl1HC83/TeBwTy77THog0ctYpfI5nCMfU4IfEqfaZQh+0bjG
         Xr1AOxQ32n7o4XT4k/aiXq2NvB3mbfP+nzB82GzwilkSnj9tGbzRnO+X7p9rVSu6Am8p
         xXAXPP5Sm8ROdcRFtRf8iiXcAVOxWac3eyFac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KoynnpqyM2T+oZqn3mX12olVYK6D1zjkp8rnCkTSUvs=;
        b=BW7EUnmxIe5EGc1yjf04r6inym5YSRSXM7Snc4GrWDIKSSs9mARp7Qh/6rFcAdqiB2
         /0A5SjwUDAKLnArVovBmhCJpbxmgBqA6hdqbx/voNhmimG/IHfz6LWdfQM3aDZ9fY8nu
         2yAzzBOW3rYeD9IlWUFvYgJQrXro9iMxgJatsqK/XLF8QYReTKRvYhR9Qf4J27RHOKdf
         Y9Fy1gP8MqgemqSjxION6QRMb082//k34oT6aofXOnECU+Rf7CAQ9F+UXfSwYe+lMR12
         qUQBCNw4SpB2EFXlIWyjut12N+6c5W36AKvmRy/8fxS2JLDsjyLBj+h0Q5mUeLWHNdd1
         0o+Q==
X-Gm-Message-State: APjAAAXKxyuHruCFtMZ5cat3xO6GfEsG7MScRkIdbjlq2gCo7DrEllvm
        F5c36riGWHfFnobq7XqmDxQqIw==
X-Google-Smtp-Source: APXvYqy5y/Lw0eRYVC6/15L8Sq6tO9dk7Qd7al4TRo3JfHEzvHz7TQFlCEhubCymAKhBxCKBg9+97A==
X-Received: by 2002:adf:f048:: with SMTP id t8mr14008877wro.237.1574076215200;
        Mon, 18 Nov 2019 03:23:35 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:23:34 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 04/48] soc: fsl: qe: introduce qe_io{read,write}* wrappers
Date:   Mon, 18 Nov 2019 12:22:40 +0100
Message-Id: <20191118112324.22725-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QUICC engine drivers use the powerpc-specific out_be32() etc. In
order to allow those drivers to build for other architectures, those
must be replaced by iowrite32be(). However, on powerpc, out_be32() is
a simple inline function while iowrite32be() is out-of-line. So in
order not to introduce a performance regression on powerpc when making
the drivers work on other architectures, introduce qe_io* helpers.

Also define the qe_{clr,set,clrset}bits* helpers in terms of these new
macros.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/soc/fsl/qe/qe.h | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index a1aa4eb28f0c..9cac04c692fd 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -241,21 +241,37 @@ static inline int qe_alive_during_sleep(void)
 #define qe_muram_offset cpm_muram_offset
 #define qe_muram_dma cpm_muram_dma
 
-#define qe_setbits_be32(_addr, _v) iowrite32be(ioread32be(_addr) |  (_v), (_addr))
-#define qe_clrbits_be32(_addr, _v) iowrite32be(ioread32be(_addr) & ~(_v), (_addr))
+#ifdef CONFIG_PPC32
+#define qe_iowrite8(val, addr)     out_8(addr, val)
+#define qe_iowrite16be(val, addr)  out_be16(addr, val)
+#define qe_iowrite32be(val, addr)  out_be32(addr, val)
+#define qe_ioread8(addr)           in_8(addr)
+#define qe_ioread16be(addr)        in_be16(addr)
+#define qe_ioread32be(addr)        in_be32(addr)
+#else
+#define qe_iowrite8(val, addr)     iowrite8(val, addr)
+#define qe_iowrite16be(val, addr)  iowrite16be(val, addr)
+#define qe_iowrite32be(val, addr)  iowrite32be(val, addr)
+#define qe_ioread8(addr)           ioread8(addr)
+#define qe_ioread16be(addr)        ioread16be(addr)
+#define qe_ioread32be(addr)        ioread32be(addr)
+#endif
+
+#define qe_setbits_be32(_addr, _v) qe_iowrite32be(qe_ioread32be(_addr) |  (_v), (_addr))
+#define qe_clrbits_be32(_addr, _v) qe_iowrite32be(qe_ioread32be(_addr) & ~(_v), (_addr))
 
-#define qe_setbits_be16(_addr, _v) iowrite16be(ioread16be(_addr) |  (_v), (_addr))
-#define qe_clrbits_be16(_addr, _v) iowrite16be(ioread16be(_addr) & ~(_v), (_addr))
+#define qe_setbits_be16(_addr, _v) qe_iowrite16be(qe_ioread16be(_addr) |  (_v), (_addr))
+#define qe_clrbits_be16(_addr, _v) qe_iowrite16be(qe_ioread16be(_addr) & ~(_v), (_addr))
 
-#define qe_setbits_8(_addr, _v) iowrite8(ioread8(_addr) |  (_v), (_addr))
-#define qe_clrbits_8(_addr, _v) iowrite8(ioread8(_addr) & ~(_v), (_addr))
+#define qe_setbits_8(_addr, _v) qe_iowrite8(qe_ioread8(_addr) |  (_v), (_addr))
+#define qe_clrbits_8(_addr, _v) qe_iowrite8(qe_ioread8(_addr) & ~(_v), (_addr))
 
 #define qe_clrsetbits_be32(addr, clear, set) \
-	iowrite32be((ioread32be(addr) & ~(clear)) | (set), (addr))
+	qe_iowrite32be((qe_ioread32be(addr) & ~(clear)) | (set), (addr))
 #define qe_clrsetbits_be16(addr, clear, set) \
-	iowrite16be((ioread16be(addr) & ~(clear)) | (set), (addr))
+	qe_iowrite16be((qe_ioread16be(addr) & ~(clear)) | (set), (addr))
 #define qe_clrsetbits_8(addr, clear, set) \
-	iowrite8((ioread8(addr) & ~(clear)) | (set), (addr))
+	qe_iowrite8((qe_ioread8(addr) & ~(clear)) | (set), (addr))
 
 /* Structure that defines QE firmware binary files.
  *
-- 
2.23.0

