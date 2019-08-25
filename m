Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1DAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 05:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53F0217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 05:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8fdl5A8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfHYFkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 01:40:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36288 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfHYFkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 01:40:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id f19so8131106plr.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2019 22:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFfgVd1HrYudeMH+V4T/rdJ0ZaXATB1kXtOEUXrqdlA=;
        b=m8fdl5A8fxXULQBbv8DkWxR9lnZiN19xRHyF1cgeSYypSxNVhdNlMol9HGfyjTEt1Z
         NErtDMu9J9v757HnHofiLvHU1oSaFrIlxB3VzbNbT6UXuq3VUvWGI0BP+aaOSh/f1KWY
         uaOBA+rJ54B801AC5/cCGpqkuvzenMui0NuCBm+Iw1y+mnhmlzYCC+Wp+ElT1K5hrH1v
         PYMBNKLM2QiQnH6+y/KSWsjyHgLDVyJS0upAZH4+iT1J2sGJ5NuHI6PoRaYmSrylAPhz
         W0wlIrAJhAtq6Jl4V1Gmydewmtgg4/3TgMxdcrYHi5jo5jc9BerpmEbSKfassIMPFwTF
         3L5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFfgVd1HrYudeMH+V4T/rdJ0ZaXATB1kXtOEUXrqdlA=;
        b=RzPZQEbmYUJRkRiBC1RRN3F2Y6H3WsdLNImKG0UpnHC1cRCZ4IIL4Yxh4MbE/1uegc
         Wxse4G2D6pQzZl0cHb+IbFvbppMj2ENwBXnJOTb+sTvhkOq323ajWzsRIeEcFGVv/7VN
         hOEugt6wWhh1OaIMMEXr9Kr5UB1Sjvlm5XftUyhmrwoo4FdeyRq7uXMsV1cvv5TeGaQg
         cfH+Q8vLgOQXKFPr6bqjDwflJu5PKRQ/JNvFo/Gls60NBOsNyd6/I+O9gY3FCJfTupcR
         Px2xUxpT5lehHD479o/KFvX72kW1J+aZgxpyHOWQxipV26VobHl/IkowYUC9sw9bPpsE
         L6OQ==
X-Gm-Message-State: APjAAAU/jzFLKrleIgxkNTj9/xm4kN5aDptzjagbGLMSmvW/vSNpn0Nq
        mT6VpD7a0mpdtVOkS5umNC4=
X-Google-Smtp-Source: APXvYqycSpOt5WgIzTiPYUlZTknHB+u4aBa9CR62RYRGwaidOo2OVwDD12nanrgdW9DMXKOSU+PJyQ==
X-Received: by 2002:a17:902:4201:: with SMTP id g1mr13023712pld.300.1566711651684;
        Sat, 24 Aug 2019 22:40:51 -0700 (PDT)
Received: from localhost.localdomain (ip-103-85-38-221.syd.xi.com.au. [103.85.38.221])
        by smtp.gmail.com with ESMTPSA id r75sm9395181pfc.18.2019.08.24.22.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 22:40:51 -0700 (PDT)
From:   Adam Zerella <adam.zerella@gmail.com>
Cc:     Adam Zerella <adam.zerella@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] pcmcia/i82092: Refactored dprintk macro for dev_dbg().
Date:   Sun, 25 Aug 2019 15:35:10 +1000
Message-Id: <20190825053513.13990-1-adam.zerella@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190823174357.GA8052@kroah.com>
References: <20190823174357.GA8052@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested in https://kernelnewbies.org/KernelJanitors/Todo
this patch replaces the outdated macro of DPRINTK for dev_dbg()

To: Dominik Brodowski <linux@dominikbrodowski.net>
To: Thomas Gleixner <tglx@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Adam Zerella <adam.zerella@gmail.com>
To: linux-kernel@vger.kernel.org
Signed-off-by: Adam Zerella <adam.zerella@gmail.com>
---
Changes in v2:
  - Swap pr_debug() for dev_dbg()
  - Clarify commit summary message

 drivers/pcmcia/i82092.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index ec54a2aa5cb8..245d60189375 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -117,9 +117,9 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 		
 		if (card_present(i)) {
 			sockets[i].card_state = 3;
-			dprintk(KERN_DEBUG "i82092aa: slot %i is occupied\n",i);
+			dev_dbg(&dev->dev, "i82092aa: slot %i is occupied\n", i);
 		} else {
-			dprintk(KERN_DEBUG "i82092aa: slot %i is vacant\n",i);
+			dev_dbg(&dev->dev, "i82092aa: slot %i is vacant\n", i);
 		}
 	}
 		
@@ -128,7 +128,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 	pci_write_config_byte(dev, 0x50, configbyte); /* PCI Interrupt Routing Register */
 
 	/* Register the interrupt handler */
-	dprintk(KERN_DEBUG "Requesting interrupt %i \n",dev->irq);
+	dev_dbg(&dev->dev, "Requesting interrupt %i\n", dev->irq);
 	if ((ret = request_irq(dev->irq, i82092aa_interrupt, IRQF_SHARED, "i82092aa", i82092aa_interrupt))) {
 		printk(KERN_ERR "i82092aa: Failed to register IRQ %d, aborting\n", dev->irq);
 		goto err_out_free_res;
-- 
2.20.1

