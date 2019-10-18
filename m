Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D73CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F0F2064B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ITsGvMKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438552AbfJRJFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:05:51 -0400
Received: from mail-eopbgr740070.outbound.protection.outlook.com ([40.107.74.70]:36192
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729213AbfJRJFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:05:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWE6u6r6/YjcpHd3pzIEpSxk1g34kgxVXZtv9SkYIGo6bwsj2b7akDec0BEP60Op/lxaFVnYE2nlcH1eTJJWbqMy8aRU33dkcNyfvo/pxYNbuFLjAtlV80U23YdZaoRD7ZlM2m2hFInXwfnIT8zHkabbJ8sVDAbSoeVxfRdh8NuqQ3SJq3AsJ9Bz4SBlJ6egEt5sqWNhpQ7v7DD6dTa9vP7EvnWOWTtOBOV/DRy5cFuF+ZCbz+OnQVX8vjYvX16HulylwZUQuFzsCHjTsrbDIOJQwXREgmReO8uTzK4SdiqnpNmBq+b5FLVb1DR48QWYuNTTM2LpGEoWqr3jItLiaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdDGdfhKK4DumTJ5T0x8DdxN4eMF0rmum9BgfEUCWM4=;
 b=OztUOh7AS//PkWahUHQsitmxhoW96murHqYLpyFr2t9+iinEgZZm7rskzkzp/HtH1qYX5Z8ACQOp9NID7CnvFznuor8RjkpzHZGZRDA9m/CuL1AmXz7RcbUDIOAK/JH25/h8isZEc3Oo1EPnuYIrbXGSVTmrq40jI5BzTQquSkXoF2sH4niSYhuBQnM5U9NFmw1o/b9OP2qosU9ikOYBakDmUCs6uy1tcPeimv0Gq0TItXiWwPK0qPw0e6S0yfIRmxi5gBcq/kq7pbWFAEj9w7Lmu/mq3GIzaJKUyWRLf2iQUmj33rUbx3UrqqB4OTPvRcsjvfsHawKgRcv+WTqK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdDGdfhKK4DumTJ5T0x8DdxN4eMF0rmum9BgfEUCWM4=;
 b=ITsGvMKUSBI4EZmDB84VE4kVK/QRNQFTkE6IhyzEwcpH5anm+YFY7rKexEwWzqBhOWXulFKm7UlRFbG//0cvKjjA9bWeTFSY26687Gvl9hznhYZc6f0maO5oPAvEFR66KgcZhy3NkrepD8JCTmPosxFgElL2WZqCitmF/KdG3Zs=
Received: from MN2PR02MB6029.namprd02.prod.outlook.com (52.132.174.207) by
 MN2PR02MB6173.namprd02.prod.outlook.com (52.132.174.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 18 Oct 2019 09:05:07 +0000
Received: from MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::7830:9d9a:b79a:40e7]) by MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::7830:9d9a:b79a:40e7%6]) with mapi id 15.20.2347.026; Fri, 18 Oct 2019
 09:05:07 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Michal Simek <michals@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: RE: [PATCH v3 4/8] dt-bindings: mmc: arasan: Add optional properties
 for Arasan SDHCI
Thread-Topic: [PATCH v3 4/8] dt-bindings: mmc: arasan: Add optional properties
 for Arasan SDHCI
Thread-Index: AQHVhLNB61L4BxlTxk+rSkpwaMUAS6dfJmOAgAD1W5A=
Date:   Fri, 18 Oct 2019 09:05:07 +0000
Message-ID: <MN2PR02MB602959AB68B4C88B81359F2EC16C0@MN2PR02MB6029.namprd02.prod.outlook.com>
References: <1571293310-92563-1-git-send-email-manish.narani@xilinx.com>
 <1571293310-92563-5-git-send-email-manish.narani@xilinx.com>
 <20191017182255.GA7053@bogus>
