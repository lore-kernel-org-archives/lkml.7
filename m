Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B232CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B1A20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552917083;
	bh=vojxR7jHXkK5DhdRYlkBiwpeCJK+6+mYmtEgl5Tlc8o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qeIVzHU/Mpq5wntIXcY0GAz9zv4BOJpr63AKWhQMWIIqUIG4N5atJeL3GiN36b4X2
	 00QeM1g8Xv/AXQywI2BRyyAhcvQEMItM9KMQUPLPeext8WWC2lng1FbOzI1I5jglGg
	 CWzBimKLKyL7RiFnssn53mqsYNA+yfzF0DkdDPk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfCRNvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfCRNvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:51:21 -0400
Received: from localhost (173-28-64-202.client.mchsi.com [173.28.64.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC86520857;
        Mon, 18 Mar 2019 13:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552917081;
        bh=vojxR7jHXkK5DhdRYlkBiwpeCJK+6+mYmtEgl5Tlc8o=;
        h=From:To:Cc:Subject:Date:From;
        b=W6WQNnqfHv1cJFYXzIdcLao/XD61E7fUy2v8AsIMMieiKhrltYJPr00Sm1UNcvanH
         7cdzGVh8QuKHm7tW8bSgaNTy3LpnCag4ZBdbKhDlXIZphiZiaZdBycSCKbq7W8aXnk
         wDevnFCuVB6t4eG3y5yRvrPB9GEpgfrClvrZ38Ns=
From:   helgaas@kernel.org
To:     Karsten Keil <isdn@linux-pingi.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] mISDN: hfcpci: Test both vendor & device ID for Digium HFC4S
Date:   Mon, 18 Mar 2019 08:51:06 -0500
Message-Id: <20190318135106.43603-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The device ID alone does not uniquely identify a device.  Test both the
vendor and device ID to make sure we don't mistakenly think some other
vendor's 0xB410 device is a Digium HFC4S.  Also, instead of the bare hex
ID, use the same constant (PCI_DEVICE_ID_DIGIUM_HFC4S) used in the device
ID table.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/isdn/hardware/mISDN/hfcmulti.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcmulti.c b/drivers/isdn/hardware/mISDN/hfcmulti.c
index 4d85645c87f7..0928fd1f0e0c 100644
--- a/drivers/isdn/hardware/mISDN/hfcmulti.c
+++ b/drivers/isdn/hardware/mISDN/hfcmulti.c
@@ -4365,7 +4365,8 @@ setup_pci(struct hfc_multi *hc, struct pci_dev *pdev,
 	if (m->clock2)
 		test_and_set_bit(HFC_CHIP_CLOCK2, &hc->chip);
 
-	if (ent->device == 0xB410) {
+	if (ent->vendor == PCI_VENDOR_ID_DIGIUM &&
+	    ent->device == PCI_DEVICE_ID_DIGIUM_HFC4S) {
 		test_and_set_bit(HFC_CHIP_B410P, &hc->chip);
 		test_and_set_bit(HFC_CHIP_PCM_MASTER, &hc->chip);
 		test_and_clear_bit(HFC_CHIP_PCM_SLAVE, &hc->chip);
-- 
2.21.0.225.g810b269d1ac-goog

