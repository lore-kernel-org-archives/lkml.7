Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62D3C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B6C24680
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="pBO83T+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbfLMAIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:08:47 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:42650 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731369AbfLMAIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:44 -0500
Received: by mail-pj1-f67.google.com with SMTP id o11so336280pjp.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Er5nAZa0dzjPGmbpRmr/URcdpkFHKxX1ZKta5byo+BA=;
        b=pBO83T+3pLGQIG/lo6bFoz3CUjfvRFotL/CE9Az3B2XbEMhTbp5PLKYjAfoPEB59vG
         2O/Zb2NN55/9N+nZmWeNlYp6Oe8nfM6fsSMmX8PTAhDYuqlPfhNP4mKs72qMKmPPrbIx
         FroUhUeinf4yNuUDSVTwcyDaHsbQsmcKQHadhavR4Q/K4Ythj3VCPcDC2t/lX+djVWGb
         FJvI5rWb9ge9+7O5dOjCdbau4XrTsCJqZhcPniOAiTcyOXRklo0qM2XUVtqr7yEl2jwF
         e0oa/s10DoYmA7d/8PvJ4sP5ApdnsU35p4NUC4vRnyOX5JMGGyKH9dHSmHZjr6QvqiaG
         2VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Er5nAZa0dzjPGmbpRmr/URcdpkFHKxX1ZKta5byo+BA=;
        b=BEk+dWaq+uOJbHTU3LN+6NAUTkgKGJ8kbuK5fhzS8OILJ76FwpVChTsKA7vJoyOMth
         AGk8YCwRt2JtSipevyoNCflm+C4UfBT38uI6i2yOHwix4Qe1zmTcXXDi5jnlWD5efHzA
         qtuDXdm7BHSRrIjsWuWGJY8XJrR+4j7eIIqvxiWkvitxwX4IuQkhIZ+4i5uKUSLO4KV8
         f0k6RqH5RZOUMTnlH5kUjGvJGipWUkTmIhPPohgtmdsLIgnKmN4ZM16XMzcrZWwY3BHX
         EkIKiszfS0IUI8wFz2eURBp9l/Yo/LTYdmzvaPTkhSboEfAjqTM1Kb5jHrc5nRPU3uEZ
         NLQQ==
X-Gm-Message-State: APjAAAXzymAtEYwlNRonllGFT7YoA1ZEi0CpCo2bJ7xRxMLDAruRjjFV
        RvQw6Jr69u18+mdbgVecxTsf5Vcss90=
X-Google-Smtp-Source: APXvYqwB3D0kINS7nIHxvaSLTZkj+rB5xcPZkkmxepOINemcjk0j3BsedcI0tT2o8OES5EGFzhUJVw==
X-Received: by 2002:a17:90a:8989:: with SMTP id v9mr13191061pjn.119.1576195723176;
        Thu, 12 Dec 2019 16:08:43 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:42 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 30/58] tty/serial: Don't check port->sysrq
Date:   Fri, 13 Dec 2019 00:06:29 +0000
Message-Id: <20191213000657.931618-31-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uart_handle_sysrq_char() already handles it.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/pch_uart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index c625bf7b8a92..0a96217dba67 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -584,10 +584,8 @@ static int pch_uart_hal_read(struct eg20t_port *priv, unsigned char *buf,
 			if (uart_handle_break(port))
 				continue;
 		}
-		if (port->sysrq) {
-			if (uart_handle_sysrq_char(port, rbr))
-				continue;
-		}
+		if (uart_handle_sysrq_char(port, rbr))
+			continue;
 
 		buf[i++] = rbr;
 	}
-- 
2.24.0

