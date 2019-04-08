Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19234C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C4E20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RTidcFK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDHKq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:46:56 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:56073 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbfDHKq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:46:56 -0400
X-IronPort-AV: E=Sophos;i="5.60,325,1549954800"; 
   d="scan'208";a="29661142"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Apr 2019 03:46:54 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 8 Apr 2019 03:46:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3Pyv3nPnfkLnlxKtutK3/JEPBY+yx8ZrPPsNF5KhFc=;
 b=RTidcFK7PIvJ2XwtaNtqaB30gT9uWiZOqS5TUY+LTvM9vzXeBartRVbNtVBA835udVCNLQNeywDCpBoo72a0lqEGD2KWQTgFPRk3J5y5VmRR/rp26MAeuarOns/9As8xLY2aMKdQ9VazNd2jY/2pyU4b9I8KWTTIXOUAF8M/DZ0=
Received: from BL0PR11MB3329.namprd11.prod.outlook.com (10.167.235.150) by
 BL0PR11MB3281.namprd11.prod.outlook.com (10.167.234.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Mon, 8 Apr 2019 10:46:52 +0000
Received: from BL0PR11MB3329.namprd11.prod.outlook.com
 ([fe80::24e8:ee39:be6e:9336]) by BL0PR11MB3329.namprd11.prod.outlook.com
 ([fe80::24e8:ee39:be6e:9336%2]) with mapi id 15.20.1771.021; Mon, 8 Apr 2019
 10:46:52 +0000
From:   <RaghuramChary.Jallipalli@microchip.com>
To:     <Jisheng.Zhang@synaptics.com>, <marc.zyngier@arm.com>
CC:     <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: lan78xx: fix "enabled interrupts" warninig
Thread-Topic: [PATCH] net: lan78xx: fix "enabled interrupts" warninig
Thread-Index: AQHU7dHV0yp6Fa7I5USr12hPuITf3qYx3ZMggAALEoCAACApYA==
Date:   Mon, 8 Apr 2019 10:46:52 +0000
Message-ID: <BL0PR11MB3329824981AAA87127C157C69F2C0@BL0PR11MB3329.namprd11.prod.outlook.com>
References: <20190408140301.3dcbccdd@xhacker.debian>
        <BL0PR11MB33292EC33542F7D4FE5208469F2C0@BL0PR11MB3329.namprd11.prod.outlook.com>
 <20190408155947.3efcb1eb@xhacker.debian>
In-Reply-To: <20190408155947.3efcb1eb@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RaghuramChary.Jallipalli@microchip.com; 
x-originating-ip: [118.185.82.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7441fdb-2f7c-44d4-4e9e-08d6bc0f82d8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BL0PR11MB3281;
x-ms-traffictypediagnostic: BL0PR11MB3281:
x-microsoft-antispam-prvs: <BL0PR11MB3281BE11055CE6B65F0EDF2F9F2C0@BL0PR11MB3281.namprd11.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(366004)(39860400002)(189003)(199004)(68736007)(7736002)(186003)(102836004)(26005)(6506007)(11346002)(446003)(305945005)(74316002)(76176011)(486006)(33656002)(52536014)(106356001)(110136005)(105586002)(476003)(55016002)(9686003)(54906003)(2906002)(6116002)(3846002)(6436002)(6246003)(53936002)(316002)(229853002)(5660300002)(4326008)(66066001)(7696005)(256004)(25786009)(72206003)(86362001)(14454004)(97736004)(71190400001)(71200400001)(4744005)(14444005)(8676002)(478600001)(81156014)(81166006)(8936002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR11MB3281;H:BL0PR11MB3329.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N96efMKdKtMn82l1Klig1FNdbho+0uU2yTxSyqkDGgBif35dnK0ujKd4EUxxaPcp+xUInTmF5HbFYOr0OLyNE4oxqKQdatiSPW5eQpLPBNFsztvky6186H1uoDzESS2E5t8kZExu0y+phWnAj+anA7Tw6lNM3BbNqfM6KqGckiOPieRhk8yiM0f6pZOpefsrLjDm5sfPUJGTHTV0RJArOwnHZHhC/PwyLDd0YHyPnM9hGQU8r/z1dYNaZyPyxDMzoTI7agOv42nEk1zj1oTTi5mfVk5LP81y7797/IOkxSYVqc260PLVk3EQUaH/HNLnDhH+dUA6O6yQykKIC1w1xPENLhln+Bba6bLqgbNExmTjmVdrjdARyKH2ofH163PVa5X/QnA5NXsu0wIQDV7loawncQCxZoBda/3jgKNummg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c7441fdb-2f7c-44d4-4e9e-08d6bc0f82d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 10:46:52.3878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3281
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is this warning specific to any linux version?
>=20
> In theory, no. I only tested 5.0, 4.20, both can reproduce this warning.
>
This makes me think that code is fine because it occurs in 4.20 and greater=
. Or maybe the problem is masked in older. I maybe wrong in assuming that.=
=20
=20
>=20
> The warning comes from calling generic_handle_irq() in usb tasklet contex=
t.
> This is not correct.
>=20
> Per my understanding, if there's chained irq, we could introduce extra
> irqdomain. E.g
>=20
> GIC <--> another irqchip controller <--> HW device
>=20
Correct, IRQ domain is generally used in chained irq controllers.
Yes, We need to check why irq domain is used in the current driver.

Thanks
