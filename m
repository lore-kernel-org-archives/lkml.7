Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD554C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9773121744
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h06WdcHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfEIVMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:12:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42106 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfEIVMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:12:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id x15so1716939pln.9;
        Thu, 09 May 2019 14:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XchIQ0AZQeRGIdq/2nF2UsN/rGYnQ8oRBDgU+OwHFOQ=;
        b=h06WdcHvp6WlG/4gmsdbHNCHdNJycwyUJyTbcMLnzcWKm/Q5sIi41mDciwWf2q4P3m
         8XFB9AcWniLCwTMFBQVAI2/aYHhTTgsYoEbT6lRpV2IDmm9TRvH9G/BhSbYqYzaqGTch
         qXiC4NRIX+LmLYkWCSHOzjwuO7H+2XQwviPoZDrzETOu6qMzy3yLYA5pLtBFdCmY7Zbu
         skylZcWQN/bLSPg0ko0UF7NGNuB+Sb2Bm3WnzXl1niz+zJASZ7M9adikxHS9VOKsRstS
         oM+sogMwUdGRPQxMsCMoQwMBH3Fk8H6j6IM/jDSPiOyQcOfV5kvfM1sJkBwiblx6DsoE
         QwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XchIQ0AZQeRGIdq/2nF2UsN/rGYnQ8oRBDgU+OwHFOQ=;
        b=XyVsRhlfC/txrZ7tLnquDjq3mxEqUTEfJd1dVj5EmBCeCnXg/0NKpyAEOF7PjdmbY+
         Mby/5ugHm2OWUAIwOdLVl2kIltehkgguxGvOWJqjaP0OCc7nZvewSkzusCuld4zJPE/P
         9v2exyWg0UO2Hdrn/8yuJvdXK3JNmkLidMIhLtfkNrJ6PUQQ4bxb6soHdooU63wUXr/0
         z5Nedim70ydKb8+GqBVAHrVxdcY/s3LRFyL8ckVk5YgrmtC0M58KCkPKPQ10a1YrMt9k
         wy5L7tiE2YoL1D/JgDY1R+GjEoTKd8VHwtRR+IjERYEopVuUfCtnvsr4v57nvU9kMf2I
         zFWw==
X-Gm-Message-State: APjAAAXF3bJvHHoDyShIVqyEln/x0siRqcxO56XInUcZ6+92c1buz+PP
        oCZ7KdEO47PZNj0AzuvAm3cCYwaN
X-Google-Smtp-Source: APXvYqz5TNYDm7+pNd+Gdu8MOu9qaXb0QKIcU0YBiGqe8MvC1uVctsjgLOR8LasG89GzHZh7Xsfl8w==
X-Received: by 2002:a17:902:1123:: with SMTP id d32mr8229816pla.82.1557436336270;
        Thu, 09 May 2019 14:12:16 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id w12sm8815119pfj.41.2019.05.09.14.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:12:15 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS)
Subject: [PATCH] tty: amba-pl011: allow shared interrupt
Date:   Thu,  9 May 2019 14:11:58 -0700
Message-Id: <20190509211159.29364-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

The PL011 register space includes all necessary status bits to
determine whether a device instance requires handling in response
to an interrupt. Therefore, multiple instances of the device could
be serviced by a single shared interrupt, which is the case on BCM7211.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 89ade213a1a9..5921a33b2a07 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1717,7 +1717,7 @@ static int pl011_allocate_irq(struct uart_amba_port *uap)
 {
 	pl011_write(uap->im, uap, REG_IMSC);
 
-	return request_irq(uap->port.irq, pl011_int, 0, "uart-pl011", uap);
+	return request_irq(uap->port.irq, pl011_int, IRQF_SHARED, "uart-pl011", uap);
 }
 
 /*
-- 
2.17.1

