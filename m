Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF582C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806412073B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="mtt3Y0wv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbfLMAKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:10:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39202 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731923AbfLMAJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id b137so539489pga.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rwaCDvP2SQj1o7uheLZnVseeTUqUJ8P4h6n2JiZ/MC8=;
        b=mtt3Y0wvBSEMysIfrMk21rxnUIraMTD+Q2MiUnnOxDxcvAI5UzsT0AFnONaANjmJ7Y
         0F1mI93iI+Sr//gNJdLr8VX9AitSNRFruoNzmjPeUKTfhlR2dCuvzIiVPWFadPbVIR0y
         3N73E1M5tTsMiYdJvdGgpCBKw33Sav5QnZ7D1BaKSCQ/3Dm3xSPDcq57/bclYG20sP0d
         wFtwtkgTweKV9IZDBwXYbrdwnDwzTEVdWV0hWeBZrG3Qa17bdcOhJI3pHeaCn7uIPJzd
         hF0D+wjcGyklIJD+6U8afW7hUS27sZW2Py754cEj0ssixlqD4qMXYPQT0IdTBzigUdWJ
         Csdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rwaCDvP2SQj1o7uheLZnVseeTUqUJ8P4h6n2JiZ/MC8=;
        b=tPYxCGFO/ju8i/Pw8U+afLq4fAaBgqGR3zRnU+mWPzY4QnHR0B4BuCJy0KnCAZVdj3
         4IzuJYM6ZUh/1pGCzASG8BvAODrDCzfbIs09pMX48kwEgG+LKMNhRckPWmxJWzVVdphW
         tetCXwj5hOED7TT+6CQatb60ptwkDEN2rb7OPJYO27+syO9qjoZvl3RmBS4ZTMc29UJq
         usSaaiOFwPYyakLXTgo5c2BS65oGXGs2j4jvaqvSoLGgePwOuEMlh7cvejQe9AopymCm
         eQcXgOgrDlK739hduHqO6I44RJQkx7RlHXTUXIGW3SgupXYdlHckzccPkQ1ZYMAUphKQ
         xjAQ==
X-Gm-Message-State: APjAAAWnJcZ5sCnFw5qaDNYrYF8LWRM4Ch3kQbBT2MHfwKW7WefiZ9y1
        oMvzQLpG5nhzenbdnnWIdemnd5EEhdg=
X-Google-Smtp-Source: APXvYqzpvwlX7RE1YDXyYUzalDpCfq0DhK3EDDKp5uHfwTbYvMi0O1TvJKiN5BhofTaQKLeTebK3wg==
X-Received: by 2002:a63:66c6:: with SMTP id a189mr12658322pgc.401.1576195797358;
        Thu, 12 Dec 2019 16:09:57 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:56 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 55/58] usb/serial: Don't handle break when CONFIG_MAGIC_SYSRQ is disabled
Date:   Fri, 13 Dec 2019 00:06:54 +0000
Message-Id: <20191213000657.931618-56-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While at it, remove ifdeffery around usb_serial_handle_sysrq_char() as
it doesn't save much from .text anyway.

Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/usb/serial/generic.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
index 1be8bea372a2..37361031402e 100644
--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -571,7 +571,6 @@ int usb_serial_generic_get_icount(struct tty_struct *tty,
 }
 EXPORT_SYMBOL_GPL(usb_serial_generic_get_icount);
 
-#ifdef CONFIG_MAGIC_SYSRQ
 int usb_serial_handle_sysrq_char(struct usb_serial_port *port, unsigned int ch)
 {
 	if (port->sysrq && port->port.console) {
@@ -584,16 +583,13 @@ int usb_serial_handle_sysrq_char(struct usb_serial_port *port, unsigned int ch)
 	}
 	return 0;
 }
-#else
-int usb_serial_handle_sysrq_char(struct usb_serial_port *port, unsigned int ch)
-{
-	return 0;
-}
-#endif
 EXPORT_SYMBOL_GPL(usb_serial_handle_sysrq_char);
 
 int usb_serial_handle_break(struct usb_serial_port *port)
 {
+	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ))
+		return 0;
+
 	if (!port->sysrq) {
 		port->sysrq = jiffies + HZ*5;
 		return 1;
-- 
2.24.0

