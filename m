Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8EECA9ED1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838EB21897
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eHKbe+UO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfKBAYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 20:24:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38096 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfKBAYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 20:24:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id c13so8098411pfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 17:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LezSatWohHihzh0HhIGiufhnWt/TD8Ia5dOfWYhDmnY=;
        b=eHKbe+UOONcj8qkQTHzjdB9YYIqtDnUbEK2VSdeH95FZDWFVAfOtEc1Oy+JCWXu8hh
         xw05ztBdQFe6LPohjURqTJHPjJ58E+jyhwzeUI/MNCnX7+p1LywE8ZcoT9StWNK400Zm
         bL16uEvikVZD3tbygPl698Yb5b7AW7DtE1XPY3wCFvJTdx8Of+yLO5Ne5FXkdxjuRitt
         NRVq99tAntXAHmKtQRwQ1Qp7HCGRRiwyf4wO/7+2lRPRM8SMAFo1rE75W/PgqI9VBFyd
         GgewgMy5KvCVJDPLk2IV+ayc8DAm1UE/bqJHd364XY7SzUP06ZsLDyUwH7GMqbCV90MX
         x/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LezSatWohHihzh0HhIGiufhnWt/TD8Ia5dOfWYhDmnY=;
        b=sPa+1IMlzYHry++lzNi08e+ylYZA9xsQD5Jl+3LeGO99U3Fq1Z1nfKdaxbacxR/p0D
         VO0GCzUiOdGiv6aZ2J6AT1ztjyYuRI+SWh2TMMO8Ul5YSSzqaMPkvNfqHTdV5IH5ATqy
         AF8Ut1JnNR9jiZPCQgMRrbMnQUaIVzXjbP7ljR5exvY/uYzyXPqHwxy6VcT6vk/XcChS
         Cz34UREe2r37z+9GPVWMLaRGWf4VgCjBORV6B0G4wvFeT/+KOY81PZNDscWQytvtdmFu
         dYZLqlIXqcvTKuBwPJSM6Fa+KinxCADOEAxzhhGWxNGQdu6S3uINVnKlqzql68pVbvze
         WG8w==
X-Gm-Message-State: APjAAAW9f8t8waZqYpekV8ieaGXnFLuij4EUM73k1KowlHGVshi7Sapc
        wCqse8Ao86CxqYPsTwofTEEKeA==
X-Google-Smtp-Source: APXvYqyHLo4acaa9eCPQ/NgX/Aw4ZtDtvPs0Mzt7YxuCoeTrNIOJiDCbToJ+lxt4mDByh+WDd3q+yg==
X-Received: by 2002:a62:1d8d:: with SMTP id d135mr9250453pfd.172.1572654264076;
        Fri, 01 Nov 2019 17:24:24 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w2sm7700833pgr.78.2019.11.01.17.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 17:24:23 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] PCI: qcom: Fix the fixup of PCI_VENDOR_ID_QCOM
Date:   Fri,  1 Nov 2019 17:24:20 -0700
Message-Id: <20191102002420.4091061-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There exists non-bridge PCIe devices with PCI_VENDOR_ID_QCOM, so limit
the fixup to only affect the PCIe 2.0 (0x106) and PCIe 3.0 (0x107)
bridges.

Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 3 ++-
 include/linux/pci_ids.h                | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 35f4980480bb..b91abf4d4905 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1441,7 +1441,8 @@ static void qcom_fixup_class(struct pci_dev *dev)
 {
 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
 }
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, PCI_ANY_ID, qcom_fixup_class);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, PCIE_DEVICE_ID_QCOM_PCIE20, qcom_fixup_class);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, PCIE_DEVICE_ID_QCOM_PCIE30, qcom_fixup_class);
 
 static struct platform_driver qcom_pcie_driver = {
 	.probe = qcom_pcie_probe,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 21a572469a4e..3d0724ee4d2f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2413,6 +2413,8 @@
 #define PCI_VENDOR_ID_LENOVO		0x17aa
 
 #define PCI_VENDOR_ID_QCOM		0x17cb
+#define PCIE_DEVICE_ID_QCOM_PCIE20	0x0106
+#define PCIE_DEVICE_ID_QCOM_PCIE30	0x0107
 
 #define PCI_VENDOR_ID_CDNS		0x17cd
 
-- 
2.23.0

