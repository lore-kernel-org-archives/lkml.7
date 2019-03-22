Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10621C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC0F2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257765;
	bh=84ty1k1Ynjf8wCQXegVIxbMr0dyfCAbv8DmUynwRX88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a/LHeqqQqRqFALnJgr0bAc071MLX7pDK55Nd80omLewJb5xcu3fnvLRkwpXvxDLIA
	 VNXFy30lD7DZf94RKF1vCRZkwliIJcnjX+s6yx0X588HFkwk3OmhOEWJtl0+Mv1/WK
	 gzC/rDP3ONM/ouft8uYiUXZMaKy/aVWtECCZuLx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390845AbfCVM3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390607AbfCVMTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:19:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09E912054F;
        Fri, 22 Mar 2019 12:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257159;
        bh=84ty1k1Ynjf8wCQXegVIxbMr0dyfCAbv8DmUynwRX88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRZu+C1+BuHunzjsG2SdoByrezFzW49CfU/LFiJXO0KApPkoa1CNafbuNnig9k5Eo
         8qNlSUNI5REqUXjz/ur5/HS0p2pbVP4QH3mfRxp3JoOxDpWD3SNKIhI0vZr5B0+z0K
         ubszDoeHV9LxRilhzo4OQ6Oi/bXf0sC6o1hQg4Qk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH 5.0 150/238] serial: 8250_pci: Fix number of ports for ACCES serial cards
Date:   Fri, 22 Mar 2019 12:16:09 +0100
Message-Id: <20190322111307.211408543@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jay Dolan <jay.dolan@accesio.com>

commit b896b03bc7fce43a07012cc6bf5e2ab2fddf3364 upstream.

Have the correct number of ports created for ACCES serial cards. Two port
cards show up as four ports, and four port cards show up as eight.

Fixes: c8d192428f52 ("serial: 8250: added acces i/o products quad and octal serial cards")
Signed-off-by: Jay Dolan <jay.dolan@accesio.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_pci.c |   36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4575,10 +4575,10 @@ static const struct pci_device_id serial
 	 */
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM_2SDB,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pericom_PI7C9X7954 },
+		pbn_pericom_PI7C9X7952 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_COM_2S,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pericom_PI7C9X7954 },
+		pbn_pericom_PI7C9X7952 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SDB,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_pericom_PI7C9X7954 },
@@ -4587,10 +4587,10 @@ static const struct pci_device_id serial
 		pbn_pericom_PI7C9X7954 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM232_2DB,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pericom_PI7C9X7954 },
+		pbn_pericom_PI7C9X7952 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_COM232_2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pericom_PI7C9X7954 },
+		pbn_pericom_PI7C9X7952 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM232_4DB,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_pericom_PI7C9X7954 },
@@ -4599,10 +4599,10 @@ static const struct pci_device_id serial
 		pbn_pericom_PI7C9X7954 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM_2SMDB,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pericom_PI7C9X7954 },
+		pbn_pericom_PI7C9X7952 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_COM_2SM,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pericom_PI7C9X7954 },
+		pbn_pericom_PI7C9X7952 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SMDB,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_pericom_PI7C9X7954 },
@@ -4611,13 +4611,13 @@ static const struct pci_device_id serial
 		pbn_pericom_PI7C9X7954 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_ICM485_1,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pericom_PI7C9X7954 },
+		pbn_pericom_PI7C9X7951 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_ICM422_2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pericom_PI7C9X7954 },
+		pbn_pericom_PI7C9X7952 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_ICM485_2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pericom_PI7C9X7954 },
+		pbn_pericom_PI7C9X7952 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_ICM422_4,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_pericom_PI7C9X7954 },
@@ -4626,16 +4626,16 @@ static const struct pci_device_id serial
 		pbn_pericom_PI7C9X7954 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_ICM_2S,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pericom_PI7C9X7954 },
+		pbn_pericom_PI7C9X7952 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4S,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_pericom_PI7C9X7954 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_ICM232_2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pericom_PI7C9X7954 },
+		pbn_pericom_PI7C9X7952 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_MPCIE_ICM232_2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pericom_PI7C9X7954 },
+		pbn_pericom_PI7C9X7952 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_ICM232_4,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_pericom_PI7C9X7954 },
@@ -4644,13 +4644,13 @@ static const struct pci_device_id serial
 		pbn_pericom_PI7C9X7954 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_ICM_2SM,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pericom_PI7C9X7954 },
+		pbn_pericom_PI7C9X7952 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM422_4,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pericom_PI7C9X7958 },
+		pbn_pericom_PI7C9X7954 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM485_4,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pericom_PI7C9X7958 },
+		pbn_pericom_PI7C9X7954 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM422_8,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_pericom_PI7C9X7958 },
@@ -4659,19 +4659,19 @@ static const struct pci_device_id serial
 		pbn_pericom_PI7C9X7958 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM232_4,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pericom_PI7C9X7958 },
+		pbn_pericom_PI7C9X7954 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM232_8,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_pericom_PI7C9X7958 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SM,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pericom_PI7C9X7958 },
+		pbn_pericom_PI7C9X7954 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_COM_8SM,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_pericom_PI7C9X7958 },
 	{	PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4SM,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pericom_PI7C9X7958 },
+		pbn_pericom_PI7C9X7954 },
 	/*
 	 * Topic TP560 Data/Fax/Voice 56k modem (reported by Evan Clarke)
 	 */


