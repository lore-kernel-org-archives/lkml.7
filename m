Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE68BC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 03:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD59206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 03:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PVa0I+65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKRD4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 22:56:13 -0500
Received: from mail-eopbgr730061.outbound.protection.outlook.com ([40.107.73.61]:1215
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbfKRD4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 22:56:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uwr0eiW6B7BtiupCkDrEQwr5DXoZUWCz8Z4a4/Hq8Cix7RVVcQJzCxi60IkZymM0zPCP2HwWb1xblwDvqkO+LwODwr/zl2H3wGPYvnkvifdIOMjvLCa6B2nLvcRVwJE1/GkjZ0jrgiLUicMylpkA+2/AgeVHBNbnn+9aqxOsQQJ/2Lwr/z/iJoEYidnzaVaHkEFS6cOtVrv6TQH08kQHfP5q/H+rZ+JONDnq7/JgRhH4MOERlGhF2biDFMJJKAzOORwr1+N0hKNo0v8eXKZewaxrrTCVFUmgVu7tSQYVsONcb4ZbhKr4xJVtlK4Pcsl21TmIHgZdQiwFBsAlmeqEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eYL9Ao6QqC25nNrr33sI+SvhtxEGKhQ3MotCVBhsvA=;
 b=Zz6u4aTyWra0LlO1cyD2JdBEHd4dXJJP2pyOpiMBn8glcL5/N13UpNTCoGznUGDA5sbUVa+LeoAYpbTNzyXg0eR2zRgwrbZkowd3jLoWZxoZCAN8jjxJtBq2wpEuMtVqFbzRp/FK8NFpwZfJPUdeL/GaTNNPaJGfRKlqIOCeNUhoFCVnI9C9+NIQ1kSwFtwAkh2vVotBD4VsMATvznen/jWjQCetzN1ex3z0c0vrR8IS0X2ccjXvain/wUnxLGgs9zZ1x09uw082KEuybk5NWsJ+rCZsK9F0NxBkQvW7yezJKV3v8P6EijS2H9bi32w+JCwlUJIgbHrJNkQafVbqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eYL9Ao6QqC25nNrr33sI+SvhtxEGKhQ3MotCVBhsvA=;
 b=PVa0I+65e52z52KAYfq/8gJ+ZvYpBaNKNhpdjYF3YP0laSY5sgkAuBYpsTuB9hFKJgQx+cvJxl9yJX4EhvFvxfL5Jczn7OpfIXzgwzmLn9/WffaU1xUeT0yZO0sgUoWlkKazfneOjh2SOIrXza6vdReK9Pw9d8RIlzQoDMjJyQo=
Received: from MN2PR02MB6029.namprd02.prod.outlook.com (52.132.174.207) by
 MN2PR02MB6687.namprd02.prod.outlook.com (52.135.50.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Mon, 18 Nov 2019 03:55:56 +0000
Received: from MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::7c98:7d3:f15a:27f]) by MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::7c98:7d3:f15a:27f%3]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 03:55:56 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Michal Simek <michals@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: RE: [PATCH v5 4/8] dt-bindings: mmc: Add optional generic properties
 for mmc
Thread-Topic: [PATCH v5 4/8] dt-bindings: mmc: Add optional generic properties
 for mmc
