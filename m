Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB3AC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D7F20722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="oScgG/Iu";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="oScgG/Iu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfKZPzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:55:24 -0500
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:40040
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728218AbfKZPzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 10:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBb9avuoa4Kg0rTlZNVeuyqM8pKEjrFj5UnjOtQhfzc=;
 b=oScgG/IuHe8Z3PTA0ro1EdqWnae6QdorxgVSrIae5jaLdSt4fHPrz7oZ22xrcMjQBSt9XUWtiNuZhtvKdldFi9uWvN6zXH4VdFcHUenMcT/wyzGflZxm6ujCUcJWOkj1iA7K4M/eaFnfpXpGssartnklQqQgU4J3JOp9brHPNyk=
Received: from VI1PR08CA0088.eurprd08.prod.outlook.com (2603:10a6:800:d3::14)
 by AM0PR08MB3393.eurprd08.prod.outlook.com (2603:10a6:208:e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16; Tue, 26 Nov
 2019 15:55:15 +0000
Received: from DB5EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by VI1PR08CA0088.outlook.office365.com
 (2603:10a6:800:d3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Tue, 26 Nov 2019 15:55:14 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT027.mail.protection.outlook.com (10.152.20.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 15:55:14 +0000
Received: ("Tessian outbound 712c40e503a7:v33"); Tue, 26 Nov 2019 15:55:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bbab109c25cdd2e1
X-CR-MTA-TID: 64aa7808
Received: from cbdcfc79fc0a.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DBFDCEC5-ECC3-4359-A5F1-B0B0204F0192.1;
        Tue, 26 Nov 2019 15:55:08 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2057.outbound.protection.outlook.com [104.47.10.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cbdcfc79fc0a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 15:55:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hijr9BiQBd30cS5BmYKrz8lT4fTfLjU8gXKOPNNyF3pXLx7Ju1q/NCRoNHsA3W2Ml7b4UjajZILjs5FJol6GoDJecaeFYSfMSfNAbbqwre6NY3UJjNKa05jz/7gR/FwrfSBKYz+Wd1Ubhx7Zm+8RKmLaDUv3AQdoaQjvVJgm3o+lsX5sFu6i85RJNA9S4h4vBVMZGFFp3tyvRQl16ounpAUkfPST9QDnuoAvoNbTyUXDpY/TGznlTUckL9l2T4XzNDhZzfeyXdeYr2iZpV5GDNAFuMYILVLQ7KNuccoZXm6vxZY+7atUHWxtCaUPWIqc/+7JVaxDk9SWUVe2YtsW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBb9avuoa4Kg0rTlZNVeuyqM8pKEjrFj5UnjOtQhfzc=;
 b=iQ+QuCj9Tupw86fwTz3yLjtb81t/Jn7yVms4djPda+z0ssKEg5dFOQvJV3f8THUXHsO+Xfg3SuMDN60SHV55qVw3orgZ/oLjfwYj74lrCgL4hYpwDnu7fXRfroqkJTJ9G1bZvO6B0N713GB+pcAv2W3icaLo+9wxM/N2vjeiT2LcdHy2XCoBJForVu/uQke3gvul7LDzGSgI++AVeR5K8SfRg2y0Qfn3bVr5QtAbnBGkhMQsTYJ+d7kHP88oeMPy52n7W8UtnQP0gY2qf6X2eYT+zdWhaHL0RxouE09KPknwfHMs2SBkRkTA1ROwC15PIOcv+IpYA1oOVrgNF8FVRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBb9avuoa4Kg0rTlZNVeuyqM8pKEjrFj5UnjOtQhfzc=;
 b=oScgG/IuHe8Z3PTA0ro1EdqWnae6QdorxgVSrIae5jaLdSt4fHPrz7oZ22xrcMjQBSt9XUWtiNuZhtvKdldFi9uWvN6zXH4VdFcHUenMcT/wyzGflZxm6ujCUcJWOkj1iA7K4M/eaFnfpXpGssartnklQqQgU4J3JOp9brHPNyk=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2910.eurprd08.prod.outlook.com (10.175.245.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 15:55:06 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 15:55:06 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
CC:     nd <nd@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 29/30] drm/bridge: add support for device links to bridge
Thread-Topic: [PATCH 29/30] drm/bridge: add support for device links to bridge
Thread-Index: AQHVpFu1iHJCIvZyo0WUUQNtpUlix6edhM4AgAAWJ4A=
Date:   Tue, 26 Nov 2019 15:55:06 +0000
Message-ID: <1817506.VEjLu2jiqi@e123338-lin>
References: <20191126131541.47393-1-mihail.atanassov@arm.com>
 <20191126131541.47393-30-mihail.atanassov@arm.com>
 <20191126143534.GW29965@phenom.ffwll.local>
In-Reply-To: <20191126143534.GW29965@phenom.ffwll.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LNXP123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::17) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 319fba88-8c8b-42b6-4bad-08d7728906e2
X-MS-TrafficTypeDiagnostic: VI1PR08MB2910:|AM0PR08MB3393:
X-Microsoft-Antispam-PRVS: <AM0PR08MB3393BFF07BF9F1B92DC2F5128F450@AM0PR08MB3393.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(52314003)(6246003)(86362001)(81156014)(81166006)(66946007)(8936002)(110136005)(66476007)(5660300002)(2906002)(5024004)(316002)(6116002)(3846002)(14444005)(66066001)(386003)(66446008)(6436002)(14454004)(446003)(6486002)(99286004)(11346002)(229853002)(71190400001)(26005)(8676002)(64756008)(256004)(25786009)(478600001)(71200400001)(54906003)(66556008)(6506007)(33716001)(4326008)(76176011)(186003)(6512007)(305945005)(7736002)(102836004)(52116002)(9686003)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2910;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: PA4itfa/2Si2NMx2+lcHXMnRKCfXPY7K8OjtG4OUqjt+8UBV+y5uP0RmREI1gTJCJSsS4v9w+T2FaSMtfKQx/ufUloa/HrPopi/YJJmp3Jar1XgPD6v8eaAV3aXBo4maJl2rXMFfBURVp+4s7BwQyssVx7MBZSWAq9VWkTUxFSrI7r/BuNmBCW6aKlDcreu51/mJXaPPayZiwXjNTv5bpH4xLtpSS8ZGYg0PUJBdRXhgbUGLhJFOPtzkmuskw+y/wNLgFAKhA4rUjxUqibpKzB/E85S9R3q9RT6Pot3TO0NiL9GdgIl0wKJ6pZmlUEYqVAtIumrnP9Zn9dEJjgmUr/3ULZ1eqS0yh2X0l2ZEf0BSmN9K4kfY1z3ExtoNfs5TGLrXBLJcnJpD9JeRfVtTkyEBiaWpKUUw2BWShCOADzbSHAAruWJZI3jMtZHhtoi5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <052B63C321E52E458F3A46BE0A2BFCB4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2910
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(52314003)(22756006)(54906003)(106002)(110136005)(14444005)(70206006)(316002)(7736002)(97756001)(9686003)(46406003)(86362001)(6246003)(5024004)(336012)(446003)(2906002)(76130400001)(70586007)(305945005)(186003)(102836004)(26005)(356004)(23726003)(6512007)(107886003)(8676002)(50466002)(99286004)(6116002)(76176011)(47776003)(3846002)(5660300002)(14454004)(11346002)(6506007)(386003)(8746002)(26826003)(81166006)(4326008)(229853002)(6486002)(66066001)(33716001)(81156014)(478600001)(25786009)(8936002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3393;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1c34ce03-23a8-4523-8e91-08d7728901ec
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nuv+pmITfIutlEDOv/FfdVBD2h0csvvd4Ap4CH/QWuIVfVVY8jCPBR+In5tMC4T8mYALEln30kFTL7fRUOR9Q6Rn8wkNRcv+vSRC+7+tkyhkUufxvh6IBH19YF7CYZjtlgw97zehKAxhP8U2gGkG0SNsSBolSzg5SSg5ui2WeAow9ZKJAehdT8JlCIrAu0tmpmJtJG3nGLMJArzwhR69axEtheZDJH956B5dvAFEptmvYviCDNs8tJHy4BTRAprV/OKrwZ7Ok3RcJDjHbhFTFFD/ChsOxD8poqeUs4UcPbnQjQyYpzxYpgaT6wFjM+FJSU6RYZ15Vei6m/OHhZqMN2JTBk9I1GwNadL/A8NJN2Q+bVEIlRG58LpW5RQS4Co5TWpGh635oYunGTy7MmdiJiLtI7Ey3Vqbs+ipNhhFxcsCGxsbNqPe5pnIdc3tnhhJ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 15:55:14.7273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 319fba88-8c8b-42b6-4bad-08d7728906e2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3393
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 26 November 2019 14:35:34 GMT Daniel Vetter wrote:
> On Tue, Nov 26, 2019 at 01:16:26PM +0000, Mihail Atanassov wrote:
> > From: Russell King <rmk+kernel@armlinux.org.uk>
> >=20
> > Bridge devices have been a potential for kernel oops as their lifetime
> > is independent of the DRM device that they are bound to.  Hence, if a
> > bridge device is unbound while the parent DRM device is using them, the
> > parent happily continues to use the bridge device, calling the driver
> > and accessing its objects that have been freed.
> >=20
> > This can cause kernel memory corruption and kernel oops.
> >=20
> > To control this, use device links to ensure that the parent DRM device
> > is unbound when the bridge device is unbound, and when the bridge
> > device is re-bound, automatically rebind the parent DRM device.
> >=20
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > Tested-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > [reworked to use drm_bridge_init() for setting bridge->device]
> > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
>=20
> So I thought the big plan was to put the device_link setup into
> drm_bridge_attach, so that it's done for everyone. And we could then
> slowly go through the existing drivers that use the component framework t=
o
> get this handled correctly.
>=20
> So my questions:
> - is there a problem if we add the device_link for everyone?

Possibly not, but I didn't want to stir the entire pot :). This is
safer in the sense that it's an opt-in, so a lower chance of
regressions in code and setups that I can't possibly test. If you
think it's worth sticking it in the existing code paths, I can
certainly do that too.

> - is there an issue if we only add it at drm_bridge_attach time? I kinda
>   assumed that it's not needed before that (EPROBE_DEFER should handle
>   load dependencies as before), but it could be that some drivers ask for
>   a bridge and then check more stuff and then drop the bridge without
>   calling drm_bridge_attach. We probably don't have a case like this yet,
>   but better robust than sorry.

I think there would be a race there:

- bridge driver calls drm_bridge_add() in their probe()
- client driver calls of_drm_find_bridge() in their probe()
- bridge driver gets removed, calls drm_bridge_remove()
- client driver uses the now invalid drm_bridge pointer from above to
  do drm_bridge_attach()

With of_drm_bridge_find_devlink(), you get the device_link inside the
bridge_lock so the reference to the drm_bridge will either be valid, or
your driver gets removed right after it's probed, so that the bridge
can be removed, too.

In patch 30/30 I use both the _devlink and the non-_devlink versions
of of_drm_find_bridge(), but I guess there's no harm adding another
refcount on the link, it'll get destroyed if the bridge is removed
regardless, although that may need a DL_FLAG_AUTOREMOVE_CONSUMER.

>=20
> Anyway, I scrolled through the bridge patches, looked all good, huge
> thanks for tackling this! Once we have some agreement on the bigger
> questions here I'll try to go through them and review.
>=20
> Cheers, Daniel
> > ---
> >  drivers/gpu/drm/drm_bridge.c | 49 ++++++++++++++++++++++++++----------
> >  include/drm/drm_bridge.h     |  4 +++
> >  2 files changed, 40 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.=
c
> > index cbe680aa6eac..e1f8db84651a 100644
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/mutex.h>
> > =20
> >  #include <drm/drm_bridge.h>
> > +#include <drm/drm_device.h>
> >  #include <drm/drm_encoder.h>
> > =20
> >  #include "drm_crtc_internal.h"
> > @@ -109,6 +110,7 @@ void drm_bridge_init(struct drm_bridge *bridge, str=
uct device *dev,
> >  	bridge->encoder =3D NULL;
> >  	bridge->next =3D NULL;
> > =20
> > +	bridge->device =3D dev;
> >  #ifdef CONFIG_OF
> >  	bridge->of_node =3D dev->of_node;
> >  #endif
> > @@ -492,6 +494,32 @@ void drm_atomic_bridge_enable(struct drm_bridge *b=
ridge,
> >  EXPORT_SYMBOL(drm_atomic_bridge_enable);
> > =20
> >  #ifdef CONFIG_OF
> > +static struct drm_bridge *drm_bridge_find(struct drm_device *dev,
> > +					  struct device_node *np, bool link)
> > +{
> > +	struct drm_bridge *bridge, *found =3D NULL;
> > +	struct device_link *dl;
> > +
> > +	mutex_lock(&bridge_lock);
> > +
> > +	list_for_each_entry(bridge, &bridge_list, list)
> > +		if (bridge->of_node =3D=3D np) {
> > +			found =3D bridge;
> > +			break;
> > +		}
> > +
> > +	if (found && link) {
> > +		dl =3D device_link_add(dev->dev, found->device,
> > +				     DL_FLAG_AUTOPROBE_CONSUMER);
> > +		if (!dl)mutex
> > +			found =3D NULL;
> > +	}
> > +
> > +	mutex_unlock(&bridge_lock);
> > +
> > +	return found;
> > +}
> > +
> >  /**
> >   * of_drm_find_bridge - find the bridge corresponding to the device no=
de in
> >   *			the global bridge list
> > @@ -503,21 +531,16 @@ EXPORT_SYMBOL(drm_atomic_bridge_enable);
> >   */
> >  struct drm_bridge *of_drm_find_bridge(struct device_node *np)
> >  {
> > -	struct drm_bridge *bridge;
> > -
> > -	mutex_lock(&bridge_lock);
> > -
> > -	list_for_each_entry(bridge, &bridge_list, list) {
> > -		if (bridge->of_node =3D=3D np) {
> > -			mutex_unlock(&bridge_lock);
> > -			return bridge;
> > -		}
> > -	}
> > -
> > -	mutex_unlock(&bridge_lock);
> > -	return NULL;
> > +	return drm_bridge_find(NULL, np, false);
> >  }
> >  EXPORT_SYMBOL(of_drm_find_bridge);
> > +
> > +struct drm_bridge *of_drm_find_bridge_devlink(struct drm_device *dev,
> > +					      struct device_node *np)
> > +{
> > +	return drm_bridge_find(dev, np, true);
> > +}
> > +EXPORT_SYMBOL(of_drm_find_bridge_devlink);
> >  #endif
> > =20
> >  MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
> > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > index d6d9d5301551..68b27c69cc3d 100644
> > --- a/include/drm/drm_bridge.h
> > +++ b/include/drm/drm_bridge.h
> > @@ -382,6 +382,8 @@ struct drm_bridge {
> >  	struct drm_encoder *encoder;
> >  	/** @next: the next bridge in the encoder chain */
> >  	struct drm_bridge *next;
> > +	/** @device: Linux driver model device */
> > +	struct device *device;
> >  #ifdef CONFIG_OF
> >  	/** @of_node: device node pointer to the bridge */
> >  	struct device_node *of_node;
> > @@ -407,6 +409,8 @@ void drm_bridge_init(struct drm_bridge *bridge, str=
uct device *dev,
> >  		     const struct drm_bridge_timings *timings,
> >  		     void *driver_private);
> >  struct drm_bridge *of_drm_find_bridge(struct device_node *np);
> > +struct drm_bridge *of_drm_find_bridge_devlink(struct drm_device *dev,
> > +					      struct device_node *np);
> >  int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *=
bridge,
> >  		      struct drm_bridge *previous);
> > =20
>=20
>=20


--=20
Mihail



