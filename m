Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589E5ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AF720869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qhS9Cg+r";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qhS9Cg+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408966AbfJQKsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:48:35 -0400
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:28766
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404935AbfJQKsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl3sMsX0c+XxnqBP0DW1fAeOGamt9J9H22Xo7e7LUFs=;
 b=qhS9Cg+ru0VhuqvfEL3cbiVyxjoo3V7/gbh0rRlky/xMKH7SRKflhfsimaVc8+b9Mw/dUEGUi6/qh9U3dxiqiVauVxVeLXwb7dj0c4YYfdotQu5nHbuoedBA8bWog3+wGhws4NB0dP/sOfix72FzphUqY149xmBCiXCwXqLQn9Q=
Received: from DB6PR0802CA0042.eurprd08.prod.outlook.com (2603:10a6:4:a3::28)
 by AM5PR0801MB2003.eurprd08.prod.outlook.com (2603:10a6:203:4a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Thu, 17 Oct
 2019 10:48:27 +0000
Received: from VE1EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by DB6PR0802CA0042.outlook.office365.com
 (2603:10a6:4:a3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.17 via Frontend
 Transport; Thu, 17 Oct 2019 10:48:26 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT052.mail.protection.outlook.com (10.152.19.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Thu, 17 Oct 2019 10:48:25 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Thu, 17 Oct 2019 10:48:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 15e5672419524f75
X-CR-MTA-TID: 64aa7808
Received: from 2c004cea8bcb.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.1.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 81EA1DB6-7CE7-4915-9F28-35F5476F86ED.1;
        Thu, 17 Oct 2019 10:48:14 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2056.outbound.protection.outlook.com [104.47.1.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2c004cea8bcb.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 17 Oct 2019 10:48:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUR4N41EDlxfhuMSPv2vrL9EduXW3L8lgACckjDkkgyC0QLarwgvtcUX16un4UItt5TIyRP81ALBzMgzOd2KuDA14YQJ/4Yq0owOvxsdbrKKkMKojiqW9Ova2t+3H7e5cnmfASnP1KB2EtwjJVOF/1mTJeRtW7yAbAqWLMTkofJ+pTPwiby+bdhQqIUYrDuBiW0RXHoRnajgpbU9qsy6R5pI3AoWn3xquXEsp0tgkhjtt8/5Wf1Vz9qwnJ+w7th4XK6OpBQwWpBrTW4oUAV55r4Njc3PBMDftIH0JtXf03gXID14sCoqlxYHBArQU/I3oZDSC8+JYGnrYkCUcxE3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl3sMsX0c+XxnqBP0DW1fAeOGamt9J9H22Xo7e7LUFs=;
 b=f/JQY9+kHR0LaWY9uGrRmNOiLNLH2Q8lrL7g+wRWZEVHF/NiBqfPivlJXzEqMSmoOWyqf1PQMLvdnFIGWdIsYCbLAMFhzls0j3TzCILYWmROWDqlIEnMsvnFjRVZNJpRwPzLH7W2UfCzMjMZyYcSAciPBarbjWDdso8Re6FR3OFlmYjojds/ejL43+t3uENGZ9XLeDzgSFWiDnMDEWoQrimRWfvtbBhYnn2qYeul9AKfeDeRyDOm/lekBN55/yMp8qc2dzXZk+Nuc50W+NeF2xpnHs86kcWU8eeO+R4fxdx8XW9XfhrzJK2aZEOrrkP7Yi2Nv20Hcue4JqRfAJF5Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl3sMsX0c+XxnqBP0DW1fAeOGamt9J9H22Xo7e7LUFs=;
 b=qhS9Cg+ru0VhuqvfEL3cbiVyxjoo3V7/gbh0rRlky/xMKH7SRKflhfsimaVc8+b9Mw/dUEGUi6/qh9U3dxiqiVauVxVeLXwb7dj0c4YYfdotQu5nHbuoedBA8bWog3+wGhws4NB0dP/sOfix72FzphUqY149xmBCiXCwXqLQn9Q=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB4769.eurprd08.prod.outlook.com (10.255.99.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 17 Oct 2019 10:48:13 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a%5]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 10:48:13 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>,
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
Thread-Index: AQHVhDme1+iX/Utgt0y74txJGijIlKddc0AAgAC0dYCAAFdhgIAAIZ6AgAAHlgA=
Date:   Thu, 17 Oct 2019 10:48:12 +0000
Message-ID: <20191017104812.6qpuzoh5bx5i2y3m@DESKTOP-E1NTVVP.localdomain>
References: <20191004143418.53039-4-mihail.atanassov@arm.com>
 <20191009055407.GA3082@jamwan02-TSP300> <5390495.Gzyn2rW8Nj@e123338-lin>
 <20191016162206.u2yo37rtqwou4oep@DESKTOP-E1NTVVP.localdomain>
 <20191017030752.GA3109@jamwan02-TSP300>
 <20191017082043.bpiuvfr3r4jngxtu@DESKTOP-E1NTVVP.localdomain>
 <20191017102055.GA8308@jamwan02-TSP300>
In-Reply-To: <20191017102055.GA8308@jamwan02-TSP300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LO2P265CA0287.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::35) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: b1323b4c-7d4e-4938-2b48-08d752ef898c
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM6PR08MB4769:|AM6PR08MB4769:|AM5PR0801MB2003:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB20036203958BBABF010AEEBEF06D0@AM5PR0801MB2003.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 01930B2BA8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(6436002)(316002)(76176011)(6486002)(186003)(54906003)(66556008)(66446008)(229853002)(64756008)(66946007)(26005)(66476007)(25786009)(6116002)(52116002)(66066001)(14454004)(478600001)(58126008)(99286004)(3846002)(386003)(6506007)(102836004)(6246003)(9686003)(6512007)(6862004)(14444005)(8676002)(4326008)(71190400001)(86362001)(1076003)(256004)(8936002)(5660300002)(2906002)(71200400001)(6636002)(81156014)(486006)(44832011)(476003)(11346002)(446003)(7736002)(305945005)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4769;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: cVQXy2esuDoVcWYLosK3wSNIXonJm13oxjMRTTNEYLIkFiu5JawqJAtmKGYWSJ/a6R2WdUdBYlSj3ZpRtdve0BFmBDm5nYFrBuRkDSshqWsKKT8LcnWPkPMY+eJzxjZe294XunrGUS7/SZZBvJkD4RQlfHjlAuzj+iRbYaS0GjS2713JIA5vzFMS8EWQHB2zsHx1D/EBfMLqKwGU0WSvQLDYnjg4R2YA7tQyYdL1QLPAk3Oph4tLgs7d7L12orfbqzhY8e+Io0h5fcRUVbkHnaVu1d0037iL3UGQsrOh74o6aTwvFgfakNLnaKGOExlwE7isHpSSznloealRVfzX9NeGyrX3veIRlPD8OT03qpVjAtU++w/DcR59wrVY4lGSqm/1sJRGIDa9sYlheHttVBlB/rxuuGJ85xY9aaH1dFc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <992E23AC5D263B4886484E3F786F8871@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4769
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(199004)(189003)(6486002)(6512007)(70586007)(9686003)(70206006)(305945005)(76130400001)(86362001)(50466002)(76176011)(6862004)(5660300002)(7736002)(356004)(1076003)(107886003)(6246003)(316002)(14444005)(99286004)(58126008)(54906003)(4326008)(25786009)(47776003)(8936002)(8746002)(97756001)(81156014)(81166006)(336012)(66066001)(8676002)(26005)(23726003)(102836004)(6116002)(3846002)(46406003)(186003)(486006)(14454004)(2906002)(229853002)(6636002)(26826003)(63350400001)(386003)(446003)(6506007)(476003)(11346002)(126002)(478600001)(22756006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB2003;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: ac3aacb7-a725-4acc-caaa-08d752ef8200
NoDisclaimer: True
X-Forefront-PRVS: 01930B2BA8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+7fT/24NcnFm+yySqyQwoOJfk6C5d/PdBhTWUq+gReql8JYKSg+EfAfFurCvQlFrx/xGJlU7B6w5rxl0TMVoLB5PRIxpC0UqdRcwrWK//tPt7E4e/BLZeU+7Z3SAqfhCS2na8g7OOTOzYgd40a8HLiKVUc7ui56NTmpDMYdrjRwXVsrxMLOzr8FxOuRLfYvde3YkcvPUjZlHBcTkRnW4ZxUxgz1ITzDc0JnmGMMuHGb7OUdQchaytcYOdNUBz1Wk/RUW9Uilm7qcFmqU7UyyTM9q3tFw43NMh94HddcltxHGkMi5BJnaUPYug3ua9XwvhP5yVsIpNO2Jy50lxBeS42r7YMTf68dG8SPkAKWt3Yrm1ImjULi+XpDF84P29BXi2+7PdZd01mPFXxVj4/9IGhNfbH3J+eNCvoZt9hfGvU=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 10:48:25.3489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1323b4c-7d4e-4938-2b48-08d752ef898c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 10:21:03AM +0000, james qian wang (Arm Technology C=
hina) wrote:
> On Thu, Oct 17, 2019 at 08:20:56AM +0000, Brian Starkey wrote:
> > On Thu, Oct 17, 2019 at 03:07:59AM +0000, james qian wang (Arm Technolo=
gy China) wrote:
> > > On Wed, Oct 16, 2019 at 04:22:07PM +0000, Brian Starkey wrote:
> > > >=20
> > > > If James is strongly against merging this, maybe we just swap
> > > > wholesale to bridge? But for me, the pragmatic approach would be th=
is
> > > > stop-gap.
> > > >
> > >=20
> > > This is a good idea, and I vote +ULONG_MAX :)
> > >=20
> > > and I also checked tda998x driver, it supports bridge. so swap the
> > > wholesale to brige is perfect. :)
> > >=20
> >=20
> > Well, as Mihail wrote, it's definitely not perfect.
> >=20
> > Today, if you rmmod tda998x with the DPU driver still loaded,
> > everything will be unbound gracefully.
> >=20
> > If we swap to bridge, then rmmod'ing tda998x (or any other bridge
> > driver the DPU is using) with the DPU driver still loaded will result
> > in a crash.
>=20
> I haven't read the bridge code, but seems this is a bug of drm_bridge,
> since if the bridge is still in using by others, the rmmod should fail
>=20

