Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1508EC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D131C25633
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DdGzMhx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfE3JIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 05:08:42 -0400
Received: from mail-eopbgr10087.outbound.protection.outlook.com ([40.107.1.87]:21457
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726442AbfE3JIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ml4/Tyy2EwqtQaAZNjq82bPnQb2EkJyukUMl263N6pE=;
 b=DdGzMhx1gIEjZMhlE/kW11tbkml8NoCrdxGlhX7wD36Nu7iyHynYS4dIpWL5cr9S3HkD8gmgtlvN6w2ODJblhyPM90DWxh0O06a2eVGLzvCPj1/rDm+ohe7Lp6qN8gE585lAVkAfnFy21h2ETuVplQKh5XeKx+AwG9PaD6hiyy8=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.44.16) by
 AM5PR0402MB2898.eurprd04.prod.outlook.com (10.175.42.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.22; Thu, 30 May 2019 09:08:36 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::a1bf:17d:a52:3824]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::a1bf:17d:a52:3824%4]) with mapi id 15.20.1943.016; Thu, 30 May 2019
 09:08:36 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: Enable the USB snooping
Thread-Topic: [PATCH] usb: dwc3: Enable the USB snooping
Thread-Index: AQHTXdpMV/QBUrO8J0eNmcCmR0ATg6MVIlkAgAAD6zCAABVWgINueaJwgAAMz4CAAwpoAA==
Date:   Thu, 30 May 2019 09:08:36 +0000
Message-ID: <AM5PR0402MB2865F3735D808E1BC9F67968F1180@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20171115060459.45375-1-ran.wang_1@nxp.com>
 <87ineb9b5v.fsf@linux.intel.com>
 <VI1PR04MB1504776EF3D4D8C374F0C069F1290@VI1PR04MB1504.eurprd04.prod.outlook.com>
 <87shdfet90.fsf@linux.intel.com>
 <AM5PR0402MB28654EBE2D431CC2F8061CF8F11E0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <87k1eaanjw.fsf@linux.intel.com>
In-Reply-To: <87k1eaanjw.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3654c925-77c6-42ca-3e61-08d6e4de6636
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM5PR0402MB2898;
x-ms-traffictypediagnostic: AM5PR0402MB2898:
x-microsoft-antispam-prvs: <AM5PR0402MB28986F0C518DCE1DC0C7CA60F1180@AM5PR0402MB2898.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(396003)(376002)(136003)(199004)(189003)(11346002)(446003)(86362001)(76176011)(66946007)(66066001)(6436002)(486006)(102836004)(6246003)(76116006)(3846002)(71200400001)(229853002)(6116002)(6506007)(478600001)(6916009)(53546011)(14454004)(55016002)(71190400001)(81156014)(81166006)(7736002)(25786009)(476003)(5660300002)(256004)(14444005)(74316002)(4326008)(54906003)(68736007)(66476007)(64756008)(305945005)(73956011)(66556008)(186003)(53936002)(66446008)(26005)(7696005)(52536014)(8936002)(9686003)(2906002)(316002)(99286004)(8676002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2898;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eR7rGfmlB+wLICgzsDZhUzZ+ofQsel5yBmAKjilxU4tC5FZ5e0yH7WbLK0mB0roadQ6sldOERXa7beSiP+DP2vtQmtWCBR/C9y1S6PGDbkuNX5eCW+s/cs/lc8DX89VGiAj9WOmmxNsj6ld90X4MYWEV3Wr1qOxGVctwlT6uHRvyoZyanFxg3wLgQ9u/DX/bc3LgknZ0u0aUCiF6SvtAsRn3XjEdTTmcngj2XdF9+Exp+4rjTq0fQ0/EtKAf5kv1NX7+KGt+2ybUQ2geIykISlCHVaj7kCqq89X+hRWmK5R5zsH118csZ9U/lUtWMb1yLDf1KfnYWQGh4UAOuNgra4a8WlcyxEHIaKC3FDLVjeURWl2Jswx2bgLCcDbrHHGnewM9VBA/PH1P1HJX9EDKJ9BcprJfh4H5wgKd/XacqcE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3654c925-77c6-42ca-3e61-08d6e4de6636
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 09:08:36.7066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ran.wang_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2898
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On Tuesday, May 28, 2019 18:20, Felipe Balbi wrote:
>=20
<snip>
> >> >> >  /* Global Debug Queue/FIFO Space Available Register */
> >> >> >  #define DWC3_GDBGFIFOSPACE_NUM(n)	((n) & 0x1f)
> >> >> >  #define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
> >> >> > @@ -859,6 +867,7 @@ struct dwc3_scratchpad_array {
> >> >> >   * 	3	- Reserved
> >> >> >   * @imod_interval: set the interrupt moderation interval in 250n=
s
> >> >> >   *                 increments or 0 to disable.
> >> >> > + * @dma_coherent: set if enable dma-coherent.
> >> >>
> >> >> you're not enabling dma coherency, you're enabling cache snooping.
> >> >> And this property should describe that. Also, keep in mind that
> >> >> different devices may want different cache types for each of those
> >> >> fields, so your property would have to be a lot more complex. Somet=
hing
> like:
> >> >>
> >> >> 	snps,cache-type =3D <foobar "cacheable">, <baz "cacheable">, ...
> >> >>
> >> >> Then driver would have to parse this properly to setup GSBUSCFG0.
> >
> > According to the DesignWare Cores SuperSpeed USB 3.0 Controller
> > Databook (v2.60a), it has described Type Bit Assignments for all suppor=
ted
> master bus type:
> > AHB, AXI3, AXI4 and Native. I found the bit definition are different am=
ong
> them.
> > So, for the example you gave above, feel a little bit confused.
> > Did you mean:
> >     snps,cache-type =3D <DATA_RD  "write allocate">, <DESC_RD
> > "cacheable">, <DATA_WR  "bufferable">, <DESC_WR  "read allocate">
>=20
> yeah, something like that.

I think DATA_RD  should be a macro, right? So, where I can put its define?
Create a dwc3.h in include/dt-bindings/usb/ ?

Another question about this remain open is: DWC3 data book's Table 6-5
Cache Type Bit Assignments show that bits definition will differ per
MBUS_TYPEs as below:
----------------------------------------------------------------           =
     =20
 MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]                 =
      =20
 ----------------------------------------------------------------          =
      =20
 AHB      |Cacheable     |Bufferable   |Privilegge |Data                   =
      =20
 AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable             =
      =20
 AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable             =
      =20
 AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable             =
      =20
 Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI            =
      =20
 ----------------------------------------------------------------          =
      =20
 Note: The AHB, AXI3, AXI4, and PCIe busses use different names for certain=
      =20
 signals, which have the same meaning:                                     =
      =20
   Bufferable =3D Posted                                                   =
        =20
   Cacheable =3D Modifiable =3D Snoop (negation of No Snoop)
=20
For Layerscape SoCs, MBUS_TYPE is AXI3. So I am not sure how to use
snps,cache-type =3D <DATA_RD  "write allocate">, to cover all MBUS_TYPE?
(you can notice that AHB and AXI3's cacheable are on different bit)
Or I just need to handle AXI3 case?

Regards,
Ran
