Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3439ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3662064B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Bxc1Pa+F";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Bxc1Pa+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409873AbfJRLBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 07:01:40 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:63713
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390315AbfJRLBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 07:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pzusbNj7NuLcs6S/MEsIssznSoIGv9jIXqpEYts4Lg=;
 b=Bxc1Pa+FkrcA6WfZpYSNuLW4YgMGVdaGrhnv6nSspIZpaKzwse6CSgpGKeIln85JNm8wiYJBQXKpIFfkDvo+WyntpfHzZWDPadhe+Eik8TfRjWgW0DLEmoj3meVNQqgHjV7OCDiyJMhtCIS2uIfkv1OppkjGrAs3aJAfjF///YU=
Received: from VI1PR0801CA0083.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::27) by AM4PR0802MB2227.eurprd08.prod.outlook.com
 (2603:10a6:200:5e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.19; Fri, 18 Oct
 2019 11:01:33 +0000
Received: from AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::206) by VI1PR0801CA0083.outlook.office365.com
 (2603:10a6:800:7d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20 via Frontend
 Transport; Fri, 18 Oct 2019 11:01:32 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT058.mail.protection.outlook.com (10.152.17.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 18 Oct 2019 11:01:30 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Fri, 18 Oct 2019 11:01:21 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a1a28f31e63a18ae
X-CR-MTA-TID: 64aa7808
Received: from a8bae19f48b7.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 27147B68-3D26-477E-98FD-58D3D7925E70.1;
        Fri, 18 Oct 2019 11:01:14 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2054.outbound.protection.outlook.com [104.47.12.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a8bae19f48b7.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 18 Oct 2019 11:01:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TskExcp+oRkqUSOjF8oczvBP7BSVzCAH2EtfR+os99ZgIeFIglhI7v6txAr2bqAogaQ1hq7+IFrv3yo9k5/65eYube4k+mEmVB0nXafLomH7TU/HER5yfLPI+paMdo5H5nh1yA8lQYcElwzU5nIf6RNqZzQlxC+95HToPmTmHFwpC7jrghp1gOSIvUmJAC4PikqO50IBs5+Qqb8v3blthmroiwGHVxZCs6atD1AwAzr4s2aRy8+9DxMCoLX6fBgDq0rl7WDCg1jR5KYlipjHsssqZWbU7nbur+ES7GZEkbe/i1KvQk+iUfCGviMz1HpDZZFLG0Pnf5EPPQNziMQwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pzusbNj7NuLcs6S/MEsIssznSoIGv9jIXqpEYts4Lg=;
 b=Jmlq9R3EUifg7biK1NhPftZRR4Y3lOIcy43/PWcqtfhmd+jUw63kc+26A9ZLW0nWdqjnyIZKZ48QOU9fcFBThtyO4B9jB794kOjXZpFg++cYD2QY1dtY47eGWa0dlpf6w2igCkBHlnGK59u2AFNxhNtpLr6GcTh925YxJ9kBW8btbvsyBM1sd3wcTIbe6zMi4dCtb/BUI5dAqXT01EnjuQ5XSZTSOWmzlcpHNJwDQWWDb0uxO9Qn+A12d2JnfdcD8Vcog3/+Hk3eqLC9bhC3+o/wyYwi5VzOtkWlFddhIbZK/F5JiRSTZ/fnhhky3j8iqNTnWgUpV94oC0LAv7BYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pzusbNj7NuLcs6S/MEsIssznSoIGv9jIXqpEYts4Lg=;
 b=Bxc1Pa+FkrcA6WfZpYSNuLW4YgMGVdaGrhnv6nSspIZpaKzwse6CSgpGKeIln85JNm8wiYJBQXKpIFfkDvo+WyntpfHzZWDPadhe+Eik8TfRjWgW0DLEmoj3meVNQqgHjV7OCDiyJMhtCIS2uIfkv1OppkjGrAs3aJAfjF///YU=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3888.eurprd08.prod.outlook.com (20.178.80.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Fri, 18 Oct 2019 11:01:13 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2347.024; Fri, 18 Oct 2019
 11:01:13 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Brian Starkey <Brian.Starkey@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <mripard@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Sean Paul <sean@poorly.run>
Subject: Re: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Thread-Topic: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Thread-Index: AQHVfmYCVHmeR23TD0SRvLooFH2IJKddhx2A///3y4CAALR0gIAAV3AAgAAhkICAAAeWAIABTLOAgABJQoA=
Date:   Fri, 18 Oct 2019 11:01:12 +0000
Message-ID: <1762076.f1XlaKvzUH@e123338-lin>
References: <20191004143418.53039-4-mihail.atanassov@arm.com>
 <20191017104812.6qpuzoh5bx5i2y3m@DESKTOP-E1NTVVP.localdomain>
 <20191018063851.GA18702@jamwan02-TSP300>
In-Reply-To: <20191018063851.GA18702@jamwan02-TSP300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P265CA0355.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::31) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: d1005342-65fa-4393-0474-08d753ba8820
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3888:|VI1PR08MB3888:|AM4PR0802MB2227:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0802MB2227C9B1496E4C3D1F537CDF8F6C0@AM4PR0802MB2227.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 01949FE337
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(396003)(366004)(39860400002)(346002)(376002)(189003)(199004)(54906003)(229853002)(316002)(14454004)(2906002)(76176011)(4326008)(186003)(478600001)(6506007)(386003)(52116002)(6436002)(6486002)(6862004)(9686003)(71200400001)(71190400001)(6512007)(3846002)(6116002)(25786009)(486006)(11346002)(446003)(99286004)(476003)(256004)(14444005)(5660300002)(6636002)(33716001)(305945005)(66946007)(66476007)(66556008)(64756008)(66446008)(81156014)(81166006)(7736002)(8936002)(8676002)(6246003)(102836004)(26005)(66066001)(86362001)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3888;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 2EKjCu1Hc8wnpZMlIlY9l84S1yVNK6dZ3rVjrFRBfgwVN60At6EJY3rJXmBsu2lH7Q7fmyV+XPx0dtd5AmvI0a01jOY5qldEdGRN6Uxpx6UhTAIhzZNx1PYcMJuGI1++INRho1Rw/88ZcYRvCF51FsbIva2/5VsPU5WwwLEzk8cRH3fDPCJXiLDOHc6tzYIl6qXaT8wIWEcMmX/xIz46rXUwr6bLYxFZTKRtSpGto2Y894o1ymqgE1ywMy+O5koLVlRH1KICh89TLosfsnP4GeXatVva2eBO8hnQgXPQnBnfBZcuQG7opc4fRIrnj7BFwXqpmKRmgiNsvYoh9M2mYP/CPeQYIb4YshjE5VfVicKBuS745j0QouAantOsYPzChkVK2M6+akmiWM9fhAyjiL8k4iIsFYAAvxqxtIzft2k=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF04E6F538BF7742924B072225422630@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3888
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(346002)(39860400002)(396003)(136003)(199004)(189003)(356004)(81156014)(8936002)(8746002)(8676002)(81166006)(305945005)(7736002)(54906003)(23726003)(478600001)(26826003)(14454004)(6116002)(3846002)(70206006)(70586007)(14444005)(4326008)(25786009)(6636002)(6246003)(107886003)(9686003)(6512007)(6862004)(76130400001)(6486002)(229853002)(63350400001)(102836004)(99286004)(76176011)(5660300002)(26005)(336012)(66066001)(186003)(486006)(386003)(6506007)(47776003)(476003)(126002)(11346002)(446003)(36906005)(22756006)(2906002)(86362001)(97756001)(316002)(46406003)(33716001)(50466002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2227;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: b5c247a0-2418-4560-df7f-08d753ba7d4e
NoDisclaimer: True
X-Forefront-PRVS: 01949FE337
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /aRyyY2IqAE20ol3n3Nydq/InrFWF6mEUvD1nQ+y3zErDxBy/0f7jFqE0bBriit1ZA4jUelwfnv8M3gcmj6jsyG3ZrjpbrTS9u5Bk4P/t6+452fy7I9Aw+EehkDqCcB3KxVyNrlpw3sDQOBw1w6H/7/DGedoUpj5ME1Si9GpdTRIn3Prh4g3d0m8D22qCz+0dQtAHbbCjs/zBGqPhbwlXvws70E5SmgCWuIeqx+oPkSq2IX+JXd0BGHMpL5w0OEavNGzcMfGif7aVBdBgh0AFBp+E5aPLGfCDvdfgbkywc3bdD6EVnV2epC1TdEo/NqIVpBE6tSLPliIHeDpAhiCDvU+vz3YUrQObJ0RkAJnBLNc6DKCy1kK2I1IcJl51uMnwy70SfZpqWr/hsPkbkmLc5T2cELeMql9fFUHkeOfu+U=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2019 11:01:30.8155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1005342-65fa-4393-0474-08d753ba8820
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2227
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 18 October 2019 07:38:59 BST james qian wang (Arm Technology Chi=
na) wrote:
> On Thu, Oct 17, 2019 at 10:48:12AM +0000, Brian Starkey wrote:
> > On Thu, Oct 17, 2019 at 10:21:03AM +0000, james qian wang (Arm Technolo=
gy China) wrote:
> > > On Thu, Oct 17, 2019 at 08:20:56AM +0000, Brian Starkey wrote:
> > > > On Thu, Oct 17, 2019 at 03:07:59AM +0000, james qian wang (Arm Tech=
nology China) wrote:
> > > > > On Wed, Oct 16, 2019 at 04:22:07PM +0000, Brian Starkey wrote:
> > > > > >=20
> > > > > > If James is strongly against merging this, maybe we just swap
> > > > > > wholesale to bridge? But for me, the pragmatic approach would b=
e this
> > > > > > stop-gap.
> > > > > >
> > > > >=20
> > > > > This is a good idea, and I vote +ULONG_MAX :)
> > > > >=20
> > > > > and I also checked tda998x driver, it supports bridge. so swap th=
e
> > > > > wholesale to brige is perfect. :)
> > > > >=20
> > > >=20
> > > > Well, as Mihail wrote, it's definitely not perfect.
> > > >=20
> > > > Today, if you rmmod tda998x with the DPU driver still loaded,
> > > > everything will be unbound gracefully.
> > > >=20
> > > > If we swap to bridge, then rmmod'ing tda998x (or any other bridge
> > > > driver the DPU is using) with the DPU driver still loaded will resu=
lt
> > > > in a crash.
> > >=20
> > > I haven't read the bridge code, but seems this is a bug of drm_bridge=
,
> > > since if the bridge is still in using by others, the rmmod should fai=
l
> > >=20
> >=20
> > Correct, but there's no fix for that today. You can also take a look
> > at the thread linked from Mihail's cover letter.
> >=20
> > > And personally opinion, if the bridge doesn't handle the dependence.
> > > for us:
> > >=20
> > > - add such support to bridge
> >=20
> > That would certainly be helpful. I don't know if there's consensus on
> > how to do that.
> >=20
> > >   or
> > > - just do the insmod/rmmod in correct order.
> > >=20
> > > > So, there really are proper benefits to sticking with the component
> > > > code for tda998x, which is why I'd like to understand why you're so
> > > > against this patch?
> > > >
> > >=20
> > > This change handles two different connectors in komeda internally, co=
mpare
> > > with one interface, it increases the complexity, more risk of bug and=
 more
