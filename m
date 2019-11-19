Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F528C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE782082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="S5ft5BzV";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="S5ft5BzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfKSJWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:22:31 -0500
Received: from mail-eopbgr00072.outbound.protection.outlook.com ([40.107.0.72]:60480
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfKSJWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhHu+aLMdQ/MYK8ualj+Qe0oxyBaY+ZAjF5v2hRFMOc=;
 b=S5ft5BzVLp0B3Bz1AJLAwGtNJIg1aKPlDnWky4QfuppQA8UuUwuUNbsFmjxt2RN4NgG8IzvX7wp6iStESAI+KWs/0mS5NBe41XKTaIZfyHG6tSvCzwEg4pEsUi3gwC011W5Z6Xm5S73hwrhXxFg4jk4DI/W2Vb9NcYwFafXysmg=
Received: from VI1PR0802CA0027.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::13) by DB6PR0801MB1751.eurprd08.prod.outlook.com
 (2603:10a6:4:2e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16; Tue, 19 Nov
 2019 09:22:20 +0000
Received: from VE1EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by VI1PR0802CA0027.outlook.office365.com
 (2603:10a6:800:a9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.26 via Frontend
 Transport; Tue, 19 Nov 2019 09:22:20 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT027.mail.protection.outlook.com (10.152.18.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Tue, 19 Nov 2019 09:22:20 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Tue, 19 Nov 2019 09:22:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8ca61f1f0f2b2958
X-CR-MTA-TID: 64aa7808
Received: from fce982040cec.2 (cr-mta-lb-1.cr-mta-net [104.47.5.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C1ECA74E-1743-49BA-A672-7010E434EFA6.1;
        Tue, 19 Nov 2019 09:22:10 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2057.outbound.protection.outlook.com [104.47.5.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fce982040cec.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 19 Nov 2019 09:22:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWMcFkUNExDO3dip/4hpEUVecJ5DyezdeM4vLrASZ/iCdNTnaTLKHbyI/GrTVH+7dTg6+F67ukHRr+7L/DdN7boayQOi/KcuMAhm2Q9DInfEAXq7sVGX/IbJCpC7liWZKwLWF/RpmnBVGYVNlo0j0TA/rLfpJ1JGN2SLh0r24C2me8/cyues/kJ3Tn3q4BQRRbX0c15eYo5xHi3fDRRdR++YFMjbz8trHZ1li3QMUdepzzxShPxhUQV6v0/UwHOjYWK6bYXrOcsB3OFzCeBEFxyuwWyiUcIIIC8/CjXCFOMlsRPXn4BMSVLKzPQHyxvsD5w7szDPfrq5+8+8zH38Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhHu+aLMdQ/MYK8ualj+Qe0oxyBaY+ZAjF5v2hRFMOc=;
 b=elvRVG38FdMiih3ayXhQ0VbuTbLu1yel0uP4177YWyvtcynpXOf/pP4goQDoK6lqlw4nM3mN0s+6Lua1/NSvlD8CiX8rhnN8GtdNzDsujRmQSk0s2fOzE56ugxKU6pb9KeWiJeoyq/DU7iHnAdNC3uR33H6Fx75STpKsCa52PYinRhgLs0LeqaghYWjApwayA7YJ6Xp3mabmmlcs1mYC+UlAmsFzz2peLB+sltlkYR+oXhVLGivDbM4pLZ0Sc98cZT/FX6qAo6qD6pVq7moY7FhzgmkMt1Vr7BgZI/pZG4K1wArEBtvEz5TdIxJxIVw0cE3SFqhrEPxrBNs5BjljzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhHu+aLMdQ/MYK8ualj+Qe0oxyBaY+ZAjF5v2hRFMOc=;
 b=S5ft5BzVLp0B3Bz1AJLAwGtNJIg1aKPlDnWky4QfuppQA8UuUwuUNbsFmjxt2RN4NgG8IzvX7wp6iStESAI+KWs/0mS5NBe41XKTaIZfyHG6tSvCzwEg4pEsUi3gwC011W5Z6Xm5S73hwrhXxFg4jk4DI/W2Vb9NcYwFafXysmg=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4782.eurprd08.prod.outlook.com (10.255.115.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Tue, 19 Nov 2019 09:22:07 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 09:22:07 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH v3 1/6] drm/komeda: Add side by side assembling
Thread-Topic: [PATCH v3 1/6] drm/komeda: Add side by side assembling
Thread-Index: AQHVmsa9UkYGk9o7O0O+920wharNZKeLWkAAgAbly4A=
Date:   Tue, 19 Nov 2019 09:22:07 +0000
Message-ID: <20191119092201.GC2881@jamwan02-TSP300>
References: <20191114083658.27237-1-james.qian.wang@arm.com>
 <20191114083658.27237-2-james.qian.wang@arm.com>
 <6478126.Gfiuz5foDL@e123338-lin>
In-Reply-To: <6478126.Gfiuz5foDL@e123338-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0040.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::28) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e37c4dc-b97f-4d93-6c22-08d76cd1fa92
X-MS-TrafficTypeDiagnostic: VE1PR08MB4782:|VE1PR08MB4782:|DB6PR0801MB1751:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1751DC0665D051E140F2E813B34C0@DB6PR0801MB1751.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:308;OLM:308;
x-forefront-prvs: 022649CC2C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(376002)(136003)(346002)(396003)(366004)(199004)(189003)(99286004)(71190400001)(2906002)(33656002)(6116002)(6862004)(86362001)(33716001)(4326008)(76176011)(26005)(25786009)(6512007)(11346002)(316002)(386003)(6506007)(6246003)(476003)(14454004)(6486002)(54906003)(5660300002)(66446008)(186003)(66946007)(66476007)(64756008)(66556008)(7736002)(1076003)(6436002)(6636002)(305945005)(229853002)(58126008)(446003)(3846002)(52116002)(55236004)(478600001)(102836004)(8936002)(71200400001)(9686003)(486006)(256004)(14444005)(8676002)(81156014)(81166006)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4782;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: QqV4qW9t36e7fVRwPULIcbwUjlkbiI/p/UmM/3avT6L3C8h+SG5sDS/tGbN26N3dJFngQVjX49eNi8O7H3QF7QGIr8KMFauXjVvVq0sH+An2XvmMK3Fw/yz7w08+KuzCBJDQf56+WYCxQJ8xN5rugOcHbnVPMvtrM/FoW8iFfSN7hxxxLQA8JqH8CzJ72CpoX6m5M/n+8yWdj/gBNPMhSFy8u7x/4J8M50HQFZklqOAOm5nnl/+NxIYxl1visr+TWZlhsn603xP5yJzF5sjben5i7F6Ev5DGp+A0plS3b3P379PuVSF4yURZyalm6/UIU0LZGtnbjGToonU/rW5zNR/z6dwYI71+whcXtl5f6xpTHioKHY3UepBQB5mPibtp8YjekZEndJ2++g0otM+Yr7DprYLV80ya8UlnkZyRhoZy8dAjcZKEno4rCnPd4OWJ
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C45671F45F9E054291B46CF9C8F27CEF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4782
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1110001)(339900001)(189003)(199004)(81166006)(9686003)(486006)(99286004)(11346002)(70206006)(478600001)(336012)(70586007)(14444005)(476003)(126002)(26826003)(6512007)(50466002)(446003)(76176011)(66066001)(2906002)(76130400001)(97756001)(54906003)(33716001)(23726003)(6862004)(1076003)(81156014)(105606002)(229853002)(186003)(7736002)(5660300002)(102836004)(22756006)(386003)(6486002)(26005)(4326008)(8676002)(6506007)(6246003)(46406003)(47776003)(14454004)(356004)(86362001)(6116002)(8936002)(58126008)(25786009)(8746002)(6636002)(316002)(305945005)(36906005)(33656002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1751;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a338e57e-5a17-4375-2ebc-08d76cd1f2a9
NoDisclaimer: True
X-Forefront-PRVS: 022649CC2C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dmZ7GDqYjTkexfZhPZE0WucJhjib/OOiyg96dH+pB3TApG70xgG9GM6QB4dO3dvqo08yG5jVwn5wuKBuHv2s4XVvcL4DVVd0QHhJexcpjDdSEqWxCMwT7CZn98BkdrfQQoEUqlrjWLGEg8FCnlLofAJjWNgLnbMqrHg7B8+CGazsCCz2LSUwnmLAUCH+ZH3fQdVc3a6K3jgBXKrXxIi2m8wIrbo4ECBg0Yqt7wkISkOVwTkVaz7F+P4fUPW3Uj+MRde6cLkUbhHG0brPHgn6LiXd8f96Mlb70QkpMo3mE+A6adkrL+KItILcSSVlU+1MDpbS8hgfHVTHffRLwB0XywBykGHDzTmpK9RMn5vIHpqYH8eb7p7LfNNIpVplLgQml68K8B3kroJXwGNbEeKotmlBXyL3ZkVBxS90PtQcs/3H+uIVFk8TwaXBhM6noaF
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2019 09:22:20.2698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e37c4dc-b97f-4d93-6c22-08d76cd1fa92
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1751
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 12:02:00AM +0000, Mihail Atanassov wrote:
> Hi James,
>=20
> On Thursday, 14 November 2019 08:37:24 GMT james qian wang (Arm Technolog=
y China) wrote:
> > Komeda HW can support side by side, which splits the internal display
> > processing to two single halves (LEFT/RIGHT) and handle them by two
> > pipelines separately.
> > komeda "side by side" is enabled by DT property: "side_by_side_master",
> > once DT configured side by side, komeda need to verify it with HW's
> > configuration, and assemble it for the further usage.
>=20
> A few problems I see with this approach:
>  - This property doesn't scale to >2 pipes;
>  - Our HW is capable of dynamically switching between SBS and non-SBS
> modes, with this DT property you're effectively denying the opportunity
> to use the second pipe when the first one can be satisfied with
> 4 planes and 1px/clk.
>=20
> If we only want to fix the first problem, then at least we need this
> to be a property of the pipeline node with a phandle linking slave to
> master (or bidirectional).

I had consider this way before, but consider we have no product (now
and in next 2/3 years) can support >2 pipes. So for DT I decide to
focus on current, but you may see I add two side_by_side flags.

  - mdev->side_by_side.
  - crtc->side_by_side.

And beside the DT parse we use mdev->side_by_side, the real SBS
operation actually based on crtc->side_by_side, then once the HW
changed, we only need to update the SBS assemble/decision code, but no
need to update the real sbs logic.

thanks
James

> For the second, why not do the SBS decision at modeset time?
> If the first CRTC has dual-link output and the commit:
>  - only drives one CRTC
>  - uses up to 4 planes
>  - doesn't meet clk requirements without SBS but does with SBS
> then we can switch SBS on dynamically.
> And we can tweak that decision with power use in mind later on since
> there's no user-visible knob.

Yes, you're right, current implementation just use simplest way to
show the feature, and for dynamic enable/disable sbs will be added
when we have the real usage case.

> We can still keep a DT property if we have a use case for it (e.g.
> forcing SBS on for some reason), but we might want to name it slightly
> more conservatively then, so it doesn't imply that we never do SBS
> when it's not there.
>=20
> Lastly, maintaining that property in combination with the dynamic
> modeset-time SBS decision tree means extra code for more or less the
> same functionality. <2c>I'm not 100% sure it's worth it.</2c>

I think we'd add such support when we have the real use case. :)

> >=20
> > v3: Correct a typo.
> >=20
> > Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@=
arm.com>
> > ---
> >  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 13 ++++-
> >  .../gpu/drm/arm/display/komeda/komeda_dev.c   |  3 ++
> >  .../gpu/drm/arm/display/komeda/komeda_dev.h   |  9 ++++
> >  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  3 ++
> >  .../drm/arm/display/komeda/komeda_pipeline.c  | 50 +++++++++++++++++--
> >  .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
> >  6 files changed, 73 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_crtc.c
> > index 1c452ea75999..cee9a1692e71 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > @@ -561,21 +561,30 @@ int komeda_kms_setup_crtcs(struct komeda_kms_dev =
*kms,
> >  	kms->n_crtcs =3D 0;
> > =20
> >  	for (i =3D 0; i < mdev->n_pipelines; i++) {
> > +		/* if sbs, one komeda_dev only can represent one CRTC */
> > +		if (mdev->side_by_side && i !=3D mdev->side_by_side_master)
> > +			continue;
> > +
> >  		crtc =3D &kms->crtcs[kms->n_crtcs];
> >  		master =3D mdev->pipelines[i];
> > =20
> >  		crtc->master =3D master;
> >  		crtc->slave  =3D komeda_pipeline_get_slave(master);
> > +		crtc->side_by_side =3D mdev->side_by_side;
> > =20
> >  		if (crtc->slave)
> >  			sprintf(str, "pipe-%d", crtc->slave->id);
> >  		else
> >  			sprintf(str, "None");
> > =20
> > -		DRM_INFO("CRTC-%d: master(pipe-%d) slave(%s).\n",
> > -			 kms->n_crtcs, master->id, str);
> > +		DRM_INFO("CRTC-%d: master(pipe-%d) slave(%s) sbs(%s).\n",
> > +			 kms->n_crtcs, master->id, str,
> > +			 crtc->side_by_side ? "On" : "Off");
> > =20
> >  		kms->n_crtcs++;
> > +
> > +		if (mdev->side_by_side)
> > +			break;
> >  	}
> > =20
> >  	return 0;
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_dev.c
> > index 4e46f650fddf..c3fa4835cb8d 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > @@ -178,6 +178,9 @@ static int komeda_parse_dt(struct device *dev, stru=
ct komeda_dev *mdev)
> >  		}
> >  	}
> > =20
> > +	mdev->side_by_side =3D !of_property_read_u32(np, "side_by_side_master=
",
> > +						   &mdev->side_by_side_master);
> > +
> >  	return ret;
> >  }
> > =20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/=
gpu/drm/arm/display/komeda/komeda_dev.h
> > index d406a4d83352..471604b42431 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > @@ -183,6 +183,15 @@ struct komeda_dev {
> > =20
> >  	/** @irq: irq number */
> >  	int irq;
> > +	/**
> > +	 * @side_by_side:
> > +	 *
> > +	 * on sbs the whole display frame will be split to two halves (1:2),
> > +	 * master pipeline handles the left part, slave for the right part
> > +	 */
> > +	bool side_by_side;
>=20
> That's a duplicate of the one in komeda_crtc. You don't need both.
>=20
> > +	/** @side_by_side_master: master pipe id for side by side */
> > +	int side_by_side_master;
>=20
> As I detailed above, this should be on the crtc, otherwise we can't
> scale to >2 pipes.
>=20
> > =20
> >  	/** @lock: used to protect dpmode */
> >  	struct mutex lock;
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/=
gpu/drm/arm/display/komeda/komeda_kms.h
> > index 456f3c435719..ae6654fe95e2 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > @@ -76,6 +76,9 @@ struct komeda_crtc {
> >  	 */
> >  	struct komeda_pipeline *slave;
> > =20
> > +	/** @side_by_side: if the master and slave works on side by side mode=
 */
> > +	bool side_by_side;
> > +
> >  	/** @slave_planes: komeda slave planes mask */
> >  	u32 slave_planes;
> > =20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_pipeline.c
> > index 452e505a1fd3..104e27cc1dc3 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
> > @@ -326,14 +326,56 @@ static void komeda_pipeline_assemble(struct komed=
a_pipeline *pipe)
> >  struct komeda_pipeline *
> >  komeda_pipeline_get_slave(struct komeda_pipeline *master)
> >  {
> > -	struct komeda_component *slave;
> > +	struct komeda_dev *mdev =3D master->mdev;
> > +	struct komeda_component *comp, *slave;
> > +	u32 avail_inputs;
> > +
> > +	/* on SBS, slave pipeline merge to master via image processor */
> > +	if (mdev->side_by_side) {
> > +		comp =3D &master->improc->base;
> > +		avail_inputs =3D KOMEDA_PIPELINE_IMPROCS;
> > +	} else {
> > +		comp =3D &master->compiz->base;
> > +		avail_inputs =3D KOMEDA_PIPELINE_COMPIZS;
> > +	}
> > =20
> > -	slave =3D komeda_component_pickup_input(&master->compiz->base,
> > -					      KOMEDA_PIPELINE_COMPIZS);
> > +	slave =3D komeda_component_pickup_input(comp, avail_inputs);
> > =20
> >  	return slave ? slave->pipeline : NULL;
> >  }
> > =20
> > +static int komeda_assemble_side_by_side(struct komeda_dev *mdev)
> > +{
> > +	struct komeda_pipeline *master, *slave;
> > +	int i;
> > +
> > +	if (!mdev->side_by_side)
> > +		return 0;
> > +
> > +	if (mdev->side_by_side_master >=3D mdev->n_pipelines) {
> > +		DRM_ERROR("DT configured side by side master-%d is invalid.\n",
> > +			  mdev->side_by_side_master);
> > +		return -EINVAL;
> > +	}
> > +
> > +	master =3D mdev->pipelines[mdev->side_by_side_master];
> > +	slave =3D komeda_pipeline_get_slave(master);
> > +	if (!slave || slave->n_layers !=3D master->n_layers) {
> > +		DRM_ERROR("Current HW doesn't support side by side.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!master->dual_link) {
> > +		DRM_DEBUG_ATOMIC("SBS can not work without dual link.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i =3D 0; i < master->n_layers; i++)
> > +		master->layers[i]->sbs_slave =3D slave->layers[i];
> > +
> > +	return 0;
> > +}
> > +
> >  int komeda_assemble_pipelines(struct komeda_dev *mdev)
> >  {
> >  	struct komeda_pipeline *pipe;
> > @@ -346,7 +388,7 @@ int komeda_assemble_pipelines(struct komeda_dev *md=
ev)
> >  		komeda_pipeline_dump(pipe);
> >  	}
> > =20
> > -	return 0;
> > +	return komeda_assemble_side_by_side(mdev);
> >  }
> > =20
> >  void komeda_pipeline_dump_register(struct komeda_pipeline *pipe,
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/dri=
vers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > index ac8725e24853..20a076cce635 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > @@ -237,6 +237,7 @@ struct komeda_layer {
> >  	 * not the source buffer.
> >  	 */
> >  	struct komeda_layer *right;
> > +	struct komeda_layer *sbs_slave;
> >  };
> > =20
> >  struct komeda_layer_state {
> >=20
>=20
>=20
> --=20
> Mihail
>=20
>=20