In-Reply-To: <20191017182255.GA7053@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e21799c4-1848-4b8c-7597-08d753aa45ab
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: MN2PR02MB6173:|MN2PR02MB6173:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB6173A51B5BFC033749BE7F0FC16C0@MN2PR02MB6173.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(199004)(189003)(13464003)(33656002)(6916009)(11346002)(446003)(186003)(66946007)(486006)(476003)(52536014)(66476007)(66556008)(64756008)(66446008)(76116006)(6116002)(3846002)(2906002)(86362001)(256004)(4326008)(6246003)(107886003)(55016002)(6436002)(9686003)(7696005)(99286004)(102836004)(53546011)(6506007)(26005)(76176011)(7736002)(54906003)(229853002)(316002)(71190400001)(14454004)(305945005)(8936002)(71200400001)(66066001)(8676002)(81166006)(5660300002)(81156014)(7416002)(74316002)(25786009)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6173;H:MN2PR02MB6029.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VxHAmmWdjgRIP2EZitAtde07idnY7U5xD2BAYbnXwlqwfbvS3dTmakzXk3fWXWjzXkNmrzWR+8Fdn74t8ZbzGiy2XfC6Sy8LIUN92ScWwQXue+WXe6iBeXjtTGNvx9hgh3PuGjcZRlh3umpAOUCJ3pO3Cy9JWZWy+p2LRejdIBwSrkOqdj+GMgtvfUebSjipiUJ7F3p2JMgqzfqgZBPidysOKUBs//JkIboYmS09aHz2VB9M/agIQZ1vAE8fbe4gLWdG8CuxV+XH1pBFjQcQyOVbcJ9rO8QNwd1Si3Ky0C4yIbZeVhbO7wcbEuJSwPvdJhX+jGmZJ5Kwjyx7ep0ijEecXot2yrRk+hU5uVGdsMYWdVMJ/UIjLIiVVtHLuPVmmQxaQxRhBc8X95U9NcO/kuU0Mq6WLSHx75DvbhTlh3E=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21799c4-1848-4b8c-7597-08d753aa45ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 09:05:07.1916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uk9fl15d0lIRvfHgGexfRRXwH7giT1ypAZe6qjKJr/Qa6wzAtnU5naj8haBlROYCeYlJjapj4SY9izDIB/eJxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you so much for the review.
Please find my comments inline below.

Thanks,
Manish

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, October 17, 2019 11:53 PM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: ulf.hansson@linaro.org; mark.rutland@arm.com; adrian.hunter@intel.com=
;
> Michal Simek <michals@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; Rajan
> Vaja <RAJANV@xilinx.com>; Nava kishore Manne <navam@xilinx.com>;
> mdf@kernel.org; linux-mmc@vger.kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git
> <git@xilinx.com>
> Subject: Re: [PATCH v3 4/8] dt-bindings: mmc: arasan: Add optional proper=
ties
> for Arasan SDHCI
>=20
> On Thu, Oct 17, 2019 at 11:51:46AM +0530, Manish Narani wrote:
> > Add optional propeties for Arasan SDHCI which are used to set clk delay=
s
>=20
> properties
>=20
> > for different speed modes in the controller.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  .../devicetree/bindings/mmc/arasan,sdhci.txt      | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > index b51e40b2e0c5..e0369dd7fb18 100644
> > --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > @@ -46,6 +46,21 @@ Optional Properties:
> >      properly. Test mode can be used to force the controller to functio=
n.
> >    - xlnx,int-clock-stable-broken: when present, the controller always =
reports
> >      that the internal clock is stable even when it is not.
> > +  - clk-phase-legacy: Input/Output Clock Delay pair in degrees for Leg=
acy
> Mode.
> > +  - clk-phase-mmc-hs: Input/Output Clock Delay pair degrees for MMC HS=
.
> > +  - clk-phase-sd-hs: Input/Output Clock Delay pair in degrees for SD H=
S.
> > +  - clk-phase-uhs-sdr12: Input/Output Clock Delay pair in degrees for =
SDR12.
> > +  - clk-phase-uhs-sdr25: Input/Output Clock Delay pair in degrees for =
SDR25.
> > +  - clk-phase-uhs-sdr50: Input/Output Clock Delay pair in degrees for =
SDR50.
> > +  - clk-phase-uhs-sdr104: Input/Output Clock Delay pair in degrees for
> SDR104.
> > +  - clk-phase-uhs-ddr50: Input/Output Clock Delay pair in degrees for =
SD
> DDR50.
> > +  - clk-phase-mmc-ddr52: Input/Output Clock Delay pair in degrees for =
MMC
> DDR52.
> > +  - clk-phase-mmc-hs200: Input/Output Clock Delay pair in degrees for =
MMC
> HS200.
> > +  - clk-phase-mmc-hs400: Input/Output Clock Delay pair in degrees for =
MMC
> HS400.
>=20
> Should be common?
Yes, these properties should be common.

>=20
> Range of values?
As these values are in degrees, the range of values is 0 to 359 degrees.

Thanks,
Manish
