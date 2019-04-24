Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F51DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554C3205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126485;
	bh=kvoszp9IDmHg9ngeL4CEh7OMph4HwrbQW4aEiH5OQf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pzuxJwdCg0QRUrLqE2RRGad60+tduypW48ubyV9kK1em6O5G3dOOwjsOLCp3pkm68
	 rHNk27drEqbO5ZmQepjCN5JAGBtYm60TMCOAnwa5Pu8bHcsAE8Zm+OBAuxM9gZbaTR
	 B4W4zfSnaXSz+1xz496jsgLJsqmMCbVDo+3bvp0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389333AbfDXRVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:21:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388321AbfDXRVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:21:21 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85D9F205ED;
        Wed, 24 Apr 2019 17:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126481;
        bh=kvoszp9IDmHg9ngeL4CEh7OMph4HwrbQW4aEiH5OQf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L3aoNn9BsomLihxbZG076t3Dva0X7jzqmZBH4k7m4pILrg3mdZXHlnQiIjJqQLUh8
         ZRwUEk1FsUR9N7ZF/7eH1sGMqQSNMgvoPVqyygexPb7q+rSnj1QEssGlNwbdOF4dYz
         iTIhI8Dq7wuIK4R5i9GvvAPo7H/z8f+9rbqhj4sE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.4 097/168] PCI: Add function 1 DMA alias quirk for Marvell 9170 SATA controller
Date:   Wed, 24 Apr 2019 19:09:01 +0200
Message-Id: <20190424170929.430446249@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
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
@@ -3623,6 +3623,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_M
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c14 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9130,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9170,
+			 quirk_dma_func1_alias);
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c47 + c57 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9172,
 			 quirk_dma_func1_alias);


