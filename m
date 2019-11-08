Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13F3C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8772F206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="O/6AGo/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbfKHNCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:02:52 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39445 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730945AbfKHNC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:28 -0500
Received: by mail-lf1-f68.google.com with SMTP id z24so1469371lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eoU6yRz6gH6qOWyRe/vJLGf2pgvTpCjyg96xNihJCPI=;
        b=O/6AGo/ZGsFlsmLzJdyEPO3mV8xhZwNRXLRrD1SwfTKq6IMDjQUNw7j0VpK1oVFyLL
         wc5e8wLviGXZ87K0ZB9XM3865S7c5VlogZhWCTbefzWUbe06CEYaPSev0sIHG2QmP0NR
         92+WT/4laZ948//hxG0mEeosoGrg8VxvjMNyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eoU6yRz6gH6qOWyRe/vJLGf2pgvTpCjyg96xNihJCPI=;
        b=C+rj40NVxZoZuCoSdXjxQvUTX3+tTs1z19qA++2cglvWlYhLbPgKjhS4SCM5Qym9l2
         OWrR/Yjgo1DaHUKBRRbIk+3ZwDsE9rh799LbMIuZDchwKX4NCjoX4DL+NfRn1FCcLEQC
         nNMV6+tWM/xTksJfJ6cYsxC3Kdwp3r9MOXFxr4l/ZAORwvfGSKt8a5WaleiWKkzMqwPp
         B9AJW+CuA0bDsWYm6TzmFETB8TGRWcpVc5TzuAQql203kPsOvTfOQPidp3FQ9srtBroK
         9Kx7RGdA4DgrKNBGlZB+RFaIfBpydwfMJiY3mYK3qUaeo3ZydpBr/3ZR4xverwy0sz+j
         qhrg==
X-Gm-Message-State: APjAAAVsi4zo53NL3Dr8XKygaa889f9GeE7jMRBf/pJC73enGxPXtbAy
        q0CtO/r7cU+faxEz39PkHe55Gg==
X-Google-Smtp-Source: APXvYqwxS6IOvsV8gHqknaTDjoYrWzUraN+5B9FEomuPHvbNlLsU0KSDBbHmOzMq8nrZpelvp/lTbQ==
X-Received: by 2002:ac2:5097:: with SMTP id f23mr6576512lfm.90.1573218146378;
        Fri, 08 Nov 2019 05:02:26 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:02:25 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 47/47] soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE
Date:   Fri,  8 Nov 2019 14:01:23 +0100
Message-Id: <20191108130123.6839-48-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are also ARM and ARM64 based SOCs with a QUICC Engine, and the
core QE code as well as net/wan/fsl_ucc_hdlc and tty/serial/ucc_uart
has now been modified to not rely on ppcisms.

So extend the architectures that can select QUICC_ENGINE, and add the
rather modest requirements of OF && HAS_IOMEM.

The core code as well as the ucc_uart driver has been tested on an
LS1021A (arm), and it has also been tested that the QE code still
works on an mpc8309 (ppc).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
index cfa4b2939992..f1974f811572 100644
--- a/drivers/soc/fsl/qe/Kconfig
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -5,7 +5,8 @@
 
 config QUICC_ENGINE
 	bool "QUICC Engine (QE) framework support"
-	depends on FSL_SOC && PPC32
+	depends on OF && HAS_IOMEM
+	depends on PPC32 || ARM || ARM64 || COMPILE_TEST
 	select GENERIC_ALLOCATOR
 	select CRC32
 	help
-- 
2.23.0

