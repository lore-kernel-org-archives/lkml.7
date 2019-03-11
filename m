Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80431C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1522075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="J/qyMzkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfCKFe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 01:34:57 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:38964 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfCKFe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 01:34:57 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 875B5A93
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 05:34:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Tk4cXPJltSqP for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 00:34:55 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 5C87A87A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 00:34:55 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id 190so4106036itv.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 22:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IIwBByuKrGjNRZJQLNi5VG3nQ6wnw8s3N/1S/7GaWeI=;
        b=J/qyMzkteoC/rGJXtgjdxmkuVxtxQ4E7hIempYBbETG+qtz5U1InPMnL03hDYB2hRb
         3iDiUk7ZOeD94ltQUKLrjvhMBoBdlbQ+hf0iYgb+7J2uYlX+qJOA7kc+MAeQbjHIboqT
         3UNyx0DCOUtstdZxA3XnFtGKkYS6usfIS+GCc2R4Jg4fhbz+eUqdRdn05DngB/A9bvgs
         oyt/gZaxwNfEuxokh1O8l22sd4lMqDnLNYvWo31i9sZtmVOWFFQMDECRceNjTXKEGW9D
         coMGAeGonEHnvZGkVS2JnUaiN9kKste/sIFALGGL8YAzWiqjZqWFrITwj89j6zVAnC80
         pGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IIwBByuKrGjNRZJQLNi5VG3nQ6wnw8s3N/1S/7GaWeI=;
        b=N+clLCsRewNqiwthgxd24SQ4j0vOBh/Zn4myA2gRVkX+ZEPtfjOdnfAGeBZfsPCfzy
         9R3V4HkxtCONCkhijtJtId3TQ8n1aDEZpg2zPGE5Bhb8RddiN++NRHz0wNGQUDwI9Wgr
         977sAyiEVZO4/Rd9v2Wyup/qoBdjvzQOztBjfy7auzBHKqCRHF6EuHOEZaXeTONzCt8Q
         l2tn591YZiJE2MXyu0Eg+zvWyEw+w9+XtbGQY4CHoHyWOxyhwavQ5hs3MGsI+UaZIo+7
         mbWxfDMY0xUwpTI9BBH1kFXP8SEze4vUAJNh2D+b7qSWZ3LaTbScrJdeJFTcMhVFbqfv
         gDvA==
X-Gm-Message-State: APjAAAV1qQL6olrUfmWs3/n+RA8wyFfKkezcN7zKYUBVUTL7XFWem6w8
        Y/uD+L7aSs1llGmOl0mVceTT4JB+SKhGMxK/Htp2RbCjGxboh3HEvNC6epTTdDduWWCR9Nw9Wv9
        cMg0ZHnOFDYm7fI2xOBlZ/VFr9LbX
X-Received: by 2002:a6b:6003:: with SMTP id r3mr11269784iog.231.1552282494936;
        Sun, 10 Mar 2019 22:34:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw8zfvzgTkjoQuoBSj+nkc+iCrh0FAx5SKv7ukL66qsizQPzzRTi/64iFgdCEuwb0N5+p8xtQ==
X-Received: by 2002:a6b:6003:: with SMTP id r3mr11269778iog.231.1552282494683;
        Sun, 10 Mar 2019 22:34:54 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id 14sm7636013ity.24.2019.03.10.22.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 22:34:53 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] isdn: hfcpci: fix potential NULL pointer dereference
Date:   Mon, 11 Mar 2019 00:34:34 -0500
Message-Id: <20190311053436.10747-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case ioremap fails, the fix releases resources and returns.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/isdn/hardware/mISDN/hfcpci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/isdn/hardware/mISDN/hfcpci.c b/drivers/isdn/hardware/mISDN/hfcpci.c
index ebb3fa2e1d00..d1d53c5de3c0 100644
--- a/drivers/isdn/hardware/mISDN/hfcpci.c
+++ b/drivers/isdn/hardware/mISDN/hfcpci.c
@@ -2036,6 +2036,12 @@ setup_hw(struct hfc_pci *hc)
 	       "HFC-PCI: defined at mem %#lx fifo %#lx(%#lx) IRQ %d HZ %d\n",
 	       (u_long) hc->hw.pci_io, (u_long) hc->hw.fifos,
 	       (u_long) hc->hw.dmahandle, hc->irq, HZ);
+	if (unlikely(!hc->hw.pci_io)) {
+		pci_free_consistent(hc->pdev, 0x8000, hc->hw.fifos,
+				    hc->hw.dmahandle);
+		return 1;
+	}
+
 	/* enable memory mapped ports, disable busmaster */
 	pci_write_config_word(hc->pdev, PCI_COMMAND, PCI_ENA_MEMIO);
 	hc->hw.int_m2 = 0;
-- 
2.17.1

