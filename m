Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6E9C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381202084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X+nvi14o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfDLCZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 22:25:46 -0400
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]:24131
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfDLCZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 22:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45NpUaJ16rCVVf/LFAh1yory77Vj7fwAp5I5rDKt+VQ=;
 b=X+nvi14omlIRxKoaKI3H7U1wfhr3XaUSvhaYq1xxXswbtNNcPf/1XsA8HTHRkhBXJ87rr+cjB4+MnNJcHzB07oMeoMF9fVwC3hziyAmmGtyVHrXnfafbcMmtJYgUIDFlihUyh8HmuxNU4XWmP64PtorYRsqZzbTGM2KJzBkKP9U=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5924.eurprd04.prod.outlook.com (20.178.117.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Fri, 12 Apr 2019 02:25:42 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 02:25:42 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXT] Re: [PATCH V7 2/4] firmware: imx: enable imx scu general
 irq function
Thread-Topic: [EXT] Re: [PATCH V7 2/4] firmware: imx: enable imx scu general
 irq function
Thread-Index: AQHU7pET1wfs7oociU2EvcNWCsnYxqY2lGmAgAEmHACAABRYkA==
Date:   Fri, 12 Apr 2019 02:25:42 +0000
Message-ID: <AM0PR04MB4211816EDBEF23F7B330CCCB80280@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1554785675-8090-1-git-send-email-Anson.Huang@nxp.com>
 <1554785675-8090-2-git-send-email-Anson.Huang@nxp.com>
 <20190411073252.GC3050@dragon>
 <DB3PR0402MB3916B67E6DA995AB70C29799F5280@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916B67E6DA995AB70C29799F5280@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e4b4676-c267-4a72-54ab-08d6beee2960
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5924;
x-ms-traffictypediagnostic: AM0PR04MB5924:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB59243567F89B701410BE87CB80280@AM0PR04MB5924.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(376002)(39860400002)(396003)(199004)(189003)(44832011)(74316002)(52536014)(81156014)(81166006)(476003)(66066001)(8676002)(68736007)(11346002)(486006)(86362001)(93886005)(446003)(6246003)(256004)(71200400001)(478600001)(102836004)(14444005)(25786009)(33656002)(966005)(2906002)(26005)(71190400001)(6506007)(186003)(53936002)(54906003)(97736004)(55016002)(5660300002)(6306002)(76176011)(7416002)(305945005)(99286004)(7696005)(4326008)(14454004)(8936002)(3846002)(105586002)(7736002)(9686003)(2501003)(316002)(106356001)(6116002)(229853002)(6436002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5924;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xp5lbjbLgBVZ+LEEIBjLvid1Cy5dQUgZpkC5lugjLtkaF2mwHLHLr6HpmUbBG/B6d0ajTrWYvBFgScx4JEohaMOgsXVd0tGyi6W3CKEKgs43Ux5dDZ4XEafRP1847JV749oLGDRf9N1dtauW1e+DhKrwebr7cBYKffLufKFPfCr/h7jf3aUqSN8TmHT8yVCAXBtnxF9/7AsGZ1+jkZPpChWrfWg+jR83bods3N8JS91Cm67EFWKX4M562pupMIBIyn00b2zysrJo3675eMDFMZwceSBnlyHS28F9KWL8vjwb8Pam5rMa8ywzYniD5+bohFu/rGoANCa/ib2sC4p0SU5zrELoZSqobrXE+6xP1XPrP7RMi7SzTUJThggfivQk7W8oRR0INHKfnkGS1YDJgXdN8VlSXFanCFtXaTimxQk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4b4676-c267-4a72-54ab-08d6beee2960
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 02:25:42.4326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5924
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Anson Huang
> Sent: Friday, April 12, 2019 9:06 AM
>=20
> Hello, Alexandre
> 	As i.MX SCU general irq function is picked up by Shawn, could you please
> also pick up below i.MX SC RTC alarm support patch ?
> 	https://patchwork.kernel.org/patch/10890525/
>=20

No, it can't go through Alexandre's tree due to dependency issue.

Shawn,
Do you think you can pick it up? Alexandre already gave the Ack.

AFAIK there's no other SCU RTC patches since v5.1-rc1 in Alexandre's tree.

Regards
Dong Aisheng

> > On Tue, Apr 09, 2019 at 04:59:55AM +0000, Anson Huang wrote:
> > > The System Controller Firmware (SCFW) controls RTC, thermal and WDOG
> > > etc., these resources' interrupt function are managed by SCU. When
> > > any IRQ pending, SCU will notify Linux via MU general interrupt
> > > channel #3, and Linux kernel needs to call SCU APIs to get IRQ
> > > status and notify each module to handle the interrupt.
> > >
> > > Since there is no data transmission for SCU IRQ notification, so
> > > doorbell mode is used for this MU channel, and SCU driver will use
> > > notifier mechanism to broadcast to every module which registers the
> > > SCU block notifier.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> >
> > Applied, thanks.
