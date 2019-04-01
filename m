Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74587C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CAC206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138842;
	bh=BCVQIym5xgrQxawIBzie0j8swrcRTot7fGfMy4XOqU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vr5zqrPTkniIZFgpbWdcHiSVgQT3kxvLQKGjbMAaDUh7OWFqPMP4InblzYtld19R0
	 /J5cYJw9hhgd+rkkSR3lzkhYJM/+A+953GvPkCAYXysXEAAWuHGekDbJo4FRRleqvV
	 8LfcxYFIxIYMdE3RdoD3WEPZtmgn/kkTWNzxplHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfDAROA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729872AbfDARN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:13:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8B9C21925;
        Mon,  1 Apr 2019 17:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138837;
        bh=BCVQIym5xgrQxawIBzie0j8swrcRTot7fGfMy4XOqU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJRJbeivfwteEkGZYu2cc6JB70C5UhIIemD6c1rI9kES+XZNNlu2mEM/EPpTH8O6M
         Ip+QAnEJFaTauI3Y1e78iUjwO0KTPo0DIKHF+q21WO8KoUXuHBu3qirwRr4w7TxgV0
         q3KWUr+Zx0xDblgORfull52QBfpq3gw9w6O1ecdU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 009/134] mISDN: hfcpci: Test both vendor & device ID for Digium HFC4S
Date:   Mon,  1 Apr 2019 19:00:45 +0200
Message-Id: <20190401170045.166027956@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4365,7 +4365,8 @@ setup_pci(struct hfc_multi *hc, struct p
 	if (m->clock2)
 		test_and_set_bit(HFC_CHIP_CLOCK2, &hc->chip);
 
-	if (ent->device == 0xB410) {
+	if (ent->vendor == PCI_VENDOR_ID_DIGIUM &&
+	    ent->device == PCI_DEVICE_ID_DIGIUM_HFC4S) {
 		test_and_set_bit(HFC_CHIP_B410P, &hc->chip);
 		test_and_set_bit(HFC_CHIP_PCM_MASTER, &hc->chip);
 		test_and_clear_bit(HFC_CHIP_PCM_SLAVE, &hc->chip);


