Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076BBCA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D436A222C1
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="GbMgHMlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504488AbfJYMlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:41:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33030 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440311AbfJYMlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so2574815ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N50Dd0BwKrCHAeZk4A17lzm64zQu/57ZOLH9CQ/zcnE=;
        b=GbMgHMlPuXicUd1jD2lMN2qhtRW8TtquRFBK/Ddk4tseiBp72B5kglvaqT7HytLeBz
         ERycsML3pLKiOMNp8blGqHqZt1010NyDGfn7LqQaBg6mJbO74s9jsmr3XhByikIXl+at
         RFzgtUIoBjMXP8kS9sv6NM1bEvcbXcMXINIIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N50Dd0BwKrCHAeZk4A17lzm64zQu/57ZOLH9CQ/zcnE=;
        b=KiZCBeZ5vjT4EryyqscTcrHl/QleVsZc++HZ0WlJrx5OMeqvfw/pTdL0AeycJXjEwY
         zXNtVG870rYQb4NSh/k25ZUrMVJWaT2fSJ5fQ4cXejsCTAMW32rY3ojqTWUavxZ0FeTY
         h2XcZR76w6AXmnkBLKVZEvSd0qUE8l6bBR4+KtNTwe7sfv4lCpsRAJ7HQxDFUf3aSHRm
         RwsPkSzRQUC6BmyUSg8VVjkC1T6GAYhc27FjzVJQwUdskrlXGdIIbmWc7xo/JEtwhf+s
         8vDDj6wgaen+KWbuxhJpWkHhoGmWhyqqQFYcKwoznN50/jpjoQY1fMKAuhMUru/YsKUN
         +olA==
X-Gm-Message-State: APjAAAUNyuyucin88WZKiUhx5rkR5Id2ii9ewe96ocUH8wvzlXb4S8PL
        /ibC31anBnxZacJPNf7ggymmzw==
X-Google-Smtp-Source: APXvYqwo2JfL7eIt5j0UGDMoCocGX5aXqxwftXfPdGyY5T7w8Mdcm7mXtiOPvL3zk+z+WGo8qCu+jw==
X-Received: by 2002:a2e:7815:: with SMTP id t21mr1151982ljc.149.1572007270677;
        Fri, 25 Oct 2019 05:41:10 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:09 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 06/23] soc: fsl: qe: avoid tail comments in qe_ic.h
Date:   Fri, 25 Oct 2019 14:40:41 +0200
Message-Id: <20191025124058.22580-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is consistent with normal kernel coding style and the style used
in the struct definition above this one.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.h | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.h b/drivers/soc/fsl/qe/qe_ic.h
index 9420378d9b6b..29b4d768e4a8 100644
--- a/drivers/soc/fsl/qe/qe_ic.h
+++ b/drivers/soc/fsl/qe/qe_ic.h
@@ -89,11 +89,20 @@ struct qe_ic {
  * QE interrupt controller internal structure
  */
 struct qe_ic_info {
-	u32	mask;	  /* location of this source at the QIMR register. */
-	u32	mask_reg; /* Mask register offset */
-	u8	pri_code; /* for grouped interrupts sources - the interrupt
-			     code as appears at the group priority register */
-	u32	pri_reg;  /* Group priority register offset */
+	/* Location of this source at the QIMR register */
+	u32	mask;
+
+	/* Mask register offset */
+	u32	mask_reg;
+
+	/*
+	 * For grouped interrupts sources - the interrupt code as
+	 * appears at the group priority register
+	 */
+	u8	pri_code;
+
+	/* Group priority register offset */
+	u32	pri_reg;
 };
 
 #endif /* _POWERPC_SYSDEV_QE_IC_H */
-- 
2.23.0

