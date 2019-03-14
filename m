Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFB7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355082184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="PWYA5OoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfCNOci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:32:38 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:1682 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfCNOch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:32:37 -0400
X-IronPort-AV: E=Sophos;i="5.58,478,1544511600"; 
   d="scan'208";a="28192145"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Mar 2019 07:32:36 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Mar 2019 07:32:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zlf4KIFmvTYgKXbrWtgqXKHjE/4rX5RXS374QmjVmNw=;
 b=PWYA5OoB93v45QOvMgr27hgNGHWb2qagJ8SAaGtiD6gGe1buF3j5Iy3qfnSeRStVSXYXCbxy4LBY1v+oIO+3MCcSNMMWXpVntTc5hlOZbTL30SgjjUu0ldvdMK1VM8L2D2QAfBHx5RoR0zMdXzXOnZAKtvwP4v5Bm6e+eRnlbSY=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1744.namprd11.prod.outlook.com (10.175.53.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 14 Mar 2019 14:32:32 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%9]) with mapi id 15.20.1686.021; Thu, 14 Mar 2019
 14:32:32 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <anson.huang@nxp.com>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>,
        <linux@armlinux.org.uk>, <stefan@agner.ch>,
        <otavio@ossystems.com.br>, <leonard.crestez@nxp.com>,
        <schnitzeltony@gmail.com>, <jan.tuerk@emtrion.com>,
        <yibin.gong@nxp.com>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>
CC:     <linux-imx@nxp.com>
Subject: Re: [PATCH V3 2/5] pwm: Add i.MX TPM PWM driver support
Thread-Topic: [PATCH V3 2/5] pwm: Add i.MX TPM PWM driver support
Thread-Index: AQHU2i8UfsWigsRPE0WddLYXHF4Yz6YK3zgAgAA6SwCAABeQAA==
Date:   Thu, 14 Mar 2019 14:32:32 +0000
Message-ID: <0080775b-05cb-a691-5847-2f4edc538880@microchip.com>
References: <1552544534-5295-1-git-send-email-Anson.Huang@nxp.com>
 <1552544534-5295-3-git-send-email-Anson.Huang@nxp.com>
 <79e6e48f-8d93-84fa-70d4-8c8f95ac2eea@microchip.com>
 <DB3PR0402MB3916C2561A7597F35D1A2EA0F54B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916C2561A7597F35D1A2EA0F54B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR03CA0075.eurprd03.prod.outlook.com
 (2603:10a6:803:50::46) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190314163215908
x-originating-ip: [86.120.234.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1b50e44-e1a7-4be8-1b55-08d6a889e470
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1744;
x-ms-traffictypediagnostic: MWHPR11MB1744:
x-microsoft-antispam-prvs: <MWHPR11MB174426DE4FD4039709BF8E06874B0@MWHPR11MB1744.namprd11.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(93886005)(305945005)(25786009)(6486002)(4326008)(2501003)(26005)(6512007)(53936002)(6436002)(99286004)(5660300002)(7736002)(52116002)(76176011)(102836004)(97736004)(7416002)(36756003)(2906002)(386003)(6246003)(31696002)(81156014)(2201001)(53546011)(6506007)(14454004)(86362001)(256004)(105586002)(8936002)(81166006)(229853002)(106356001)(31686004)(71190400001)(8676002)(66066001)(110136005)(68736007)(2616005)(558084003)(186003)(14444005)(446003)(478600001)(71200400001)(72206003)(3846002)(486006)(6116002)(11346002)(316002)(476003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1744;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hZt98PBbt7KMpVbOSaZzbMMkOMQc/KO2lN6xED/6lFICPJFsAGWVRDhQOA+z0nnX1LrQm3Hqz4xHyj+Byef0Uy93Kfe79bmlUeZBul8ttrNtu3tZQhQx8o/BHBmxgA3MHVWiBTFJTicZAXatiuREl23yVg9xWs/jERvJRhj1RUfHzOenu7l+lsYmXTfzRGBqBR+ZP4EZabSJb4kLLH/dkSjnQ/TAUTomSR6JYZp8zSE8n1qiuI01oJW8hNBDlol33dHn2nIsT6y/iZqgqunTXwyM6eP9FOaTg0AmVmrMNMoXY679gF+5CZp4RCNjIFG2lqWDGY40WswnH3siunEmhoZ0byP5bXeT0GpGDjc8QmSbCtjjA8RHXDzJKGbUe/CjCMopI4u1bMnwgMYwSOJFdfD2gmxevfcoH4ECcSpaEDs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B396336CB34714A986A95AB13969412@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b50e44-e1a7-4be8-1b55-08d6a889e470
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 14:32:32.5560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1744
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE0LjAzLjIwMTkgMTU6MDcsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiBzbyBoZXJlIEkg
anVzdCBtYWtlIGl0IGVuYWJsZWQNCj4gYWZ0ZXIgcHJvYmVkLCBhbmQgT05MWSBkaXNhYmxlIGl0
IGFmdGVyIGRyaXZlciBpcyByZW1vdmVkIG9yIHN1c3BlbmRlZC4NCg0KT2ssIGFncmVlIQ0K
