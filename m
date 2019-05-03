Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE638C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 04:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFB22070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 04:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="ZI/oDJAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfECEAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 00:00:17 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34936 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfECEAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 00:00:16 -0400
Received: by mail-oi1-f195.google.com with SMTP id w197so3492848oia.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 21:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rUTSw74gexjNwzq9ZLmaaBHpeJsduJxpcMlGupfmHG4=;
        b=ZI/oDJADO4rOIoCDUnEV0PbQiau5ydorvrx+xZUz6wqYvpFKXYpKjD09gcXjvLJpdH
         2cQCCQkAcf+0n06uPKjdHDUPcXEiKHbg9eHm4XK5AKX46KEiyP+pPzgBnYQefV/+vyFh
         cKwAIAGh1P4P5VUSJXf4iQx4iVu1ouPvCqcGu2oL9SU61i14VDndeWAEL2v38AtIDuwz
         NfC49wl8dxQpI9tFDfxwSsZT0qZQ84eYQLUd8B2wLOvZph01gOCgwANcJvzZ1M9yJi2X
         QFstesEHaDZOYE2n1xzsV0Y0VgXBrnuSBUuBnbB9Zukz/1DEfi6xPsaduTPskGLbajRv
         KE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rUTSw74gexjNwzq9ZLmaaBHpeJsduJxpcMlGupfmHG4=;
        b=hUFzU2+zPiA367BivmJ5sl8sDZJK/LjDh/YKu3cuX78fMBY3AyQVhvFrJjtDEUV2/z
         4c9CEpvVqv4QRG1ryIojQgAYsjSiRYegdOUL5/zAICWOviIF2WaEhjkGNEbzR2gbNwb3
         Ip5TOtRC+T9UJRA/RXnzFOkpVm93P1jXvl/g9EivZ2Zd3KzdHMSyzx+j3XsSVzObZmfz
         k56CDsdorzp+Sulr0jiJFAeZwGgpIdbVdhZYF3O3Q/xAMKGI8AtT84bhF6nz5CT+L5+m
         Pv5yNnfyn21SYDJGYLC4b9mb0nmBRUf2jWrX3vEEE3/UdAxunBgb8k8Qzzp299xbmZes
         1vLA==
X-Gm-Message-State: APjAAAUqsuk0wxMwUexafKiGJebAOunCKUJ/EijXkWnv68oULw2s5Aak
        KvDHUHnQ5R7vXAI/fZH/4iPmng==
X-Google-Smtp-Source: APXvYqytlEstswINkPkyIA6Dj4cZY6kaWgFkfd4RiLPYDmMNxSqqtMj7RyWp3JbDg58d1b+iaPcNAA==
X-Received: by 2002:aca:5b85:: with SMTP id p127mr4620755oib.90.1556856015507;
        Thu, 02 May 2019 21:00:15 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:5518:38b8:ef25:393a])
        by smtp.gmail.com with ESMTPSA id 20sm622436oty.58.2019.05.02.21.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 21:00:14 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v2 1/9] PCI/AER: Cleanup dmesg logs
Date:   Thu,  2 May 2019 22:59:38 -0500
Message-Id: <20190503035946.23608-2-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503035946.23608-1-fred@fredlawl.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup dmesg logs.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/pci/pcie/aer.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f8fc2114ad39..82eb45335b6f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -964,8 +964,8 @@ static bool find_source_device(struct pci_dev *parent,
 	pci_walk_bus(parent->subordinate, find_device_iter, e_info);
 
 	if (!e_info->error_dev_num) {
-		pci_printk(KERN_DEBUG, parent, "can't find device of ID%04x\n",
-			   e_info->id);
+		pci_info(parent, "can't find device of ID%04x\n",
+			 e_info->id);
 		return false;
 	}
 	return true;
@@ -1380,7 +1380,6 @@ static int aer_probe(struct pcie_device *dev)
 
 	rpc = devm_kzalloc(device, sizeof(struct aer_rpc), GFP_KERNEL);
 	if (!rpc) {
-		dev_printk(KERN_DEBUG, device, "alloc AER rpc failed\n");
 		return -ENOMEM;
 	}
 	rpc->rpd = dev->port;
@@ -1389,8 +1388,8 @@ static int aer_probe(struct pcie_device *dev)
 	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
 					   IRQF_SHARED, "aerdrv", dev);
 	if (status) {
-		dev_printk(KERN_DEBUG, device, "request AER IRQ %d failed\n",
-			   dev->irq);
+		dev_err(device, "request AER IRQ %d failed\n",
+			dev->irq);
 		return status;
 	}
 
@@ -1419,7 +1418,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
 	rc = pci_bus_error_reset(dev);
-	pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
+	pci_info(dev, "Root Port link has been reset\n");
 
 	/* Clear Root Error Status */
 	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
-- 
2.17.1

