Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DD0C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0D422CB8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="vd59aFEe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="m2RhJXIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfGZNUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:20:09 -0400
Received: from mail-eopbgr140072.outbound.protection.outlook.com ([40.107.14.72]:28029
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfGZNUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRHDjP4TwohRU5NoYHalwfWooDhIrfFUTY/STQuX8Jc=;
 b=vd59aFEeC79q/GcBlFCAnJlr1QA2l4xycbWr4wMArbyFhkapV6Bj9TQvzhevcSVG1+OanagUl6gFVG/xldEV9mh+5LDqbbXtb5u8pYzPcPus4wY0MNxq/str5Py/KoC5dYAtJXYHRRAc5yqfQ+KN2NSjC481xtQeZTfESopJDcI=
Received: from VE1PR08CA0013.eurprd08.prod.outlook.com (2603:10a6:803:104::26)
 by VI1PR0801MB1853.eurprd08.prod.outlook.com (2603:10a6:800:5a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.10; Fri, 26 Jul
 2019 13:20:00 +0000
Received: from DB5EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::205) by VE1PR08CA0013.outlook.office365.com
 (2603:10a6:803:104::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.14 via Frontend
 Transport; Fri, 26 Jul 2019 13:20:00 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT020.mail.protection.outlook.com (10.152.20.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18 via Frontend Transport; Fri, 26 Jul 2019 13:19:58 +0000
Received: ("Tessian outbound 578a71fe5eaa:v26"); Fri, 26 Jul 2019 13:19:58 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 08a6699b9bb97d37
X-CR-MTA-TID: 64aa7808
Received: from 0047972d8848.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C4B5526B-A765-4FA5-A726-B6C882F7E659.1;
        Fri, 26 Jul 2019 13:19:53 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2054.outbound.protection.outlook.com [104.47.0.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0047972d8848.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 26 Jul 2019 13:19:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tz3Ym/M9PoRdz5t53I0ZXWY3CiBzG9+jcpa9eLt4Zq/55QU1vX+2appxJcxXHsvd7nni4Q3lMLp3oQyaWNUt9cOZfjNjIkbh92uPPXqIh5XovHiudvpGJTDalIE32a3E6OaEWEo5+TP1IbVzd5jACVD38Hos5Q/rIOU+LYFe/pF9+Kgr/dQ6hpSB1uuRNc1xVEJCJrw3GkgfuxDn/O5GPc+w73drAdcQCq8aTdeAU9r2tw3GLp2zVrYPNuE/y9bmcBmSY0xdSxunLXQb7pRC5948FA9DmwWGZKyj3amWhNwngxV+EUp9YxMoAQLvD11Rzh6w/NqTU3kZ64Sriz/+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBpO9NZx53Fv74lGLfqGEQF6VNYPDeSTdNywxa7PAjA=;
 b=I+sUNkjITEb5cVAyQSZXD4Jz64+OGSGjNb6yjn2acoqDuDVkWVnk6fG7F/JpFY6i2Njb+QYDhp6iRW3QTlhDwU4i+wi0tORZjGXWJp08oPryxLT6zGMG2eQg5C0SfgWfQ/mpk0QXLO9EnYm3Zve33S/WKBOcOqiflQ+uU6wbcX1FIarOPRadpipwAMtv38jUQi5vjitfh7n0I7+S54cU0BgUXnyY/8votbhln0macLvwk4pZ7qpm6pTN2NVFyrdFRgvLBmWY/LwhjL2Wj5oAx7UJV3S405n1pg8QpDXhBPpuj3l6d1Dm0IC/aY7BBVQyGXLnolsH4696dJZJrtfgjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBpO9NZx53Fv74lGLfqGEQF6VNYPDeSTdNywxa7PAjA=;
 b=m2RhJXItYAJ4/4suXdIK03AL2G9hpGU7uGArG1fWkIy//yjMIu+gMFnw9lr2GhcqyMprUpijeABr1VEfe0tu/2PHavQBWZi4O3KTxSvBPF53kadS0HEjG8IsovGSrt/rKsE79bNqHF+tNFzTVvsFFzTDl30+WKxxw6vLclniZgs=
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com (10.172.218.15) by
 AM4PR0802MB2308.eurprd08.prod.outlook.com (10.172.219.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Fri, 26 Jul 2019 13:19:51 +0000
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::547b:d806:40d0:50fc]) by AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::547b:d806:40d0:50fc%5]) with mapi id 15.20.2094.013; Fri, 26 Jul 2019
 13:19:51 +0000
From:   James Clark <James.Clark@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: [PATCH 0/1] perf tools: Add PMU event JSON files for ARM Cortex-A76
 and, Neoverse N1.
Thread-Topic: [PATCH 0/1] perf tools: Add PMU event JSON files for ARM
 Cortex-A76 and, Neoverse N1.
Thread-Index: AQHVQ7TOLGfepB9AX0OMLMFAtrLfvA==
Date:   Fri, 26 Jul 2019 13:19:51 +0000
Message-ID: <4ae020be-180e-4cb6-4b84-a2d519b466ef@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.40]
x-clientproxiedby: LO2P265CA0068.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::32) To AM4PR0802MB2242.eurprd08.prod.outlook.com
 (2603:10a6:200:5f::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: ff89b4d1-cbff-421c-1b03-08d711cbf54f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR0802MB2308;
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2308:|VI1PR0801MB1853:
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1853A84697FD3EFF3B7DE001E2C00@VI1PR0801MB1853.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 01106E96F6
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(189003)(199004)(316002)(486006)(25786009)(66446008)(2906002)(6512007)(53936002)(2351001)(71190400001)(99286004)(476003)(6506007)(8936002)(71200400001)(3846002)(81166006)(6436002)(36756003)(31686004)(2616005)(52116002)(5640700003)(2501003)(386003)(256004)(6116002)(186003)(54906003)(81156014)(478600001)(68736007)(66556008)(7736002)(66946007)(6916009)(4326008)(44832011)(14454004)(558084003)(64756008)(66476007)(102836004)(8676002)(6486002)(66066001)(86362001)(305945005)(31696002)(5660300002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2308;H:AM4PR0802MB2242.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 5qebJpn6nIVW0gCRc5z3V9skeNPXkUBPXdl6GAfQqpLhl4hT9pJvmNbt7+4T9hocnIUKfprFIazAQKaGC0/AfBJyMZcvcIQ+YqeDfY+zk00bD/WCyA7ZBt7k3dP/maey50bZXUwszEm9AS80SdcCOvDLrrtboj9iv5o7yErp2384lIF1XUWnMNQlvH51SWw9n0tYGUe/qDGvnUerc7lJElGYR3r2KkqEHN+hRgKIao8E3VDvy+FUzDJVRLAvQM7lYTDaoOvW69D6XFQ5WTaKxAxSExr8iKH4lPM5LM2LEHCt6fDMyqhql8WCWNFJN9gTPMl6RA0uCdFGCakou7XLjWyxdOrJkHXAOWIPR8VkCwx/cveieQ/Q97ckTgDuXJIdU/9TZCgqg0zN3/mVizlbTYXaNNPpJSMayAk31VIvXwk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83D3AC53F68B26438FB169720BCBCF41@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2308
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(39860400002)(2980300002)(40434004)(189003)(199004)(8676002)(186003)(81166006)(8936002)(36756003)(436003)(476003)(81156014)(2906002)(486006)(6486002)(25786009)(14444005)(6916009)(5660300002)(5024004)(2616005)(63350400001)(31686004)(31696002)(70586007)(126002)(47776003)(2501003)(450100002)(63370400001)(50466002)(22756006)(2486003)(99286004)(23676004)(356004)(4744005)(3846002)(316002)(336012)(386003)(6506007)(2351001)(6512007)(478600001)(6116002)(5640700003)(54906003)(66066001)(102836004)(7736002)(305945005)(86362001)(70206006)(76130400001)(26005)(26826003)(14454004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1853;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6debbc56-3dd2-478b-5464-08d711cbf0f1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0801MB1853;
X-Forefront-PRVS: 01106E96F6
X-Microsoft-Antispam-Message-Info: h0o43paqMONWrTbyQgORMPmXUfpW57SgTqHddXbM1Oo+N936+EvLV8Oai4PwXyeGhDJ5YajKkfBEx0xdVreIiAiEV+AeAbIdd+C1OPZjWIqD/9QVBkt1XVXPQmg5VEUkgKH7XZszPNf1zigBL67Uf0LFYtyIXWxLj3QhPD//IJGEw3Q6BB+0q840LPB30aMDev3j+CydkVlgSLKzxVdF5OR7P1wSh8Yh2k4jGupOlXYQ70hS7P4Rnn4rkCjWzPGBqQgm43PFkDzZvY+e7o+fQ2TS1g9fLgrZ66WZJjvKbdfAF39AnmeYo+jhpbELhiApRCBIDAAsiJooV9FxYkCVIEGHf3MiN6iAxQ3oP1GbQVTf9rWcXNQRG54+HK/uQ2s8cEAo6+upEWdDGRSDGBR0zyp2ToGiQWA8qaXxU+oh7E4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2019 13:19:58.7139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff89b4d1-cbff-421c-1b03-08d711cbf54f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkknbSBhIGRldmVsb3BlciBhdCBBUk0gYW5kIEknbSBuZXcgdG8gdXBzdHJlYW1pbmcg
aGVyZS4gSSdkIGxpa2UgdG8gc3VibWl0IHRoaXMgcGF0Y2ggZm9yDQpldmVudCBjb3VudGVycyBm
b3IgdHdvIG5ldyBBUk0gQ1BVcy4NCg0KQXQgc29tZSBwb2ludCBpbiB0aGUgZnV0dXJlIEkgd2ls
bCBhbHNvIGNvbnRpbnVlIHdvcmsgYXJvdW5kIGFybS1zcGUuYyB0byBpbXByb3ZlIFNQRSBzdXBw
b3J0Lg0KDQoNClRoYW5rcw0KSmFtZXMNCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBv
ZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5
IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVu
dCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xv
c2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBv
c2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5r
IHlvdS4NCg==
