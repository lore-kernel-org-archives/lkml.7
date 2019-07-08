Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336D2C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 05:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA7B20659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 05:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="9gkKnKHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfGHFys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 01:54:48 -0400
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:58691
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727448AbfGHFys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 01:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn0FHAAGeyrfyuH6ItbW+MBpVfF0cTy/MH2QCiCo3aM=;
 b=9gkKnKHFha5taGEm/fHxAiFuqVPkbsPByvP9WU0uauZniE5PcFFbuu3G2/hKPV5PgzQHqf3+9efIcX7hROp1zic31idFHpzymmilTGEZhQhuPcXAiNBvIM/jik33xnx2mjx36P5jaki4N6lUhIKKLYbjdrFnVEWAs5P90WaDG64=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5102.eurprd08.prod.outlook.com (20.179.30.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Mon, 8 Jul 2019 05:54:43 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Mon, 8 Jul 2019
 05:54:43 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>, nd <nd@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ben Davis <Ben.Davis@arm.com>
Subject: Re: [PATCH 1/2] drm/komeda: Disable slave pipeline support
Thread-Topic: [PATCH 1/2] drm/komeda: Disable slave pipeline support
Thread-Index: AQHVMyb5WQQBB7gGc06vpLjh/Rmuxqa78rAAgARKPgA=
Date:   Mon, 8 Jul 2019 05:54:43 +0000
Message-ID: <20190708055434.GA3841@jamwan02-TSP300>
References: <20190705114357.17403-1-james.qian.wang@arm.com>
 <20190705122348.GN15868@phenom.ffwll.local>
In-Reply-To: <20190705122348.GN15868@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:203:52::20) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25e0adea-56a4-4fcb-f09b-08d70368c653
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5102;
x-ms-traffictypediagnostic: VE1PR08MB5102:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VE1PR08MB51025AE248BA1C64DC8F2554B3F60@VE1PR08MB5102.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(346002)(376002)(366004)(39850400004)(396003)(199004)(189003)(40434004)(6306002)(6636002)(6436002)(8936002)(81166006)(8676002)(81156014)(6512007)(2906002)(9686003)(53936002)(316002)(305945005)(68736007)(58126008)(53386004)(110136005)(6486002)(71200400001)(71190400001)(6246003)(229853002)(3846002)(6116002)(256004)(14444005)(5024004)(7736002)(966005)(1076003)(478600001)(476003)(486006)(33716001)(14454004)(446003)(25786009)(11346002)(102836004)(55236004)(26005)(2201001)(6506007)(86362001)(386003)(66066001)(33656002)(587094005)(186003)(76176011)(64756008)(99286004)(5660300002)(66446008)(66476007)(73956011)(66556008)(66946007)(2501003)(52116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5102;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4mdlr1pgRmvyr0IwaV0ciP1mOXrvFxuRyHKkEhbQcATIlGUfCmXQjt3igKdZZ0UY6o3UtiNFcJyTncTEydDfRb4CD5Cdbh9sjuF1Zfg7wcQgnjZsCHkVQ78GavcvSNXWn6VLD287RA02BKkRSHmgXh2A+hb4y+htQlEln29TufuIqg5fPJ5DcWZLrtV31ftskG8Q4evKLL1i/Wq7m7LA5D8k7HSO3kFjY+A6L7Kk5Hgb6ICjexzuhHT7RUl8kyKq+0jfbcCd+axA+mQiITIUdG4uD5ctwfNZqbdUn3OhiIue8fFq0DKsJNTT4S2gu88TdoeZCig4VbOcSdeI4mD1G0nNqiTz3R5EYRbS05EOcTRZzmwfC3jsbAMh2tnY2DdxvK6L374kRycD37THLM6wq8/rwJ3VQZR9Cy9bMTQUUDE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <97D9F1E29801684D905FF917FFED7923@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e0adea-56a4-4fcb-f09b-08d70368c653
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 05:54:43.8564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 02:23:48PM +0200, Daniel Vetter wrote:
> On Fri, Jul 05, 2019 at 11:44:16AM +0000, james qian wang (Arm Technology=
 China) wrote:
> > Since the property slave_planes have been removed, to avoid the resourc=
e
> > assignment problem in user disable slave pipeline support temporarily.
> >
> > Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@=
arm.com>
>
> I guess the way you have to enumerate the planes listing the slave planes
> wont just automatically work in any fashion and force a lot more fallback=
s
> to primary plane only. At least until virtualization of plane hw is done.
> So makes sense to outright disable all the slave plane stuff for now. And
> I think it's ok to keep all the code still, we'll use it again.
>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> > ---
> >  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_crtc.c
> > index f4400788ab94..8ee879ee3ddc 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > @@ -481,7 +481,7 @@ int komeda_kms_setup_crtcs(struct komeda_kms_dev *k=
ms,
> >  master =3D mdev->pipelines[i];
> >
> >  crtc->master =3D master;
> > -crtc->slave  =3D komeda_pipeline_get_slave(master);
>
> This might cause an unused function warning, might need to annotate it
> with __unused.
> -Daniel

If so, I'd like to drop this change.

Since even with this change, that still can not pass all our tests.
we have to update the user tests or the komeda implementation.
Once we finished the updating, we still need to revert this change.
So maybe just drop it is more better.

Thanks
James

> > +crtc->slave  =3D NULL;
> >
> >  if (crtc->slave)
> >  sprintf(str, "pipe-%d", crtc->slave->id);
> > --
> > 2.20.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
