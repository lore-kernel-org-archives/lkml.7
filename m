Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D931C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 03:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1466320854
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 03:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="GFLoDzeZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfH1Die (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 23:38:34 -0400
Received: from mail-eopbgr700074.outbound.protection.outlook.com ([40.107.70.74]:3073
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbfH1Did (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 23:38:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KP9dU7BuAdHIudrQUgeUId9HFYlModRndIwX56WUY5pC31T4NjzBXJzZp8KwmG/S7VPDJ1dSEuOzCmx2mwmg/qs4zAluP/+Bvr3hvw7Omtmz51g2udqqjw/ij6yEyo8AK1aHtDa4ZMwB5OS1ozcvL8Uft7SyykBQ3+6diy4l+mj1Ga0B+8N20yaCSM0NWCPQL/yu76GxKzZ/au9ZBonVYC+MRYvdueGYybueceWT9pS3sxDi+FfAasVvKUMK6cdJ5Un5xUQxGHY4JPVF+ihXo8/U1km25s+L/3TMUpdJ8D0M4bJ2XYf6lHmUPW3XBeiCLLnqJH87soxRc7N/oiBWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di8bz63uCvj3ZDVdNqPcyFRfow4gNvt4T85knoDt/ro=;
 b=nJCJX8SBQShzq34TE3+/bxHhcm4mvE+SZwC7ZldtTnki7MzxS8isNY+W8GRSzGisSJLHzmjmzMT65Y+SPsN2Kr1raVzTcibiO+UamWSy95EmzNy633VzAgGZIbZW+j1GmflUy+MQAyOaKwUfV0EIDitwsf4buUvo6c8Gb6yHofFb97HIFDZ2LLcEdHIGM1TbnOp1nultncI/g68Hrv4gYywi6C9iu2xCsvScNL1UnkEJfW3q1qhTmUw0xHmLpjvg94W5u5xKWywV+gONby5wSFIo8Vq+A8ZCh6CCwfLWlFl+LCZsOw60/H9j6zPs8JJ+Br7sniQR+gCLIDZGhCB5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di8bz63uCvj3ZDVdNqPcyFRfow4gNvt4T85knoDt/ro=;
 b=GFLoDzeZaDkD5NNJQPy+s4UnA2ZTDtUhYFLWSIS1X9qTlFvROjyj3GSQv8LDvwb5573Wgke8D737wNkU8WsTY1e+Kb9/SBCKXphyovmx7F9CbfeJvIRQskMDqx30+CtFz8ipqMraCXPc7p9AcE9n87aHJcoEmM0IwW9yFJbdTvc=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3735.namprd03.prod.outlook.com (52.135.214.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Wed, 28 Aug 2019 03:38:29 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 03:38:29 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/8] regulator: add support for SY8824C regulator
Thread-Topic: [PATCH 2/8] regulator: add support for SY8824C regulator
Thread-Index: AQHVXLPE86z8PZfejUaXlIn4vcy6TacPZk+AgACBN4A=
Date:   Wed, 28 Aug 2019 03:38:29 +0000
Message-ID: <20190828112705.5e683693@xhacker.debian>
References: <20190827163252.4982af95@xhacker.debian>
        <20190827163418.1a32fc48@xhacker.debian>
        <20190827194437.GO23391@sirena.co.uk>
In-Reply-To: <20190827194437.GO23391@sirena.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR03CA0020.apcprd03.prod.outlook.com
 (2603:1096:404:14::32) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b2a0e52-40d8-4ed9-47c4-08d72b6930f0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3735;
x-ms-traffictypediagnostic: BYAPR03MB3735:
x-microsoft-antispam-prvs: <BYAPR03MB37353BB293E74EF89087F134EDA30@BYAPR03MB3735.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(376002)(366004)(199004)(189003)(11346002)(446003)(478600001)(5660300002)(14454004)(229853002)(6512007)(9686003)(6436002)(2906002)(1076003)(25786009)(6246003)(54906003)(4744005)(7736002)(64756008)(66946007)(66476007)(66446008)(305945005)(6116002)(3846002)(4326008)(66556008)(6916009)(316002)(256004)(76176011)(71190400001)(71200400001)(14444005)(81166006)(81156014)(8676002)(486006)(50226002)(8936002)(66066001)(52116002)(26005)(6486002)(86362001)(186003)(102836004)(99286004)(386003)(6506007)(476003)(53936002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3735;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 87GBs5McoHxpm74jLkMppfYOeEx/uytH5n+39I/UK2XksAyWMSw/bneVLslL7if7c8tWhF1TRZ8iocJm13Gl13bkqFTu2jxcieZEm9c5EpMqA/uQGvQTjh+HAfjEQdUQ3sJubnWM/EtiRoozYG4dRJU9h75QzHw+nAcbRgASpuEoonmM8j0iINgr397eMKsiHvmbJLVZVpFmEHN1jAm44eK4EJfUYhKnqtrOlsthJMbQrp4QcM+KshTjNIYa9GWPBJLXHvt4K0yX1XoWUNK7HYkw22bilq58fUo2j15XgP+BqvKdVsK0+3PnYz4/swFYxXb/X5eAd70C1/FIjCmfpsfMdIQ4Y1Cumgi45F12cYIEjI3kLZvU8XQjvAEgcBPcI2EPyUYK2Pd7gH99814VrC4izWBW8ibpRdDLATpxJGk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E9DFA9C38EA3734C8B469BDB78ED2444@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2a0e52-40d8-4ed9-47c4-08d72b6930f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 03:38:29.0937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNmMag5bgmTKIftAJCC3+eRmuh/b3YKvU4ddUwZ3u5Ch15yjoCPyRYtq0GFaX2C5ZsG74RdiXkk3Vtcl6EZj3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3735
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, 27 Aug 2019 20:44:37 +0100 Mark Brown wrote:

> On Tue, Aug 27, 2019 at 08:45:33AM +0000, Jisheng Zhang wrote:
>=20
> This looks mostly good and I'll apply it, a couple of small
> things though:
>=20
> > @@ -0,0 +1,192 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * SY8824C regulator driver
> > + * =20
>=20
> Please send a patch which updates the entire comment block to be
> C++ style so it looks consistent.

Do you mean update the following style

A:

// SPDX-License-Identifier: GPL-2.0
/*
 * SY8824C regulator driver
 * ...


as B:

// SPDX-License-Identifier: GPL-2.0
// SY8824C regulator driver
// ...

I'm not sure which style is correct. But I see B is commonly used
in lots .c source files in other dirs, such as kernel/ mm/ etc.

Could you please clarify?

Thanks

>=20
> > +#define BUCK_EN		(1 << 7)
> > +#define MODE		(1 << 6)
> > + =20
>=20
> Please also add prefixes to these to namespace them, especially
> MODE is likely to collide with something later.

good idea. Will do in newer version
