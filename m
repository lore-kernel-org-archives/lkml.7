Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFFBC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95EA2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mXq1aH2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfKUJEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:04:42 -0500
Received: from mail-eopbgr740048.outbound.protection.outlook.com ([40.107.74.48]:50176
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726132AbfKUJEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:04:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gn+vP5DZDlJo2PuwMyJ6W5ED0OQoWv2L5f0W1Dvf9FI4/mLSrdKBvdwVKeLUyTEy5LPmFVTDx/6NrgRnY0Ue7kAWbgDfoLnyQqSC4UJa3yuQQXsg57BJ9QCayRfkGbif1Hbf9Cbce4XfGUetN/x2zqwnoCXu3a9PTu64ocCMTWEtldPl9kggPynngR9Trok2VQMdwceFWUd21r00LFjNRxyhdH8txX9yH92vFL+4weng0J3T2mHF5s01ynjy1Qj+7GE/GzvXiaxIdCJylgKyma/1ZrDzRYRxAs25RL/gyYSBM0OgYu0aF0H/h/oTzIGpOL+vTgBHJAt5+pSGNIM2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3DulbXL9J15u61yWz56lXH9lvQFGc7NOxYb6mRJxfw=;
 b=U8VetMlbyENyeYcoYkgty5G2HPcp/7IXlir0U1Rum6eCT/+kLbAyN+XTarCl+hVAOuK3BlO3AgkF82hI+mKsOlXgipzZOCGa9lGELT/+9FwOMiKR3fNhXRtsNGQVavuLJ4+ZQoPTTbPxs+EPiG+TT99NWcjhnGloAe5jyXRVm7d0BcA4So18iw7QW4LaRb/cBYMLsdJEe9ueQXXhIHt5mU1kNcvKY1Z3rCf8ADSC9M/kiYYeYJvNmkGOYM3g1J6KZhvVIHpygr4oH/531NBsWMR4SZSPK6d9jGKtuwFS57MyKQlpnkfLiks+/QGlygyHUEXbdS0oeANUsSVm619rGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3DulbXL9J15u61yWz56lXH9lvQFGc7NOxYb6mRJxfw=;
 b=mXq1aH2gh16jFvrQuzqdwJ851ZzKPFEG9rZdb5T20kdXlvvE1DZWR+f6H7b2RPzAksim0Jli0HeN6m/y5sotve7RwEahjiFv1A7reLau9/0RxIhn2uRh4lQedd8JfttFftmeejDxmlVsLjRHv0depAxZI5w34QF9g71WoCc6rxw=
Received: from MN2PR02MB6094.namprd02.prod.outlook.com (52.132.172.151) by
 MN2PR02MB6398.namprd02.prod.outlook.com (52.132.172.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Thu, 21 Nov 2019 09:04:39 +0000
Received: from MN2PR02MB6094.namprd02.prod.outlook.com
 ([fe80::319d:d506:2faf:a4a2]) by MN2PR02MB6094.namprd02.prod.outlook.com
 ([fe80::319d:d506:2faf:a4a2%7]) with mapi id 15.20.2474.018; Thu, 21 Nov 2019
 09:04:39 +0000
From:   Shubhrajyoti Datta <shubhraj@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [RFC PATCHv2 1/3] dt-bindings: misc: Add dt bindings for flex noc
 Performance Monitor
Thread-Topic: [RFC PATCHv2 1/3] dt-bindings: misc: Add dt bindings for flex
 noc Performance Monitor
Thread-Index: AQHVdCmZoFI17g0Ymkq7XWhFdff3yqdUgJwAgEEqGnA=
Date:   Thu, 21 Nov 2019 09:04:38 +0000
Message-ID: <MN2PR02MB60943664B80D3028F8422175AA4E0@MN2PR02MB6094.namprd02.prod.outlook.com>
References: <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569474867.git.shubhrajyoti.datta@xilinx.com>
 <20191010214835.GA4523@bogus>
In-Reply-To: <20191010214835.GA4523@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shubhraj@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf6c2898-cba2-45d2-3edc-08d76e61d6d7
x-ms-traffictypediagnostic: MN2PR02MB6398:|MN2PR02MB6398:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB6398D596ED3BB0D86F80E012AA4E0@MN2PR02MB6398.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(189003)(199004)(13464003)(64756008)(229853002)(7696005)(86362001)(74316002)(305945005)(76176011)(55016002)(7736002)(52536014)(256004)(54906003)(71200400001)(71190400001)(316002)(6916009)(76116006)(4326008)(14454004)(99286004)(25786009)(5660300002)(6116002)(11346002)(3846002)(6436002)(446003)(81166006)(478600001)(6246003)(107886003)(33656002)(102836004)(9686003)(26005)(6506007)(66066001)(186003)(66556008)(66946007)(66476007)(8676002)(81156014)(8936002)(53546011)(2906002)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6398;H:MN2PR02MB6094.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: te+sYE2MSaP+XjmP9swNAe7X7erTE0Fa2krWTNUxbvOVE3lMWVuFCDAi828WqXbqS0cKi2QdKsb1jxmaNWTZ6GUV0UfxFJzNOm9I6kAabdmp8PLUj5Yc4x6TnkKXZs3VXc86xD/pzThcLXKqQhmWo6ppkH3wF920E3cetgA4O2nl8vWpA89DpfNWMhWibMvciu75zoisnaU9VMrt6Ooa0Am4BdwhmxzWdtH0ZhlRFCZTtzd2r8B0Dakefq2ScGe0e7wuzR8ZaKRYwnUK5KElQtpaWb1AimoLihZWeQyF0kjguzLtUTrdUHnD/kl2SCwty2RwrO7dDO+v6rppcPPltDAQ5k7nsAdmSk3FlEv1KkkAmWKUoTLSM2/o/RV3cbxf7dtS0unSU06ck3+7D0QNdWQipp1RsJq7J811Bo8P+IILqJyfA6zJHtiITHyZr8n9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6c2898-cba2-45d2-3edc-08d76e61d6d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 09:04:38.9659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YbfSKlMGQOOHoSw5IT7XlljKal00oJN53jV+MZSpFMW9+Q0GnBap+uoaxJktR10Q6GvW79ISx1r1ihUiyufcOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6398
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, October 11, 2019 3:19 AM
> To: Shubhrajyoti Datta <shubhraj@xilinx.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> arnd@arndb.de; gregkh@linuxfoundation.org; Michal Simek
> <michals@xilinx.com>
> Subject: Re: [RFC PATCHv2 1/3] dt-bindings: misc: Add dt bindings for fle=
x noc
> Performance Monitor
>=20
> On Thu, Sep 26, 2019 at 10:46:24AM +0530, Shubhrajyoti Datta wrote:
> > Add dt bindings for flexnoc Performance Monitor.
> > The flexnoc counters for read and write response and requests are
> > supported.
> >
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > ---
> >  .../devicetree/bindings/misc/xlnx,flexnoc.txt      | 24
> ++++++++++++++++++++++
>=20
> bindings/perf/
>=20
> Please convert this to a schema. See
> Documentation/devicetree/writing-schema.rst.
Ok=20
>=20
> >  1 file changed, 24 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/misc/xlnx,flexnoc.txt
> >
> > diff --git a/Documentation/devicetree/bindings/misc/xlnx,flexnoc.txt
> > b/Documentation/devicetree/bindings/misc/xlnx,flexnoc.txt
> > new file mode 100644
> > index 0000000..6b533bc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/xlnx,flexnoc.txt
> > @@ -0,0 +1,24 @@
> > +* Xilinx Flexnoc Performance Monitor driver
>=20
> Bindings are for h/w blocks, not drivers.
Wil change
>=20
> > +
> > +The FlexNoc Performance Monitor has counters for monitoring the read
> > +and the write transaction counter.
> > +
> > +Required properties:
> > +- compatible: "xlnx,flexnoc-pm-2.7"
> > +- reg : Address and length of register sets for each device in
> > +       "reg-names"
> > +- reg-names : The names of the register addresses corresponding to the
> > +               registers filled in "reg"
> > +               - funnel: base address of the funnel registers
> > +               - baselpd: base address of the LPD PM registers
> > +               - basefpd: base address FPD PM registers
>=20
> Is this really all one h/w block.
>=20
> FlexNoC is an interconnect, right? Is there more to it than just perfmon?
Yes , however the driver only uses the monitoring  part.

>=20
> > +
