Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E3AC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4392206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNxvj/kS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfHZH3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:29:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33866 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfHZH3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:29:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so10077390pgc.1;
        Mon, 26 Aug 2019 00:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kiqMdthucN5qlDDkHZdYC3nWxz2rbgAlylxLZ3Dr+rY=;
        b=aNxvj/kSIiyExBL7CtlLVJRWgoo7J/Qfzip24Dk2Z3Pwdl/chitwuAmnVuqezO1CRK
         aJnamMjJtAscSP8h1qCzqP8NxNF6/Z3q57QSeU/w4yjY8IrQ+OQ+nfCNxbPbQlhVs8zK
         9QnIV36qOB4NDj1LVHc91QbvE3lAcfWHJvkfEbWRXsAenrF4lWu3+S8AWpuaDYQ0BkMt
         itr86HuqdgC9HhyBMbRUZEHCo90Cn6fyPDHqPq7cK0nE/oyBguj9VBfmDFO44G7DUQf7
         MvPV76WUMxm95Fx+xIySlBa2KUGXyfqeNwGf1YtYmJzli+AESaA1LGhtawhpacr7uMU5
         aOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kiqMdthucN5qlDDkHZdYC3nWxz2rbgAlylxLZ3Dr+rY=;
        b=c52Zb8PcG2KNW2V1eb4oJ1mhDJDgxxpd3yjUnwxNmPcLvT9yKy8eYuFeOuv+Oz9jvX
         pBeotnRhtLXB5R8Cp9lF84bPYxsw9bDEMclxiS/0WjERRDfum2L0wYCHw1PL7/pikY2b
         V4mNqwT2FJQABXOMTgvkT4nJWhdJkKBvmAO5B1vQsRzPkwenMgsVr2ma4+w29wyQUC9l
         hHfRZvMvT1RKGzvRo/Cl/J/4PFbAdYb/1yTIUItEmliw3o38SGJufXh97U15gputwKv2
         KDy2LwiBmQBxCMcKEfPA7pOR+HgDjgT4puETtwpFp23Kqd+zdTYznBUMfiO4ZQ1npPZx
         CnMQ==
X-Gm-Message-State: APjAAAXV6iwGPnBAPPXp3S3t55D//Z+D7cTYkzOocHF6/XGiHzZ9VZgu
        VexuLhqLlHNyrE0e1rfAw4U=
X-Google-Smtp-Source: APXvYqwaEIFfOa5FDdNC/APLv1D0Js3Qz8PsRBDFkX8DIS8QlvZYPfuThCOhfw17POL4Xw+WoinefQ==
X-Received: by 2002:aa7:851a:: with SMTP id v26mr18339469pfn.238.1566804592041;
        Mon, 26 Aug 2019 00:29:52 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p90sm11195670pjp.7.2019.08.26.00.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 00:29:51 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 3/3] serial: sprd: keep console alive even if missing the 'enable' clock
Date:   Mon, 26 Aug 2019 15:29:29 +0800
Message-Id: <20190826072929.7696-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826072929.7696-1-zhang.lyra@gmail.com>
References: <20190826072929.7696-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The sprd serial console can work with only 26M fixed clock,
but the probe() is returning fail if the clock "enable" is not
configured in device tree.

This patch will fix the problem to let the uart device which is
used for console can be initialized even missing "enable" clock
configured in devicetree. We should make sure the debug function
as available as we can. 

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/tty/serial/sprd_serial.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index aead823c650b..c4d8c77c1261 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1103,6 +1103,16 @@ static int sprd_remove(struct platform_device *dev)
 	return 0;
 }
 
+static bool sprd_uart_is_console(struct uart_port *uport)
+{
+	struct console *cons = sprd_uart_driver.cons;
+
+	if (cons && cons->index >= 0 && cons->index == uport->line)
+		return true;
+
+	return false;
+}
+
 static int sprd_clk_init(struct uart_port *uport)
 {
 	struct clk *clk_uart, *clk_parent;
@@ -1129,10 +1139,17 @@ static int sprd_clk_init(struct uart_port *uport)
 
 	u->clk = devm_clk_get(uport->dev, "enable");
 	if (IS_ERR(u->clk)) {
-		if (PTR_ERR(u->clk) != -EPROBE_DEFER)
-			dev_err(uport->dev, "uart%d can't get enable clock\n",
-				uport->line);
-		return PTR_ERR(u->clk);
+		if (PTR_ERR(u->clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		dev_warn(uport->dev, "uart%d can't get enable clock\n",
+			uport->line);
+
+		/* To keep console alive even if the error occurred */
+		if (!sprd_uart_is_console(uport))
+			return PTR_ERR(u->clk);
+
+		u->clk = NULL;
 	}
 
 	return 0;
-- 
2.20.1

