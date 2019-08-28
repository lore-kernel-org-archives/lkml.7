Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680F3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31572233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="HrI6MtgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfH1FtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 01:49:20 -0400
Received: from mail-eopbgr690064.outbound.protection.outlook.com ([40.107.69.64]:22290
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725613AbfH1FtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 01:49:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsqC1pfqbhKh/W7zEwH/Iu+QC6zmU+mRQmi1T3m5IihVHNY0S36YlBKkYyZi08AEhELxNNcg/1grQ1YSBwmWMZiZN6Fz0mdVI/4RJpkbm1bAesXZk/dSMRh6XMWkufqOuRJQf2d8YT08dKaFb7MwlJc/0Zc/fplZeAfRPEspw9bb/jWV3Z8iOl0/4nxAhNuEcRBiLA8Z5l9LG1Nz/W0feLShSQXFeBPZu2qUW4OgxLlsE/bccVhMpVhVsaovoanJPO3wJ4JJYUw5KJqTIrF1eH0dnlCRU99ishyh2VtmDnth4Kr3GE8HvyGJeAdh5cAto5Q6hEYwWmJzmVCLajqBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7SYLuCRAiImVwjIAQJQ/z4F4N0tK8u3DjAlLacmcGo=;
 b=EEMFJXKGqNGL5McvDkEcRXHPpPM68s//mbBb4y8tyt00g4Fa9TOHWRdy9l5HeYAldQ6Ehtv0vzO/hXEpMLP/POG4MJdJJsIAQVHQaSckUmlyE3fTvs8K87PGIr67CGdKzee/UXodDcjQihvZp5u6UZygEKvQswkNMb8fijmMw8lGgRm1K6LHjxoAZR9pr68qHKZxyeTeIx4sjLZXb0kWwsnG2YyqNiZi7sGcPbEql3lAJAx8P39qVzR1uvBKzTOS9JbvIgVNS5wXJ+/9DhsasZFGiOjFT5U6VNZduZUFXQ6yEiwHb9gKXACl5aeZFpVG4Tm+Q8mxlBwn0spR2FXRuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7SYLuCRAiImVwjIAQJQ/z4F4N0tK8u3DjAlLacmcGo=;
 b=HrI6MtgXSvlzdIwIvGk6t5uM5hoggrb5/cvbo1uHu1jiUwDG7jvzpdrXRahG0Rqh+W2IYa7Nyhf/HQHWoJDrA4wKV+FjktVgppzdO+0y/gMKQ1HnUTbGNiKu+GEqj1uARF4b/oAW+oQub2JYwfYcySmdXu6M81l54SkuwKlJPXg=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4453.namprd03.prod.outlook.com (20.178.49.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 05:49:17 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 05:49:17 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/8] regulator: add support for SY8824C regulator
Thread-Topic: [PATCH 2/8] regulator: add support for SY8824C regulator
Thread-Index: AQHVXLPE86z8PZfejUaXlIn4vcy6TacPZk+AgAEHU4D//550gA==
Date:   Wed, 28 Aug 2019 05:49:16 +0000
Message-ID: <20190828133757.6a0fe6dd@xhacker.debian>
References: <20190827163252.4982af95@xhacker.debian>
        <20190827163418.1a32fc48@xhacker.debian>
        <20190827194437.GO23391@sirena.co.uk>
        <20190828112705.5e683693@xhacker.debian>
In-Reply-To: <20190828112705.5e683693@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:404:a6::29) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec9a8dec-b64c-4a64-b4d9-08d72b7b7691
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4453;
x-ms-traffictypediagnostic: BYAPR03MB4453:
x-microsoft-antispam-prvs: <BYAPR03MB44531E89B6466D8462C13333EDA30@BYAPR03MB4453.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(76176011)(305945005)(7736002)(386003)(1076003)(8676002)(99286004)(6506007)(316002)(102836004)(8936002)(81166006)(6512007)(66476007)(9686003)(229853002)(81156014)(6486002)(478600001)(5660300002)(14454004)(2906002)(6436002)(71190400001)(25786009)(3846002)(6116002)(71200400001)(53936002)(54906003)(86362001)(4326008)(50226002)(446003)(52116002)(186003)(6916009)(26005)(66556008)(6246003)(11346002)(66446008)(476003)(64756008)(14444005)(256004)(66946007)(66066001)(486006)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4453;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GwZtuduHp//ikAH923Y375WYJci9YgQQmRZhDUmZADtgEdI1YfmbNRNGOW4/YB9yNCI4nyLXS+VbaJrB3LpCb4ddyIeuyFv5vABmKBHQPMsbEGg5H2iFT/nj/N+Zh3rXiaZVqB62kyt6H1tBLlCtDJ2N1B4zl9KJb/tpJvN8HkDaBaDkqd3Fz1D7SJazMbCNWPMjj2wHk9rpDXT6kIKQUfR+WeSW0U8oTjJ95OcFcpP6bcOk5I4XCM1vS9ejstXBKIMvtPEi3shIyDCJ2cmHVnzyhiQpHGGs98comT2gN37wUSI3ds8c1aIDZHfwUhHjnr3c7o+jhjmoxa9MC4iGm/fdZoRMCzQtkxd9IPk0u9+WVWsIsVFhR7w81SwI1KV72o7Y6DvOtG7gIaZjDeOkjYYRVeLTCM0bPzJaVAuKnYI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AABB45CDBCCCF849A0ACA2D834A0B47D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9a8dec-b64c-4a64-b4d9-08d72b7b7691
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 05:49:16.9195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+yQW95OPfmslC6bDdglWOUA4bzMO86g7BnoHAXyOxw5kR/zHVj+AETzUg6ShjHB6gF5UfqlTkpa26Ct3U81Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 11:27:05 +0800 Jisheng Zhang wrote:

> Hi Mark,
>=20
> On Tue, 27 Aug 2019 20:44:37 +0100 Mark Brown wrote:
>=20
> > On Tue, Aug 27, 2019 at 08:45:33AM +0000, Jisheng Zhang wrote:
> >=20
> > This looks mostly good and I'll apply it, a couple of small
> > things though:
> >  =20
> > > @@ -0,0 +1,192 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * SY8824C regulator driver
> > > + *   =20
> >=20
> > Please send a patch which updates the entire comment block to be
> > C++ style so it looks consistent. =20
>=20
> Do you mean update the following style
>=20
> A:
>=20
> // SPDX-License-Identifier: GPL-2.0
> /*
>  * SY8824C regulator driver
>  * ...
>=20
>=20
> as B:
>=20
> // SPDX-License-Identifier: GPL-2.0
> // SY8824C regulator driver
> // ...
>=20
> I'm not sure which style is correct. But I see B is commonly used

sorry, typo. I mean "I see A is commonly used ..."

> in lots .c source files in other dirs, such as kernel/ mm/ etc.
>=20
> Could you please clarify?
>=20
> Thanks
>=20
> >  =20
> > > +#define BUCK_EN		(1 << 7)
> > > +#define MODE		(1 << 6)
> > > +   =20
> >=20
> > Please also add prefixes to these to namespace them, especially
> > MODE is likely to collide with something later. =20
>=20
> good idea. Will do in newer version

