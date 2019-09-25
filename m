Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2DDC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 03:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34E82075D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 03:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ageJebil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411454AbfIYDNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 23:13:52 -0400
Received: from mail-eopbgr00057.outbound.protection.outlook.com ([40.107.0.57]:63367
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391325AbfIYDNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 23:13:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZt/p+meZcs9bTqCAS+LVS2t8lUQVOjQxOAicCpo28CC6hFP/tNbIkCSYjKgoUlc5Xa/WSV2tUFfBQDJpjpeAI42dt4FfIIWWo0ZgCARPYOTzMfmHBfUSKuKJnEsOkg87cElJLnqQHg38SNfgLlmGHjHcimCNJDGqXIl4A+cRPdbNg3BUcOaGrThlJp32CzYEziQyhWbdJCFkRafOgcBuAhXhdIce/xHfFOm8Tvw9KTfjO5qxLTlK0+FiuxfSHxTGFilrCN/THXzq2aT5vV0i0FWaj28+FMIMBeEai5VFchjrookY4dn6oZF0Myxee3XFu6W41kKZ3QPviM16Hbp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gPHhrxSS5RyrbR7T8Oh9S5esSP6LfVKH3fYxdNWa/I=;
 b=Qu98TRwRabPNHMh+rwU0oJV1TAtEfNaGdGQqVgBV44Qsp8OhrGc1LVKI3Svi4IbtTl7rf6yx4xOtDsSgAARH0kaTiQGYAnrGw5QQOe4XzVs1tcBi6nT11m3MDHBdjJZtJgQmh7ZrrNz24WGVPFcRYdN8mKx0g5p9Qqyv74Bnu01HQNRIGeX/splCfhsAAAYKZymiNS2Mv9wsSyq69LJP2pu+I17m8rOfWk40uSB9D1CuxXHBwbWpZIV2uOC6xHoBPbgw3FBLQYE+QYTBEZ2weBfDwhwoL2LOqsRjPyRAo/5TY/E/cYiCZcSo0oTzdIxI4ln3UmMTJokkGXaGFAT8MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gPHhrxSS5RyrbR7T8Oh9S5esSP6LfVKH3fYxdNWa/I=;
 b=ageJebilx9+uO8ZDHRp4WpElodreLQWZebpAqG9yTio1cqn+QJ4EDWs5ayFNK53H9QvX+fXrwR4c/w8TbsgAscaykz3eT5rp9b6vBxsJrWLBgVqvmokHlsGAs/QIE7vGmT8WpEdPunwAZJBm09lna+tVES3pPSNkDJEl9G+kC6E=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB4713.eurprd04.prod.outlook.com (20.176.233.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 03:13:08 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::4427:96f2:f651:6dfa]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::4427:96f2:f651:6dfa%5]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 03:13:08 +0000
From:   Biwen Li <biwen.li@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Ran Wang <ran.wang_1@nxp.com>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [v3,3/3] Documentation: dt: binding: fsl: Add
 'fsl,ippdexpcr-alt-addr' property
Thread-Topic: [v3,3/3] Documentation: dt: binding: fsl: Add
 'fsl,ippdexpcr-alt-addr' property
