Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB69C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B4D20748
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bV6Z9fOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKRLYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:24:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42800 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfKRLYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so18983570wrf.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZltWz01c8oCLmnoDvGrjVYpDxnidbYU1IX5rZmzZKUE=;
        b=bV6Z9fOx1VItspILAPRI5W8VOzo91dJcPE/eE8sUJW2P4w2Ur80bjp3SPzzP/d4z/E
         MNBEe1oPE/Q4EqZMdrWa8+KFp0Tesxe54lIFXB7D363t3pkjemC+wSS4s6kTqXeCXtQW
         aUbLE4f3qMlzjD6rC/R3oG1YYH6Zub7/X+FKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZltWz01c8oCLmnoDvGrjVYpDxnidbYU1IX5rZmzZKUE=;
        b=ZSNxmA6tsnuyg3WQFjmVOm+n9gPrdglOO200LSTw4xd0Y7ZZXUjyl3gjC8G6PA6hKg
         9Mzr/Ojhn0GrWJCFCPfo1sBGWgdWlANIDLfVLsmBzvV61IfqAP/mIFqEN0NFkL2IIQn3
         WM3nodLsYgBHy5Gx+fapBsxiwqeGvZrAFNW7kE17yz5W7uBpT62k+gUPiRYU6jokcO1F
         xf0b1K7g54hitF7jkyP7fxMDJtqZ5RI9mXKv32sYGfG4PG5MOr4tGzMZSGGwIt6fV8UV
         XAlio6BuB+yjv+jySHo/xI/Jkg4k5EQTsqRSqpL57Kp0GSbHu6tBn6dmPwTtuJYgK/tS
         S9aQ==
X-Gm-Message-State: APjAAAVfTn9d63RQTE6Qza8mc+uU0YSbgo+MptBD/8pZgfSKE3DrWQDO
        eZ8wxJH6SIq8GDV+RqxqxDVGSA==
X-Google-Smtp-Source: APXvYqwv5rLwOET/SNGVGrdd9i02wz6KfyE1CgBtoScH76g/+bIKbBO7+P1A77J80UsjXI2JMZ20tQ==
X-Received: by 2002:adf:ef51:: with SMTP id c17mr16069888wrp.266.1574076274319;
        Mon, 18 Nov 2019 03:24:34 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:33 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 48/48] soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE
Date:   Mon, 18 Nov 2019 12:23:24 +0100
Message-Id: <20191118112324.22725-49-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
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

