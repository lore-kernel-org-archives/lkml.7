Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C714C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E25621739
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XR/GqCPu";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XR/GqCPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfK1PeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 10:34:18 -0500
Received: from mail-eopbgr140081.outbound.protection.outlook.com ([40.107.14.81]:41671
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbfK1PeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbaWo9nVqkjLcBGJycyvW1kzREZ6dBVcviZwznVjkP8=;
 b=XR/GqCPuC36kLs8Ja3UkrlIAAr0BApaQFy1bIo13zGRm/HYEd40ERaOXsSkDOr6Bx+zga+dbYpPVIavvGwyROQk4apXqVBVN4PvsT0ogg7MQGfN8pVApayf+4PemxnkC1gGcKvYTOxWw551nN1Q9J65gS60ZqYztsIFU/bfyYkA=
Received: from VI1PR0802CA0019.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::29) by DB7PR08MB3322.eurprd08.prod.outlook.com
 (2603:10a6:5:26::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18; Thu, 28 Nov
 2019 15:34:08 +0000
Received: from DB5EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::201) by VI1PR0802CA0019.outlook.office365.com
 (2603:10a6:800:aa::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.20 via Frontend
 Transport; Thu, 28 Nov 2019 15:34:07 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT045.mail.protection.outlook.com (10.152.21.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Thu, 28 Nov 2019 15:34:07 +0000
Received: ("Tessian outbound d55de055a19b:v37"); Thu, 28 Nov 2019 15:34:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e425c32ae8fdd41f
X-CR-MTA-TID: 64aa7808
Received: from cd8c12da6dc5.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BAB62CD5-0FE5-4257-B825-3BE26B89D31B.1;
        Thu, 28 Nov 2019 15:34:01 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cd8c12da6dc5.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 28 Nov 2019 15:34:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/6ZxN25yp3YqBcadzX0cok41UY9PAeuFtpOiquRLQSthICoYRxrY72nZqE1o8UxOicjU87TU9NzDW/ufLC0VU2CJyRdUHnRUCkiz4PEBi2kmbcOK8q/DJGGEygK+H4J1C5stbKQwcqf0bTwFkGMQkk+7wsXd6Sii1MtqAhCVwShfcj7HGnuhxwMk0httYIQ9uGFg0QSJuWm4T2i7YwRy0XFS3R3ST7FFxJEl6lnLlReCfrsiPHOjGWU/FJRxX7dj3XeDfFq9ZoGk77U2C8ZtdqpJoNLYWDvYa4u9BfMnaClBbSQ4//IYvpzA3yMci2whsL3ap1P0tlz8Q5ZkE9yKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbaWo9nVqkjLcBGJycyvW1kzREZ6dBVcviZwznVjkP8=;
 b=m28q/la/hPyctNi0zcivUBTIxTSRIhBaxk9KQXcbCBpdQPCM0aVDDmjEr6IL0PltRG6XYEObtKXu05KWNVxO6C2C3aPzVR5V8qNX1iKxczV+bHcm04SnB1a5URGFXtYfYVJqWT6HV35fo6hoxFfcrgJzS03Vv0uJ8bOU1AbRKlnDQdwftVCgnK/qzIrCM/Qk03o3CNQf32VZllWwM7r6WaRHjdrTS01vez9vvbSSvTlBIln9J1lt6E3NupxMSCnSbMkwC5EBin7KU/x6gXoLMsizKa62pa7cW03eVLu3gGKCBP21idtljjGAQpyBJ7aT7Jk5gXlsiu86TRHpNfMz6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbaWo9nVqkjLcBGJycyvW1kzREZ6dBVcviZwznVjkP8=;
 b=XR/GqCPuC36kLs8Ja3UkrlIAAr0BApaQFy1bIo13zGRm/HYEd40ERaOXsSkDOr6Bx+zga+dbYpPVIavvGwyROQk4apXqVBVN4PvsT0ogg7MQGfN8pVApayf+4PemxnkC1gGcKvYTOxWw551nN1Q9J65gS60ZqYztsIFU/bfyYkA=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3694.eurprd08.prod.outlook.com (20.178.13.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Thu, 28 Nov 2019 15:33:59 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Thu, 28 Nov 2019
 15:33:59 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     nd <nd@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 29/30] drm/bridge: add support for device links to bridge
Thread-Topic: [PATCH 29/30] drm/bridge: add support for device links to bridge
Thread-Index: AQHVpFu1iHJCIvZyo0WUUQNtpUlix6edhM4AgAMlaYA=
Date:   Thu, 28 Nov 2019 15:33:59 +0000
Message-ID: <6854050.X4Y1bUp2or@e123338-lin>
References: <20191126131541.47393-1-mihail.atanassov@arm.com>
 <20191126131541.47393-30-mihail.atanassov@arm.com>
 <20191126143534.GW29965@phenom.ffwll.local>
In-Reply-To: <20191126143534.GW29965@phenom.ffwll.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0075.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::15) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d45d412c-1780-4aea-98c4-08d77418687e
X-MS-TrafficTypeDiagnostic: VI1PR08MB3694:|DB7PR08MB3322:
X-Microsoft-Antispam-PRVS: <DB7PR08MB3322B3A129B6BF519123AB348F470@DB7PR08MB3322.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 0235CBE7D0
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(52314003)(189003)(199004)(446003)(71190400001)(4326008)(305945005)(71200400001)(11346002)(478600001)(102836004)(2906002)(6506007)(9686003)(6512007)(14454004)(33716001)(386003)(7736002)(86362001)(5660300002)(66066001)(64756008)(66556008)(66476007)(229853002)(66446008)(14444005)(66946007)(6916009)(81156014)(81166006)(8676002)(8936002)(6486002)(6436002)(316002)(54906003)(26005)(25786009)(186003)(6116002)(76176011)(6246003)(99286004)(52116002)(3846002)(256004)(5024004)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3694;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: y5q5+p8Mkfj5/v5A9zWfNQ1UeWhl6ZFxpcr+U3/DnAkXeBE2pSVLoXEN4f4P79jaI/TC8rX38VJUXMBW4BdPhGXGOfdmavvY+VGRv/xbB1gbyZgOyETcIaoNQ8kDCWRMo9dbMGJhYrzCMlFiN7OYvvQ+LmnGWWe4J8Bkcrg9uAg86GICYxPxotE4FSimellIGZ59GsHfWydU3qiECzCz2pm4BBhcqXkIjPtpJB4qNqlAzdMfs/hLYk8D5WWjk/FlTlsDxcoUcOJfyJIRtSxOobesAy6etxPm6wBU/ksRH/wt5i5X1bBWHi5ByS5P3Ui5Irgzx5YyN2v9d2IYIk9ibGW9L/8+e1HfTc16Dp2jPN8sN1DIPBioX5IOPGKgrPcybzf1J8k4XInxXYTODcvEYmXZYi+MT1xpZvO3+dXlOPPFsKxzxKn4Mv7uU1UmkLz6
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <805C6FBABB19A6488E6B1FD5D40CFF5A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3694
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(136003)(376002)(346002)(39860400002)(199004)(189003)(52314003)(6486002)(86362001)(47776003)(8936002)(99286004)(8746002)(6506007)(386003)(102836004)(25786009)(5660300002)(14444005)(5024004)(186003)(26005)(336012)(33716001)(106002)(54906003)(2906002)(50466002)(316002)(76176011)(107886003)(22756006)(23726003)(6246003)(70586007)(70206006)(6862004)(76130400001)(6512007)(9686003)(97756001)(3846002)(4326008)(6116002)(66066001)(305945005)(81156014)(81166006)(26826003)(478600001)(8676002)(11346002)(446003)(356004)(14454004)(7736002)(229853002)(46406003)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3322;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: bf1933f9-e86f-4a64-db1d-08d774186343
NoDisclaimer: True
X-Forefront-PRVS: 0235CBE7D0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Qgqf7Vd3zdx1sntrJNo1OIe0hNeZpt191jH6sLQHPbM/9Jby8Sg+/+YMX/oq1d2yyEusVs5lC2SyLxwE7JLF9Z8/84bt7p1OVFRNGvAc/YRSOMOShdAILr6k0llXexf1OQ9jswlrAde/n6qcA+mXtkJ3ifmcm7RKMTH4EdUPdmoi4bmkuvL1INix3DlbFGGkrn1TmAoFD+H7JjEQ7sPueeK6Jt7YpreziJTP6lGyH6N31s/lTiIn57Nz/OLlKUmWe8uZzAxMmxpb5YKc+qvO2sshPX5KQLUzNKNLo2jBMFwImVy7ii++35fhjCBcF8amdMFDQrzH9vfbGN/svQe/Ed+prxoYsPQWQkGhQHzqcKi7sPAonjUUJbLBMePKhBBY5b7gxZj5jtY0niXt+ZGCMyUa98jw1u/Zb1KD2zMlxnt88VEZBXryR7FGq8AHIG6
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2019 15:34:07.6878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45d412c-1780-4aea-98c4-08d77418687e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3322
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

So after spending time looking at the code and thinking
about it, I'm slowly coming to the conclusion that getting device
links right for everyone in one go is a much bigger task than this
opt-in quick-fix here. I've hit, at the very least, the following
snags in trying to apply it universally:

panel_bridge - removing one via drm_of_panel_bridge_remove() uses
of_drm_find_bridge(), which would add a devlink at a very inopportune
time;

mipi_dsi_host - attach/detach, where e.g. dw-mipi-dsi.c handles bridge
creation/destruction, doesn't correspond directly to a struct device's
lifetime, so the device link would linger longer than is required;

others that add/remove bridges at times different from probe/remove
(drivers using the component framework?).

I think it'd still be valuable even with limiting the scope to drivers
that get their bridge in probe() and drop it in remove() for now, and
only roll it out as an opt-in. Thoughts?

I think to get it right we need to use the links' refcount, with e.g.
of_drm_find_bridge() giving you a refcount of 1, and bridge_detach()
maybe dropping the refcount, but I can envision ways where this breaks
too, so maybe just an of_drm_{get,put}_bridge()?

> - is there an issue if we only add it at drm_bridge_attach time? I kinda
>   assumed that it's not needed before that (EPROBE_DEFER should handle
>   load dependencies as before), but it could be that some drivers ask for
>   a bridge and then check more stuff and then drop the bridge without
>   calling drm_bridge_attach. We probably don't have a case like this yet,
>   but better robust than sorry.
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
> > +		if (!dl)
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



