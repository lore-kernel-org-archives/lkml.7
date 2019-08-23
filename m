Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80280C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5139221019
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmVf6U+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404431AbfHWGaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 02:30:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38389 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404394AbfHWGaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 02:30:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id w11so4523510plp.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 23:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHgzB7LXrFsDHZMpQ3e7AmMOPq1F2h1b1Flup3dGb5k=;
        b=nmVf6U+Yw+OIUaxMQF9WI05AI4EhxwHVlvr9jNM9Mzf4LtCySIgvRnABT0drXl/Kis
         l/wu4O3seA8e2RjFyD55Ap6vvdgyjod1M+SkK9OdEvqHDNEUptuvtJf6uFhvOefo55+R
         Km9j2WA4OKdaIs5EYafyWLbr5V6BWczzcQDPT3XRVLeyNV1f89PkF0RKG/DSb0iuVvuo
         iOl2JqlK6yCs+pJHPX7yxVhztxpoWikKPOygzOJCL9uy3aex32hj/v1wKebi/+GIFQzc
         XV1SghbYCKRCBiN+//pCHXI/EJkBbY+8kI2U1fufbtIr5VM0cksWsDaa9tzzrKYMzmO0
         qIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHgzB7LXrFsDHZMpQ3e7AmMOPq1F2h1b1Flup3dGb5k=;
        b=iPtC0JnSTXkuh1zf9LUbgJrr+BqxkiqYzQue5iCyzh7hwOeWxVsCEnAXJHhDdbhlHU
         TKbTRbjPWefYG5qHfkC/+AGnZHIWZgBv6bBa4T1NiqH7p6spI9g+PyzYTMB3ACiBsTIb
         ehdLfU2u0uCxoJUL6ucFfYsIZ4PE+3+DMJWjjHRuuPLyrIE5Y51r28BM4pajsK//zN3P
         b7Ua8zD0FAm+Pmuoo+46/oNqv1/nvEYRuXNiYlXxc8b/z2dofgd85xN/Q+IjqX1N30KB
         kb3Avo3GKbqOl9ukNQX50J7x+TMo+m1yNlPyb74konJSPPBeZzCD4ueaJjKnrTTT5OPg
         8PGg==
X-Gm-Message-State: APjAAAXWjHC2l5/JzwxirKdH2MyYwFGj3BYxFF3KUK5I65+1b21zeXTD
        +72tK8a6PbwbXFOnYRsYS6U=
X-Google-Smtp-Source: APXvYqzjM1750tRhH/gnLvOqHn8wNbky+a9NAExFz6f74r1T0MfI+OlLiPsk82HDNkLmauL6eirrdg==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61mr2885601plb.22.1566541816984;
        Thu, 22 Aug 2019 23:30:16 -0700 (PDT)
Received: from FINLAND.cbr.squiz.net.au (220-245-33-70.static.tpgi.com.au. [220.245.33.70])
        by smtp.gmail.com with ESMTPSA id o1sm1195408pjp.0.2019.08.22.23.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 23:30:16 -0700 (PDT)
From:   Adam Zerella <adam.zerella@gmail.com>
Cc:     Adam Zerella <adam.zerella@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia/i82092: Refactored dprintk macro for pr_debug().
Date:   Fri, 23 Aug 2019 16:29:49 +1000
Message-Id: <20190823062951.1168-1-adam.zerella@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out in https://kernelnewbies.org/KernelJanitors/Todo
this patch replaces the outdated macro of DPRINTK for pr_debug()

To: Dominik Brodowski <linux@dominikbrodowski.net>
To: Thomas Gleixner <tglx@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Adam Zerella <adam.zerella@gmail.com>
To: linux-kernel@vger.kernel.org
Signed-off-by: Adam Zerella <adam.zerella@gmail.com>
---
 drivers/pcmcia/i82092.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index ec54a2aa5cb8..e1929520c20e 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -117,9 +117,9 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 		
 		if (card_present(i)) {
 			sockets[i].card_state = 3;
-			dprintk(KERN_DEBUG "i82092aa: slot %i is occupied\n",i);
+			pr_debug("i82092aa: slot %i is occupied\n", i);
 		} else {
-			dprintk(KERN_DEBUG "i82092aa: slot %i is vacant\n",i);
+			pr_debug("i82092aa: slot %i is vacant\n", i);
 		}
 	}
 		
@@ -128,7 +128,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 	pci_write_config_byte(dev, 0x50, configbyte); /* PCI Interrupt Routing Register */
 
 	/* Register the interrupt handler */
-	dprintk(KERN_DEBUG "Requesting interrupt %i \n",dev->irq);
+	pr_debug("Requesting interrupt %i\n", dev->irq);
 	if ((ret = request_irq(dev->irq, i82092aa_interrupt, IRQF_SHARED, "i82092aa", i82092aa_interrupt))) {
 		printk(KERN_ERR "i82092aa: Failed to register IRQ %d, aborting\n", dev->irq);
 		goto err_out_free_res;
-- 
2.20.1

