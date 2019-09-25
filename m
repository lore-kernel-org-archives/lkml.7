Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44562C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD1721D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NzrgFqhT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EykCfkzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442323AbfIYGiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 02:38:12 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:55253 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411896AbfIYGiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 02:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569393491; x=1600929491;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yeqfhyNFdbMwC9gfCj65cyffTyGmmcoKSNDTmhB7C+4=;
  b=NzrgFqhT3TOWW2FvAYKzWt+X9vkbZ5vjUzYJVC/p6ic29qH3guyEToKB
   02oH3J5ndf0ZUzJ3b8nPuB3L/pTXbeVu/ltSer5NPc8eRK5Rqm997E5Um
   vyHMuNmDaCWB4wTF8okRa6uwWOgCptChOFhh0be7mDmC8IGQdbVLX3t+2
   LmB37ZLU97M5+seGCfg0LphekRSDiJR1rNNEndkkxHgAeTGnxwpoblUTt
   m6wn+1YvtKrQ26XdG3Xm1sOmtuSYPCIWx6W5fWmSHXY65vRr9vYFuwjb6
   1sYdQLEJw/h+zvzdpmrTYXHX7TCdzW1dAOLJRlU0HdN+NkoIFYhbW5EDu
   w==;
IronPort-SDR: I3c67+mMcgE+OBFGglQUPPu29B/gHDqPtPDavKEdFBLKc0XpCJyRrGKxKou4i53PwFC/RL6/cM
 uu/t4fEnY4ESp4doaDpnl3P01/t3Oy9LZEXf19sXCKSvQewncsJ/m04jQK3xYwb3VOE0cFd/Nb
 5ADlVYdQwOn4WFOQ7tPtWd9RsI/vbK6LPFVX1YyaJkQcwU0yd5YFq4/LQ3+mOrF1HI3bIVCAVI
 JmBwvi3xxyYOG2pfsHPD1sXvoDvN0ZuT3uxelh4jmmD23mG8WZ0DUBAMBoD7W2lLoA4r7ZzXHw
 P7M=
X-IronPort-AV: E=Sophos;i="5.64,546,1559491200"; 
   d="scan'208";a="120615906"
Received: from mail-by2nam05lp2056.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.56])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2019 14:38:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmUrK84vOwqRxu50gdQo+ncDMIXePO+kko2ZZyyolRmqoGEVL/AdVavcg5HhGWJLBftTrpqnZCFkqKht1Ps6t2CwL26Zz16G3VAuCi6zTWOFC9VepGvPwmBeCrdkinQDpgSZUVX1x3EFqW842F/blbGaOG38MZCP12o4+f69HiHZ4Tt5IbW38QYHWV6xUnGNryGAvIKKATq3xtXmXVkN2ga2UnvGZo20p7mQXRWFtjNDp0xeorwa164LFb7215KsF3U9Ufrn66E2xRiHsjHG6I9GpG73RFU44fY5dtr7vU6sgItajTogvOYPI1Bg73jOVphNXiTv656Q1aCBXCFQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BIOflEycOB7rSOrwtmLZA3ec/ldK301LqFjt2pdvLE=;
 b=Byr8q+amt3TW9b82+3tCY0kDaPy1wb/Q/IaCK6Vz4eM+2WD6aTx8Osq3Y+JCK1SAaDAtz99d238OgOT6J+FPHxEq8hOwoQBqfTowFQpYCnQFpThsqALn1Cx21ABTVT/dhKWp0IpjtzJJvPGShY/tK+bXCWHj54mPYnfVjl6hcfzlku9XGFPBEROO56yX3+EP432lWp4PMFTDEvFqsWc9XyzEV8h3ujgumTtkkmR8vL2w86U4WIXFNSw2juAXTfaf/bm61fzZyFvGvUpXfYCb2RXTLnD4bWxdOYy1xeyDeaiRjhfIwPQ95KWPs4jGzaLv4k8SYzktZKNGhrpnOGw5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BIOflEycOB7rSOrwtmLZA3ec/ldK301LqFjt2pdvLE=;
 b=EykCfkznUcKJLshRwpMPVVa198Re2mJI/ZMwva6Pe3RwmD2DVFQX3DovuNaz1q6noVmSTyqzs//qhOpfJzs7SlV2fcIQ30mlqxrqKp+RnHh2LZscR+aOFXVxp//6/Yk+dRUm6ciicnB8/sAngEy56swJJwzlguKC02BAFDgtLW8=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5712.namprd04.prod.outlook.com (20.179.21.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 06:38:08 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0%7]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 06:38:08 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roman Kiryanov <rkir@google.com>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v2 2/2] RISC-V: defconfig: Enable Goldfish RTC driver
