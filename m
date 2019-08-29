Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3324C3A5A4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 02:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746712173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 02:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ovX/byAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfH2CqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 22:46:24 -0400
Received: from mail-eopbgr20056.outbound.protection.outlook.com ([40.107.2.56]:36941
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbfH2CqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 22:46:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqCu8U1A+GXYYZpOYMCDpqB2hyLinidfIqmhnhr2jSanMqYheCvkZWxtcjeKzKPiIGGnykwOIIfsPC/fIPlm9JiS636uNbXruUpbYjt8w5fL15wnAn0Z2MlRIExkFvtbRqegVx37B6kLxhxMFY0L5+oaidRXhVmKtCYpKSNvj3gp7A4d3jI8ug/Wlr1fmez7ftVDVTbS40bKyV1ORF4u+45Cvsk6K/vG0Z9YbkAep/SypytdL/0qaZwxixXSzmLosWtS8xSl0HP5XmoL1ivwGDYiL9BvApvd2eWWLldRtL2Zqqc1vQ9YZiS9drLs/enlhsCzraQXXPLYMd+jIf5kSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yWf7L2gQzxVkG10y4VJ/kAw1LB+1I9uUe7/qn1cW9k=;
 b=MVrKqjI4WnYfsRjbXxK/pwI/fo0UV0hpnYdZb7SHoVYRkSVG0UrznuvB07BNiiWtfy16pTOzT71kgtDTgNsgbpO7TRJWl1Djhy87UI4YDb63txaQkYTRjs8b9aY0HDZ7gQaFDmKri96ldPqLBy4CI5p/fOuk7Eje/JLY6U1saKj7aSn+ObO0c3Cbyh5Lufwq6Y1VgvyLiudBWaSQfveSzOnAvzrHxUgZDLQp2Lg1B7E3HiAPMp1O1R/9lyxbdP4BCn6d9gDB2JJEkE4Cfg7XBIOrbs1t0oJUzc+SYZ12PCvSuL5+9f8B+4hgdN/A4qihsNqj6+16QV5pZRQrfDYUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yWf7L2gQzxVkG10y4VJ/kAw1LB+1I9uUe7/qn1cW9k=;
 b=ovX/byAg0iQraa8vGDPlGZ8d9bChc2OqZn1aWR9Sa+FdNSHcDkmOphtV+uq8VJJz8ww/mnOkDlsHdMQjY/OcRJgfCsWQc0W3Ma/8JfR8R4as5xMW231q0iR0U6m2zvlKUoiFP34rcM+egvkt64bv03b+9y6Ylm9TTylIyfYne9I=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6755.eurprd04.prod.outlook.com (20.179.252.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 29 Aug 2019 02:46:19 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.023; Thu, 29 Aug 2019
 02:46:19 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] arm: xen: mm: use __GPF_DMA32 for arm64
Thread-Topic: [PATCH] arm: xen: mm: use __GPF_DMA32 for arm64
Thread-Index: AQHVNi9zmpVhxJk2Z0aPUBEkePn3c6cPOA8AgADZ48CAARk7AIAAkAzw
Date:   Thu, 29 Aug 2019 02:46:19 +0000
Message-ID: <AM0PR04MB4481C44313C450F8994AF4BC88A20@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190709083729.11135-1-peng.fan@nxp.com>
 <d70b3a5c-647c-2147-99be-4572f76e898b@arm.com>
 <AM0PR04MB4481386D2C54AEA6987E1B1588A30@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <alpine.DEB.2.21.1908281103290.25361@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.1908281103290.25361@sstabellini-ThinkPad-T480s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 596f9668-4705-49bb-9296-08d72c2b1207
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6755;
x-ms-traffictypediagnostic: AM0PR04MB6755:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6755ACAF082E66E4713A9B9C88A20@AM0PR04MB6755.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(189003)(199004)(8936002)(229853002)(256004)(8676002)(81156014)(14444005)(81166006)(33656002)(53546011)(76176011)(6506007)(26005)(7696005)(305945005)(7736002)(2906002)(186003)(102836004)(86362001)(74316002)(316002)(99286004)(66066001)(54906003)(478600001)(66556008)(76116006)(66946007)(66476007)(66446008)(6916009)(64756008)(446003)(11346002)(476003)(486006)(44832011)(6116002)(3846002)(53936002)(4326008)(25786009)(5660300002)(52536014)(6436002)(6246003)(14454004)(55016002)(71190400001)(71200400001)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6755;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M7WCWBDde4fnhsUfpj10HINnZWIgIbFH3vb/+2AcdMw0TFUHPn3Wtz4cyNfCh9eB9ePlLsWODe4Z9bGGPvVLDEFjPP16YoxRzjkI7TvOZuCOwIY/w6SElGIPoLtyJGK69eFxMSU5IHSGSBUZtSr1BdTmR/tt+RX+eZCbE1DDWABVqDbglBfvEP6Z9UjWjJoDUw5KrnJ6bQXSDNqFeA1VsYC9lhnjwr2Tf+OJpHCP4k30d/bZ924y9p9HBS8kAOx4B9YrufxSOZA5LsjutIIfEw2PyL4Oznaa5/pR6frtS1pzkz45BoX4J69xJiHSQX/GirYirEuP8svi0NCL4C/6PfOQLo2hhTYFNIcX9FepNn8htLPpjL2169XwJDVI6O/YjtRn4HH8xwoK2Hzus5LFBtcRJh3b1KGCturXxzd/VVs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596f9668-4705-49bb-9296-08d72c2b1207
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 02:46:19.3067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kGv0b5yeEGah/DAXfPnLLlVHLdM5gS5+ubmK6samYq2+clZQQD+FOMJVfY17GIX8F90v8qKmIVCTEDUQcMoRgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefano,

> Subject: RE: [PATCH] arm: xen: mm: use __GPF_DMA32 for arm64
>=20
> On Wed, 28 Aug 2019, Peng Fan wrote:
> > Hi Robin,
> >
> > > Subject: Re: [PATCH] arm: xen: mm: use __GPF_DMA32 for arm64
> > >
> > > On 09/07/2019 09:22, Peng Fan wrote:
> > > > arm64 shares some code under arch/arm/xen, including mm.c.
> > > > However ZONE_DMA is removed by commit
> > > > ad67f5a6545("arm64: replace ZONE_DMA with ZONE_DMA32").
> > > > So to ARM64, need use __GFP_DMA32.
>=20
> Hi Peng,
>=20
> Sorry for being so late in replying, this email got lost in the noise.
>=20
>=20
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >   arch/arm/xen/mm.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c index
> > > > e1d44b903dfc..a95e76d18bf9 100644
> > > > --- a/arch/arm/xen/mm.c
> > > > +++ b/arch/arm/xen/mm.c
> > > > @@ -27,7 +27,7 @@ unsigned long
> > > > xen_get_swiotlb_free_pages(unsigned
> > > > int order)
> > > >
> > > >   	for_each_memblock(memory, reg) {
> > > >   		if (reg->base < (phys_addr_t)0xffffffff) {
> > > > -			flags |=3D __GFP_DMA;
> > > > +			flags |=3D __GFP_DMA | __GFP_DMA32;
> > >
> > > Given the definition of GFP_ZONE_BAD, I'm not sure this combination
> > > of flags is strictly valid, but rather is implicitly reliant on only
> > > one of those zones ever actually existing. As such, it seems liable
> > > to blow up if the plans to add ZONE_DMA to arm64[1] go ahead.
> >
> > How about this, or do you have any suggestions?
> > diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c index
> > d33b77e9add3..f61c29a4430f 100644
> > --- a/arch/arm/xen/mm.c
> > +++ b/arch/arm/xen/mm.c
> > @@ -28,7 +28,11 @@ unsigned long xen_get_swiotlb_free_pages(unsigned
> > int order)
> >
> >         for_each_memblock(memory, reg) {
> >                 if (reg->base < (phys_addr_t)0xffffffff) {
> > +#ifdef CONFIG_ARM64
> > +                       flags |=3D __GFP_DMA32; #else
> >                         flags |=3D __GFP_DMA;
> > +#endif
> >                         break;
> >                 }
> >         }
>=20
> Yes I think this is the way to go, but we are trying not to add any #ifde=
f
> CONFIG_ARM64 under arch/arm. Maybe you could introduce a static inline
> function to set GFP_DMA:
>=20
>   static inline void xen_set_gfp_dma(gfp_t *flags)
>=20
> it could be implemented under arch/arm/include/asm/xen/page.h for arm
> and under arch/arm64/include/asm/xen/page.h for arm64 using __GFP_DMA
> for the former and __GFP_DMA32 for the latter.

Thanks for your suggestion. I'll use this in V2.

Thanks,
Peng.

