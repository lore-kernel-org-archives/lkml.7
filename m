Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD0CC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4202D206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFGv0dcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfHZH3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:29:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41913 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbfHZH3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:29:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id 196so11227445pfz.8;
        Mon, 26 Aug 2019 00:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ov+j8dmklUbxH1qenI+7z+xzSttZ7JB7MnKJwaKTJ8o=;
        b=EFGv0dcMCI3fgqPBjiMdxArXroa1ewpXvEyMBiOLUddrgPjN4gKfGTnXIdkLJaUXuR
         +LmM4hxnP6jJVzax9gpVgB72YJ5E1JJ68w8d4BdEzNTUmJMSK75xqmuEc1JkKdNPs9nw
         kJ+iGovwyQ4/l2WxJuUxPSmKZFbSUwepSvFmsa5um2Vz4AkgYC8ThS2gRgOjia9OGDEk
         kVLE5JG+E1xgoyauQcsXPUaAVjcBLvpwCE3oPgObFnr9nf6MkL79dyamv4vQbTy6zO6R
         Nqbjj7ekpxKR1iY8LH89i0jf3/JAts0NGYO5DcpN4PBJcAilNQ7GdmbSdn7nu1mBxNQg
         X41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ov+j8dmklUbxH1qenI+7z+xzSttZ7JB7MnKJwaKTJ8o=;
        b=f7xFkFH0MpF/MyqVmBMIw8/JQIApDDc17WptClmiRMPN5EAGPTlI7FBgY3vuq9QyMg
         KYpNFLWtXfV9N3VHfMVgbRmav5Qjooo812P/aY8hruNEKVOGixjZBvgnk4tkrNkshAnP
         k9HlM42T4gAsCxmapCe8WefClg9UbiZLPYxmcqqFeAoxQALTub8mrdiGNpkDsSJn9n5U
         t8RKqybvmuefZYKGFa/ZLCQhqFqE0Ntec/tZkoIuRPediGaY2eI2fufQc4iIWaTxWY37
         ywS5S2ZhQqlzhfGeXd7O8Cd+c7LyXYg86JcILXe0vDWvMIXKPDL2naumHy6XWjG1WcPx
         cXcA==
X-Gm-Message-State: APjAAAWw65e/Si8NqGAGHOZIQ9XuK6j5pe3ZFn+seqHkSVd0zMTe4EkH
        fF6DpricS6ZU67nM3EenEKQ=
X-Google-Smtp-Source: APXvYqym4NFd6Y769WkEr5WabszGG4IuyyXbdj1m2MF6jYjLasneWerHXnq2IRLP4+4lTqbYnL+R8g==
X-Received: by 2002:a63:66c5:: with SMTP id a188mr15079458pgc.127.1566804586264;
        Mon, 26 Aug 2019 00:29:46 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p90sm11195670pjp.7.2019.08.26.00.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 00:29:45 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 1/3] serial: sprd: check the right port and membase
Date:   Mon, 26 Aug 2019 15:29:27 +0800
Message-Id: <20190826072929.7696-2-zhang.lyra@gmail.com>
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

When calling sprd_console_setup(), sprd_uart_port probably is NULL,
we should check that first instead of checking its items directly.

Also we should check membase to avoid accessing uart device before
its initialization finished.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/tty/serial/sprd_serial.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 73d71a4e6c0c..a3be4e2dd019 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -975,7 +975,7 @@ static void sprd_console_write(struct console *co, const char *s,
 
 static int __init sprd_console_setup(struct console *co, char *options)
 {
-	struct uart_port *port;
+	struct sprd_uart_port *sprd_uart_port;
 	int baud = 115200;
 	int bits = 8;
 	int parity = 'n';
@@ -984,15 +984,17 @@ static int __init sprd_console_setup(struct console *co, char *options)
 	if (co->index >= UART_NR_MAX || co->index < 0)
 		co->index = 0;
 
-	port = &sprd_port[co->index]->port;
-	if (port == NULL) {
+	sprd_uart_port = sprd_port[co->index];
+	if (!sprd_uart_port || !sprd_uart_port->port.membase) {
 		pr_info("serial port %d not yet initialized\n", co->index);
 		return -ENODEV;
 	}
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
-	return uart_set_options(port, co, baud, parity, bits, flow);
+	return uart_set_options(&sprd_uart_port->port, co, baud,
+				parity, bits, flow);
 }
 
 static struct uart_driver sprd_uart_driver;
-- 
2.20.1

