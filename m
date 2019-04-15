Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A384BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECB920880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355743;
	bh=vnv0gOdJRTocFsr+a4Ofrk0+1s339ptuwQCpqV2qD+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ClU53agVlyKIrTtXPhbjdr0XLqJcsaDVFrZfpWm///WV9PseEovaO75iHC11s0pET
	 7uDX1dfdhCUT2pbd/KXMgTTckVekRjd0O8zqs1BeQP1PMRnA4DTgtZBNd8B94LKIf4
	 aun/QxhGjO9v88HLPuHNRTlf51GL7q6J50MH4ut4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbfDOTNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:13:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731623AbfDOTNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:13:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 267A421900;
        Mon, 15 Apr 2019 19:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355624;
        bh=vnv0gOdJRTocFsr+a4Ofrk0+1s339ptuwQCpqV2qD+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NmehhxCbWgWXy8S7P7Dc3Err4xIyHwgngJgipPgGed5fJVCdYvNwr71uX4Th+KSrh
         AzA4GPvWZOXWI3AGxoeB8aaYYPUE3sbJ8EahUEBElESQdF5A3uZ0SeOMvCnz4QtWPC
         A321y1Rqv5BUrViDvp0ulp6kKcGcDzxUf56zJuBw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5.0 106/117] PCI: Add function 1 DMA alias quirk for Marvell 9170 SATA controller
Date:   Mon, 15 Apr 2019 21:01:16 +0200
Message-Id: <20190415183750.151129314@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
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
@@ -3877,6 +3877,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_M
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c14 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9130,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9170,
+			 quirk_dma_func1_alias);
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c47 + c57 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9172,
 			 quirk_dma_func1_alias);


