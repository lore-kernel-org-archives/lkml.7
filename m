Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BA6C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E675420835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UgVyVAjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfDXHNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:13:52 -0400
Received: from mail-eopbgr150078.outbound.protection.outlook.com ([40.107.15.78]:40423
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbfDXHNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBcaGwEAJk/BWY5w9l6JssJBo/tPOMKKsLgLBBILaRI=;
 b=UgVyVAjbE1SVdlix6PapfDCIy3z+YYjXd98W2zUdXj1kVq33Tppvib6/4Ml5u3Sy4bhhOPXSt4VJU/0645CPhKP7Fqd0azZazYp2NSvWb8GqYq5i1CWWDhKwWDo1brEFSJaVHua93XurGlVYMqtw81TzZlh/9O8xQPwz+8Bp1Ys=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6323.eurprd04.prod.outlook.com (20.179.36.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 24 Apr 2019 07:13:49 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::880d:a6d1:c29c:8560]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::880d:a6d1:c29c:8560%3]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 07:13:48 +0000
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
Thread-Index: AQHU4MUXcPbU/vcAG02E7jK3YSvT1aYX1gUAgB459YCAFGt6gIAAnYaA
Date:   Wed, 24 Apr 2019 07:13:48 +0000
Message-ID: <20190424071347.73xbynv5jqipqkgx@fsr-ub1664-175>
References: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com>
 <CAOMZO5DWpu9irOWR3rux-vV1sihfsDkTs5SJ7XXy8MgRBCd-Gw@mail.gmail.com>
 <155493360763.20095.6174028293897341109@swboyd.mtv.corp.google.com>
 <155605619927.15276.90300312265075245@swboyd.mtv.corp.google.com>
In-Reply-To: <155605619927.15276.90300312265075245@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5d98508-3c27-4a0c-b4bf-08d6c88465d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB6323;
x-ms-traffictypediagnostic: AM0PR04MB6323:
x-microsoft-antispam-prvs: <AM0PR04MB63238C60ACB0EB80B55692CDF63C0@AM0PR04MB6323.eurprd04.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(396003)(366004)(376002)(39860400002)(346002)(189003)(199004)(316002)(14454004)(97736004)(6246003)(5660300002)(6916009)(6486002)(229853002)(71200400001)(305945005)(478600001)(53936002)(7736002)(6436002)(2906002)(4326008)(71190400001)(54906003)(99286004)(66066001)(73956011)(44832011)(446003)(33716001)(486006)(76176011)(8676002)(476003)(11346002)(66946007)(102836004)(186003)(6506007)(68736007)(1076003)(53546011)(26005)(66446008)(66556008)(66476007)(64756008)(93886005)(91956017)(5024004)(14444005)(25786009)(6512007)(9686003)(3846002)(256004)(86362001)(76116006)(6116002)(8936002)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6323;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /Gr2hzgoH00809P6f1mXg3h6y82Aes0AIfvTQEBWJGBAcajXAzPb68DDHNVNpn15GUok+VH1gfPUnBR7X7AaxdRzIJWBuvnZXMmnl9RMaGYmmkX/0K8G5EPlgKoytutf0O5eCKPe0OQyS7x2e7kk+6o7vRstgzmkHpyJMF4Z8vEucCTghnQtoSXDnFBse2FqvPsYmbao4G0LOc/GVQRA4a0KmqiS2P6gEtofElL+rsSp66A+g+dVBPDgDddGBl7O7eQ5h6STUtP8yXJswPk9Rhm1OJWVUCNtdi6/h8PZ0PXmDpIYeGWz3JtxJT5LVkfeJG1P+Rpq/gAESl/xFLis+W30bLhupH8F69a6l7n3rpD8+KxkCvCI/++sMV6bJEe0HfQErUpaJlOJOjoOP0t83uT/lq7tc0/j/ytZ4mAEJ2o=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <514CC0D793A5544D9E3E93AD49311BD8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d98508-3c27-4a0c-b4bf-08d6c88465d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 07:13:48.7938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-04-23 14:49:59, Stephen Boyd wrote:
> WARNING: This email was created outside of NXP. DO NOT CLICK links or att=
achments unless you recognize the sender and know the content is safe.
>=20
>=20
>=20
> Quoting Stephen Boyd (2019-04-10 15:00:07)
> > Quoting Fabio Estevam (2019-03-22 09:24:54)
> > > Hi Abel,
> > >
> > > On Fri, Mar 22, 2019 at 12:37 PM Abel Vesa <abel.vesa@nxp.com> wrote:
> > > >
> > > > This work is part of the effort of switching the entire imx clock d=
rivers
> > > > towards clk_hw based API. In order to do that, we have to keep the =
old
> > >
> > > Maybe I missed some earlier discussions on this topic, but let me ask
> > > a fundamental question first: what is the motivation for this API
> > > change?
> > >
> > > I could not find the reasoning inside the series.
> >
> > The reasoning should be added to the series, but I would like to see cl=
k
> > providers only deal with clk_hw structures and not with clk structures.
> > This clearly divides the line between clk consumers and clk providers s=
o
> > that we know if clk providers are using the clk API themselves. That's
> > why I introduced clk_hw_register() in the first place.
> >

Sorry for the late response.

AFAICT, all the providers that are used in imx6 and imx7 are using
(with this patchseries) the clk_hw_register (unless I'm missing something h=
ere).

Can you please be more specific and point out exactly which one isn't ?

>=20
> FYI, I'm dropping this from my review queue under the assumption it will
> be sent again. Also, it would be nice to not have the wrappers at all in
> the next series so that everything is clk_hw based instead of clk based.
> Otherwise, it looks good to me and I'd like to see this work completed.
> Thanks!
>=20

I'll try to resend this before the end of next week.

As for the wrappers, they need to stay in until the last user of the clk
based API is switched to clk_hw based. That means all the remaining imx
platforms (1 through 5, and then 8). I chosed to do the imx6 and imx7
first because these are easier to find. Once this is in, I'll move on
with the imx8 and then the imx1 through imx5 (which are harder to find
nowadays).

Thanks for helping with the review on this.=
