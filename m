Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB13FA3733
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7B620659
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Xz2aNYzo";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Xz2aNYzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390810AbfJQKVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:21:24 -0400
Received: from mail-eopbgr50071.outbound.protection.outlook.com ([40.107.5.71]:17322
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726248AbfJQKVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHOCG4g14g9I82Tgawbo8Uuxf673x4zWA7hdx+/rFe0=;
 b=Xz2aNYzobNJDYdN6bERQ+moPCyBw815OVan/SDufJ1aNa2IMaeYXVx/COOCKqJYahoaClOZc04EslUVJpy0xzbuMyhmgCYpQ0Qd39+ye2ssUf0EnIUyIt3sf04Zm3dJUoNiDwc7Aq/52+xr5ACFyJrxNDAveuFZ+fjCqAiLQKmw=
Received: from DB7PR08CA0011.eurprd08.prod.outlook.com (2603:10a6:5:16::24) by
 AM6PR08MB3624.eurprd08.prod.outlook.com (2603:10a6:20b:51::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 10:21:17 +0000
Received: from VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by DB7PR08CA0011.outlook.office365.com
 (2603:10a6:5:16::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.21 via Frontend
 Transport; Thu, 17 Oct 2019 10:21:17 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT061.mail.protection.outlook.com (10.152.19.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Thu, 17 Oct 2019 10:21:15 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Thu, 17 Oct 2019 10:21:11 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6da32e8c48f5518c
X-CR-MTA-TID: 64aa7808
Received: from 05b673008291.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BD2A9E65-89EA-4F96-8E41-C1A81B57481D.1;
        Thu, 17 Oct 2019 10:21:05 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2051.outbound.protection.outlook.com [104.47.6.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 05b673008291.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 17 Oct 2019 10:21:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRMcULz8ceahvCO4TaRUgPsOPpypWEVRbQwK4nO3balanlnEbjZdeW3+Ez+jSJe7ugnP6G3r/tYV0j7WD1uadnNVEzIDbppUqUi0V+wPQvZnxGLHe4jKCTDa/r69a7CXjpJtH2wxDN12LUUx0IgaztcMmHEgASqX3b1ARcWts4pCml1d7Ar+qy9GHkXvfZ9AybU0Eyr30cyOUQlA79QZA3qoSw3L/qNoJj4HyAr4ztG6iCfQUWAJ1ctvRVZpNjCE4otjd2ClX7pds6I5sYoSr85u2rKU6xwd2d1tsqWBE/lcAv7crH3Zj6DT5vV6rNBf4tTsI29vhhStzCmViuHXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHOCG4g14g9I82Tgawbo8Uuxf673x4zWA7hdx+/rFe0=;
 b=UZlwrv61r8+7AbarAEIxvHy9A3yexPw5oNXLzaxjBU6k0TqAlRgZXYscM8+3rsT1+uvk6yKCznvd61IZTlHjYvq22O8TVXRi40toAWpRmCEG2vQFZXtQYiBrYxNRKGdEE3zOWu6uM8n8PtrasuCbYPS9FsCS5xpsnLtbJk/O4MN/l+v7c13BDlYAzPkTPR62mCQlDgXN5PK0uAJnvXT1+S/BQEUs+E82l/p/tzLoyjYdjLRfu59HawWDUDbVA0vV3PxV6aqSdP1eM3cfyAu4s2L+eKADWcdyxpcGDrGjcAAvHB0v3STtPzdGjl8dFk8rZGFlY+yx7cRZMMWjwF5djw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHOCG4g14g9I82Tgawbo8Uuxf673x4zWA7hdx+/rFe0=;
 b=Xz2aNYzobNJDYdN6bERQ+moPCyBw815OVan/SDufJ1aNa2IMaeYXVx/COOCKqJYahoaClOZc04EslUVJpy0xzbuMyhmgCYpQ0Qd39+ye2ssUf0EnIUyIt3sf04Zm3dJUoNiDwc7Aq/52+xr5ACFyJrxNDAveuFZ+fjCqAiLQKmw=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4751.eurprd08.prod.outlook.com (10.255.113.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Thu, 17 Oct 2019 10:21:03 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 10:21:03 +0000
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
Thread-Index: AQHVfmX7+sBzYHhR8EiYyRUjNjETp6dddmWAgAAIg4CAALRsAIAAV3gAgAAhhoA=
Date:   Thu, 17 Oct 2019 10:21:03 +0000
Message-ID: <20191017102055.GA8308@jamwan02-TSP300>
References: <20191004143418.53039-4-mihail.atanassov@arm.com>
 <20191009055407.GA3082@jamwan02-TSP300> <5390495.Gzyn2rW8Nj@e123338-lin>
 <20191016162206.u2yo37rtqwou4oep@DESKTOP-E1NTVVP.localdomain>
 <20191017030752.GA3109@jamwan02-TSP300>
 <20191017082043.bpiuvfr3r4jngxtu@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20191017082043.bpiuvfr3r4jngxtu@DESKTOP-E1NTVVP.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0182.apcprd02.prod.outlook.com
 (2603:1096:201:21::18) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: db8a6219-6ed8-4069-f3e5-08d752ebbe41
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4751:|VE1PR08MB4751:|AM6PR08MB3624:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB36244B0E7E77ACF4D498EA19B36D0@AM6PR08MB3624.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 01930B2BA8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(199004)(189003)(66066001)(52116002)(476003)(102836004)(6862004)(11346002)(71190400001)(446003)(256004)(26005)(71200400001)(1076003)(186003)(386003)(66446008)(66476007)(14444005)(64756008)(316002)(55236004)(6506007)(66946007)(3846002)(4326008)(66556008)(86362001)(6512007)(9686003)(6116002)(76176011)(14454004)(5660300002)(25786009)(8676002)(2906002)(229853002)(81156014)(8936002)(7736002)(6636002)(305945005)(486006)(6486002)(54906003)(99286004)(6246003)(58126008)(81166006)(33656002)(478600001)(6436002)(33716001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4751;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: urF/W+RrRCjgIXqkHPR4S2PXu4lziqeS/k23ViucitRQ79KqLjqKzetthDuaNgIZdcu1PHhZsmy3NIDHermIwdWYUsVpF9Uu8icXjNrtd/DmRfqWYoL5ZpjTjeljyvJ5fCmeNz0O8S+4yP3VrtDhEFDFRdZQn3Mi7+hze1rwoqUy+LasTc825Zezsrk6lOSl++3mlRTpBofIzf/z6B16s0ieBsJAHsibwWlhYXfEdlKyXCeTsmuWrir2ynn9eqv7P0X3bnnu/4sud+fIMnBwnYFB8rQ2QgtC/qGv8h5+lJ1OJyElq4NZyKIvgl1/qo/JV/QE7ZtIw3UZJ56YD9My5sAEZLzvujQThOJ0doF1bVmbj8R/Zqn/Q5YdRJPz+JoS9uZXyf1PEtsnQKy6EzIVa+4FmDsn8CLV8EbeFpjW7Mk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E816EBE59B03C4C9685BB5552ED9FBF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4751
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(136003)(39860400002)(376002)(396003)(189003)(199004)(356004)(6862004)(4326008)(66066001)(14454004)(33716001)(1076003)(46406003)(14444005)(99286004)(47776003)(2906002)(50466002)(6246003)(107886003)(36906005)(316002)(25786009)(8746002)(26826003)(6486002)(8936002)(229853002)(478600001)(5660300002)(54906003)(3846002)(23726003)(305945005)(70206006)(9686003)(6512007)(33656002)(126002)(8676002)(58126008)(486006)(81166006)(81156014)(22756006)(7736002)(446003)(76176011)(63350400001)(97756001)(386003)(11346002)(186003)(102836004)(86362001)(336012)(6636002)(76130400001)(26005)(6116002)(6506007)(70586007)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3624;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: ae12bc4e-ea00-44a1-5cab-08d752ebb68f
NoDisclaimer: True
X-Forefront-PRVS: 01930B2BA8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVRBU404rkusf/C2alU4hOPW8I6OYxHWepVZ4KYyUtPVWq3ZiSeR7jLdWF++5K7sencW54O2osEP01ATNO34E9e7HBdJ1g+qmC9QeEPsUAj+CkI+TAq2bbBOCGxmoN3no28bSi/97Cdc/KTxeV3fA51BgJnCeTuU4MWobEuxJ1M96PuyX4p+0TcrcAmUc7X1QXnDcGa4x6TiC18+FDrK75Ei++9apq2OIHcC2U9Qge6T5VTPlyVLNutwj5+qVDpbapA1tMlwtou311SGGAnVIizCdF3+vOFGdluDVS9bFSpcYKyIrzmlYAdG39Tax6fTY0dGzf1Rgk7w4dWMYuOpVaYlEVcWolC7CD9v7/9Ky7RMg3M9wtYizNwT2tarYmhAzZRBDN1UQzmxZSvA6klIL3SGwVd1eaP17/alg5fsYSo=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 10:21:15.7919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db8a6219-6ed8-4069-f3e5-08d752ebbe41
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3624
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 08:20:56AM +0000, Brian Starkey wrote:
> On Thu, Oct 17, 2019 at 03:07:59AM +0000, james qian wang (Arm Technology=
 China) wrote:
> > On Wed, Oct 16, 2019 at 04:22:07PM +0000, Brian Starkey wrote:
> > >=20
> > > If James is strongly against merging this, maybe we just swap
> > > wholesale to bridge? But for me, the pragmatic approach would be this
> > > stop-gap.
> > >
> >=20
> > This is a good idea, and I vote +ULONG_MAX :)
> >=20
> > and I also checked tda998x driver, it supports bridge. so swap the
> > wholesale to brige is perfect. :)
> >=20
>=20
> Well, as Mihail wrote, it's definitely not perfect.
>=20
> Today, if you rmmod tda998x with the DPU driver still loaded,
> everything will be unbound gracefully.
>=20
> If we swap to bridge, then rmmod'ing tda998x (or any other bridge
> driver the DPU is using) with the DPU driver still loaded will result
> in a crash.

I haven't read the bridge code, but seems this is a bug of drm_bridge,
since if the bridge is still in using by others, the rmmod should fail

And personally opinion, if the bridge doesn't handle the dependence.
for us:

- add such support to bridge
  or
- just do the insmod/rmmod in correct order.

> So, there really are proper benefits to sticking with the component
> code for tda998x, which is why I'd like to understand why you're so
> against this patch?
>

This change handles two different connectors in komeda internally, compare
with one interface, it increases the complexity, more risk of bug and more
cost of maintainance.

So my suggestion is keeping on one single interface in komeda, no
matter it is bridge or component, but I'd like it only one, but not
them both in komeda.

Thanks
James

> Thanks,
> -Brian
