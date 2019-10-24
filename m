Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6A0CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D3C205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="c3gScaiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502177AbfJXMwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:52:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37530 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731315AbfJXMwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:52:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id e11so17249498wrv.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 05:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=Gp7w0CtXS7ruAPklTtPyVZtj6tEuTD3cIiAzzfhQRVA=;
        b=c3gScaiSiuSQAr39lZY8I7G1TApjk3EA/mdkJJzcMp+pIetKvw8wWnL6NyUMGENyyU
         3k137WtLzyHVyZwFdN/XeWymlPYLio/Fce3DG+uxslTJFlQ4Fz+ofwU80z/8rzzRnSXm
         MM48hzOyEl56IoYKeDpaKb5gyuSxKU2xGH7nF2LFjUmfHdHeY7b2fMCRsdJpWNjxAp0y
         eEvsDhNg+RYY1gZVmDvDJlHC5TFYivd8yJDFqRU8v+J/7exKPtffY79JJPoduRwg5v8l
         wPyZs+5bahu2bSX9ZEEBjVdA0JJP7KqCxakoLZ8kDtdegfZSyo7C/QAGqyUipLm9uWxn
         nu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=Gp7w0CtXS7ruAPklTtPyVZtj6tEuTD3cIiAzzfhQRVA=;
        b=uBnwoYFTp3fSEZzjL1JHMzclvcB/aUsTyNwk+zFzQIJbc60V1dzpplOmx2Kbamyn4c
         XdvBc2bKzoxHmdacsdo6jouHrKMi2sd3+lJhkf6FTuC4U45hP1StEyd553lU/8eTb2hE
         d/G4IFQ5Szkhrh34cFPhA+V9HcX65p23plaSfM4b0n14jWg9o5XEd47ddlPREaowpe9U
         q/qmH5fx3gnhoz6Ss8b8SrMBZ+BsH7aQIsy8lgUM4hGBF2H+i+jaeeJOR/Of7wMsDX3R
         hYqVuxLeyyXDvYGtcgtzL1Fl8mwjhwNjQFyamiimWWc4T8Ktp41u4ZgGSqYxzCwcO0aY
         5svA==
X-Gm-Message-State: APjAAAXEkMjaU4aaolX0vsDPTxzDAHZCTiC3/LsVAkNm6b2bV7nrrhtB
        3BsZf0+KYUDVsMAcjMIaszkY3Q==
X-Google-Smtp-Source: APXvYqx5PxXCsgOAtnabXr44Wc7UjjcydX19m7KM+dGbPTZ2Xq7vY9OrubLua2c2mKVrXupORzKKIw==
X-Received: by 2002:adf:f44e:: with SMTP id f14mr3603127wrp.56.1571921541265;
        Thu, 24 Oct 2019 05:52:21 -0700 (PDT)
Received: from [10.83.36.220] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 65sm25428205wrs.9.2019.10.24.05.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 05:52:20 -0700 (PDT)
From:   James Sewart <jamessewart@arista.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH] Ensure pci transactions coming from PLX NTB are handled when 
 IOMMU is turned on
Message-Id: <A3FA9DE1-2EEF-41D8-9AC2-B1F760E7F5D5@arista.com>
Date:   Thu, 24 Oct 2019 13:52:19 +0100
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>
To:     iommu@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PLX PEX NTB forwards DMA transactions using Requester ID's that =
don't exist as
PCI devices. The devfn for a transaction is used as an index into a =
lookup table
storing the origin of a transaction on the other side of the bridge.

This patch aliases all possible devfn's to the NTB device so that any =
transaction
coming in is governed by the mappings for the NTB.

Signed-Off-By: James Sewart <jamessewart@arista.com>
---
 drivers/pci/quirks.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 320255e5e8f8..647f546e427f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5315,6 +5315,28 @@ SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
 SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
 SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
=20
+/*
+ * PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints. =
These IDs
+ * are used to forward responses to the originator on the other side of =
the
+ * NTB. Alias all possible IDs to the NTB to permit access when the =
IOMMU is
+ * turned on.
+ */
+static void quirk_PLX_NTB_dma_alias(struct pci_dev *pdev)
+{
+	if (!pdev->dma_alias_mask)
+		pdev->dma_alias_mask =3D kcalloc(BITS_TO_LONGS(U8_MAX),
+					      sizeof(long), GFP_KERNEL);
+	if (!pdev->dma_alias_mask) {
+		dev_warn(&pdev->dev, "Unable to allocate DMA alias =
mask\n");
+		return;
+	}
+
+	// PLX NTB may use all 256 devfns
+	memset(pdev->dma_alias_mask, U8_MAX, (U8_MAX+1)/BITS_PER_BYTE);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b0, =
quirk_PLX_NTB_dma_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b1, =
quirk_PLX_NTB_dma_alias);
+
 /*
  * On Lenovo Thinkpad P50 SKUs with a Nvidia Quadro M1000M, the BIOS =
does
  * not always reset the secondary Nvidia GPU between reboots if the =
system
--=20
2.19.1


