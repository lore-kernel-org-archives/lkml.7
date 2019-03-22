Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E421DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B370E21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255669;
	bh=oCD2WDRsei9/GO+kq4duLLar1qEf9obAt2DzX2nmDQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JVLq6uFEiLFvg1yf+TAzXwlQ50/oQXtnLXqi2jBTg9vXDIhhau3TYKdkODJiEjEyl
	 SyL+NhPOhYCW4zm/8ZiPAUfAhtvgdpjyl16Z5PknplYIIk0gjeESiX2DyjiT4jCzTB
	 nRIuRlAw7POpKFgha1DAPqFtdNpmlb4XIvfxo2Dc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733185AbfCVLy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732835AbfCVLy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:54:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B167F2192B;
        Fri, 22 Mar 2019 11:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255665;
        bh=oCD2WDRsei9/GO+kq4duLLar1qEf9obAt2DzX2nmDQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZ0deGZf4zkTRLsMAB274sK5TKfvA6r0NQs8uXJ/tK7Kl59nfWUO3zTZvaZuLaXKq
         XWzv9wFSeyJ+D8j36lQNMjpB66TPh6dL/+b6ViIXm9ckf3bNgBsbFtiTaSJ/88qhX/
         11oXmVO9exf7Qf/oqdUpsMvlZiO4wVf0fEorau3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH 4.14 133/183] serial: 8250_pci: Fix number of ports for ACCES serial cards
Date:   Fri, 22 Mar 2019 12:16:01 +0100
Message-Id: <20190322111251.391668570@linuxfoundation.org>
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
@@ -4580,10 +4580,10 @@ static const struct pci_device_id serial
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
@@ -4592,10 +4592,10 @@ static const struct pci_device_id serial
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
@@ -4604,10 +4604,10 @@ static const struct pci_device_id serial
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
@@ -4616,13 +4616,13 @@ static const struct pci_device_id serial
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
@@ -4631,16 +4631,16 @@ static const struct pci_device_id serial
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
@@ -4649,13 +4649,13 @@ static const struct pci_device_id serial
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
@@ -4664,19 +4664,19 @@ static const struct pci_device_id serial
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


