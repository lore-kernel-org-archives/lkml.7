Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649C9C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAC421774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ZNhCjhlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfK1O5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:57:16 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42444 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfK1O5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:14 -0500
Received: by mail-lj1-f195.google.com with SMTP id e28so4646633ljo.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1FO1UQTXh28fI62ubVME27vBFvBx/0Nlk287V+GPtYU=;
        b=ZNhCjhlXYdCo4kAsX4UTTimsvzqdgi2hv8plsAFFBTnJnb4euDfFWwFH4zxFx7MhZ+
         RbpYnU0P9tFXmZQP1mq9z+OrG5+RlE+3xdI7EhoVDAA+VVIPGMPTe8TwM2ppgKuG8LGk
         O1ZhnUDfTQ1fjCjBLJmqQ+eVOggVlMbYyMVqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1FO1UQTXh28fI62ubVME27vBFvBx/0Nlk287V+GPtYU=;
        b=a9HJOpDWRNw7uS24NLg0aDqxVNNm1zbNwrRJNVveYlp+hu7Fl81CL2kwSkAPWO7M7M
         onG6C7GJMih0f/vCiv21hoTzEz2uqWg60foWY4bjQ1oeqPP+6wHPYxAhrzTDpCB0sbKl
         l1GxXkDdUGseI6TRzJz0CdwYDHsslZc96NC7COQ0MdlDtOXYoQ6gVSCweH/M5hJRiCki
         iR6vIezQcI2KlS8zVAC4XM0JJ6U8n9EwiwrGLrF+MfdUZ+jzuGW0zjwrTF2kWG/kH3Ul
         P68vJ1gu1rPqbwixDjFVk7X35h5g00QKBy/QRcFp1bDD3TSVwfPZi+8nVZV/4NGkKyvu
         qtiQ==
X-Gm-Message-State: APjAAAUCNbNnXsc9BOm0CnW/eJUPF5tOqRV5p5+RZ6bQMR31J42J37YG
        W2g1m5rZj9oFdN14qn0NMZitBQ==
X-Google-Smtp-Source: APXvYqwWny19ndDBOcZFfoY6H4dtBKDtCID2hru7I1YwvHnyPzyw7kTW9NPWsf4LyhSpEJUZyub1AA==
X-Received: by 2002:a2e:9006:: with SMTP id h6mr34696274ljg.231.1574953032680;
        Thu, 28 Nov 2019 06:57:12 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:11 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 06/49] soc: fsl: qe: replace spin_event_timeout by readx_poll_timeout_atomic
Date:   Thu, 28 Nov 2019 15:55:11 +0100
Message-Id: <20191128145554.1297-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for allowing QE to be built for architectures other
than ppc, use the generic readx_poll_timeout_atomic() helper from
iopoll.h rather than the ppc-only spin_event_timeout().

Reviewed-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 456bd7416876..85737e6f5b62 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
+#include <linux/iopoll.h>
 #include <linux/crc32.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of_platform.h>
@@ -108,7 +109,8 @@ int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input)
 {
 	unsigned long flags;
 	u8 mcn_shift = 0, dev_shift = 0;
-	u32 ret;
+	u32 val;
+	int ret;
 
 	spin_lock_irqsave(&qe_lock, flags);
 	if (cmd == QE_RESET) {
@@ -135,13 +137,12 @@ int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input)
 	}
 
 	/* wait for the QE_CR_FLG to clear */
-	ret = spin_event_timeout((qe_ioread32be(&qe_immr->cp.cecr) & QE_CR_FLG) == 0,
-				 100, 0);
-	/* On timeout (e.g. failure), the expression will be false (ret == 0),
-	   otherwise it will be true (ret == 1). */
+	ret = readx_poll_timeout_atomic(qe_ioread32be, &qe_immr->cp.cecr, val,
+					(val & QE_CR_FLG) == 0, 0, 100);
+	/* On timeout, ret is -ETIMEDOUT, otherwise it will be 0. */
 	spin_unlock_irqrestore(&qe_lock, flags);
 
-	return ret == 1;
+	return ret == 0;
 }
 EXPORT_SYMBOL(qe_issue_cmd);
 
-- 
2.23.0

