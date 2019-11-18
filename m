Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67C3C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E27A2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WBqyJalM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfKRLYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:24:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54970 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfKRLYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id z26so16919950wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IVPif8k5ZIR6D+wGrwJyE64cs7Iq/Iy6NadbSzu369Y=;
        b=WBqyJalM20Pe2+yF9hF7XnXsYtxzLRnMRKlU7/1VgblKEWzSrmyIVbJGD8OkiIg0Vr
         UlmpxFxPN87KDhJ6En8fXOli2Zo44+zz6/W09vpd+Xsqljhn0yhFAzrYHuJflVOyQaS+
         z/1qNFcET4IUJ3z1szwXb0kXhrjHW7ZaUhJrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IVPif8k5ZIR6D+wGrwJyE64cs7Iq/Iy6NadbSzu369Y=;
        b=asTC1ydbUTIFnHItViNJy6REhEkcbAvg4gIRJF9FWljPCUoHSZmbCyHpPbWjHiUtzs
         iKnTfTN+hPeqZb3fdY/EGRIPruxP1uIlDpgnC6QCKTGbT97CkrO0vbbYkndXCvKU5CjL
         8lub3W3mZGlalD6pB2Fm1uDmt1560bvCeU1ArijASafYzAzmCE3tdxvkATnGnDvHfzoT
         G5NCQpo1j2Sr0UtzkRt5M2ugb+iy1NccrgSIxScHaGJxMxJpx1GtK5wVTTNHjbIDZi35
         faoxGpgSMjD0PMJmy9EogWQ/xt0TbdobTXrl945kK4KiW8vZBpDH/K+i9edXqsvZj77C
         VwcA==
X-Gm-Message-State: APjAAAXOgDzdAcjIkLlRqv2w1EuExYae5UEjCKDvBCudgJqpLfTOnTdW
        3W0sX3FfiI7pv4mMQel5nCzP4w==
X-Google-Smtp-Source: APXvYqwSHGVqPcUA7VYXWlj6j53pgDT3YUvH8UuqMAU+wb80v+JDgc+bHai2XLBSBsbTbd8M19jYXw==
X-Received: by 2002:a7b:c3d6:: with SMTP id t22mr29358315wmj.13.1574076256553;
        Mon, 18 Nov 2019 03:24:16 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:16 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v5 34/48] serial: ucc_uart: access __be32 field using be32_to_cpu
Date:   Mon, 18 Nov 2019 12:23:10 +0100
Message-Id: <20191118112324.22725-35-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buf member of struct qe_bd is a __be32, so to make this work on
little-endian hosts, use be32_to_cpu when reading it.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 9436b93d5cfa..afc2a5d69202 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -343,7 +343,7 @@ static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
 		/* Pick next descriptor and fill from buffer */
 		bdp = qe_port->tx_cur;
 
-		p = qe2cpu_addr(bdp->buf, qe_port);
+		p = qe2cpu_addr(be32_to_cpu(bdp->buf), qe_port);
 
 		*p++ = port->x_char;
 		qe_iowrite16be(1, &bdp->length);
@@ -371,7 +371,7 @@ static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
 	while (!(qe_ioread16be(&bdp->status) & BD_SC_READY) &&
 	       (xmit->tail != xmit->head)) {
 		count = 0;
-		p = qe2cpu_addr(bdp->buf, qe_port);
+		p = qe2cpu_addr(be32_to_cpu(bdp->buf), qe_port);
 		while (count < qe_port->tx_fifosize) {
 			*p++ = xmit->buf[xmit->tail];
 			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -491,7 +491,7 @@ static void qe_uart_int_rx(struct uart_qe_port *qe_port)
 		}
 
 		/* get pointer */
-		cp = qe2cpu_addr(bdp->buf, qe_port);
+		cp = qe2cpu_addr(be32_to_cpu(bdp->buf), qe_port);
 
 		/* loop through the buffer */
 		while (i-- > 0) {
-- 
2.23.0

