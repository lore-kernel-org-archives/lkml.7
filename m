Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2D4C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8935C224F3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bdDiyV5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfKTN1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:27:03 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:47732 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbfKTN1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:27:02 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191120132659epoutp01b7963067ad051a9a617a75386f7a34b8~Y4d9otqNQ1742317423epoutp01J
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 13:26:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191120132659epoutp01b7963067ad051a9a617a75386f7a34b8~Y4d9otqNQ1742317423epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574256419;
        bh=FkQW2/gVwlv8TBWB7Gl7mfLPp4FHKc20kVE7ZZRny3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bdDiyV5aMjsYLArhYtqIZVJ2KysP7W3sVnPWW92gmUGIgCD8zAe7XLNByVzHdtc/6
         wndd1f0loMWTpZcJXvQDrEQ4i4MJZJxfthMXJwJ/Y5tOymDrLk9TuL7BW67/kEwDt0
         5i+sQoBQVoexWljLaSOwuidxHzOloikJrjquwUFk=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20191120132658epcas5p1732a15c7f2fd3e762b8dfc81c4fe474c~Y4d8yxWtW2044820448epcas5p1B;
        Wed, 20 Nov 2019 13:26:58 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.14.04074.22F35DD5; Wed, 20 Nov 2019 22:26:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20191120132657epcas5p418542be130de4e02901825eeac7edcdb~Y4d8BJagV2494424944epcas5p4r;
        Wed, 20 Nov 2019 13:26:57 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191120132657epsmtrp11ea69c5a37e8987f37f614310cac4a0c~Y4d8AWTdl1339613396epsmtrp1Z;
        Wed, 20 Nov 2019 13:26:57 +0000 (GMT)
X-AuditID: b6c32a4b-2e1ff70000000fea-b9-5dd53f221ac9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.AC.03814.12F35DD5; Wed, 20 Nov 2019 22:26:57 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191120132655epsmtip23470c213326649db3c9a7e424a81f4da~Y4d6byOAV2341723417epsmtip2Q;
        Wed, 20 Nov 2019 13:26:55 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        pankaj.dubey@samsung.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, bhelgaas@google.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: [PATCH v3 2/2] PCI: dwc: add support to handle ZRX-DC Compliant
 PHYs
Date:   Wed, 20 Nov 2019 18:56:11 +0530
Message-Id: <1574256371-617-3-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574256371-617-1-git-send-email-anvesh.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZdlhTU1fJ/mqswcm9EhbN/7ezWpzdtZDV
        YklThsWuux3sFiu+zGS3uPC0h83i8q45bBZvfr9gt1h6/SKTxaKtX9gtWvceYXfg9lgzbw2j
        x85Zd9k9Fmwq9di0qpPNo2/LKkaPLfs/M3ocv7GdyePzJrkAjigum5TUnMyy1CJ9uwSujI9T
        XjIWPBCuWNX2naWB8b5AFyMHh4SAicT1JYpdjFwcQgK7GSUermtnhnA+MUrMWDyVBcL5xijx
        vGE7O0xHx2deiPheRolX++ZAFbUwScxaOZWpi5GTg01AW+Ln0b3sILaIgILE5t5nrCBFzAL/
        GCWufpnHCJIQFvCX+NdwgBnEZhFQlXi5u40VxOYVcJKYvmMiG4gtISAncfNcJ1gNp4CzxLzt
        zWwggyQELrNJ/Py5kBmiyEVi847ZLBC2sMSr41vYIWwpiZf9bVB2vkTv3aVQdo3ElLsdjBC2
        vcSBKyAvcABdpymxfpc+SJhZgE+i9/cTJoiPeSU62oQgTCWJtpnVEI0SEovn34Q6wENi54WL
        rJBwmMYosfDDefYJjLKzEIYuYGRcxSiZWlCcm55abFpgnJdarlecmFtcmpeul5yfu4kRnDi0
        vHcwbjrnc4hRgINRiYc3Q+NqrBBrYllxZe4hRgkOZiUR3j3Xr8QK8aYkVlalFuXHF5XmpBYf
        YpTmYFES553EejVGSCA9sSQ1OzW1ILUIJsvEwSnVwOgjcz7FYVXZ/YyOB3uf/7vxSGvB2fDb
        s3OOvIzO0TYIm3k6frVYwBouO6+Oq+pdi5XvFnAaPPl86pvT0ean+9w2vdg6mUeJl+Widv3s
        x1EnOnU5nvRsKruV7zxp3eVjZp/fa1wU2P042lNa5m+MXZxC065c5rrnL69sNAs8v9fd/kjZ
        PCHJb1xKLMUZiYZazEXFiQBu/6QkGAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWy7bCSvK6i/dVYg+2rFC2a/29ntTi7ayGr
        xZKmDItddzvYLVZ8mcluceFpD5vF5V1z2Cze/H7BbrH0+kUmi0Vbv7BbtO49wu7A7bFm3hpG
        j52z7rJ7LNhU6rFpVSebR9+WVYweW/Z/ZvQ4fmM7k8fnTXIBHFFcNimpOZllqUX6dglcGR+n
        vGQseCBcsartO0sD432BLkYODgkBE4mOz7xdjFwcQgK7GSU6Pl5j62LkBIpLSHzZ+xXKFpZY
        +e85O0RRE5PE966/jCAJNgFtiZ9H97KD2CICChKbe5+xghQxC3QxSaw9vQUsISzgK7Hk4HkW
        EJtFQFXi5e42VhCbV8BJYvqOiVAb5CRunutkBrE5BZwl5m1vZgO5TgioZs1r6wmMfAsYGVYx
        SqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgSHrZbWDsYTJ+IPMQpwMCrx8GZoXI0VYk0s
        K67MPcQowcGsJMK75/qVWCHelMTKqtSi/Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtS
        i2CyTBycUg2MSdcFDeq2H55rNuvYk7utRY7tvHmn90jVF65WkVG9xT67rvlKgScL1/F8ifRM
        t2/JHXxSGR+Frb/uLqxT66kXZZC5/rU39J6NvvFT5iPyLNcPrL109fd6sZDPGfcsZ/WuE4/e
        K/FCyIHxwJa6b39MwkUeuazRvvKl5LGlTl1Jp42a0fuj6plKLMUZiYZazEXFiQCnFRlbVwIA
        AA==
