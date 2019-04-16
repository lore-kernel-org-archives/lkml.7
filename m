Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5B2C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BDD2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bY2/kTaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfDPI1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:27:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38793 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbfDPI1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:27:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so10029920pfo.5;
        Tue, 16 Apr 2019 01:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wSXawtePsQ2vPenoE5g6gqTHM+qfmcA55/vvKDCelvw=;
        b=bY2/kTaYddTu2z6xUl+xBmSkSbfqy6E8O2LK70reRNDtXu2LP3TFqEvQQOWmg/YN1D
         VEZ+Yj7o13QzqQCWsmUmrNNaKSylqCd3r09zcJ/fY6C0q/+vuFbSWFkRHFuvUKqof61q
         gaSrkD7e6UQEqt+qjPs5BXQKKOjtCOjRs2knwuMRiJAXqVh4190Q/g4PptthFKTUAGPa
         58puthAZsi0YRCsmf4SaxZ2IwOLJ2fucJM7aqPJSybX/c7PYURE4zWAUO/MqH52rCaX3
         bJxRQDM9WKXlE4274F145sdir3l9Sf65wqOadMzvDlbrRZ7z516V9N5J6ZkP69rlKQjZ
         NFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wSXawtePsQ2vPenoE5g6gqTHM+qfmcA55/vvKDCelvw=;
        b=Bgo0FJDqW6GbymI3JOWein3r4u6ybWFnDhBU1qwgqjpBKBtFWC+GvRZr/Uhw/34Eop
         /+ECa2E1abLDo2N1/W0F4aczNXOZvUyoRJgLQ13RwUjkUm0mhh6XTx2OuLpHL6dl+ZQx
         J0BdyLatQui+rLOhBOqaKkN/RNqRCSlIoviqDp101NhFEIoUUb9ZgyGlS4guzy3qbIM5
         dOe2tTm5AOM72xSz4CSeFcGzbcBy1igut7Zsgfm04xrt0CHMnER84w6FQ9/iSrVoKJDP
         5Str3l/+/ZvbmytdrkHK+JH5xjAaVPvZs1VGpU4Xfs36hxmJ3MaKwKU/QG46VAmF3DSQ
         T5Qg==
X-Gm-Message-State: APjAAAUSX4Cqp/nUU37mRo5ZWX5L0U55O3okcr2dCpnm3oitR0IqQkAn
        yv4mWl4IopJCv6Hl0Ou/CfA=
X-Google-Smtp-Source: APXvYqyIJtfDFAqfroBON9ydby3jhN9HXtT71C8ZERCECYbfh9Fe8UdjpIzCL29V4jTIbHVO/NN9Qw==
X-Received: by 2002:a62:4554:: with SMTP id s81mr53087660pfa.66.1555403231264;
        Tue, 16 Apr 2019 01:27:11 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id h19sm90604629pfd.130.2019.04.16.01.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 01:27:10 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V7 2/4] USB: serial: f81232: fix interrupt worker not stop
Date:   Tue, 16 Apr 2019 16:27:03 +0800
Message-Id: <1555403225-3430-2-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555403225-3430-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1555403225-3430-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The F81232 will use LSR/Interrupt worker to handle LSR error & MSR
change. This patch will fix the interrupt work should stop in close()
and suspend().

Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
V7:
	1: first introduce to this series patch.

 drivers/usb/serial/f81232.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 18d3fcf2907a..7c7495ae5600 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -576,6 +576,7 @@ static void f81232_close(struct usb_serial_port *port)
 	usb_serial_generic_close(port);
 	usb_kill_urb(port->interrupt_in_urb);
 	flush_work(&port_priv->lsr_work);
+	flush_work(&port_priv->interrupt_work);
 	port_priv->is_port_open = false;
 
 	mutex_unlock(&port_priv->lock);
@@ -679,8 +680,10 @@ static int f81232_suspend(struct usb_serial *serial, pm_message_t message)
 
 	usb_kill_urb(port->interrupt_in_urb);
 
-	if (port_priv)
+	if (port_priv) {
 		flush_work(&port_priv->lsr_work);
+		flush_work(&port_priv->interrupt_work);
+	}
 
 	return 0;
 }
-- 
2.7.4

