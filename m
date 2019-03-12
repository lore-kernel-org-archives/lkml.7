Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF98DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB33F214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Y+3Yeb52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfCLFzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:55:15 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:58628 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfCLFzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:55:14 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 1BC649C9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 05:55:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5kY8iYv2Jhei for <linux-kernel@vger.kernel.org>;
        Tue, 12 Mar 2019 00:55:12 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id DBF379AF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:55:12 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id 190so1270396itv.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=l7CP9PHOpjHZ8ntpI+Qq1qyFCmQFHlN5Tc75DwlZcVA=;
        b=Y+3Yeb52+oGloy5I/6svZJJ9jKIqai16xm9v60yQFWRO9PZ/IQ98p9l81sH4lNR0wn
         1RcuFjw892h70UGIlUG+uMPqZNqt42MUVxzmBX6LrISrMuxSKxGtPHVQVY4hPu1eE7wO
         y2p/cmTcjamVh1nDcEZH021jCovv1QoyDDhklm3FPizoyMg7gfsWI1YsHdXl27H37JlV
         I18cHECnVxbooJn/54p1JtLCX5tfRMcKNj9M2Yb5uh83gehv7ciKGSqWsS0MU+4V5Ghi
         x2+PGLoug+vb173OAxnEbtF00cDGLhZ5H/F2lIr9Ffe2zrONw2YoQrnyHyU14v2PNgzF
         V1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l7CP9PHOpjHZ8ntpI+Qq1qyFCmQFHlN5Tc75DwlZcVA=;
        b=jTk4e2ry8ZW5TwhLreZudmirWDdsJVD74wLbhT0RWb5fRDJVgyaDdaks7pq1/w5HTx
         7Nkn8A1iVgPdatRZR+MPlYnEnmsHLhC3P20RVbjdfKKeGXcxu0bWvdyJwhqCblgewkQ3
         9HfMRXNxQc/tRZqBxxDVkVfYdKjjiY/HPyz45S3CvWu46ogCeTaMhABw8t5hru6dVG1S
         hCYe47Q6TvRKmCL22s6ezUxFTqNej1gOswDfkyD8cz4crOw82hn3/Iv6g19PNTeMl6PL
         9NnP7QwUKbGxS04qLyktxfAbjJjxAvvPx3syR9x6t9wu7Kia6Ao6RRrc/ygiHwEVxW+0
         FckQ==
X-Gm-Message-State: APjAAAV25FxXPaO6/w/qfqZmbVp1CBGN5PKTraid0rfvYApoarwjjBhY
        PVjXMzqAW20qAV0n0L7eRs8+6YhHSszoKj1iA1Rcy70o97FnJe+g4Z6gM6kKluVapBRrLWy+oyY
        vcF4HXVGx7iIs0DrY70UeOCfDD7xF
X-Received: by 2002:a24:66c8:: with SMTP id k191mr1051348itc.20.1552370112780;
        Mon, 11 Mar 2019 22:55:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzZRQvcjt142R4p7ArNNBj0GKbEZPSeVuOub4w1/py91yEH7xnm7VvFtThhwWY/Aa5j2+wk8g==
X-Received: by 2002:a24:66c8:: with SMTP id k191mr1051328itc.20.1552370112050;
        Mon, 11 Mar 2019 22:55:12 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id s12sm762324itj.41.2019.03.11.22.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 22:55:11 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] isdn: hfcpci: fix potential NULL pointer dereference
Date:   Tue, 12 Mar 2019 00:54:55 -0500
Message-Id: <20190312055457.11055-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case ioremap fails, the fix releases resources and returns.
The following printk is for logging purpose and thus is
preserved.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/isdn/hardware/mISDN/hfcpci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/isdn/hardware/mISDN/hfcpci.c b/drivers/isdn/hardware/mISDN/hfcpci.c
index ebb3fa2e1d00..362aa5450a5e 100644
--- a/drivers/isdn/hardware/mISDN/hfcpci.c
+++ b/drivers/isdn/hardware/mISDN/hfcpci.c
@@ -2032,10 +2032,19 @@ setup_hw(struct hfc_pci *hc)
 	hc->hw.fifos = buffer;
 	pci_write_config_dword(hc->pdev, 0x80, hc->hw.dmahandle);
 	hc->hw.pci_io = ioremap((ulong) hc->hw.pci_io, 256);
+	if (unlikely(!hc->hw.pci_io)) {
+		printk(KERN_WARNING
+		       "HFC-PCI: Error in ioremap for PCI!\n");
+		pci_free_consistent(hc->pdev, 0x8000, hc->hw.fifos,
+				    hc->hw.dmahandle);
+		return 1;
+	}
+
 	printk(KERN_INFO
 	       "HFC-PCI: defined at mem %#lx fifo %#lx(%#lx) IRQ %d HZ %d\n",
 	       (u_long) hc->hw.pci_io, (u_long) hc->hw.fifos,
 	       (u_long) hc->hw.dmahandle, hc->irq, HZ);
+
 	/* enable memory mapped ports, disable busmaster */
 	pci_write_config_word(hc->pdev, PCI_COMMAND, PCI_ENA_MEMIO);
 	hc->hw.int_m2 = 0;
-- 
2.17.1

