Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB62CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F60A222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Dl1IRMuT";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Dl1IRMuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505060AbfJRJMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:12:35 -0400
Received: from mail-eopbgr120057.outbound.protection.outlook.com ([40.107.12.57]:12192
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731444AbfJRJMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWR/Z4PQ4JtYsK6tzrgWRthab9Zpue1OMpZ4V/y1A34=;
 b=Dl1IRMuTlgir2SPg8B3UR64pNs5tMTaqmUdKHiqOOLf6xxeV+WYepSr91Itvl7IYadxqCzpCApY9kD17BwrmQsMNE91VABSbhsdXv4kjCDkeb2cToDGdk2EMCmweSYHnRO7D+M6jYW6QWdc2cBpp7VoDGAySIoQPEZmnd729zpw=
Received: from VI1PR08CA0193.eurprd08.prod.outlook.com (2603:10a6:800:d2::23)
 by PR2PR08MB4908.eurprd08.prod.outlook.com (2603:10a6:101:23::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 18 Oct
 2019 09:12:28 +0000
Received: from AM5EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by VI1PR08CA0193.outlook.office365.com
 (2603:10a6:800:d2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 18 Oct 2019 09:12:27 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT057.mail.protection.outlook.com (10.152.17.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 18 Oct 2019 09:12:26 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Fri, 18 Oct 2019 09:12:22 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0ae0b86be84cc997
X-CR-MTA-TID: 64aa7808
Received: from fdde536169ae.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7F56160A-8422-43FE-B781-BE4CC986E9AD.1;
        Fri, 18 Oct 2019 09:12:16 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2055.outbound.protection.outlook.com [104.47.8.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fdde536169ae.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 18 Oct 2019 09:12:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEGvfSZ9UMvUD7pjcuoRox6t+5y6DLBC6OKbrqKXDKLtdl7Gf3eAW4ZD+knhCHWk6oXCtxYavhcgmSnSn2rbyhT08WWJHHcYNSf+UShca/Ad/WQQj3BOKPCQhWIieOdGXzBbhkxk1MAaGYJd3/XEiIfNf0SzBSLy23Xs2L9Sft8IJ+38HEypEKq3ne6iyUQ7iZf+tZNnMzvLt/oJ1aqNhS4lJDBqh5yrhRXE1Jizchzdbe6mVrWy/gx7U/9JQtVYegdiJDWy0ABjcAf7ErMeACEuYvads1/DcG7doJVGO4YsbRKmaDa9k9IXOr/d2j6zkDD2mNU0Oema4pZoC0WstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWR/Z4PQ4JtYsK6tzrgWRthab9Zpue1OMpZ4V/y1A34=;
 b=YksIR+6PQZ/g5awPPbTkeidKR4q9t/42RgGNEM5vQHOhATLi2MeYIhZHNhnPJ75ZVn3UrOFn427af9v3mRfp1NFux7QO3w80JEZYh2exx0YRawXprnKN60E86Cj7Y2XKEHPdE+/qeG0zNZ4y/24eX+5I7NQlzGmsFdsl85EocbHyLB2gjJ8zrJHPLGNuUtHmed8jSxuRB6FGva27+BoFh8swWE/hhjR4piUuW866w2wUBZFXIrX3U3yZw1DD1kbLZYzct3sUxyFsRHi8D1cehBtfGpw+EKrDhv1fgx0mLZm5ZSY9ogjfQdj0BoeMKdMAAzQFVCz0QWsei0lygBNdcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWR/Z4PQ4JtYsK6tzrgWRthab9Zpue1OMpZ4V/y1A34=;
 b=Dl1IRMuTlgir2SPg8B3UR64pNs5tMTaqmUdKHiqOOLf6xxeV+WYepSr91Itvl7IYadxqCzpCApY9kD17BwrmQsMNE91VABSbhsdXv4kjCDkeb2cToDGdk2EMCmweSYHnRO7D+M6jYW6QWdc2cBpp7VoDGAySIoQPEZmnd729zpw=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB3333.eurprd08.prod.outlook.com (52.135.163.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Fri, 18 Oct 2019 09:12:15 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a%5]) with mapi id 15.20.2347.023; Fri, 18 Oct 2019
 09:12:15 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Sean Paul <sean@poorly.run>
Subject: Re: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Thread-Topic: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Thread-Index: AQHVhDme1+iX/Utgt0y74txJGijIlKddc0AAgAC0dYCAAFdhgIAAIZ6AgAAHlgCAAA7tgIABQtWAgAAlwoA=
Date:   Fri, 18 Oct 2019 09:12:15 +0000
Message-ID: <20191018091213.k6bka3tajy2vez6l@DESKTOP-E1NTVVP.localdomain>
References: <20191004143418.53039-4-mihail.atanassov@arm.com>
 <20191009055407.GA3082@jamwan02-TSP300> <5390495.Gzyn2rW8Nj@e123338-lin>
 <20191016162206.u2yo37rtqwou4oep@DESKTOP-E1NTVVP.localdomain>
 <20191017030752.GA3109@jamwan02-TSP300>
 <20191017082043.bpiuvfr3r4jngxtu@DESKTOP-E1NTVVP.localdomain>
 <20191017102055.GA8308@jamwan02-TSP300>
 <20191017104812.6qpuzoh5bx5i2y3m@DESKTOP-E1NTVVP.localdomain>
 <20191017114137.GC25745@shell.armlinux.org.uk>
 <20191018065657.GA19117@jamwan02-TSP300>
In-Reply-To: <20191018065657.GA19117@jamwan02-TSP300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LO2P265CA0369.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::21) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: eba6977f-b9b5-4a9a-f08b-08d753ab4b56
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM6PR08MB3333:|AM6PR08MB3333:|PR2PR08MB4908:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <PR2PR08MB4908E438B48DB24D812B29C3F06C0@PR2PR08MB4908.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 01949FE337
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(199004)(189003)(14454004)(966005)(76176011)(386003)(478600001)(99286004)(186003)(52116002)(102836004)(8936002)(26005)(2906002)(66066001)(11346002)(446003)(8676002)(81166006)(81156014)(476003)(6506007)(44832011)(486006)(4744005)(66946007)(256004)(316002)(229853002)(66556008)(66476007)(6486002)(6436002)(71200400001)(66446008)(4326008)(6636002)(58126008)(64756008)(86362001)(5660300002)(9686003)(6306002)(6512007)(25786009)(3846002)(305945005)(6116002)(7736002)(6862004)(71190400001)(6246003)(1076003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3333;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: LL61bUl2uiHTpeGFwp6+GwDBs/BFtM8BvDFCR8BZ7sTa7R7+tQMhKNQJo2fFXmNmBRGfTtdQCrjdxHZv6pW39YcQ1ByMBwHWnn0xsyQNJcU3drsrawUleIcM79s3N/TSGhTTLKYdxEzZ/bWi3tRyRXKTDrG3KOvc6TJIlMC/fR5p6KzRm7HL2WXIp5qfPqqO7Mjg4H7KVvsyLo6e25+LCbk9/2YO1wZxrZSCXvEBHrbeRNQWZbwX6f2NpsndRPXQWISlR29dflKOkvA91VomTJS94Pl3crLXNF3Spbhx09ERdsgmR3qghufOipdzKY8xefeVkzMGu0bBzKtN4rMnTwj+AY+SSj6RHqcY3gNC8m4v8oBAwfOYFuO1oWLX3YnBriAlDrTShvmxCFHG/VRLqTAxXCgTeyjuh969rasqIOhCe5ECYRginAm2dU837tdhUVf7E/YXlWPdbQGGHAPHAw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <377373FC9EE9DA4D92BB84D26F6073F4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3333
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(39860400002)(346002)(199004)(189003)(76130400001)(478600001)(50466002)(1076003)(26826003)(966005)(6636002)(8676002)(14454004)(22756006)(25786009)(46406003)(305945005)(7736002)(47776003)(229853002)(2906002)(70586007)(81166006)(81156014)(8746002)(4326008)(8936002)(356004)(70206006)(6862004)(97756001)(6246003)(86362001)(66066001)(6512007)(9686003)(316002)(6486002)(23726003)(5660300002)(107886003)(54906003)(476003)(126002)(446003)(11346002)(36906005)(99286004)(3846002)(6116002)(6506007)(58126008)(76176011)(4744005)(26005)(486006)(336012)(102836004)(386003)(6306002)(63350400001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:PR2PR08MB4908;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8b270db4-aa36-43f2-6edf-08d753ab449d
NoDisclaimer: True
X-Forefront-PRVS: 01949FE337
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3eC6PUsm0nwx5kVkgcyhjxSmozOYWoGT6Y6lcJlBIRKRNWb6UN8VR/MzzzXYQhsxAJ7/wEAySte7l8OIlpkZ3BoS7eHTRjntG+CBJSe4AUNiX5l/+rq4jZeLMpL7URQBLDeTdeGrScusJ4y8JtuUiyyibyVARyV8FsbC54Ne7YV1voXy+DKirdl5IAR9cwut378XbTy5vKyowSweEMvL+/5X/6a+FmKyzdOQMtbpy6NeMydFtI+M2/yja19lEx1Z2cEwqdoaIxjafDIIewTagKDB2+eh9mLdub8sw1BfDOlmgAAURoHADG2hM3z0cmYtaAAeO9GDHmsvJlzY+1eC7N5ToGH+Ij6ddb3t5k92QFTs3W7yKD0rD82KN5Qp3qwQbXzfFsUDtG+k9QlfEkQF874yOKY93YotMbT9D4SsznBibzvz2SX3mIRpYtckFWZBXshlLXMHRqM4gCKv+a2d+Q==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2019 09:12:26.4165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eba6977f-b9b5-4a9a-f08b-08d753ab4b56
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4908
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 06:57:05AM +0000, james qian wang (Arm Technology C=
hina) wrote:
>=20
> Hi Brian:
>=20
> Can this convince you to fully swap to bridge ?

Not until those patches materialise and land, no :-)

>=20
> Actually even there is no fix, we won't real encounter such rmmod problem=
,
> since we always build the bridge/tda998 (by Y) into the image.
>=20

If you say so. I think the folks here like having drm as a module to
make it easy to patch things without a reboot.

-Brian

> Thanks
> James
> > --=20
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622k=
bps up
> > According to speedtest.net: 11.9Mbps down 500kbps up
