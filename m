Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641A1C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 02:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148D921920
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 02:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="eJH/moj/";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="eJH/moj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfI0CWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 22:22:46 -0400
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:56128
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727631AbfI0CWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 22:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sj3uqaFoS7iFPNXbwuuCnsulqMWJX5WdBCY6BJ/hxA0=;
 b=eJH/moj/3iyRu0TeWPAS1nvGigc/eWEf4x3f+LMAltIGFgm28g13AYmlgwDWkJECSfYqwvV2fSQPEhhCYc9h079QaRlaQXorjvhWJMzG57YgAe9fdCrWnRQtW1Am3YzYe1JHyEZYADf9py3cU58R+pRlH+PSiOzZVvLog0I9v6A=
Received: from AM4PR08CA0068.eurprd08.prod.outlook.com (2603:10a6:205:2::39)
 by VI1PR08MB4158.eurprd08.prod.outlook.com (2603:10a6:803:e9::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Fri, 27 Sep
 2019 02:22:36 +0000
Received: from VE1EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by AM4PR08CA0068.outlook.office365.com
 (2603:10a6:205:2::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.17 via Frontend
 Transport; Fri, 27 Sep 2019 02:22:36 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT059.mail.protection.outlook.com (10.152.19.60) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 27 Sep 2019 02:22:35 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Fri, 27 Sep 2019 02:22:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4b6112c4c3b5d4a7
X-CR-MTA-TID: 64aa7808
Received: from 7cfb8e3b9955.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.1.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 885D8583-355E-410A-AB75-3B22B005693F.1;
        Fri, 27 Sep 2019 02:22:26 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2051.outbound.protection.outlook.com [104.47.1.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7cfb8e3b9955.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 27 Sep 2019 02:22:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrzhtzxQQh3V85ujLDgApRq5D+1YXGfwl5dDtUceQo+9L4Ct9TamRDR0OTsZHONiLWVVndfir/WlQR/J/OQwTKmwek3abmEbnYYChKuRQukZR7oD8Uu7edfiV7N017m+18x8YhV+fTMq4jCZTEdH0ntkjIE8InLR1FmA9o+qTUVor4yuNznIrmvljt5jhutxrxji1Qfb3v/yix/DCygyWyz7a0+UP+7ATS/PsxMDfNsyVILi+7FkQKF7z/tql/WaVb7Ir78hd9T0IiTayjf0BEonaRd1NcaoMO3+U6mZ9Hip/+HUY3CSKy3PtwBi9q8/be/44kAiT0zvS+znxG2jXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sj3uqaFoS7iFPNXbwuuCnsulqMWJX5WdBCY6BJ/hxA0=;
 b=N6BHLHtMgGXsYyrt3afg2Zw3PkTaKzoC/aNlmhFSvEd+vUpOL+A7Cy3Oz4p7RD6gAlv0KsRtvRdcAcOjzfpxkT0odBei9ehhEF8cRVdpylKL91Qc2MEIKxOXZGnb49dD2ZaUmwVPRWQkQVRdYibLWz1vs5eDZThASqKO1JctCVI2L4p1Y/KzniybWp5SwSxwlNvWVHa9q8vy+lxYT8IFm8VGP/+uk3a5WpYKtopkCPwjBoqTUylLt4c0pa+qKa1eqZMjjqkMTGepwxgkSGHPNA/a4e4r2Vy8Dx6yqnzw8AiXNmFV2HS3beaCZOuVUv2MwTvxtdXCUw5B0Whl5e9aFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sj3uqaFoS7iFPNXbwuuCnsulqMWJX5WdBCY6BJ/hxA0=;
 b=eJH/moj/3iyRu0TeWPAS1nvGigc/eWEf4x3f+LMAltIGFgm28g13AYmlgwDWkJECSfYqwvV2fSQPEhhCYc9h079QaRlaQXorjvhWJMzG57YgAe9fdCrWnRQtW1Am3YzYe1JHyEZYADf9py3cU58R+pRlH+PSiOzZVvLog0I9v6A=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4847.eurprd08.prod.outlook.com (10.255.114.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Fri, 27 Sep 2019 02:22:25 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879%5]) with mapi id 15.20.2284.023; Fri, 27 Sep 2019
 02:22:25 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
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
Thread-Index: AQHVb5fml3iiEtk+MEOqXjNduhm+kKc5MiiAgADp5ICAAhFyAIACqBcA
Date:   Fri, 27 Sep 2019 02:22:24 +0000
Message-ID: <20190927022218.GA11732@jamwan02-TSP300>
References: <20190920094329.17513-1-lowry.li@arm.com>
 <20190923121604.jqi6ewln27yvdajw@DESKTOP-E1NTVVP.localdomain>
 <20190924021313.GA15776@jamwan02-TSP300>
 <20190925094810.fbeyt7fxvyhaip33@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190925094810.fbeyt7fxvyhaip33@DESKTOP-E1NTVVP.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2P15301CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::23) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 548f2752-61ed-425d-00a5-08d742f18f94
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VE1PR08MB4847;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4847:|VE1PR08MB4847:|VI1PR08MB4158:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4158FE3EEE7FD0D7C4E81734B3810@VI1PR08MB4158.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 0173C6D4D5
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(189003)(199004)(478600001)(2906002)(14454004)(86362001)(25786009)(186003)(7736002)(26005)(386003)(446003)(486006)(476003)(6636002)(55236004)(99286004)(66946007)(6506007)(66476007)(76176011)(3846002)(71200400001)(71190400001)(52116002)(66556008)(66446008)(64756008)(6116002)(6512007)(9686003)(6862004)(6486002)(6246003)(4744005)(66066001)(305945005)(102836004)(6436002)(11346002)(1076003)(229853002)(8936002)(54906003)(8676002)(81156014)(4326008)(81166006)(316002)(58126008)(33656002)(5660300002)(33716001)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4847;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: bw9t85S6ViV+V79hqy69DbYxx4JEK2RtBgl0CdoU4pP+/Q35U1IeJJyEyjilyA6QGc3U6UXzx6NAx2uyu9E31T0XutLp4EIc6P3ns/gxMYzH344wtbAFmIzM08vc8ENPk6P2vTPCoQRvJy92GLhpmZSD9zYU4epJBfZkNB5FMnj8GloYsE3aCcoUd0bwQFyYfIy5CT0Z2330QwfsgZHqvaU2JPzc8K+cPWV/xMd4X/1GTkKZ/tj+XvaYD08eLRRNfspiKJ3Ud5/NAyPmx18V0S4nxC26Rm/T/R8ribNWKapeQRhYvAnNYgU5HyBsVrE7p3J0Z3GTTGsCKcnat2aIiClBUI1FFZ0mVC//u92K51tHrQnYIx9Kjz9mG7emzGwV64S7v/luDuu+iiPWZHMAucjj8r27zVB42buiPMwABpQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A5B6D405326C164F9FFC6ACC39BE50EF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4847
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(3846002)(386003)(8676002)(58126008)(81166006)(316002)(478600001)(8936002)(6486002)(81156014)(22756006)(76176011)(6512007)(9686003)(4744005)(6636002)(1076003)(5660300002)(8746002)(229853002)(54906003)(50466002)(102836004)(47776003)(33656002)(99286004)(305945005)(4326008)(76130400001)(36906005)(6862004)(97756001)(26826003)(14454004)(66066001)(33716001)(26005)(336012)(186003)(70586007)(70206006)(446003)(86362001)(63350400001)(7736002)(356004)(2906002)(126002)(486006)(476003)(6116002)(46406003)(11346002)(25786009)(6246003)(23726003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4158;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4989c802-b7c4-46af-586c-08d742f188da
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR08MB4158;
NoDisclaimer: True
X-Forefront-PRVS: 0173C6D4D5
X-Microsoft-Antispam-Message-Info: e13/PfN04M1qXek5Imb2ShGU4YiwJKogdxuUMuwSYkhOSQx7K7ZOw7VUHq3Gu64CBJ/UiKQJeiEmOMU/f97cLBTZV906wDuRC9djd/MA2genBwam24WWdmXiNx2m3pwA7o9KJXkC0PlHaPqqXt9YhIz9J+rP0uVwP2yUTZpzHOzrzPW+W1eTU7bvXyH0EMjcxwU6mUcnlqJ+6UeVPmx1IxbNawmMGQRqCQHiLgYRt6821NOEs4zcQHS9byoJUkDSsG/L/8P3DnYIUXC3h3VzOUiRAMuhxMAL/yjGWd0W8V6JFMZHDgNrO5tTbDvv9EEE1hQUEpfbJ+anbIgbP7P1ooPJGUNrsbQ7P8U7tlRVzC/8uLo0oxw4vrC8fNXjVip5rH5e0q2WdAG/bCtoiDQvV/CRJtoEwScXORDIadZwXf0=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2019 02:22:35.8396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 548f2752-61ed-425d-00a5-08d742f18f94
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 09:48:11AM +0000, Brian Starkey wrote:
> Hi James,
>=20
> On Tue, Sep 24, 2019 at 02:13:27AM +0000, james qian wang (Arm Technology=
 China) wrote:
> >=20
> > Hi Brian:
> >=20
> > Since one monitor can support mutiple color-formats, this DT property
> > supply a way for user to select a specific one from this supported
> > color-formats.
>=20
> Modifying DT is a _really_ user-unfriendly way of specifying
> preferences. If we want a user to be able to pick a preferred format,
> then it should probably be via the atomic API as Ville mentioned.
>

Hi Brian:

Agree, a drm UPAI might be the best & right way for this.

I can raise a new thread/topic to discuss the "HOW TO", maybe after the
Chinese national day.

LAST:
what do you think about this patch:
- Just drop it, waiting for the new uapi
- or keep it, and replace it once new uapi is ready.

Thanks
James

> Cheers,
> -Brian
