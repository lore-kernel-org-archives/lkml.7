Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31656C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C31218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355089;
	bh=0IPO3GPXSNE+9Ka9AB5izpzFtVcFCfhwD+wiNvcxIvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A06J+wlVtv5BU58bzcUuuanzf2zkglMeUCbw7xe+xqh7xqbvvXBQj/8WEDSQH3UGX
	 lv2OxEAOCMMqsnG6qOOEZryJqmA7OKL2lEpebB+R5drORTM1gUX31B8HicXxfEG8Lj
	 Ft3VvjlFVAOPObfUGlzuDcRK9foQLuNJV9+yPR5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfDOTEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729589AbfDOTEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:04:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6FE5218D3;
        Mon, 15 Apr 2019 19:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355082;
        bh=0IPO3GPXSNE+9Ka9AB5izpzFtVcFCfhwD+wiNvcxIvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RgyUid8YRFlzjfeynxyJrtdWwy17y4haxwSHQzJsITxx2QaEPO9KJK1TC21/lG+up
         q6S1KJThFlU1Rrq6F5pSyM+NM1sowTc3VoPdXbMrGBhc5UVzMcnic9LewmfBhUpSn7
         fxalT5q/DzW/f+KaVcA7kZ+PP75DVMGCAkxAo7Gc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.14 66/69] PCI: Add function 1 DMA alias quirk for Marvell 9170 SATA controller
Date:   Mon, 15 Apr 2019 20:59:24 +0200
Message-Id: <20190415183736.547573805@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
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
@@ -3888,6 +3888,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_M
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c14 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9130,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9170,
+			 quirk_dma_func1_alias);
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c47 + c57 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9172,
 			 quirk_dma_func1_alias);


