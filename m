Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EB0C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD5F21771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Cu0pEa3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfK1O6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:58:16 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46230 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbfK1O6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:58:11 -0500
Received: by mail-lf1-f65.google.com with SMTP id a17so20229357lfi.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ApKAjcbgk3TFllS4KVlYulsx0IXhA9sg3keVA4kG7Kg=;
        b=Cu0pEa3DGH8Jq4DqyrRVVK+6bn2ungANZKmPnurdLgGvoCh7zh9ab2EKVG+2ifp9f9
         rF8n9op4NSmEteqozoQv7Ma5TFukZVpXhMk//1OFvFLfiiCXPFq6mIrgqPDMuC4k0F+i
         tPXfxNLVhzbivJVrd/o409oUcl06X8HPclCC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ApKAjcbgk3TFllS4KVlYulsx0IXhA9sg3keVA4kG7Kg=;
        b=VIE+GrRvBhHTgPiaj9e75PLwJXDe4PwMiUTdeT8BuGCoxCdspdglHhuxZr4wAPpG6x
         MfDQRnGSr0vwZrVEdU27GAzev1cdN5UeufoGipqMTR8V+WYCjOLhtFhiMHnVQ6LLVxJB
         TFzqNY2CeQfG49CwhFeDbsEb1nQhYlzdx2CJPvbv/KKhJdl56xztZH2tu/+yzU7k/2ZB
         PBnclaZJPmDFoqGKCMiwf9RP3CzlnvQdCMThGXvn7xnYH+yRhJF/r8v5AziG6lB83HFz
         CdhMrnKR8X8bsHaEptc7miDSZTxmmshYXVsn4hK/ZhVNo/IwlhB4h2/JNzQbA55zIW7D
         5WCQ==
X-Gm-Message-State: APjAAAXOnqTuWpF3N1w0G/y9QnsR8jUtfDrCCsHObpz3xYQKxitxTIYL
        oSHzlmy1OjZR0mcPWqbOXK2XIA==
X-Google-Smtp-Source: APXvYqwJ2pFRjS+aCBBi6M5p/vBXoIE7qINVl1Cxd1FpO3O+0xRHnhugtUuDHZc9+RuUfUWk5qB68w==
X-Received: by 2002:ac2:4adc:: with SMTP id m28mr8797486lfp.26.1574953087899;
        Thu, 28 Nov 2019 06:58:07 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:58:07 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 49/49] soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE
Date:   Thu, 28 Nov 2019 15:55:54 +0100
Message-Id: <20191128145554.1297-50-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are also PPC64, ARM and ARM64 based SOCs with a QUICC Engine,
and the core QE code as well as net/wan/fsl_ucc_hdlc and
tty/serial/ucc_uart has now been modified to not rely on ppcisms.

So extend the architectures that can select QUICC_ENGINE, and add the
rather modest requirements of OF && HAS_IOMEM.

The core code as well as the ucc_uart driver has been tested on an
LS1021A (arm), and it has also been tested that the QE code still
works on an mpc8309 (ppc). Qiang Zhao has tested that the QE-HDLC code
that gets enabled with this works on ARM64.

Reviewed-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
index cfa4b2939992..357c5800b112 100644
--- a/drivers/soc/fsl/qe/Kconfig
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -5,7 +5,8 @@
 
 config QUICC_ENGINE
 	bool "QUICC Engine (QE) framework support"
-	depends on FSL_SOC && PPC32
+	depends on OF && HAS_IOMEM
+	depends on PPC || ARM || ARM64 || COMPILE_TEST
 	select GENERIC_ALLOCATOR
 	select CRC32
 	help
-- 
2.23.0

