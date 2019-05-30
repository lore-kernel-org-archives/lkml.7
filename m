Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9975FC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721C925F32
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OLoT7VqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389107AbfE3E4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:56:30 -0400
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:47622
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728004AbfE3E41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 00:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSzyyruOCcrBNP2EXS3w6rvMjqQoBKBQ6AwYS4O2+DY=;
 b=OLoT7VqGtrC8urw6f25CnHV7VaQcx9PsJrAQPzr3XhPJimSzSYuQ3aupIWfZUU+e6P2BbrJNpyx8J2EIvRaaOQOdSwsUvCXnSxdqwIqK/xwyMR+yk6M7JO7PkoXj6qjE08j2AqIyK8um8VVIaZvaiAHFRb8IdeKb4tLzDmI/8NQ=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB3837.eurprd04.prod.outlook.com (52.134.16.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Thu, 30 May 2019 04:56:23 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::4c3e:205:bec9:54ef]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::4c3e:205:bec9:54ef%4]) with mapi id 15.20.1943.016; Thu, 30 May 2019
 04:56:23 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "david@lechnology.com" <david@lechnology.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Robby Cai <robby.cai@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: Issue: regmap: use debugfs even when no device
Thread-Topic: [EXT] Re: Issue: regmap: use debugfs even when no device
Thread-Index: AdUU+qx1aGJHwDdCQOqTU9L/+rTCagAXkpgAABimScAAFRReAAAk/Onw
Date:   Thu, 30 May 2019 04:56:22 +0000
Message-ID: <VI1PR0402MB36007B2A40344C69BACA13B7FF180@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <VI1PR0402MB3600F0FB1A031BE502588C93FF1E0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <20190528132632.GJ2456@sirena.org.uk>
 <VI1PR0402MB3600AD425469BAF9BCC5CC2FFF1F0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <20190529111554.GO2456@sirena.org.uk>
In-Reply-To: <20190529111554.GO2456@sirena.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6e80a2d-6326-4cc2-eb27-08d6e4bb29d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3837;
x-ms-traffictypediagnostic: VI1PR0402MB3837:
x-microsoft-antispam-prvs: <VI1PR0402MB3837DE634B447691735F97B6FF180@VI1PR0402MB3837.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(396003)(366004)(189003)(199004)(6916009)(71200400001)(486006)(64756008)(76116006)(81166006)(476003)(73956011)(2906002)(446003)(66556008)(14444005)(66066001)(6506007)(26005)(74316002)(66946007)(11346002)(76176011)(66476007)(53546011)(7696005)(66446008)(99286004)(102836004)(68736007)(316002)(229853002)(305945005)(6116002)(3846002)(6246003)(52536014)(54906003)(53936002)(8936002)(8676002)(186003)(9686003)(33656002)(4744005)(55016002)(5660300002)(81156014)(7736002)(256004)(6436002)(4326008)(478600001)(14454004)(25786009)(71190400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3837;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s6e0qcxWtLOfri2MrA36WOURgZAClFoCDkf2/jUkDN8Lte44Cy1ynznV/Af14YAsAPlFp83gIOx25G2tshqVSlCorE1oQwJQDmzIA83oKTSTI4Ee/CpLkYGriWMVbeChy+Uw+ChxG6uhjNalDlgNmQaJBYnKzTAyLhMpDq2R+on3GyjTcArHpAiL44q7XY/SKm/hA+iohVKam6X4YKwC+9lUsldrOA4W2I98AweIMv9Iyq/lFmYjOXATH3uXW8zqX5DW/mRkjaNtXODOHQkVOZQGRm4jcYue+QoX3/Ely+GCMV7DRO0nrPJHUxJCqYa/yz70VOiqRwc4/7IYsobWITbhM37GuQs4Cur6WHzujhBKdWvSOmORow1kPxCNhfI/1yly/goQrllMEdqDw8mwxhfzWhUfSn4W//Hc2dNYpoQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e80a2d-6326-4cc2-eb27-08d6e4bb29d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 04:56:22.8003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fugang.duan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org> Sent: Wednesday, May 29, 2019 7:16 PM
> To: Andy Duan <fugang.duan@nxp.com>
> Cc: david@lechnology.com; rafael@kernel.org; Robby Cai
> <robby.cai@nxp.com>; gregkh@linuxfoundation.org; linux-kernel
> <linux-kernel@vger.kernel.org>
> Subject: Re: [EXT] Re: Issue: regmap: use debugfs even when no device
>=20
> On Wed, May 29, 2019 at 01:33:46AM +0000, Andy Duan wrote:
>=20
> > Correct, regmap without device also has issue when power if off,
> > because regmap doesn't implement runtime pm for the device, but maybe
> > device driver implement the runtime pm for the device.
>=20
> > So regmap how to manage the clock and power when access registers by
> debugfs ?
>=20
> Like I say the basic recommendation is to use a cache.

Got it, thanks.=20
