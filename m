Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14593C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9FB20716
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ndr5reQv";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="JHincInR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLTIFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 03:05:14 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:63984 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725941AbfLTIFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 03:05:14 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBK7xeQK027368;
        Fri, 20 Dec 2019 00:05:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=OUff02j2r31gNZcDLaHfXDojAzOxysBMfhBt7dA4C5k=;
 b=ndr5reQvFCCDFJPqJbJIbuoFJ/mOxrMV3HzFhxdn0Ei2+ZUrLYFwOLTiaciANuu2Dre6
 6iCPOKGVNERWIRZsCn81yAp9SPe44tp9tLj/5qZnrkvBUBypoRzNG3RQ/a26ikmfJwSr
 zyCE/DLn/ryLYtEXvkT7ktvNAqLeqCKN4g+poVJoip+oiTanttE6YMchhoEi6gzeFJ7T
 ujX4+IvOEucKCHIeS01AxEAunwHc72Iln2UG05kBnWZ55LAAINwKcQC5LQmPXkUfeXzN
 sXh+1+D5wNDEoFI68fRcYqh0cRSatJZz4B7JkSZFwxtxG4KjjT2uy0LuokhMOk8UPrhT zA== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2056.outbound.protection.outlook.com [104.47.45.56])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wyr9p6rpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Dec 2019 00:05:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhzsmQ2iuaLl89tBa5rABZ1HibklCRKL/eN58oXWc074LnrH/kiuPWTzcIlC5IsyYQIajYJugO82SDbdgrtTK0ScwYDIcp3jGwj2JkZERK1V3zU3MowzEcFkFPE3aZkUnE00pDvONHKkQMxR2AfNy5QUN4gYfrQHHZTaWoR1olIV5Td6hqOWlPe2JKVJ4/OxmjLKw5OpshXSYz8rPqoVlAlO6f/fCk2gBj00DEeP+oyVMMWYKP+u+fAP6Hp177TwjHQyUe5nHmIcHH4mJJXk4NYdXEtl3SzbVEXBNwTUt25WPkc1BK0GECC9gufX2yed7kX3UF6SHAHYvzS7OSmCzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUff02j2r31gNZcDLaHfXDojAzOxysBMfhBt7dA4C5k=;
 b=QGQIXUBEXIu4oJFLE0l+eYq/rI08IeZKYhYUgwCnjk4BloxVJPdlT1sbMW1bPkKwaiL62JieTw84sKBXwACnmBRlTPVUfLBocG4ljagLB35XTija/ob2zkfzXKNupvepTbaVN4OgH4ZCY6cYeowqFEYT3m7PkoRlF5oB7ubOvJfDMD6ola8VI4RIAUY0qU7IIjPfkdCN8zRB9CUdWyRfSkQ1XtAeYTHNfXveLEAC6kRoBmb0NOoKQZxIZ9EkPi2WGGATjtlmlQpf7Yz3C7pp3gRynO61QTGWJyVTSNn6q3k9nvWM/S833lFEbIGOsHLY+LPo4UkR3fiVZOc8VfHBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUff02j2r31gNZcDLaHfXDojAzOxysBMfhBt7dA4C5k=;
 b=JHincInRfjs6nQTECy27v6p6Tpo+TVPJSUKHV6ynaSfa8Rni3+PxMfzUjazTszhobhOqYN2hngJ1D3+Db5ZRTa+rzx41WY/fFhAkvQvIGigzbMJgDTgZNZM9xDqL3Z2lh3LzoaMOQ6hSVe1dZ0q8y8gYUKnIJKxgvqFkwj5eISE=
