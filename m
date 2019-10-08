Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3116C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DF220673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="WUWTjKZK";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="WUWTjKZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbfJHJ0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:26:23 -0400
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:49413
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729375AbfJHJ0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=et5jj9Pa/lqTdaeVe9uQpr0ARVsSQzejCF3aB4Qx17w=;
 b=WUWTjKZKkJzLuG08jyPF0GgTm+0eeimWX8xkPi+VM1bta+b293ZEof12pyxk980jevBmzHKwDwyr0Dn9oefZc5HLbUD1iNX8PVe0h//37W4KgZJXz5bBF3pNPaDPxdZ6rldJzR7JpIeGpTjG00VXSQ98Kaii/7S3tvJdtcpwGb0=
Received: from VI1PR08CA0271.eurprd08.prod.outlook.com (2603:10a6:803:dc::44)
 by DB6PR0801MB1781.eurprd08.prod.outlook.com (2603:10a6:4:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.23; Tue, 8 Oct
 2019 09:26:13 +0000
Received: from DB5EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by VI1PR08CA0271.outlook.office365.com
 (2603:10a6:803:dc::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Tue, 8 Oct 2019 09:26:12 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT031.mail.protection.outlook.com (10.152.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 8 Oct 2019 09:26:11 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Tue, 08 Oct 2019 09:26:05 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 03db2b03ffff9e6e
X-CR-MTA-TID: 64aa7808
Received: from f3e08f20f2f5.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 89E31E92-160F-4EAD-A454-02A61646212D.1;
        Tue, 08 Oct 2019 09:25:59 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2058.outbound.protection.outlook.com [104.47.4.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f3e08f20f2f5.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 08 Oct 2019 09:25:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jk4lCRAOEGg0xhUkJjaFiPVfg2IZ8qZn9akUwFgxl7flEzhkU4wWSm/td1i3R2ZSye/GiG1p2mj8L2RtW07ZdvQT6H1NrrcSg2rloF7a4aK3wJocIKlvX18yoIs2LIavZSdghi32dopDRcjfe4xfTqM2Hb4cqD6N55T4J3mi/nKTrdJMNgfEEhnT2BPrRYBkUIukF1fnJvLBXDYaIFxRU9fJiYalvse4F6ZkdOjGZVGpv2gTe8uXeGjuJDLZ1T9mxMRD/+TE+Sb6GVSI6N7eQt9Gpi0m9KH9SvXnGc2sYffcvQv3e+5bKPtY2vqp5YD/KkZduR24Zswfk5rYNIDwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=et5jj9Pa/lqTdaeVe9uQpr0ARVsSQzejCF3aB4Qx17w=;
 b=FR7hLpB4SW++ZF27dhQerTzpW/XqaqDFsuk8DQWwUNRg1QX/4uESiFJP3YSgKIn1eKhHI8cIzjA5HF93XOv4o/GEXgu3K9PNg6TrN0eVy9KEjnE5d4uinzxc/XWWqxsAOsVQ70NmifmQx0JV0oUFsTAha/jzB0PRp032u97G6WKHZiLHte9VC/zBR8bquMDrsYdEnN2SXr3iTHyd8mP7JsiS90/U4RUfA2F6KSpRydwSLl917iRw/gaidr7S6QiTLZLL60vR5G19nqvbsbertGXlxDeWmiIbYQnIVAdMD/YqtLqhae/P3mBVXPUIuBnZbnga+Wgb5tPLO3FCva4fbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=et5jj9Pa/lqTdaeVe9uQpr0ARVsSQzejCF3aB4Qx17w=;
 b=WUWTjKZKkJzLuG08jyPF0GgTm+0eeimWX8xkPi+VM1bta+b293ZEof12pyxk980jevBmzHKwDwyr0Dn9oefZc5HLbUD1iNX8PVe0h//37W4KgZJXz5bBF3pNPaDPxdZ6rldJzR7JpIeGpTjG00VXSQ98Kaii/7S3tvJdtcpwGb0=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3246.eurprd08.prod.outlook.com (52.134.123.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 09:25:57 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::e52a:a540:75ae:ced9]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::e52a:a540:75ae:ced9%4]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 09:25:57 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
CC:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds output-color format/depth support
Thread-Topic: [PATCH] drm/komeda: Adds output-color format/depth support
Thread-Index: AQHVb5fml3iiEtk+MEOqXjNduhm+kKc5MiiAgADp5ICAAhFyAIACqBcAgAVBDQCADH7tAA==
Date:   Tue, 8 Oct 2019 09:25:57 +0000
Message-ID: <20191008092550.GA19624@lowli01-ThinkStation-P300>
References: <20190920094329.17513-1-lowry.li@arm.com>
 <20190923121604.jqi6ewln27yvdajw@DESKTOP-E1NTVVP.localdomain>
 <20190924021313.GA15776@jamwan02-TSP300>
 <20190925094810.fbeyt7fxvyhaip33@DESKTOP-E1NTVVP.localdomain>
 <20190927022218.GA11732@jamwan02-TSP300>
 <20190930103626.de3p6rbowyerjbks@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190930103626.de3p6rbowyerjbks@DESKTOP-E1NTVVP.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR04CA0065.apcprd04.prod.outlook.com
 (2603:1096:202:14::33) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: c5c919ee-3dde-4d87-46b1-08d74bd18ed9
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3246:|VI1PR08MB3246:|DB6PR0801MB1781:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0801MB178101A172780406AF1B85859F9A0@DB6PR0801MB1781.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 01842C458A
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(189003)(199004)(55236004)(11346002)(446003)(476003)(486006)(86362001)(6862004)(6486002)(71200400001)(71190400001)(2906002)(14454004)(966005)(6636002)(229853002)(6506007)(8676002)(386003)(52116002)(33716001)(76176011)(26005)(186003)(102836004)(478600001)(1076003)(81156014)(81166006)(25786009)(8936002)(99286004)(66476007)(64756008)(66446008)(54906003)(58126008)(316002)(4326008)(66066001)(66556008)(5660300002)(66946007)(9686003)(6512007)(33656002)(6116002)(7736002)(3846002)(305945005)(6306002)(256004)(6436002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3246;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ly6a7NRTfbwe/5SSajOsCFqm5gWiOhVvHqp1yqIQBgidhBgJScKfP0sgHwtQRQleKbxU3OryxtGb3zQcAaFUjsWPxj+ff07BpPwVuAd/vr3hJa7RJHCdfyowzgpszeE1uMeDdhg9ltmKHtNBOe11zk79Ck7Sl7uBCQveKUYYubaNLH3X8sT0Ic80/hJ9CXxSkwVLkv+BhLs4vdByfpuQ82nRBSYdbPyEMEtDg0T1Ag098UQw9YZm42RTTI5UJHFL0VaAnkQVXE16aZyzsE1WKtsPlUIP0NL1TrQaqjqAWECFkCju1JVCKQiDjLpwlwxlyJnmytKCbgn3lKcPS9m3o4vVLe18A+0aUVCqcVxRWlfXTdUdVWWPdA6tB3MNkgrzc34g4cj5q+mr3nNZ7oCLiMzN+xvUKpBB8gQ04JrODWKTv2ctH00j6NBmX/7kgmvrZ+eWUKjc+9RhpivDi//JVw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4C87069E1AE9174BAE683E117AF3A4AA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3246
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(346002)(376002)(39860400002)(396003)(189003)(199004)(9686003)(76130400001)(70206006)(336012)(126002)(486006)(229853002)(70586007)(63350400001)(476003)(97756001)(46406003)(11346002)(446003)(47776003)(102836004)(3846002)(6512007)(2906002)(6486002)(23726003)(66066001)(6116002)(6306002)(86362001)(26005)(6246003)(386003)(6506007)(186003)(50466002)(4326008)(25786009)(33656002)(99286004)(22756006)(81166006)(14454004)(81156014)(6636002)(33716001)(6862004)(58126008)(8676002)(8936002)(478600001)(966005)(26826003)(316002)(76176011)(356004)(305945005)(54906003)(1076003)(8746002)(7736002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1781;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 36481227-7fa9-43b9-a5f6-08d74bd186a4
NoDisclaimer: True
X-Forefront-PRVS: 01842C458A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DmD4ANxZBa7JTuB07EPDOl/t7HD7qxqFdo3KZZxfqVUzJv+LNDH7I38xivEczbj1ED6K5OHWxjTMHiUmmXWXTKing8azKUbJnEqr1QMxmnVgMgrjdGo2vJOVWpPP4foMmPuJyR3Lrbp6JxgD7U6GCaUt1mZXPHd8KRbjR2ZPT2ROldU51k15esoVCRmyiIVieuZ0lFKOJvz7hEuU1u17Gk0nA7bRI4shhP9+PA0V2dowD/lK84TPcRIDUQ6WrZi97/yFBPahuu0E/HkTlRnoJCHdlBSao9uhp158lGO5z0M1QYbkq4SAj9OaUD1zMQoebayD5qpbOoRuwkv0Tn+yiGtaZEA/RbuSxthiV2wIMzi3OO/V1d6q4tUlZUD5P3a1vf4SDxz+iCNEZuWd/xkRn0c66hJkmg0qr51VJh5bDnPSZoCWiWgmuATSUC108Fk9Q6iToznO7oJfhUl9XkZcQw==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 09:26:11.2546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c919ee-3dde-4d87-46b1-08d74bd18ed9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1781
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 10:36:27AM +0000, Brian Starkey wrote:
> On Fri, Sep 27, 2019 at 02:22:24AM +0000, james qian wang (Arm Technology=
 China) wrote:
> > On Wed, Sep 25, 2019 at 09:48:11AM +0000, Brian Starkey wrote:
> > > Hi James,
> > >=20
> > > On Tue, Sep 24, 2019 at 02:13:27AM +0000, james qian wang (Arm Techno=
logy China) wrote:
> > > >=20
> > > > Hi Brian:
> > > >=20
> > > > Since one monitor can support mutiple color-formats, this DT proper=
ty
> > > > supply a way for user to select a specific one from this supported
> > > > color-formats.
> > >=20
> > > Modifying DT is a _really_ user-unfriendly way of specifying
> > > preferences. If we want a user to be able to pick a preferred format,
> > > then it should probably be via the atomic API as Ville mentioned.
> > >
> >=20
> > Hi Brian:
> >=20
> > Agree, a drm UPAI might be the best & right way for this.
> >=20
> > I can raise a new thread/topic to discuss the "HOW TO", maybe after the
> > Chinese national day.
> >=20
> > LAST:
> > what do you think about this patch:
> > - Just drop it, waiting for the new uapi
> > - or keep it, and replace it once new uapi is ready.
>=20
> The bit-depth stuff is clear and non-controversial, so you could split
> that out and merge it.
>=20
> For the YUV stuff, I think it would be fine to merge the
> implementation that we discussed here - force YUV for modes which must
> be YUV, and leave the user-preference stuff for a later UAPI.
>=20
> Thanks,
> -Brian
>=20
Hi Brian,
We've split color depth out. Thanks for your comments.
https://patchwork.freedesktop.org/series/67730/

Regards,
Lowry
> >=20
> > Thanks
> > James
> >=20
> > > Cheers,
> > > -Brian
