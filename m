Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DCAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84E720830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140486;
	bh=KFsXn4+nh2YdtoFA7FzslTKhJ7Wyuk4NYgYHu4led9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MbuEJWgD2eRBap/enJOchLWFGmw5pvQpuMLgBkfMZd8yRcZuZSMxfEEDLilF6E1xx
	 ZnbTZlHdFG4jJeTK0uC/NtBl80i9EMfvMNndwUu67DLoTOiy1aXXNQSnzzsR8yTXww
	 JJV5HKyGExourG4UJWSH6ZKe6YD9B9kaamp5gKJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbfDARiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388288AbfDARiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:38:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AD862070B;
        Mon,  1 Apr 2019 17:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140286;
        bh=KFsXn4+nh2YdtoFA7FzslTKhJ7Wyuk4NYgYHu4led9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BY+z0Naogq3rsIeH7AHH+qE6LBLlThpmFkkpmISwzRFwbAZ7SD7CuzIT2oNmtEWoc
         sc9vvSKQ8ZiPtt341hPeDkyHaU5xzIW53ZMrpAvvDCMCmzbeMhzaN33kTJD4D8IqLR
         CAliREKPfRMOnG9B5uBWIwswLl5nnuZ/tyOTj594=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 29/50] mISDN: hfcpci: Test both vendor & device ID for Digium HFC4S
Date:   Mon,  1 Apr 2019 19:03:12 +0200
Message-Id: <20190401170044.460157269@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit fae846e2b7124d4b076ef17791c73addf3b26350 ]

The device ID alone does not uniquely identify a device.  Test both the
vendor and device ID to make sure we don't mistakenly think some other
vendor's 0xB410 device is a Digium HFC4S.  Also, instead of the bare hex
ID, use the same constant (PCI_DEVICE_ID_DIGIUM_HFC4S) used in the device
ID table.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/isdn/hardware/mISDN/hfcmulti.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/isdn/hardware/mISDN/hfcmulti.c
+++ b/drivers/isdn/hardware/mISDN/hfcmulti.c
@@ -4370,7 +4370,8 @@ setup_pci(struct hfc_multi *hc, struct p
 	if (m->clock2)
 		test_and_set_bit(HFC_CHIP_CLOCK2, &hc->chip);
 
-	if (ent->device == 0xB410) {
+	if (ent->vendor == PCI_VENDOR_ID_DIGIUM &&
+	    ent->device == PCI_DEVICE_ID_DIGIUM_HFC4S) {
 		test_and_set_bit(HFC_CHIP_B410P, &hc->chip);
 		test_and_set_bit(HFC_CHIP_PCM_MASTER, &hc->chip);
 		test_and_clear_bit(HFC_CHIP_PCM_SLAVE, &hc->chip);


