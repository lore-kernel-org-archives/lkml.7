Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D490C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28BA2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxgHkvz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfD0JTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 05:19:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37860 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfD0JTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 05:19:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id g3so2888551pfi.4;
        Sat, 27 Apr 2019 02:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Gg/uK4hT6erpZ9y7ys+gWQjOqjeDr2lhneKZX4LpVYQ=;
        b=IxgHkvz5aNsXC9JiJTT3Kwd64QRsfiQ7GF3sH96LTAcMK4dGRiBgMQjZ4MR0Fiuf6d
         q9elPIf9/QoKD4BxW10NAB2e6tN7FiGAyXnsLp4/AePRVTyzeLCxG5fSjYP1vnux2RFn
         CoJvG7KFrGRC7zq4qWaR81ezonCDFg54Liplj3OazAOyxYqny+Wf3LbdCgMLpTqKbEoT
         tJqoXTQIRPwRxlE1e6d48tp0n9hgfOKe1eSiquBvLDC69OQwUuId+5OVg5sBTsY0LP+n
         mzZmXCuuzxlL3rSXtyR5lnl4Js0I29ZNa+7TI+QfaeGc/fsvBkp+xk+yIR3126Ytw4xq
         HstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Gg/uK4hT6erpZ9y7ys+gWQjOqjeDr2lhneKZX4LpVYQ=;
        b=ZcSe7YJkrMBrSfpUuGacroble6+yaoo7jxFB8UdZdRjwsGOkd3AFPqR78bqqAeF7JT
         Xhg5eO8KGuZy+t1iN31UxYLrFAn+XpFmakT/447nVGJ2C4ryIi+K8RJXvUqOUgqf5rEo
         JU6p4FIbHEEtwte+LdQRYVMxaWzANEu22x73GEJ61ayp2LQhyAiF8v+d/YV0/IjMCq12
         CTe22Ck5QORF6Lstq15cQpFN5KvyNF3SxCmb8TL+8T4/HVGC/M+3EU1DpPLVzmL69QK4
         vT8F/scIs5a90yzldONgUiOpbb+rGo0pcMZ0KTNFz0T94V9qRW9sDILq39FiSyqrmdHd
         QRhA==
X-Gm-Message-State: APjAAAUmUndwn5/v1MGwFpgy4PzbmYzBtAbSlpXpj8ldPFF7R9d7EGjj
        LgA9tcEmLLCF/TAFdg2LGfBrS3C2o4E=
X-Google-Smtp-Source: APXvYqxGDPaNuh/WH0EAveQ3DVS5k/WaByaRL7R6a2rUOB4HfEzSoS5c3KCbecgE8gC5WxypvItjVw==
X-Received: by 2002:a63:fd58:: with SMTP id m24mr24643145pgj.298.1556356785499;
        Sat, 27 Apr 2019 02:19:45 -0700 (PDT)
Received: from haolee.io ([2600:3c01::f03c:91ff:fe77:6cf4])
        by smtp.gmail.com with ESMTPSA id u6sm39870871pfm.10.2019.04.27.02.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 02:19:45 -0700 (PDT)
Date:   Sat, 27 Apr 2019 17:19:43 +0800
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, haolee.swjtu@gmail.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: serial: 8250: Fix type field in format string
Message-ID: <20190427091943.GA3810@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_dbg statement should print the value of uart.port.mapbase instead
of its address. Besides that, uart.port.irq and uart.port.iotype are all
unsigned types, so using %u is more appropriate.

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

