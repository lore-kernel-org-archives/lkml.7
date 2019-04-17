Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0F7C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3F62073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="NBRGzTmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbfDQIWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:22:12 -0400
Received: from mail-eopbgr680083.outbound.protection.outlook.com ([40.107.68.83]:60503
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728531AbfDQIWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rry4T1fhzj9zDMMjQeePAGYS05AW6bOyEODh1CvSXWA=;
 b=NBRGzTmnWKjQ2Rg6CjApiqDelQ4OsuPre7ufDLva9vfOYR+E/AJC7Yo4TqPHGVChuRSTyag5HNyLvcUztXBpX3cE350FmR4ApAoZF3FdwKkhHShgaeBqOhzICl6fNq27JBw7badNvOgVt/F3OhWQvfcrkyDPDjYt0f/HLB8JI8k=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4613.namprd03.prod.outlook.com (20.179.90.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Wed, 17 Apr 2019 08:22:07 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::7933:c072:6250:6b25]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::7933:c072:6250:6b25%3]) with mapi id 15.20.1792.021; Wed, 17 Apr 2019
 08:22:07 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     "RaghuramChary.Jallipalli@microchip.com" 
        <RaghuramChary.Jallipalli@microchip.com>
CC:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "Woojung.Huh@microchip.com" <Woojung.Huh@microchip.com>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: lan78xx: fix "enabled interrupts" warninig
Thread-Topic: [PATCH] net: lan78xx: fix "enabled interrupts" warninig
Thread-Index: AQHU7dHNU1pmmx19ukWi008Ht4Z+BqYx4peAgACJ84D//6iSAIABfFmAgAGQOQCAAAb8AIAKnOQAgABJ0IA=
Date:   Wed, 17 Apr 2019 08:22:07 +0000
Message-ID: <20190417161357.4e29fedd@xhacker.debian>
References: <20190408140301.3dcbccdd@xhacker.debian>
        <BL0PR11MB33292EC33542F7D4FE5208469F2C0@BL0PR11MB3329.namprd11.prod.outlook.com>
        <20190408155947.3efcb1eb@xhacker.debian>
        <BL0PR11MB3329824981AAA87127C157C69F2C0@BL0PR11MB3329.namprd11.prod.outlook.com>
        <20190409092753.39961390@xhacker.debian>
        <BL0PR11MB3329C59EEA6073D8073D23ED9F2E0@BL0PR11MB3329.namprd11.prod.outlook.com>
        <20190410174538.5ebe1787@xhacker.debian>
        <BN6PR11MB39530B69C9BD75927F1F61B89F250@BN6PR11MB3953.namprd11.prod.outlook.com>
In-Reply-To: <BN6PR11MB39530B69C9BD75927F1F61B89F250@BN6PR11MB3953.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:404:42::22) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4eabcb3-983a-4ae0-fd31-08d6c30dc77e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR03MB4613;
x-ms-traffictypediagnostic: BYAPR03MB4613:
x-microsoft-antispam-prvs: <BYAPR03MB4613107C88DA06A72E3571ABED250@BYAPR03MB4613.namprd03.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(136003)(346002)(39860400002)(199004)(189003)(86362001)(68736007)(5640700003)(229853002)(14444005)(5024004)(316002)(54906003)(7416002)(486006)(476003)(446003)(7736002)(3846002)(256004)(2906002)(6436002)(1076003)(11346002)(305945005)(6486002)(8936002)(71200400001)(76176011)(66066001)(8676002)(26005)(71190400001)(102836004)(52116002)(6116002)(25786009)(186003)(478600001)(6506007)(106356001)(4326008)(14454004)(105586002)(5660300002)(81166006)(97736004)(6916009)(81156014)(6512007)(2351001)(99286004)(72206003)(2501003)(53936002)(93886005)(50226002)(386003)(9686003)(6246003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4613;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q68ETHDzaQHYQ/eBaQBZobloCwfXaTrLlB7gUplbzKCUphyKSkGLEPILz1oImPH6Kxpqm+L6OU9UKooXdtMrOxLR072kIBjD2i2zEbZrLDasOXJPpl2rQsxd3NW1IY3qPRV1kceIpJvi3ve6jZL2l6vjE9QBWMVxV3ItzHw0KKRnHRq88q03K4HVRd2adWKp4odK8ZVATTflqE55n0y7z/dBrYgPCM8IX3mnDCHwywsRwuyUf9I28+YXNpgymillvZvAM5F17nfE5MVTsrFxqpe/N6472PGu1B924cXDq+saWAQdMqYUIjaFhd70bXpi5Wdi/CMbXrW6Gci7nLipihd862TUgPnkvrB3SOBTEyd/BKGUfi3vuo1GvZhRHezmkzneMLK89GISx+ilYUo1ashtbaHC6j1Ef+bsWD0RyG4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <74CEE7F8C39F444DBD448AF83329DECE@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4eabcb3-983a-4ae0-fd31-08d6c30dc77e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 08:22:07.2185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4613
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 03:49:46 +0000 <RaghuramChary.Jallipalli@microchip.com>=
 wrote:

>=20
> Hi Jisheng,

Hi,

>=20
> > > I want to understand if there is any functionality impact with this w=
arning? =20
> > Because I'm afraid if the current changes are removed we might hit some
> > other issues (or older ones). We have to go through rigorous testing be=
fore
> > going ahead.
> >
> > Warning indicates there's something wrong in the code. =20
>=20
> Agree that the code is incorrect. Just wanted to understand if you had an=
y functionality impact too.
>=20
> >
> > IMHO phy_mac_interrupt() and PHY_IGNORE_INTERRUPT is the correct
> > solution. If the phy_mac_interrupt() poll is fixed, I think maybe old i=
ssue
> > which commit cc89c323a30e want to fix won't exist.
> > =20
>=20
> I tried to reproduce the problem in PC environment but did not see the wa=
rnings.
> However, I tried your patch and did plug/unplug tests(rmmod/insmod contin=
uously) and observed call traces from kernel. I don't see these traces with=
out your patch.
> Attached log.

I believe this is another bug in lan78xx driver: after phy_disconnect() if
there's intr urb coming, we will call phy_mac_interrupt, so trigger
phy_state_machine(), but now the phydev->attached_dev is NULL, so NULL
pointer deference. Can you please try below patch:

--->8
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 246a0d1bbc6c..27d6fbdd58c1 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3467,6 +3467,8 @@ static void lan78xx_disconnect(struct usb_interface *=
intf)
 	net =3D dev->net;
 	phydev =3D net->phydev;
=20
+	usb_kill_urb(dev->urb_intr);
+
 	phy_unregister_fixup_for_uid(PHY_KSZ9031RNX, 0xfffffff0);
 	phy_unregister_fixup_for_uid(PHY_LAN8835, 0xfffffff0);
=20
@@ -3483,7 +3485,6 @@ static void lan78xx_disconnect(struct usb_interface *=
intf)
=20
 	lan78xx_unbind(dev, intf);
=20
-	usb_kill_urb(dev->urb_intr);
 	usb_free_urb(dev->urb_intr);
=20
 	free_netdev(net);

