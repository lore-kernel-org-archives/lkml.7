Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1446EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A27233A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tXzM/EUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391637AbfHWKBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:01:38 -0400
Received: from mail-eopbgr700061.outbound.protection.outlook.com ([40.107.70.61]:12289
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730580AbfHWKBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:01:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXSqTlZinUVtpAKsmj0oVAUE9/E8hRWrmtiKxBPJilSCCNBktJWd6TFPVgKBnO8S1HAkxFfjAfymGSqQs9nRp1BAgtsNLKCbHzBwSfSqFRcecWxe8aUO9K6ARQqkA9hMqWjfV3ahxd8okv1W/jGsaBZh20f39sQ0h6SRMQhCDEEySrI23SceThcw6uWOvWuH5Ftsbc9y3su68QLBNn0S5y/6b1WZQ70VypDxf/1oTbY4tVUKvjiUDiV8tPlAlK23OdtqD6gq1X3cBdpA/VVM5PNmEG8h3mFDDCn4nlJD39keV9Itt8cYWr5wLnd9OzxceIOxl0ZRUBXrQdIF+4eo1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QS//HXcLChW8QZm3OqWZMQdi+9moM/Dh5nm+izKg3nQ=;
 b=O7OF09itaqfeRDYsGROTmlhZNNBrsbKFt2ZJS1hNmXIJzQ7Ofn35wgCwUagSSLjC+tZ8vN/OHxmMMLCbmCfE++B/QlNgeGgjdBpB32aWN3T1oqYKIRXnQsPYC/a0AFcM5Z6uFfyAG7Ljlp4A89a0TbkUS5YNeNSCIawLrLk0SUaAKKdPnzCO3nRaoe1EPK3hJ6taqgtFoFd1ZKfFK4tqXQTlNtDZPx9UCtpQbazIfT6szP9xLA5I9tv2qeW2/8DvHnzhAlsF0H1oc9kvRQM2NXv6y6j/lzff2wRcvPBTbKD5hczBj0eikUJYEW//McylbIwNGh2G2/XLXPgbCoGLeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QS//HXcLChW8QZm3OqWZMQdi+9moM/Dh5nm+izKg3nQ=;
 b=tXzM/EUqrPSHHVrk9bgisKcC7WhojJ5Fkw1HG+LKNPZdUWowiS67L8intYJzOumWiNifimuS5GEV9tOeBhPEZJvaQEVFatd5CzlpngkoajGTCNEAHppVWb7v5liF4YQERM3FPYBHeixDTdBCQXv5ilijOgXaY6LmYA41qPLT14k=
Received: from MN2PR02MB6029.namprd02.prod.outlook.com (10.255.7.10) by
 MN2PR02MB6349.namprd02.prod.outlook.com (52.132.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 10:01:32 +0000
Received: from MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::6930:d45:6895:4255]) by MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::6930:d45:6895:4255%4]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 10:01:32 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Rob Herring <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "christoph.muellner@theobroma-systems.com" 
        <christoph.muellner@theobroma-systems.com>,
        "philipp.tomsich@theobroma-systems.com" 
        <philipp.tomsich@theobroma-systems.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "ayaka@soulik.info" <ayaka@soulik.info>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "tony.xie@rock-chips.com" <tony.xie@rock-chips.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Subject: RE: [PATCH v2 01/11] dt-bindings: mmc: arasan: Update documentation
 for SD Card Clock
Thread-Topic: [PATCH v2 01/11] dt-bindings: mmc: arasan: Update documentation
 for SD Card Clock
Thread-Index: AQHVL84QKtDrcydqmkObCTy1mFTFVabXUFgAgAB7vdCAA6ZJgIAnAKOwgAULIgCAAE+DgIABBZpg
Date:   Fri, 23 Aug 2019 10:01:31 +0000
Message-ID: <MN2PR02MB6029DEFCD8E9B54AA9610023C1A40@MN2PR02MB6029.namprd02.prod.outlook.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
 <MN2PR02MB60299EB8B83C4EA68A0F2B33C1A80@MN2PR02MB6029.namprd02.prod.outlook.com>
 <CAPDyKFqdLE7d9uz_KcpO0CihM+QsFyKbNsoDMoNLT2Qy_TmNdw@mail.gmail.com>
 <4911073.ucheZMAtV3@phil>
