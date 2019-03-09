Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8896DC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5440E2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="K+ybUmVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfCIFqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 00:46:16 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:32860 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfCIFqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 00:46:14 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 9F722CF4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 05:46:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3JWXJF4hHNra for <linux-kernel@vger.kernel.org>;
        Fri,  8 Mar 2019 23:46:12 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 6849CCBB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 23:46:12 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id 190so13628167itl.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 21:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kj3Bwn80ubs82fDZHjDLBwS3FXvCPwH2tZMLIqJf2TQ=;
        b=K+ybUmVT5SZmm4OrP7we4tQyvzSc9oUlG/gdknZASS6XBsROwPMoTFtqF9vdxPyrxL
         e8a4yxqOiP5jmzG1+Yv8mOltg94N4L/83Mzz4crdlCrpQgb+222QVniUrVnMHv7XO3e1
         6fsXjAJfypiYkdwYhpKnznYxcdosVcPvxftXz7kadyjx2M127X2adb4e1YYg2UB1JCkP
         n0xmUyLD/SjQnOtxZvMk/Z7z0DsiDUsxngFb9J6+A8mCyEatgwB/DbUArkCqkJP+b3/M
         aCCpQCKebQ538IQ+/P02cYm84gK1+FIGtZatuYTnSo7g03lprnrsKmVUz/SocVGSP1MM
         e+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kj3Bwn80ubs82fDZHjDLBwS3FXvCPwH2tZMLIqJf2TQ=;
        b=suikKWQWNBARmmoi+wcfgRfhhRdfN+ldUd/0i2csmKD2U8nkMqHHhinvrEUfDeTvO8
         2tj/2uvR9pNVV5Cwcc96C+bkSnZwkoqSI5eXHRSka7A+NETlfa7v6lrwS79n5hd0odh3
         vM7OZrFPpYNWxCC8mqfaP7SnfnD3IGDo48NcqaYU0/hC3oW8fPTY4Lk6L4A+MjO+3NEZ
         KR3nTGzImw84moucR4Va8PeC5r3w7eocuJzZ/hHHfqqkz3/nL67z2qKj0dcoVO/sGB5R
         IeKtL4tj769cKI55SIsgGGW4/MtSRbfG8SU1YZu7zG/0lgEMLXBhXJm8pPNlTfePJMFe
         35VA==
X-Gm-Message-State: APjAAAUCmFy2E34rVGnnLhNVxjGTjLd9eY7yIUSo4qBrvIwoG0Y/6Rtt
        xwCoUXQ7wcGF7y7BVTPWzOtByTDtcZpKUvFBJ92oj7YS3vr0rbD0SN/Bu81coiDBmxwF3t/ygZw
        mNjCOrycv3A2ZymqewlyQWqu7gHc5
X-Received: by 2002:a5e:8403:: with SMTP id h3mr1967170ioj.116.1552110371991;
        Fri, 08 Mar 2019 21:46:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqyHv9uCA7OgziikVT58JmC1x5tGCp3tYtAbHt4HTQq9QybNa+m1Ay17FRKHKh3+aNFAFCt8ng==
X-Received: by 2002:a5e:8403:: with SMTP id h3mr1967156ioj.116.1552110371753;
        Fri, 08 Mar 2019 21:46:11 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id l131sm5459690itc.17.2019.03.08.21.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 21:46:11 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] isdn: hfcpci: fix potential NULL pointer dereference
Date:   Fri,  8 Mar 2019 23:46:04 -0600
Message-Id: <20190309054605.23912-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case ioremap fails, the fix reports an error and returns.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/isdn/hardware/mISDN/hfcpci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/isdn/hardware/mISDN/hfcpci.c b/drivers/isdn/hardware/mISDN/hfcpci.c
index ebb3fa2e1d00..b400d6528a56 100644
--- a/drivers/isdn/hardware/mISDN/hfcpci.c
+++ b/drivers/isdn/hardware/mISDN/hfcpci.c
@@ -2036,6 +2036,11 @@ setup_hw(struct hfc_pci *hc)
 	       "HFC-PCI: defined at mem %#lx fifo %#lx(%#lx) IRQ %d HZ %d\n",
 	       (u_long) hc->hw.pci_io, (u_long) hc->hw.fifos,
 	       (u_long) hc->hw.dmahandle, hc->irq, HZ);
+	if (unlikely(!hc->hw.pci_io)) {
+		printk(KERN_WARNING
+		       "HFC-PCI: ioremap failed!\n");
+		return 1;
+	}
 	/* enable memory mapped ports, disable busmaster */
 	pci_write_config_word(hc->pdev, PCI_COMMAND, PCI_ENA_MEMIO);
 	hc->hw.int_m2 = 0;
-- 
2.17.1

