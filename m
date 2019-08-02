Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A0FC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DCB216C8
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ebwwa5Td"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406861AbfHBTr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 15:47:58 -0400
Received: from mail-eopbgr40082.outbound.protection.outlook.com ([40.107.4.82]:31662
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406752AbfHBTrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:47:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfjry86hYoeqyu0dcaehoYO0oM8aKAM8hmL1GIx8yWPZlNVfnwAKdkW80cdg/7pUYKPI6o3I9Gt2tonYJevh+3R0y9fmwxgmzELF36WgYCWlbgDI5Ha50yvdHVnhF0i0XyeD4sGqLe6j5GVFSFl7EeYAY2Odi5Xi4Z8iOrWcnCid97LLwMkIP/z8GsE3PVfxkgObVtgkbJPKGjmlPvheJNKpfGAUkckuXoV7Bd9T17yh7WPZl6bqwstlQDc+ek2q8q5uUQjSK6+Ss35O/aQOCX1a0U4OqGGKzmrzq/+XXTFI7EKxX6zve4m+kvhHoOkA3sAY37jdTFWFWAYPVmLYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egAmLLcYxNc+vNg4VL0BrjM1fDO0l7UPG3LF2prGCGY=;
 b=YAl5z4uUcOK6IZStWx1Xh/IbZbO7WFoy9a5tkYivJvbK+pJLoLUkgL8pFLosKfpjSbUJfVMSdw2mhJB4htrfxHVyFvdhVt7+us3UQWBm3suikjrlB0d6qOWrcU8pZLIs3T590+tACwUpb3ZMKseonGT6CSWuIjq8+HcY2iJN6pcYviUPbuGuOM7RY8dSWepu29GWCt9Bc5oflAE2Jjeby/hdyNb5I3Z0hjPr5JqM0KC+f/RP+R0iyNtgvJrg64KccAD0qIm8ksHzA07Wcor0p+qEgnOho2RIkRonnhUbvP35kKNYglMMfYDGn23vrXqcCUqjPr8G7Af855ys/U/9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egAmLLcYxNc+vNg4VL0BrjM1fDO0l7UPG3LF2prGCGY=;
 b=Ebwwa5TdLeuExBXi3kWz9jeXPxdQiG7MGFE9bPKLoF9TQsBSzOnlqvJx+/BDT1AHsuCG/oPKxAoyiEUWw6CWkkDuqO0RdUzuJbDG79NgJBxU7Xo8jeKsq9zqKld3TuQ0PFKxTnHC0a3sZaQYrPZVHJOmfrpt3XsbP1UwKjG3kic=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB2829.eurprd04.prod.outlook.com (10.175.26.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 2 Aug 2019 19:47:25 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023%7]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 19:47:25 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>
Subject: [PATCH 6/6] arm64: defconfig: Enable configs for S32V234
Thread-Topic: [PATCH 6/6] arm64: defconfig: Enable configs for S32V234
Thread-Index: AQHVSWsb/yQRxZpYOkehuDu46fPO7Q==
Date:   Fri, 2 Aug 2019 19:47:25 +0000
Message-ID: <20190802194702.30249-7-stefan-gabriel.mirea@nxp.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
In-Reply-To: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: AM6PR04CA0051.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::28) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a505ba7-8748-4128-a196-08d717823df9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2829;
x-ms-traffictypediagnostic: VI1PR0402MB2829:
x-microsoft-antispam-prvs: <VI1PR0402MB2829224DABD18116520CC6BEDFD90@VI1PR0402MB2829.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(189003)(199004)(68736007)(446003)(8676002)(6486002)(54906003)(110136005)(3846002)(305945005)(4744005)(7416002)(1076003)(6116002)(66066001)(2906002)(2201001)(316002)(256004)(36756003)(6636002)(486006)(102836004)(14454004)(71200400001)(53936002)(26005)(66476007)(11346002)(81166006)(71190400001)(186003)(76176011)(66946007)(2616005)(64756008)(8936002)(66446008)(66556008)(99286004)(4326008)(386003)(6506007)(5660300002)(2501003)(52116002)(81156014)(50226002)(25786009)(476003)(478600001)(86362001)(7736002)(6512007)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2829;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FL8pWv/qH15hbCfrjKWf6Td2G1D3hUPtBMW8HFoF6ATlaskQYg4OmmC3HLY7XoQ9nwTUov5k0IkKPCETbIuO3Q9/75fTrPJCEkWgPgtlMv494+dFLJ3wtQtmLRvhlsdP20aCS1bBjaJzTb//9M8moeotJ+8gCklKemcAgMHEBwqcqsCkDJBYOthustR9duCDqOWzftv33QmcTP3Nwvs5NVFlcqCX5ibZfX5y2njYlFtWWwboVjfOBgRm+aw6+Tgem8LvoxXwOZcDHr5k2AcIvCALG3IOiB6e7UC1/eM4ThT6/ZkPTGv1nT4wI6UJt/31yuy5AySECD+OOq3z+mZ8iEXl7bS3U5i/BLOxJDn8JPeCoqrM66kEk+D77aA9ChkSLl/6lzwWUkTMyLfur6rniaDv8yCxj6Xq9g5iUur7l6c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a505ba7-8748-4128-a196-08d717823df9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 19:47:25.1490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stefan-gabriel.mirea@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2829
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mihaela Martinas <Mihaela.Martinas@freescale.com>

Enable support for the S32V234 SoC, including the previously added UART
driver.

Signed-off-by: Mihaela Martinas <Mihaela.Martinas@freescale.com>
Signed-off-by: Adrian.Nitu <adrian.nitu@freescale.com>
Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0e58ef02880c..bb5aa95a8455 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -48,6 +48,7 @@ CONFIG_ARCH_MXC=3Dy
 CONFIG_ARCH_QCOM=3Dy
 CONFIG_ARCH_RENESAS=3Dy
 CONFIG_ARCH_ROCKCHIP=3Dy
+CONFIG_ARCH_S32=3Dy
 CONFIG_ARCH_SEATTLE=3Dy
 CONFIG_ARCH_STRATIX10=3Dy
 CONFIG_ARCH_SYNQUACER=3Dy
@@ -347,6 +348,8 @@ CONFIG_SERIAL_XILINX_PS_UART=3Dy
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=3Dy
 CONFIG_SERIAL_FSL_LPUART=3Dy
 CONFIG_SERIAL_FSL_LPUART_CONSOLE=3Dy
+CONFIG_SERIAL_FSL_LINFLEXUART=3Dy
+CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE=3Dy
 CONFIG_SERIAL_MVEBU_UART=3Dy
 CONFIG_SERIAL_DEV_BUS=3Dy
 CONFIG_VIRTIO_CONSOLE=3Dy
--=20
2.22.0

