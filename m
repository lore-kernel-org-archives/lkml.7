Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252EDC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F6820895
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bIXhboGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfKRLYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:24:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35702 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfKRLYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id 8so18378352wmo.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=skc4BB3FfJVhrMQufim0pPb5lTLStBal+/ZiI3PgHrk=;
        b=bIXhboGAOfHEuhy5XNvLSkt/v8AbF7er8M7+DnbVSRGu/nfzVD9BIZMY9lvVjK01yq
         x4OwM95DdJqvHHmAn2AEIZpahfvZGZTl5VI+0W8Nii1hH0oJGGfoxnKmw/9+dD48TPoO
         1EZMF/DjpiyKhwbirwHabUH+m5MatGIRUQD+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=skc4BB3FfJVhrMQufim0pPb5lTLStBal+/ZiI3PgHrk=;
        b=j4MQn/ETzKdReUr5rz9mhhMhZlhSIhB7WDdIBZF1Jcjz8k7ghoF9SSEpS+71oYcOjQ
         JlXonVgHgxW4pCM5PVP647tKAH+76LH5w71acLSJDQQ/D2L+9QBfmkNWnNUuuXllFOTf
         lGgsNIUU7M42MfdDbSmBQt3y6gD03rsB+fAcsmNalLU4hUyp3p9+tf+7rODHEyLr9Jzx
         bKqytmH3Pt1WPeUuI0zTfr0lNGWGkVt2b0pLBWa86IFZIXsiJBF85rChpl3XZHDg+moI
         4mbyAF7V7Ci8VzjF08EqQGInVpd4uZzha/Yj3Um/qtS4PeHtDSV2rv1C9+S+tCkMAsLg
         6mBw==
X-Gm-Message-State: APjAAAX85onx3IYdU8aGGoMivg6bV/6F0N7PB7URUiFHiS8Etp0/q2du
        r9gxtfgojr5JXCxyCb2z7Wq5ww==
X-Google-Smtp-Source: APXvYqzv/wXIsjaRbMxH9N3IlxmKxJic89M7wV8bzm0V/mj0kc0XrptcV3zjVvdAWMEcHYldq3xfjg==
X-Received: by 2002:a7b:c768:: with SMTP id x8mr29728216wmk.26.1574076247328;
        Mon, 18 Nov 2019 03:24:07 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:07 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v5 28/48] serial: ucc_uart: explicitly include soc/fsl/cpm.h
Date:   Mon, 18 Nov 2019 12:23:04 +0100
Message-Id: <20191118112324.22725-29-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver uses #defines from soc/fsl/cpm.h, so instead of relying on
some other header pulling that in, do that explicitly. This is
preparation for allowing this driver to build on ARM.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index a0555ae2b1ef..7e802616cba8 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -32,6 +32,7 @@
 #include <soc/fsl/qe/ucc_slow.h>
 
 #include <linux/firmware.h>
+#include <soc/fsl/cpm.h>
 #include <asm/reg.h>
 
 /*
-- 
2.23.0

