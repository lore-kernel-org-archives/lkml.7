Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AF5C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C01B206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="P8Xa9IyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbfLMAJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39558 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731568AbfLMAJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id o9so385516plk.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l5WLqTQP9VT3Wj9H/IDghikmP99MJJRtTWNwh4knJ1g=;
        b=P8Xa9IyOFvUhnq1qV0qnqNFEDzFCnyBVvEhf15NcXH/cTRxIvFsnDeJh431tEL7Bho
         vdUjPUjtRf7DXpmoLJ4OgEeMus6y8d+uGvBU3rBIastCi+YaDl7eBBH1PPp+J8z/8v1b
         OAK7+gFw8kV3SQdJZu0ik5pf6c4aVoyS+z5NAOJ0ENZ7s40qEPP7yAuuSHjBLl9qHISY
         pzuxIWw/vGVhkuP91JKD4QoZjBzpnqxee8Xfx92EgK55JdIiTx0rg3wcqTMThvBtjYJs
         d/3tWF946bZdAjgsjrIflpPX6sGopVBo1A3BGFh0K4Sdr/Z+A6g0ZWtd4/unAg8p8CnU
         TBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5WLqTQP9VT3Wj9H/IDghikmP99MJJRtTWNwh4knJ1g=;
        b=Xyc8HHIWhCDn8Z3HWJdWKEH4ag4W3Ffvxb+pyi7p8RCahQyPyudEynzv4T7xuEFJcS
         U0p3NH0fH1CJPAhorKZDj6P7C05DtkmaZApIpjt4RnSx/kw5AkmG7scHeVhhbn5Owf6g
         axOOaTIHXsIeYKyoh99O6KWfWe3NWlSyXyQJe41yfznznrTWnUnZUSyKNjqdNfOYwwJ+
         m15N0vaswSfGzPR2izVvAsoBW064tWKZHV+TrJl2ha5kguE/SCp9VVhTa8A4TorrwNJn
         0OMaqBsD+76aX/qtxWvythNwSRkIJwoPulXSfUIm/bcV0NMWNmMI+uyj2G2E5ORB9Njc
         cz4w==
X-Gm-Message-State: APjAAAXGGnwhTgsggPF0rUVy54m7V7fIRSvT/Gx4WKj01tKqG3ZmU2DQ
        NKZLlGjTKHjXbS4UJn8tMT+yJft3xd0=
X-Google-Smtp-Source: APXvYqy3wIN8nnc/UL9s/cxQrhBLjGU7KJitO7vCE6oaWq78Eq4QrQYcUGPCAaWotsrH9/5FfOuNkg==
X-Received: by 2002:a17:902:6b45:: with SMTP id g5mr12477341plt.159.1576195767792;
        Thu, 12 Dec 2019 16:09:27 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:27 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 45/58] tty/serial: Migrate sunhv to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:44 +0000
Message-Id: <20191213000657.931618-46-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SUPPORT_SYSRQ ifdeffery is not nice as:
- May create misunderstanding about sizeof(struct uart_port) between
  different objects
- Prevents moving functions from serial_core.h
- Reduces readability (well, it's ifdeffery - it's hard to follow)

In order to remove SUPPORT_SYSRQ, has_sysrq variable has been added.
Initialise it in driver's probe and remove ifdeffery.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/sunhv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index f8503f8fc44e..eafada8fb6fa 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -25,10 +25,6 @@
 #include <asm/irq.h>
 #include <asm/setup.h>
 
-#if defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/serial_core.h>
 #include <linux/sunserialcore.h>
 
@@ -552,6 +548,7 @@ static int hv_probe(struct platform_device *op)
 
 	sunhv_port = port;
 
+	port->has_sysrq = 1;
 	port->line = 0;
 	port->ops = &sunhv_pops;
 	port->type = PORT_SUNHV;
-- 
2.24.0

