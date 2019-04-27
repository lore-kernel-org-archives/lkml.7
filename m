Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C62C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6102064A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YS5I/PQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfD0UCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 16:02:50 -0400
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:39493
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbfD0UCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 16:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7ixNb3cEMOv5V6/O/AYuHD6yqE8cuO6dlEpzMcuIbE=;
 b=YS5I/PQHNThq6HMdoDzEdofb9ZFLOq2c7NbJjCvEpzdsv0idVtPUwy7CzdggYSa1/joOwSB8vfUQFfd+A5Zl194SioBed8qUOQy1ZJ4x/d+rjDpQ8DuQmBVaP0pAwv5P5+0CopPvLaSkh+FMMBqQtflNnXrpJBFWqQ+zp8FFw2c=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6019.eurprd04.prod.outlook.com (20.179.32.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.14; Sat, 27 Apr 2019 20:02:45 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::880d:a6d1:c29c:8560]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::880d:a6d1:c29c:8560%3]) with mapi id 15.20.1835.015; Sat, 27 Apr 2019
 20:02:45 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [RFC 00/19] clk: imx: Switch the imx6 and imx7 to
 clk_hw based API
Thread-Topic: [EXT] Re: [RFC 00/19] clk: imx: Switch the imx6 and imx7 to
 clk_hw based API
Thread-Index: AQHU4MUXcPbU/vcAG02E7jK3YSvT1aYX1gUAgB459YCAFGt6gIAAnYaAgAIjjYCAA2nsAA==
Date:   Sat, 27 Apr 2019 20:02:45 +0000
Message-ID: <20190427193814.xs6tm3nzxc4ju6so@fsr-ub1664-175>
References: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com>
 <CAOMZO5DWpu9irOWR3rux-vV1sihfsDkTs5SJ7XXy8MgRBCd-Gw@mail.gmail.com>
 <155493360763.20095.6174028293897341109@swboyd.mtv.corp.google.com>
 <155605619927.15276.90300312265075245@swboyd.mtv.corp.google.com>
 <20190424071347.73xbynv5jqipqkgx@fsr-ub1664-175>
 <155620761362.15276.4197988939287759775@swboyd.mtv.corp.google.com>
In-Reply-To: <155620761362.15276.4197988939287759775@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91d87a5b-67f4-4969-094a-08d6cb4b50c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6019;
x-ms-traffictypediagnostic: AM0PR04MB6019:
x-microsoft-antispam-prvs: <AM0PR04MB6019B02E5B1486CB1D098CEFF63F0@AM0PR04MB6019.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0020414413
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(6436002)(66066001)(5660300002)(8676002)(81156014)(229853002)(81166006)(99286004)(97736004)(6486002)(33716001)(76176011)(316002)(68736007)(6512007)(8936002)(9686003)(3846002)(6916009)(6116002)(91956017)(66476007)(66556008)(64756008)(66446008)(76116006)(86362001)(54906003)(73956011)(66946007)(53546011)(102836004)(93886005)(53936002)(71190400001)(71200400001)(186003)(6506007)(305945005)(7736002)(256004)(14444005)(2906002)(478600001)(44832011)(11346002)(446003)(26005)(6246003)(1076003)(25786009)(476003)(486006)(14454004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6019;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g7ILKgzhc0PabUtA8l7EtLfAWXyC1Ox++vu+UB0eTc8fBIZtQ8kv6Jc5S1dljfQ1aJ6f87mrQRj/eOdQ7ed58Hu2s/vPZMjo6bA0oCeXLj16apt0467GGzwHByK9FWfsxnx4aOPRCfElrC25BH2net2k8L79K/M+1Y82N99ETCCQrmOGw0xd9h32uB23jMqQUGy4t669Z91KVqilStorfenVieCiIwdoVTdsF+MILJ2p2v3plxsapcz1dRzaVljPWTX1NiX0o6a3X1jAEGZqYulBCu+VKycIJ2mwh0So9hIxuhy9aMVMkj1KLRItBmdSbVoK6/1bo+VBpmgv+sJXaVBxFw58HbhqDowCeOQcL0AunDhhtLWprNwYPcCzjy3kLZfe4kWp+ZNrNkwedNw7jy3egw7vNm0ltfDJmxtIcI0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <786A2DACB3811D4F8FEF29EA5CE0661D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d87a5b-67f4-4969-094a-08d6cb4b50c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2019 20:02:45.6262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-04-25 08:53:33, Stephen Boyd wrote:
> Caution: EXT Email
>=20
> Quoting Abel Vesa (2019-04-24 00:13:48)
> >
> > Can you please be more specific and point out exactly which one isn't ?
>=20
> Is this a question for me?
>=20

Nevermind. I'll send another version in the following days.

> >
> > >
> > > FYI, I'm dropping this from my review queue under the assumption it w=
ill
> > > be sent again. Also, it would be nice to not have the wrappers at all=
 in
> > > the next series so that everything is clk_hw based instead of clk bas=
ed.
> > > Otherwise, it looks good to me and I'd like to see this work complete=
d.
> > > Thanks!
> > >
> >
> > I'll try to resend this before the end of next week.
> >
> > As for the wrappers, they need to stay in until the last user of the cl=
k
> > based API is switched to clk_hw based. That means all the remaining imx
> > platforms (1 through 5, and then 8). I chosed to do the imx6 and imx7
> > first because these are easier to find. Once this is in, I'll move on
> > with the imx8 and then the imx1 through imx5 (which are harder to find
> > nowadays).
> >
>=20
> Ok. I'm not thrilled to keep around legacy code because nobody is
> testing out new kernels on these devices. If we can, we should try to
> delete old drivers that don't get used anymore, but if we can't then
> we should be able to modify and compile those drivers and wait for the
> bug reports to come in if something is broken.
>=20

Yes, as I said, I'll put together some other patchseries for the older imx
platforms (1 through 5) once this one gets in.

> =
