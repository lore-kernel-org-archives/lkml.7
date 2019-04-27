Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5B7C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A73208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG+DAdkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfD0IAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 04:00:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41680 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfD0IAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 04:00:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so2813047pfd.8;
        Sat, 27 Apr 2019 01:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=025lya6M642Hc3kd+lp59G5S76r6+kxfF19HoQqHv8M=;
        b=eG+DAdkR23NstusL7nr/dmjT6YNKym7aNjq/HxTw/AUv+B9NLdz4L632Y1XTRx3Tdb
         e77lSB0dwaoQX65kl8/D3Nm1Sa/2CIWF6DWv5SkS3tdXNDAOnVzZBoKk9M+7BtibCz3A
         u0PFfdutsfWTD/oOps6ewi0y/87BQRdpZWl3KpBjqJBaNsV+QCCDlPCItD6ny+57KAme
         ozklGXSR6ytjllqctNQQvbBo6yXUBXUDcrAT6y4xkbXyJfbssOf4jvXMFLUwLpLP/McY
         qeIprym0d//hu/3xTujKIU5jx1/0E+yHgsLdVXwMxQTfc46+4NP3PqIFMaW9gp0boaIV
         bJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=025lya6M642Hc3kd+lp59G5S76r6+kxfF19HoQqHv8M=;
        b=M5kCYhzGm5SbxIahE4u3fiy/EtG2KkzFLO/g5jiz7jvQ29RYZmWZe9pcs0xMWdUu9s
         KHXuR1ZgfunmNXgGk46aHIHWCJZTQLhT9CNqsqio+AE5a1zUQ4Qnewe3CObSdVegkAPN
         Dp5rtexbi8zQqU5enX1/AiVO6zGcYe0URttu7VNx/jV9X8kBcdeKldJJ2pWlICs2q1fm
         QkFLIwrbyngdKuiuF7/FeaSYNO9IhAR3Hw64LrCERZAYdrvTC5yS2sLiYKOA7ropD8dw
         c2NfjODWUmRGDoKmBns52XtnTaD6+W/Moy3iWeiwzZ9ULX29adEktT7iHqlYqz70VkGE
         M6oA==
X-Gm-Message-State: APjAAAVenAYuvSSswepVqwaNQP+RTs8AzBf5Og1NVOxSeJQppdMp5yZR
        QkevEXsjLErhUTSwhB7bypg=
X-Google-Smtp-Source: APXvYqyjC1GaOO8V5xZbkrqBs/STQ7VAcDV3xpRwAYfN7CQ0ozSai4eSxTJAEOJbuaDIUklV8m4qtQ==
X-Received: by 2002:a65:408b:: with SMTP id t11mr9287344pgp.372.1556352017659;
        Sat, 27 Apr 2019 01:00:17 -0700 (PDT)
Received: from haolee.io ([2600:3c01::f03c:91ff:fe77:6cf4])
        by smtp.gmail.com with ESMTPSA id u62sm45155374pfa.124.2019.04.27.01.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 01:00:17 -0700 (PDT)
Date:   Sat, 27 Apr 2019 16:00:15 +0800
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, haolee.swjtu@gmail.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: 8250: Fix type field in format string
Message-ID: <20190427080013.GA3624@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable type and the type field is inconsistent.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 drivers/tty/serial/8250/8250_pnp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 431e69a5a6a0..9dea11baf479 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -462,8 +462,8 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 		return -ENODEV;
 
 	dev_dbg(&dev->dev,
-		 "Setup PNP port: port %lx, mem %pa, irq %d, type %d\n",
-		 uart.port.iobase, &uart.port.mapbase,
+		 "Setup PNP port: port %#lx, mem %#lx, irq %u, type %u\n",
+		 uart.port.iobase, uart.port.mapbase,
 		 uart.port.irq, uart.port.iotype);
 
 	if (flags & CIR_PORT) {
-- 
2.14.5

