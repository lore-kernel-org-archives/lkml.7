Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05122C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4202075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nwkC+QF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfFEK3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 06:29:41 -0400
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:27982
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbfFEK3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 06:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93zaW02zuIjpnvTLQWsbo123yZtcIUuZGTGSXVRFxSs=;
 b=nwkC+QF6UuZDlA7RENtn7ZNzQUqYgSKT5XFuiMN+TIF9SFISsKtHSrjummyh91sCTjIaTNy8KhBKbnz7Wh00mkuJgDWMlo0jtlZKoBO2F6WVgteTqg1LxwzsBKoBptF5Bz5GAVr+JYk0OFnVet7+6upaTB5xaJy2JMMkQpna4mY=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6448.eurprd04.prod.outlook.com (20.179.232.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Wed, 5 Jun 2019 10:29:37 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30%7]) with mapi id 15.20.1943.018; Wed, 5 Jun 2019
 10:29:37 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Nicolin Chen <nicoleotsuka@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: fsl_esai: fix the channel swap issue after xrun
Thread-Topic: [PATCH] ASoC: fsl_esai: fix the channel swap issue after xrun
Thread-Index: AdUbiN9oFE5912rCR4S4j98+QHq3YA==
Date:   Wed, 5 Jun 2019 10:29:37 +0000
Message-ID: <VE1PR04MB6479D7512EDE1217228033CAE3160@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb2a07fc-8f8d-41d9-1519-08d6e9a0b5e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6448;
x-ms-traffictypediagnostic: VE1PR04MB6448:
x-microsoft-antispam-prvs: <VE1PR04MB6448106546CC88F90CEEFEE8E3160@VE1PR04MB6448.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(346002)(376002)(199004)(189003)(53936002)(110136005)(54906003)(6246003)(25786009)(316002)(52536014)(478600001)(5660300002)(14454004)(4326008)(7696005)(68736007)(2501003)(66066001)(33656002)(9686003)(55016002)(3846002)(6116002)(229853002)(186003)(2906002)(71190400001)(256004)(71200400001)(6506007)(66446008)(99286004)(8936002)(102836004)(66556008)(64756008)(73956011)(66946007)(26005)(86362001)(486006)(476003)(66476007)(74316002)(76116006)(6436002)(8676002)(305945005)(81166006)(81156014)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6448;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nd5VNJAsdiAZAun34cLpBHKiidakPYTTVH+fUcBaaCwRZ+328ICws/ANXPLJACEkYV8V0UwVKGHHdjBKaZWlvzK+7vZSwggt01c8Ootlf2v6GxaEFO0dRI//DzVr7c2BT6lvNEGi9WFjW58tbjxM2m2P1HJXNf1pQcvY24jAXz7IVNn6nmxbfn02WoqqN0HoYRzKrMJgGM2OsjknalPsjIPVTDXtTdTj2GnSITuktIUlho4WarxJrfBPDVPlyasRfsPVI8zzEuzYk+Kns4MGYdPMaRikEzOuG7Dn0Sfc75vYrhDO9PskTFzICHN1JJ0KAGAcULANvjBWlcBRP8Q5ba2DWcurLaCH25J/YRSzlHg/spFkQSjoI9i+Gclw6TDhDkmRzR0se7smXlGJLdqHYSqiSJnK4cCUYHeH2OeOV4A=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2a07fc-8f8d-41d9-1519-08d6e9a0b5e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 10:29:37.4157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shengjiu.wang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6448
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
> > > > > Sounds like a bug to me...should fix it first by marking the
> > > > > data registers as volatile.
> > > > >
> > > > The ETDR is a writable register, it is not volatile. Even we
> > > > change it to Volatile, I don't think we can't avoid this issue.
> > > > for the regcache_sync Just to write this register, it is correct be=
havior.
> > >
> > > Is that so? Quoting the comments of regcache_sync():
> > > "* regcache_sync - Sync the register cache with the hardware.
> > >  *
> > >  * @map: map to configure.
> > >  *
> > >  * Any registers that should not be synced should be marked as
> > >  * volatile."
> > >
> > > If regcache_sync() does sync volatile registers too as you said, I
> > > don't mind having this FIFO reset WAR for now, though I think this
> > > mismatch between the comments and the actual behavior then should
> get people's attention.
> > >
> > > Thank you
> >
> > ETDR is not volatile,  if we mark it is volatile, is it correct?
>=20
> Well, you have a point -- it might not be ideally true, but it sounds lik=
e a
> correct fix to me according to this comments.
>=20
> We can wait for Mark's comments or just send a patch to the mail list for
> review.
>=20
> Thanks you

I test this patch, we don't need to reset the FIFO, and regcache_sync didn'=
t
Write the ETDR even the EDTR is not volatile.  This fault maybe caused by
Legacy, in the beginning we add this patch in internal branch, there maybe
Something cause this issue, but now can't reproduced.=20

So I will remove the reset of FIFO.

Best regards
Wang Shengjiu =20



