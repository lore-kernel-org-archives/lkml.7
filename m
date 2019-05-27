Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6504C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635DE20717
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cKsWPnZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfE0GvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:51:23 -0400
Received: from mail-eopbgr40058.outbound.protection.outlook.com ([40.107.4.58]:6916
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbfE0GvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdwnLJHAbS7rzk7YzRpuDpYzUw6eA1nfcGZlpicj1qA=;
 b=cKsWPnZLnRkhUe2JJ41QpAcL5YiNx3v7ByjfE395nzJoAVom7cgGSFZmY2iKzJBRdLDt7zlXcXszgzntRqvI49JX2nRHOfgVsmZHoBQm7SatciVABi8pUH0O90GZlH3lixL95q7l6BNScQcKAso2ZsAy8CUXXxaXgXVWWP/+ug4=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5024.eurprd08.prod.outlook.com (10.255.159.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Mon, 27 May 2019 06:51:18 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 06:51:18 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
CC:     Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "sean@poorly.run" <sean@poorly.run>
Subject: Re: [PATCH] drm/komeda: Added AFBC support for komeda driver
Thread-Topic: [PATCH] drm/komeda: Added AFBC support for komeda driver
Thread-Index: AQHU6tZrSfGY2oLen0KpP248EWVF9Q==
Date:   Mon, 27 May 2019 06:51:18 +0000
Message-ID: <20190527065110.GA29041@james-ThinkStation-P300>
References: <20190404110552.15778-1-james.qian.wang@arm.com>
 <20190516135748.GC1372@arm.com>
 <20190521084552.GA20625@james-ThinkStation-P300>
 <20190524111009.beddu67vvx66wvmk@DESKTOP-E1NTVVP.localdomain>
 <20190524121226.GD5942@intel.com>
In-Reply-To: <20190524121226.GD5942@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0061.apcprd03.prod.outlook.com
 (2603:1096:203:52::25) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52d9a7f6-b3cd-4487-f53e-08d6e26fb792
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VE1PR08MB5024;
x-ms-traffictypediagnostic: VE1PR08MB5024:
x-ms-exchange-purlcount: 1
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB502421FB0715ADCBA8A93A46B31D0@VE1PR08MB5024.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(136003)(346002)(396003)(376002)(39860400002)(199004)(189003)(6116002)(3846002)(81166006)(53936002)(8676002)(2906002)(256004)(81156014)(8936002)(6486002)(14454004)(9686003)(6916009)(6436002)(7736002)(6306002)(66066001)(71200400001)(71190400001)(6512007)(86362001)(4326008)(478600001)(305945005)(58126008)(6246003)(54906003)(966005)(68736007)(446003)(11346002)(476003)(316002)(186003)(33716001)(33656002)(14444005)(66446008)(64756008)(66556008)(66476007)(5660300002)(486006)(73956011)(229853002)(66946007)(66574012)(1076003)(52116002)(25786009)(99286004)(6506007)(386003)(76176011)(26005)(55236004)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5024;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F5km2PMt0UDlBTSblck5e5RWcRwEjLRBcalFyzh0LFuq4fLWZ8fEF4XnrCq7i4996wMH9yfue7erfP0gs4/72iYyOfjb19ahmQA0DCVOKJQIJXBKW0Y7JfBF6JCvvnQQVVoLuNF2iqhF0vKO+2nPfOJZh+vCqj0hu5FF1Yjx3FAASrf+Kt4LvRlKkt3bbEO+9SqCqbUK0by/lDo899JIULc8wYPaBdmRUVIGRqI6CqdrTGcwgwZuBOl1Wq3kO3JeJr5woPxQjz5c8V6Djxut18lth5+2dXB/6ggCjQeQP8BvbH1PxcxuwWhSiJorMYTW7t9Pv6q6lHHpm+bBYYIyF85IMb1TPqJ1E8NmK/uj0RDbKiFLOEEawjx9Ns6YPiaCE/gmEo24Kh5TgrTDbDvtzEY33s9pJj+gyqkzZp5P6WU=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C24BF3C00204B949903C6211330B1116@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d9a7f6-b3cd-4487-f53e-08d6e26fb792
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 06:51:18.4143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 03:12:26PM +0300, Ville Syrj=E4l=E4 wrote:
> On Fri, May 24, 2019 at 11:10:09AM +0000, Brian Starkey wrote:
> > Hi,
> >=20
> > On Tue, May 21, 2019 at 09:45:58AM +0100, james qian wang (Arm Technolo=
gy China) wrote:
> > > On Thu, May 16, 2019 at 09:57:49PM +0800, Ayan Halder wrote:
> > > > On Thu, Apr 04, 2019 at 12:06:14PM +0100, james qian wang (Arm Tech=
nology China) wrote:
> > > > > =20
> > > > > +static int
> > > > > +komeda_fb_afbc_size_check(struct komeda_fb *kfb, struct drm_file=
 *file,
> > > > > +			  const struct drm_mode_fb_cmd2 *mode_cmd)
> > > > > +{
> > > > > +	struct drm_framebuffer *fb =3D &kfb->base;
> > > > > +	const struct drm_format_info *info =3D fb->format;
> > > > > +	struct drm_gem_object *obj;
> > > > > +	u32 alignment_w =3D 0, alignment_h =3D 0, alignment_header;
> > > > > +	u32 n_blocks =3D 0, min_size =3D 0;
> > > > > +
> > > > > +	obj =3D drm_gem_object_lookup(file, mode_cmd->handles[0]);
> > > > > +	if (!obj) {
> > > > > +		DRM_DEBUG_KMS("Failed to lookup GEM object\n");
> > > > > +		return -ENOENT;
> > > > > +	}
> > > > > +
> > > > > +	switch (fb->modifier & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
> > > > > +	case AFBC_FORMAT_MOD_BLOCK_SIZE_32x8:
> > > > > +		alignment_w =3D 32;
> > > > > +		alignment_h =3D 8;
> > > > > +		break;
> > > > > +	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
> > > > > +		alignment_w =3D 16;
> > > > > +		alignment_h =3D 16;
> > > > > +		break;
> > > > > +	default:
> > > > Can we have something like a warn here ?
> > >=20
> > > will add a WARN here.
> > >=20
> >=20
> > I think it's better not to. fb->modifier comes from
> > userspace, so a malicious app could spam us with WARNs, effectively
> > dos-ing the system. -EINVAL should be sufficient.
>=20
> Should probably check that the entire modifier+format is
> actually valid. Otherwise you risk passing on a bogus
> modifier deeper into the driver which may trigger
> interesting bugs.
>=20
> Also theoretically (however unlikely) some broken userspace
> might start to depend on the ability to create framebuffers
> with crap modifiers, which could later break if you change
> the way you handle the modifiers. Then you're stuck between
> the rock and hard place because you can't break existing
> userspace but you still want to change the way modifiers
> are handled in the kernel.
>=20
> Best not give userspace too much rope IMO. Two ways to go about
> that:
> 1) drm_any_plane_has_format() (assumes your .format_mod_supported()
>    does its job properly)
> 2) roll your own=20
>=20
> --=20
> Ville Syrj=E4l=E4
> Intel

Hi Brian & Ville:

komed has a format+modifier check before the fb size check.
and for komeda_fb_create, the first step is do the format+modifier
check, the size check is the furthur check after the such format
valid check. and the detailed fb_create is like:

struct drm_framebuffer *
komeda_fb_create(struct drm_device *dev, struct drm_file *file,
		 const struct drm_mode_fb_cmd2 *mode_cmd)
{
        ...
        /* Step 1: format+modifier valid check, if it can not be support,
         * get_format_caps will return a NULL ptr.
         */
	kfb->format_caps =3D komeda_get_format_caps(&mdev->fmt_tbl,
						  mode_cmd->pixel_format,
						  mode_cmd->modifier[0]);
	if (!kfb->format_caps) {
		DRM_DEBUG_KMS("FMT %x is not supported.\n",
			      mode_cmd->pixel_format);
		kfree(kfb);
		return ERR_PTR(-EINVAL);
	}

	drm_helper_mode_fill_fb_struct(dev, &kfb->base, mode_cmd);

        /* step 2, do the size check */
	if (kfb->base.modifier)
		ret =3D komeda_fb_afbc_size_check(kfb, file, mode_cmd);
	else
		ret =3D komeda_fb_none_afbc_size_check(mdev, kfb, file, mode_cmd);
	if (ret < 0)
		goto err_cleanup;

        ...
}

So theoretically, the WARN in step2 is redundant if get_format_caps
function has no problem. :). the WARN here is only for reporting
the kernel BUG or code inconsitent with format caps check and the
fb size check. And I agree, basically it will not happene.
@Brian, I'm Ok to remove it. :)

@Ville:
Basically komeda follow the way-1, but a little improvement for
matching komeda's requirement. for komeda which will do two level's
format+modifier check.
1). In fb_create, A roughly check to see if the format+modifier can be
    supported by current HW.
2). In plane_atomic_check: to see if the format+modifier can be
    supported for a specific layer and with a specific configuration (ROT)

This is a format valid check example for plane_check.
https://patchwork.freedesktop.org/patch/301140/?series=3D59747&rev=3D2

James
