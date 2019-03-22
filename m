Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E317EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CC02192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257196;
	bh=MvxTez8BdncWhSC14f1JBvnj3jtndZWenKYuxALknKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eKLNarY9YTRYDVrO3/d2v75CHEdIbJbDhVsYADsO3skgae5YEaazFTy0PBBOMhMIS
	 B+hWsYia1FM9S7YjEmnXATEPSX6RxtD0U0fcCITd7QAAXZSlhS/XRzF01Q9oRtBev7
	 nIJqPArFE624kZKol+QN6yfeH9CuFPy6A5xWCgOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390343AbfCVMTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390168AbfCVMTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:19:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B60B218A1;
        Fri, 22 Mar 2019 12:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257189;
        bh=MvxTez8BdncWhSC14f1JBvnj3jtndZWenKYuxALknKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmN28fVOwHYdrfu/O9uV8glCkeCJ1N8/z5sOjsCQUnvmcsQWnxvCHtrogvoCm1Fwg
         bWqlbtnVVbkelih7D2U2MbUNKfKBnK1mPq/wCsZ9M03tdSUShgchLTW0JTNx2tnqlp
         8/vQFX4WVeXZfYfQOiJsQzCTq86hIPbDen/fiylw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 5.0 128/238] PCI/DPC: Fix print AER status in DPC event handling
Date:   Fri, 22 Mar 2019 12:15:47 +0100
Message-Id: <20190322111306.054786558@linuxfoundation.org>
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

From: Dongdong Liu <liudongdong3@huawei.com>

commit 9f08a5d896ce43380314c34ed3f264c8e6075b80 upstream.

Previously dpc_handler() called aer_get_device_error_info() without
initializing info->severity, so aer_get_device_error_info() relied on
uninitialized data.

Add dpc_get_aer_uncorrect_severity() to read the port's AER status, mask,
and severity registers and set info->severity.

Also, clear the port's AER fatal error status bits.

Fixes: 8aefa9b0d910 ("PCI/DPC: Print AER status in DPC event handling")
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
[bhelgaas: changelog]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Cc: stable@vger.kernel.org	# v4.19+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pcie/dpc.c |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -202,6 +202,28 @@ static void dpc_process_rp_pio_error(str
 	pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS, status);
 }
 
+static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
+					  struct aer_err_info *info)
+{
+	int pos = dev->aer_cap;
+	u32 status, mask, sev;
+
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &mask);
+	status &= ~mask;
+	if (!status)
+		return 0;
+
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
+	status &= sev;
+	if (status)
+		info->severity = AER_FATAL;
+	else
+		info->severity = AER_NONFATAL;
+
+	return 1;
+}
+
 static irqreturn_t dpc_handler(int irq, void *context)
 {
 	struct aer_err_info info;
@@ -229,9 +251,12 @@ static irqreturn_t dpc_handler(int irq,
 	/* show RP PIO error detail information */
 	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
 		dpc_process_rp_pio_error(dpc);
-	else if (reason == 0 && aer_get_device_error_info(pdev, &info)) {
+	else if (reason == 0 &&
+		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
+		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
 		pci_cleanup_aer_uncorrect_error_status(pdev);
+		pci_aer_clear_fatal_status(pdev);
 	}
 
 	/* We configure DPC so it only triggers on ERR_FATAL */