Thread-Topic: [PATCH v2 2/2] RISC-V: defconfig: Enable Goldfish RTC driver
Thread-Index: AQHVc2vL/aB/O/VoT0mkZEceqSj8FA==
Date:   Wed, 25 Sep 2019 06:38:08 +0000
Message-ID: <20190925063706.56175-3-anup.patel@wdc.com>
References: <20190925063706.56175-1-anup.patel@wdc.com>
In-Reply-To: <20190925063706.56175-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::25) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [199.255.44.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 570f3220-4313-468d-9dd0-08d74182ed60
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR04MB5712;
x-ms-traffictypediagnostic: MN2PR04MB5712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB571236FF6CB49595162C6F488D870@MN2PR04MB5712.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(199004)(189003)(71200400001)(2171002)(76176011)(4326008)(386003)(6506007)(476003)(54906003)(3846002)(6116002)(110136005)(81166006)(486006)(99286004)(102836004)(81156014)(1076003)(316002)(14444005)(2616005)(11346002)(8676002)(7736002)(50226002)(6512007)(26005)(6486002)(5660300002)(186003)(86362001)(305945005)(2906002)(44832011)(256004)(36756003)(71190400001)(446003)(66066001)(66946007)(66476007)(66556008)(64756008)(66446008)(6436002)(14454004)(25786009)(478600001)(52116002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5712;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3AY60UiE7y1zyuaDYso1HsDCCQ3uhcXzV0vLhRHzVtZ3uLPIFQ+7/qZ5NXBKmkzpeAdoq/JOqMorbc7+jFXQ+sMd3luo9E37y7aIvg6xuiGQ9ScjDtx7Uk6CLXcCReRMisJzXuqNNX+Ug0QWPNRqs8WwoKcFNmRxSqcS/VIW5Rr9V8wrG5Mugc0G9T0IJqMmt7RUOGap1fakETZ9g0omxdcPp+0Kb4nHG8GgQ20Lfsr3gP1x0FwX2yF2r/UXba5c3W8XZgzLlFEgt1p+K4quBHvd27ovHFN/0f7/ijC98NLf2dbPIhBmlfHs2cUOe35IfmibgSGdzoImhyvuAOKAtQ0M7QxdLOvn+tzZbFVqJcZnSX3LhCY8nTlvE7vFVa6IOBPSELXPvdRR/wwvhrxRJvKiu7r7JvDcaYuQFHim+ME=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570f3220-4313-468d-9dd0-08d74182ed60
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 06:38:08.6906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g2fEz9OZpKqEf+2i9/d1lP3OtENMSLStUr1PIsDU5D37PL2M0gHUGBA/K/ggfi1Gx10ZIgDpAWTDBaeGcAgxWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have Goldfish RTC device available on QEMU RISC-V virt machine
hence enable required driver in RV32 and RV64 defconfigs.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/configs/defconfig      | 3 +++
 arch/riscv/configs/rv32_defconfig | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 3efff552a261..57b4f67b0c0b 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -73,7 +73,10 @@ CONFIG_USB_STORAGE=3Dy
 CONFIG_USB_UAS=3Dy
 CONFIG_MMC=3Dy
 CONFIG_MMC_SPI=3Dy
+CONFIG_RTC_CLASS=3Dy
+CONFIG_RTC_DRV_GOLDFISH=3Dy
 CONFIG_VIRTIO_MMIO=3Dy
+CONFIG_GOLDFISH=3Dy
 CONFIG_EXT4_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_AUTOFS4_FS=3Dy
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_de=
fconfig
index 7da93e494445..50716c1395aa 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -69,7 +69,10 @@ CONFIG_USB_OHCI_HCD=3Dy
 CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
 CONFIG_USB_STORAGE=3Dy
 CONFIG_USB_UAS=3Dy
+CONFIG_RTC_CLASS=3Dy
+CONFIG_RTC_DRV_GOLDFISH=3Dy
 CONFIG_VIRTIO_MMIO=3Dy
+CONFIG_GOLDFISH=3Dy
 CONFIG_SIFIVE_PLIC=3Dy
 CONFIG_EXT4_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
--=20
2.17.1