In-Reply-To: <4911073.ucheZMAtV3@phil>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1966d976-6296-4270-83d8-08d727b0e02a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR02MB6349;
x-ms-traffictypediagnostic: MN2PR02MB6349:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB6349E05FF752BE6DD7144EACC1A40@MN2PR02MB6349.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(13464003)(3846002)(66476007)(33656002)(15650500001)(55016002)(316002)(7416002)(2906002)(9686003)(6506007)(2501003)(53936002)(110136005)(54906003)(76176011)(6306002)(7696005)(476003)(66946007)(4326008)(14444005)(6436002)(26005)(256004)(7736002)(66066001)(305945005)(446003)(11346002)(74316002)(102836004)(99286004)(25786009)(478600001)(86362001)(186003)(53546011)(81156014)(8676002)(81166006)(52536014)(71200400001)(6116002)(76116006)(71190400001)(66446008)(66556008)(8936002)(6246003)(64756008)(5660300002)(229853002)(14454004)(486006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6349;H:MN2PR02MB6029.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9Vl+qXx2dOdegOLwu62qQ8+4+nRh27YzrIIoOilYNVsQC1lnDRA9R/IRld5qwvpSI/gOxNasY2x1Ez/k7fpHiI/W1b9Vm1vrThhX9v5yKpTAxI4n7XAYuToSlQegcjo86V+esHv0BblmBruBabqxERp6s9/C4gwez7UFJYmEIgMm8jqnwhkrVm0mL4OyTajk9ZtQX4155Ug7Mb2n3V6qS/d/QvWy70sJBKvuQQqhmRz5/BqADWYhXgK7aPYhvOsjFXUImT+xlvDxQ4Ygx+kqqgRk9l6QRRbW4elhufkS5td0mv8fPp/d8SwYpyB+WYacPTxN0Yu23+nzVB64dT4LP8eEhxefBdtyyl5lEFjnGoLsiYDqQFH7RXoIyZfp5JMmdyKSonGcamxEGtwvSYMenkZLx2TeqmpFkp05W07EkMg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1966d976-6296-4270-83d8-08d727b0e02a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 10:01:32.2905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jBmd3S0wOLAUfaLh6VksDZrRmaun/lQvOoy3AKrJnbvehcphtLPjqprCw5+QIDdcry8DRLPpbzAnwPcCDGHRPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6349
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko/Uffe,



> -----Original Message-----
> From: Heiko Stuebner <heiko@sntech.de>
> Sent: Thursday, August 22, 2019 11:53 PM
> To: Ulf Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org
> Cc: Manish Narani <MNARANI@xilinx.com>; Rob Herring <robh@kernel.org>;
> mark.rutland@arm.com; Michal Simek <michals@xilinx.com>;
> adrian.hunter@intel.com; christoph.muellner@theobroma-systems.com;
> philipp.tomsich@theobroma-systems.com; viresh.kumar@linaro.org;
> scott.branden@broadcom.com; ayaka@soulik.info; kernel@esmil.dk;
> tony.xie@rock-chips.com; Rajan Vaja <RAJANV@xilinx.com>;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-rockchip@lists.infradead.org
> Subject: Re: [PATCH v2 01/11] dt-bindings: mmc: arasan: Update
> documentation for SD Card Clock
>=20
> Am Donnerstag, 22. August 2019, 15:38:26 CEST schrieb Ulf Hansson:
> > [...]
> >
> > > > > > > ---
> > > > > > >  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 15
> > > > ++++++++++-
> > > > > > ----
> > > > > > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > > > > > >
> > > > > > > diff --git
> a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > > > > b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > > > > > index 1edbb04..15c6397 100644
> > > > > > > --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > > > > > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > > > > > @@ -23,6 +23,10 @@ Required Properties:
> > > > > > >    - reg: From mmc bindings: Register location and length.
> > > > > > >    - clocks: From clock bindings: Handles to clock inputs.
> > > > > > >    - clock-names: From clock bindings: Tuple including "clk_x=
in" and
> > > > "clk_ahb"
> > > > > > > +            Apart from these two there is one more optional =
clock
> which
> > > > > > > +            is "clk_sdcard". This clock represents output cl=
ock from
> > > > > > > +            controller and card. This must be specified when=
 #clock-
> cells
> > > > > > > +            is specified.
> > > > > > >    - interrupts: Interrupt specifier
> > > > > > >
> > > > > > >  Required Properties for "arasan,sdhci-5.1":
> > > > > > > @@ -36,9 +40,10 @@ Optional Properties:
> > > > > > >    - clock-output-names: If specified, this will be the name =
of the card
> > > > clock
> > > > > > >      which will be exposed by this device.  Required if #cloc=
k-cells is
> > > > > > >      specified.
> > > > > > > -  - #clock-cells: If specified this should be the value <0>.=
  With this
> > > > property
> > > > > > > -    in place we will export a clock representing the Card Cl=
ock.  This
> clock
> > > > > > > -    is expected to be consumed by our PHY.  You must also sp=
ecify
> > > > > > > +  - #clock-cells: If specified this should be the value <0>.=
 With this
> > > > > > > +    property in place we will export one clock representing =
the Card
> > > > > > > +    Clock. This clock is expected to be consumed by our PHY.=
 You
> must
> > > > also
> > > > > > > +    specify
> > > > > >
> > > > > > specify what?
> > > > > I think this line was already there, I missed to correct it, Will=
 update in
> v3.
> > > > >
> > > > > >
> > > > > > The 3rd clock input I assume? This statement means any existing=
 users
> > > > > > with 2 clock inputs and #clock-cells are in error now. Is that =
correct?
> > > > > Yes, this is correct. So far there was only one vendor using '#cl=
ock-cells'
> > > > which is Rockchip. I have sent DT patch (02/11) for that also.
> > > > > Here this is needed as earlier implementation isn't correct as su=
ggested
> by
> > > > Uffe. (https://lkml.org/lkml/2019/6/20/486) .
> > > >
> > > > I am not sure how big of a problem the backwards compatible thingy
> > > > with DT is, in general we must not break it. What do you say Manish=
?
> > >
> > > Though I agree with Uffe on this, there is no other way from my
> understanding. Please suggest.
> > >
> > > >
> > > > As a workaround, would it be possible to use
> > > > of_clk_get_from_provider() somehow to address the compatibility iss=
ue?
> > >
> > > For this to be used we have to parse 'clkspec' from the DT node and p=
ass
> the same as an argument to this function. In this case also the DT node n=
eeds to
> be updated, which is same as we have done in this series.
> >
> > Alright. I guess breaking DTBs for Rockchip platforms isn't
> > acceptable, especially if those are already widely deployed, which I
> > have no idea of....
>=20
> The arasan sdhci is part of the rk3399, so every SBC using that SoC, but
> also the whole Gru series of ChromeOS devices (Samsung Chromebook Plus
> among them) would be affected.

Thanks for confirming. This will be taken care of. I will go back to v1 cha=
nges and will send v3.

Thanks,
Manish