Received: from BYAPR07MB5110.namprd07.prod.outlook.com (20.176.255.14) by
 BYAPR07MB6134.namprd07.prod.outlook.com (20.179.88.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Fri, 20 Dec 2019 08:04:58 +0000
Received: from BYAPR07MB5110.namprd07.prod.outlook.com
 ([fe80::e4c9:23b3:78c1:acdd]) by BYAPR07MB5110.namprd07.prod.outlook.com
 ([fe80::e4c9:23b3:78c1:acdd%6]) with mapi id 15.20.2559.012; Fri, 20 Dec 2019
 08:04:58 +0000
From:   Yuti Suresh Amonkar <yamonkar@cadence.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jsarha@ti.com" <jsarha@ti.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Subject: RE: [RESEND PATCH v1 02/15] dt-bindings:phy: Convert Cadence MHDP PHY
 bindings to YAML.
Thread-Topic: [RESEND PATCH v1 02/15] dt-bindings:phy: Convert Cadence MHDP
 PHY bindings to YAML.
Thread-Index: AQHVsCQ8Q9KmNWZjKkyps5tDo7aPsqfCAUsAgACikQA=
Date:   Fri, 20 Dec 2019 08:04:58 +0000
Message-ID: <BYAPR07MB511064CAE0E9B64564261643D22D0@BYAPR07MB5110.namprd07.prod.outlook.com>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
 <1576069760-11473-3-git-send-email-yamonkar@cadence.com>
 <20191219211050.GA1841@bogus>
In-Reply-To: <20191219211050.GA1841@bogus>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [14.143.9.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 553d7f9a-0c3d-4301-6ed7-08d785234ea8
x-ms-traffictypediagnostic: BYAPR07MB6134:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB61340B0DB318F4D99C231CC6D22D0@BYAPR07MB6134.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(36092001)(13464003)(478600001)(19627235002)(7696005)(52536014)(5660300002)(71200400001)(107886003)(6916009)(4326008)(86362001)(8936002)(316002)(9686003)(8676002)(81156014)(81166006)(54906003)(55016002)(33656002)(6506007)(76116006)(53546011)(2906002)(26005)(186003)(55236004)(66946007)(64756008)(66556008)(66476007)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB6134;H:BYAPR07MB5110.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qe8/WgEWMNVUwGGTHmWFqKmi4vtL9G6+LOAiflXN96vS3GUtBy5AbOutRUpBfP6pTpHkVh119iQ0WL321ZdeWxGHJAK0g/g5PJ1DhqgUrIJMUfHU8kUuAH7g5iOzY9Y2RUhbazgHm856zn2u2O2iFjr2jPUYo2eqL2nyR5ZUnGXLunkkcyS9MuOnkm3C6Jg63T+illt6aVyjFkPiFL+vzTh9Lxz5v6jpDq0to9Ug3AmsXioE9SCt4uvp4ep9mcayA8ZjrJG/vhTUe63btBnI0hStLsiT6lg6zoTRDdwJXaOWhVeAJH28uJ1YQgrc77i06D9OyBTM4/eY3T6FjYWkQg93DbOIKoia5gIJMAqdHbpi+PTV/jTm9EwUEcrlU5s2rJ0LcXFkSknXwLH4qanedYM7BgiQE4ZIhCpldOgOcxenSMu7YIMI3nqMSrnHLIOUiYgAOhkn6GbDVsym6U+CauLMk6tqM0/e+zxYASS+2Y4sfq64+cfTnE5tkW9H6qSUvz6x8HMs3FAjvsJa+bjIQ9x032wqSxKMiDsILxnmPuqOqE5hHZ0oxQE/Fh0pejE0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553d7f9a-0c3d-4301-6ed7-08d785234ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 08:04:58.4496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X86bmRxp5qeE6Nx49q6OmWaK5NVuOMfOeqavNJe7LPHx/4PAqOHJMU6FtnMAwP0lzcVWWurYpqCe++EKoomiKEXGb1eaQhIgicdrfSXS66o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6134
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_08:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912200063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, December 20, 2019 2:41
> To: Yuti Suresh Amonkar <yamonkar@cadence.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> kishon@ti.com; mark.rutland@arm.com; jsarha@ti.com;
> tomi.valkeinen@ti.com; praneeth@ti.com; Milind Parab
> <mparab@cadence.com>; Swapnil Kashinath Jakhade
> <sjakhade@cadence.com>
> Subject: Re: [RESEND PATCH v1 02/15] dt-bindings:phy: Convert Cadence
> MHDP PHY bindings to YAML.
>=20
> EXTERNAL MAIL
>=20
>=20
> On Wed, Dec 11, 2019 at 02:09:07PM +0100, Yuti Amonkar wrote:
>=20
> > - Convert the MHDP PHY devicetree bindings to yaml schemas.
>=20
> > - Rename DP PHY to have generic Torrent PHY nomrnclature.
>=20
> > - Rename compatible string from "cdns,dp-phy" to "cdns,torrent-phy".
>=20
>=20
>=20
> You can't just change compatible strings. It's an ABI. Unless you know
>=20
> for sure there are no users that would care.
>=20

The driver has never been functional and therefore not used in any active u=
se cases. We will update this in the commit description=20
of next patch series.

>=20
>=20
> >
>=20
> > Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
>=20
> > ---
>=20
> >  .../devicetree/bindings/phy/phy-cadence-dp.txt     | 30 ------------
>=20
> >  .../bindings/phy/phy-cadence-torrent.yaml          | 57
> ++++++++++++++++++++++
>=20
> >  2 files changed, 57 insertions(+), 30 deletions(-)
>=20
> >  delete mode 100644 Documentation/devicetree/bindings/phy/phy-
> cadence-dp.txt
>=20
> >  create mode 100644 Documentation/devicetree/bindings/phy/phy-
> cadence-torrent.yaml
>=20
> >
>=20
> > diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
> b/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
>=20
> > deleted file mode 100644
>=20
> > index 7f49fd54e..0000000
>=20
> > --- a/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
>=20
> > +++ /dev/null
>=20
> > @@ -1,30 +0,0 @@
>=20
> > -Cadence MHDP DisplayPort SD0801 PHY binding
>=20
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> > -
>=20
> > -This binding describes the Cadence SD0801 PHY hardware included with
>=20
> > -the Cadence MHDP DisplayPort controller.
>=20
> > -
>=20
> > -----------------------------------------------------------------------=
---------
>=20
> > -Required properties (controller (parent) node):
>=20
> > -- compatible	: Should be "cdns,dp-phy"
>=20
> > -- reg		: Defines the following sets of registers in the parent
>=20
> > -		  mhdp device:
>=20
> > -			- Offset of the DPTX PHY configuration registers
>=20
> > -			- Offset of the SD0801 PHY configuration registers
>=20
> > -- #phy-cells	: from the generic PHY bindings, must be 0.
>=20
> > -
>=20
> > -Optional properties:
>=20
> > -- num_lanes	: Number of DisplayPort lanes to use (1, 2 or 4)
>=20
> > -- max_bit_rate	: Maximum DisplayPort link bit rate to use, in Mbps
> (2160,
>=20
> > -		  2430, 2700, 3240, 4320, 5400 or 8100)
>=20
> > -----------------------------------------------------------------------=
---------
>=20
> > -
>=20
> > -Example:
>=20
> > -	dp_phy: phy@f0fb030a00 {
>=20
> > -		compatible =3D "cdns,dp-phy";
>=20
> > -		reg =3D <0xf0 0xfb030a00 0x0 0x00000040>,
>=20
> > -		      <0xf0 0xfb500000 0x0 0x00100000>;
>=20
> > -		num_lanes =3D <4>;
>=20
> > -		max_bit_rate =3D <8100>;
>=20
> > -		#phy-cells =3D <0>;
>=20
> > -	};
>=20
> > diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-
> torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-
> torrent.yaml
>=20
> > new file mode 100644
>=20
> > index 0000000..4fa9d0a
>=20
> > --- /dev/null
>=20
> > +++ b/Documentation/devicetree/bindings/phy/phy-cadence-
> torrent.yaml
>=20
>=20
>=20
> Normal file naming is using the compatible string.
>=20
>=20
>=20
> > @@ -0,0 +1,57 @@
>=20
> > +%YAML 1.2
>=20
> > +---
>=20
> > +$id: "https://urldefense.proofpoint.com/v2/url?u=3Dhttp-
> 3A__devicetree.org_schemas_phy_phy-2Dcadence-2Dtorrent.yaml-
> 23&d=3DDwIBAg&c=3DaUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-
> _haXqY&r=3DxythEVTj32hrXbonw_U5uD9n5Dh9J7TTTznvmGAGKo4&m=3D9-
> kyiRknYkYa5DqMjgD8NdzvcteoR6ElMbozga1HYMw&s=3DR0d1BN7TnO9WvU1
> Wd1msGE7rObNLWn_xhVoW247Ggu0&e=3D "
>=20
> > +$schema: "https://urldefense.proofpoint.com/v2/url?u=3Dhttp-
> 3A__devicetree.org_meta-2Dschemas_core.yaml-
> 23&d=3DDwIBAg&c=3DaUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-
> _haXqY&r=3DxythEVTj32hrXbonw_U5uD9n5Dh9J7TTTznvmGAGKo4&m=3D9-
> kyiRknYkYa5DqMjgD8NdzvcteoR6ElMbozga1HYMw&s=3DuIcZwMHgTJIbhKM1q
> hWr_-4NoZWn5KaohCrVBA28Ruk&e=3D "
>=20
> > +
>=20
> > +title: Cadence Torrent SD0801 PHY binding for DisplayPort
>=20
> > +
>=20
> > +description:
>=20
> > +  This binding describes the Cadence SD0801 PHY hardware included with
>=20
> > +  the Cadence MHDP DisplayPort controller.
>=20
> > +
>=20
> > +maintainers:
>=20
> > +  - Swapnil Jakhade <sjakhade@cadence.com>
>=20
> > +  - Yuti Amonkar <yamonkar@cadence.com>
>=20
> > +
>=20
> > +properties:
>=20
> > +  compatible:
>=20
> > +    const: cdns,torrent-phy
>=20
> > +
>=20
> > +  reg:
>=20
> > +    items:
>=20
> > +      - description: Offset of the DPTX PHY configuration registers.
>=20
> > +      - description: Offset of the SD0801 PHY configuration registers.
>=20
> > +
>=20
> > +  "#phy-cells":
>=20
> > +    const: 0
>=20
> > +
>=20
> > +  num_lanes:
>=20
> > +    description:
>=20
> > +      Number of DisplayPort lanes.
>=20
> > +    allOf:
>=20
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
>=20
> > +      - enum: [1, 2, 4]
>=20
> > +
>=20
> > +  max_bit_rate:
>=20
> > +    description:
>=20
> > +      Maximum DisplayPort link bit rate to use, in Mbps
>=20
> > +    allOf:
>=20
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
>=20
> > +      - enum: [2160, 2430, 2700, 3240, 4320, 5400, 8100]
>=20
> > +
>=20
> > +required:
>=20
> > +  - compatible
>=20
> > +  - reg
>=20
> > +  - "#phy-cells"
>=20
> > +
>=20
> > +examples:
>=20
> > +  - |
>=20
> > +    dp_phy: phy@f0fb030a00 {
>=20
> > +          compatible =3D "cdns,torrent-phy";
>=20
> > +          reg =3D <0xf0 0xfb030a00 0x0 0x00000040>,
>=20
> > +                <0xf0 0xfb500000 0x0 0x00100000>;
>=20
> > +          num_lanes =3D <4>;
>=20
> > +          max_bit_rate =3D <8100>;
>=20
> > +          #phy-cells =3D <0>;
>=20
> > +    };
>=20
> > +...
>=20
> > --
>=20
> > 2.7.4
>=20
> >

Thanks & Regards=20
Yuti Amonkar
