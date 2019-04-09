Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C93C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E00F20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="tYI///G7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfDIBgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 21:36:15 -0400
Received: from mail-eopbgr750083.outbound.protection.outlook.com ([40.107.75.83]:63342
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725950AbfDIBgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 21:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtOGbTw0D8MZFQkXd32h3JC4MoeshcrO2gx6LlPe9A8=;
 b=tYI///G72EcYpBjUsGXqVu/4R+Usy5jaERYLmfIxEJWl3vIeNLLK2uT1jcQDP2/6XOINZLp/dJibtMqgbxy+j0krQ/KClT2ubIVBHZdr027Lj9kf1bHCy35lf3WtIQKsuXgGHucHRUMJL/vt+Y33rbzmro386fkWmtqUuRHjSIk=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4439.namprd03.prod.outlook.com (20.178.49.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Tue, 9 Apr 2019 01:36:11 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 01:36:11 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     "RaghuramChary.Jallipalli@microchip.com" 
        <RaghuramChary.Jallipalli@microchip.com>
CC:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "Woojung.Huh@microchip.com" <Woojung.Huh@microchip.com>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: lan78xx: fix "enabled interrupts" warninig
Thread-Topic: [PATCH] net: lan78xx: fix "enabled interrupts" warninig
Thread-Index: AQHU7dHNU1pmmx19ukWi008Ht4Z+BqYx4peAgACJ84D//6iSAIAA9j2A
Date:   Tue, 9 Apr 2019 01:36:10 +0000
Message-ID: <20190409092753.39961390@xhacker.debian>
References: <20190408140301.3dcbccdd@xhacker.debian>
        <BL0PR11MB33292EC33542F7D4FE5208469F2C0@BL0PR11MB3329.namprd11.prod.outlook.com>
        <20190408155947.3efcb1eb@xhacker.debian>
        <BL0PR11MB3329824981AAA87127C157C69F2C0@BL0PR11MB3329.namprd11.prod.outlook.com>
In-Reply-To: <BL0PR11MB3329824981AAA87127C157C69F2C0@BL0PR11MB3329.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:404:a6::24) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 125e9db4-8d5a-4b7c-cc60-08d6bc8bbe65
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR03MB4439;
x-ms-traffictypediagnostic: BYAPR03MB4439:
x-microsoft-antispam-prvs: <BYAPR03MB443933E85F38B89EA21215DDED2D0@BYAPR03MB4439.namprd03.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(366004)(396003)(376002)(199004)(189003)(478600001)(25786009)(6916009)(97876018)(14454004)(2501003)(26005)(72206003)(2906002)(70486001)(102836004)(6486002)(76176011)(97736004)(386003)(186003)(66066001)(229853002)(105586002)(14444005)(6506007)(256004)(2351001)(68736007)(6246003)(106356001)(3846002)(8936002)(6512007)(305945005)(86362001)(476003)(71190400001)(11346002)(5640700003)(446003)(6116002)(8266002)(117636001)(81156014)(7736002)(486006)(5660300002)(8676002)(93886005)(99286004)(81166006)(4326008)(53936002)(52116002)(54906003)(6436002)(50226002)(316002)(1076003)(71200400001)(1970100003)(9686003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4439;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l1hWWhy2S1r9yNdDzLabkLzrMp/mz7SrHZ/KiBFkp/QqFGPdUMC84Ii3c42Gi8TEvFrvgtfrGDRmXZwHwWIASlVmnMUONG/LjCKPyNHh0Mg6gM4zooGki2lkBzhEZ2XuU+R2yjTxG9z+p3q3Sr9qpieFq2gh6+4Z4YROyIrrv4KHRoJe/K38TaSzHZ/w1DYdWl7Hzde5ptRRgpUkZWJ4WMx4sM2D4cvzIATbqw5/UnFeuXaE7CudPXXfOGuVgecGm90fNUM2gYY1uToHzZHoFc4c08WQR9NxcPAs2N+T6w9f0rdcWa0p9eQSQgwAVq+du+JHgtae40tWFJZsGaZpkAXrSi6boV9cQ4Jwk8UN6nlqUk0PXl4JnX29HHcS954A1kEFORrP09l7dhF/bEJGEqzPM+AVVdmrC1QMBdBg/aI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7901A8ACE9A14246A1F2FBC0B414FF7F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125e9db4-8d5a-4b7c-cc60-08d6bc8bbe65
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 01:36:10.8928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4439
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019 10:46:52 +0000  wrote:

>=20
>=20
> > > Is this warning specific to any linux version? =20
> >
> > In theory, no. I only tested 5.0, 4.20, both can reproduce this warning=
.
> > =20
> This makes me think that code is fine because it occurs in 4.20 and great=
er. Or maybe the problem is masked in older. I maybe wrong in assuming that=
.

Per my understanding, the warning should occur since commit cc89c323a30e
("lan78xx: Use irq_domain for phy interrupt from USB Int. EP")
I just bought a Raspberry Pi 3B+ a few days ago, so I didn't have chance
to check 4.19 and before.

>=20
> >
> > The warning comes from calling generic_handle_irq() in usb tasklet cont=
ext.
> > This is not correct.
> >
> > Per my understanding, if there's chained irq, we could introduce extra
> > irqdomain. E.g
> >
> > GIC <--> another irqchip controller <--> HW device
> > =20
> Correct, IRQ domain is generally used in chained irq controllers.
> Yes, We need to check why irq domain is used in the current driver.
>=20

It's introduced in the commit cc89c323a30e

Thanks

