Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA237CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C1220684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ibji9vJE";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ibji9vJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436525AbfJXIDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:03:45 -0400
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:64004
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbfJXIDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2OUT2Z+7aGZACB/eB25FMCiFYY98b/g1HOtfCBAf48=;
 b=Ibji9vJE3DdW4aY9mwFL4tl70pHUFlWeGxvyxUSfX+6QzMy3j2bY/UkJuXWUG48yedPL6U8A8s/kExgH2GMuUtmdERDi/AkF9IPhk7OD5lzq3FgcL5f8JT/aQ/Qyuqqz45CeXI4uU99UWcWLVPr1USfpzfak8tlONTGKr8I8tvA=
Received: from VI1PR08CA0100.eurprd08.prod.outlook.com (2603:10a6:800:d3::26)
 by HE1PR0801MB1996.eurprd08.prod.outlook.com (2603:10a6:3:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22; Thu, 24 Oct
 2019 08:03:32 +0000
Received: from DB5EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::201) by VI1PR08CA0100.outlook.office365.com
 (2603:10a6:800:d3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22 via Frontend
 Transport; Thu, 24 Oct 2019 08:03:32 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT042.mail.protection.outlook.com (10.152.21.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.23 via Frontend Transport; Thu, 24 Oct 2019 08:03:32 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Thu, 24 Oct 2019 08:03:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 01e845c14af7a5bc
X-CR-MTA-TID: 64aa7808
Received: from 06fe89dfd3da.2 (cr-mta-lb-1.cr-mta-net [104.47.6.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8840981D-DE34-446D-88A1-B1E9F15AD98D.1;
        Thu, 24 Oct 2019 08:03:23 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2052.outbound.protection.outlook.com [104.47.6.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 06fe89dfd3da.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 24 Oct 2019 08:03:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJKYv0ZoYF0wCx0ZMJB7/4hQw4A3BvcFIx5ENLmyjQhLalpiX835CvYgpry4ldHg8XrhEYDn2HryVHFdPkUwsM3iiKLv6hnFdnw1Q3SKWUmtYsqu3Kmdx5l+rcp1ZMa9WteCGEl+WrRiNf+q87+fZSExYafkU/5FbjRHCXGrGeElnO9BMnXg41zqLcCiobS12txKWFlbnPD8yc+qmoVuoHL2wqrXxWWHiq12Z+9TZLBjs7clkt0qznZlgTa/y8OhgkMXJ7BNwBgCBhA9Nd+q7lj596YnevPZF1UNKRmCMAKz53hGaTeQA7cOUviav43DITQxh1R8MXGPIOhNMSquag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2OUT2Z+7aGZACB/eB25FMCiFYY98b/g1HOtfCBAf48=;
 b=IznyRgltrgRl+PkBXj6tBoX3o8eVNqg2+2XVro1AgvG7O9WcWLs80ypdE67tx7oeC3hXIXEYRON/Tuq0u6yQE0Dg060Gouh79kW1vNrgno4eE8QiDUtYzRQMrXB6xAfqEvOaQ59KAUsp3KWP8Sj80p4ivqRCebYY4Ce0wbpHPKE+d4V83WMyzLxkXJpX9bKuV8q++zmmFsORXFFHxtHu0AwRKm1y4GCSNSPF/d6wSq11Ybu9Diiexyms0qJnrqutyQ9pnBDHZ9vIlvi69ZvY9oBFu2u83wSqlcntJNrFKfvAI3FSep6sjhiaU8s6IRBGaQI71ABy/wIOrdafdcRSJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2OUT2Z+7aGZACB/eB25FMCiFYY98b/g1HOtfCBAf48=;
 b=Ibji9vJE3DdW4aY9mwFL4tl70pHUFlWeGxvyxUSfX+6QzMy3j2bY/UkJuXWUG48yedPL6U8A8s/kExgH2GMuUtmdERDi/AkF9IPhk7OD5lzq3FgcL5f8JT/aQ/Qyuqqz45CeXI4uU99UWcWLVPr1USfpzfak8tlONTGKr8I8tvA=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2813.eurprd08.prod.outlook.com (10.170.237.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Thu, 24 Oct 2019 08:03:21 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2387.023; Thu, 24 Oct 2019
 08:03:21 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     nd <nd@arm.com>, Daniel Vetter <daniel@ffwll.ch>,
        Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>
Subject: Re: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Thread-Topic: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Thread-Index: AQHVfmYCVHmeR23TD0SRvLooFH2IJKddhx2A///3y4CAALR0gIAAV3AAgAAhkICAAAeWAIAADuyAgAephQCAAAHAAIAAAKIAgABiMICAAAMtgIACshCA
Date:   Thu, 24 Oct 2019 08:03:21 +0000
Message-ID: <2680521.ztbuDzSfBp@e123338-lin>
References: <20191016162206.u2yo37rtqwou4oep@DESKTOP-E1NTVVP.localdomain>
 <20191022144207.GV25745@shell.armlinux.org.uk>
 <20191022145328.GW25745@shell.armlinux.org.uk>
In-Reply-To: <20191022145328.GW25745@shell.armlinux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P265CA0345.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::21) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ade9476e-2ab6-487f-8340-08d75858a9a0
X-MS-TrafficTypeDiagnostic: VI1PR08MB2813:|VI1PR08MB2813:|HE1PR0801MB1996:
X-MS-Exchange-PUrlCount: 2
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1996AD9D6BF786A312F8D3858F6A0@HE1PR0801MB1996.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 0200DDA8BE
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(376002)(346002)(366004)(39860400002)(396003)(51914003)(189003)(199004)(3846002)(6486002)(316002)(229853002)(446003)(386003)(6916009)(11346002)(53546011)(6116002)(6436002)(2906002)(6506007)(26005)(8676002)(81156014)(476003)(8936002)(54906003)(30864003)(81166006)(6512007)(6306002)(52116002)(6246003)(66476007)(14444005)(5024004)(256004)(7736002)(86362001)(71190400001)(25786009)(102836004)(64756008)(66446008)(66556008)(71200400001)(966005)(14454004)(478600001)(33716001)(4326008)(76176011)(305945005)(5660300002)(66066001)(99286004)(486006)(66946007)(9686003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2813;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: JAj3xBJegLOGYzebHSP9gCf+z4EwZLlBpYRjtud9igJ/eFxMTDUG6bjsyCuwVpJAjCbYJ/3Klk5vkL6c+vKHVqFQKjbkBwTXR9gd8crw8GwbY2bc555dQPGEwRIGk7pQrPkpdHgfaPA3WNLWCIE9CgwlyhY7ihs6/o6Xkefox/sj0xeBFEOFw/Z7QJYCCszpCVzilNBh5LYbLxZUBK1+Evsj6a22ZZJfFHxBx0Pi263cccOrFpiVk5sQv9XVbqblwfXPWeL8mkxFyGBK40UOqbzXk1qenrIy4K5mRnLTnYaDFIthrUOAoogPxH7Aicnph8k33S0eBhNaQ58M2+W3Zno4w0xyEfF3RDzx8VljPlKRH+ZKUcLDQmJiaNdI9XH/ssPxfKeEbuWcNQBw/aRGLQZMg5NcOtdw4a6Levuq9PblDl6w6NZMTu7Pwjyxx+im5JpwAgE32vtiB5AwInCHTcQqqztCfghWL9I0oJQfOig=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <286F3A4C8A08224799208CC2FFA7F210@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2813
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(396003)(376002)(136003)(346002)(1110001)(339900001)(51914003)(199004)(189003)(54906003)(46406003)(99286004)(5024004)(50466002)(14444005)(97756001)(316002)(6486002)(966005)(305945005)(7736002)(478600001)(26826003)(6246003)(229853002)(107886003)(6306002)(9686003)(6512007)(6862004)(30864003)(5660300002)(356004)(2906002)(23726003)(6116002)(3846002)(22756006)(33716001)(86362001)(4326008)(26005)(25786009)(186003)(102836004)(76176011)(70586007)(70206006)(6506007)(386003)(53546011)(66066001)(47776003)(76130400001)(336012)(486006)(126002)(476003)(81166006)(446003)(81156014)(11346002)(8676002)(105606002)(8936002)(8746002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1996;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1438d893-2a6c-4dab-3756-08d75858a317
NoDisclaimer: True
X-Forefront-PRVS: 0200DDA8BE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YOGk3cDMOfVCwrPxhFYJmzFdvjU1TI7Yb4dktvz7Tn8gW7jPb4Z+uOLy1tlwiFtd55QDfURsQMdVWR0x/4+oMXiVfRsZ7TXYkBA06pige/tOQ3RXcLTNKWziFfNPrZbFYDLSsF5d4qhHjE7crKJrY7pWA9QuRyVzhPz3K3XYqb6AobAQ+zjNyQ3l9j+LaZQm/TbKk8NO97R2wJM+9wFwfT69IgeiBwX/nOBDPeDd3ha4Qcmcb7i4YsrwWHE6hoEIQdurrQrdw0HDGlSnicsNazDuH0CFduQ673nfJ46lwtsSmhkXJ4EtnEnCePzb9vWWwIsY/3WcuTQcabSxOzXehf+oZIoaYYpvL8fF/52e9BcxxLX9UsOw24HyBULbCuzrdwe5mOTLSPIFR9R5+bgH9XXZSlHGEVlxkfBwNzy9DiVxGoz0m343rrXUl1Wacdzsd9bqjrlPdmOOpqkBS2z3+B6hslgmWc0jT9V++qi90xk=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2019 08:03:32.1699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ade9476e-2ab6-487f-8340-08d75858a9a0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1996
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Tuesday, 22 October 2019 15:53:29 BST Russell King - ARM Linux admin wro=
te:
> On Tue, Oct 22, 2019 at 03:42:07PM +0100, Russell King - ARM Linux admin =
wrote:
> > On Tue, Oct 22, 2019 at 10:50:42AM +0200, Daniel Vetter wrote:
> > > On Tue, Oct 22, 2019 at 10:48 AM Russell King - ARM Linux admin
> > > <linux@armlinux.org.uk> wrote:
> > > > I had a patches, which is why I raised the problem with the core:
> > > >
> > > > 6961edfee26d bridge hacks using device links
> > > >
> > > > but it never went further than an experiment at the time because of=
 the
> > > > problems in the core.  As it was a hack, it never got posted.  Seem=
s
> > > > that kernel tree (for the cubox) is still 5.2 based, so has a lot o=
f
> > > > patches and might need updating to a more recent base before anythi=
ng
> > > > can be tested.
> > >=20
> > >=20
> > > For reference, the panel patch:
> > >=20
> > > https://patchwork.kernel.org/patch/10364873/
> > >=20
> > > And the huge discussion around bridges, that resulted in Rafael
> > > Wyzocki fixing all the core issues:
> > >=20
> > > https://www.spinics.net/lists/dri-devel/msg201927.html
> > >=20
> > > James, do you want to look into this for bridges?
> >=20
> > I can now confirm that it does work.
>=20
> Something like this - it's based off an older kernel, so may be missing
> some of the bridge drivers, but should be sufficient for people to test
> with.

Thanks for the patch, I tested to the limit that our driver allows at
the moment -- rmmod'ing the bridge while the driver is not in use --
and I don't see any issues there. komeda successfully gets removed then
re-probed once the bridge reappears. For that part,

Tested-by: Mihail Atanassov <mihail.atanassov@arm.com>

I couldn't sadly check a hot unplug since we have an mm bug or two that
I need to sort out first. If anyone else has a hot-unplug capable
driver and can test, it'd be good to ensure that also functions
properly.

>=20
> 8<=3D=3D=3D=3D
> From: Russell King <rmk+kernel@armlinux.org.uk>
> Subject: [PATCH] drm/bridge: add support for device links to bridge
>=20
> Bridge devices have been a potential for kernel oops as their lifetime
> is independent of the DRM device that they are bound to.  Hence, if a
> bridge device is unbound while the parent DRM device is using them, the
> parent happily continues to use the bridge device, calling the driver
> and accessing its objects that have been freed.
>=20
> This can cause kernel memory corruption and kernel oops.
>=20
> To control this, use device links to ensure that the parent DRM device
> is unbound when the bridge device is unbound, and when the bridge
> device is re-bound, automatically rebind the parent DRM device.
>=20
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c  |  1 +
>  drivers/gpu/drm/bridge/analogix-anx78xx.c     |  1 +
>  drivers/gpu/drm/bridge/dumb-vga-dac.c         |  1 +
>  drivers/gpu/drm/bridge/lvds-encoder.c         |  1 +
>  .../bridge/megachips-stdpxxxx-ge-b850v3-fw.c  |  1 +
>  drivers/gpu/drm/bridge/nxp-ptn3460.c          |  1 +
>  drivers/gpu/drm/bridge/panel.c                |  1 +
>  drivers/gpu/drm/bridge/parade-ps8622.c        |  1 +
>  drivers/gpu/drm/bridge/sii902x.c              |  1 +
>  drivers/gpu/drm/bridge/sii9234.c              |  1 +
>  drivers/gpu/drm/bridge/sil-sii8620.c          |  1 +
>  drivers/gpu/drm/bridge/tc358767.c             |  1 +
>  drivers/gpu/drm/bridge/ti-tfp410.c            |  1 +
>  drivers/gpu/drm/drm_bridge.c                  | 48 ++++++++++++++-----
>  drivers/gpu/drm/i2c/tda998x_drv.c             |  1 +
>  include/drm/drm_bridge.h                      |  4 ++
>  16 files changed, 53 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_drv.c
> index f6d2681f6927..6a5906da58ea 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -1217,6 +1217,7 @@ static int adv7511_probe(struct i2c_client *i2c, co=
nst struct i2c_device_id *id)
>  		goto err_unregister_cec;
> =20
>  	adv7511->bridge.funcs =3D &adv7511_bridge_funcs;
> +	adv7511->bridge.device =3D dev;
>  	adv7511->bridge.of_node =3D dev->of_node;
> =20
>  	drm_bridge_add(&adv7511->bridge);
> diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/=
bridge/analogix-anx78xx.c
> index 3c7cc5af735c..77ff17c38037 100644
> --- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
> +++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
> @@ -1323,6 +1323,7 @@ static int anx78xx_i2c_probe(struct i2c_client *cli=
ent,
> =20
>  	mutex_init(&anx78xx->lock);
> =20
> +	anx78xx->bridge.device =3D &client->dev;
>  #if IS_ENABLED(CONFIG_OF)
>  	anx78xx->bridge.of_node =3D client->dev.of_node;
>  #endif
> diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/brid=
ge/dumb-vga-dac.c
> index d32885b906ae..40169920560e 100644
> --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
> @@ -202,6 +202,7 @@ static int dumb_vga_probe(struct platform_device *pde=
v)
>  	}
> =20
>  	vga->bridge.funcs =3D &dumb_vga_bridge_funcs;
> +	vga->bridge.device =3D &pdev->dev;
>  	vga->bridge.of_node =3D pdev->dev.of_node;
>  	vga->bridge.timings =3D of_device_get_match_data(&pdev->dev);
> =20
> diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/brid=
ge/lvds-encoder.c
> index 2ab2c234f26c..5012be35a5fb 100644
> --- a/drivers/gpu/drm/bridge/lvds-encoder.c
> +++ b/drivers/gpu/drm/bridge/lvds-encoder.c
> @@ -115,6 +115,7 @@ static int lvds_encoder_probe(struct platform_device =
*pdev)
>  	 * to look up.
>  	 */
>  	lvds_encoder->bridge.of_node =3D dev->of_node;
> +	lvds_encoder->bridge.device =3D dev;
>  	lvds_encoder->bridge.funcs =3D &funcs;
>  	drm_bridge_add(&lvds_encoder->bridge);
> =20
> diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/d=
rivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> index 79311f8354bd..e211c57f6f56 100644
> --- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> @@ -304,6 +304,7 @@ static int stdp4028_ge_b850v3_fw_probe(struct i2c_cli=
ent *stdp4028_i2c,
> =20
>  	/* drm bridge initialization */
>  	ge_b850v3_lvds_ptr->bridge.funcs =3D &ge_b850v3_lvds_funcs;
> +	ge_b850v3_lvds_ptr->bridge.device =3D dev;
>  	ge_b850v3_lvds_ptr->bridge.of_node =3D dev->of_node;
>  	drm_bridge_add(&ge_b850v3_lvds_ptr->bridge);
> =20
> diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridg=
e/nxp-ptn3460.c
> index 98bc650b8c95..00097e314575 100644
> --- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
> +++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
> @@ -323,6 +323,7 @@ static int ptn3460_probe(struct i2c_client *client,
>  	}
> =20
>  	ptn_bridge->bridge.funcs =3D &ptn3460_bridge_funcs;
> +	ptn_bridge->bridge.device =3D dev;
>  	ptn_bridge->bridge.of_node =3D dev->of_node;
>  	drm_bridge_add(&ptn_bridge->bridge);
> =20
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/pane=
l.c
> index b12ae3a4c5f1..eab7126f0d61 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -168,6 +168,7 @@ struct drm_bridge *drm_panel_bridge_add(struct drm_pa=
nel *panel,
>  	panel_bridge->panel =3D panel;
> =20
>  	panel_bridge->bridge.funcs =3D &panel_bridge_bridge_funcs;
> +	panel_bridge->bridge.device =3D panel->dev;
>  #ifdef CONFIG_OF
>  	panel_bridge->bridge.of_node =3D panel->dev->of_node;
>  #endif
> diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bri=
dge/parade-ps8622.c
> index 2d88146e4836..ff79df0ff183 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8622.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8622.c
> @@ -589,6 +589,7 @@ static int ps8622_probe(struct i2c_client *client,
>  	}
> =20
>  	ps8622->bridge.funcs =3D &ps8622_bridge_funcs;
> +	ps8622->bridge.device =3D dev;
>  	ps8622->bridge.of_node =3D dev->of_node;
>  	drm_bridge_add(&ps8622->bridge);
> =20
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/si=
i902x.c
> index dd7aa466b280..ef768b149bee 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -991,6 +991,7 @@ static int sii902x_probe(struct i2c_client *client,
>  	}
> =20
>  	sii902x->bridge.funcs =3D &sii902x_bridge_funcs;
> +	sii902x->bridge.device =3D dev;
>  	sii902x->bridge.of_node =3D dev->of_node;
>  	sii902x->bridge.timings =3D &default_sii902x_timings;
>  	drm_bridge_add(&sii902x->bridge);
> diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/si=
i9234.c
> index 25d4ad8c7ad6..824ffaeff16e 100644
> --- a/drivers/gpu/drm/bridge/sii9234.c
> +++ b/drivers/gpu/drm/bridge/sii9234.c
> @@ -936,6 +936,7 @@ static int sii9234_probe(struct i2c_client *client,
>  	i2c_set_clientdata(client, ctx);
> =20
>  	ctx->bridge.funcs =3D &sii9234_bridge_funcs;
> +	ctx->bridge.device =3D dev;
>  	ctx->bridge.of_node =3D dev->of_node;
>  	drm_bridge_add(&ctx->bridge);
> =20
> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridg=
e/sil-sii8620.c
> index bd3165ee5354..5bc56c5f6826 100644
> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c
> @@ -2333,6 +2333,7 @@ static int sii8620_probe(struct i2c_client *client,
>  	i2c_set_clientdata(client, ctx);
> =20
>  	ctx->bridge.funcs =3D &sii8620_bridge_funcs;
> +	ctx->bridge.device =3D dev;
>  	ctx->bridge.of_node =3D dev->of_node;
>  	drm_bridge_add(&ctx->bridge);
> =20
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/t=
c358767.c
> index 13ade28a36a8..d62c6925c5fe 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -1526,6 +1526,7 @@ static int tc_probe(struct i2c_client *client, cons=
t struct i2c_device_id *id)
>  		return ret;
> =20
>  	tc->bridge.funcs =3D &tc_bridge_funcs;
> +	tc->bridge.device =3D dev;
>  	tc->bridge.of_node =3D dev->of_node;
>  	drm_bridge_add(&tc->bridge);
> =20
> diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/=
ti-tfp410.c
> index dbf35c7bc85e..2f9899d7d4b4 100644
> --- a/drivers/gpu/drm/bridge/ti-tfp410.c
> +++ b/drivers/gpu/drm/bridge/ti-tfp410.c
> @@ -326,6 +326,7 @@ static int tfp410_init(struct device *dev, bool i2c)
>  	dev_set_drvdata(dev, dvi);
> =20
>  	dvi->bridge.funcs =3D &tfp410_bridge_funcs;
> +	dvi->bridge.device =3D dev;
>  	dvi->bridge.of_node =3D dev->of_node;
>  	dvi->bridge.timings =3D &dvi->timings;
>  	dvi->dev =3D dev;
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index cba537c99e43..b4561ce63a49 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -26,6 +26,7 @@
>  #include <linux/mutex.h>
> =20
>  #include <drm/drm_bridge.h>
> +#include <drm/drm_device.h>
>  #include <drm/drm_encoder.h>
> =20
>  #include "drm_crtc_internal.h"
> @@ -463,6 +464,32 @@ void drm_atomic_bridge_enable(struct drm_bridge *bri=
dge,
>  EXPORT_SYMBOL(drm_atomic_bridge_enable);
> =20
>  #ifdef CONFIG_OF
> +static struct drm_bridge *drm_bridge_find(struct drm_device *dev,
> +					  struct device_node *np, bool link)
> +{
> +	struct drm_bridge *bridge, *found =3D NULL;
> +	struct device_link *dl;
> +
> +	mutex_lock(&bridge_lock);
> +
> +	list_for_each_entry(bridge, &bridge_list, list)
> +		if (bridge->of_node =3D=3D np) {
> +			found =3D bridge;
> +			break;
> +		}
> +
> +	if (found && link) {
> +		dl =3D device_link_add(dev->dev, found->device,
> +				     DL_FLAG_AUTOPROBE_CONSUMER);
> +		if (!dl)
> +			found =3D NULL;
> +	}
> +
> +	mutex_unlock(&bridge_lock);
> +
> +	return found;
> +}
> +
>  /**
>   * of_drm_find_bridge - find the bridge corresponding to the device node=
 in
>   *			the global bridge list
> @@ -474,21 +501,16 @@ EXPORT_SYMBOL(drm_atomic_bridge_enable);
>   */
>  struct drm_bridge *of_drm_find_bridge(struct device_node *np)
>  {
> -	struct drm_bridge *bridge;
> -
> -	mutex_lock(&bridge_lock);
> -
> -	list_for_each_entry(bridge, &bridge_list, list) {
> -		if (bridge->of_node =3D=3D np) {
> -			mutex_unlock(&bridge_lock);
> -			return bridge;
> -		}
> -	}
> -
> -	mutex_unlock(&bridge_lock);
> -	return NULL;
> +	return drm_bridge_find(NULL, np, false);
>  }
>  EXPORT_SYMBOL(of_drm_find_bridge);
> +
> +struct drm_bridge *of_drm_find_bridge_devlink(struct drm_device *dev,
> +					      struct device_node *np)
> +{
> +	return drm_bridge_find(dev, np, true);
> +}
> +EXPORT_SYMBOL(of_drm_find_bridge_devlink);
>  #endif
> =20
>  MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda9=
98x_drv.c
> index e79507fb225f..5d4122bcf7ff 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -2201,6 +2201,7 @@ static int tda998x_create(struct device *dev)
>  	}
> =20
>  	priv->bridge.funcs =3D &tda998x_bridge_funcs;
> +	priv->bridge.device =3D dev;
>  #ifdef CONFIG_OF
>  	priv->bridge.of_node =3D dev->of_node;
>  #endif
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 7616f6562fe4..f8a3af42a382 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -382,6 +382,8 @@ struct drm_bridge {
>  	struct drm_encoder *encoder;
>  	/** @next: the next bridge in the encoder chain */
>  	struct drm_bridge *next;
> +	/** @device: Linux driver model device */
> +	struct device *device;
>  #ifdef CONFIG_OF
>  	/** @of_node: device node pointer to the bridge */
>  	struct device_node *of_node;
> @@ -403,6 +405,8 @@ struct drm_bridge {
>  void drm_bridge_add(struct drm_bridge *bridge);
>  void drm_bridge_remove(struct drm_bridge *bridge);
>  struct drm_bridge *of_drm_find_bridge(struct device_node *np);
> +struct drm_bridge *of_drm_find_bridge_devlink(struct drm_device *dev,
> +					      struct device_node *np);
>  int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *br=
idge,
>  		      struct drm_bridge *previous);
> =20
>=20


--=20
Mihail