Thread-Index: AQHVkHqBcCBapDuL00GCzGyd3h/hfad7qj+AgAojF2CACplXgA==
Date:   Mon, 18 Nov 2019 03:55:56 +0000
Message-ID: <MN2PR02MB6029D9F42B920927DF7813EEC14D0@MN2PR02MB6029.namprd02.prod.outlook.com>
References: <1572588353-110682-1-git-send-email-manish.narani@xilinx.com>
 <1572588353-110682-5-git-send-email-manish.narani@xilinx.com>
 <20191104231427.GA7606@bogus>
 <MN2PR02MB6029D371F580123CB32BE148C1740@MN2PR02MB6029.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB6029D371F580123CB32BE148C1740@MN2PR02MB6029.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [183.83.139.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc92a5c6-cadb-4a87-2462-08d76bdb3721
x-ms-traffictypediagnostic: MN2PR02MB6687:|MN2PR02MB6687:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB6687B6E12F14DB9B21834866C14D0@MN2PR02MB6687.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39850400004)(136003)(366004)(396003)(376002)(189003)(199004)(13464003)(305945005)(8676002)(81156014)(81166006)(33656002)(8936002)(66556008)(64756008)(66446008)(66946007)(9686003)(66476007)(107886003)(55016002)(486006)(6436002)(229853002)(26005)(71190400001)(478600001)(14454004)(6506007)(446003)(76176011)(7696005)(186003)(53546011)(2906002)(476003)(11346002)(256004)(14444005)(99286004)(316002)(54906003)(71200400001)(86362001)(3846002)(6116002)(102836004)(6246003)(25786009)(7736002)(74316002)(7416002)(66066001)(5660300002)(4326008)(6916009)(76116006)(52536014)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6687;H:MN2PR02MB6029.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rOZrp0mVJmr7AF7YHnfNrC2O9Ve2tHtyaAxPlMS+RwFeAIQYu+OCEEY1FwJY9Famof+/gNizlcLoN8VBEk0AHu7RtnWQ6Vw/Spi/CJoPdFlMg6bXqWrAZjLfL9opEKQaUWGtkTTH5N/Gpg90Q75wZicXCqnvcMwTZk7u/gXWzeSvYfKPvxx8E2M/1NGZer76UG2nc6SnRN5sPySvXIRCxQ3AkuWj8Bvu4BUJpOiYRDomhyPpWw8KY/rqeOeH10v0nQs3mCKhy6peiYDBocua3g4Hc6ERGSs7G/OJTPb0evbk0KUulu9aQ1z09Sup64cAhTIQVenfefhZ3if94fOg6AgmVLVSVUqM9WqQphYyDBD8Ta99Hm1lQ/ZVxzTFNHb2RKFFiKhXKkmyblr5bStEEa1AYLNXZMLkal7sEvhzTeMf7nY4LwcAx9tGZwS8+/Lb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc92a5c6-cadb-4a87-2462-08d76bdb3721
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 03:55:56.1394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHLkQiB/6Omxrs/SOYjfYtWaBt5NOwAdj1VP7xBvqPuYXFMlVIjAnqoC4guvtRA9qjaI8CsJX9GGUjahXxLfyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Manish Narani
> Sent: Monday, November 11, 2019 3:38 PM
> To: Rob Herring <robh@kernel.org>
> Cc: ulf.hansson@linaro.org; mark.rutland@arm.com;
> adrian.hunter@intel.com; Michal Simek <michals@xilinx.com>; Jolly Shah
> <JOLLYS@xilinx.com>; Nava kishore Manne <navam@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; linux-mmc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; git <git@xilinx.com>
> Subject: RE: [PATCH v5 4/8] dt-bindings: mmc: Add optional generic proper=
ties
> for mmc
>=20
> Hi Rob,
>=20
>=20
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Tuesday, November 5, 2019 4:44 AM
> > To: Manish Narani <MNARANI@xilinx.com>
> > Cc: ulf.hansson@linaro.org; mark.rutland@arm.com;
> > adrian.hunter@intel.com; Michal Simek <michals@xilinx.com>; Jolly Shah
> > <JOLLYS@xilinx.com>; Nava kishore Manne <navam@xilinx.com>; Rajan
> Vaja
> > <RAJANV@xilinx.com>; linux-mmc@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; git <git@xilinx.com>
> > Subject: Re: [PATCH v5 4/8] dt-bindings: mmc: Add optional generic
> > properties for mmc
> >
> > On Fri, Nov 01, 2019 at 11:35:49AM +0530, Manish Narani wrote:
> > > Add optional properties for mmc hosts which are used to set clk delay=
s
> > > for different speed modes in the controller.
> > >
> > > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > > ---
> > >  .../bindings/mmc/mmc-controller.yaml          | 92 +++++++++++++++++=
++
> > >  1 file changed, 92 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/mmc-
> controller.yaml
> > b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > > index 080754e0ef35..87a83d966851 100644
> > > --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > > +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > > @@ -212,6 +212,98 @@ properties:
> > >      description:
> > >        eMMC HS400 enhanced strobe mode is supported
> > >
> > > +  # Below mentioned are the clock (phase) delays which are to be
> > configured
> > > +  # in the controller while switching to particular speed mode. The =
range
> > > +  # of values are 0 to 359 degrees.
> > > +
> > > +  clk-phase-legacy:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for Legacy Mode.
> > > +
> > > +  clk-phase-mmc-hs:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair degrees for MMC HS.
> > > +
> > > +  clk-phase-sd-hs:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for SD HS.
> > > +
> > > +  clk-phase-uhs-sdr12:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for SDR12.
> > > +
> > > +  clk-phase-uhs-sdr25:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for SDR25.
> > > +
> > > +  clk-phase-uhs-sdr50:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for SDR50.
> > > +
> > > +  clk-phase-uhs-sdr104:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for SDR104.
> > > +
> > > +  clk-phase-uhs-ddr50:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for SD DDR50.
> > > +
> > > +  clk-phase-mmc-ddr52:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for MMC DDR52.
> > > +
> > > +  clk-phase-mmc-hs200:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for MMC HS200.
> > > +
> > > +  clk-phase-mmc-hs400:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for MMC HS400.
> >
> > This can be condensed into:
> >
> > patternProperties:
> >
> > "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-
> > (sdr(12|25|50|104)|ddr50))$":
> >
> > Or if you want to divide them between SD and MMC ones, that would be
> > fine for me.
>=20
> Below change should work? Please review.
>=20
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -333,6 +333,16 @@ patternProperties:
>      required:
>        - reg
>=20
> +  "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-
> (sdr(12|25|50|104)|ddr50))$":
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Set the clock (phase) delays which are to be configured in the
> +      controller while switching to particular speed mode. These values
> +      are in pair of degrees.
> +
>  dependencies:
>    cd-debounce-delay-ms: [ cd-gpios ]
>    fixed-emmc-driver-type: [ non-removable ]
> @@ -351,6 +361,7 @@ examples:
>          keep-power-in-suspend;
>          wakeup-source;
>          mmc-pwrseq =3D <&sdhci0_pwrseq>;
> +        clk-phase-sd-hs =3D <63>, <72>;
>      };
>=20
>    - |


Any comment on above change?

Thanks,
Manish
