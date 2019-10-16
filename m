Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDBCFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068AF20650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DU5vQSyM";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DU5vQSyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392260AbfJPKOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:14:42 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:55874
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727235AbfJPKOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KFNSm98Rrp9kw1XgvlA4IKw/0rjvZeetA6DDh2GHmU=;
 b=DU5vQSyM7IZWt24pRgQZKjH/7fk9IESk3Ige599XVk7adPrVqAOqmTdmTroZedJ5k677ExgfsJ+O9dhOt6WMoafgVuP+Q1mveSarwRS56rT2AIoMbstQ4vTsgB9w8HNU3kawHfwrmPg/H+n8VsvgO6oenJkhJrFCSwjllWuRnZE=
Received: from VI1PR08CA0254.eurprd08.prod.outlook.com (2603:10a6:803:dc::27)
 by DB7PR08MB3372.eurprd08.prod.outlook.com (2603:10a6:10:4f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17; Wed, 16 Oct
 2019 10:12:54 +0000
Received: from AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by VI1PR08CA0254.outlook.office365.com
 (2603:10a6:803:dc::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 16 Oct 2019 10:12:54 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT046.mail.protection.outlook.com (10.152.16.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 16 Oct 2019 10:12:52 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Wed, 16 Oct 2019 10:12:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3b2406841a3ebc8d
X-CR-MTA-TID: 64aa7808
Received: from 5edff9ff4dac.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2172D6B4-84D4-4126-8CFB-EE17093DBF68.1;
        Wed, 16 Oct 2019 10:12:46 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2051.outbound.protection.outlook.com [104.47.9.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5edff9ff4dac.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 16 Oct 2019 10:12:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzBOlo+2cY+RHES4V1ChQ7eq6sRyq55z99qHUc3dIruhwjqnN0od5NwHv0IqQrR1nZkle+EeW+9ysSg9shWtp1H5XzlQgvSlR7zpQzNQB5cTyixcm/hgNypCgWa36c/3rzVIVKmyISCx6E1o2M4bpfAADKandmfXlxvsv/irQo19omJV6kMK6M/3hZzPL6u29rGRC6A94XA7JG+EJIdn/VanU1OwS6Ci6sPsDOCwtdo31/wos0Ri+syDhJ+ksethT2vLQE/Mne1a/+8vueKIKtWKusDEszPiVdQYTT5E2aRmLm+mo7SO2k6JjisyLOLG1VYOE86lPk24RzuHvCzecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KFNSm98Rrp9kw1XgvlA4IKw/0rjvZeetA6DDh2GHmU=;
 b=IECsnya534K8PzhPSxelgMNHu5/Ft323go5zqj7RBLfzWmivAlOUY9gJHD9Zfe6wjs8U1Mer1QswmhF5ISJVOGRkI/Uz9PoReGVAWrzH6Q3K72b2BDcClnLngk1MoxhpwNwr5QZ8nba7vZS6aJlHuDPbIZwiKzVxawg5yRiEpPwQWr91AAjoTIShjmrndBhUDO1/Q97efhREDlpSvMNUex1HlpeksJjRd5mAeQp4qD/7PxeQ6TriCkHibGkbg8i9ytvlMrmV5xQ1LMAJdFMxoR+yL8YNTUk8Ny0YfF2v79eS+DEefYRfZIRFYoJcEk/PvrWdHZGo7oIlGbfHMITAKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KFNSm98Rrp9kw1XgvlA4IKw/0rjvZeetA6DDh2GHmU=;
 b=DU5vQSyM7IZWt24pRgQZKjH/7fk9IESk3Ige599XVk7adPrVqAOqmTdmTroZedJ5k677ExgfsJ+O9dhOt6WMoafgVuP+Q1mveSarwRS56rT2AIoMbstQ4vTsgB9w8HNU3kawHfwrmPg/H+n8VsvgO6oenJkhJrFCSwjllWuRnZE=
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com (10.172.218.15) by
 AM4PR0802MB2337.eurprd08.prod.outlook.com (10.172.218.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Wed, 16 Oct 2019 10:12:44 +0000
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::9c3e:dc5:e056:9f89]) by AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::9c3e:dc5:e056:9f89%12]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 10:12:43 +0000
From:   James Clark <James.Clark@arm.com>
To:     Tan Xiaojun <tanxiaojun@huawei.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>,
        "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
        "brueckner@linux.ibm.com" <brueckner@linux.ibm.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Kim Phillips <Kim.Phillips@amd.com>
CC:     "gengdongjiu@huawei.com" <gengdongjiu@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "liwei391@huawei.com" <liwei391@huawei.com>,
        "huawei.libin@huawei.com" <huawei.libin@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Al Grant <Al.Grant@arm.com>, nd <nd@arm.com>
Subject: Re: [RFC PATCH 2/3] perf tools: Add support for "report" for some spe
 events
Thread-Topic: [RFC PATCH 2/3] perf tools: Add support for "report" for some
 spe events
Thread-Index: AQHVSRBYwzSrk8h9+0+uZFn2bs0fiabxxmkAgACaVACAWJIigIAFtiSAgAHjIoCAAAW6gIAACz6AgArlPgA=
Date:   Wed, 16 Oct 2019 10:12:43 +0000
Message-ID: <58bed363-41ee-e425-a36e-e3c69d1a4e90@arm.com>
References: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
 <1564738813-10944-3-git-send-email-tanxiaojun@huawei.com>
 <0ac06995-273c-034d-52a3-921ea0337be2@arm.com>
 <016c1ce8-7220-75a2-43fa-0efe150f897c@huawei.com>
 <805660ca-1cf3-4c7f-3aa2-61fed59afa8b@arm.com>
 <637836d6-c884-1a55-7730-eeb45b590d39@huawei.com>
 <b7e5ca2d-8c6c-8ab8-637e-a9aaebaf62a5@arm.com>
 <2b1fc8c7-c0b9-f4b9-a24f-444bc22129af@huawei.com>
 <335fedb8-128c-7d34-c5e8-15cd660fe12e@huawei.com>
In-Reply-To: <335fedb8-128c-7d34-c5e8-15cd660fe12e@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.96.140]
x-clientproxiedby: AM4PR07CA0029.eurprd07.prod.outlook.com
 (2603:10a6:205:1::42) To AM4PR0802MB2242.eurprd08.prod.outlook.com
 (2603:10a6:200:5f::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: f0a3200e-5324-4462-8ffe-08d7522167b7
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2337:|AM4PR0802MB2337:|DB7PR08MB3372:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB33721BE5B503908D462DBEFEE2920@DB7PR08MB3372.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 0192E812EC
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(199004)(189003)(76176011)(36756003)(71190400001)(66946007)(71200400001)(66556008)(186003)(66476007)(110136005)(54906003)(316002)(2501003)(66446008)(64756008)(6506007)(102836004)(26005)(7736002)(52116002)(14454004)(6246003)(386003)(99286004)(256004)(66066001)(6512007)(81156014)(8936002)(7416002)(478600001)(8676002)(31696002)(305945005)(81166006)(25786009)(6116002)(3846002)(44832011)(2616005)(476003)(31686004)(11346002)(5660300002)(2906002)(4326008)(229853002)(446003)(486006)(2201001)(6486002)(86362001)(6436002)(21314003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2337;H:AM4PR0802MB2242.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: EKTnx5zdkSZsFiVc1H9iWj8Yc9qr84WMBHTayEMib2905YEpXDJiNxZOTbffYA7/Ojjxs4naKz5NnqqPu3QvVVNQ6D5UuekM3pXIzoc2+k6oLaHEoTLoVLl7LIosTIg81ses7iH5uJZPQmF4gEPe3P+7qiwcFinSVtvNVypw7sHvzH1LrwEKX8ejueOxpQV0x/2c543YTQHuSuhhxDpQY+xawIMR/z1xrwcCI2LiZd0+Yg3cnnvDv+xsM98LQPTWK/lWhuz+VStam6ILfPq1pThtZRY+oQH2jAAj0SX9rX0IdvN8iQF3uULCCozaoC/4JtTyixmd5WIDPo5B6qQSy556p24A75Jvdn4CoDtcq90RCy+2tT/fjVKbl1J9JCNk3uGHBEU7QdENxfvNao6Afm7VPaTSOrE2Q+uvFhO0H+8=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <6D50A32F91C7D94A9752A1E7B029CD57@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2337
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(126002)(2616005)(386003)(5660300002)(26005)(476003)(63350400001)(36906005)(11346002)(47776003)(446003)(336012)(6246003)(450100002)(14454004)(6506007)(26826003)(486006)(6116002)(110136005)(186003)(22756006)(54906003)(316002)(3846002)(70206006)(70586007)(8936002)(8676002)(8746002)(81156014)(81166006)(76130400001)(31696002)(36756003)(356004)(99286004)(4326008)(6512007)(31686004)(50466002)(6486002)(2201001)(86362001)(7736002)(229853002)(66066001)(305945005)(23746002)(25786009)(2906002)(478600001)(76176011)(2501003)(102836004)(21314003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3372;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4f4c34fd-4fa1-4b35-ae40-08d752216274
NoDisclaimer: True
X-Forefront-PRVS: 0192E812EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2am5IklEPjvtKtdSieJMgMkKvYu22k9pMq9wuv8BkM76cnrS9a3As5DUtNSk2WbJ2zXxiF8yhHkiEm0XpRTFXnT/aKJHhgpOBJGfbMTBVf4J3/aIrZTzDHhvlUq0W7AZkGdFKr78Qn6xZvAPeSHDPXAqrquWdtqgJSsfeTiLFZHx67ToZIslJd502FIejZt6nP5STXtW2lgZC3wYo2n4XbDTZSgz8KzRuS0WauHSAcD41X3BMie7Rj88IgxxvW3GeylAaeCROdocS/pH6h1YE2KKCJLjbY/6QvAIPF0/WTeZMImGuEMPiIET9Zg84tWTPPThiQ3N7wcOVW00SozsEc0FtFNFoss0TjGbk55BzTnvs8mYr+jN8z2wpQgejzfR+QvaFqlOjNcTBRVbVjuhhBdVsGAH6od39NWc+6qkrxM=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2019 10:12:52.2775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a3200e-5324-4462-8ffe-08d7522167b7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3372
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaojun,

>>
>> What do you mean when the user specifies "event:pp", if the SPE is avail=
able, configure and record the spe data directly via the perf event open sy=
scall?
>> (perf.data itself is the same as using -e arm_spe_0//xxx?)
>=20
> I mean, for the perf record, if the user does not add ":pp" to these even=
ts, the original process is taken, and if ":pp" is added, the spe process i=
s taken.
>=20

Yes we think this is the best way to do it considering that SPE has been im=
plemented as a separate PMU and it will be very difficult to do it in the K=
ernel when the precise_ip attribute is set.

I think doing everything in userspace is easiest. This will at least mean t=
hat users of Perf don't have to be aware of the details of SPE to get preci=
se sample data.

So if the user specifies "event:p" when SPE is available, the SPE PMU is au=
tomatically configured data is recorded. If the user also specifies -e arm_=
spe_0//xxx and wants to do some manual configuration, then that could overr=
ide the automatic configuration.


James

