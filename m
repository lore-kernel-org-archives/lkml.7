Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D91C04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438382173B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H59jEkUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfE2Bdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 21:33:50 -0400
Received: from mail-eopbgr20056.outbound.protection.outlook.com ([40.107.2.56]:1799
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbfE2Bdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 21:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAdTFE2BcM/u6p+SAKc3drgKKpM1CxyEM9SNfpu85SE=;
 b=H59jEkUaos9lRHf1rnVHadx/jWpDWqxL5e69NWgIPAp0o94hZjgS9i7CQHCrHeGWYnc+aIfid3Wd5eW5XgjonrKJkg96DezjZblAFN/BFTC8nIuxg2hgOIO2YQUdX0X7S8HGFTZr3TkYqpUscJs4n3eUzy56f1MJdUQMN3MtL+Y=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB3920.eurprd04.prod.outlook.com (52.134.17.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Wed, 29 May 2019 01:33:46 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::4c3e:205:bec9:54ef]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::4c3e:205:bec9:54ef%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 01:33:46 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "david@lechnology.com" <david@lechnology.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Robby Cai <robby.cai@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: Issue: regmap: use debugfs even when no device
Thread-Topic: [EXT] Re: Issue: regmap: use debugfs even when no device
Thread-Index: AdUU+qx1aGJHwDdCQOqTU9L/+rTCagAXkpgAABimScA=
Date:   Wed, 29 May 2019 01:33:46 +0000
Message-ID: <VI1PR0402MB3600AD425469BAF9BCC5CC2FFF1F0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <VI1PR0402MB3600F0FB1A031BE502588C93FF1E0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <20190528132632.GJ2456@sirena.org.uk>
In-Reply-To: <20190528132632.GJ2456@sirena.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f62cf8c-9d63-42b7-bf17-08d6e3d5b18e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0402MB3920;
x-ms-traffictypediagnostic: VI1PR0402MB3920:
x-microsoft-antispam-prvs: <VI1PR0402MB3920A853CAB30AEC2D5647E3FF1F0@VI1PR0402MB3920.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(189003)(64756008)(5660300002)(14454004)(71200400001)(229853002)(9686003)(6436002)(71190400001)(54906003)(316002)(66476007)(55016002)(14444005)(256004)(478600001)(66946007)(66556008)(4744005)(76116006)(73956011)(53936002)(66446008)(33656002)(26005)(76176011)(6506007)(3846002)(6116002)(7696005)(8676002)(305945005)(74316002)(6246003)(86362001)(66066001)(81156014)(8936002)(81166006)(186003)(25786009)(4326008)(476003)(446003)(486006)(68736007)(11346002)(99286004)(52536014)(7736002)(2906002)(6916009)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3920;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mpzObb8xiEsmoBdlu7Mgg8yY9yB8DmLj3wp7xA3gdrShFX4J8kzeb0MFnt4hAODP4fEuE5hM2oK0qW9C+RZ5ui1lyIs8Nnl+Ze2fXc+uV46KY+QAhhZK+kmBIxDRk64i4Og/eonk2eJaRUxyiDsOXAyhdvOsYdop7/0vNNfLxLQa5kLmhYTi3LIIW3UJ9TM2fnkU6yEn72YZr/lRbKzx8cT9bJQgkV7Pb8WVEwPztyjShMEUFJUNWC2aolYvJjVZM7p2ieurUGurscYYjgb+NYMHZOVhwGkevwn2Pe3KzX0ZKS0QuGEL39AnAIIT1jcQV6QCMI08vz4B0lF87miOURUT7NrQ3W4paVpXhpZ7ZQzv53t4lVmvPNV73ZpiBLRMi/34d3odCbjXoCgrd6A4oFeeDKPngYbUW4Cy8tWmWbM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f62cf8c-9d63-42b7-bf17-08d6e3d5b18e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 01:33:46.5455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fugang.duan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3920
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mark Brown <broonie@kernel.org> Sent: Tuesday, May 28, 2019 9:27 PM
> On Tue, May 28, 2019 at 02:20:15AM +0000, Andy Duan wrote:
>=20
> > So on i.MX8MM/8QM/8QXP platforms, we catch the issue that user dump
> > regmap registers without power cause system hang.
> > Maybe revert the patch is more reasonable ?
>=20
> This is an issue with or without a device - you can have the same issue w=
ith
> devices that are powered off.  Typically where power is dynamic the drive=
r
> will use a register cache so the registers are always available.

Correct, regmap without device also has issue when power if off, because re=
gmap
doesn't implement runtime pm for the device, but maybe device driver implem=
ent
the runtime pm for the device.=20

So regmap how to manage the clock and power when access registers by debugf=
s ?

Andy
