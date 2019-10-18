Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D9ACA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBF821925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ZXFEBkFJ";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ZXFEBkFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409544AbfJRG5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:57:34 -0400
Received: from mail-eopbgr120040.outbound.protection.outlook.com ([40.107.12.40]:47746
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2504354AbfJRG5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPyEoTUlrU8QvEYqz8Tk32AJTLkpJosaPzdc17aMazU=;
 b=ZXFEBkFJo+3tpZ2aVAeXjX/jS4jz+jsRGNKTL2jTtBTAo3ZxsheWBqVa5Y/ja3B3Wyjy9cXe+gZlSgm/Dc9WbD5jKMkMMvfz8+sL5oKEF5XyESUqebSahgzfLBnnoOyjbwcOKX8cXCELDKDHNeOjFS+ENDTVauvNhXNjQNH1R2k=
Received: from VI1PR08CA0270.eurprd08.prod.outlook.com (2603:10a6:803:dc::43)
 by PR2PR08MB4635.eurprd08.prod.outlook.com (2603:10a6:101:18::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Fri, 18 Oct
 2019 06:57:21 +0000
Received: from VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by VI1PR08CA0270.outlook.office365.com
 (2603:10a6:803:dc::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 18 Oct 2019 06:57:20 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT050.mail.protection.outlook.com (10.152.19.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 18 Oct 2019 06:57:19 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Fri, 18 Oct 2019 06:57:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cc54e5edf7b0fa3a
X-CR-MTA-TID: 64aa7808
Received: from 4278e5fca78a.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 02BA9805-DBCC-43BE-8BA1-A9B0A017F460.1;
        Fri, 18 Oct 2019 06:57:09 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2057.outbound.protection.outlook.com [104.47.8.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4278e5fca78a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 18 Oct 2019 06:57:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLgQJY89eTmbjF+ib/LF9JQUEL6ihC8FelaNSLjyDniLoe7HYPRzIcWk0dSOd/4QXpIpHAipiWf4ecCy8KXvfvvZNvcqKchqkQmrGpFr/zAUQSk9ZC/K2KLYdcnCCeKzCOauN9hij5LLkmFfHk7ZSPL+NawKhaUKp+mnGo3OhwA+H+tsxloazMj4X9NxsMaKBeptD7WZt+RDmm7FI2dVxYzhbwiqgCxlx0OTV36OebBObBf3eZeozfbnU/y71QD4kh1FhfLg2GOTcUg+3LTAUD8TlD4UWZJRWaR9AkU/zB0EQOQvVHA+YcGezC5RYRxsNuJKpl7VZpFVe0zJwM1jWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPyEoTUlrU8QvEYqz8Tk32AJTLkpJosaPzdc17aMazU=;
 b=mBb/8b4hVGDQtII9A6eJHFd5xJkm/ZktPDFfGjxNUISwAkIjhoMFxDU4tb6vamBOfv8u+YTARMvb08VlUG7h9kkkQxYW5vuv+LLP/FPfNkPriommIsOGMc2WfP7X0aDK7h1G178tPHDM36SK3EdA9Ud15WOjapnmyoS+UgYg640L8vTLjkzrB4oUxm+w/RgM1tsmCKf8pfr6Bi1JtNTZYvIlS0G6Os5dM94sttSdQDBmAp1HrWRS4B2TzYxYneL1nB6MtVZtCikDKINrKUR1oqWuoDxp8F9ceEwdF5UoJzqVLAIBfwigkZkN8EX5+4GEa5FzCpN2uAteR10vBjT/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPyEoTUlrU8QvEYqz8Tk32AJTLkpJosaPzdc17aMazU=;
 b=ZXFEBkFJo+3tpZ2aVAeXjX/jS4jz+jsRGNKTL2jTtBTAo3ZxsheWBqVa5Y/ja3B3Wyjy9cXe+gZlSgm/Dc9WbD5jKMkMMvfz8+sL5oKEF5XyESUqebSahgzfLBnnoOyjbwcOKX8cXCELDKDHNeOjFS+ENDTVauvNhXNjQNH1R2k=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4640.eurprd08.prod.outlook.com (10.255.27.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 18 Oct 2019 06:57:05 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.026; Fri, 18 Oct 2019
 06:57:05 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Brian Starkey <Brian.Starkey@arm.com>,
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
Thread-Index: AQHVfmX7+sBzYHhR8EiYyRUjNjETp6dddmWAgAAIg4CAALRsAIAAV3gAgAAhhoCAAAegAIAADuyAgAFCzIA=
Date:   Fri, 18 Oct 2019 06:57:05 +0000
Message-ID: <20191018065657.GA19117@jamwan02-TSP300>
References: <20191004143418.53039-4-mihail.atanassov@arm.com>
 <20191009055407.GA3082@jamwan02-TSP300> <5390495.Gzyn2rW8Nj@e123338-lin>
 <20191016162206.u2yo37rtqwou4oep@DESKTOP-E1NTVVP.localdomain>
 <20191017030752.GA3109@jamwan02-TSP300>
 <20191017082043.bpiuvfr3r4jngxtu@DESKTOP-E1NTVVP.localdomain>
 <20191017102055.GA8308@jamwan02-TSP300>
 <20191017104812.6qpuzoh5bx5i2y3m@DESKTOP-E1NTVVP.localdomain>
 <20191017114137.GC25745@shell.armlinux.org.uk>
In-Reply-To: <20191017114137.GC25745@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0001.apcprd03.prod.outlook.com
 (2603:1096:203:2e::13) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: dc155520-5ee6-4c9c-5be5-08d753986b52
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4640:|VE1PR08MB4640:|PR2PR08MB4635:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <PR2PR08MB4635DA6F7C9CB312BF69971FB36C0@PR2PR08MB4635.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 01949FE337
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(189003)(199004)(51444003)(6916009)(476003)(305945005)(6436002)(54906003)(6116002)(446003)(6306002)(11346002)(66066001)(66476007)(64756008)(66446008)(7736002)(66556008)(229853002)(2906002)(316002)(33656002)(186003)(81166006)(6486002)(9686003)(486006)(6512007)(81156014)(6506007)(386003)(58126008)(76176011)(14444005)(99286004)(256004)(66946007)(8936002)(966005)(6246003)(3846002)(52116002)(26005)(4326008)(14454004)(71200400001)(71190400001)(102836004)(5660300002)(8676002)(33716001)(25786009)(55236004)(1076003)(86362001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4640;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: cilwhNXXYUgmymZUG40aeaPFJ9SksP8pZ/w61/L0l4hF+JhGrbuQ91XRMlMqdg2gJXngCOGqSKraKd6PfrD9/zAFFBPdKJtsRSSIqaAhLRT9MBFpaUIaLMXzrWBr2bopcpXsj1Bxzx7f9JBk9FL8KUQV90PMZVeE0Yx/u0JRzYmFuUBYgsE5owEr+Q1Vjsbd0Dff0Yen0xPkBTWUZUTwLkpOh1TR0waY7TX/6lGbEYTzA3lgrVHyHIIulrEX14U5gYv6fJA9fhVM/sATmC4gBdC5MYgBcvukT+T/opE15S+7zAKv9SLZ3JL3liFEvIhr1pliI6FKoqCZ5tlXWe95bZnTo+1UnjjUWLnmSad83jV3gkuw5MuWO0s7yQQZVrcX5jd1RhA45Wl5s1HjaqjeYs86ivYbIxJglrDIZQ4rHsYUMyuJolWNQh+s5wR/wtlfDFceJGzLLDD9bzQaNIwhLA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E3946259F4482D41BC696EE8D19DFF66@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4640
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(39860400002)(396003)(136003)(346002)(199004)(189003)(51444003)(229853002)(476003)(6512007)(9686003)(1076003)(33716001)(107886003)(356004)(14454004)(11346002)(6306002)(22756006)(6246003)(47776003)(126002)(70206006)(7736002)(102836004)(70586007)(6862004)(305945005)(8746002)(8936002)(446003)(81166006)(8676002)(63350400001)(81156014)(86362001)(186003)(99286004)(3846002)(6116002)(76130400001)(23726003)(2906002)(4326008)(336012)(6506007)(316002)(97756001)(36906005)(58126008)(25786009)(14444005)(46406003)(76176011)(26005)(33656002)(26826003)(66066001)(6486002)(5660300002)(478600001)(966005)(50466002)(54906003)(386003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:PR2PR08MB4635;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: bdea8aa2-c049-4aac-8dfe-08d7539862ad
NoDisclaimer: True
X-Forefront-PRVS: 01949FE337
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RwB42FLupc9Fkbo/iDtLIQCUjnTeSWyc2nx8LNfRZ/hhQ8YbJxg2wNb51oikZ/0lO61sdVRfzl97/w1v0lpZtEhILJRlIT3YZIbtYC7ATsLBHYtwP8v9rcQTqzUePCDHTCyyr6Uz8xpxx/6Dw958/ErTPrlBOuqKy4XFmWScassTWN2MadcUUwEjK61USv6pMtmaEuq3IFIRfmTWWJ8QvRrrueX6u+RV/tcPbLY3UM3+7aybYRezgJbhvytvEUsOdi2WME2pf2tU8D4cc5YwXtpGuMt0v1WnQ+tpuXhnPUMZ/6MATb8WXLQXu2HdSUE8QNJvtV7PowWR8xR36Bouvc5+etq00znEeQuahi38+BHiKcjMF/MQiL4ueKFNVT4uLL5q35KjZ9eGNl251fCupNT6t/CAXi/OBYPuD7/PECZKNREorXUoSyI9sWRESbofeO+ORP30bndAflNTzo1PsA==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2019 06:57:19.5507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc155520-5ee6-4c9c-5be5-08d753986b52
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4635
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 12:41:37PM +0100, Russell King - ARM Linux admin wr=
ote:
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
> >=20
> > As/when improvements are made to the bridge code we can remove the
> > component bits and not lose anything.
>=20
> There was an idea a while back about using the device links code to
> solve the bridge issue - but at the time the device links code wasn't
> up to the job.  I think that's been resolved now, but I haven't been
> able to confirm it.  I did propose some patches for bridge at the
> time but they probably need updating.

Hi Russell:

Thank you, that's a good news.

Hi Brian:

Can this convince you to fully swap to bridge ?

Actually even there is no fix, we won't real encounter such rmmod problem,
since we always build the bridge/tda998 (by Y) into the image.

Thanks
James
> --=20
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbp=
s up
> According to speedtest.net: 11.9Mbps down 500kbps up
