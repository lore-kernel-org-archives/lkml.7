Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A982C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5465B24774
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WE8aLIMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfEaQra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:47:30 -0400
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:56017
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727105AbfEaQr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PNB+iX0JXfIC0kbo7QRgW+BBwqfUl6yy2PWjiq0550=;
 b=WE8aLIMgkT6+mj+1pimOxRgKud4Nsu+0perqEnBGYI6mvtLqm64hBvV7ImBQuq8aQwGi0w9IRa+qpiAGhIyPHwKvl0z1+g6NBZIDK0dIPrry9vM1A+6ppJ+5evvfe4Kzd2CgMDsou5zv41/n9BwXro7z5ZMHzrO1KcH0kxz/DpE=
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com (52.134.90.16) by
 AM0PR04MB4212.eurprd04.prod.outlook.com (52.134.95.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Fri, 31 May 2019 16:47:24 +0000
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::3df6:6e48:cc6d:71c6]) by AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::3df6:6e48:cc6d:71c6%5]) with mapi id 15.20.1922.021; Fri, 31 May 2019
 16:47:24 +0000
From:   York Sun <york.sun@nxp.com>
To:     Radu Nicolae Pirea <radu_nicolae.pirea@upb.ro>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     Mike Turquette <mturquette@baylibre.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrey Filippov <andrey@elphel.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [Patch v9] driver/clk/clk-si5338: Add common clock
 framework driver for si5338
Thread-Topic: [EXT] Re: [Patch v9] driver/clk/clk-si5338: Add common clock
 framework driver for si5338
Thread-Index: AQHVF7oG6C1le8DQ9Euu7t2xmZzbwg==
Date:   Fri, 31 May 2019 16:47:24 +0000
Message-ID: <AM0PR04MB3971799F379795FE812D6D529A190@AM0PR04MB3971.eurprd04.prod.outlook.com>
References: <1472247978-29312-1-git-send-email-york.sun@nxp.com>
 <96cb1e730ea5afd651d4c79f20f365df5fe8a29b.camel@upb.ro>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=york.sun@nxp.com; 
x-originating-ip: [66.235.24.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd73a39a-1f28-46d9-5be2-08d6e5e7a84f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4212;
x-ms-traffictypediagnostic: AM0PR04MB4212:
x-microsoft-antispam-prvs: <AM0PR04MB421265AE67A1B5B3CF01E64D9A190@AM0PR04MB4212.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:862;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(3846002)(7736002)(52536014)(76116006)(54906003)(4744005)(2906002)(64756008)(6116002)(7696005)(6436002)(26005)(73956011)(86362001)(229853002)(33656002)(478600001)(91956017)(110136005)(66476007)(66446008)(74316002)(25786009)(316002)(66556008)(66946007)(5660300002)(305945005)(2501003)(186003)(7416002)(44832011)(446003)(8936002)(68736007)(55016002)(486006)(76176011)(6506007)(9686003)(71190400001)(99286004)(81156014)(102836004)(8676002)(53936002)(53546011)(71200400001)(66066001)(4326008)(14454004)(6246003)(81166006)(256004)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4212;H:AM0PR04MB3971.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GRCqxB4sHejEnDciYNjolrqYJCNdiN/+9H5QD6Eyh1dY/VJuOiw+IYHg+jJbH2KGaaz+INqmQ9CmmuJGP70PLaHtmaqDcIYGFl6Ap4cSI8hDj2DIol1ocasPu9LhC4VCd5GLMZ3MnLOooAhGiwiVqpQUMIqweThVFaeNn6YxLzKUjGi60Ku5NFCBmxt3J5ymcK1Ur40XodzoPP8nM62zk4s43d/+H5p+7J4HLomqqlec0VawHQXbYanYXfcBisC/2aF8Jnlo/zlpZkjj2Pc1jXsX1WpjaiGQrC7IrzS7uze9JCtyWThVvnCKxTDv0KtE3pQuJekEBL6gQdP4947nOf0jUBYxnCzTnnS0kzMQ16C4DwBY5sLFdbT0fylnyU7w/qC1q1TSptdbUyH86cgobvgqf+JDuUVbuAFPIMWlhFQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd73a39a-1f28-46d9-5be2-08d6e5e7a84f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 16:47:24.2653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: york.sun@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/19 7:06 AM, Radu Nicolae Pirea wrote:=0A=
> Caution: EXT Email=0A=
> =0A=
> Hi,=0A=
> =0A=
> @York I want to continue the work on this driver and I want to upstream=
=0A=
> it. Are you OK with this?=0A=
> =0A=
> I saw later improvement suggestions related to the bindings and I will=0A=
> make the changes.=0A=
=0A=
Radu,=0A=
=0A=
You are welcome to improve this driver.=0A=
=0A=
York=0A=
