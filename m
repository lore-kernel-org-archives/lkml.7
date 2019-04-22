Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40690C10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 03:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E8720859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 03:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tu9Pq/7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfDVDPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 23:15:49 -0400
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]:19779
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726108AbfDVDPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 23:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkMgGk+A9DdfNZmfLS/vdkCr8u4npk0R0N/pwBlC0+Q=;
 b=Tu9Pq/7dK0NF+HOtkJKs6fLIM2AZVV3P+GI8Ol1HE3+lCWjch2Lneyfcdn/5Tr/vUpTxnpB5bEhJDBdmPspMOYx4hpsAHDcKqdTDgBhAzK3lu8EU7RT5sKD44UfE1l0DvJJLYKYhBapOcbcl51bpiANLPJTLbJRpvMgB3WsfH+c=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6462.eurprd04.prod.outlook.com (20.179.233.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Mon, 22 Apr 2019 03:15:34 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 03:15:34 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
CC:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Topic: [PATCH V5 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Index: AdT4uaT1uq7daVZnSH2lrcd7+mk+DA==
Date:   Mon, 22 Apr 2019 03:15:34 +0000
Message-ID: <VE1PR04MB6479817B69545A662FFB43B4E3220@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7f6616b-dc19-4fc3-fdce-08d6c6d0c8eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6462;
x-ms-traffictypediagnostic: VE1PR04MB6462:
x-microsoft-antispam-prvs: <VE1PR04MB6462D816AB1104F113AB6109E3220@VE1PR04MB6462.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(73956011)(64756008)(66556008)(99286004)(66446008)(26005)(66476007)(186003)(4326008)(66066001)(76116006)(305945005)(74316002)(7696005)(86362001)(6506007)(14444005)(256004)(7736002)(97736004)(54906003)(66946007)(102836004)(2906002)(229853002)(25786009)(486006)(81166006)(14454004)(5660300002)(476003)(33656002)(6916009)(52536014)(55016002)(6246003)(9686003)(8676002)(68736007)(53936002)(8936002)(81156014)(71190400001)(1411001)(71200400001)(6116002)(3846002)(6436002)(498600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6462;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FFGFf7JsI7kfAlKlJRctKIUOPMS+R5wsFGzevqLcQcfizKgxdGGLQUgWz2ZSOxEm4PYEkzjKc3sSLu4qRzdHBv1BvSSPhPALyAQhvbTXylwQQ7Ay4trOyFAeLPstP0slPfP7bdwgqfmh4zxclyGacN193JqvhDoSkZumW9cbNQzMW4rFspb80nRk6h48g4txgL1mUY+t1SwW53RP8631j6qh3VeqRRoSJGB1ZJgmm3CHGdkys80wtqYfs7wkvp3jnn1Ixndi9xCouP9cFbgUtbopDiU7avLlnbKl9gJmMnvGPTBwlWs7YMSERBEJCB78LDmHSnGvm+F3WufAOHJkIPJT1XnF1UJPH/YYSKNgSxjQvL9aJh860HB/1yYTtNb5GEzFNbuUkoPCfUUhU9y2dpZp1mT+Z8LCFITWPlC+BFc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f6616b-dc19-4fc3-fdce-08d6c6d0c8eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 03:15:34.4269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

>=20
>=20
> On Mon, Apr 22, 2019 at 02:32:35AM +0000, S.j. Wang wrote:
> > When we want to support more sample rate, for example 12kHz/24kHz
> we
> > need update the process_option table, if we want to support more
> > sample rate next time, the table need to be updated again. which is
> > not flexible.
> >
> > We got a function fsl_asrc_sel_proc to replace the table, which can
> > give the pre-processing and post-processing options according to the
> > sample rate.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>=20
> A couple of more small comments.
>=20
> And please add this when you resend:
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
>=20
> > + * Unsupport cases: Tsout > 8.125 * Tsin, Tsout > 16.125 * Tsin
>=20
> Since we have a ratio validation somewhere else, it's okay to drop this l=
ine -
> - it may confuse people since the function no longer checks these
> unsupported cases.

I add this for may be in the future we forget the limitation. Just for a re=
minder.

Best regards
Wang shengjiu
>=20
> > +static int fsl_asrc_sel_proc(int inrate, int outrate,
>=20
> I think "void" type should be just fine as we made sure there is no
> unsupported cases running in this function.
