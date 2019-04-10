Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AD8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D222077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="zxsiMFWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfDJJUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:20:43 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:39526 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbfDJJUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:20:42 -0400
X-IronPort-AV: E=Sophos;i="5.60,332,1549954800"; 
   d="scan'208";a="30015681"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Apr 2019 02:20:40 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 10 Apr 2019 02:20:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k86exRVfpWsSkq2VZ9mZFkYTmrCsubZsVR3iKdKPiKM=;
 b=zxsiMFWP7dhLWIqc6ROyw8ixy7nmxxPn7fDtdqa5LRqKFy/donXjFOI6wUvnL1Yke28wZTggWMA1NeaSYgjf8+eLelyO5EHSZ0ygo/G88HtVTQTuY4xoM157+hjVpxVyFrELeL8gu8A5cv7419vQiyAZ1A7ECRSEu8q9fzpK020=
Received: from BL0PR11MB3329.namprd11.prod.outlook.com (10.167.235.150) by
 BL0PR11MB3249.namprd11.prod.outlook.com (10.167.234.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Wed, 10 Apr 2019 09:20:38 +0000
Received: from BL0PR11MB3329.namprd11.prod.outlook.com
 ([fe80::24e8:ee39:be6e:9336]) by BL0PR11MB3329.namprd11.prod.outlook.com
 ([fe80::24e8:ee39:be6e:9336%2]) with mapi id 15.20.1771.021; Wed, 10 Apr 2019
 09:20:38 +0000
From:   <RaghuramChary.Jallipalli@microchip.com>
To:     <Jisheng.Zhang@synaptics.com>
CC:     <marc.zyngier@arm.com>, <Woojung.Huh@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: lan78xx: fix "enabled interrupts" warninig
Thread-Topic: [PATCH] net: lan78xx: fix "enabled interrupts" warninig
Thread-Index: AQHU7dHV0yp6Fa7I5USr12hPuITf3qYx3ZMggAALEoCAACApYIABBMYAgAIM3VA=
Date:   Wed, 10 Apr 2019 09:20:38 +0000
Message-ID: <BL0PR11MB3329C59EEA6073D8073D23ED9F2E0@BL0PR11MB3329.namprd11.prod.outlook.com>
References: <20190408140301.3dcbccdd@xhacker.debian>
        <BL0PR11MB33292EC33542F7D4FE5208469F2C0@BL0PR11MB3329.namprd11.prod.outlook.com>
        <20190408155947.3efcb1eb@xhacker.debian>
        <BL0PR11MB3329824981AAA87127C157C69F2C0@BL0PR11MB3329.namprd11.prod.outlook.com>
 <20190409092753.39961390@xhacker.debian>
In-Reply-To: <20190409092753.39961390@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RaghuramChary.Jallipalli@microchip.com; 
x-originating-ip: [118.185.82.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96ec3074-88b6-4301-6666-08d6bd95cb97
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BL0PR11MB3249;
x-ms-traffictypediagnostic: BL0PR11MB3249:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BL0PR11MB32493D58276385A27DBAFE449F2E0@BL0PR11MB3249.namprd11.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(346002)(396003)(189003)(199004)(316002)(6436002)(105586002)(76176011)(6916009)(7696005)(54906003)(106356001)(2906002)(93886005)(52536014)(229853002)(99286004)(11346002)(476003)(102836004)(66066001)(446003)(486006)(26005)(6116002)(6506007)(186003)(256004)(25786009)(71190400001)(14444005)(55016002)(71200400001)(4326008)(6306002)(9686003)(86362001)(68736007)(7736002)(8936002)(74316002)(305945005)(53936002)(81156014)(3846002)(72206003)(478600001)(97736004)(81166006)(6246003)(14454004)(8676002)(5660300002)(33656002)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR11MB3249;H:BL0PR11MB3329.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qt4BxReicKsKuqU/Z/jlB8zadWLPDBiHdqP/mPLqpoh77oOAEY2CwGunUQSGpfGlD8nm5/EVSSWCmicHaJ5NHsqTp1ZOTXPTyb8UetDCWKx6/HxEzyBpTzvDnTvo3OoZstchs4MjtCUlBJDC3h+HXge1NmGoPGyXDLi31Um7b5pVazn03sPvdSwp15aIVYN5D+Pdoaxn3o7rs/S0atnLZmpk4av8csyUusPpNYvGRnpyi66WdBTo2K/xlclseUlxvA3khOTRdg8gWgTYFJ04YT/Qc4PM9v7XDzMSO72CWSVO3n2RQx/sI6D1XgrwAPghA7JJuUEzZy+LC8B4IWKkd7/SRwNic2cydvszv1hxjP3AOfZltvd9wU4VuaSjqbyFzUAl0p7aF6/wK0q22MpQcGiBtqjtMCQQYLPW9RbA3KI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ec3074-88b6-4301-6666-08d6bd95cb97
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 09:20:38.0916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3249
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >
> > > The warning comes from calling generic_handle_irq() in usb tasklet
> context.
> > > This is not correct.
> > >
> > > Per my understanding, if there's chained irq, we could introduce
> > > extra irqdomain. E.g
> > >
> > > GIC <--> another irqchip controller <--> HW device
> > >
> > Correct, IRQ domain is generally used in chained irq controllers.
> > Yes, We need to check why irq domain is used in the current driver.
> >
>=20
> It's introduced in the commit cc89c323a30e
>=20
Hi Jisheng,
I had spent some time to look into the history of commit. The reason for ha=
ving irq domain in driver is because of the unavailability of real hardware=
 interrupt, here we have USB interrupt pipe which is not actual interrupt.
So changes were proposed to have pseudo phy interrupt and handlers in phy l=
ib. But later it was suggested to implement linux interrupt controller in d=
river itself.
You can see the archive here https://patchwork.ozlabs.org/patch/564511/
I want to understand if there is any functionality impact with this warning=
? Because I'm afraid if the current changes are removed we might hit some o=
ther issues (or older ones). We have to go through rigorous testing before =
going ahead.

Thanks.

