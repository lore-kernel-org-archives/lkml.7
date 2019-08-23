Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8881AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 19:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5132B21897
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 19:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EoVemOlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406142AbfHWTMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 15:12:09 -0400
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]:31678
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406115AbfHWTMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 15:12:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9Ltf4KAnlgLs3jIF2avxYjRL/ZcIRyFhrNHyEhPofo8a47OlgMUaC3hLBKND9x5+3HhffUD0wimM6bKBVjYX8lltcK1cjCJMfpMhdFJgEvGBJ0O1KqVDeg8fczhHX0xRmcqgvDsetw6Qh/PJKrQaahaVgICEzXaFziyNtZGp0jaCMCjHL+pyKC69srMD2EaQ1nXiDDVIsAOz+jMZR6ANMUr9EwHFm+7dYlt96kMtuo0ZfNFBDQfKdsZSDkvnOB6YxANpFX7HazOJupHrsUg0glTmiODG7d44JGeKCcE65dQjDYClYHmCCyoeAlh1gHhQDlHNeV8EnYLS83syX5JzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egAmLLcYxNc+vNg4VL0BrjM1fDO0l7UPG3LF2prGCGY=;
 b=F/h0ojSGgxW0PaqeRb7OFjiqb3Xp9D6etzxz/gBwSRKUo+GWpEuHvmZpTJAP+8jGqBXveJMEMDRoD8R736+DOJNgYtqWz5jKmSNjP2Vo2pDXkQcDKzSaOaXkc/0GkJN9G8iPLpH2dQp/7sQlc8v25hk+AePLtvgBwPQqDMjgzuuiLSob6LuK45Sg+GPucsiqg5VU6YYl8NsQLlvo2Lj4b1Z6kxzxucWcHN7+Dt3ZnnWvFyRudNdRU5nXu0dnxl2utxD1ytCxlEeJThgw8fvuJh3dTS8KX6izTchhlg8ZgibxMjxRwy4HyfRJwj3TlyfLTHV3cTM+qT2hIDt5ByqP4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egAmLLcYxNc+vNg4VL0BrjM1fDO0l7UPG3LF2prGCGY=;
 b=EoVemOlIBJeY/WvrPItvVs+vdOuFhPGY2a5VaxPzAfAmyMRALG+GDG2B5FW7r+3DxEgdCotWSvbUa1zY7AsLMxUSnqCmMDUAofPoLbenTx14vIgP5Lj4WXVtBB4RdQ69hBL3xYJzCFS1ZhIBg5+me276UfiKu6f7VlHL8a+M93g=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB2717.eurprd04.prod.outlook.com (10.175.22.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 19:11:42 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023%7]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 19:11:42 +0000
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
Subject: [PATCH v3 7/7] arm64: defconfig: Enable configs for S32V234
Thread-Topic: [PATCH v3 7/7] arm64: defconfig: Enable configs for S32V234
Thread-Index: AQHVWeaY2v6WFA+VBUyvk0fD5W0utQ==
Date:   Fri, 23 Aug 2019 19:11:42 +0000
Message-ID: <20190823191115.18490-8-stefan-gabriel.mirea@nxp.com>
References: <20190823191115.18490-1-stefan-gabriel.mirea@nxp.com>
In-Reply-To: <20190823191115.18490-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: AM5PR0402CA0007.eurprd04.prod.outlook.com
 (2603:10a6:203:90::17) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdf608ca-8d79-4ea7-96c8-08d727fdbb40
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0402MB2717;
x-ms-traffictypediagnostic: VI1PR0402MB2717:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB27175AF93966C49C47D55850DFA40@VI1PR0402MB2717.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(189003)(199004)(446003)(476003)(2501003)(66446008)(76176011)(6436002)(6486002)(386003)(6506007)(50226002)(81156014)(256004)(86362001)(66946007)(64756008)(66556008)(66476007)(66066001)(186003)(8936002)(6512007)(25786009)(81166006)(36756003)(478600001)(52116002)(8676002)(14454004)(102836004)(6116002)(5660300002)(486006)(26005)(2201001)(71200400001)(53936002)(71190400001)(1076003)(316002)(110136005)(7416002)(54906003)(4326008)(99286004)(7736002)(305945005)(6636002)(3846002)(11346002)(2616005)(4744005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2717;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XUoXzVhHQn4W7F6ga20L4KDqNtgmFRvHXKqS1PiKRqQB9CGNKnwzQwxGV/vpJPYDyT3e1+4mcse9Y2PPXQgY8Uv8/7cCvtfKJu20GJfwzeQU4OC6fxTOJ3Us46cheTjhFt5CqP/omZan/skxY0xMd3ZSFufEApczwv0V5cbeJor5QHbTUtb9yjAtFsb9LcTKBxo0p+XSoqnLhhMDMJneHk1T8TTuTbP+Sms3nIBsgTaGnmoa5OGGJrFdSx+jvj7RqfnVy6QPXtX4RXGEBW095xObxtsZ3ppWutw7NzAwbv46/yD/cXfmF1CMlwHtc5rP9kYE54UMtknGS9jBnShMe4TW95aKMNP8bUSuvsogKYDhNdBONYAPrWn8knYtn6CVh//KaCOMHgFAnbAA0vFo6ZfncVWBpxuwgnmB9V1OCO0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf608ca-8d79-4ea7-96c8-08d727fdbb40
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 19:11:42.0284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cSEddpcg/saqOpsEelq3kR9VHxcbrTTYUOioxZ1IdiPq88OOF36gDNiOjo9ibMpDFx9exECfseb7Fg214LLzXBjw6w6MVrHaawp15P7dsRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2717
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

