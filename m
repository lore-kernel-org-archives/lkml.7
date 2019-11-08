Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A395FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1ED12085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="arBXPaYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfKHNBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:01:36 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39976 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfKHNBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:01:35 -0500
Received: by mail-lf1-f67.google.com with SMTP id f4so4411803lfk.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KoynnpqyM2T+oZqn3mX12olVYK6D1zjkp8rnCkTSUvs=;
        b=arBXPaYvk7b9VQYEk27Lbsm2eaj47OMjYlVYaqSiH0ymjHtJ0z8jMJOs56Fvd8UuBJ
         NKk3dJoZqQrq8Qd6neEX/y/JOno76+Cbx1L38NbXMark/8C5i8DIGjC8HDXiz6AkmhZZ
         Zs4D4v6HFqp/TvlK8kAms9Xw0N+CDuG7slgBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KoynnpqyM2T+oZqn3mX12olVYK6D1zjkp8rnCkTSUvs=;
        b=WNW/xkKFbtNfmMIEjJumaBcpmyCxDNRqefYAgWfmNs6woJ/7DXZY7g5NNDpyGlr0gR
         15pATndEzJvY5Cw8u8jsO1bH/5dwczEp0boOkIP8Kei9mqSOFEUkOXBWoKMeumve0vJU
         qxdxhkm9tBTc9nW0r4SmhPQPYC8XJLdJI+DjeAQQ5inZWBJ1coN3NyQep4atkQ6q9L+I
         UFhqB3vNTmrgVyCCTsZPelnGonbrewYMyA3KFvuyYzYmJsXI7ps6THIJfrPXVp52iHVf
         X0dftZ09paQbNW0triHpYlHWF5m6hFUnHXcuFXARmwZqx1QJKR37TuF3MEbTCcCe72UY
         Ki+Q==
X-Gm-Message-State: APjAAAVk4RgBo5bECKZH/5Fdc9YJfKGu9nZLQwUsrkl5dwO1lnhuFuUP
        bAF4KdG9SPCVBT/4MGExqb96Yw==
X-Google-Smtp-Source: APXvYqw8ntNr9Y7KtuD0WwqwQ/l6wehUmvqisdSJSXgT0uYQXoY9XMkvlc3TmtbKf6RhjcbTykfXxg==
X-Received: by 2002:a19:f107:: with SMTP id p7mr6501640lfh.91.1573218092860;
        Fri, 08 Nov 2019 05:01:32 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:32 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 04/47] soc: fsl: qe: introduce qe_io{read,write}* wrappers
Date:   Fri,  8 Nov 2019 14:00:40 +0100
Message-Id: <20191108130123.6839-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
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

