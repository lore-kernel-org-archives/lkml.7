Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBD9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B20F206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="I56+dAaU";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="I56+dAaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbfJHIG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:06:58 -0400
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:64326
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730292AbfJHIG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drQ9hLzOpV9DsXFhX7lPjxUSGbfWmD+ZWz3Ew18XLK4=;
 b=I56+dAaUTkCHBbRnMfKI2KqFJQ5PS/YLN00+DI/5JfShqSdMRt5uNbtgk6J4rzGGlXfLG0wXK+GAyT0YcHj+vy56Ss2qeOLP6vuBXdgN68KUyynAv3deYEOmLMy4koBx6Q7mU7lU9pmLgm5EdyzxqoB0xSVscAmynN1mIK5WnVY=
Received: from VI1PR08CA0122.eurprd08.prod.outlook.com (2603:10a6:800:d4::24)
 by DB6PR08MB2759.eurprd08.prod.outlook.com (2603:10a6:6:1d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.25; Tue, 8 Oct
 2019 08:06:48 +0000
Received: from DB5EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by VI1PR08CA0122.outlook.office365.com
 (2603:10a6:800:d4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2327.24 via Frontend
 Transport; Tue, 8 Oct 2019 08:06:48 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT057.mail.protection.outlook.com (10.152.20.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 8 Oct 2019 08:06:47 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Tue, 08 Oct 2019 08:06:41 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b542d3dbdbb4a977
X-CR-MTA-TID: 64aa7808
Received: from 170c1393c5c0.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 11610660-6CF2-440C-ADA4-7D45A3E50944.1;
        Tue, 08 Oct 2019 08:06:35 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2055.outbound.protection.outlook.com [104.47.10.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 170c1393c5c0.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 08 Oct 2019 08:06:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZqCpZFpF/2R4ptk6Mzi0Uux555Oym0fqUa97Pr2qpR8DNtH+34mUS4Nh1REWi6zw2s725eaIIAQSMq8VEQ0nAfuHy4ja7Rx97B6eNRllAOtyH1n3LZnLled+asQXH3tsRvI5hhiDM9F0wzlIm2Qd2RF45Puvx5PLV5ytTjYZpzO8YzNKcLVwEjEeLwCQ6f55ZueZwQk5yZJHRGNphkl3nD9WLBbGwdtwIE6JiDX+ViwQwGUgG4uhSFqGLbSC0afGq3/tLYIdaktblIkw/GtEGz7L4qscaPMcduAwDFlqkzUc97HE8Yj9tT9m5gOQDwFSHIxoPg0KY60q6ME1Ga+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drQ9hLzOpV9DsXFhX7lPjxUSGbfWmD+ZWz3Ew18XLK4=;
 b=LLm03ZEqwQHkNoKAtCESAz54nZoOCqYNGibg6kmBgCEqOGfC9bV7X9muWNVIKvM9eoL4SnHezE0kxjzabpJgIRKHrC6y1vWKA+55cfgjgsJwJiV/zYAg19NTiiqw3P94T+QnsvHX5wI/UGwjA9FZ126PQ1k8QNkBNQ4TgZ/QrFE+4reRAhwo1NOYcV7Sjkv7+rFAT81ss/7eHwd0oJFPG5TDxOE/PshtqQFkdnqpQvv4Lq8t7BXZZNxpGiOtxNBscUdypkueYcrwqqINdtf1sxC3o0/9Hokd/DVnP/XFrOj5mXYXI3ERWnDZQXrmZPmrw/mlMUeI/R+fUpV56m6Iiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drQ9hLzOpV9DsXFhX7lPjxUSGbfWmD+ZWz3Ew18XLK4=;
 b=I56+dAaUTkCHBbRnMfKI2KqFJQ5PS/YLN00+DI/5JfShqSdMRt5uNbtgk6J4rzGGlXfLG0wXK+GAyT0YcHj+vy56Ss2qeOLP6vuBXdgN68KUyynAv3deYEOmLMy4koBx6Q7mU7lU9pmLgm5EdyzxqoB0xSVscAmynN1mIK5WnVY=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5119.eurprd08.prod.outlook.com (10.255.159.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 8 Oct 2019 08:06:33 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2305.023; Tue, 8 Oct 2019
 08:06:33 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Colin Ian King <colin.king@canonical.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH][next] drm/komeda: remove redundant assignment to pointer
 disable_done
Thread-Topic: [PATCH][next] drm/komeda: remove redundant assignment to pointer
 disable_done
Thread-Index: AQHVes/ZUJmCrklP8UyDQux9AfFYh6dK3dyAgAAo5gCABCjhgIABOU0A
Date:   Tue, 8 Oct 2019 08:06:33 +0000
Message-ID: <20191008080626.GA20953@jamwan02-TSP300>
References: <20191004162156.325-1-colin.king@canonical.com>
 <20191004192720.7eiqdvsm2yv62svg@e110455-lin.cambridge.arm.com>
 <35232014-f65a-f7a1-99db-8ed91f610a77@canonical.com>
 <20191007132505.GV22609@kadam>
In-Reply-To: <20191007132505.GV22609@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: e04d085b-2fae-4eb9-a4bc-08d74bc6773e
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5119:|VE1PR08MB5119:|DB6PR08MB2759:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR08MB27592679B3B30777C572028DB39A0@DB6PR08MB2759.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 01842C458A
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(51914003)(189003)(199004)(1076003)(305945005)(52116002)(102836004)(6916009)(229853002)(33656002)(33716001)(71190400001)(71200400001)(25786009)(8936002)(76176011)(316002)(86362001)(53546011)(386003)(5660300002)(6506007)(66066001)(6246003)(14454004)(55236004)(4326008)(26005)(6486002)(9686003)(6512007)(66476007)(2906002)(7736002)(66446008)(64756008)(66556008)(6116002)(3846002)(66946007)(6436002)(8676002)(476003)(446003)(11346002)(58126008)(478600001)(486006)(81156014)(186003)(99286004)(81166006)(256004)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5119;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: wrKhIg88kw6f7joum39OZNMfGbAoeoP05o162+BTXP+KCjsUhXZmJ17HyaJf0cgHFfPegFWuaIxfK52AUrnVhbrDh/9zUsAheDcGJl5K9JPImseijDdQvktax1VvIo8Io1fg1+74yebi63mYHy+KJoyxWPFFerTipZFLbdX0e9F8SFsaUsykw/ae/aj9svYXiO2EdGkYUVJkQca7WN7FmuNMBiRthetyEbtjDahe1CFsCOol3arhocSrCeKPxtq8b7bB6uf6ySHg/J2f+7bA9ZOt8M7UALrTUJv7zuCVfZ1dsdHcVodmVtqU4DC/HuYvXw20qh1EKxhOQWCe5rDK2q4b5TNNSPmsrB6ITy3CNtC1JDQ9Y7zUTX/Ln87NwHyibLAjYFzzX67PCDrehPntKdmbAZpPNbmXsQLdBSUSYKM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <280853445FFF80489C1A703653481D96@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5119
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(396003)(136003)(39860400002)(346002)(51914003)(199004)(189003)(33656002)(11346002)(316002)(446003)(47776003)(25786009)(476003)(8936002)(22756006)(4326008)(76130400001)(8746002)(58126008)(54906003)(126002)(486006)(450100002)(7736002)(336012)(70586007)(305945005)(478600001)(26826003)(6246003)(70206006)(6862004)(386003)(229853002)(76176011)(6116002)(23726003)(186003)(6512007)(9686003)(102836004)(14454004)(6486002)(99286004)(46406003)(26005)(5660300002)(33716001)(50466002)(53546011)(8676002)(66066001)(81166006)(81156014)(63350400001)(1076003)(356004)(97756001)(6506007)(86362001)(3846002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR08MB2759;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a82089e6-05cc-4e09-52d4-08d74bc66f19
NoDisclaimer: True
X-Forefront-PRVS: 01842C458A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pGBRbmBy+f3DELS9GVyzsu3WOWGXGtuZzdXZCpaHRY7glQBTpQDzy6ffYeXkUGBmB6JV6c3jVakqsmNOjJ5+PpZRSphco3VPdKMe/rpW03sr8aDKx9T3XDxv5j5EjVsItTrbwrwK3U4j1YYjmXVmFEccTILVx8RYDZLWflflCcushD18XADw9nT0//XenrSpX1Q/GWCMEDf0ljV91OUFmKaUO2jpE/R+Oi9QWGKw9DieKfA2HwkS962kVX3DzSMDyKUUju+aVXRYKXIhGVfOLSzV5XWetlf8lQk+cTkQxl1f9XHhuUSYuz+Erly9PFIgVOf79lhumjcrU1wtsSgpntKDfvH4oxYIxBwWg84fElw9DONaLROASV08nx6WWTNu34k1eyYB6DLGsAai26C1bxkgyAiD+QcuZCvwyKjCYlk=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 08:06:47.1725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e04d085b-2fae-4eb9-a4bc-08d74bc6773e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 04:25:05PM +0300, Dan Carpenter wrote:
> On Fri, Oct 04, 2019 at 10:53:44PM +0100, Colin Ian King wrote:
> > On 04/10/2019 20:27, Liviu Dudau wrote:
> > > On Fri, Oct 04, 2019 at 05:21:56PM +0100, Colin King wrote:
> > >> From: Colin Ian King <colin.king@canonical.com>
> > >>
> > >> The pointer disable_done is being initialized with a value that
> > >> is never read and is being re-assigned a little later on. The
> > >> assignment is redundant and hence can be removed.
> > >=20
> > > Not really true, isn't it? The re-assignment is done under the condit=
ion that
> > > crtc->state->active is true. disable_done will be used regardless aft=
er the if
> > > block, so we can't skip this initialisation.
> > >=20
> > > Not sure why Coverity flags this, but I would NAK this patch.
> >=20
> > I'm patching against the driver from linux-next so I believe this is OK
> > for that. I believe your statement is true against linux which does not
> > have commit:
> >=20
> > d6cb013579e743bc7bc5590ca35a1943f2b8f3c8
> > Author: Lowry Li (Arm Technology China) <Lowry.Li@arm.com>
> > Date:   Fri Sep 6 07:18:06 2019 +0000
> >=20
>=20
> It really does help reviewing patches when this is mentioned in the
> commit message.
>=20
> There is some debate about whether this should be mentioned as a Fixes
> since it doesn't fix a bug.  I initialy felt it shouldn't be, but now
> I think enough people think it should be listed as Fixes that I must be
> wrong.  Either way, it's very useful information.
>=20
> The other thing is that soon get_maintainer.pl will start CC'ing people
> from the Fixes tag and right now Lowry Li is not CC'd so that's
> unfortunate.
>=20
> regards,
> dan carpenter

Hi Liviu:

Colin's code is right.

Following code I copied from linux-next, and I checked drm-misc, the
code are same.=20

        struct komeda_pipeline *slave  =3D kcrtc->slave;
//---- First initialization.
        struct completion *disable_done =3D &crtc->state->commit->flip_done=
;
        bool needs_phase2 =3D false;

        DRM_DEBUG_ATOMIC("CRTC%d_DISABLE: active_pipes: 0x%x, affected: 0x%=
x\n",
                         drm_crtc_index(crtc),
                         old_st->active_pipes, old_st->affected_pipes);

        if (slave && has_bit(slave->id, old_st->active_pipes))
                komeda_pipeline_disable(slave, old->state);

        if (has_bit(master->id, old_st->active_pipes))
                needs_phase2 =3D komeda_pipeline_disable(master, old->state=
);

//---- Secondary initialization.
        disable_done =3D (needs_phase2 || crtc->state->active) ?
                       NULL : &crtc->state->commit->flip_done;

//--- First using is here.
        /* wait phase 1 disable done */
        komeda_crtc_flush_and_wait_for_flip_done(kcrtc, disable_done);

So the first initialization with the delcaration is unnecessary.

And I also checked our internal testing branch which actually doesn't have
the first initialization. seems somethings wrong when lowry submit this to
upstream.

Hi Colin:

Thanks for the fix. I'll push it to drm-misc-fixes

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

Best Regards
James

