Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB62CCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1B52067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="g0t9IWVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfKAMmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:42:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43793 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730656AbfKAMm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id j5so7132154lfh.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=td9IeMtAnKP3TNZfmfJvazvskLsY9wm2/Illqt7TzBU=;
        b=g0t9IWVbZwlbGUfe42OCviDf0Xj5nVyevQuGZEnMgLfjpAKphqtdzJEhNTgeJq19Rs
         0QW0lur2U4C7+Hqd9TQsEODQMXwvLaOL7OhWWq8OKpNrwLsasSUx0ZC0CwR+VUcfXMhS
         UHtbeWLwVKEc0aDg0l5XldrFFe/FaIduB+JGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=td9IeMtAnKP3TNZfmfJvazvskLsY9wm2/Illqt7TzBU=;
        b=fADex9c+Lv4UowyAX9EDAiJ1AMNsC3tr9fL2T+WHDdGhWZjWYXJsOVzaqVCIrsiPJE
         YzrpK/Te1nlZmwoB8rMnz/l1v0Pd+j7nCxIdFehyIO2k9X3NfmomHoVly9Yg9kO1vnkz
         6YHGJCiAnbe3q9hIUkqev5/Ei7BU0GGVf6hL36SYeLhIsMUWix9LEyXkp3g1UTZAlFp0
         ZZfc66p/6H/9Mc2gcrI4Jc2nICkX4Rnii4xe0GQV9yvOMWKfPcx8c7RKfjtNJ4HP1Uv7
         Io3YD6hdfC0ngOBFDTp9iCGHX25juyNF24nRlS35zpPJqGrQuIYo5Pu5FPaDAUhnQpMK
         Dsmw==
X-Gm-Message-State: APjAAAXksG+xyfm/kyOnG8sSozWsuugp/nByKX2bQ0UR7DQN9ugA8Vjl
        u2RB2EQFdEzJJLOvf5lzvRAQZw==
X-Google-Smtp-Source: APXvYqxY2laHtfFgtTJ6vvKR4Xn06GwjZhA2wuPw7Ipw9dAvLGzODcePDlA6j5DNpYqbyvnIVabf3g==
X-Received: by 2002:ac2:5967:: with SMTP id h7mr6973677lfp.119.1572612146522;
        Fri, 01 Nov 2019 05:42:26 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:26 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 09/36] soc: fsl: qe: drop assign-only high_active in qe_ic_init
Date:   Fri,  1 Nov 2019 13:41:43 +0100
Message-Id: <20191101124210.14510-10-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

high_active is only assigned to but never used. Remove it.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 8c874372416b..4b03060d8079 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -320,7 +320,7 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 {
 	struct qe_ic *qe_ic;
 	struct resource res;
-	u32 temp = 0, ret, high_active = 0;
+	u32 temp = 0, ret;
 
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret)
@@ -366,10 +366,8 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 		temp |= CICR_GRTB;
 
 	/* choose destination signal for highest priority interrupt */
-	if (flags & QE_IC_HIGH_SIGNAL) {
+	if (flags & QE_IC_HIGH_SIGNAL)
 		temp |= (SIGNAL_HIGH << CICR_HPIT_SHIFT);
-		high_active = 1;
-	}
 
 	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
 
-- 
2.23.0

