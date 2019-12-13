Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C55C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D76206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="NPETUlta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbfLMAJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36623 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731794AbfLMAJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id x184so398028pfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9JntUxXt1Y85ooe5sbFev2QqISCNlaixFGYth5GAgwY=;
        b=NPETUltamd7d7ptdYvLyWmJu5j/gbTB4g3ZuEfX6uazSsjURvl4ACBrip9mbuOJ0MG
         gecfY8UqOTfuNAm3PJqc/XIXm0+zhSzDiLGhA8n7wvoaBRHnQw/DFwxnYkm76fLOqHe2
         FRnMnGU7m72dFrrdnONl4eBlUD9W7XfjBcrgqg+niAPTQ6S4QHD/hfCj3ZPXBSQGdfR4
         w96IFjePBpOjR9ZwPbAPpWOgeIQs2fphrUZi56AYWNvVXpX2CrFUjyaF8CROWW0Dn43+
         z76qYcM4IObIdBZ77pRtdAEGa1Kz+lHETgq9QQwUV+Ii4jH+8b8pDP6HtA9efJjpFFzR
         KBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9JntUxXt1Y85ooe5sbFev2QqISCNlaixFGYth5GAgwY=;
        b=GzQa1TIsp4BHF4wXe2Q409cq2DWMYT8HeMZtzOEX9ggbeDW6PTju7Mfs3VSxIKIjzT
         G4iPPsnVzg1RA8a6Qxqatn5kyhJj6sIakyj7Sih02sf04bYPEmI3j4l8nwBFKC8A7+f2
         RccPk+6okxoxQQ5MkpuBPmnQM9pXjPoLAZzlNska8Uqff456dq3wuwepVSdJi2bn3wwc
         JX6N1LXFsil/qdYYLa2oJBLORfyszjVH40mKPbn0LQ7lblsvMz9gKAyGVyl1KKQ22RI4
         J7WYAd1HB997Dc8rb5SbF5DSiTkdE39Ffjq1JzTakme50UgWgAhFYTLho/DCjXcJIbRp
         5jKA==
X-Gm-Message-State: APjAAAXb9WZvHadVgS2QP6hh507iq+BPaHUCPieLX7wrTMGisWlTqnYa
        oAbb2/MWoHh7/AI9C5AEKRrnXYk13yQ=
X-Google-Smtp-Source: APXvYqz7t4GUUIPfvbXQS/YoeWMe3o6IsSxNmpIcIRs2xeZI5yAwhwfmMDrrRl6jMip5ZPO13bZIXw==
X-Received: by 2002:a63:3750:: with SMTP id g16mr3628252pgn.413.1576195748551;
        Thu, 12 Dec 2019 16:09:08 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:07 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 39/58] tty/serial: Migrate sccnxp to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:38 +0000
Message-Id: <20191213000657.931618-40-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/sccnxp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index d2b77aae42ae..10cc16a71f26 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -7,10 +7,6 @@
  *  Based on sc26xx.c, by Thomas Bogendörfer (tsbogend@alpha.franken.de)
  */
 
-#if defined(CONFIG_SERIAL_SCCNXP_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -1000,6 +996,7 @@ static int sccnxp_probe(struct platform_device *pdev)
 		s->port[i].regshift	= s->pdata.reg_shift;
 		s->port[i].uartclk	= uartclk;
 		s->port[i].ops		= &sccnxp_ops;
+		s->port[i].has_sysrq = IS_ENABLED(CONFIG_SERIAL_SCCNXP_CONSOLE);
 		uart_add_one_port(&s->uart, &s->port[i]);
 		/* Set direction to input */
 		if (s->chip->flags & SCCNXP_HAVE_IO)
-- 
2.24.0

