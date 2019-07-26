Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ABBC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC7820651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="LsyTizCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfGZOoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:44:39 -0400
Received: from mail-eopbgr00047.outbound.protection.outlook.com ([40.107.0.47]:7916
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728150AbfGZOoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:44:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOLvlAD0ETpXy6YM+REkMgSz/INz5lbkz4x/B/bqTeVYZm02Pgg+Iz/UYFw4xC8hIYIAPUSq/3lnaAWZJv3FFQy84esyZ7OL5RVJ0o3R04Grm06tGorH/ilP5qUnsEWe/vLQ4pcIOe9V1bDqVAQa4fcRyXyoOnMcb2jZZkM0p+agaeGTz8vNVhPjJ9gnjTz0FyGssJYWh8z3A61AjAQbGYyH79V7eLdNGzvaOXW6MXSpgpcrdCL/ZO2GPgfjwW1Gpikvfkg02HxmG61ONhDtfbLCKe3E5gcqGQOtt7/Gn1SRPp7bbjCw5hArQ9jSQoQ/ekO5l3llPFHuEkDhsl3wtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZM2MtZbFBkhaAysQmO2cHFKeTB76YhUEauzP6usF4g=;
 b=K4r1BYrZOYD2XuyLfBt1P6dnj1LJ2rLlWvlY0j355j67kgms0ui49M9C0aocinPgZuoJszfBigzZAnBb3QTZtqggwfJXRRrVmNSbMxLRvIQGaQLYB7ChUeNV8sWxFlaYs+ygCmsbViIA6oBlQzY/XGQl50WbpaXlh4VjR4szM07tYjKtqNt0Gc3jaGVYbANFhTPZe1qIQewHf5M97cWTjaShOC5jXR/4HVJQ2nRX6gYfLdLNGGf1TwEn0+fibHiN+Z0BtL69/GyTSl/yM8jHEPXS0CR31tRrxOCyQDVNGV7SCuGAsCOn/Qs0Tl2bwqKkFwVa6usEAOSIXNka09F95w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZM2MtZbFBkhaAysQmO2cHFKeTB76YhUEauzP6usF4g=;
 b=LsyTizCZve8hWjctPJgTrCY8J4t2GGS9uTL2QXDycyEVHQLUStbCngXMS1vgr/mfPlKhMp/yM+Zc7s7iEfoGZbGtJNfrJFl46KCxv7+udEvmr5k7RbXY4vapULfpAgz9+1pYaMs/NIi4fWjKzXawMsUeRykCYKQjUy1Q+LYWKe8=
Received: from VI1PR08MB3696.eurprd08.prod.outlook.com (20.178.13.156) by
 VI1PR08MB3725.eurprd08.prod.outlook.com (20.178.14.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Fri, 26 Jul 2019 14:44:31 +0000
Received: from VI1PR08MB3696.eurprd08.prod.outlook.com
 ([fe80::6d04:e478:d795:5d80]) by VI1PR08MB3696.eurprd08.prod.outlook.com
 ([fe80::6d04:e478:d795:5d80%4]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 14:44:31 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Skips the invalid writeback job
Thread-Topic: [PATCH] drm/komeda: Skips the invalid writeback job
Thread-Index: AQHVQ4nw7K9FV7USuUuF4ik2yHSO+qbc9HAAgAAFvAA=
Date:   Fri, 26 Jul 2019 14:44:30 +0000
Message-ID: <20190726144428.tfwoaniidijchblt@DESKTOP-E1NTVVP.localdomain>
References: <1564128758-23553-1-git-send-email-lowry.li@arm.com>
 <20190726142356.GI15868@phenom.ffwll.local>
In-Reply-To: <20190726142356.GI15868@phenom.ffwll.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::17) To VI1PR08MB3696.eurprd08.prod.outlook.com
 (2603:10a6:803:b6::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba656020-a4f5-47ac-8058-08d711d7c442
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3725;
x-ms-traffictypediagnostic: VI1PR08MB3725:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR08MB3725AA26134A81CCB958A566F0C00@VI1PR08MB3725.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(40434004)(189003)(199004)(5660300002)(587094005)(229853002)(66066001)(68736007)(1076003)(476003)(26005)(2906002)(6116002)(9686003)(6306002)(5024004)(256004)(76176011)(53936002)(86362001)(14444005)(6636002)(3846002)(478600001)(14454004)(8936002)(44832011)(6506007)(11346002)(25786009)(6486002)(446003)(386003)(8676002)(966005)(53386004)(7736002)(66556008)(66476007)(64756008)(81156014)(81166006)(66446008)(186003)(486006)(66946007)(6436002)(71190400001)(71200400001)(316002)(2201001)(6246003)(2501003)(110136005)(3716004)(99286004)(52116002)(58126008)(305945005)(102836004)(6512007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3725;H:VI1PR08MB3696.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2xyYifqKZQrA6PZ1mrbQzyBCnxfWm8DUClfZWdD06kZeoFW4OIDv1Pw6jzaC16EyJ0Pbw/RjvnC4QAD4IfzYBCQPgub2oXiU9Shfcsr1M39a7al0MntQvTxjdV3RFKNFAU7V/tP/fhyhoMb4DirVMG79X2P7pX/qfYETiGNnl1lYb+sJ72iNQ4tGUcdcsbauHtnFpRfP+m+Mh229Ml/KbqhPpHwfOjsy5Edl66Qjkcm3BxWmIoPL3alHXMYO+D7Snh8EGxLn6k2A/GhGAHvmXzk1okDbsB504QMmpXbEVmX5ow4ZjIJ5ulyC/UDqWdK+l4yFv4uvwi++ImGBWNLQy9nYymivNpJVN9uozqTp16YPD+JvKX4QxCYCRpqXOOqIxLjyO3RdvO7RWi+9cpuQkRldFQxGLAbD+8PkIS8RHuU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5471A259FEDA3A498B8E46BC98059A51@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba656020-a4f5-47ac-8058-08d711d7c442
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 14:44:30.8575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Brian.Starkey@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 04:23:56PM +0200, Daniel Vetter wrote:
> On Fri, Jul 26, 2019 at 08:13:00AM +0000, Lowry Li (Arm Technology China)=
 wrote:
> > Current DRM-CORE accepts the writeback_job with a empty fb, but that
> > is an invalid job for HW, so need to skip it when commit it to HW.
> >
> > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
>
> Hm, this sounds a bit like an oversight in core writeback code? Not sure
> how this can even happen, setting up a writeback job without an fb sounds
> a bit like a bug to me at least ...
>
> If we don't have a good reason for why other hw needs to accept this, the=
n
> imo this needs to be rejected in shared code. For consistent behaviour
> across all writeback supporting drivers.
> -Daniel

I think it's only this way to simplify the drm_writeback_set_fb()
implementation in the case where the property is set more than once in
the same commit (to something valid, and then 0).

The core could indeed handle it - drm_writeback_set_fb() would check
fb. If it's NULL and there's no writeback job, then it can just early
return. If it's NULL and there's already a writeback job then it
should drop the reference on the existing fb and free that job.

Could lead to the job getting alloc/freed multiple times if userspace
is insane, but meh.

-Brian

>
> > ---
> >  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c         | 2 +-
> >  drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c | 9 ++++++++-
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_crtc.c
> > index 2fed1f6..372e99a 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > @@ -265,7 +265,7 @@ void komeda_crtc_handle_event(struct komeda_crtc *k=
crtc,
> >  komeda_pipeline_update(slave, old->state);
> >
> >  conn_st =3D wb_conn ? wb_conn->base.base.state : NULL;
> > -if (conn_st && conn_st->writeback_job)
> > +if (conn_st && conn_st->writeback_job && conn_st->writeback_job->fb)
> >  drm_writeback_queue_job(&wb_conn->base, conn_st);
> >
> >  /* step 2: notify the HW to kickoff the update */
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > index 9787745..8e2ef63 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > @@ -52,9 +52,16 @@
> >  struct komeda_data_flow_cfg dflow;
> >  int err;
> >
> > -if (!writeback_job || !writeback_job->fb)
> > +if (!writeback_job)
> >  return 0;
> >
> > +if (!writeback_job->fb) {
> > +if (writeback_job->out_fence)
> > +DRM_DEBUG_ATOMIC("Out fence required on a invalid writeback job.\n");
> > +
> > +return writeback_job->out_fence ? -EINVAL : 0;
> > +}
> > +
> >  if (!crtc_st->active) {
> >  DRM_DEBUG_ATOMIC("Cannot write the composition result out on a inactiv=
e CRTC.\n");
> >  return -EINVAL;
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