Correct, but there's no fix for that today. You can also take a look
at the thread linked from Mihail's cover letter.

> And personally opinion, if the bridge doesn't handle the dependence.
> for us:
>=20
> - add such support to bridge

That would certainly be helpful. I don't know if there's consensus on
how to do that.

>   or
> - just do the insmod/rmmod in correct order.
>=20
> > So, there really are proper benefits to sticking with the component
> > code for tda998x, which is why I'd like to understand why you're so
> > against this patch?
> >
>=20
> This change handles two different connectors in komeda internally, compar=
e
> with one interface, it increases the complexity, more risk of bug and mor=
e
> cost of maintainance.
>=20

Well, it's only about how to bind the drivers - two different methods
of binding, not two different connectors. I would argue that carrying
our out-of-tree patches to support both platforms is a larger
maintenance burden.

Honestly this looks like a win-win to me. We get the superior approach
when its supported, and still get to support bridges which are more
common.

As/when improvements are made to the bridge code we can remove the
component bits and not lose anything.

> So my suggestion is keeping on one single interface in komeda, no
> matter it is bridge or component, but I'd like it only one, but not
> them both in komeda.

If we can put the effort into fixing bridges then I guess that's the
best approach for everyone :-) Might not be easy though!

-Brian

>=20
> Thanks
> James
>=20
> > Thanks,
> > -Brian
