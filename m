Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67B6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A8D2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259144;
	bh=lwxJepbfjhZ9cN0ewxbJHfURHWPd+arRGY2DE3Gh02w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ab0/G4pEtVXQI21sqBTrC4LgJyYcxRzGVcTfReHNP3c6RBM75KvCcibUOmEjENu9r
	 ug9aY6h+cyyykmGsA2zPCcP0za+F7D7+wWmbdi9edbG8DBX+/B8DMoykILzHdGEtMN
	 qSiIpJO87wU3ijcJrowzq14ga35avHSqJtkvAO5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732920AbfCVMwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:52:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733030AbfCVLxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:53:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48D542082C;
        Fri, 22 Mar 2019 11:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255604;
        bh=lwxJepbfjhZ9cN0ewxbJHfURHWPd+arRGY2DE3Gh02w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cwcBERKBWzD4UUP7qG/kpkmjlFpeeJ6LmQrFomDlzbyKOCDAdgYTdlmzODrFHVojn
         DMTvexo70J5adsHWSchmq2eMT9Stq45tT13ML284NHCJafszu78/KuTTX2iFv/XIjX
         XVi0Cqt6odXHj9+QIkPig2GGT3zcATFQgvQXr+Os=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH 4.14 134/183] serial: 8250_pci: Have ACCES cards that use the four port Pericom PI7C9X7954 chip use the pci_pericom_setup()
Date:   Fri, 22 Mar 2019 12:16:02 +0100
Message-Id: <20190322111251.457729630@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jay Dolan <jay.dolan@accesio.com>

commit 78d3820b9bd39028727c6aab7297b63c093db343 upstream.

The four port Pericom chips have the fourth port at the wrong address.
Make use of quirk to fix it.

Fixes: c8d192428f52 ("serial: 8250: added acces i/o products quad and octal serial cards")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Jay Dolan <jay.dolan@accesio.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_pci.c |  105 +++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2033,6 +2033,111 @@ static struct pci_serial_quirk pci_seria
 		.setup		= pci_default_setup,
 		.exit		= pci_plx9050_exit,
 	},
+	{
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
+		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SDB,
+		.subvendor  = PCI_ANY_ID,
+		.subdevice  = PCI_ANY_ID,
+		.setup      = pci_pericom_setup,
+	},
+	{
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
+		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_COM_4S,
+		.subvendor  = PCI_ANY_ID,
+		.subdevice  = PCI_ANY_ID,
+		.setup      = pci_pericom_setup,
+	},
+	{
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
+		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM232_4DB,
+		.subvendor  = PCI_ANY_ID,
+		.subdevice  = PCI_ANY_ID,
+		.setup      = pci_pericom_setup,
+	},
+	{
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
+		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_COM232_4,
+		.subvendor  = PCI_ANY_ID,
+		.subdevice  = PCI_ANY_ID,
+		.setup      = pci_pericom_setup,
+	},
+	{
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
+		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SMDB,
+		.subvendor  = PCI_ANY_ID,
+		.subdevice  = PCI_ANY_ID,
+		.setup      = pci_pericom_setup,
+	},
+	{
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
+		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_COM_4SM,
+		.subvendor  = PCI_ANY_ID,
+		.subdevice  = PCI_ANY_ID,
+		.setup      = pci_pericom_setup,
+	},
+	{
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
+		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_ICM422_4,
+		.subvendor  = PCI_ANY_ID,
+		.subdevice  = PCI_ANY_ID,
+		.setup      = pci_pericom_setup,
+	},
+	{
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
+		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_ICM485_4,
+		.subvendor  = PCI_ANY_ID,
+		.subdevice  = PCI_ANY_ID,
+		.setup      = pci_pericom_setup,
+	},
+	{
+		.vendor     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4S,
+		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM232_4,
+		.subvendor  = PCI_ANY_ID,
+		.subdevice  = PCI_ANY_ID,
+		.setup      = pci_pericom_setup,
+	},
+	{
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
+		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_ICM232_4,
+		.subvendor  = PCI_ANY_ID,
+		.subdevice  = PCI_ANY_ID,
+		.setup      = pci_pericom_setup,
+	},
+	{
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
+		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM422_4,
+		.subvendor  = PCI_ANY_ID,
+		.subdevice  = PCI_ANY_ID,
+		.setup      = pci_pericom_setup,
+	},
+	{
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
+		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM485_4,
+		.subvendor  = PCI_ANY_ID,
+		.subdevice  = PCI_ANY_ID,
+		.setup      = pci_pericom_setup,
+	},
+	{
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
+		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM232_4,
+		.subvendor  = PCI_ANY_ID,
+		.subdevice  = PCI_ANY_ID,
+		.setup      = pci_pericom_setup,
+	},
+	{
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
+		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SM,
+		.subvendor  = PCI_ANY_ID,
+		.subdevice  = PCI_ANY_ID,
+		.setup      = pci_pericom_setup,
+	},
+	{
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
+		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4SM,
+		.subvendor  = PCI_ANY_ID,
+		.subdevice  = PCI_ANY_ID,
+		.setup      = pci_pericom_setup,
+	},
 	/*
 	 * SBS Technologies, Inc., PMC-OCTALPRO 232
 	 */