X-CMS-MailID: 20191120132657epcas5p418542be130de4e02901825eeac7edcdb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191120132657epcas5p418542be130de4e02901825eeac7edcdb
References: <1574256371-617-1-git-send-email-anvesh.s@samsung.com>
        <CGME20191120132657epcas5p418542be130de4e02901825eeac7edcdb@epcas5p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many platforms use DesignWare controller but the PHY can be different in
different platforms. If the PHY is compliant is to ZRX-DC specification
it helps in low power consumption during power states.

If current data rate is 8.0 GT/s or higher and PHY is not compliant to
ZRX-DC specification, then after every 100ms link should transition to
recovery state during the low power states.

DesignWare controller provides GEN3_ZRXDC_NONCOMPL field in
GEN3_RELATED_OFF to specify about ZRX-DC compliant PHY.

Platforms with ZRX-DC compliant PHY can set phy_zrxdc_compliant variable
to specify this property to the controller.

Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
Patchset v2 can be found at:
 - 1/2: https://lkml.org/lkml/2019/11/11/672
 - 2/2: https://lkml.org/lkml/2019/10/28/285

Changes w.r.t v2:
 - Addressed review comments
 - Rebased on latest linus/master

 drivers/pci/controller/dwc/pcie-designware.c | 6 ++++++
 drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 820488d..36a01b7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -556,4 +556,10 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		       PCIE_PL_CHK_REG_CHK_REG_START;
 		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
 	}
+
+	if (pci->phy_zrxdc_compliant) {
+		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
+		val &= ~PORT_LOGIC_GEN3_ZRXDC_NONCOMPL;
+		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
+	}
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 5a18e94..f43f986 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -60,6 +60,9 @@
 #define PCIE_MSI_INTR0_MASK		0x82C
 #define PCIE_MSI_INTR0_STATUS		0x830
 
+#define PCIE_PORT_GEN3_RELATED		0x890
+#define PORT_LOGIC_GEN3_ZRXDC_NONCOMPL	BIT(0)
+
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
 #define PCIE_ATU_REGION_OUTBOUND	0
@@ -249,6 +252,7 @@ struct dw_pcie {
 	void __iomem		*atu_base;
 	u32			num_viewport;
 	u8			iatu_unroll_enabled;
+	bool			phy_zrxdc_compliant;
 	struct pcie_port	pp;
 	struct dw_pcie_ep	ep;
 	const struct dw_pcie_ops *ops;
-- 
2.7.4

