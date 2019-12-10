Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3AFC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5752C2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="F4oWCJWt";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="F4oWCJWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfLJN3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:29:04 -0500
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:37575
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbfLJN3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cosQTrS48MmpJTSUWFa6Zdboc/yqChB49MRJZnBLRds=;
 b=F4oWCJWtrgPNFhATOqJI1aK8/XUNnR2hWa59f3AqFSn9qIMVnIo3ciAYOJjlQL1AAlWsKSIebUIXjyBv4BJdEnaHFgkwXwJcc+3Mg/uynPnuJPw9aOebaczR1G/nhg0bxiu+E40ydwjMaERtw48tDAZiRPMiNpVGEtWZ9goRRac=
Received: from VI1PR0801CA0088.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::32) by DB6PR08MB2663.eurprd08.prod.outlook.com
 (2603:10a6:6:21::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.17; Tue, 10 Dec
 2019 13:28:50 +0000
Received: from DB5EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by VI1PR0801CA0088.outlook.office365.com
 (2603:10a6:800:7d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.14 via Frontend
 Transport; Tue, 10 Dec 2019 13:28:50 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT056.mail.protection.outlook.com (10.152.21.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Tue, 10 Dec 2019 13:28:50 +0000
Received: ("Tessian outbound 1e3e4a1147b7:v37"); Tue, 10 Dec 2019 13:28:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d6764d9970649753
X-CR-MTA-TID: 64aa7808
Received: from 296fd68b5255.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 63509ADF-EC12-40CD-888C-6CA1EDF59E90.1;
        Tue, 10 Dec 2019 13:28:44 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 296fd68b5255.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 10 Dec 2019 13:28:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7RQMSm7G7fRRXECKDHpu/lXctQENQOEWynUFf27PgqnnhagTptWjlefq0ydRswtbuAkCEhZdN4nxktwUk4RL6IsqdAEjdLdrpTI7csyOhZATeVd0gxULvTwpR8gzIBZJ2IVhp20x7VYDS5w5F92J3YOFa/lxPQOvyt+vskQluxGra4zj+wzPQkPd//k7DAZj4Lml8hpyehohayUqcedR7aPZg54SjTzd48Ug0Fy4Em5s3oBOpRxzMtAdvy8Lkh8zIGvSJSs8rJf9QL8SBoUH+hMddBUXU1P177RcvXhHRA5MSXnEsoqWeCYYfe3p92jfvSIXz+gMep85a1OR+Vr+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cosQTrS48MmpJTSUWFa6Zdboc/yqChB49MRJZnBLRds=;
 b=XSAt0rmj7q0lpMwXBeB6hXA6AcL+sDBBcIfcH+SfmEv+IKScYuf5UWSpFY+U3Ops6kQMpoQ0Z9m7xs5rvmLMr6dWbs5kaMznm4vGlOofTQvns+bKOYheD9TFHOgsQOK/3o8NSHyOzDc/8QCH8J2/C/8aeGXGW/srimok76EvxMJjd09VcTesZU/8cnJSyWtYhTNLH1iXa3zASlHmdcRLpPfbKzvrYNpGoJqL7AtnKT+WHd0ckPYF6w+p9c0BKAuNqUkJW4TDLH1BV/s6eTuoWzaSvkyli16wStvNOeeTEiGmXbM35qDSDU1X9JM4I7MBBCHsMPCLdva2guv8Xb3xqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cosQTrS48MmpJTSUWFa6Zdboc/yqChB49MRJZnBLRds=;
 b=F4oWCJWtrgPNFhATOqJI1aK8/XUNnR2hWa59f3AqFSn9qIMVnIo3ciAYOJjlQL1AAlWsKSIebUIXjyBv4BJdEnaHFgkwXwJcc+3Mg/uynPnuJPw9aOebaczR1G/nhg0bxiu+E40ydwjMaERtw48tDAZiRPMiNpVGEtWZ9goRRac=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3136.eurprd08.prod.outlook.com (52.133.14.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 13:28:42 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 13:28:42 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm: Rename drm_bridge->dev to drm
Thread-Topic: [PATCH] drm: Rename drm_bridge->dev to drm
Thread-Index: AQHVq4lXPN/wPtLXyE2pxOrtyWLc3Ker2ioAgAEef4CAAAlgAIAGK6UAgAAJsYA=
Date:   Tue, 10 Dec 2019 13:28:42 +0000
Message-ID: <1934781.Wy2AY364az@e123338-lin>
References: <20191205163028.19941-1-mihail.atanassov@arm.com>
 <55bdd2ef-1033-9ae4-f033-bf6c3984cc95@suse.de>
 <20191210101250.GQ624164@phenom.ffwll.local>
In-Reply-To: <20191210101250.GQ624164@phenom.ffwll.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0304.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::28) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ee1aec6b-031d-4d0c-de87-08d77d74e4a1
X-MS-TrafficTypeDiagnostic: VI1PR08MB3136:|DB6PR08MB2663:
X-Microsoft-Antispam-PRVS: <DB6PR08MB26638DA10D4F028F110DE0FE8F5B0@DB6PR08MB2663.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3968;OLM:3968;
x-forefront-prvs: 02475B2A01
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(189003)(199004)(54906003)(966005)(110136005)(4326008)(186003)(26005)(6506007)(316002)(7416002)(2906002)(86362001)(478600001)(66476007)(81156014)(9686003)(6512007)(64756008)(81166006)(8676002)(5660300002)(8936002)(6486002)(30864003)(71200400001)(33716001)(52116002)(66446008)(66946007)(66556008)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3136;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: rSK37nTxetFYCi7eRp8yXSIcjmG5kkN4KtGriFTBdTPS4bPFeoKlA5FWM0Gn5CbfyVFxxDRUQMS9olga/LXT/YKcFRhQAyfK4xhq5hVj3mu2cqX9QJbUtJSTpxYdLBKVy8/tZv65CfpjWZV3Wo7I+rmT1MqJG8K2QiWK5IGsn4JZ2JCae33KQsNvqxvoXpOpzS6mpV13CQTFSaVYp5uoVrduEw6+8RYc95lBP35RFlHX400+7/aALjH6SHB69Fz600mYFqqT1EvSYFA8RcXbf/urgeBYxT1/p1vGPo3JTyp3hhzXwZdyNlx6kGCvpS9XS82ppEjWsYzN1Bn7ZNfNL/CZ+2ZEHfpuS01fhMBiMg2lbllvHlzIUblOCfFezvUAeEsC+YaCRwO2ponRzqAERDKHKbx78I3wFyFQUR2W4Js/rbqCyGjmHjhCBRqaAg1FW6Wk5zVRGlScC/y2RgGDmizvHJLBDDhR7APWYCKWtc4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD800F25E00E894382C2DC2898F832E0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3136
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(346002)(376002)(39860400002)(136003)(189003)(199004)(110136005)(70206006)(70586007)(54906003)(8676002)(356004)(33716001)(6506007)(336012)(2906002)(81156014)(26005)(81166006)(186003)(5660300002)(4326008)(6486002)(9686003)(966005)(86362001)(8936002)(316002)(30864003)(6512007)(26826003)(478600001)(76130400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR08MB2663;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5a2b586e-e388-4b3d-8ad8-08d77d74dfb9
NoDisclaimer: True
X-Forefront-PRVS: 02475B2A01
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMyCAiLZ4O3+WaErvVXG8pof9hCrTCpopcUZP6UCvqysAQrMHvS5L3/sMLsrLmiaS+H0uEwB70CJ3VsVzL5H0PVASi5xijkpbd9ppBH2eUbU+Zh+nyLexQNblHFdjIe2m1bb+YcQ3MGukMYpSiqQ7imC+zNY11JKQ/Tm25KFM5R/WoAM6oNFP8fpoZ8V08F4mPmR1ExZ9hSnK4kVuoA4FmHdvcHRunUJOhJ3fSoTCQ+pYNhbzEViQPzg+clYdtW4u6lXEQ7CKnQC+vskoLLaRwKp/XQ70W2AQ+g0WsRFDoYobVycb9gZ/yf5K9exJSIDyEqZnkJFc7Nvc3BCmam64akbH7SzcHyNuzB+GcN6F3r9x8YwAvodv91vY9aI6yI020cy1TtIZO/SPdANifsdmvIFB8gc9WKGC2MYMj+wg9q/fQt/3CSl9bvcPO2Ukvgrazv/Im0tx2MZxk7nSg6gPF7TMq9Pb8bZaNX33Ijn99Q=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 13:28:50.0875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1aec6b-031d-4d0c-de87-08d77d74e4a1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2663
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 10 December 2019 10:12:50 GMT Daniel Vetter wrote:
> On Fri, Dec 06, 2019 at 12:59:04PM +0100, Thomas Zimmermann wrote:
> > Hi
> >=20
> > Am 06.12.19 um 12:25 schrieb Mihail Atanassov:
> > > Hallo Thomas,
> > >=20
> > > On Thursday, 5 December 2019 18:20:06 GMT Thomas Zimmermann wrote:
> > >> Hi
> > >>
> > >> Am 05.12.19 um 17:30 schrieb Mihail Atanassov:
> > >>> The 'dev' name causes some confusion with 'struct device' [1][2], s=
o use
> > >>> 'drm' instead since this seems to be the prevalent name for 'struct
> > >>> drm_device' members.
> > >>>
> > >>> [1] https://patchwork.freedesktop.org/patch/342472/?series=3D70039&=
rev=3D1
> > >>> [2] https://patchwork.freedesktop.org/patch/343643/?series=3D70432&=
rev=3D1
> > >>
> > >> I read through the provided links, but can't see why is it called 'd=
rm'.
> > >> That sounds like a reference to a DRM driver structure to me.
> > >=20
> > > There are about 550 hits on 'struct drm_device *drm', so I gathered t=
hat
> > > it's the most common alternative to just naming it 'dev' (at about 4.=
5k
> > > hits in the codebase). There's also 'ddev', 'drm_dev', 'drmdev' with
> > > few hits.
> > >=20
> > >>
> > >> What about attached_dev or consumer_dev or encoder_dev?
> > >=20
> > > Those would be more descriptive, if you think it's worth sidestepping
> > > the above convention a bit. I don't mind either way.
> >=20
> > Well, I don't have a say on these things, but it's worth considering a
> > more descriptive name IMHO.
> >=20
> > I also wonder why that field is there in the first place. Invoking
> > drm_bridge_attach() sets the encoder and its dev field for the bridge.
> > [1] Could the dev field be removed and all users refer to encoder->dev
> > instead? If so, it seems like the better way to go.
>=20
> That sounds like a pretty neat idea (if possible) ...
> -Daniel
>=20

OK, I'll poke at it a bit and see what falls out. I'm guessing we don't
particularly care about the extra pointer being dereferenced in driver code=
?
The vast majority of the uses are in attach/detach logic so fairly benign b=
ut
we do have a few in IRQs.

> >=20
> > Best regards
> > Thomas
> >=20
> > [1]
> > https://elixir.bootlin.com/linux/v5.4.2/source/drivers/gpu/drm/drm_brid=
ge.c#L128
> >=20
> > >=20
> > >>
> > >> Best regards
> > >> Thomas
> > >>
> > >>>
> > >>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > >>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > >>> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > >>> ---
> > >>>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c         |  2 +-
> > >>>  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c   |  2 +-
> > >>>  drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c   |  2 +-
> > >>>  drivers/gpu/drm/bridge/cdns-dsi.c                    |  2 +-
> > >>>  drivers/gpu/drm/bridge/dumb-vga-dac.c                |  2 +-
> > >>>  .../gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c |  2 +-
> > >>>  drivers/gpu/drm/bridge/nxp-ptn3460.c                 |  2 +-
> > >>>  drivers/gpu/drm/bridge/panel.c                       |  2 +-
> > >>>  drivers/gpu/drm/bridge/parade-ps8622.c               |  2 +-
> > >>>  drivers/gpu/drm/bridge/sii902x.c                     |  6 +++---
> > >>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c            |  6 +++---
> > >>>  drivers/gpu/drm/bridge/tc358764.c                    |  4 ++--
> > >>>  drivers/gpu/drm/bridge/tc358767.c                    |  6 +++---
> > >>>  drivers/gpu/drm/bridge/ti-sn65dsi86.c                |  2 +-
> > >>>  drivers/gpu/drm/bridge/ti-tfp410.c                   |  6 +++---
> > >>>  drivers/gpu/drm/drm_bridge.c                         | 12 ++++++--=
----
> > >>>  drivers/gpu/drm/i2c/tda998x_drv.c                    |  2 +-
> > >>>  drivers/gpu/drm/mcde/mcde_dsi.c                      |  2 +-
> > >>>  drivers/gpu/drm/msm/edp/edp_bridge.c                 |  2 +-
> > >>>  drivers/gpu/drm/msm/hdmi/hdmi_bridge.c               |  4 ++--
> > >>>  drivers/gpu/drm/rcar-du/rcar_lvds.c                  |  2 +-
> > >>>  include/drm/drm_bridge.h                             |  4 ++--
> > >>>  22 files changed, 38 insertions(+), 38 deletions(-)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers=
/gpu/drm/bridge/adv7511/adv7511_drv.c
> > >>> index 9e13e466e72c..db7d01cb0923 100644
> > >>> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > >>> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > >>> @@ -863,7 +863,7 @@ static int adv7511_bridge_attach(struct drm_bri=
dge *bridge)
> > >>>  		adv->connector.polled =3D DRM_CONNECTOR_POLL_CONNECT |
> > >>>  				DRM_CONNECTOR_POLL_DISCONNECT;
> > >>> =20
> > >>> -	ret =3D drm_connector_init(bridge->dev, &adv->connector,
> > >>> +	ret =3D drm_connector_init(bridge->drm, &adv->connector,
> > >>>  				 &adv7511_connector_funcs,
> > >>>  				 DRM_MODE_CONNECTOR_HDMIA);
> > >>>  	if (ret) {
> > >>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/d=
rivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> > >>> index b4f3a923a52a..0e3508aeaa6c 100644
> > >>> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> > >>> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> > >>> @@ -541,7 +541,7 @@ static int anx6345_bridge_attach(struct drm_bri=
dge *bridge)
> > >>>  		return err;
> > >>>  	}
> > >>> =20
> > >>> -	err =3D drm_connector_init(bridge->dev, &anx6345->connector,
> > >>> +	err =3D drm_connector_init(bridge->drm, &anx6345->connector,
> > >>>  				 &anx6345_connector_funcs,
> > >>>  				 DRM_MODE_CONNECTOR_eDP);
> > >>>  	if (err) {
> > >>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/d=
rivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> > >>> index 41867be03751..d5722bc28933 100644
> > >>> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> > >>> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> > >>> @@ -908,7 +908,7 @@ static int anx78xx_bridge_attach(struct drm_bri=
dge *bridge)
> > >>>  		return err;
> > >>>  	}
> > >>> =20
> > >>> -	err =3D drm_connector_init(bridge->dev, &anx78xx->connector,
> > >>> +	err =3D drm_connector_init(bridge->drm, &anx78xx->connector,
> > >>>  				 &anx78xx_connector_funcs,
> > >>>  				 DRM_MODE_CONNECTOR_DisplayPort);
> > >>>  	if (err) {
> > >>> diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/br=
idge/cdns-dsi.c
> > >>> index 3a5bd4e7fd1e..f6d7e97de66e 100644
> > >>> --- a/drivers/gpu/drm/bridge/cdns-dsi.c
> > >>> +++ b/drivers/gpu/drm/bridge/cdns-dsi.c
> > >>> @@ -651,7 +651,7 @@ static int cdns_dsi_bridge_attach(struct drm_br=
idge *bridge)
> > >>>  	struct cdns_dsi *dsi =3D input_to_dsi(input);
> > >>>  	struct cdns_dsi_output *output =3D &dsi->output;
> > >>> =20
> > >>> -	if (!drm_core_check_feature(bridge->dev, DRIVER_ATOMIC)) {
> > >>> +	if (!drm_core_check_feature(bridge->drm, DRIVER_ATOMIC)) {
> > >>>  		dev_err(dsi->base.dev,
> > >>>  			"cdns-dsi driver is only compatible with DRM devices supporting=
 atomic updates");
> > >>>  		return -ENOTSUPP;
> > >>> diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/dr=
m/bridge/dumb-vga-dac.c
> > >>> index cc33dc411b9e..30b5e54df381 100644
> > >>> --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> > >>> +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
> > >>> @@ -112,7 +112,7 @@ static int dumb_vga_attach(struct drm_bridge *b=
ridge)
> > >>> =20
> > >>>  	drm_connector_helper_add(&vga->connector,
> > >>>  				 &dumb_vga_con_helper_funcs);
> > >>> -	ret =3D drm_connector_init_with_ddc(bridge->dev, &vga->connector,
> > >>> +	ret =3D drm_connector_init_with_ddc(bridge->drm, &vga->connector,
> > >>>  					  &dumb_vga_con_funcs,
> > >>>  					  DRM_MODE_CONNECTOR_VGA,
> > >>>  					  vga->ddc);
> > >>> diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw=
.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > >>> index e8a49f6146c6..ab06394cfff7 100644
> > >>> --- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > >>> +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > >>> @@ -223,7 +223,7 @@ static int ge_b850v3_lvds_attach(struct drm_bri=
dge *bridge)
> > >>>  	drm_connector_helper_add(connector,
> > >>>  				 &ge_b850v3_lvds_connector_helper_funcs);
> > >>> =20
> > >>> -	ret =3D drm_connector_init(bridge->dev, connector,
> > >>> +	ret =3D drm_connector_init(bridge->drm, connector,
> > >>>  				 &ge_b850v3_lvds_connector_funcs,
> > >>>  				 DRM_MODE_CONNECTOR_DisplayPort);
> > >>>  	if (ret) {
> > >>> diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm=
/bridge/nxp-ptn3460.c
> > >>> index 57ff01339559..714cb954522a 100644
> > >>> --- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
> > >>> +++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
> > >>> @@ -247,7 +247,7 @@ static int ptn3460_bridge_attach(struct drm_bri=
dge *bridge)
> > >>>  	}
> > >>> =20
> > >>>  	ptn_bridge->connector.polled =3D DRM_CONNECTOR_POLL_HPD;
> > >>> -	ret =3D drm_connector_init(bridge->dev, &ptn_bridge->connector,
> > >>> +	ret =3D drm_connector_init(bridge->drm, &ptn_bridge->connector,
> > >>>  			&ptn3460_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
> > >>>  	if (ret) {
> > >>>  		DRM_ERROR("Failed to initialize connector with drm\n");
> > >>> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridg=
e/panel.c
> > >>> index f4e293e7cf64..7ed3b3e85f03 100644
> > >>> --- a/drivers/gpu/drm/bridge/panel.c
> > >>> +++ b/drivers/gpu/drm/bridge/panel.c
> > >>> @@ -67,7 +67,7 @@ static int panel_bridge_attach(struct drm_bridge =
*bridge)
> > >>>  	drm_connector_helper_add(connector,
> > >>>  				 &panel_bridge_connector_helper_funcs);
> > >>> =20
> > >>> -	ret =3D drm_connector_init(bridge->dev, connector,
> > >>> +	ret =3D drm_connector_init(bridge->drm, connector,
> > >>>  				 &panel_bridge_connector_funcs,
> > >>>  				 panel_bridge->connector_type);
> > >>>  	if (ret) {
> > >>> diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/d=
rm/bridge/parade-ps8622.c
> > >>> index b7a72dfdcac3..18cc693734b3 100644
> > >>> --- a/drivers/gpu/drm/bridge/parade-ps8622.c
> > >>> +++ b/drivers/gpu/drm/bridge/parade-ps8622.c
> > >>> @@ -487,7 +487,7 @@ static int ps8622_attach(struct drm_bridge *bri=
dge)
> > >>>  	}
> > >>> =20
> > >>>  	ps8622->connector.polled =3D DRM_CONNECTOR_POLL_HPD;
> > >>> -	ret =3D drm_connector_init(bridge->dev, &ps8622->connector,
> > >>> +	ret =3D drm_connector_init(bridge->drm, &ps8622->connector,
> > >>>  			&ps8622_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
> > >>>  	if (ret) {
> > >>>  		DRM_ERROR("Failed to initialize connector with drm\n");
> > >>> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bri=
dge/sii902x.c
> > >>> index b70e8c5cf2e1..3d8b3e1eb0aa 100644
> > >>> --- a/drivers/gpu/drm/bridge/sii902x.c
> > >>> +++ b/drivers/gpu/drm/bridge/sii902x.c
> > >>> @@ -402,7 +402,7 @@ static void sii902x_bridge_mode_set(struct drm_=
bridge *bridge,
> > >>>  static int sii902x_bridge_attach(struct drm_bridge *bridge)
> > >>>  {
> > >>>  	struct sii902x *sii902x =3D bridge_to_sii902x(bridge);
> > >>> -	struct drm_device *drm =3D bridge->dev;
> > >>> +	struct drm_device *drm =3D bridge->drm;
> > >>>  	int ret;
> > >>> =20
> > >>>  	drm_connector_helper_add(&sii902x->connector,
> > >>> @@ -820,8 +820,8 @@ static irqreturn_t sii902x_interrupt(int irq, v=
oid *data)
> > >>> =20
> > >>>  	mutex_unlock(&sii902x->mutex);
> > >>> =20
> > >>> -	if ((status & SII902X_HOTPLUG_EVENT) && sii902x->bridge.dev)
> > >>> -		drm_helper_hpd_irq_event(sii902x->bridge.dev);
> > >>> +	if ((status & SII902X_HOTPLUG_EVENT) && sii902x->bridge.drm)
> > >>> +		drm_helper_hpd_irq_event(sii902x->bridge.drm);
> > >>> =20
> > >>>  	return IRQ_HANDLED;
> > >>>  }
> > >>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gp=
u/drm/bridge/synopsys/dw-hdmi.c
> > >>> index dbe38a54870b..7a549cce8536 100644
> > >>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > >>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > >>> @@ -2346,7 +2346,7 @@ static int dw_hdmi_bridge_attach(struct drm_b=
ridge *bridge)
> > >>> =20
> > >>>  	drm_connector_helper_add(connector, &dw_hdmi_connector_helper_fun=
cs);
> > >>> =20
> > >>> -	drm_connector_init_with_ddc(bridge->dev, connector,
> > >>> +	drm_connector_init_with_ddc(bridge->drm, connector,
> > >>>  				    &dw_hdmi_connector_funcs,
> > >>>  				    DRM_MODE_CONNECTOR_HDMIA,
> > >>>  				    hdmi->ddc);
> > >>> @@ -2554,8 +2554,8 @@ static irqreturn_t dw_hdmi_irq(int irq, void =
*dev_id)
> > >>>  	if (intr_stat & HDMI_IH_PHY_STAT0_HPD) {
> > >>>  		dev_dbg(hdmi->dev, "EVENT=3D%s\n",
> > >>>  			phy_int_pol & HDMI_PHY_HPD ? "plugin" : "plugout");
> > >>> -		if (hdmi->bridge.dev)
> > >>> -			drm_helper_hpd_irq_event(hdmi->bridge.dev);
> > >>> +		if (hdmi->bridge.drm)
> > >>> +			drm_helper_hpd_irq_event(hdmi->bridge.drm);
> > >>>  	}
> > >>> =20
> > >>>  	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
> > >>> diff --git a/drivers/gpu/drm/bridge/tc358764.c b/drivers/gpu/drm/br=
idge/tc358764.c
> > >>> index db298f550a5a..1744d7daa534 100644
> > >>> --- a/drivers/gpu/drm/bridge/tc358764.c
> > >>> +++ b/drivers/gpu/drm/bridge/tc358764.c
> > >>> @@ -352,7 +352,7 @@ static void tc358764_enable(struct drm_bridge *=
bridge)
> > >>>  static int tc358764_attach(struct drm_bridge *bridge)
> > >>>  {
> > >>>  	struct tc358764 *ctx =3D bridge_to_tc358764(bridge);
> > >>> -	struct drm_device *drm =3D bridge->dev;
> > >>> +	struct drm_device *drm =3D bridge->drm;
> > >>>  	int ret;
> > >>> =20
> > >>>  	ctx->connector.polled =3D DRM_CONNECTOR_POLL_HPD;
> > >>> @@ -378,7 +378,7 @@ static int tc358764_attach(struct drm_bridge *b=
ridge)
> > >>>  static void tc358764_detach(struct drm_bridge *bridge)
> > >>>  {
> > >>>  	struct tc358764 *ctx =3D bridge_to_tc358764(bridge);
> > >>> -	struct drm_device *drm =3D bridge->dev;
> > >>> +	struct drm_device *drm =3D bridge->drm;
> > >>> =20
> > >>>  	drm_connector_unregister(&ctx->connector);
> > >>>  	drm_fb_helper_remove_one_connector(drm->fb_helper, &ctx->connecto=
r);
> > >>> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/br=
idge/tc358767.c
> > >>> index 8029478ffebb..fccacd12bb53 100644
> > >>> --- a/drivers/gpu/drm/bridge/tc358767.c
> > >>> +++ b/drivers/gpu/drm/bridge/tc358767.c
> > >>> @@ -1407,7 +1407,7 @@ static int tc_bridge_attach(struct drm_bridge=
 *bridge)
> > >>>  {
> > >>>  	u32 bus_format =3D MEDIA_BUS_FMT_RGB888_1X24;
> > >>>  	struct tc_data *tc =3D bridge_to_tc(bridge);
> > >>> -	struct drm_device *drm =3D bridge->dev;
> > >>> +	struct drm_device *drm =3D bridge->drm;
> > >>>  	int ret;
> > >>> =20
> > >>>  	/* Create DP/eDP connector */
> > >>> @@ -1514,7 +1514,7 @@ static irqreturn_t tc_irq_handler(int irq, vo=
id *arg)
> > >>>  		dev_err(tc->dev, "syserr %x\n", stat);
> > >>>  	}
> > >>> =20
> > >>> -	if (tc->hpd_pin >=3D 0 && tc->bridge.dev) {
> > >>> +	if (tc->hpd_pin >=3D 0 && tc->bridge.drm) {
> > >>>  		/*
> > >>>  		 * H is triggered when the GPIO goes high.
> > >>>  		 *
> > >>> @@ -1528,7 +1528,7 @@ static irqreturn_t tc_irq_handler(int irq, vo=
id *arg)
> > >>>  			h ? "H" : "", lc ? "LC" : "");
> > >>> =20
> > >>>  		if (h || lc)
> > >>> -			drm_kms_helper_hotplug_event(tc->bridge.dev);
> > >>> +			drm_kms_helper_hotplug_event(tc->bridge.drm);
> > >>>  	}
> > >>> =20
> > >>>  	regmap_write(tc->regmap, INTSTS_G, val);
> > >>> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/dr=
m/bridge/ti-sn65dsi86.c
> > >>> index 43abf01ebd4c..23576c3fac9f 100644
> > >>> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > >>> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > >>> @@ -275,7 +275,7 @@ static int ti_sn_bridge_attach(struct drm_bridg=
e *bridge)
> > >>>  						   .node =3D NULL,
> > >>>  						 };
> > >>> =20
> > >>> -	ret =3D drm_connector_init(bridge->dev, &pdata->connector,
> > >>> +	ret =3D drm_connector_init(bridge->drm, &pdata->connector,
> > >>>  				 &ti_sn_bridge_connector_funcs,
> > >>>  				 DRM_MODE_CONNECTOR_eDP);
> > >>>  	if (ret) {
> > >>> diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/b=
ridge/ti-tfp410.c
> > >>> index aa3198dc9903..cae9fd584ff1 100644
> > >>> --- a/drivers/gpu/drm/bridge/ti-tfp410.c
> > >>> +++ b/drivers/gpu/drm/bridge/ti-tfp410.c
> > >>> @@ -135,7 +135,7 @@ static int tfp410_attach(struct drm_bridge *bri=
dge)
> > >>> =20
> > >>>  	drm_connector_helper_add(&dvi->connector,
> > >>>  				 &tfp410_con_helper_funcs);
> > >>> -	ret =3D drm_connector_init_with_ddc(bridge->dev, &dvi->connector,
> > >>> +	ret =3D drm_connector_init_with_ddc(bridge->drm, &dvi->connector,
> > >>>  					  &tfp410_con_funcs,
> > >>>  					  dvi->connector_type,
> > >>>  					  dvi->ddc);
> > >>> @@ -179,8 +179,8 @@ static void tfp410_hpd_work_func(struct work_st=
ruct *work)
> > >>> =20
> > >>>  	dvi =3D container_of(work, struct tfp410, hpd_work.work);
> > >>> =20
> > >>> -	if (dvi->bridge.dev)
> > >>> -		drm_helper_hpd_irq_event(dvi->bridge.dev);
> > >>> +	if (dvi->bridge.drm)
> > >>> +		drm_helper_hpd_irq_event(dvi->bridge.drm);
> > >>>  }
> > >>> =20
> > >>>  static irqreturn_t tfp410_hpd_irq_thread(int irq, void *arg)
> > >>> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bri=
dge.c
> > >>> index cba537c99e43..80f7a1aa969e 100644
> > >>> --- a/drivers/gpu/drm/drm_bridge.c
> > >>> +++ b/drivers/gpu/drm/drm_bridge.c
> > >>> @@ -119,19 +119,19 @@ int drm_bridge_attach(struct drm_encoder *enc=
oder, struct drm_bridge *bridge,
> > >>>  	if (!encoder || !bridge)
> > >>>  		return -EINVAL;
> > >>> =20
> > >>> -	if (previous && (!previous->dev || previous->encoder !=3D encoder=
))
> > >>> +	if (previous && (!previous->drm || previous->encoder !=3D encoder=
))
> > >>>  		return -EINVAL;
> > >>> =20
> > >>> -	if (bridge->dev)
> > >>> +	if (bridge->drm)
> > >>>  		return -EBUSY;
> > >>> =20
> > >>> -	bridge->dev =3D encoder->dev;
> > >>> +	bridge->drm =3D encoder->dev;
> > >>>  	bridge->encoder =3D encoder;
> > >>> =20
> > >>>  	if (bridge->funcs->attach) {
> > >>>  		ret =3D bridge->funcs->attach(bridge);
> > >>>  		if (ret < 0) {
> > >>> -			bridge->dev =3D NULL;
> > >>> +			bridge->drm =3D NULL;
> > >>>  			bridge->encoder =3D NULL;
> > >>>  			return ret;
> > >>>  		}
> > >>> @@ -151,13 +151,13 @@ void drm_bridge_detach(struct drm_bridge *bri=
dge)
> > >>>  	if (WARN_ON(!bridge))
> > >>>  		return;
> > >>> =20
> > >>> -	if (WARN_ON(!bridge->dev))
> > >>> +	if (WARN_ON(!bridge->drm))
> > >>>  		return;
> > >>> =20
> > >>>  	if (bridge->funcs->detach)
> > >>>  		bridge->funcs->detach(bridge);
> > >>> =20
> > >>> -	bridge->dev =3D NULL;
> > >>> +	bridge->drm =3D NULL;
> > >>>  }
> > >>> =20
> > >>>  /**
> > >>> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2=
c/tda998x_drv.c
> > >>> index a63790d32d75..fa430e43f5ad 100644
> > >>> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> > >>> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> > >>> @@ -1360,7 +1360,7 @@ static int tda998x_bridge_attach(struct drm_b=
ridge *bridge)
> > >>>  {
> > >>>  	struct tda998x_priv *priv =3D bridge_to_tda998x_priv(bridge);
> > >>> =20
> > >>> -	return tda998x_connector_init(priv, bridge->dev);
> > >>> +	return tda998x_connector_init(priv, bridge->drm);
> > >>>  }
> > >>> =20
> > >>>  static void tda998x_bridge_detach(struct drm_bridge *bridge)
> > >>> diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde=
/mcde_dsi.c
> > >>> index 42fff811653e..4ef14d5cdcb6 100644
> > >>> --- a/drivers/gpu/drm/mcde/mcde_dsi.c
> > >>> +++ b/drivers/gpu/drm/mcde/mcde_dsi.c
> > >>> @@ -846,7 +846,7 @@ static void mcde_dsi_bridge_disable(struct drm_=
bridge *bridge)
> > >>>  static int mcde_dsi_bridge_attach(struct drm_bridge *bridge)
> > >>>  {
> > >>>  	struct mcde_dsi *d =3D bridge_to_mcde_dsi(bridge);
> > >>> -	struct drm_device *drm =3D bridge->dev;
> > >>> +	struct drm_device *drm =3D bridge->drm;
> > >>>  	int ret;
> > >>> =20
> > >>>  	if (!drm_core_check_feature(drm, DRIVER_ATOMIC)) {
> > >>> diff --git a/drivers/gpu/drm/msm/edp/edp_bridge.c b/drivers/gpu/drm=
/msm/edp/edp_bridge.c
> > >>> index 2950bba4aca9..a329c7a79d8d 100644
> > >>> --- a/drivers/gpu/drm/msm/edp/edp_bridge.c
> > >>> +++ b/drivers/gpu/drm/msm/edp/edp_bridge.c
> > >>> @@ -47,7 +47,7 @@ static void edp_bridge_mode_set(struct drm_bridge=
 *bridge,
> > >>>  		const struct drm_display_mode *mode,
> > >>>  		const struct drm_display_mode *adjusted_mode)
> > >>>  {
> > >>> -	struct drm_device *dev =3D bridge->dev;
> > >>> +	struct drm_device *dev =3D bridge->drm;
> > >>>  	struct drm_connector *connector;
> > >>>  	struct edp_bridge *edp_bridge =3D to_edp_bridge(bridge);
> > >>>  	struct msm_edp *edp =3D edp_bridge->edp;
> > >>> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/d=
rm/msm/hdmi/hdmi_bridge.c
> > >>> index ba81338a9bf8..0add3c88a13e 100644
> > >>> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> > >>> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> > >>> @@ -20,7 +20,7 @@ void msm_hdmi_bridge_destroy(struct drm_bridge *b=
ridge)
> > >>> =20
> > >>>  static void msm_hdmi_power_on(struct drm_bridge *bridge)
> > >>>  {
> > >>> -	struct drm_device *dev =3D bridge->dev;
> > >>> +	struct drm_device *dev =3D bridge->drm;
> > >>>  	struct hdmi_bridge *hdmi_bridge =3D to_hdmi_bridge(bridge);
> > >>>  	struct hdmi *hdmi =3D hdmi_bridge->hdmi;
> > >>>  	const struct hdmi_platform_config *config =3D hdmi->config;
> > >>> @@ -56,7 +56,7 @@ static void msm_hdmi_power_on(struct drm_bridge *=
bridge)
> > >>> =20
> > >>>  static void power_off(struct drm_bridge *bridge)
> > >>>  {
> > >>> -	struct drm_device *dev =3D bridge->dev;
> > >>> +	struct drm_device *dev =3D bridge->drm;
> > >>>  	struct hdmi_bridge *hdmi_bridge =3D to_hdmi_bridge(bridge);
> > >>>  	struct hdmi *hdmi =3D hdmi_bridge->hdmi;
> > >>>  	const struct hdmi_platform_config *config =3D hdmi->config;
> > >>> diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/=
rcar-du/rcar_lvds.c
> > >>> index 8c6c172bbf2e..12fcfbf31968 100644
> > >>> --- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
> > >>> +++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> > >>> @@ -622,7 +622,7 @@ static int rcar_lvds_attach(struct drm_bridge *=
bridge)
> > >>>  	if (!lvds->panel)
> > >>>  		return 0;
> > >>> =20
> > >>> -	ret =3D drm_connector_init(bridge->dev, connector, &rcar_lvds_con=
n_funcs,
> > >>> +	ret =3D drm_connector_init(bridge->drm, connector, &rcar_lvds_con=
n_funcs,
> > >>>  				 DRM_MODE_CONNECTOR_LVDS);
> > >>>  	if (ret < 0)
> > >>>  		return ret;
> > >>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > >>> index c0a2286a81e9..795860200ebf 100644
> > >>> --- a/include/drm/drm_bridge.h
> > >>> +++ b/include/drm/drm_bridge.h
> > >>> @@ -376,8 +376,8 @@ struct drm_bridge_timings {
> > >>>   * struct drm_bridge - central DRM bridge control structure
> > >>>   */
> > >>>  struct drm_bridge {
> > >>> -	/** @dev: DRM device this bridge belongs to */
> > >>> -	struct drm_device *dev;
> > >>> +	/** @drm: DRM device this bridge belongs to */
> > >>> +	struct drm_device *drm;
> > >>>  	/** @encoder: encoder to which this bridge is connected */
> > >>>  	struct drm_encoder *encoder;
> > >>>  	/** @next: the next bridge in the encoder chain */
> > >>>
> > >>
> > >>
> > >=20
> > >=20
> >=20
>=20
>=20
>=20
>=20
>=20


--=20
Mihail



