Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A8EC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881D120679
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="LDnc57Qr";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="LDnc57Qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbfI3Kia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:38:30 -0400
Received: from mail-eopbgr150073.outbound.protection.outlook.com ([40.107.15.73]:1441
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729870AbfI3Kia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qONRKqBvkt1IpQ+h599hAArEKDB2e2sWBruuLP6md+k=;
 b=LDnc57QrkKqRSDnhkf0iy+IdTw3KN5dlKsxWB5eUQPgi/Bj99YTqBFVxsEeTYs9RJU4ffA0yBA2GtilRUjNhGcX7TKOh6nHYyKl/M0h7FPpGIHR4qWeXoEc+mGA2SBB1Qwrm0uKx7GbnAc6UP4ashSKDk9GOAFtnfwLYewmw4Fk=
Received: from VI1PR08CA0219.eurprd08.prod.outlook.com (2603:10a6:802:15::28)
 by AM0PR08MB3251.eurprd08.prod.outlook.com (2603:10a6:208:63::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Mon, 30 Sep
 2019 10:36:45 +0000
Received: from DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by VI1PR08CA0219.outlook.office365.com
 (2603:10a6:802:15::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.15 via Frontend
 Transport; Mon, 30 Sep 2019 10:36:45 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT010.mail.protection.outlook.com (10.152.20.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 30 Sep 2019 10:36:43 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Mon, 30 Sep 2019 10:36:37 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bde6d61795fd5f44
X-CR-MTA-TID: 64aa7808
Received: from ee54bc317598.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0AC95A4E-366C-4092-888C-25D1C19A9EC0.1;
        Mon, 30 Sep 2019 10:36:32 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2056.outbound.protection.outlook.com [104.47.6.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ee54bc317598.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 30 Sep 2019 10:36:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNAurmxlNkMWtG8Wy+GwR4noc9Gzu+EDQaeI3WtZJLhOnUpN0yGY7iBn2nlfRr9lCZNQ3XMJTE10h1hp1IiXV0XAFNUjWiWPB05xVNNorpBFKsXRL2UfOR6G4FD8fRtAb2Ro1/cDc/5WDghUAwMHMlk8gzVWk7idLxiRekC3QRW6vSDaC28vcXDK1mifnJc/HdaUUDRlQY6apVstiJ/NlquKZM0W/bPSfiAp2L4hH4yamnrwhA3/RvLN522LHlm1JJwfMoevSFjU6r7pazTz77BGyGHjR+hzLPAGX4Yeuo4N3naKnoIpOvuVgfe97srIcBoJaR7rbNZGLFZCQUOHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qONRKqBvkt1IpQ+h599hAArEKDB2e2sWBruuLP6md+k=;
 b=jUma4CIANX66t0xmIu+9pBJS1BvTJJ+zUOgf+H0WFOLF8UDFJ5no8RQfjnGxXEWwfcqD8AarSxMVq3U2X8JIoyZyUwHWSzUJqDeMCk6HCukYmI1ZC6Syyc4IH1J1PvPq8EW+J34qt8HFkH321/qaZOOogqUxe+4EGDlBcAjmnqRD2OKT+uqg4s/bmT3dC99LKvIq5+/DSm3Ou5nxnKeGsfc2s5Es8gL4nVMGrVfXxWRkOGJYYFDfq9OjlCkbwYeT5I3pUPYE9WK7e3986cNJ6X1Yxez8XD613pc9LPRIykBM0TlnNEgGnnkn4QZDQDeNRnwfR/vNXBgYREwZovQ/8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qONRKqBvkt1IpQ+h599hAArEKDB2e2sWBruuLP6md+k=;
 b=LDnc57QrkKqRSDnhkf0iy+IdTw3KN5dlKsxWB5eUQPgi/Bj99YTqBFVxsEeTYs9RJU4ffA0yBA2GtilRUjNhGcX7TKOh6nHYyKl/M0h7FPpGIHR4qWeXoEc+mGA2SBB1Qwrm0uKx7GbnAc6UP4ashSKDk9GOAFtnfwLYewmw4Fk=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB3301.eurprd08.prod.outlook.com (52.135.164.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 10:36:27 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976%7]) with mapi id 15.20.2284.028; Mon, 30 Sep 2019
 10:36:27 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
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
Thread-Index: AQHVb5fml3iiEtk+MEOqXjNduhm+kKc5MiiAgADp5ICAAhFyAIACqBcAgAVBDQA=
Date:   Mon, 30 Sep 2019 10:36:27 +0000
Message-ID: <20190930103626.de3p6rbowyerjbks@DESKTOP-E1NTVVP.localdomain>
References: <20190920094329.17513-1-lowry.li@arm.com>
 <20190923121604.jqi6ewln27yvdajw@DESKTOP-E1NTVVP.localdomain>
 <20190924021313.GA15776@jamwan02-TSP300>
 <20190925094810.fbeyt7fxvyhaip33@DESKTOP-E1NTVVP.localdomain>
 <20190927022218.GA11732@jamwan02-TSP300>
In-Reply-To: <20190927022218.GA11732@jamwan02-TSP300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LO2P265CA0428.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::32) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: dbf78b63-4772-422d-ce64-08d7459215f1
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM6PR08MB3301:|AM6PR08MB3301:|AM0PR08MB3251:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3251087A9E1F72A915C06ACEF0820@AM0PR08MB3251.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 01762B0D64
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(189003)(199004)(11346002)(8676002)(476003)(478600001)(446003)(386003)(86362001)(8936002)(316002)(81166006)(81156014)(71190400001)(58126008)(4326008)(71200400001)(54906003)(1076003)(99286004)(486006)(6506007)(6636002)(256004)(2906002)(76176011)(6436002)(6486002)(5660300002)(186003)(9686003)(6512007)(44832011)(3846002)(102836004)(66446008)(64756008)(7736002)(66556008)(6862004)(66946007)(66476007)(66066001)(6246003)(229853002)(14454004)(52116002)(26005)(6116002)(305945005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3301;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: fDQ22QzaEYltZYthtlgv262dWvnhzxDtjO9JFEeLc4VUx7Uebyuamx0cOEcuDhgDU59cKGGski/F/Nhup+6rUK7/NkZduizNdUi+CScBsy0I2H9Zslj8KITXoG/bQqL8cdDe7uQPADZZLxGyCbA8WHxXmlb4CWdwOQPu1+yrO3gtdif/qehFPYFb1159WOGS8jEPsKZb8QTs+01ri+FuR4hMaldLXcazFPotug/6y4ilXw2PkW1bKx0JWdH3HvbVpWO1F854ZZnWKoD3rZPp9Q+WdOjumNsm855L4gqxY67z9NalpcZSzPrcSMs0hpdm/MoWKK+gtFDJfc7CQ5bXkdyomRzhtRc6kWZYFBP3/sXCx+ycrywy770HoDX7zgMkzxld8Zqp2sj07gu9dVbwytfFpIcsjwJmwYKeIgwFXHY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FEC1E22EAEC731408B0F44E2F806E6AB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3301
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(189003)(199004)(229853002)(23726003)(26005)(76176011)(70586007)(9686003)(2906002)(6506007)(386003)(54906003)(6512007)(102836004)(66066001)(6116002)(47776003)(76130400001)(99286004)(70206006)(478600001)(26826003)(6486002)(25786009)(14454004)(58126008)(316002)(6246003)(186003)(6862004)(50466002)(3846002)(4326008)(8936002)(126002)(486006)(63350400001)(86362001)(22756006)(1076003)(305945005)(8746002)(5660300002)(7736002)(8676002)(46406003)(446003)(11346002)(356004)(81166006)(81156014)(336012)(97756001)(6636002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3251;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: fc49b9e9-aaac-410a-52bd-08d745920c42
NoDisclaimer: True
X-Forefront-PRVS: 01762B0D64
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +cZCw6BoU2Vfe2FCm1mRvCxYpndZztWsxeWefHlYhyv3E1wbgU/RVwsD+dMS2fOqbKtvKxVRAfBCEu34ep249wBJ/HEfasa33GEVFb6tH6NdvSohet65bI2RfpV2lVjrb5aue6jwMvJmNW46P6QZX/4Vm53RVndCDwdha2suuxUnUfYAzOpURHwffx3qg7wxaz76FFX8wColpl2VavJfozRoZDrTGX+1PLDMZkrThF7F3UbUXjP4oVE4qxbTWInP4z6gCEFwmTgM8AKJZ55D7LmjCPDo+A536KF/Wa0l1CTcrAcmhnLlIJfcBO5n1Dp2NUrld4+XXjZGXZJPZBZ1k46Vp/gdISfV4yVsE8jQAv0gVS9InhWZrqJkP4A9ywGZXKUg6CNg42Se8vMuOMBFykAdA6YVUuOa6TxaD6P3lhM=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2019 10:36:43.1424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf78b63-4772-422d-ce64-08d7459215f1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3251
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 02:22:24AM +0000, james qian wang (Arm Technology C=
hina) wrote:
> On Wed, Sep 25, 2019 at 09:48:11AM +0000, Brian Starkey wrote:
> > Hi James,
> >=20
> > On Tue, Sep 24, 2019 at 02:13:27AM +0000, james qian wang (Arm Technolo=
gy China) wrote:
> > >=20
> > > Hi Brian:
> > >=20
> > > Since one monitor can support mutiple color-formats, this DT property
> > > supply a way for user to select a specific one from this supported
> > > color-formats.
> >=20
> > Modifying DT is a _really_ user-unfriendly way of specifying
> > preferences. If we want a user to be able to pick a preferred format,
> > then it should probably be via the atomic API as Ville mentioned.
> >
>=20
> Hi Brian:
>=20
> Agree, a drm UPAI might be the best & right way for this.
>=20
> I can raise a new thread/topic to discuss the "HOW TO", maybe after the
> Chinese national day.
>=20
> LAST:
> what do you think about this patch:
> - Just drop it, waiting for the new uapi
> - or keep it, and replace it once new uapi is ready.

The bit-depth stuff is clear and non-controversial, so you could split
that out and merge it.

For the YUV stuff, I think it would be fine to merge the
implementation that we discussed here - force YUV for modes which must
be YUV, and leave the user-preference stuff for a later UAPI.

Thanks,
-Brian

>=20
> Thanks
> James
>=20
> > Cheers,
> > -Brian
