Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB7AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90D02190C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126009;
	bh=lKTDafnugXs1C19ugkJTfV+8Nyb0Wg0EnSfhH6NWDnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=naaOTSH/Fl0F4zh1TBoAkyT6eaYfOG1K6Wb+/e4GuIchFPBqvRakcy0ie5IxYTGLO
	 2sYlvrqXwjvx/rtJvaB6J1GUVgv5hh81p0AfF4d6Oui+IYPqz1iRXhEY5SXeCz2p1q
	 Jj/0LUdIdNZtbtMxCIq8z+bD8pACWgJ+8qnKSKPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbfDXRN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387879AbfDXRN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:13:26 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5A6121915;
        Wed, 24 Apr 2019 17:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126006;
        bh=lKTDafnugXs1C19ugkJTfV+8Nyb0Wg0EnSfhH6NWDnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tw7yXV9CzX8EZvGlRPJ80/Ls4W6mOl2QdiuGd5RDewKv0QtMcvyZHF77+lGezciSO
         ufeMaL4U9dWFo8rUaU6YmBYDzkNSptbATuP1H3CJnywJ5Dbs6Pfavj9bNPqXj7PV8O
         5EsOgN6IFBqinwWMkybNHX6kzWiLa652GTxZlwxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3.18 059/104] PCI: Add function 1 DMA alias quirk for Marvell 9170 SATA controller
Date:   Wed, 24 Apr 2019 19:09:16 +0200
Message-Id: <20190424170903.607619009@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Przywara <andre.przywara@arm.com>

commit 9cde402a59770a0669d895399c13407f63d7d209 upstream.

There is a Marvell 88SE9170 PCIe SATA controller I found on a board here.
Some quick testing with the ARM SMMU enabled reveals that it suffers from
the same requester ID mixup problems as the other Marvell chips listed
already.

Add the PCI vendor/device ID to the list of chips which need the
workaround.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/quirks.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3565,6 +3565,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_M
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c14 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9130,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9170,
+			 quirk_dma_func1_alias);
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c47 + c57 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9172,
 			 quirk_dma_func1_alias);


