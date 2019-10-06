Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670A1C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411062080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383454;
	bh=hkctlvyNTnBfIMJFghBmAj+o0d3mrZHtRkI+IrQdr+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=er+DdEsSLT1OxVDnr/QyFwvJyAtSEtL0+LqMGVBtvV3Iv2rhD1lgbpkAGh7Ktg7Bs
	 JqOGLunyAlmazV9yo95AsGCizFzAYuAVte1pn8ssTPXUkytjq/+/HUQ9Xvvf6nj57l
	 SyyK0P8xhU5gmAm4xa1a/XOeflrMeCOJOq6KwTpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbfJFRhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729495AbfJFRha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:37:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 927342080F;
        Sun,  6 Oct 2019 17:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383449;
        bh=hkctlvyNTnBfIMJFghBmAj+o0d3mrZHtRkI+IrQdr+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VEDsER8qBA3zKBW0FwJvDPjA7oUXbFJjcm6zfv9cVHhEPiBzsuxWoe0boygbnFWQc
         V9VnkxKHkI7yxMpPNBNTVKYze9iqcNEW4T2f3CYBRO1dR+CK2eVvuzXFoQtich4N2s
         5mMCEAHqiBAosPAM/8E0yfV6nIVWHNCH/pEFT9MI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 108/137] PCI: Add pci_info_ratelimited() to ratelimit PCI separately
Date:   Sun,  6 Oct 2019 19:21:32 +0200
Message-Id: <20191006171217.986222664@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Wilczynski <kw@linux.com>

[ Upstream commit 7f1c62c443a453deb6eb3515e3c05650ffe0dcf0 ]

Do not use printk_ratelimit() in drivers/pci/pci.c as it shares the rate
limiting state with all other callers to the printk_ratelimit().

Add pci_info_ratelimited() (similar to pci_notice_ratelimited() added in
the commit a88a7b3eb076 ("vfio: Use dev_printk() when possible")) and use
it instead of printk_ratelimit() + pci_info().

Link: https://lore.kernel.org/r/20190825224616.8021-1-kw@linux.com
Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c   | 4 ++--
 include/linux/pci.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 088fcdc8d2b4d..f2ab112c0a71f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -884,8 +884,8 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
-	if (dev->current_state != state && printk_ratelimit())
-		pci_info(dev, "Refused to change power state, currently in D%d\n",
+	if (dev->current_state != state)
+		pci_info_ratelimited(dev, "Refused to change power state, currently in D%d\n",
 			 dev->current_state);
 
 	/*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dd436da7eccc1..9feb59ac85507 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2375,4 +2375,7 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #define pci_notice_ratelimited(pdev, fmt, arg...) \
 	dev_notice_ratelimited(&(pdev)->dev, fmt, ##arg)
 
+#define pci_info_ratelimited(pdev, fmt, arg...) \
+	dev_info_ratelimited(&(pdev)->dev, fmt, ##arg)
+
 #endif /* LINUX_PCI_H */
-- 
2.20.1



