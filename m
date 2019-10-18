Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C500CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A2520820
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xBmbfXXa";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xBmbfXXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442062AbfJRGjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:39:20 -0400
Received: from mail-eopbgr90082.outbound.protection.outlook.com ([40.107.9.82]:65168
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728284AbfJRGjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deovY0igDeil9fRvR2ecRNrPldYF/S5H5KUBG8sFtx8=;
 b=xBmbfXXaTXaZFtWgGvSc06WvtqMYf1gz2CKPIVupo+vTyr9zj5LkcFy2Ti7pIuVmmvtY3Il6aeobiiXBYrUojMiArkc9jp08fzmpkD6TSiCph0oJP15R0qqQq85P860R0RiuRWKWfrbjPYhVL0MZcaSrSPhpHEdixxB7oC6YUeY=
Received: from DB6PR0802CA0040.eurprd08.prod.outlook.com (2603:10a6:4:a3::26)
 by PR2PR08MB4857.eurprd08.prod.outlook.com (2603:10a6:101:1c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Fri, 18 Oct
 2019 06:39:11 +0000
Received: from DB5EUR03FT029.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by DB6PR0802CA0040.outlook.office365.com
 (2603:10a6:4:a3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 18 Oct 2019 06:39:11 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT029.mail.protection.outlook.com (10.152.20.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 18 Oct 2019 06:39:08 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Fri, 18 Oct 2019 06:39:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3c989cafdc21090c
X-CR-MTA-TID: 64aa7808
Received: from 788a2b172e8a.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7B99A076-E363-42E5-834E-1D73A5D76034.1;
        Fri, 18 Oct 2019 06:39:01 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2059.outbound.protection.outlook.com [104.47.6.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 788a2b172e8a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 18 Oct 2019 06:39:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4Rh0z9bOo7CPDhPYaxazNMQjMU0QU1zeITCajUOrXWW4t2K21mFwAGzNAxaI7RJFtSw5fZse5jBhGcCbIdmYzmG17k77ye1O4i/8eTA5C63/4OXtud2q1t4vx2Uos6CtUSwuTz0AfTIbMWkwLYJrauTQmo5TGRxqjYCMMWLMawxptaZmxeip1auN7Wzasa/vF4P+xa15JASx90y6W2IbLx+U8kvkfOg/nFkslHHFCSOgXSUulhFk8O3JcmOAxanxtWtYA6bsjyZrLtim+Wygz0QdH4BEPsYOoLc7PlEGbez7W3zZJUEv91XnhkCjn1MkDz1/yQwVGvcBXWX1LA40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deovY0igDeil9fRvR2ecRNrPldYF/S5H5KUBG8sFtx8=;
 b=QT6RcJlaBt6iJY9hsOX+bJMLhVS2LvHd7kicSFCWakZqib8ocDIajZBWMik4xWLK+tbqtqKAR+tSrNVaWQPuGeK8BGZ/Igd7g88V+6nlgUXlGqI/xw9jNj335krNx8URa2GGDxxWzDsBCriC5UG2crBhxzvAy2pl+DZ/Q3GoMgfCZDWqVwPUwLLKy4ZICaF0hWKYZDApTdAkPoVJx/WU16jvLEUOL6/r+p9F/M1zIu96ns4BWFtVZQddU0WdzAzde3QRzoeCVFInP6RUtMK3sDWtW2Khr8ZdKzUETDzmTa/y1WxaiVomYrSVgm/xA5e2qOJ6hOUSwJQ0NmSQhEp7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deovY0igDeil9fRvR2ecRNrPldYF/S5H5KUBG8sFtx8=;
 b=xBmbfXXaTXaZFtWgGvSc06WvtqMYf1gz2CKPIVupo+vTyr9zj5LkcFy2Ti7pIuVmmvtY3Il6aeobiiXBYrUojMiArkc9jp08fzmpkD6TSiCph0oJP15R0qqQq85P860R0RiuRWKWfrbjPYhVL0MZcaSrSPhpHEdixxB7oC6YUeY=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4637.eurprd08.prod.outlook.com (10.255.114.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 18 Oct 2019 06:38:59 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.026; Fri, 18 Oct 2019
 06:38:59 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
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
Thread-Index: AQHVfmX7+sBzYHhR8EiYyRUjNjETp6dddmWAgAAIg4CAALRsAIAAV3gAgAAhhoCAAAegAIABTKqA
Date:   Fri, 18 Oct 2019 06:38:59 +0000
Message-ID: <20191018063851.GA18702@jamwan02-TSP300>
References: <20191004143418.53039-4-mihail.atanassov@arm.com>
 <20191009055407.GA3082@jamwan02-TSP300> <5390495.Gzyn2rW8Nj@e123338-lin>
 <20191016162206.u2yo37rtqwou4oep@DESKTOP-E1NTVVP.localdomain>
 <20191017030752.GA3109@jamwan02-TSP300>
 <20191017082043.bpiuvfr3r4jngxtu@DESKTOP-E1NTVVP.localdomain>
 <20191017102055.GA8308@jamwan02-TSP300>
 <20191017104812.6qpuzoh5bx5i2y3m@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20191017104812.6qpuzoh5bx5i2y3m@DESKTOP-E1NTVVP.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0401CA0009.apcprd04.prod.outlook.com
 (2603:1096:202:2::19) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 15f8a52d-e942-4d4b-f8f2-08d75395e130
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4637:|VE1PR08MB4637:|PR2PR08MB4857:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <PR2PR08MB4857D42038AD76E01C61C6D3B36C0@PR2PR08MB4857.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 01949FE337
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(26005)(66066001)(2906002)(7736002)(8676002)(6862004)(4326008)(478600001)(256004)(71190400001)(71200400001)(66946007)(54906003)(9686003)(6512007)(6636002)(14444005)(229853002)(66556008)(66476007)(66446008)(64756008)(386003)(55236004)(5660300002)(86362001)(102836004)(6506007)(25786009)(186003)(11346002)(446003)(14454004)(76176011)(81156014)(486006)(33656002)(6486002)(1076003)(8936002)(3846002)(316002)(33716001)(6246003)(305945005)(58126008)(81166006)(52116002)(476003)(6116002)(99286004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4637;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: mo+P8P+FR6ADw2qI5/d3qNSHHTIQkurKYgLLStVPsJxsjTnXENiIOvaZBEvvRnJ6XItx5m5I11lQjgoSJJhb0+fPmH07t/WO5Gpa/qlN+0zooQjJXd+a558FflkNxgnI2IJ6+S6VKLyHrIelj06yJxuaQAWOMcHRPvh6EiA/RehxtzG3t+RYJxNlJzR7nzKMIIytsiQfclGi45bsTBfw8QJbblwsO0HvJbrtSy2V6cUZRHYFw2L27ZjNpRUU6dZlGbIuOeejOeEffeEAgVbxXv5JxrGAfPBoA4XzoQfQXn0p+VRyHUZgOxHdCAAnmjDZ1C8zdHuqmPyK0shms+kNo1fRs4GbqWapX2wPm6X1UQB8O8KuBGlXmxlGJFVbGnnhgIPeVdBgBaUPmzxJfS/nhe6T8cClEKupL/Pl211hhmE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <534A4133140A7F41969D6124426D8D8A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4637
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT029.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(39860400002)(396003)(346002)(136003)(189003)(199004)(126002)(11346002)(86362001)(476003)(5660300002)(33656002)(46406003)(76130400001)(81156014)(8746002)(8936002)(76176011)(81166006)(50466002)(8676002)(478600001)(7736002)(305945005)(4326008)(14444005)(33716001)(47776003)(66066001)(6636002)(26826003)(446003)(6246003)(6862004)(336012)(14454004)(107886003)(99286004)(25786009)(70206006)(2906002)(229853002)(70586007)(102836004)(6506007)(386003)(6512007)(9686003)(26005)(186003)(3846002)(6116002)(356004)(23726003)(54906003)(6486002)(316002)(97756001)(1076003)(22756006)(63350400001)(486006)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:PR2PR08MB4857;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 414fd9d1-46eb-4c6f-2918-08d75395db44
NoDisclaimer: True
X-Forefront-PRVS: 01949FE337
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/xhuMicTBb6KwutbFaWPvHPWVBdsdIrnS2+WmCBFQZK1XGLutl2bFjGNh9TEOtTRCCO0xkwHLBQydT4EVdVYIe1HPvDIuWUzHOZ27/cHZFjML+64Zu9QQz5va2OZflD66+oxjYvZo9iN6ZtQRQW1kRERREDQxG7yts3OXgAWIKQ6dCmJF28nZvMsXWpTc6yysNQuPAwXFzewpwy4igBeqHwy4Dw9wPUb4ZCNQTUYxgBaR2MucOen1fXfc9YQG6BWMPRQHFpgp//F2E1Z+r46eL5T5qw+j5kkJiNlCpYbbsZZlZJTpHcw0chbAi0HqU+kX9TBg0FtcGkXiMl7d9ZrL4I5P2XODtsKK3R038q9dnGsqgnda9IgRVgrZbJRm8wI6ewirMLRs1ZZHLAkq6aQ9Dbof591VngSLjUPZ4EvDM=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2019 06:39:08.7508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f8a52d-e942-4d4b-f8f2-08d75395e130
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4857
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 10:48:12AM +0000, Brian Starkey wrote:
> On Thu, Oct 17, 2019 at 10:21:03AM +0000, james qian wang (Arm Technology=
 China) wrote:
> > On Thu, Oct 17, 2019 at 08:20:56AM +0000, Brian Starkey wrote:
> > > On Thu, Oct 17, 2019 at 03:07:59AM +0000, james qian wang (Arm Techno=
logy China) wrote:
> > > > On Wed, Oct 16, 2019 at 04:22:07PM +0000, Brian Starkey wrote:
> > > > >=20
> > > > > If James is strongly against merging this, maybe we just swap
> > > > > wholesale to bridge? But for me, the pragmatic approach would be =
this
> > > > > stop-gap.
> > > > >
> > > >=20
> > > > This is a good idea, and I vote +ULONG_MAX :)
> > > >=20
> > > > and I also checked tda998x driver, it supports bridge. so swap the
> > > > wholesale to brige is perfect. :)
> > > >=20
> > >=20
> > > Well, as Mihail wrote, it's definitely not perfect.
> > >=20
> > > Today, if you rmmod tda998x with the DPU driver still loaded,
> > > everything will be unbound gracefully.
> > >=20
> > > If we swap to bridge, then rmmod'ing tda998x (or any other bridge
> > > driver the DPU is using) with the DPU driver still loaded will result
> > > in a crash.
> >=20
> > I haven't read the bridge code, but seems this is a bug of drm_bridge,
> > since if the bridge is still in using by others, the rmmod should fail
> >=20
>=20
> Correct, but there's no fix for that today. You can also take a look
> at the thread linked from Mihail's cover letter.
>=20
> > And personally opinion, if the bridge doesn't handle the dependence.
> > for us:
> >=20
> > - add such support to bridge
>=20
> That would certainly be helpful. I don't know if there's consensus on
> how to do that.
>=20
> >   or
> > - just do the insmod/rmmod in correct order.
> >=20
> > > So, there really are proper benefits to sticking with the component
> > > code for tda998x, which is why I'd like to understand why you're so
> > > against this patch?
> > >
> >=20
> > This change handles two different connectors in komeda internally, comp=
are
> > with one interface, it increases the complexity, more risk of bug and m=
ore
> > cost of maintainance.
> >=20
>=20
> Well, it's only about how to bind the drivers - two different methods
> of binding, not two different connectors. I would argue that carrying
> our out-of-tree patches to support both platforms is a larger
> maintenance burden.
>=20
> Honestly this looks like a win-win to me. We get the superior approach
> when its supported, and still get to support bridges which are more
> common.
>

My consideration is: if we support both link methods, we may suffering

- 1. bridge reference cnt problem
- 2. maintance two link methods.

the 1) seems unavoidable, so swap all to bridage at least can avoid
the pain of 2). that's why I thought your idea "swap all to bridage"
is good.

Thanks
James.

> As/when improvements are made to the bridge code we can remove the
> component bits and not lose anything.
>=20
> > So my suggestion is keeping on one single interface in komeda, no
> > matter it is bridge or component, but I'd like it only one, but not
> > them both in komeda.
>=20
> If we can put the effort into fixing bridges then I guess that's the
> best approach for everyone :-) Might not be easy though!
>=20
> -Brian
>=20
> >=20
> > Thanks
> > James
> >=20
> > > Thanks,
> > > -Brian
