Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FB5C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818C820673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r1BRrmFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbfIXJGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:06:01 -0400
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:7101
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729579AbfIXJGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:06:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuPzQnrXDFNzSX+qRrCS+v/977IWlLZdBbrth6ZO6EKC+2Sy92tgXpnMxmbI9MDPw8sTyvlzS70QR/x/c+q44q0s0z7I0BYdacm0a1r1izEQT0bBtyn/Oa1IWFe7gcOAAsVV94Cl8ui9Qq+7HRaWgzY+KhOU0fMlDFCFHqFvSvT646YoUIG8DOXAX4/Tw6ab1JIzHOFxpCRBGYdGuY0SCF8T/T8+XYCYTmdnE8sfYcu4ylxRSKXXUzkavaRBG4j02QpOQAG5Vt5JoD00pkTOWPICXw+1Ovm0Tn4tjKgDNTvFUyVkK4NrjlsegYd0Ttz8/5KpsjFUsj9BkArFGVfk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjhwr+PkNSPrN9sjAprXRxlLuF0aqKCvoWqPXO/V+UU=;
 b=OpiiUHS38/cKm7QnzcgzHrGtCg20sMh6RTICUqsOK00Fzp2QpranvvCPGOVt8zHCojEjuOLXH6VfyT0YFt1QI7UXqv5y7AH807bszpMJCDjby9pUucl3xVHV384Rtyi5YSUDiQX8uEGoAxx6L15nW+4eWJUQ2B5EGMEvdwT8yU061IANoBaxToT95phquzLqCYJ22KFs0fev9xHXU18Pt2pgvMaK9425d/Jk4V8+Sym/CXrboHscummmhvM2bCq372YntcNDl2lcAgVJjkZBwaAlIWY8eyK+mxlVpO3P8CE3W4+fF9C62UtVgCrbAMxhW0Dwga3Z+bm+5Lv4SBmQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjhwr+PkNSPrN9sjAprXRxlLuF0aqKCvoWqPXO/V+UU=;
 b=r1BRrmFY6lNCsH4fszehdp4RCEFNSQGab8eGxqdLYZ8uG1EUt7t5zVukRHEWG6IRIYsE2gnuqmJBdx9caG+b4YcvL4/qVt3TcOH2s2HUNEbFx8tKJI8DPSOGPHq99I0jTiWxYCeXiM85E27PG1OU7p6wKi+5rOHcG8EQKTOoS0g=
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com (20.179.254.214) by
 AM0PR04MB6291.eurprd04.prod.outlook.com (20.179.33.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 09:05:53 +0000
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::9974:f659:52e:40b6]) by AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::9974:f659:52e:40b6%4]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 09:05:53 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
CC:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH V3 4/4] ASoC: fsl_asrc: Fix error with S24_3LE format
 bitstream in i.MX8
Thread-Topic: [PATCH V3 4/4] ASoC: fsl_asrc: Fix error with S24_3LE format
 bitstream in i.MX8
