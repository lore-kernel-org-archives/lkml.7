Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7C1C28CC5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 02:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213B6279DD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 02:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aSAbJwwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfFCCdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 22:33:23 -0400
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:46993
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfFCCdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 22:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3c3JmRRSQ8pq+B3flUTKYDUe2uH9pKiCbftKqmA1Io=;
 b=aSAbJwwgCBsdkVpsZ30Q8dsiGKKkcuiO8qrNKDHfqkVmy+yZslUFVRFYPkRnfVZ8UdhEx9gJ6hOnJ7Y5nLobyITj1RMa/+LY0vIF2fUpGHxp9X8bX7rxHnbIxYoJn88BLsMZ8TZYRf++5KqULx2B1NgS6Ab5IvzghAt80g/wwDM=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.44.16) by
 AM5PR0402MB2740.eurprd04.prod.outlook.com (10.175.42.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Mon, 3 Jun 2019 02:33:15 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::a1bf:17d:a52:3824]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::a1bf:17d:a52:3824%4]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 02:33:15 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH] usb: dwc3: Enable the USB snooping
Thread-Topic: [PATCH] usb: dwc3: Enable the USB snooping
Thread-Index: AQHTXdpMV/QBUrO8J0eNmcCmR0ATg6MVIlkAgAAD6zCAABVWgINueaJwgAAMz4CAAwpoAIAF38Dw
Date:   Mon, 3 Jun 2019 02:33:15 +0000
Message-ID: <AM5PR0402MB2865D0F0E2B4F65C86D051F8F1140@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20171115060459.45375-1-ran.wang_1@nxp.com>
 <87ineb9b5v.fsf@linux.intel.com>
 <VI1PR04MB1504776EF3D4D8C374F0C069F1290@VI1PR04MB1504.eurprd04.prod.outlook.com>
 <87shdfet90.fsf@linux.intel.com>
 <AM5PR0402MB28654EBE2D431CC2F8061CF8F11E0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <87k1eaanjw.fsf@linux.intel.com>
 <AM5PR0402MB2865F3735D808E1BC9F67968F1180@AM5PR0402MB2865.eurprd04.prod.outlook.com>
In-Reply-To: <AM5PR0402MB2865F3735D808E1BC9F67968F1180@AM5PR0402MB2865.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f900d15f-51af-4cbf-6bb0-08d6e7cbd514
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM5PR0402MB2740;
x-ms-traffictypediagnostic: AM5PR0402MB2740:
x-microsoft-antispam-prvs: <AM5PR0402MB27408496538B8E18AE5B735AF1140@AM5PR0402MB2740.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39860400002)(346002)(189003)(199004)(504964003)(5660300002)(26005)(54906003)(66946007)(102836004)(66476007)(76116006)(73956011)(2906002)(6506007)(8676002)(6916009)(478600001)(25786009)(6436002)(33656002)(53546011)(446003)(52536014)(476003)(6116002)(3846002)(64756008)(6246003)(68736007)(99286004)(86362001)(66446008)(66556008)(486006)(11346002)(186003)(8936002)(14444005)(256004)(229853002)(7736002)(305945005)(53936002)(74316002)(14454004)(316002)(66066001)(76176011)(7696005)(55016002)(71190400001)(81156014)(71200400001)(9686003)(81166006)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2740;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jumJUU2z1JIF0GHB/HPJDh7KQ1Fedn7krtlQ8ynwwfDFDfiS9fs+a2JaO7KCPLLOXEqFHKHpT14CG7YwwgFS8ZJNadH5iyrzkRleyVNgUJ/2+AAkVNNh7ozz5Ds9CfImgYrs5RYVl9VRSt8EjZS6WDC0+E7t8H1hd7YoQ5+fyOs3i43cNLOugu+n5UwzD1h/kjix1V3wlljyXuns63wgGfDB2IC3hr9XsPYsjx+szlE3GovAQATHDtOIYqxa65/LFGQdTCY84A7kLca4JQeW1ve8pkQ+6RI+eCYWSO+IhWFMDlcaEsIi0OH7FS4VFO9l6qhHdhqJIvZvulbYHRHaPW57fGXZk9wYaVJPFagT4Lf2o2+lsjpA+lURRnBhiTyusFPtSLfx+sBFtuaEAR05KMpBqaoOIG2euXZsGA+kwuc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f900d15f-51af-4cbf-6bb0-08d6e7cbd514
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 02:33:15.7665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ran.wang_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2740
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On Thursday, May 30, 2019 17:09, Ran Wang wrote:
>=20
> <snip>
> > >> >> >  /* Global Debug Queue/FIFO Space Available Register */
> > >> >> >  #define DWC3_GDBGFIFOSPACE_NUM(n)	((n) & 0x1f)
> > >> >> >  #define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
> > >> >> > @@ -859,6 +867,7 @@ struct dwc3_scratchpad_array {
> > >> >> >   * 	3	- Reserved
> > >> >> >   * @imod_interval: set the interrupt moderation interval in 25=
0ns
> > >> >> >   *                 increments or 0 to disable.
> > >> >> > + * @dma_coherent: set if enable dma-coherent.
> > >> >>
> > >> >> you're not enabling dma coherency, you're enabling cache snooping=
.
> > >> >> And this property should describe that. Also, keep in mind that
> > >> >> different devices may want different cache types for each of
> > >> >> those fields, so your property would have to be a lot more
> > >> >> complex. Something
> > like:
> > >> >>
> > >> >> 	snps,cache-type =3D <foobar "cacheable">, <baz "cacheable">, ...
> > >> >>
> > >> >> Then driver would have to parse this properly to setup GSBUSCFG0.
> > >
> > > According to the DesignWare Cores SuperSpeed USB 3.0 Controller
> > > Databook (v2.60a), it has described Type Bit Assignments for all
> > > supported
> > master bus type:
> > > AHB, AXI3, AXI4 and Native. I found the bit definition are different
> > > among
> > them.
> > > So, for the example you gave above, feel a little bit confused.
> > > Did you mean:
> > >     snps,cache-type =3D <DATA_RD  "write allocate">, <DESC_RD
> > > "cacheable">, <DATA_WR  "bufferable">, <DESC_WR  "read allocate">
> >
> > yeah, something like that.
>=20
> I think DATA_RD  should be a macro, right? So, where I can put its define=
?
> Create a dwc3.h in include/dt-bindings/usb/ ?

Could you please give me some advice here? I'd like to prepare next version=
 patch after
getting this settled.

> Another question about this remain open is: DWC3 data book's Table 6-5 Ca=
che
> Type Bit Assignments show that bits definition will differ per MBUS_TYPEs=
 as
> below:
> ----------------------------------------------------------------
>  MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
>  ----------------------------------------------------------------
>  AHB      |Cacheable     |Bufferable   |Privilegge |Data
>  AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable
>  AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable
>  AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable
>  Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI
>  ----------------------------------------------------------------
>  Note: The AHB, AXI3, AXI4, and PCIe busses use different names for certa=
in
>  signals, which have the same meaning:
>    Bufferable =3D Posted
>    Cacheable =3D Modifiable =3D Snoop (negation of No Snoop)
>=20
> For Layerscape SoCs, MBUS_TYPE is AXI3. So I am not sure how to use
> snps,cache-type =3D <DATA_RD  "write allocate">, to cover all MBUS_TYPE?
> (you can notice that AHB and AXI3's cacheable are on different bit) Or I =
just need
> to handle AXI3 case?

Also on this open. Thank you in advance.

Regards,
Ran
