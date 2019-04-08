Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CE5C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF3920883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="SkmjpV32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDHIHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:07:48 -0400
Received: from mail-eopbgr720075.outbound.protection.outlook.com ([40.107.72.75]:7221
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbfDHIHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1tDYvMUNFpwicM/oUGRn7zzJmNQVguap/IF5fgjMVI=;
 b=SkmjpV32f8WTQeINZVW8gAE76lFhtgTI5eb557COigk9uRk2JkWGLT8zLuqwdU3BZYb5JWghwCr1VghiE+aA5DvNNVhiQdEz858Glp8W8zYP8b8TmSJTInEmSC8zSEom0W0MVS3s99WvbKN8gs1QbMQkSEWNydCUlR1MelOiuKU=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4021.namprd03.prod.outlook.com (20.177.127.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 08:07:43 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 08:07:43 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     "RaghuramChary.Jallipalli@microchip.com" 
        <RaghuramChary.Jallipalli@microchip.com>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     "Woojung.Huh@microchip.com" <Woojung.Huh@microchip.com>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: lan78xx: fix "enabled interrupts" warninig
Thread-Topic: [PATCH] net: lan78xx: fix "enabled interrupts" warninig
Thread-Index: AQHU7dHNU1pmmx19ukWi008Ht4Z+BqYx4peAgAAD1oA=
Date:   Mon, 8 Apr 2019 08:07:43 +0000
Message-ID: <20190408155947.3efcb1eb@xhacker.debian>
References: <20190408140301.3dcbccdd@xhacker.debian>
        <BL0PR11MB33292EC33542F7D4FE5208469F2C0@BL0PR11MB3329.namprd11.prod.outlook.com>
In-Reply-To: <BL0PR11MB33292EC33542F7D4FE5208469F2C0@BL0PR11MB3329.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY1PR01CA0184.jpnprd01.prod.outlook.com (2603:1096:403::14)
 To BYAPR03MB4773.namprd03.prod.outlook.com (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42dcfc6b-2225-498d-37fb-08d6bbf946a0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR03MB4021;
x-ms-traffictypediagnostic: BYAPR03MB4021:
x-microsoft-antispam-prvs: <BYAPR03MB40218E75A1CC4662C5C5A5D8ED2C0@BYAPR03MB4021.namprd03.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(376002)(366004)(189003)(199004)(51914003)(81156014)(99286004)(81166006)(486006)(110136005)(6486002)(54906003)(2501003)(316002)(14454004)(50226002)(446003)(11346002)(102836004)(25786009)(6436002)(5660300002)(8936002)(52116002)(26005)(6116002)(3846002)(72206003)(66066001)(6246003)(68736007)(2906002)(478600001)(476003)(9686003)(97736004)(4326008)(6512007)(105586002)(305945005)(8676002)(86362001)(186003)(71190400001)(53936002)(106356001)(6506007)(229853002)(386003)(1076003)(76176011)(14444005)(256004)(7736002)(71200400001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4021;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: twQLTMYr/4F5HzcJPlNSRlqbd8nLlatNyaf+rnFEbRMaRtlda/LMKHOM5iLss4mTEJj0tREMyx/xgKEFd2BAbMhRtSMg8jbsVtgH1dAh+O026IEWN9z0pkoS9r/flbpyu7cv8tVsxz9eyvuhUopN62sQwDckb9RNCKj1sr3X+rbHD+hQMtrlReIX+/cUGp3RC4/c8+67ddS2ZBGYq4ibs5z0mVrQOlgnDo6NtpGiTQp4nU5trkdYhoWQUtVsD/y0gg/BsII6xXWzGUFxlX+DSjoSEYUUpCMdxwv6CvwdHFybI61CShTE4IO0c7hamssFFXkoul0PooqbdkqNSUgpUFC9jYr5wZhCQbzgHLdSN6vptdw1atv2GYi/MwPizSHoxnOlwQYLRAXc+yWlzhiJI2HKKXrQkPwkOStZ63hM0kw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D712D61574FC944DBD3FEC1F684D77D2@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dcfc6b-2225-498d-37fb-08d6bbf946a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 08:07:43.0503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019 07:46:03 +0000 wrote:

>=20
>=20
> >
> > Per my understanding, the proper handling of PHY irq is to make use of
> > PHY_IGNORE_INTERRUPT then call phy_mac_interrupt when
> > INT_ENP_PHY_INT is triggered.
> > =20
>=20
> Hi Jisheng,

Hi

> Thanks for the changes.
> Is this warning specific to any linux version?=20

In theory, no. I only tested 5.0, 4.20, both can reproduce this warning.

> Why do you think PHY irq domain handling is not proper?

+ Marc

The warning comes from calling generic_handle_irq() in usb tasklet context.
This is not correct.

Per my understanding, if there's chained irq, we could introduce extra
irqdomain. E.g

GIC <--> another irqchip controller <--> HW device

But in lan78xx, this is not the case. There's no chained irq at all.
In fact, there's a bit INT_ENP_PHY_INT in MAC's Interrupt Endpoint status
word to indicate this is PHY interrupt. So this is the case
PHY_IGNORE_INTERRUPT/phy_mac_interrupt intend for.

irq experts knows irqdomain etc better, maybe they can provide more inputs

> Maybe we can fix that rather removing complete IRQ domain code changes.
> Also, Can you pls let us know how this changes fixed your warning.

The patch removes the generic_handle_irq() calling from invalid context.

Thanks
