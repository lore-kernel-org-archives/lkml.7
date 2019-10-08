Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAB6ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5A920867
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="4OI8xI+C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="5y16yN4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfJHBMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 21:12:36 -0400
Received: from mail-eopbgr10072.outbound.protection.outlook.com ([40.107.1.72]:23086
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729212AbfJHBMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 21:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1KtVEPnAF8CPcSIEqZyMNBK0j289yLKVGvVBXMEJdI=;
 b=4OI8xI+CE/cCAW6CKLB+ocmyhk5EAW7AZySyjiaN+UBjBpCaDCmW/PovppkXOjQFGb4ixR7ZDDmALXjLeai8hQA63TAfxzZOluLV/8no4QSmo+nJYc5u60rmasnDGLUcoRSjMHIqm08Yl1a8unl3dDtJMJK2vvZ8IQKRVmC9DcM=
Received: from AM4PR08CA0043.eurprd08.prod.outlook.com (2603:10a6:205:2::14)
 by DB8PR08MB5514.eurprd08.prod.outlook.com (2603:10a6:10:fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24; Tue, 8 Oct
 2019 01:12:24 +0000
Received: from VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by AM4PR08CA0043.outlook.office365.com
 (2603:10a6:205:2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Tue, 8 Oct 2019 01:12:23 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT025.mail.protection.outlook.com (10.152.18.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 8 Oct 2019 01:12:21 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Tue, 08 Oct 2019 01:12:14 +0000
X-CR-MTA-TID: 64aa7808
Received: from 3540e2e27d1d.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.1.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C98FBF4A-DF32-4533-A4CA-FDB2DB63A7ED.1;
        Tue, 08 Oct 2019 01:12:09 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2056.outbound.protection.outlook.com [104.47.1.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3540e2e27d1d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 08 Oct 2019 01:12:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWa2KhhqBYoI5BwXEFugH5b330ekeXNWOXxUXFFxpnsgFHfRi+l46DfdPdB70CYNQnLZGX7Vo/9WfJ6aPPMRzUlnpZBDpAae+OdXVn8eCyRJS1KS/x0fxVqPQEX/XETo0UtZeMwfwhkyaQMbq1gwzgh3hJxxQ68h9vdcCMI27xZOyRWEwp4hXFYV46/gk9/tzrcobEG2c3a5uQCgVHOquK5xzRs31ecDpGbc1tYlsXI6vQP809npLyv8xbKxf8qF0eMC+zYM3+f6b6f8cXytcuPK0fu9yzBd1JUEwM8yWXi6nVR1B2HwHL93HwbzYlxgSDQKvyIXHa3NGCEQsZEnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcV5EiDK+zcTCtnFogim9/sz9OF/vUUGmE+ZfS9484A=;
 b=B2kIEcNaXilyGlQC/yEcE3dEGMgZXii+V/mLa2jIB8O1/uafirKgTsFi4SGCQIl2PS8XdOLZ1r1Y2TaBhP/QTk9YzGWGaPhlDaHnSZ3p41HesnSnWTBzLR2D+zl0j/a8/jLbAa4HFtU+UnO3n561puCvCU0bGRKPmrNszfzrVrCBPu/5maZfQ1m9qUcyhCHGmC5urBv5z4MHV2l3wHC/NSUb934zogUlEfwzTIMhC/Xz10ca//moSEnkXakTvPEBgO15b2xnN5LQkm0cprMypjOKOFC5VS/DUNoWZCtTzuVkI+TdZ6Ku7oUFElLBQZAW+jV4KGkNVfkkv8UB3qz6Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcV5EiDK+zcTCtnFogim9/sz9OF/vUUGmE+ZfS9484A=;
 b=5y16yN4/GbgqRiLKZVEqgoogx/XvFh5s4HZ4OXu+tII041PoJJGx2ggD6xLOZLb1f73n812eT0ujydhsIObqHiLdIN/JjGsAbOUavipNf+XCrpMGj3t5Ri600zTjFSV/mlSf3ub3o+0J1QVyU0lavwuA3P9+aB2q0AueDlx5BZE=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB3833.eurprd08.prod.outlook.com (20.178.46.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 01:12:05 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::f9f9:ad51:6636:42f0]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::f9f9:ad51:6636:42f0%6]) with mapi id 15.20.2327.023; Tue, 8 Oct 2019
 01:12:05 +0000
From:   "Justin He (Arm Technology China)" <Justin.He@arm.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        James Morse <James.Morse@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "hejianet@gmail.com" <hejianet@gmail.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>
Subject: RE: [PATCH v10 1/3] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Thread-Topic: [PATCH v10 1/3] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Thread-Index: AQHVdzKEwsCE/iaM30SJQYun0G7iCadFwGmAgAAGtgCACjS0wA==
Date:   Tue, 8 Oct 2019 01:12:05 +0000
Message-ID: <DB7PR08MB30824EFD975EE9BACAC7FD52F79A0@DB7PR08MB3082.eurprd08.prod.outlook.com>
References: <20190930015740.84362-1-justin.he@arm.com>
        <20190930015740.84362-2-justin.he@arm.com>
        <20191001125446.gknoofnm7az4wqf5@willie-the-truck>
 <20191001141848.762296bd@why>
In-Reply-To: <20191001141848.762296bd@why>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 55fdb1af-cf51-4ea9-b52d-4913c455a40e.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: b19835be-1f1d-4b7d-50c3-08d74b8c9208
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: DB7PR08MB3833:|DB7PR08MB3833:|DB8PR08MB5514:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB55149FCE4951A8904CE79BFDF79A0@DB8PR08MB5514.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 01842C458A
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(13464003)(199004)(189003)(3846002)(476003)(229853002)(486006)(5660300002)(7736002)(74316002)(7416002)(6506007)(6246003)(53546011)(2906002)(305945005)(52536014)(14444005)(256004)(446003)(25786009)(4326008)(11346002)(6116002)(66066001)(66446008)(26005)(64756008)(66556008)(66476007)(76116006)(186003)(6436002)(99286004)(33656002)(76176011)(8676002)(54906003)(81166006)(316002)(7696005)(9686003)(8936002)(66946007)(86362001)(71190400001)(81156014)(71200400001)(14454004)(102836004)(110136005)(55236004)(55016002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3833;H:DB7PR08MB3082.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: BZJu/lwb0M0cstfVvr678UfGJ3Die4b5k+58dKoPCy6/+J7MgIrCKoUEsg9C9HChyxswVhK1CE3Q476jLK/XzSSkogMhhm6uCpPjq94OYVebNRLlIrdzsj1BywK83IXUXc8dD1EBreuVSFRlG0nVO+ue8ouVSGFBsNluaJau+xSl07C0PEjQOn/ewx+HcGFcDF27VZGxhnT2/O1ihI9daJKV6XdbE7qtq5nq9uf+8n4NVAT5WKviaCCJ9GYSUOYE8TgJFH6FXeIgLGV8zrygInAiHUFPxVSpp4kGq7WQtU0NxxBIjXTioYVRYTVhLscBls3BllTSDgCPQNCPw9xQwiyvIEwGOgObXr/2zhqYdSBHAx8ZRufF1mKVXDtyPi6kSs+7zll2SCKZSjd7NSUTdzrxwfRHt6SsEqjkiQWoEhE=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3833
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(13464003)(40434004)(7696005)(33656002)(446003)(5024004)(14444005)(76130400001)(26005)(336012)(74316002)(11346002)(476003)(436003)(4326008)(76176011)(63350400001)(99286004)(486006)(48336001)(229853002)(86362001)(7736002)(305945005)(126002)(356004)(47136003)(6116002)(102836004)(6246003)(3846002)(53546011)(6506007)(2906002)(186003)(52536014)(22756006)(14454004)(9686003)(110136005)(54906003)(36906005)(23696002)(8676002)(316002)(26826003)(5660300002)(50466002)(25786009)(66066001)(70586007)(47776003)(8936002)(55016002)(70206006)(81166006)(478600001)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5514;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7d94ae5e-259f-400c-d4b4-08d74b8c885e
X-Forefront-PRVS: 01842C458A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfwQgwc7uMqRq9ixBLQCH3+eow/HmgXngG0Nh7RbUuyo+89xlPeqRz2tj5nz56NTZWU/Y2ep0r8kAR3hYbWE8GN+D8QT88Ma1nRW0fpM0V/ThXoc4b0fazt3DAANhgHB3t71LwPYHkEwIkNWagFudEHI8wtFSVfJN2dT3p7C6LFidgmYgzchAHEhNVCZVei505EEqW9J0q08tERHY+3ZwdBRrDcbM9WCuA8IM+/HK+Rcc4vmt3TtGf80bvyzmIlwjA5hhEDNfYbgH66WaE0kYzpn7tyu5GWoXKqb9zkVQYLV47nUfKb6BzqkelldxgpolEeTEfWgoSJ7dCFr/tDF7JvbHc+2h1TycXgVyfn99zb6B5ATnaMjxj73cfGDH8yaItefH/xRpepb38ydHy9xB5OZHfLMJe1dQ5KAlX95ngE=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 01:12:21.2726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b19835be-1f1d-4b7d-50c3-08d74b8c9208
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2lsbCBhbmQgTWFyYw0KU29ycnkgZm9yIHRoZSBsYXRlIHJlc3BvbnNlLCBqdXN0IGNhbWUg
YmFjayBmcm9tIGEgdmFjYXRpb24uDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz4NCj4gU2VudDogMjAxOcTqMTDUwjHI
1SAyMToxOQ0KPiBUbzogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4NCj4gQ2M6IEp1c3Rp
biBIZSAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpIDxKdXN0aW4uSGVAYXJtLmNvbT47IENhdGFsaW4N
Cj4gTWFyaW5hcyA8Q2F0YWxpbi5NYXJpbmFzQGFybS5jb20+OyBNYXJrIFJ1dGxhbmQNCj4gPE1h
cmsuUnV0bGFuZEBhcm0uY29tPjsgSmFtZXMgTW9yc2UgPEphbWVzLk1vcnNlQGFybS5jb20+Ow0K
PiBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz47IEtpcmlsbCBBLiBTaHV0ZW1v
dg0KPiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT47IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtbW1Aa3ZhY2sub3JnOyBQdW5pdCBBZ3Jhd2FsDQo+IDxwdW5pdGFncmF3YWxAZ21haWwuY29t
PjsgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+Ow0KPiBBbmRyZXcgTW9ydG9u
IDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgaGVqaWFuZXRAZ21haWwuY29tOyBLYWx5DQo+
IFhpbiAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpIDxLYWx5LlhpbkBhcm0uY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYxMCAxLzNdIGFybTY0OiBjcHVmZWF0dXJlOiBpbnRyb2R1Y2UgaGVscGVy
DQo+IGNwdV9oYXNfaHdfYWYoKQ0KPg0KPiBPbiBUdWUsIDEgT2N0IDIwMTkgMTM6NTQ6NDcgKzAx
MDANCj4gV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4gd3JvdGU6DQo+DQo+ID4gT24gTW9u
LCBTZXAgMzAsIDIwMTkgYXQgMDk6NTc6MzhBTSArMDgwMCwgSmlhIEhlIHdyb3RlOg0KPiA+ID4g
V2UgdW5jb25kaXRpb25hbGx5IHNldCB0aGUgSFdfQUZEQk0gY2FwYWJpbGl0eSBhbmQgb25seSBl
bmFibGUgaXQgb24NCj4gPiA+IENQVXMgd2hpY2ggcmVhbGx5IGhhdmUgdGhlIGZlYXR1cmUuIEJ1
dCBzb21ldGltZXMgd2UgbmVlZCB0byBrbm93DQo+ID4gPiB3aGV0aGVyIHRoaXMgY3B1IGhhcyB0
aGUgY2FwYWJpbGl0eSBvZiBIVyBBRi4gU28gZGVjb3VwbGUgQUYgZnJvbQ0KPiA+ID4gREJNIGJ5
IG5ldyBoZWxwZXIgY3B1X2hhc19od19hZigpLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IEppYSBIZSA8anVzdGluLmhlQGFybS5jb20+DQo+ID4gPiBTdWdnZXN0ZWQtYnk6IFN1enVraSBQ
b3Vsb3NlIDxTdXp1a2kuUG91bG9zZUBhcm0uY29tPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IENhdGFs
aW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBh
cmNoL2FybTY0L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmUuaCB8IDEwICsrKysrKysrKysNCj4gPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmUuaA0KPiBiL2FyY2gvYXJtNjQv
aW5jbHVkZS9hc20vY3B1ZmVhdHVyZS5oDQo+ID4gPiBpbmRleCA5Y2RlNWQyZTc2OGYuLjk0OWJj
N2M4NTAzMCAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vY3B1ZmVh
dHVyZS5oDQo+ID4gPiArKysgYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmUuaA0K
PiA+ID4gQEAgLTY1OSw2ICs2NTksMTYgQEAgc3RhdGljIGlubGluZSB1MzINCj4gaWRfYWE2NG1t
ZnIwX3BhcmFuZ2VfdG9fcGh5c19zaGlmdChpbnQgcGFyYW5nZSkNCj4gPiA+ICAgZGVmYXVsdDog
cmV0dXJuIENPTkZJR19BUk02NF9QQV9CSVRTOw0KPiA+ID4gICB9DQo+ID4gPiAgfQ0KPiA+ID4g
Kw0KPiA+ID4gKy8qIENoZWNrIHdoZXRoZXIgaGFyZHdhcmUgdXBkYXRlIG9mIHRoZSBBY2Nlc3Mg
ZmxhZyBpcyBzdXBwb3J0ZWQgKi8NCj4gPiA+ICtzdGF0aWMgaW5saW5lIGJvb2wgY3B1X2hhc19o
d19hZih2b2lkKQ0KPiA+ID4gK3sNCj4gPiA+ICsgaWYgKElTX0VOQUJMRUQoQ09ORklHX0FSTTY0
X0hXX0FGREJNKSkNCj4gPiA+ICsgICAgICAgICByZXR1cm4gcmVhZF9jcHVpZChJRF9BQTY0TU1G
UjFfRUwxKSAmIDB4ZjsNCj4gPg0KPiA+IDB4Zj8gSSB0aGluayB3ZSBzaG91bGQgaGF2ZSBhIG1h
c2sgaW4gc3lzcmVnLmggZm9yIHRoaXMgY29uc3RhbnQuDQo+DQo+IFdlIGRvbid0IGhhdmUgdGhl
IG1hc2ssIGJ1dCB3ZSBjZXJ0YWlubHkgaGF2ZSB0aGUgc2hpZnQuDQo+DQo+IEdFTk1BU0soSURf
QUE2NE1NRlIxX0hBREJTX1NISUZUICsgMywNCj4gSURfQUE2NE1NRlIxX0hBREJTX1NISUZUKSBp
cyBhIGJpdA0KPiBvZiBhIG1vdXRoZnVsIHRob3VnaC4gSWRlYWxseSwgd2UnZCBoYXZlIGEgaGVs
cGVyIGZvciB0aGF0Lg0KPg0KT2ssIEkgd2lsbCBpbXBsZW1lbnQgdGhlIGhlbHBlciBpZiB0aGVy
ZSBpc24ndCBzbyBmYXIuDQpBbmQgdGhlbiByZXBsYWNlIHRoZSAweGYgd2l0aCBpdC4NCg0KDQot
LQ0KQ2hlZXJzLA0KSnVzdGluIChKaWEgSGUpDQoNCg0KPiAgICAgICBNLg0KPiAtLQ0KPiBXaXRo
b3V0IGRldmlhdGlvbiBmcm9tIHRoZSBub3JtLCBwcm9ncmVzcyBpcyBub3QgcG9zc2libGUuDQpJ
TVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFj
aG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlv
dSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRl
ciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3Ro
ZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBp
bmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
