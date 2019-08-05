Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADADC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5A22147A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FRxVabZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfHEQyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:54:22 -0400
Received: from mail-eopbgr60041.outbound.protection.outlook.com ([40.107.6.41]:62721
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726779AbfHEQyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:54:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ocv617mF4PzX87i6b+4e2dWeibvb+atUZarieNm73yOD4DNO9mSd2Rsx9IWfOukpOWfQB4eM9UvAH0KMyCVB7AunQbuKTtHMo6eUMW37csvus6qjx6p8pi0UWDgvXTGIr4lWXh9hnjVVgN9hzS7prDw1mo6JGDEZnkPmLHjjKHLinA8P5MEgCCexF5pPUCcO4FaRUllg3vEL+/6nVDeZLlzjQBlfVvfxq61C+b9n8TWvd1zNwxPeJ5siw+dWbqITe8VOTNe9PF7m5et67Pj8aHQEGGhSw5sdG3kGQpAqusOamLg07lE4w15StryJ7B362zOTts0dXzD1okYRB1Cc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlktXrh+/Q1j9FjaqTiaUsPU2Wxglsi/48GC+rVk4/g=;
 b=aRw2pWZ3HuRufJufM3wENTBt8u9VTtLpCVSKvq+KPBzx4svWqM7HsAYTPAGljWouyIkGZrgzPmfANUAkAq0u+CXRqGttaoKcvkmMx+UlzYI6A/en8rxo8gE37J5/8U5n+Pxfduhw76mbCeLKl5HCyaNHB+Mi0h4JtunqxlYoNJk+1alG7a+0nQEZ1o/limcJ49GXHN+sV5WKSyESUHIpt2Uc64mH3OP2ZAIiQqKf32PMvh72dAeCphHU8MKdX6SkHSNIcP+XhZKeFpLzstU297w3jyuG1PsvpKlRJ6fWcsp6zvT/+K5ye6JJmnhR0vbbn5itywLFlYiWGgm3B3iVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlktXrh+/Q1j9FjaqTiaUsPU2Wxglsi/48GC+rVk4/g=;
 b=FRxVabZYdf3hOWTbtPn5N4R3X9en9Cwbaf0Dfr2hu8lOt1NJwYYm5vwL87uTWDBEOPKWk9XdbxRu28co7BiovEcZVAiESQrJ1J/n0TcaGZ2NWRDJ6NvOI2c/dYvwnVkdoQLi8kT/4HunjMvCKnvLXd0NLfyfjxxY6CYxzbP/VgI=
Received: from VI1PR08MB3696.eurprd08.prod.outlook.com (20.178.13.156) by
 VI1PR08MB3519.eurprd08.prod.outlook.com (20.177.61.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 16:54:15 +0000
Received: from VI1PR08MB3696.eurprd08.prod.outlook.com
 ([fe80::6d04:e478:d795:5d80]) by VI1PR08MB3696.eurprd08.prod.outlook.com
 ([fe80::6d04:e478:d795:5d80%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 16:54:15 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/crc-debugfs: Add notes about CRC<->commit
 interactions
Thread-Topic: [PATCH] drm/crc-debugfs: Add notes about CRC<->commit
 interactions
Thread-Index: AQHVS6AfVKCWuj8pSkiiGLREL8ZNOqbsvTSAgAAIXgA=
Date:   Mon, 5 Aug 2019 16:54:15 +0000
Message-ID: <20190805165414.nzlru7iiqiaepuuu@DESKTOP-E1NTVVP.localdomain>
References: <20190802140910.GN7444@phenom.ffwll.local>
 <20190805151143.12317-1-brian.starkey@arm.com>
 <20190805162417.GS7444@phenom.ffwll.local>
In-Reply-To: <20190805162417.GS7444@phenom.ffwll.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LNXP265CA0034.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::22) To VI1PR08MB3696.eurprd08.prod.outlook.com
 (2603:10a6:803:b6::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc573d91-c092-4bbb-e48f-08d719c58c8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3519;
x-ms-traffictypediagnostic: VI1PR08MB3519:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR08MB35190CD7E2DF2A42B54DEB1CF0DA0@VI1PR08MB3519.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(40434004)(189003)(199004)(68736007)(53936002)(66476007)(102836004)(76176011)(6506007)(2501003)(110136005)(587094005)(316002)(386003)(305945005)(186003)(66946007)(66556008)(6306002)(64756008)(52116002)(486006)(11346002)(256004)(99286004)(66066001)(14444005)(5024004)(9686003)(7736002)(14454004)(6486002)(8676002)(8936002)(229853002)(476003)(25786009)(446003)(58126008)(26005)(478600001)(2906002)(3846002)(81166006)(81156014)(53386004)(44832011)(6512007)(71200400001)(1076003)(86362001)(6116002)(5660300002)(71190400001)(966005)(6246003)(6436002)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3519;H:VI1PR08MB3696.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VZOnsHbp8iUcf34PXVOqMJlfk3sLCiAh0mBTZuBWd2baf8K72PLp+q2/tmoxjcpoQYiqBtzG3ZgO3BV3c6fEvTu/DCfjVI351L3q9GNFmlnvhyssghgSfMHpGefZEz1v+kt0G7K5HrGR1ql4SrFZJLAzL2f0I+poAV0fDyewliPW6uJcA0FIdTUwhh1i9KUQ7J8EGE03OiStqdX4GfRG/WKx5xUuWIicDHlS35KBafMTsbilNpbpqxqQ/FtwLWj5UaticIBHGtXJ94KWqpUEfwVYESIeN6zEucwYO3kMlv0bs2JWwAs47HMR3awDsgBlqrKv+qk50orx/FAy2N8RpOM6iG20FCo8Hkr8OULeeOiVWm46hYDg7aFEMzyEe7+ZftbTpwn+0RUv7JJm9mk5vto17MeYvS4/ikxCBa7TVuk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3B10D13FB2D00D4A8F777D7F42D4B14F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc573d91-c092-4bbb-e48f-08d719c58c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 16:54:15.5613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Brian.Starkey@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3519
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 06:24:17PM +0200, Daniel Vetter wrote:
> On Mon, Aug 05, 2019 at 04:11:43PM +0100, Brian Starkey wrote:
> > CRC generation can be impacted by commits coming from userspace, and
> > enabling CRC generation may itself trigger a commit. Add notes about
> > this to the kerneldoc.
> >
> > Signed-off-by: Brian Starkey <brian.starkey@arm.com>
> > ---
> >
> > I might have got the wrong end of the stick, but this is what I
> > understood from what you said.
> >
> > Cheers,
> > -Brian
> >
> >  drivers/gpu/drm/drm_debugfs_crc.c | 15 +++++++++++----
> >  include/drm/drm_crtc.h            |  3 +++
> >  2 files changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_de=
bugfs_crc.c
> > index 7ca486d750e9..1dff956bcc74 100644
> > --- a/drivers/gpu/drm/drm_debugfs_crc.c
> > +++ b/drivers/gpu/drm/drm_debugfs_crc.c
> > @@ -65,10 +65,17 @@
> >   * it submits. In this general case, the maximum userspace can do is t=
o compare
> >   * the reported CRCs of frames that should have the same contents.
> >   *
> > - * On the driver side the implementation effort is minimal, drivers on=
ly need to
> > - * implement &drm_crtc_funcs.set_crc_source. The debugfs files are aut=
omatically
> > - * set up if that vfunc is set. CRC samples need to be captured in the=
 driver by
> > - * calling drm_crtc_add_crc_entry().
> > + * On the driver side the implementation effort is minimal, drivers on=
ly need
> > + * to implement &drm_crtc_funcs.set_crc_source. The debugfs files are
> > + * automatically set up if that vfunc is set. CRC samples need to be c=
aptured
> > + * in the driver by calling drm_crtc_add_crc_entry(). Depending on the=
 driver
> > + * and HW requirements, &drm_crtc_funcs.set_crc_source may result in a=
 commit
> > + * (even a full modeset).
> > + *
> > + * It's also possible that a "normal" commit via DRM_IOCTL_MODE_ATOMIC=
 or the
> > + * legacy paths may interfere with CRC generation. So, in the general =
case,
> > + * userspace can't rely on the values in crtc-N/crc/data being valid
> > + * across a commit.
>
> It's not just the values, but the generation itself might get disabled
> (e.g. on i915 if you select "auto" on some chips you get the DP port
> sampling point, but for HDMI mode you get a different sampling ploint, an=
d
> if you get the wrong one there won't be any crc for you). Also it's not
> just any atomic commit, only the ones with ALLOW_MODESET.

Is the meaning of ALLOW_MODESET actually defined somewhere then? I
thought it was broadly speaking "anything that would cause a flicker
on the output" - but that needn't be the same set of things that break
CRC generation.

>
> Maybe something like the below text:
>
> "Please note that an atomic modeset commit with the
> DRM_MODE_ATOMIC_ALLOW_MODESET, or a call to the legacy SETCRTR ioctl
> (which amounts to the same), can destry the CRC setup due to hardware
> requirements. This results in inconsistent CRC values or not even any CRC
> values generated. Generic userspace therefore needs to re-setup the CRC
> after each such modeset."
>
> >
> >  static int crc_control_show(struct seq_file *m, void *data)
> > diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> > index 128d8b210621..0f7ea094a900 100644
> > --- a/include/drm/drm_crtc.h
> > +++ b/include/drm/drm_crtc.h
> > @@ -756,6 +756,8 @@ struct drm_crtc_funcs {
> >   * provided from the configured source. Drivers must accept an "auto"
> >   * source name that will select a default source for this CRTC.
> >   *
> > + * This may trigger a commit if necessary, to enable CRC generation.
>
> I'd clarify this as "atomic modeset commit" just to be sure.

Ack.

Thanks,
-Brian

>
> With these two comments addressed somehow:
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
>
> > + *
> >   * Note that "auto" can depend upon the current modeset configuration,
> >   * e.g. it could pick an encoder or output specific CRC sampling point=
.
> >   *
> > @@ -767,6 +769,7 @@ struct drm_crtc_funcs {
> >   * 0 on success or a negative error code on failure.
> >   */
> >  int (*set_crc_source)(struct drm_crtc *crtc, const char *source);
> > +
> >  /**
> >   * @verify_crc_source:
> >   *
> > --
> > 2.17.1
> >
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
