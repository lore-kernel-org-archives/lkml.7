Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B06C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6628214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jEsgZRum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbfLMAHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:07:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35739 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731326AbfLMAHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:21 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so551203pgk.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+c98ZzOoZa6r4oh0WHvCTRmQQ3Z1F+2HIMc70hjB/hU=;
        b=jEsgZRumRQgH2VTgb7IeNELwg6EsCFbkQ6k+lMA5NcFyPPxcLIoX7AL6uyea78KEc8
         49DZo0LWs9eTr1cRpFmpLqmCdvRvtFYienwXJTiQrmOmxbusdeCx8hyOPVooq8w+WGun
         Y+8vzZciN1QI0taHL4RSf5PS/UkXz6lAKeCiZOaEjaDw3kf6h+r3GeYmiUiTNSXbBcxt
         595481evp0kvUEWPNYWY6JNHier+4Qf16k+Mca5m6hx8M9RMp9/CRtplGm7N6PLSgdTI
         EsEy+U9K4k1wz2p9HbwRXTQ4E9KZ8DOZN/EcvYVAZoqpxkeHPZ6IHbKvTFg7vPdO1M5l
         yLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+c98ZzOoZa6r4oh0WHvCTRmQQ3Z1F+2HIMc70hjB/hU=;
        b=nwS6J5T/Ghv4ASnQhsoBTrfd32NyFGYd6+wI466GeSVYvO2L0Mmfkbc/vYZcF56/u0
         g/8qPrFqDNGCd/zWi68PZBiVrz/UaoQl762QpkcPtmxbpCKdqSj8CgM+3oGiuhTsyjr4
         znZsKDJP4ZEx48Qv/elq2HO2Sa3/qQ1pXIlsAyk3Jl0H3KubtJUIFArFPvErdUj4rsFL
         Xql9cxWmOD/S1B6YLLB4buxyWrDkYcyJZLMsWUN+CIf/bO+kfhj+uWqXwQ6wuo3LPis6
         HgMenFKwc/fIrI6EH4SJy0rnpXQsr+I3eU/nsOLzdkceO57TqRCEWtrOs22/TDzD6bQN
         S0Zg==
X-Gm-Message-State: APjAAAWighpEDKAqhZU8gD/ar6fmSb5dbinYst1EZP55WrAqgikz8FmY
        9W8IYHCRwkj10UF578MHfJMiDLKfm/U=
X-Google-Smtp-Source: APXvYqz5fQ+7DouCDoyrPelCmS/wHA9WAdlujQLAMlQCjfldKxAtxyGpHXYSKFLtaHn0VOlC0r4y2Q==
X-Received: by 2002:a63:5a64:: with SMTP id k36mr13933148pgm.323.1576195639965;
        Thu, 12 Dec 2019 16:07:19 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:19 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 02/58] serial: Move sysrq members above
Date:   Fri, 13 Dec 2019 00:06:01 +0000
Message-Id: <20191213000657.931618-3-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the current place members those follow are:
:	upf_t			flags;
:	upstat_t		status;
:	int			hw_stopped;
:	unsigned int		mctrl;
:	unsigned int		timeout;
:	unsigned int		type;
:	const struct uart_ops	*ops;

Together, they give (*ops) 8-byte align on 64-bit platforms.
And `sysrq_ch` introduces 4-byte padding.

On the other side, above:
:	struct device		*dev;
:	unsigned char		hub6;
:	unsigned char		suspended;
:	unsigned char		unused[2];
:	const char		*name;

Adds another 4-byte padding.

Moving sysrq members just before `hub6` allows to save 8 bytes
per-uart_port on 64-bit platforms:
On my gcc, x86_64 sizeof(struct uart_port) goes from 528 to 520.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/serial_core.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 2b78cc734719..bbbe57bf5163 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -161,11 +161,6 @@ struct uart_port {
 	struct uart_icount	icount;			/* statistics */
 
 	struct console		*cons;			/* struct console, if any */
-#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
-	unsigned long		sysrq;			/* sysrq timeout */
-	unsigned int		sysrq_ch;		/* char for sysrq */
-#endif
-
 	/* flags must be updated while holding port mutex */
 	upf_t			flags;
 
@@ -244,6 +239,12 @@ struct uart_port {
 	resource_size_t		mapbase;		/* for ioremap */
 	resource_size_t		mapsize;
 	struct device		*dev;			/* parent device */
+
+#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
+	unsigned long		sysrq;			/* sysrq timeout */
+	unsigned int		sysrq_ch;		/* char for sysrq */
+#endif
+
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		suspended;
 	unsigned char		unused[2];
-- 
2.24.0

