Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8495CC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BC021A4A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JdSKrh82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfJBNFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:05:15 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:20989
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727223AbfJBNFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:05:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0VO+dE5keItSvoYa8jaTAFpT6oy92bKck6GNLU6Mb56vTkE/TPIi8/ozQNrnc9XanByg0p3jy0Pb5prgux9Z2CqwKSddhQbXGxANtZdz1oZfgx7TPtarLIKyJwTOr9m829cxwjovBdzENA3JRvPeBcATNXdxG5hX+b6F2vkxHLNr/oC5N5qpMNC6aoKjgsMPUxd6ndcWg4I97KiXUTUvHtbVRkJkXn0GtTSjst+oni2as3tNYHTyRva345TDsEkO5XDI8pGqyd+HksOTxjcnarXnJsevTWxJ0YbVlurWAYYC4/L1xMh6hOvUGPf3ETX/DcuRET+M7AOFnGvrMEaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehS3UndgXagzpEGqEcWAELDP6S0hrQKp/xr8x06uuPw=;
 b=J3Rop2Wh+g8PauF3xtjXaP38m8YojmMzf2GdQlig7hGCux4qvodRit2ZwN7UX43lcgcYaRmEOANU6djAqLWkHHvf1WkH9AMfmW8W+9O7h08FqsOivgG/s+g5uIGUzFZT8iNhf8v65K7+FKDEDbU5M+EkCkMRa7XmQnBeTEhz8xfOeCfglILH4BK+0mIyNuqnCXLfaBGS8OuJaPg0/uRtS+YMTi6jBXajRT0CRyuhOxZ3D4rCBe4TbecpUL7UvqSzwK+BXFKNpvPdyK4MS/MQ9/+yGWbvUULyGSfCMBFCZJyvxKMuU5NNN9IhBH/afzc0Uq21Whzh7XoOGHmHzxo1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehS3UndgXagzpEGqEcWAELDP6S0hrQKp/xr8x06uuPw=;
 b=JdSKrh8278foev69L1XU0WS5eE4xqVk6RYxjP+hS7fQ/2iLTZkZSKyHXbskR71TYWl/qeCtxUULbZu9ukO8Cf89V0TW/W5ZqKDxpeI90GcPd7P8h5i/oBnRC0hmqVkNqXvo1cg2LngbEhhS14dtbXk7IFCedP0CAouaTkQl6CEU=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3918.eurprd04.prod.outlook.com (52.134.17.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Wed, 2 Oct 2019 13:04:48 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::fd33:c447:3cab:c36]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::fd33:c447:3cab:c36%7]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 13:04:48 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>
Subject: [PATCH v5 5/5] arm64: defconfig: Enable configs for S32V234
Thread-Topic: [PATCH v5 5/5] arm64: defconfig: Enable configs for S32V234
Thread-Index: AQHVeSH29CXEj60aakehEbe1lYsBFQ==
Date:   Wed, 2 Oct 2019 13:04:46 +0000
Message-ID: <20191002130425.28905-6-stefan-gabriel.mirea@nxp.com>
References: <20191002130425.28905-1-stefan-gabriel.mirea@nxp.com>
In-Reply-To: <20191002130425.28905-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: PR0P264CA0194.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::14) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.240.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58e9b192-ccec-46e1-81d3-08d747391934
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR0402MB3918:|VI1PR0402MB3918:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3918D7C0FEC766F7D3286A62DF9C0@VI1PR0402MB3918.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(189003)(199004)(102836004)(2201001)(5660300002)(26005)(478600001)(76176011)(486006)(386003)(14454004)(50226002)(8676002)(8936002)(81156014)(305945005)(81166006)(6506007)(7736002)(7416002)(64756008)(6436002)(66556008)(66446008)(476003)(66066001)(2906002)(11346002)(2616005)(66476007)(6486002)(66946007)(25786009)(52116002)(2501003)(186003)(256004)(446003)(6512007)(6116002)(3846002)(36756003)(71190400001)(71200400001)(4744005)(4326008)(1076003)(86362001)(54906003)(99286004)(110136005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3918;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MHSjtRb7FhMw7vTwUbEDpLXXl/NRHtlx60XhVmVRyBLDdWKgfpH0tSrdYvFoa9QNzpCpWWt4qX5/pUAZBr6DwEsG4HaGX/LGo479uxTZzFWMqfSHs80TsraYZGDBrXMTrtRIJdOtG0PyqA6xDPNAHBW79x+JlHe2x38uyMv8yglbbWySa9n3rFg1UhqUjqD+C2piQKdZZgLQ3811vLgiDtQ9RwKHl72F3FTPGlAXiO9AOjYWgYfhBMm6hC7tW7ildZA0upxv3A5XRz7Fce2xQyDMX9sOVszdeFOr69N91jZAGK9wW+xer3/MMeYLFzh3D973fvJLQ129iwnUmywZXyc+R2HJKVvkxhe+7BtkLRiqdGt1WnUblYHDj49h4b+OmxVlnqdpRs+kH5+SnzloX2jSlQ9bSl8d73ruA9DY2Yo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e9b192-ccec-46e1-81d3-08d747391934
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 13:04:46.0122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yS4gFjWeaAgDuVAHKrmSWZR8GP2UYk+QXFPUn1Cn/X1illIIxH6DtJs+Fut1RBeHld0+bVnQ8bKM1BRxYHpLSiCIoIZGEWsOlM49BSEDUhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3918
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
index 8e05c39eab08..aa59450557b8 100644
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
@@ -352,6 +353,8 @@ CONFIG_SERIAL_XILINX_PS_UART=3Dy
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

