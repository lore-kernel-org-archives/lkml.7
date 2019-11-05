Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060F6CA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 03:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C845A21882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 03:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cgafbbDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbfKED0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 22:26:00 -0500
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:18142
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729836AbfKED0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 22:26:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvZf6bGYw6ulHvs8p1WfHyPRsGcmNGh2D7oq6omOGAy6Hsyv/omEJd09ir7zZY6oJ9W8VgioxNVqrYU9sFnosDco5IQsvqK58N3ovYhScwQMs7c6LKeGt22803lQHafqsWAlJkcMtTTMR2EkoTJMg1icwQrcXdftOq2Mu3znZloJpMdL7TWS4o+E6HsqDujKLIhZuKVpozISstI05GykPehVeY6xr66hb4oHFB/gQ2kfNVmBpDk6wvWDHN8eIv86urEIFinfP0/orUfm/hv5TZZZBAQWi7W1kXctowuOnpSUX58TXS5fktxeQjcg96t1RmNHOY18F6c3a13619+cBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cE/9ZX6doIXfJknt8eLoV2lxEYLAvKzrh6gsZ4vS5U=;
 b=OxC7VqNaI0a/gIZAldQBMredHNMwa8VxMH6pijcJK2qIPUi46m1hYc8OBLQ4hoicD5u/a+WfthG9XkTdJ/1hvpirm13YJeQ4b3+KPT1uYv7bIWmCoo2hMeIvNt6Fnw8FSvh8xN/R52S7fsEA2gX6CwnWLErDBF5RUxYvRFm4f7kJSeAfQL9kaijYjKYBS8Rar5VWtReJAy6CYOrJsVxgs+BfIh0z4R2ZFx5H/GvX7Gh1PV8+eTyLgNdksfZ1JGdMC0Vmc9HG5b4n3pmC+r5QwR02PPDyH48zmqBtQInYluouz7U0Q4UhxLq0b+2Qamvizqw2uJbpPopxvmDUqUE5Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cE/9ZX6doIXfJknt8eLoV2lxEYLAvKzrh6gsZ4vS5U=;
 b=cgafbbDR/1+IP/ocBL7OmGwsJAWTt0X3p8HhFCvJ+OLCquFfoCDS7e1kvEhVBBybXV9iGOZsuuACyG57i/Cm7xtG88Lkt0hyicEXyY0WWhgWfTlwEFZL0oOSfDkEt+fAF1MpbYmN5IY+oUdtZF4yCrhoPqLMOLNpAakHmmB4Ktg=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.232.225) by
 VE1PR04MB6656.eurprd04.prod.outlook.com (20.179.235.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 03:25:56 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::9c38:e113:f0b4:f9]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::9c38:e113:f0b4:f9%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 03:25:56 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8524: Add support S32_LE
Thread-Topic: [PATCH] ASoC: wm8524: Add support S32_LE
Thread-Index: AdWTh/O/b1+PZUkZSV2ZVOBuQ71qsg==
Date:   Tue, 5 Nov 2019 03:25:55 +0000
Message-ID: <VE1PR04MB64790EF282B41CB04EA6707DE37E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf241ae6-5e7c-45f2-dd23-08d7619fdec4
x-ms-traffictypediagnostic: VE1PR04MB6656:
x-microsoft-antispam-prvs: <VE1PR04MB66560503D3D814CB286AB995E37E0@VE1PR04MB6656.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(81166006)(66066001)(2906002)(26005)(6436002)(478600001)(7696005)(6916009)(102836004)(55016002)(316002)(54906003)(14454004)(229853002)(71190400001)(71200400001)(6246003)(52536014)(8676002)(256004)(5660300002)(486006)(305945005)(81156014)(6506007)(7416002)(3846002)(186003)(25786009)(86362001)(7736002)(74316002)(8936002)(9686003)(64756008)(76116006)(476003)(66476007)(66556008)(33656002)(66446008)(6116002)(99286004)(66946007)(14444005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6656;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9RswhFnNOYcIKjBMlpB+E/XCKq+ykOvt7Qbze/Q49PTTe1JJunrSfpq2pjYNjwseKMseBWcdIuNZEvouGedRdvUAAvdu3aA8rNulUZ4IOoqLgS1DOUinEYjD+/e6+05PEGFEQ0nwI5nw5+Xb6rknS8s2uEGUnLrmjqqTjHyiAsenW5aUYuiFHhLAz5tFMH2bvT6k8KuY029jRSOn5Sm+fzOTGCpPmme3ZpfK0v7UxPXW0Bi9/YWT2AFbUAl0wKUuCV/Txe+h8j1yoljG8Jwq+NzjlGgulPv+hYHf5uC08DZuBbweJ3Fx3rmZhXId8IHyhRIO3Kjf234W42szurwCad4uRujUvcIq1Vq4F278Q620Xwewd4vBq2FFPiCj/tEW5to7gKrQYWan0+DVdRW7mauXARi3N3xw00tQuLVHwJLsQtIoGvK6t4mkpNo79BNz
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf241ae6-5e7c-45f2-dd23-08d7619fdec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 03:25:55.9893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fneqdZ5AeIGwTzCz+f43f4oPX+YFQX/u2SPHYzgIhnZ94IwlHURtmY9UxQ6MtheEjD5IC+Y5IPlIAZYFRd83WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6656
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> On Fri, Nov 01, 2019 at 06:34:54AM +0000, S.j. Wang wrote:
> > Allow 32bit sample with this codec.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/codecs/wm8524.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/codecs/wm8524.c b/sound/soc/codecs/wm8524.c
> > index 91e3d1570c45..4e9ab542f648 100644
> > --- a/sound/soc/codecs/wm8524.c
> > +++ b/sound/soc/codecs/wm8524.c
> > @@ -159,7 +159,9 @@ static int wm8524_mute_stream(struct
> snd_soc_dai
> > *dai, int mute, int stream)
> >
> >  #define WM8524_RATES SNDRV_PCM_RATE_8000_192000
> >
> > -#define WM8524_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |
> > SNDRV_PCM_FMTBIT_S24_LE)
> > +#define WM8524_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
> > +                     SNDRV_PCM_FMTBIT_S24_LE |\
> > +                     SNDRV_PCM_FMTBIT_S32_LE)
> >
>=20
> The device doesn't actually support 32bit though, I guess it will ignore =
the
> extra LSBs so it should work. But is that really supporting 32 bit?
>=20
I also think it may ignore the extra LSBs just as you said, but don't reall=
y
Support 32bit.  This change is to make driver accept S32_LE format.

Best regards
Wang shengjiu