Thread-Index: AQHVcoOnab7d5ysBNkWsXmY0PrfSuKc6/L+AgAC3JZA=
Date:   Wed, 25 Sep 2019 03:13:07 +0000
Message-ID: <DB7PR04MB449034C4BBAA89685A2130F78F870@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <20190924024548.4356-1-biwen.li@nxp.com>
 <20190924024548.4356-3-biwen.li@nxp.com>
 <AM0PR04MB667690EE76D327D0FC09F7818F840@AM0PR04MB6676.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB667690EE76D327D0FC09F7818F840@AM0PR04MB6676.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biwen.li@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 382b4caf-c68b-46f1-f8a8-08d741664a10
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR04MB4713;
x-ms-traffictypediagnostic: DB7PR04MB4713:|DB7PR04MB4713:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB471346E0B8B912FAA0DDB0A48F870@DB7PR04MB4713.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(9686003)(55016002)(6436002)(33656002)(14454004)(229853002)(99286004)(71200400001)(71190400001)(76176011)(256004)(102836004)(7696005)(6506007)(6116002)(5660300002)(3846002)(64756008)(66446008)(14444005)(66556008)(66946007)(66476007)(2906002)(76116006)(52536014)(26005)(316002)(54906003)(110136005)(486006)(25786009)(2501003)(478600001)(44832011)(476003)(186003)(11346002)(446003)(6636002)(66066001)(8676002)(4326008)(81166006)(86362001)(81156014)(8936002)(6246003)(305945005)(74316002)(7736002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4713;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UGiv/bNKp5XgxrqM7wAW4gqocxz2dt3Af46/b2DN0ctneUVjCpaioQcF6pyZ3x8vJBW6hT7icUvFXSExiVPeQctZjeSJrzZjGN6kN9aF2WgzNk0qzwER5boKx4x5xkxuXTbQrw2PqK2Ubv4sOgaLMUBCQc2Eaqom53ogmpKAxSGXdkVd/I0nP1Tgcq5Yf9XNzW3LRAlA8Dbg1m5WdyFHM6w1OaSyIO1Zxbp4aq1cjFTduH/9o0sKBJsDbuGVNdWBMHcCvzsh//Pb8XYbEPuY7a8rj1c0+OK5JKVpryOJ4dAVQRUQ59B+nUUq2sBdOI7y8X3YUuHijTn9mrfCGj0KVfyCKjx1un5kWQzQVvFmSE6vh11uGql7oQ1LN+MnU51TfL1Dt1umL9I1x8gpSFmo7zsXXKStlcpMd6SYkn9I/gM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382b4caf-c68b-46f1-f8a8-08d741664a10
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 03:13:07.7962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUYo23gCzHkhcFC+g3kwNSqUITfR5n0ZRynSq2s6Qd+K1q4sYJQURPy8FIqfFtnb9BbBcD7aNV/2hKQ6N63SHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4713
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > The 'fsl,ippdexpcr-alt-addr' property is used to handle an errata
> > A-008646 on LS1021A
> >
> > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > ---
> > Change in v3:
> > 	- rename property name
> > 	  fsl,rcpm-scfg -> fsl,ippdexpcr-alt-addr
> >
> > Change in v2:
> > 	- update desc of the property 'fsl,rcpm-scfg'
> >
> >  Documentation/devicetree/bindings/soc/fsl/rcpm.txt | 14
> > ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > index 5a33619d881d..157dcf6da17c 100644
> > --- a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > +++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > @@ -34,6 +34,11 @@ Chassis Version		Example Chips
> >  Optional properties:
> >   - little-endian : RCPM register block is Little Endian. Without it RC=
PM
> >     will be Big Endian (default case).
> > + - fsl,ippdexpcr-alt-addr : Must add the property for SoC LS1021A,
>=20
> You probably should mention this is related to a hardware issue on LS1021=
a
> and only needed on LS1021a.
Okay, got it, thanks, I will add this in v4.
>=20
> > +   Must include n + 1 entries (n =3D #fsl,rcpm-wakeup-cells, such as:
> > +   #fsl,rcpm-wakeup-cells equal to 2, then must include 2 + 1 entries)=
.
>=20
> #fsl,rcpm-wakeup-cells is the number of IPPDEXPCR registers on an SoC.
> However you are defining an offset to scfg registers here.  Why these two
> are related?  The length here should actually be related to the #address-=
cells
> of the soc/.  But since this is only needed for LS1021, you can just make=
 it 3.
I need set the value of IPPDEXPCR resgiters from ftm_alarm0 device node(fsl=
,rcpm-wakeup =3D <&rcpm 0x0 0x20000000>;
0x0 is a value for IPPDEXPCR0, 0x20000000 is a value for IPPDEXPCR1).
But because of the hardware issue on LS1021A, I need store the value of IPP=
DEXPCR registers
to an alt address. So I defining an offset to scfg registers, then RCPM dri=
ver get an abosolute address from offset,
 RCPM driver write the value of IPPDEXPCR registers to these abosolute addr=
esses(backup the value of IPPDEXPCR registers).
>=20
> > +   The first entry must be a link to the SCFG device node.
> > +   The non-first entry must be offset of registers of SCFG.
> >
> >  Example:
> >  The RCPM node for T4240:
> > @@ -43,6 +48,15 @@ The RCPM node for T4240:
> >  		#fsl,rcpm-wakeup-cells =3D <2>;
> >  	};
> >
> > +The RCPM node for LS1021A:
> > +	rcpm: rcpm@1ee2140 {
> > +		compatible =3D "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1+";
> > +		reg =3D <0x0 0x1ee2140 0x0 0x8>;
> > +		#fsl,rcpm-wakeup-cells =3D <2>;
> > +		fsl,ippdexpcr-alt-addr =3D <&scfg 0x0 0x51c>; /*
> > SCFG_SPARECR8 */
> > +	};
> > +
> > +
> >  * Freescale RCPM Wakeup Source Device Tree Bindings
> >  -------------------------------------------
> >  Required fsl,rcpm-wakeup property should be added to a device node if
> > the device
> > --
> > 2.17.1

