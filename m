Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D4DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8742073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="icMa4rx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfLCPn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:43:27 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34934 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfLCPn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:43:27 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so1850058pgk.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 07:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=b4QI//StRs4CfOqNK9eqzKkxRA2qL4/GWMuaqRRnuEU=;
        b=icMa4rx1ZMtE5mnOvVjmI5EmCAMki8keD1M3g2P0oLuo3vA1I4BJW9vCZHa3KzebQg
         gX8+tYGFryfM9B+JfdjFEuj/FnbP8ZaCdaIDSiP3gkT1m0rpfhYO5EtPm7NjSH7S92Q7
         Ckqx4GyGRmfWn/wQqCRffS+ElnSoMBGBGth1jD5cGB+NLc6HwogzaEQ5JaZaQ+09fyJ5
         APB4eEpHr2arpYyM55WyB3NqajX3n1/4dS3wDV6IYKjWg0IFVruXrBB9sudTsjGZzqPC
         sKm0dZxtL526oFKECCvin+Dw51/efc/ZJh7TmRSFhL7ClWy/kOzTqCN7bOU+hrHOP387
         9vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=b4QI//StRs4CfOqNK9eqzKkxRA2qL4/GWMuaqRRnuEU=;
        b=aneqSfT9/ZZ5F4hajF9hBkci0EgEXxfQ73mzH7+PvulwBQormeiizj+KeKnfnsAgjm
         V6Dw0L/t5lQHC2L7zf6jNKHnAgIOLA081fy1k8xp6dZnUdTzjfNl6WxqiieRmiZzEUt+
         SW7iU1y7EpHkKLd6Jo1CsNxPjcgFfljn8Y7AZ9wjMvl5EYinAT3eOp0/GhuXdVrK6Ejf
         9SkRqTVWpsidf/Iyg+b190mBiOBGC5jUOftb/ZjXUlfurHitZfg0a4+KjdvvwAUhAFjl
         JSSDxlDams7eYPiol/SREdbEYxx+c/zd3qagXuyu6WP7lwzmMageA+geH3rs/pmGt4Ww
         gwng==
X-Gm-Message-State: APjAAAVaxGmKzF9Vs6q2BxoCvOJV2SoRoXERUXPj3fE4NAATgDjIaxEM
        cglPtVgMXdSCRKA5LLWiRd7UbQ==
X-Google-Smtp-Source: APXvYqy5sg3uYP2PMY30/llWMY51RYB4brhQFWOKQRquMLOrHznUnkMZQ43OVqK+IyKd3Jqdc+RmFw==
X-Received: by 2002:a63:1624:: with SMTP id w36mr5602893pgl.404.1575387806408;
        Tue, 03 Dec 2019 07:43:26 -0800 (PST)
Received: from [10.83.42.232] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id e11sm3953969pgh.54.2019.12.03.07.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 07:43:25 -0800 (PST)
From:   James Sewart <jamessewart@arista.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v6 1/3] PCI: Fix off by one in dma_alias_mask allocation size
Message-Id: <910070E3-7964-4549-B77F-EC7FC6144503@arista.com>
Date:   Tue, 3 Dec 2019 15:43:22 +0000
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of possible devfns is 256, add def and correct uses.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/pci/pci.c    | 2 +-
 drivers/pci/search.c | 2 +-
 include/linux/pci.h  | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a97e2571a527..d3c83248f3ce 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5876,7 +5876,7 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
 {
 	if (!dev->dma_alias_mask)
-		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
+		dev->dma_alias_mask = bitmap_zalloc(MAX_NR_DEVFNS, GFP_KERNEL);
 	if (!dev->dma_alias_mask) {
 		pci_warn(dev, "Unable to allocate DMA alias mask\n");
 		return;
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index bade14002fd8..9e4dfae47252 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -43,7 +43,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 	if (unlikely(pdev->dma_alias_mask)) {
 		u8 devfn;
 
-		for_each_set_bit(devfn, pdev->dma_alias_mask, U8_MAX) {
+		for_each_set_bit(devfn, pdev->dma_alias_mask, MAX_NR_DEVFNS) {
 			ret = fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
 				 data);
 			if (ret)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1a6cf19eac2d..6481da29d667 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -57,6 +57,8 @@
 #define PCI_DEVID(bus, devfn)	((((u16)(bus)) << 8) | (devfn))
 /* return bus from PCI devid = ((u16)bus_number) << 8) | devfn */
 #define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
+/* Number of possible devfns. devfns can be from 0.0 to 1f.7 inclusive */
+#define MAX_NR_DEVFNS 256
 
 /* pci_slot represents a physical slot */
 struct pci_slot {
-- 
2.24.0