> > > cost of maintainance.
> > >=20
> >=20
> > Well, it's only about how to bind the drivers - two different methods
> > of binding, not two different connectors. I would argue that carrying
> > our out-of-tree patches to support both platforms is a larger
> > maintenance burden.
> >=20
> > Honestly this looks like a win-win to me. We get the superior approach
> > when its supported, and still get to support bridges which are more
> > common.
> >
>=20
> My consideration is: if we support both link methods, we may suffering
>=20
> - 1. bridge reference cnt problem
> - 2. maintance two link methods.
>=20
> the 1) seems unavoidable, so swap all to bridage at least can avoid
> the pain of 2). that's why I thought your idea "swap all to bridage"
> is good.
>=20
> Thanks
> James.
>=20

Just to make sure my understanding is clear: If I respin the patch to
only use the drm_bridge i/f, you'd be happier with it and we can get it
merged?

> > As/when improvements are made to the bridge code we can remove the
> > component bits and not lose anything.
> >=20
> > > So my suggestion is keeping on one single interface in komeda, no
> > > matter it is bridge or component, but I'd like it only one, but not
> > > them both in komeda.
> >=20
> > If we can put the effort into fixing bridges then I guess that's the
> > best approach for everyone :-) Might not be easy though!
> >=20
> > -Brian
> >=20
> > >=20
> > > Thanks
> > > James
> > >=20
> > > > Thanks,
> > > > -Brian
>=20


--=20
Mihail