Thread-Index: AdVytw3fGmshbTVBRMKzM2C+xgJn/w==
Date:   Tue, 24 Sep 2019 09:05:52 +0000
Message-ID: <AM0PR04MB646870B1F74898098D4018C9E3840@AM0PR04MB6468.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e0a19b3-7055-4888-eafe-08d740ce66e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6291;
x-ms-traffictypediagnostic: AM0PR04MB6291:
x-microsoft-antispam-prvs: <AM0PR04MB6291B028BBFA6EA7FB2A8881E3840@AM0PR04MB6291.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(199004)(189003)(14454004)(4326008)(478600001)(7416002)(229853002)(6506007)(6916009)(33656002)(14444005)(99286004)(25786009)(7696005)(8936002)(186003)(26005)(86362001)(54906003)(5660300002)(66946007)(66446008)(316002)(102836004)(76116006)(1411001)(66476007)(66556008)(64756008)(6116002)(476003)(55016002)(9686003)(74316002)(8676002)(486006)(256004)(66066001)(6436002)(71200400001)(305945005)(71190400001)(6246003)(52536014)(2906002)(81166006)(3846002)(7736002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6291;H:AM0PR04MB6468.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Av2t4GrgiCIW0XuY7qkvOSsvHzvij3fu4CwoHx4xj0zZHofOC8PzWL53rpXqFDicYm+RSYPT6qylzm+n7D4XEiIGJP9PlJ+nPNTB+x09dQZyUkvMk0GYc2neyyLfyDLtyzqGCH5QzUiE9mhoDIYdIIj0G6UMWlsvJCE7cyFnhQhOa+P5SqNw83UasK9oh+DHTbhGQ6hDeKjwnlv5/hg1d211bh4RArPqDqwxB9ucY2EjU6OVZq3JqG6iJ9uAUIDgBWzH/i5xj6m1wyM746saR4xmkcgHekIrvykjKIW/S6Qa+qsMB0sAmeDRy9+nkD72d7T4JjZlWDeu1PBw0/v5SJy8bYgUvtVh+6ztoJugOR5wq6PYUKyocy4HlHt9tvCQddO/cbucCu0+mJBr+DhWRDCOcJ3xDvRUzD5u17SSgIg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0a19b3-7055-4888-eafe-08d740ce66e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 09:05:52.9416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e60udUmqaRwDPhEXiwqb4yCKEaQF7prHyyQ38F0Rgj3IC6Qj7uERf98Er47ThZ2T2rE7C3yjMfBhVcdzAmyX6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6291
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
>=20
> One issue for error-out and some nit-pickings inline. Thanks.
>=20
> On Thu, Sep 19, 2019 at 08:11:42PM +0800, Shengjiu Wang wrote:
> > There is error "aplay: pcm_write:2023: write error: Input/output error"
> > on i.MX8QM/i.MX8QXP platform for S24_3LE format.
> >
> > In i.MX8QM/i.MX8QXP, the DMA is EDMA, which don't support 24bit
> > sample, but we didn't add any constraint, that cause issues.
> >
> > So we need to query the caps of dma, then update the hw parameters
> > according to the caps.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_asrc.c     |  4 +--
> >  sound/soc/fsl/fsl_asrc.h     |  3 +++
> >  sound/soc/fsl/fsl_asrc_dma.c | 52
> > +++++++++++++++++++++++++++++++-----
> >  3 files changed, 50 insertions(+), 9 deletions(-)
> >
> > @@ -276,6 +274,11 @@ static int fsl_asrc_dma_startup(struct
> snd_pcm_substream *substream)
> >       struct device *dev =3D component->dev;
> >       struct fsl_asrc *asrc_priv =3D dev_get_drvdata(dev);
> >       struct fsl_asrc_pair *pair;
> > +     bool tx =3D substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK;
> > +     u8 dir =3D tx ? OUT : IN;
> > +     struct dma_chan *tmp_chan;
> > +     struct snd_dmaengine_dai_dma_data *dma_data;
>=20
> Nit: would it be possible to reorganize these a bit? Usually we put struc=
t
> things together unless there is a dependency, similar to
> fsl_asrc_dma_hw_params().
>=20
> > @@ -285,9 +288,44 @@ static int fsl_asrc_dma_startup(struct
> > snd_pcm_substream *substream)
> >
> >       runtime->private_data =3D pair;
> >
> > +     /* Request a temp pair, which is release in the end */
>=20
> Nit: "which will be released later" or "and will release it later"? And c=
ould
> we use a work like "dummy"? Or at least I would love to see the comments
> explaining the parameter "1"
> in the function call below.
>=20
> > +     ret =3D fsl_asrc_request_pair(1, pair);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to request asrc pair\n");
> > +             return ret;
> > +     }
> > +
> > +     tmp_chan =3D fsl_asrc_get_dma_channel(pair, dir);
> > +     if (!tmp_chan) {
> > +             dev_err(dev, "can't get dma channel\n");
>=20
> Could we align with other error messages using "failed to"?
>=20
> > +     ret =3D snd_soc_set_runtime_hwparams(substream,
> &snd_imx_hardware);
> > +     if (ret)
> > +             return ret;
> > +
> [...]
> > +     dma_release_channel(tmp_chan);
> > +     fsl_asrc_release_pair(pair);
>=20
> I think we need an "out:" here for those error-out routines to goto.
> Otherwise, it'd be a pair leak?
>=20
> > +
>=20
> Could we drop this? There is a blank line below already :)
>=20

Will update them.

Best regards
Wang Shengjiu
