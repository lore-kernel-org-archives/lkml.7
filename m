Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42F3C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757A62089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="pF91LELk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="TMg0Z84q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbfJNN2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:28:10 -0400
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:21826
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727409AbfJNN2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xjEQpP7qkRX4l7Ac6yVPfNzUHYRkRelSI8UURl1XVI=;
 b=pF91LELkSQLcYp3Ua3FcXUrvOhqNvbb3XOOGvoVj5ddm+lga/zINX/NPZpDGlcF3p6QPAgHTvyFLsU+dLRs1sgQTrO5s8F5y+ld5icBx4fy+KLdBm4FTVD/0NDNyjdMyywnyB2RdELxiaHWHLRE5Cs0OnIxyBGgzjm9Gmt493ZM=
Received: from VE1PR08CA0024.eurprd08.prod.outlook.com (2603:10a6:803:104::37)
 by AM0PR08MB3556.eurprd08.prod.outlook.com (2603:10a6:208:e0::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Mon, 14 Oct
 2019 13:28:02 +0000
Received: from DB5EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by VE1PR08CA0024.outlook.office365.com
 (2603:10a6:803:104::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Mon, 14 Oct 2019 13:28:02 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT052.mail.protection.outlook.com (10.152.21.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 14 Oct 2019 13:28:01 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Mon, 14 Oct 2019 13:27:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 78eb1c9840084e96
X-CR-MTA-TID: 64aa7808
Received: from 035005ec2589.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.2.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EC8AF93E-2F34-4E37-9BCC-976687ECFEF3.1;
        Mon, 14 Oct 2019 13:27:51 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2059.outbound.protection.outlook.com [104.47.2.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 035005ec2589.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 14 Oct 2019 13:27:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBh0i/4lzjYKEjuz6o1qJDLspPw+mdvx9OAGOq6N53QaKYPF3l6nN1WGs62BKa/fKytFwkySFnCbN0uO3PgqjQ8eduy0xcuabrAbPkRoS/i9pNFN3ozbcECrTytF7zxEWRMnJts6z5kXwxGBgxqQ0pRnbqjHQUThsYEqgkyX98Zua49uaULk43ZPxCcuPBAsep8dvymPeHIZKQZOtL7946yaX/my3Kn0bj1Nh1kM9ZKRY05eYnDn+BJ1/lBrHl3MDO3BMcAPNX/ovHmJgROun5Kv9BBjIvyBbabEuuTPZXESbG0QlGMuadfG+2qe5mX7DEgXvz4CS043GOdRwgb4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MN/jI38hX2+MZ1m3286cpAN4Lzm2ef+3vj2zl50mIAI=;
 b=fQ9spIZgvK40qhTEktJFiZIVItdukAA5ng/euM6DT8TzPk24dbi53ra0NzZOjokTKLAsIS9lmysRWYovF8yWIDlkVERWvFZbT8vDQIIWpiQ4exOvXLZZ2uoEV5Yk5XqGixXYcmwNarqkNeWq7yj5NvOrF8LqW+lXxZoSyyHzHCB+PVmplqLUhvI2+ePNfPpetWDyPwygeaDlbOVEFJGXHl93dexH5x66FmixgqMO7p6BSWtG7HDfRG8AhSDjgHdnkXm3bwPuxl8NAt73ycgbfEP59epFKELx7rGCqFF3ROBWm1ZlM1SOiU8lTrqIPnHsnoDdEz49KnwcrOlu2mMzlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MN/jI38hX2+MZ1m3286cpAN4Lzm2ef+3vj2zl50mIAI=;
 b=TMg0Z84qFMZdUCn5Sx97V097iuGFn+JaOFADtlVsyFquOeYUMeZsrJCEqYHNO6uzS6aW25a69gJpdefCfmzmagO9GpFKrVEsZ67Rr+qRfkSwpNX43oRFxWzQKm7xdvfJ41+IqNpt2YQ4LA0ONYLqRXYLG8iyUxHG9ZefHmdZj6U=
Received: from AM6PR08MB3864.eurprd08.prod.outlook.com (20.178.91.92) by
 AM6PR08MB3782.eurprd08.prod.outlook.com (20.178.89.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Mon, 14 Oct 2019 13:27:49 +0000
Received: from AM6PR08MB3864.eurprd08.prod.outlook.com
 ([fe80::78a1:2cb8:7350:cdf7]) by AM6PR08MB3864.eurprd08.prod.outlook.com
 ([fe80::78a1:2cb8:7350:cdf7%6]) with mapi id 15.20.2347.023; Mon, 14 Oct 2019
 13:27:49 +0000
From:   =?utf-8?B?UmFwaGHDq2wgR2F1bHQ=?= <Raphael.Gault@arm.com>
To:     Julien Thierry <jthierry@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>,
        "raph.gault+kdev@gmail.com" <raph.gault+kdev@gmail.com>,
        Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [RFC v4 00/18] objtool: Add support for arm64
Thread-Topic: [RFC v4 00/18] objtool: Add support for arm64
Thread-Index: AQHVVC2b/DhmaSpNM0S/NRC6Tk3XdadaLQEAgABQ+YA=
Date:   Mon, 14 Oct 2019 13:27:49 +0000
Message-ID: <fe6866f0-9c94-a307-638e-07006c303719@arm.com>
References: <20190816122403.14994-1-raphael.gault@arm.com>
 <f4fd76e1-ae15-3796-77a3-102ccc1ee028@redhat.com>
In-Reply-To: <f4fd76e1-ae15-3796-77a3-102ccc1ee028@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::21) To AM6PR08MB3864.eurprd08.prod.outlook.com
 (2603:10a6:20b:8e::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Raphael.Gault@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.52]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 37785545-9409-497e-4810-08d750aa5604
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM6PR08MB3782:|AM6PR08MB3782:|AM0PR08MB3556:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3556AC8DA7DCF3C3DEAD7494ED900@AM0PR08MB3556.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 01901B3451
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(45074003)(199004)(189003)(186003)(110136005)(31696002)(4326008)(2906002)(54906003)(81166006)(25786009)(8676002)(256004)(14444005)(8936002)(4744005)(316002)(6246003)(5660300002)(2616005)(3846002)(6116002)(85202003)(6512007)(478600001)(486006)(446003)(11346002)(2501003)(476003)(81156014)(102836004)(229853002)(86362001)(305945005)(66476007)(66556008)(64756008)(14454004)(71200400001)(31686004)(26005)(6436002)(66446008)(6506007)(386003)(66946007)(53546011)(71190400001)(6486002)(85182001)(7736002)(36756003)(66066001)(76176011)(99286004)(2201001)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3782;H:AM6PR08MB3864.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: UPr0RjQuBdW8IYSLMf0K288ARYGRhnItY9RZIzoQxwKS2fwhITyiv6h3ziE/2/NB+LuV9RjatWf5Qt0nBgL5FTU4kaX6JW8WCQA9HkNYQJC5QMGHJM0XHZ5g15LwHGhA6ovhJY/+XwAW5t9uwjU7QhTQUqRglUK9F/+4hbf7FsYWcx8cEb01+cjr6HBsZfu/cUWCDD4smvOtZrIbdrx0IXE1pH6E6aGVHjf4pH89X7H5BJupax2jVa37p0XQJ3vd7sg3vdAEJ0ASRVsza2nlI15F32+Vc+/IQt+tfB6zcootu6r0q4hEiaJ5fffLX5z69cJ9KZ+Ulb7ud5eC81L39Rqdgrl/LYL9nlVICy4e/Al0b/rptTzIjeytFm+5eosBjR8SV8hqJXTLMO/WKXwLV09Xsc9rscah/Z3PeS641Q8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8881E9EAE3B87041B5A6E6F1B4E4F7D7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3782
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Raphael.Gault@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(40434004)(199004)(45074003)(189003)(99286004)(110136005)(336012)(76176011)(436003)(81156014)(81166006)(31686004)(2486003)(76130400001)(70586007)(4326008)(6506007)(386003)(70206006)(26005)(102836004)(53546011)(186003)(25786009)(8676002)(316002)(5024004)(85202003)(23676004)(50466002)(8936002)(36756003)(14444005)(478600001)(26826003)(14454004)(54906003)(6512007)(6116002)(3846002)(2201001)(7736002)(2501003)(6246003)(305945005)(2906002)(22756006)(126002)(229853002)(486006)(85182001)(356004)(5660300002)(2616005)(446003)(476003)(63350400001)(86362001)(11346002)(47776003)(66066001)(31696002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3556;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: ff3d09b4-c471-461e-898d-08d750aa4ed3
X-Forefront-PRVS: 01901B3451
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rR/X+qyLdkJmgyxprQhoRiOEqYj1XrpLNMPlPa6xWkNhf9pQz1AAa9y+X1T2NIzqjcDprSCHen0oexLdGGXtrcpGLlp7wdWfZ6r9jfXx1teVhjPR5jtA2nAMcLFgL+7xoNr14/dOHd61xKkhPmRtH+vJdOYSi4YBVzh/PynMEnSrUJ1sFHrjAvfzQvvftcS3fW0TsZuC0vYrpSLF/f1T5BTcExcctn6gFNPsMgJUR/rSAIHWoAxPSTDKicdxr/Yo3g3nnncwTj2+/VLgeFwU4bFF0ScRD/f5lfxZZJreuuHP9QEwIk0sSs17s6fjvNe8or8s1MRJs5+1nYI8Gyq+T3JD2w/vI1v5v4g9oAoUdvzsl/6knbaEbxpWeiefgaNlbch/CSrHwtULutFX3T0o9YXSRRZtEUJwiGwauvsIevY=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2019 13:28:01.3507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37785545-9409-497e-4810-08d750aa5604
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3556
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSnVsaWVuLA0KDQpPbiAxMC8xNC8xOSA5OjM3IEFNLCBKdWxpZW4gVGhpZXJyeSB3cm90ZToN
Cj4gT24gOC8xNi8xOSAxOjIzIFBNLCBSYXBoYWVsIEdhdWx0IHdyb3RlOg0KPj4gSGksDQo+Pg0K
Pg0KPiBbLi4uXQ0KPg0KPj4gQXMgb2Ygbm93LCBvYmp0b29sIG9ubHkgc3VwcG9ydHMgdGhlIHg4
Nl82NCBhcmNoaXRlY3R1cmUgYnV0IHRoZQ0KPj4gZ3JvdW5kd29yayBoYXMgYWxyZWFkeSBiZWVu
IGRvbmUgaW4gb3JkZXIgdG8gYWRkIHN1cHBvcnQgZm9yIG90aGVyDQo+PiBhcmNoaXRlY3R1cmVz
IHdpdGhvdXQgdG9vIG11Y2ggZWZmb3J0Lg0KPj4NCj4+IFRoaXMgc2VyaWVzIG9mIHBhdGNoZXMg
YWRkcyBzdXBwb3J0IGZvciB0aGUgYXJtNjQgYXJjaGl0ZWN0dXJlDQo+PiBiYXNlZCBvbiB0aGUg
QXJtdjguNSBBcmNoaXRlY3R1cmUgUmVmZXJlbmNlIE1hbnVhbC4NCj4+DQo+DQo+IEkgd2FzIHdv
bmRlcmluZyBhYm91dCB0aGUgY3VycmVudCBzdGF0dXMgb2YgdGhlc2UgcGF0Y2hlcy4gSXMgYW55
b25lDQo+IGFjdGl2ZWx5IHdvcmtpbmcgb24gdGhpcz8NCj4NCj4gSWYgbm90LCBJIGNhbiBwaWNr
IHRoYXQgdXAgYW5kIHRyeSB0byBtYWtlIHRoaXMgZ28gZm9yd2FyZC4NCj4NCg0KSSBhbSBub3Qg
d29ya2luZyBvbiB0aGVzZSBwYXRjaGVzIGF0IHRoZSBtb21lbnQgYW5kIEkgZG9uJ3Qga25vdyB3
aGVuIEkNCmNhbiBnZXQgYmFjayBhdCBpdCBzbyBhcyBmYXIgYXMgSSBhbSBjb25jZXJuZWQgeW91
IGNhbiBwaWNrIGl0IHVwIGJ1dA0KbWF5YmUgd2FpdCBhIGJpdCB0byBzZWUgaWYgc29tZW9uZSBl
bHNlIGhhcyBhbiBpbnRlcmVzdCBpbiB0aGlzLg0KDQpUaGFua3MsDQpJTVBPUlRBTlQgTk9USUNF
OiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBjb25m
aWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBp
bnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBh
bmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2Ug
aXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBh
bnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
