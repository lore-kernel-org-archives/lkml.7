Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B11FA372D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3F620640
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GBdhjIO/";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GBdhjIO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408180AbfJQIVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:21:18 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:55182
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389530AbfJQIVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukV8AqxmvlgoHHVMd6rm6b4oZHLxc7mlDUHP9wxrEiw=;
 b=GBdhjIO/eyNcoTfaQ3jkZZkbEAcYAMD+Bs+hiC+hCH61GjIs1swvJqxHkNZzGQLvemmzb1DOcTYeok03NrgNljFiObVCrSEhImr4lUN0SEGR64bSInOSwotnC37rrp3MdN4ryTHYwMNfCtdVKYwIS4wE8JVHog/JsAD7aI1lzFM=
Received: from VI1PR08CA0233.eurprd08.prod.outlook.com (2603:10a6:802:15::42)
 by DB8PR08MB3962.eurprd08.prod.outlook.com (2603:10a6:10:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17; Thu, 17 Oct
 2019 08:21:10 +0000
Received: from DB5EUR03FT007.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::206) by VI1PR08CA0233.outlook.office365.com
 (2603:10a6:802:15::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.18 via Frontend
 Transport; Thu, 17 Oct 2019 08:21:10 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT007.mail.protection.outlook.com (10.152.20.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Thu, 17 Oct 2019 08:21:08 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Thu, 17 Oct 2019 08:21:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 129d90b1f67939b3
X-CR-MTA-TID: 64aa7808
Received: from 09eb9d269ea1.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.13.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 93DAE767-1A7E-47E2-A7DB-49974FE94D2C.1;
        Thu, 17 Oct 2019 08:20:58 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 09eb9d269ea1.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 17 Oct 2019 08:20:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjXJTkadL2vYWL58H05CG4iHsG1Pk6BUOpI+YUm6E1SGl3aUYMNy75bY0yXyGZjYrwn+knVHmZ70ST8YgvX56Y9px/Gov9Ek1uxhkjT5TRYgpZIFPBjmgcktwPShW55IgedMNlJjBYBMWPpW2MpBveOCc1z02OunJycW7plfq9v1WFFWYh5gji2gXiruKazD07W1RM6jixcbME8dx+Gj61P0IMN7nvhmWgC8BeUZPgZDQOJgBh2hNhXjXd2XyPXrwzS+r+JHdRtV+JVISWFKLE2rUtDr74UGLMyMWe0u0mx1uW/hVZQEgrjTotwr2DERGDNDiedHgDLeCl9mhmv2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukV8AqxmvlgoHHVMd6rm6b4oZHLxc7mlDUHP9wxrEiw=;
 b=eIScW3pBFA33TzK988msWtg/RMObnbppn2Ujg138Bre5FznOKm0ZbArpMdJkH3deCQ0KdqkyK/TxLtt+kZoxfXfCwVTA6r9Or2IlIdERmKXLIHwy9BV5TdYrd5g9l+NvAyH+Lu+9aiNCvupuWollTdq3zG4Qc3ELLBOQf8wZmxK1I5wpHJUfum7f0crC1Xllrhs0twF2WXuKfzyMSrqFtz1QemptVyavsoVJGIL8Qk6Qh1PA5RLfA5MZAwtta9l9Tp4Nw0VwGCh9DKZOwItnt190IXdOIcYJpFcBsf3YqDS8JeUeWDI3PLhXGTNC8H2L56QCa1omilIE41bSj4LJgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukV8AqxmvlgoHHVMd6rm6b4oZHLxc7mlDUHP9wxrEiw=;
 b=GBdhjIO/eyNcoTfaQ3jkZZkbEAcYAMD+Bs+hiC+hCH61GjIs1swvJqxHkNZzGQLvemmzb1DOcTYeok03NrgNljFiObVCrSEhImr4lUN0SEGR64bSInOSwotnC37rrp3MdN4ryTHYwMNfCtdVKYwIS4wE8JVHog/JsAD7aI1lzFM=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB3736.eurprd08.prod.outlook.com (20.178.89.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 08:20:56 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a%5]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 08:20:56 +0000
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
Thread-Index: AQHVhDme1+iX/Utgt0y74txJGijIlKddc0AAgAC0dYCAAFdhgA==
Date:   Thu, 17 Oct 2019 08:20:56 +0000
Message-ID: <20191017082043.bpiuvfr3r4jngxtu@DESKTOP-E1NTVVP.localdomain>
References: <20191004143418.53039-4-mihail.atanassov@arm.com>
 <20191009055407.GA3082@jamwan02-TSP300> <5390495.Gzyn2rW8Nj@e123338-lin>
 <20191016162206.u2yo37rtqwou4oep@DESKTOP-E1NTVVP.localdomain>
 <20191017030752.GA3109@jamwan02-TSP300>
In-Reply-To: <20191017030752.GA3109@jamwan02-TSP300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.52]
x-clientproxiedby: SN6PR01CA0024.prod.exchangelabs.com (2603:10b6:805:b6::37)
 To AM6PR08MB3829.eurprd08.prod.outlook.com (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 96695c36-2a54-40a0-e573-08d752daf673
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM6PR08MB3736:|AM6PR08MB3736:|DB8PR08MB3962:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB3962A5E9D9AF9265EEBC05ACF06D0@DB8PR08MB3962.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 01930B2BA8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(189003)(199004)(58126008)(54906003)(6436002)(6486002)(9686003)(6512007)(316002)(66066001)(44832011)(4326008)(6246003)(6862004)(486006)(476003)(11346002)(446003)(229853002)(4744005)(66946007)(66556008)(64756008)(66446008)(66476007)(81156014)(81166006)(8676002)(8936002)(25786009)(478600001)(14454004)(71190400001)(71200400001)(256004)(1076003)(186003)(26005)(6506007)(386003)(102836004)(2906002)(52116002)(76176011)(5660300002)(99286004)(86362001)(6636002)(6116002)(3846002)(305945005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3736;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Y2O0NzFGt0o6CHOL4BeVPrG7DbZc66UBB5oAFCiVX64rnHERVGtcvvjEgRPeoWY3UixsAcZORUh7yL6hLeZKHFKlBFEq/H/1Nd5iTucL1UJJtl8EbQ2Nr//0PK2BkqL7AhMNfHLXtlcmBAi/TQYqGtdvkGKmmVnG4MWYpJ3Z7NXhifVFEVljRyJV6PFS/eBRHBTio1+/WzglZP4CsWv4+8QP+iKmUd/Lj3RPjDswNtoA+C6JsF/ttCZSf9J0KYf4vUb6FMARfdVqozUH1jHr/rkyMB4bnQdXsP3/uhWwFGiTMnGx3neI4jUkhAQZYstXyqnSEvFEWjrNv2O24F01tj+cTw5ee9Zie++8tQi2Ua2L2+ONig8cFBc4wwToYQrxDxPIAbqhoTuWfubJQodVESFmH9QAmWHwCQ1VsXr/Ypk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3A65F37C6D7B304F98C90FAE55DDAA36@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3736
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT007.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(9686003)(8676002)(8936002)(86362001)(8746002)(66066001)(6512007)(46406003)(47776003)(316002)(50466002)(76130400001)(356004)(14454004)(486006)(336012)(446003)(6506007)(11346002)(386003)(26005)(81156014)(186003)(102836004)(63350400001)(126002)(476003)(81166006)(97756001)(4744005)(305945005)(7736002)(6636002)(2906002)(6862004)(26826003)(478600001)(5660300002)(25786009)(1076003)(6486002)(22756006)(70206006)(4326008)(99286004)(107886003)(6246003)(3846002)(6116002)(70586007)(229853002)(23726003)(76176011)(58126008)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB3962;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 24df4abc-381c-4ecb-167d-08d752daeef2
NoDisclaimer: True
X-Forefront-PRVS: 01930B2BA8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGXeS9M1OhDOIvtJuj3R0hGbXdE1tKTkiVlhMn7utDMcQxyPvW7yYA1/2RUyoaQPseDunzwUhxZCU7qHM712UNVHC2CySSD0OZsJD0Ddc0fCd6h2tAPtfDeXR7kvidTjPjXNwg1N9+UOjFLrsWbzvHEJtRQXRp4XeLAVHM/aafT6Ib8DomZGuR7k5YkUnGeEF1qJS7ENtXpeV0iD9m1bswmfZyh8cPZcw/vT6Dx234B4+oQL//x5g2CLaX/hCn/rM95m5y1v70BmzJCm4OzLGFN1lw3wObLTFVjt7nluYkS1jy1Nvr+wcxb8wZ+1bO+1AljIqzLOKm0xYPTd2f6qng4k9EboQK3Xzf3XL0b0z+mjOECd8Jfs0NcoPU+ATWKNLL0lrnsaMHrI/ZG4CazBFhT+5WQjnYmOLJ+9LWIBTJQ=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 08:21:08.6862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96695c36-2a54-40a0-e573-08d752daf673
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3962
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 03:07:59AM +0000, james qian wang (Arm Technology C=
hina) wrote:
> On Wed, Oct 16, 2019 at 04:22:07PM +0000, Brian Starkey wrote:
> >=20
> > If James is strongly against merging this, maybe we just swap
> > wholesale to bridge? But for me, the pragmatic approach would be this
> > stop-gap.
> >
>=20
> This is a good idea, and I vote +ULONG_MAX :)
>=20
> and I also checked tda998x driver, it supports bridge. so swap the
> wholesale to brige is perfect. :)
>=20

Well, as Mihail wrote, it's definitely not perfect.

Today, if you rmmod tda998x with the DPU driver still loaded,
everything will be unbound gracefully.

If we swap to bridge, then rmmod'ing tda998x (or any other bridge
driver the DPU is using) with the DPU driver still loaded will result
in a crash.

So, there really are proper benefits to sticking with the component
code for tda998x, which is why I'd like to understand why you're so
against this patch?

Thanks,
-Brian
