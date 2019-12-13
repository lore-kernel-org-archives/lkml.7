Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBE1C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3ABC2253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Dn0EjSQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbfLMAI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:08:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43726 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731676AbfLMAI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id p27so376950pli.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w7pZ7oO5cTd5jJHwXLM3afh3aM9gIcDEQ2gb9GDo3I4=;
        b=Dn0EjSQVnNf9x71ZhWZNtbHBchagWSgfo6KrF9WwWS7N+/3iyq9ryQIUE8bGa+Tc4N
         xCUS4gudBd1JMrtDhL7EI+qQamrfjVvjNcxovLxsSnU81NqkeYCGV7iEVMz6nBb60IKn
         DOI6O2Bg1SdaK++MAjgoHHYaDTVsqdfayBZ7jr7C+qkKrXUoiAbPYeE75isPI+yFvFEu
         dCEqy80NqK13alVnG54vSe9lH4/PGMaLB3QvAPtRjjQjj/jn9oczdk9Fnew9Q5nsdsXX
         cLgHI8uMhnDCuaYPrqI3I28zdTYL8LaJ/rGQVbQhvx7TJ1+30GawvpVTTeytKlFlEi/t
         89KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7pZ7oO5cTd5jJHwXLM3afh3aM9gIcDEQ2gb9GDo3I4=;
        b=od7qMMKB/UF2DlDEypp3/BwKvb/YYSQ9DyfFno5u+kDr+CfjJMerNFcaqBR7ayCCTP
         VsSvLdAg+snpaKmc918MtumTcAmPqpAZlUoU4MASn+Q3pqls4whAt8LhSeciMUpQTdPM
         mwkXD+dPAJqDNacnoLeF0m997DUnFeL+fr8jdd2UYgT6nT65GOFGUt3DX0h2A/L51q3j
         hA/i4PnhZ6qVWqBz0l9G9rXEoJthOuhWTMCHq9n6SnzLcJWaRfD4sTg9qG+ZBpxyFSgz
         pmpzQOZWDJRcMoqadzADVvC8eGLUzWMT1RJwIsBY47JT69dDuh7IYzlGArlSkPb1wXV4
         ewwg==
X-Gm-Message-State: APjAAAVk7KpDnMEdG8k7YKe1gCv6EkUmSupRuFBy5WxB1TB4ZS7+g3Fi
        LyshtA5qU17iUXUMXVJ/m8Z0l/7cPSk=
X-Google-Smtp-Source: APXvYqzA+oagxH5ZgfTkITXn7ZGmdQEu2sG7wvhevc9As1nHQkVrubK1G02SUzcHYwcMYYup4yADIw==
X-Received: by 2002:a17:902:7884:: with SMTP id q4mr12814553pll.285.1576195704882;
        Thu, 12 Dec 2019 16:08:24 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:24 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 24/58] tty/serial: Don't zero port->sysrq
Date:   Fri, 13 Dec 2019 00:06:23 +0000
Message-Id: <20191213000657.931618-25-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uart_handle_sysrq_char() already does it.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/mpc52xx_uart.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index ba1fddb6801c..af1700445251 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1378,10 +1378,8 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 		ch = psc_ops->read_char(port);
 
 		/* Handle sysreq char */
-		if (uart_handle_sysrq_char(port, ch)) {
-			port->sysrq = 0;
+		if (uart_handle_sysrq_char(port, ch))
 			continue;
-		}
 
 		/* Store it */
 
-- 
2.24.0

