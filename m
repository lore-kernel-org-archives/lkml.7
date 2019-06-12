Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A9EC31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B537206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="G2qneKM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406364AbfFLC1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 22:27:13 -0400
Received: from mail-eopbgr150077.outbound.protection.outlook.com ([40.107.15.77]:53315
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405046AbfFLC1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 22:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NExc82WAxKU7syWnbhUDt3M9YAckfz/ZGNyCsX7spE=;
 b=G2qneKM2UXm4SRPRSVvez4Hfcogn3QjAB45jRY8EdixXw1JQTTlCjXMNBPpuf9H8Je5xEhLe8DxMUzrfPKucOEqnQ45RBEHx3J5/DvXgkLvtTMyhdV+ykyY0BKIGEiI46BIbwcmGttw/sOPtSWOHCQsoN3oxiPhpQfcQfPtayJY=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4863.eurprd08.prod.outlook.com (10.255.113.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Wed, 12 Jun 2019 02:26:26 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1943.026; Wed, 12 Jun 2019
 02:26:26 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH v2 2/2] drm/komeda: Adds komeda_kms_drop_master
Thread-Topic: [PATCH v2 2/2] drm/komeda: Adds komeda_kms_drop_master
Thread-Index: AQHVIEa9rsSYE44q6kqYpL+RGmPd3A==
Date:   Wed, 12 Jun 2019 02:26:24 +0000
Message-ID: <20190612022617.GA8595@james-ThinkStation-P300>
References: <1560251589-31827-1-git-send-email-lowry.li@arm.com>
 <1560251589-31827-3-git-send-email-lowry.li@arm.com>
 <20190611123038.GC2458@phenom.ffwll.local>
In-Reply-To: <20190611123038.GC2458@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6852c4ff-562b-4285-933c-08d6eedd5d47
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4863;
x-ms-traffictypediagnostic: VE1PR08MB4863:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VE1PR08MB4863101E88BD1799B569DF52B3EC0@VE1PR08MB4863.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:63;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(376002)(346002)(396003)(39860400002)(136003)(40434004)(199004)(189003)(53386004)(7736002)(14444005)(66066001)(68736007)(478600001)(6636002)(5024004)(8936002)(256004)(305945005)(33716001)(6246003)(64756008)(66946007)(33656002)(81156014)(229853002)(81166006)(8676002)(587094005)(25786009)(73956011)(1076003)(66556008)(66446008)(66476007)(11346002)(186003)(58126008)(26005)(316002)(99286004)(446003)(486006)(5660300002)(110136005)(2201001)(476003)(14454004)(76176011)(53936002)(6506007)(55236004)(386003)(6306002)(6436002)(2501003)(6486002)(2906002)(9686003)(6512007)(966005)(52116002)(3846002)(71190400001)(6116002)(102836004)(86362001)(71200400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4863;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kdlQt8CSxwdpEBxtzuKUwH3zZ6n8zcANwdjACxWgpAAvtOze6lLY0jrNse8oJfiiQVYI6Mz1JF8epvfzygaqwEUNSQ+By4VQ71OFtwA5RIGR/EY77PHarXx4hnxvPkW6oQiOteXTKznYrsEzcApebQLldpGjff0SaX3CkR/HakRisWYWwDi2eii26RLp2gfrdmheHi/q9WQz1O/bOiHgOskr0gahNKVOABIBTXLlBfAO1odiZnKpVHypHUM4716dpjqiudfMBSSq+z8qdrV07b1CiiqnBKDkibxrblOK6wjDFJaXXF+qjMdNljk1KKl+fnPY0UeiAUShc0t5I93vjGlxGi2BZh/wAoKmAN/rxng7efYiHgkgnZWQvvbyJVQLHVOClomdmsjvbz9hNK6jTS8l/gNuAhC/nwsQOULwAF0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FA39B6F5C45EBF4BA1044F4DE5F7C6EF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6852c4ff-562b-4285-933c-08d6eedd5d47
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 02:26:26.0217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4863
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 02:30:38PM +0200, Daniel Vetter wrote:
> On Tue, Jun 11, 2019 at 11:13:45AM +0000, Lowry Li (Arm Technology China)=
 wrote:
> > From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
> >
> > The komeda internal resources (pipelines) are shared between crtcs,
> > and resources release by disable_crtc. This commit is working for once
> > user forgot disabling crtc like app quit abnomally, and then the
> > resources can not be used by another crtc. Adds drop_master to
> > shutdown the device and make sure all the komeda resources have been
> > released and can be used for the next usage.
> >
> > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > ---
> >  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_kms.c
> > index 8543860..647bce5 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > @@ -54,11 +54,24 @@ static irqreturn_t komeda_kms_irq_handler(int irq, =
void *data)
> >  return status;
> >  }
> >
> > +/* Komeda internal resources (pipelines) are shared between crtcs, and=
 resources
> > + * are released by disable_crtc. But if user forget disabling crtc lik=
e app quit
> > + * abnormally, the resources can not be used by another crtc.
> > + * Use drop_master to shutdown the device and make sure all the komeda=
 resources
> > + * have been released, and can be used for the next usage.
> > + */
>
> No. If we want this, we need to implement this across drivers, not with
> per-vendor hacks.
>
> The kerneldoc should have been a solid hint: "Only used by vmwgfx."
> -Daniel

Hi Daniel:
This drop_master is really what we want, can we update the doc and
add komeda as a user of this hacks like "used by vmwfgx and komeda",
or maybe directly promote this per-vendor hacks as an optional chip
function ?

James

> > +static void komeda_kms_drop_master(struct drm_device *dev,
> > +   struct drm_file *file_priv)
> > +{
> > +drm_atomic_helper_shutdown(dev);
> > +}
> > +
> >  static struct drm_driver komeda_kms_driver =3D {
> >  .driver_features =3D DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC |
> >     DRIVER_PRIME | DRIVER_HAVE_IRQ,
> >  .lastclose=3D drm_fb_helper_lastclose,
> >  .irq_handler=3D komeda_kms_irq_handler,
> > +.master_drop=3D komeda_kms_drop_master,
> >  .gem_free_object_unlocked=3D drm_gem_cma_free_object,
> >  .gem_vm_ops=3D &drm_gem_cma_vm_ops,
> >  .dumb_create=3D komeda_gem_cma_dumb_create,
> > --
> > 1.9.1
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
