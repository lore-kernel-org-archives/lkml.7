Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEB7C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701DA21773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="R4TmkzJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390819AbfEXLKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:10:13 -0400
Received: from mail-eopbgr40058.outbound.protection.outlook.com ([40.107.4.58]:15683
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390535AbfEXLKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHGGkRxKq55STwUJXDbQ6Lye9Zkh2OIt5S2/wfjfKC8=;
 b=R4TmkzJRfqLnHe0EUuHVc65Vu+Rkrm5QZokr+MNQcMSTZTgTWME1S+HrhfLNLROcYXOlrm4H068XfQdyON2OcmCEhDr9bs47Wz6FTVJb3UgfBrqttYSFp2OzbCYIJdx+ycTDQCflecRn5u8PSd73cGsYe4O9zR5I0TWYnycX2Q4=
Received: from AM6PR08MB4038.eurprd08.prod.outlook.com (20.179.1.84) by
 AM6PR08MB3912.eurprd08.prod.outlook.com (20.178.91.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Fri, 24 May 2019 11:10:09 +0000
Received: from AM6PR08MB4038.eurprd08.prod.outlook.com
 ([fe80::397e:708d:dcfd:a30f]) by AM6PR08MB4038.eurprd08.prod.outlook.com
 ([fe80::397e:708d:dcfd:a30f%3]) with mapi id 15.20.1922.019; Fri, 24 May 2019
 11:10:09 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/komeda: Added AFBC support for komeda driver
Thread-Topic: [PATCH] drm/komeda: Added AFBC support for komeda driver
Thread-Index: AQHU6tZrSfGY2oLen0KpP248EWVF9aZuCQMAgAeEiACABN9HgA==
Date:   Fri, 24 May 2019 11:10:09 +0000
Message-ID: <20190524111009.beddu67vvx66wvmk@DESKTOP-E1NTVVP.localdomain>
References: <20190404110552.15778-1-james.qian.wang@arm.com>
 <20190516135748.GC1372@arm.com>
 <20190521084552.GA20625@james-ThinkStation-P300>
In-Reply-To: <20190521084552.GA20625@james-ThinkStation-P300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::17) To AM6PR08MB4038.eurprd08.prod.outlook.com
 (2603:10a6:20b:a6::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1729f098-5715-4a7d-996e-08d6e038625b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR08MB3912;
x-ms-traffictypediagnostic: AM6PR08MB3912:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM6PR08MB39126C0041D667A162361C60F0020@AM6PR08MB3912.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0047BC5ADE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(52116002)(99286004)(76176011)(25786009)(2906002)(102836004)(386003)(316002)(256004)(446003)(44832011)(11346002)(486006)(476003)(66446008)(64756008)(1076003)(66946007)(66066001)(66556008)(66476007)(71200400001)(71190400001)(53936002)(73956011)(6486002)(9686003)(6436002)(72206003)(6506007)(6636002)(14454004)(478600001)(86362001)(8676002)(305945005)(81156014)(6512007)(229853002)(7736002)(5660300002)(6862004)(4326008)(26005)(6246003)(54906003)(186003)(58126008)(81166006)(8936002)(68736007)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3912;H:AM6PR08MB4038.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yXkg6tYTNKZLumKq2LN9tBXeiBdd694fuEB2a31+hGCUvASyDAtcspeQU/IAS0tX0r9Ty8tmYkR080KRXRBiSiMaQrIDMv0WkMsgDwEHca9ahR+EC5NoYOOSX6DST5d1tB84aNYDFUFuX+JnNP+n3qx1qop7kH8SgAcMdnR9naq20HRtla5UIDInA1q3+yPdGyPrjD28ZIIymIFhfrZSGySPUbonp/gP+0cJqul4KpjFOcY6HvFplwacrotjrN8UmO5ficiXajxHC2U0ySVPlpZRpqY8SQ/ho2yYX0dvT86aXYOPM47rZE4Z2bizjvyeU1ZiNB/639oQHKc+7dU7MeONy9EXvYAWowKN/yrQuDIMPQ00xeEVxPyHzUN0vscELi6YZUtq50y+LnA4tGLVQzsjoc83oZnr7ZCCixucVDE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <464F27F342C0B34FA294379AE634D9A1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1729f098-5715-4a7d-996e-08d6e038625b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2019 11:10:09.5502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Brian.Starkey@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3912
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 21, 2019 at 09:45:58AM +0100, james qian wang (Arm Technology C=
hina) wrote:
> On Thu, May 16, 2019 at 09:57:49PM +0800, Ayan Halder wrote:
> > On Thu, Apr 04, 2019 at 12:06:14PM +0100, james qian wang (Arm Technolo=
gy China) wrote:
> > > =20
> > > +static int
> > > +komeda_fb_afbc_size_check(struct komeda_fb *kfb, struct drm_file *fi=
le,
> > > +			  const struct drm_mode_fb_cmd2 *mode_cmd)
> > > +{
> > > +	struct drm_framebuffer *fb =3D &kfb->base;
> > > +	const struct drm_format_info *info =3D fb->format;
> > > +	struct drm_gem_object *obj;
> > > +	u32 alignment_w =3D 0, alignment_h =3D 0, alignment_header;
> > > +	u32 n_blocks =3D 0, min_size =3D 0;
> > > +
> > > +	obj =3D drm_gem_object_lookup(file, mode_cmd->handles[0]);
> > > +	if (!obj) {
> > > +		DRM_DEBUG_KMS("Failed to lookup GEM object\n");
> > > +		return -ENOENT;
> > > +	}
> > > +
> > > +	switch (fb->modifier & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
> > > +	case AFBC_FORMAT_MOD_BLOCK_SIZE_32x8:
> > > +		alignment_w =3D 32;
> > > +		alignment_h =3D 8;
> > > +		break;
> > > +	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
> > > +		alignment_w =3D 16;
> > > +		alignment_h =3D 16;
> > > +		break;
> > > +	default:
> > Can we have something like a warn here ?
>=20
> will add a WARN here.
>=20

I think it's better not to. fb->modifier comes from
userspace, so a malicious app could spam us with WARNs, effectively
dos-ing the system. -EINVAL should be sufficient.

Thanks,
-Brian

