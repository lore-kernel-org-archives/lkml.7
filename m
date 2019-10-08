Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEEDC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C9921721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xYfWyLRr";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xYfWyLRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbfJHM7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:59:22 -0400
Received: from mail-eopbgr40051.outbound.protection.outlook.com ([40.107.4.51]:11438
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730249AbfJHM7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6u4qKpggkPIyD2GA5mTsaigoVsNPCTLznM8Tb5AWQY=;
 b=xYfWyLRrHp0/YtzcWjgvmm71URnUEQF51qCBgJS8TutQ+2+Rdewt03zl+TpzWQBMGcgRXYDevsw0RcAcgS54z3IUBAbS94KXrNDHfMSExhfhrDG59OFe9MQqFKkQqUi7iTBWUSWr4Px+hoObiHGAwGVZHHgq+zEAK2Yi6yWXk0g=
Received: from VI1PR0802CA0021.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::31) by DB8PR08MB5163.eurprd08.prod.outlook.com
 (2603:10a6:10:e8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24; Tue, 8 Oct
 2019 12:59:16 +0000
Received: from AM5EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by VI1PR0802CA0021.outlook.office365.com
 (2603:10a6:800:aa::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Tue, 8 Oct 2019 12:59:16 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT039.mail.protection.outlook.com (10.152.17.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 8 Oct 2019 12:59:13 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Tue, 08 Oct 2019 12:59:06 +0000
X-CR-MTA-TID: 64aa7808
Received: from 78f1fff96177.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D58797FD-35D3-40AF-94B1-614273992599.1;
        Tue, 08 Oct 2019 12:59:01 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2050.outbound.protection.outlook.com [104.47.5.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 78f1fff96177.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 08 Oct 2019 12:59:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO97on5tdwriPoAYGoQfgwen3wn75gfleQ5FCu/I3rKlt6dod8yctHE+UJiRadRzJTAYci5TOAma63SrSPWp3KOLDWt0/RMks72ccaxvGTtMoKPM8PfOYHkyzkdn9vbMaU4qKMFVXKfEom9vJNwT+oWN0tkWzqhCBaJ5cJRlF5G/+vqO3EuGurklFfDXWvekJ8kySFBvTy2n0Qajouh5hXbhm0/iGyLZvuopc8CMxK1A1qZvcmemr0tz576K5PYZlGFm9QK8hrZ64Nr0Uz47iYLe+62ddIgjSmOjMNLEPyVgkznZJDerLqq89tnOns4LN4T5hz1QDCM+fYBl4gWFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6u4qKpggkPIyD2GA5mTsaigoVsNPCTLznM8Tb5AWQY=;
 b=ClQvwdflHSU8nzE72FFLk2duRZmEPnPMU6jIuqpYCgU6WxhYxsSegGnym5wmRxXaEaD+VH6IwGP1eBJ9VO5wz50YJg9w3SEc6MVXbGxiVTcu2VbVyMiOQD+a+ALLIajcpX3GF5wfcyyH+1Ff60KXo7m4vVXYm4OAOu6r44cS2nf0P35MSSAbr2fp2FvqETz9Ycu4S5ucGUXizVJDqFnM7sMP00By3tfvXz5Lgbtv91f1V8AkQTXHAEKatr9IqWqUFZVxJJLt5jVxoVlQu5FvBAiYsK5oK+rkYcp6V1Zb+jOXGVIFHtI3w7dY8orppq2JFhtV/XLWv3aF6g/KAkDNvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6u4qKpggkPIyD2GA5mTsaigoVsNPCTLznM8Tb5AWQY=;
 b=xYfWyLRrHp0/YtzcWjgvmm71URnUEQF51qCBgJS8TutQ+2+Rdewt03zl+TpzWQBMGcgRXYDevsw0RcAcgS54z3IUBAbS94KXrNDHfMSExhfhrDG59OFe9MQqFKkQqUi7iTBWUSWr4Px+hoObiHGAwGVZHHgq+zEAK2Yi6yWXk0g=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB2987.eurprd08.prod.outlook.com (52.134.109.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.25; Tue, 8 Oct 2019 12:58:57 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::f9f9:ad51:6636:42f0]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::f9f9:ad51:6636:42f0%6]) with mapi id 15.20.2327.023; Tue, 8 Oct 2019
 12:58:57 +0000
From:   "Justin He (Arm Technology China)" <Justin.He@arm.com>
To:     Will Deacon <will@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        James Morse <James.Morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "hejianet@gmail.com" <hejianet@gmail.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        nd <nd@arm.com>
Subject: RE: [PATCH v10 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Thread-Topic: [PATCH v10 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Thread-Index: AQHVdzKJSZgAcCvyK02xG/xeDXFx5adFwEGAgApI6UCAALNdAIAAAKRQ
Date:   Tue, 8 Oct 2019 12:58:57 +0000
Message-ID: <DB7PR08MB30828D5469EA39EA0825B809F79A0@DB7PR08MB3082.eurprd08.prod.outlook.com>
References: <20190930015740.84362-1-justin.he@arm.com>
 <20190930015740.84362-4-justin.he@arm.com>
 <20191001125413.mhxa6qszwnuhglky@willie-the-truck>
 <DB7PR08MB3082563BD18482E5D541F019F79A0@DB7PR08MB3082.eurprd08.prod.outlook.com>
 <20191008123943.j7q6dlu2qb2az6xa@willie-the-truck>
In-Reply-To: <20191008123943.j7q6dlu2qb2az6xa@willie-the-truck>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: kirill.shutemov@linux.intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: a7ed52c1-c06d-41a3-8eff-11529d8e95c4.0
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: fe601e68-965f-4022-e785-08d74bef51f1
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: DB7PR08MB2987:|DB7PR08MB2987:|DB8PR08MB5163:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB516352284DE9F39E9B1475BDF79A0@DB8PR08MB5163.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 01842C458A
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(13464003)(189003)(199004)(4326008)(3846002)(6116002)(66476007)(64756008)(6246003)(7416002)(55016002)(66446008)(66556008)(256004)(71200400001)(71190400001)(229853002)(66946007)(9686003)(14444005)(6436002)(14454004)(66066001)(2906002)(76116006)(74316002)(86362001)(476003)(8676002)(5660300002)(81166006)(8936002)(7736002)(486006)(33656002)(305945005)(478600001)(6506007)(53546011)(102836004)(55236004)(54906003)(110136005)(316002)(76176011)(7696005)(26005)(81156014)(99286004)(446003)(11346002)(186003)(25786009)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB2987;H:DB7PR08MB3082.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: HJUPrm/SvtxLhExWz09IaNYaJWEBZyGvyHAAQzW4G1XzvYI03z40TrmMzotpiUekRSFQ8ybbJo8M4z/sP0dGCTRWwb56jeAuN19mIIDr8oWJstVDTaWt31mhsZRT1YXHRCu4InwItz+X6Y7g6+oYrw8v6WHF1MCt/pCv3U84oMtiuJ5aiQhDvN0e+b9y8oXPDysn6s5CfxWa6lYICbDQ96Y23Dv2I/70jyNaqjQFGtw3Kw9nvksuEqvHMiKaTmFs6m3uSxPL2Wk7S7wIxj9CGSVBLSbQh6fIEnJwLx0I6nEUEY7tJwsreALXNsBwCgPpMy69F1aLF9ZFuHjyBW3OH3oH6pU/k2OCM/J0pF/gCrXWNuVuKy0cUJWRrGW0sXwPS7atvoMYYzeCmbB3gH3GScFyFZnWgxYhC+b8R+/dL9E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB2987
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(346002)(39860400002)(13464003)(199004)(189003)(7696005)(23676004)(476003)(6246003)(4326008)(76176011)(6506007)(186003)(102836004)(3846002)(2486003)(26005)(6116002)(33656002)(26826003)(14454004)(53546011)(9686003)(55016002)(478600001)(22756006)(8936002)(336012)(486006)(8676002)(2906002)(81156014)(81166006)(63350400001)(126002)(446003)(99286004)(11346002)(436003)(110136005)(50466002)(36906005)(54906003)(47776003)(316002)(25786009)(66066001)(52536014)(229853002)(76130400001)(86362001)(356004)(70586007)(74316002)(5660300002)(305945005)(7736002)(14444005)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5163;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 05f76976-8d7a-4126-c054-08d74bef484a
NoDisclaimer: True
X-Forefront-PRVS: 01842C458A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pcniGxNuNig2QxG29KKk3yN4FxGpp8csaniMXjDJsRJSUnxZWrhim99hwZN1WC/d4/z4hrXi9k5Qwzx8uS4hXK6kYymcHYNOn7rAJgIz6tYT7FXdiwL8NabiebxiymXn0m/f3nmC65JFzYozMFJTisqbN07AaorwgSxu5m1etxQ3oXwgId/3iysdMEASkHZssHKmAdSJywHOCDNF31pm0k7KrDUcrXseReHk8fFig8hpcz5RSPuGFL3d+ul/xAcUI+3pTOMnomc/pOw8KJ3Is4Ojvaq1CY0HqW20fOLvcpG6Iz/oEwruSNzmBC1OKxXz5oJyirpN3u7tYRAMmaBqNK/mByRZcSAsy+VqaK/iwMczggLVuxYowMJwMYlovbYEPul/3sDmYLr+horJ6lGDsL4gZYt18hGM2JaYBoHCnh4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 12:59:13.9608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe601e68-965f-4022-e785-08d74bef51f1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2lsbA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdpbGwgRGVh
Y29uIDx3aWxsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMTnlubQxMOaciDjml6UgMjA6NDANCj4g
VG86IEp1c3RpbiBIZSAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpIDxKdXN0aW4uSGVAYXJtLmNvbT4N
Cj4gQ2M6IENhdGFsaW4gTWFyaW5hcyA8Q2F0YWxpbi5NYXJpbmFzQGFybS5jb20+OyBNYXJrIFJ1
dGxhbmQNCj4gPE1hcmsuUnV0bGFuZEBhcm0uY29tPjsgSmFtZXMgTW9yc2UgPEphbWVzLk1vcnNl
QGFybS5jb20+OyBNYXJjDQo+IFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPjsgTWF0dGhldyBXaWxj
b3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+OyBLaXJpbGwgQS4NCj4gU2h1dGVtb3YgPGtpcmlsbC5z
aHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+OyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gbW1Aa3Zh
Y2sub3JnOyBQdW5pdCBBZ3Jhd2FsIDxwdW5pdGFncmF3YWxAZ21haWwuY29tPjsgVGhvbWFzDQo+
IEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4
LQ0KPiBmb3VuZGF0aW9uLm9yZz47IGhlamlhbmV0QGdtYWlsLmNvbTsgS2FseSBYaW4gKEFybSBU
ZWNobm9sb2d5IENoaW5hKQ0KPiA8S2FseS5YaW5AYXJtLmNvbT47IG5kIDxuZEBhcm0uY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMCAzLzNdIG1tOiBmaXggZG91YmxlIHBhZ2UgZmF1bHQg
b24gYXJtNjQgaWYgUFRFX0FGDQo+IGlzIGNsZWFyZWQNCj4gDQo+IE9uIFR1ZSwgT2N0IDA4LCAy
MDE5IGF0IDAyOjE5OjA1QU0gKzAwMDAsIEp1c3RpbiBIZSAoQXJtIFRlY2hub2xvZ3kNCj4gQ2hp
bmEpIHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206
IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50OiAyMDE55bm0MTDmnIgx
5pelIDIwOjU0DQo+ID4gPiBUbzogSnVzdGluIEhlIChBcm0gVGVjaG5vbG9neSBDaGluYSkgPEp1
c3Rpbi5IZUBhcm0uY29tPg0KPiA+ID4gQ2M6IENhdGFsaW4gTWFyaW5hcyA8Q2F0YWxpbi5NYXJp
bmFzQGFybS5jb20+OyBNYXJrIFJ1dGxhbmQNCj4gPiA+IDxNYXJrLlJ1dGxhbmRAYXJtLmNvbT47
IEphbWVzIE1vcnNlIDxKYW1lcy5Nb3JzZUBhcm0uY29tPjsNCj4gTWFyYw0KPiA+ID4gWnluZ2ll
ciA8bWF6QGtlcm5lbC5vcmc+OyBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz47
DQo+IEtpcmlsbCBBLg0KPiA+ID4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRl
bC5jb20+OyBsaW51eC1hcm0tDQo+ID4gPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4gPiBtbUBrdmFjay5vcmc7IFB1
bml0IEFncmF3YWwgPHB1bml0YWdyYXdhbEBnbWFpbC5jb20+OyBUaG9tYXMNCj4gPiA+IEdsZWl4
bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LQ0KPiA+
ID4gZm91bmRhdGlvbi5vcmc+OyBoZWppYW5ldEBnbWFpbC5jb207IEthbHkgWGluIChBcm0gVGVj
aG5vbG9neSBDaGluYSkNCj4gPiA+IDxLYWx5LlhpbkBhcm0uY29tPg0KPiA+ID4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MTAgMy8zXSBtbTogZml4IGRvdWJsZSBwYWdlIGZhdWx0IG9uIGFybTY0IGlm
DQo+IFBURV9BRg0KPiA+ID4gaXMgY2xlYXJlZA0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgU2VwIDMw
LCAyMDE5IGF0IDA5OjU3OjQwQU0gKzA4MDAsIEppYSBIZSB3cm90ZToNCj4gPiA+ID4gZGlmZiAt
LWdpdCBhL21tL21lbW9yeS5jIGIvbW0vbWVtb3J5LmMNCj4gPiA+ID4gaW5kZXggYjFjYTUxYTA3
OWYyLi4xZjU2YjAxMThlZjUgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL21tL21lbW9yeS5jDQo+ID4g
PiA+ICsrKyBiL21tL21lbW9yeS5jDQo+ID4gPiA+IEBAIC0xMTgsNiArMTE4LDEzIEBAIGludCBy
YW5kb21pemVfdmFfc3BhY2UgX19yZWFkX21vc3RseSA9DQo+ID4gPiA+ICAJCQkJCTI7DQo+ID4g
PiA+ICAjZW5kaWYNCj4gPiA+ID4NCj4gPiA+ID4gKyNpZm5kZWYgYXJjaF9mYXVsdHNfb25fb2xk
X3B0ZQ0KPiA+ID4gPiArc3RhdGljIGlubGluZSBib29sIGFyY2hfZmF1bHRzX29uX29sZF9wdGUo
dm9pZCkNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKwlyZXR1cm4gZmFsc2U7DQo+ID4gPiA+ICt9DQo+
ID4gPiA+ICsjZW5kaWYNCj4gPiA+DQo+ID4gPiBLaXJpbGwgaGFzIGFja2VkIHRoaXMsIHNvIEkn
bSBoYXBweSB0byB0YWtlIHRoZSBwYXRjaCBhcy1pcywgaG93ZXZlciBpc24ndA0KPiA+ID4gaXQg
dGhlIGNhc2UgdGhhdCAvbW9zdC8gYXJjaGl0ZWN0dXJlcyB3aWxsIHdhbnQgdG8gcmV0dXJuIHRy
dWUgZm9yDQo+ID4gPiBhcmNoX2ZhdWx0c19vbl9vbGRfcHRlKCk/IEluIHdoaWNoIGNhc2UsIHdv
dWxkbid0IGl0IG1ha2UgbW9yZSBzZW5zZQ0KPiBmb3INCj4gPiA+IHRoYXQgdG8gYmUgdGhlIGRl
ZmF1bHQsIGFuZCBoYXZlIHg4NiBhbmQgYXJtNjQgcHJvdmlkZSBhbiBvdmVycmlkZT8NCj4gRm9y
DQo+ID4gPiBleGFtcGxlLCBhcmVuJ3QgbW9zdCBhcmNoaXRlY3R1cmVzIHN0aWxsIGdvaW5nIHRv
IGhpdCB0aGUgZG91YmxlIGZhdWx0DQo+ID4gPiBzY2VuYXJpbyBldmVuIHdpdGggeW91ciBwYXRj
aCBhcHBsaWVkPw0KPiA+DQo+ID4gTm8sIGFmdGVyIGFwcGx5aW5nIG15IHBhdGNoIHNlcmllcywg
b25seSB0aG9zZSBhcmNoaXRlY3R1cmVzIHdoaWNoIGRvbid0DQo+IHByb3ZpZGUNCj4gPiBzZXR0
aW5nIGFjY2VzcyBmbGFnIGJ5IGhhcmR3YXJlIEFORCBkb24ndCBpbXBsZW1lbnQgdGhlaXINCj4g
YXJjaF9mYXVsdHNfb25fb2xkX3B0ZQ0KPiA+IHdpbGwgaGl0IHRoZSBkb3VibGUgcGFnZSBmYXVs
dC4NCj4gPg0KPiA+IFRoZSBtZWFuaW5nIG9mIHRydWUgZm9yIGFyY2hfZmF1bHRzX29uX29sZF9w
dGUoKSBpcyAidGhpcyBhcmNoIGRvZXNuJ3QNCj4gaGF2ZSB0aGUgaGFyZHdhcmUNCj4gPiBzZXR0
aW5nIGFjY2VzcyBmbGFnIHdheSwgaXQgbWlnaHQgY2F1c2UgcGFnZSBmYXVsdCBvbiBhbiBvbGQg
cHRlIg0KPiA+IEkgZG9uJ3Qgd2FudCB0byBjaGFuZ2Ugb3RoZXIgYXJjaGl0ZWN0dXJlcycgZGVm
YXVsdCBiZWhhdmlvciBoZXJlLiBTbyBieQ0KPiBkZWZhdWx0LA0KPiA+IGFyY2hfZmF1bHRzX29u
X29sZF9wdGUoKSBpcyBmYWxzZS4NCj4gDQo+IC4uLmFuZCBteSBjb21wbGFpbnQgaXMgdGhhdCB0
aGlzIGlzIHRoZSBtYWpvcml0eSBvZiBzdXBwb3J0ZWQgYXJjaGl0ZWN0dXJlcywNCj4gc28geW91
J3JlIGZpeGluZyBzb21ldGhpbmcgZm9yIGFybTY0IHdoaWNoIGFsc28gYWZmZWN0cyBhcm0sIHBv
d2VycGMsDQo+IGFscGhhLCBtaXBzLCByaXNjdiwgLi4uDQoNClNvLCBJSVVDLCB5b3Ugc3VnZ2Vz
dGVkIHRoYXQ6DQoxLiBieSBkZWZhdWx0LCBhcmNoX2ZhdWx0c19vbl9vbGRfcHRlKCkgcmV0dXJu
IHRydWUNCjIuIG9uIFg4NiwgbGV0IGFyY2hfZmF1bHRzX29uX29sZF9wdGUoKSBiZSBvdmVycmlk
ZWQgYXMgcmV0dXJuaW5nIGZhbHNlDQozLiBvbiBhcm02NCwgbGV0IGl0IGJlIGFzLWlzIG15IHBh
dGNoIHNldC4NCjQuIGxldCBvdGhlciBhcmNoaXRlY3R1cmVzIGRlY2lkZSB0aGUgYmVoYXZpb3Iu
IChCdXQgYnkgZGVmYXVsdCwgaXQgd2lsbCBzZXQNCnB0ZV95b3VuZykNCg0KSSBhbSBvayB3aXRo
IHRoYXQgaWYgbm8gb2JqZWN0aW9ucyBmcm9tIG90aGVycy4NCg0KQEtpcmlsbCBBLiBTaHV0ZW1v
diBEbyB5b3UgaGF2ZSBhbnkgY29tbWVudHM/IFRoYW5rcw0KPiANCj4gQ2hhbmNlcyBhcmUsIHRo
ZXkgd29uJ3QgZXZlbiByZWFsaXNlIHRoZXkgbmVlZCB0byBpbXBsZW1lbnQNCj4gYXJjaF9mYXVs
dHNfb25fb2xkX3B0ZSgpIHVudGlsIHNvbWVib2R5IHJ1bnMgaW50byB0aGUgZG91YmxlIGZhdWx0
IGFuZA0KPiB3YXN0ZXMgbG90cyBvZiB0aW1lIGRlYnVnZ2luZyBpdCBiZWZvcmUgdGhleSBzcG90
IHlvdXIgcGF0Y2guDQoNCkFzIHRvIHRoaXMgcG9pbnQsIEkgYWRkZWQgYSBXQVJOX09OIGluIHBh
dGNoIDAzIHRvIHNwZWVkIHVwIHRoZSBkZWJ1Z2dpbmcNCnByb2Nlc3MuDQoNCi0tDQpDaGVlcnMs
DQpKdXN0aW4gKEppYSBIZSkNCg0KDQoNCj4gDQo+ID4gQnR3LCBjdXJyZW50bHkgSSBvbmx5IG9i
c2VydmVkIHRoaXMgZG91YmxlIHBhZ2VmYXVsdCBvbiBhcm02NCdzIGd1ZXN0DQo+ID4gKGhvc3Qg
aXMgVGh1bmRlclgyKS4gIE9uIFg4NiBndWVzdCAoaG9zdCBpcyBJbnRlbChSKSBDb3JlKFRNKSBp
Ny00NzkwIENQVQ0KPiA+IEAgMy42MEdIeiApLCB0aGVyZSBpcyBubyBzdWNoIGRvdWJsZSBwYWdl
ZmF1bHQuIEl0IGhhcyB0aGUgc2ltaWxhciBzZXR0aW5nDQo+ID4gYWNjZXNzIGZsYWcgd2F5IGJ5
IGhhcmR3YXJlLg0KPiANCj4gUmlnaHQsIGFuZCB0aGF0J3Mgd2h5IEknbSBub3QgY29uY2VybmVk
IGFib3V0IHg4NiBmb3IgdGhpcyBwcm9ibGVtLg0KPiANCj4gV2lsbA0K
