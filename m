Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB60C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A447213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bg7IIf1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDIDaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 23:30:23 -0400
Received: from mail-eopbgr30075.outbound.protection.outlook.com ([40.107.3.75]:12878
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbfDIDaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 23:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAf9A4w+9vNSkHjT1yAJGnnTHITL+JVOiciMOwFTIOQ=;
 b=Bg7IIf1p4bQp/y91zUhQW7N8yV67ZkD4vJX43jwAoLdylGLqsBD3Pd8mle2TaRiLFvBE00/CF8SJ1VaYQjB9Jtb8XLoqN+nCQ8o3LGpaVelikUY6tVuosRZU126xDkNeNg+pph37eflMHhAIvUcyxmPydNMAuU2ja/olNZqSax8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5252.eurprd04.prod.outlook.com (20.177.42.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Tue, 9 Apr 2019 03:30:19 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 03:30:19 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
Subject: RE: [PATCH v3] pinctrl: imx8mq: Add suspend/resume ops
Thread-Topic: [PATCH v3] pinctrl: imx8mq: Add suspend/resume ops
Thread-Index: AQHU7jpDrz+M9DfmAkuvRDoTgxvh06YzLIeA
Date:   Tue, 9 Apr 2019 03:30:19 +0000
Message-ID: <AM0PR04MB42112C433296FE60C7FE5646802D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1554748702-2368-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1554748702-2368-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96806d47-f544-4699-9d86-08d6bc9bb11a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5252;
x-ms-traffictypediagnostic: AM0PR04MB5252:
x-microsoft-antispam-prvs: <AM0PR04MB5252634134DE4B784FC32D28802D0@AM0PR04MB5252.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(74316002)(7736002)(54906003)(476003)(446003)(316002)(7696005)(81156014)(256004)(14444005)(33656002)(110136005)(55016002)(8676002)(81166006)(5660300002)(305945005)(52536014)(76176011)(11346002)(486006)(44832011)(14454004)(99286004)(15650500001)(8936002)(4744005)(66066001)(6436002)(478600001)(86362001)(229853002)(68736007)(6506007)(97736004)(26005)(106356001)(102836004)(6246003)(71200400001)(53936002)(105586002)(3846002)(71190400001)(6116002)(4326008)(9686003)(25786009)(2906002)(186003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5252;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jUYKMz5W2wwC+lUlonzbkNP3OzXa5w9aBo7UZ8I7pv4QNMWmuI1+J5i9r/Of0RUYGPVtYKql/pAcOtqjipdw0ZNR5MRQr/rtasVLVElZhi6cf9oBdR12Z0Rom20Yyf883dx3yJJOqoXOkuogpGivuDx0Ytz9/PLqMese9xVC7BEKurf98rDR/zM1aoVPzkOHx8GgiVhwD4YKSMoeOScONnsJX3xrJK1B6iwhXhQnMfQacReygdQgiSlhspLVDo5/rRaWCSwjgjUivvJdOYB6X8JmjAh73u8iTi6fYcGc4Ap6FSWJLHxpQq4fBrztqDsN8z5ErxVR2nKtib8uS/lnP19NwZv/E6vQnouRG+Oz0jEzfFeIMgQZhIw3C9RDs2IOKHqqRZ15UBj8r1dtFwOS96d67BoO06fifM626lFZTdI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96806d47-f544-4699-9d86-08d6bc9bb11a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 03:30:19.5367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5252
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Abel Vesa
> Sent: Tuesday, April 9, 2019 2:39 AM
>=20
> To support pinctl hog restore after LPSR resume back, add the generic
> suspend/resume in pinctrl-imx along with the generic pm ops to be used by
> platform specific drivers. Then make use of the newly added ops in i.MX8M=
Q
> platform specific driver.
>=20
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
