Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71383C10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8D4206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwM8THfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbfDWC5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 22:57:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42196 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbfDWC5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 22:57:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so6791727pgh.9;
        Mon, 22 Apr 2019 19:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=J4MoF5Pf3jK4YljSafrqPWTwKkEgKoTcKoHfmYuz7NI=;
        b=nwM8THfh2F4L9C9ty+0RmqJJW4bZnkkDAPt5iieUrYcKNrzOxiu9G/GT5Svnp6PbiS
         XaR5y5eb6MJvIxo/EYtjeOb2bKuVZVPp404FS6yV9pMGDMqZBV9crXzcXYZI51grgyfe
         RMWLz50jjMDizxCnJKujUV9ZKM+j16sYbJRiQbwMIuLt9JJZeYKu2nbqjB+7AaZMzfcM
         DEdG4UKb1JQu/Blrh0jAIDxKJYQUZTECi0k3DeWESVSunXdkz9qpY92MfHQ2kBY8Ntub
         08RqoWaS+eMPt6/vu7olRJSLo7QpA86YqE3FyIx6Jk+C4cv2Q/oLVQXg+By+diYV5i3p
         gIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J4MoF5Pf3jK4YljSafrqPWTwKkEgKoTcKoHfmYuz7NI=;
        b=hwJmSa44QRR3CYDUsKOPvN9x6xdJAitWR6W+w51r4YMh3t2t0ZwROjCgVgGijMRXej
         olt4Ylaonj9FfKAiZvneH3i0bcYA496oArI+dh4JyN0wsrrGC9pYIBMovV5niR/jUH8O
         DKEfa5EB5uhWZeZZkZ/C2qFU5aeVJNoJgWhESErlVLJCXK12/gP1cDSViWfwZ31YJn/y
         sDvNqFM8dLmYgNbgJfZo6+bW1NtVsfRSTlBmao6IBgvpHjhtfOCBH97fc4a/9SnClMDU
         Vz4FiQJ9N37Cj8+8mE/Y/N0+n0pxTauYbuA5ReTcE6IMn1w+1lsmRicWfw1lMpa2ozwQ
         768w==
X-Gm-Message-State: APjAAAV7vP3rRzucgFNAJ/L6tpycu8KispoHVvK9fYjwE6xJcKz6Tp5U
        BdhGHyAFyIstEmRFMkZDdYPoBshFb0g=
X-Google-Smtp-Source: APXvYqzVjsC6LHgExQeicNOP7K2YPW3wrYhciORuHos8TK8TZEZvuuIIK71GZTGLyXiSHFkOwdAjBg==
X-Received: by 2002:a63:e10b:: with SMTP id z11mr21952621pgh.46.1555988223237;
        Mon, 22 Apr 2019 19:57:03 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id b19sm19832849pgb.51.2019.04.22.19.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 19:57:02 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Karsten Keil <isdn@linux-pingi.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] isdn:mISDN: fix misuse of %x in hfcpci.c
Date:   Tue, 23 Apr 2019 10:56:23 +0800
Message-Id: <20190423025623.17419-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers should be printed with %p or %px rather than
cast to (u_long) and printed with %lx.
Change %lx to %p to print the pointer.
Change %lx to %pad to print the dma_addr_t.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/isdn/hardware/mISDN/hfcpci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcpci.c b/drivers/isdn/hardware/mISDN/hfcpci.c
index 362aa54..29c22d7 100644
--- a/drivers/isdn/hardware/mISDN/hfcpci.c
+++ b/drivers/isdn/hardware/mISDN/hfcpci.c
@@ -2041,9 +2041,9 @@ setup_hw(struct hfc_pci *hc)
 	}
 
 	printk(KERN_INFO
-	       "HFC-PCI: defined at mem %#lx fifo %#lx(%#lx) IRQ %d HZ %d\n",
-	       (u_long) hc->hw.pci_io, (u_long) hc->hw.fifos,
-	       (u_long) hc->hw.dmahandle, hc->irq, HZ);
+	       "HFC-PCI: defined at mem %#lx fifo %p(%pad) IRQ %d HZ %d\n",
+	       (u_long) hc->hw.pci_io, hc->hw.fifos,
+	       &hc->hw.dmahandle, hc->irq, HZ);
 
 	/* enable memory mapped ports, disable busmaster */
 	pci_write_config_word(hc->pdev, PCI_COMMAND, PCI_ENA_MEMIO);
-- 
2.11.0

