Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B58C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A62216C8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q4cp9vhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389141AbfGYC3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 22:29:12 -0400
Received: from mail-eopbgr30058.outbound.protection.outlook.com ([40.107.3.58]:44806
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388525AbfGYC3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:29:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnRRlDPchAFpljNdAiTwpJtSscF4C1qZNCSke5NVbyf00as3QKTv7v4t5Vq27cQa+pgRalqmhx/+5UdUO8vxvOVp4fHHkIY3POVP5qB9Gd0o0Ys0W+iVW0eJAapNHKN1btHEBhWRjX7GUdTAcTuAJCAuXBBHyLaDqwdtzJeA3sPmhr6bpJpIs+gIQZmMe2XtLvo8r54Q2CkpYw0ERW2Dp3JB8HxTWztu0JuOOAUDEn/zBrwBwUQ6gZJYH/PrR+rrRtwzYvmZfJviRBH7GKwQtZIc9hD/WyjyR4xt0kzsXJDk5JzFvgdFenWUOoPSElIgHM9XtQKWEonoZ2lyMYrLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDGa+OqLRAYmgnda2KStB4zwnQ2VEII9riOZw1AyXY4=;
 b=LbCvAtFbPTRgcVHatuM5dXx/AEkGh1E6YcnrpYYd+BVHfDBWUtFtBjYMios31iHKuBNTHEBKcwqA6yPYpVFclpCZtx62w4gX1hc7mMP8JFetTFXQAKd6j6oa6JJt8KRi3qkQ+muomS2+3MhuGXBgY5iYLgU3vUs9q8vGLAMHhNkA03rWRfHzEJh4/yCkHt7NvlulTzl0U/NrvFt3GpKOpCeU6c03RmuI82AdDPVPGgOsMXLGxFe7d1lfU5D5OZvfN2MuAPU7IdnSlZIaGmLzmwUtv1uQVqioo4314wnEP0skJSfCxypIE6DfSVQYQCugWgq39Ax8ACOY3pcWZmmfVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDGa+OqLRAYmgnda2KStB4zwnQ2VEII9riOZw1AyXY4=;
 b=q4cp9vhM4PwO3cZjmVCAZhlteKWvN2EGKkVD4Xtg0tMkV23iMEPiNjWb/xTgagNSuSI9XFfZzIV2LMbYbtSfLRrySUIyiKDXC6rR9Dm+RquaMKIrrcgNdnjjdPVkwz2xPicYSx1Arzp8r8XhxXw/UNZ8Q07I1rGxN/D+DX7CTmk=
Received: from DB8PR04MB6826.eurprd04.prod.outlook.com (52.133.240.82) by
 DB8PR04MB5593.eurprd04.prod.outlook.com (20.179.11.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Thu, 25 Jul 2019 02:29:07 +0000
Received: from DB8PR04MB6826.eurprd04.prod.outlook.com
 ([fe80::a5a4:22ca:7b9b:2d92]) by DB8PR04MB6826.eurprd04.prod.outlook.com
 ([fe80::a5a4:22ca:7b9b:2d92%2]) with mapi id 15.20.2094.017; Thu, 25 Jul 2019
 02:29:07 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 1/2] usb: dwc3: Add node to update cache type setting
Thread-Topic: [PATCH V2 1/2] usb: dwc3: Add node to update cache type setting
Thread-Index: AQHVOH5G67Ou1TF8sk6MaGtvp7Q7iKbaT5kAgABcbSA=
Date:   Thu, 25 Jul 2019 02:29:07 +0000
Message-ID: <DB8PR04MB6826B4479A5A67A66025E89CF1C10@DB8PR04MB6826.eurprd04.prod.outlook.com>
References: <20190712064206.48249-1-ran.wang_1@nxp.com>
 <20190724204222.GA1234@bogus>
In-Reply-To: <20190724204222.GA1234@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d520d5df-8695-4c69-9070-08d710a7de8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB5593;
x-ms-traffictypediagnostic: DB8PR04MB5593:
x-microsoft-antispam-prvs: <DB8PR04MB55932CFC83D4852D475C3124F1C10@DB8PR04MB5593.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(199004)(189003)(71200400001)(71190400001)(446003)(74316002)(53546011)(55016002)(6916009)(7736002)(305945005)(6506007)(6116002)(186003)(6246003)(15650500001)(4326008)(3846002)(229853002)(256004)(14444005)(9686003)(476003)(11346002)(486006)(316002)(8936002)(68736007)(81156014)(81166006)(52536014)(76176011)(478600001)(25786009)(54906003)(86362001)(33656002)(76116006)(5660300002)(99286004)(66476007)(66556008)(66946007)(64756008)(66446008)(2906002)(6436002)(53936002)(26005)(102836004)(8676002)(14454004)(7696005)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5593;H:DB8PR04MB6826.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5HhAJmcyV0r2CEMPbXuPOKVAzDrfoYboCI+34kCU62QThClIaCQl8CUIeL7eU22TP+yOo2e04QuEDeNLmJDcEHbjuJw/JpTOkDpz3B3vN1uzC7ceK7P8tgVf8ihRFV72eoUUJmsewPnOqFMyzbK4ZaLWYlXgf7LzyHQtXKwIoKMk4JlYeAGAkQuUByO2wm/lHlHfJvIpfY5Gsj8UXpH+d8hqUHWU7JwXSHRIyEMY3/eF81EebSs9VScXTeNq7KmuMAsJXiO89/hcsMjoQiSe/fXzMfKtXwva+a6BZ+4a4ip7YkAIzKJhA/77fdqixP52ZGjOREpTvBpkmAF/YHZGbiDKOZ67Jd8B79znXU9DtV+MP9BVib/2Sg1pAhSTFK4K0w8PICRKp4XXYJEAZMWFyh8F0USjcJ5pFa4cQKhnIA4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d520d5df-8695-4c69-9070-08d710a7de8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 02:29:07.4150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ran.wang_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5593
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thursday, July 25, 2019 04:42 Rob Herring <robh@kernel.org> wrote:
>=20
> On Fri, Jul 12, 2019 at 02:42:05PM +0800, Ran Wang wrote:
> > Some Layerscape paltforms (such as LS1088A, LS2088A, etc) encounter
> > USB detect failues when adding dma-coherent to DWC3 node. This is
> > because the HW default cache type configuration of those SoC are not
> > right, need to be updated in DTS.
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> > Change in v2:
> > 	- New file.
> >
> >  Documentation/devicetree/bindings/usb/dwc3.txt | 43
> > ++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt
> > b/Documentation/devicetree/bindings/usb/dwc3.txt
> > index 8e5265e..7bc1cef 100644
> > --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> > +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> > @@ -110,6 +110,43 @@ Optional properties:
> >   - in addition all properties from usb-xhci.txt from the current direc=
tory are
> >     supported as well
> >
> > +* Cache type nodes (optional)
> > +
> > +The Cache type node is used to tell how to configure cache type on 4
> > +different transfer types: Data Read, Desc Read, Data Write and Desc
> > +write. For each treasfer type, controller has a 4-bit register field
> > +to enable different cache type. Quoted from DWC3 data book Table 6-5
> Cache Type Bit Assignments:
> > +----------------------------------------------------------------
> > +MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
> > +----------------------------------------------------------------
> > +AHB      |Cacheable     |Bufferable   |Privilegge |Data
> > +AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable
> > +AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable
> > +AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable
> > +Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI
> > +----------------------------------------------------------------
> > +Note: The AHB, AXI3, AXI4, and PCIe busses use different names for
> > +certain signals, which have the same meaning:
> > +  Bufferable =3D Posted
> > +  Cacheable =3D Modifiable =3D Snoop (negation of No Snoop)
>=20
> This should all be implied from the SoC specific compatible strings.

Did you mean I could implement a soc driver which can be matched by compati=
ble of 'fsl,ls1088a-dwc3' which will pass known bus type to DWC3 driver? If=
 yes, how to pass?

Or I need to add a property snps,mbus_type=3D"AXI3" to DWC3 node, which wil=
l co-work with property  transfer_type-datard =3D "cacheable" to set cache =
type properly?

Thanks & Regards,
Ran
