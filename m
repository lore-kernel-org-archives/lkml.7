Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDE3CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9612067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="f/fMT4qn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbfKAMnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:43:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43788 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbfKAMm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id s4so10091724ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rl5uwkPm7ODgb0mKXC73DMWhjRD0JTB3vFmrVrN5ZB0=;
        b=f/fMT4qnGn36cfXIZU+9WqU7PKzlWuxSvy4OA9GfJ3DZQNR+X8lpgyBQpBtHZWrDet
         MFY1GEto+tIwTd5AX3zlfaDcUnphDQQLWWrldQasSQxYPGiUvZHz4B4wbzR8n8Thxbg8
         kRKqubck2mt87Sb8mjWd21kRiGkeHA8bc+egg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rl5uwkPm7ODgb0mKXC73DMWhjRD0JTB3vFmrVrN5ZB0=;
        b=W5ZT0x43CPv2lzRK2f0wBhYv5cZXzpiFj9zCsf7P299rp6ZDLC88V2kwR/3rQhOQS6
         C4/J7aE6vPnxy0eTTm+ioAix/xPFCI95b3NIsX7bnFFfKXadOOdoSoS4Tgqq2T8ks3EQ
         DeRq1qWILSmYCjBNktx9X+vg0TDUROxUHnb8pt7ZCGHkQLdWjQ6c2t2spyxIz3p1WJoC
         MzAq9gZhP9al8FkkAeqtIiJu/iXH1Alt1TW/JRvEyVIWf8aMcCDkVIpC0AbdoSNOHiFO
         KI9ogYPRbHVygNwZGC6b+DzMpbkf8cSwrv9gE2ueDPqquuVrp+c4uIwkiDROU2Z7IvpC
         2Mkg==
X-Gm-Message-State: APjAAAVkwmRcGYhN+5khA1UvDV6JVvpVTy+q38J4mWrthQkxlpOy6vLr
        TOkOL/egAfyAnw/KgwXuMm04eKZOM1HfmiMI
X-Google-Smtp-Source: APXvYqwmyi32FUjiCLfaeVSLCItzNSl5u5Xct5wycLzlAxgtX29tMH2hvUooRJdJTIIrmknHbE9nxg==
X-Received: by 2002:a2e:b604:: with SMTP id r4mr1067016ljn.134.1572612175328;
        Fri, 01 Nov 2019 05:42:55 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:54 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v3 33/36] serial: ucc_uart: access __be32 field using be32_to_cpu
Date:   Fri,  1 Nov 2019 13:42:07 +0100
Message-Id: <20191101124210.14510-34-linux@rasmusvillemoes.dk>
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

The buf member of struct qe_bd is a __be32, so to make this work on
little-endian hosts, use be32_to_cpu when reading it.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index f5ea84928a3b..a5330582b610 100644
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

