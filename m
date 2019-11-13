Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DF7C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377B822459
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="NMs/cVyq";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="NMs/cVyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfKMNoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:44:10 -0500
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:47342
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbfKMNoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0ZEYdbr2D3d3TK+bnLmOoKXmfqBF8/y8ew85QeifXk=;
 b=NMs/cVyqFdhH5/zugH9GxoIdoS/QBP9spfV/uaDbsVNBVzPUgO0oRcmUqzNAxRrWId8OC0Z+ZpCD2UCgMWZkh0WBQWrLSLffyBDxaf0qpTMlz4rgTdhqluwWIHtxAqZi+owwISO+LVdbBSyHMaI+u0eIl3pgxPP4iLwg9p3TBPE=
Received: from VI1PR0802CA0021.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::31) by AM0PR08MB3618.eurprd08.prod.outlook.com
 (2603:10a6:208:de::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22; Wed, 13 Nov
 2019 13:44:03 +0000
Received: from DB5EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by VI1PR0802CA0021.outlook.office365.com
 (2603:10a6:800:aa::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.23 via Frontend
 Transport; Wed, 13 Nov 2019 13:44:03 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT062.mail.protection.outlook.com (10.152.20.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Wed, 13 Nov 2019 13:44:03 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Wed, 13 Nov 2019 13:44:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 888fc3b6e63e1223
X-CR-MTA-TID: 64aa7808
Received: from d9d7c5a5d790.2 (cr-mta-lb-1.cr-mta-net [104.47.2.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 36A1F602-C2DA-4A36-86C3-C3BDC8946BEC.1;
        Wed, 13 Nov 2019 13:43:55 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2059.outbound.protection.outlook.com [104.47.2.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d9d7c5a5d790.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 13 Nov 2019 13:43:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1FoFR5tf1iNl3vek+DPfGQsSXk9ROrnaQ0RRt8+3dG593sp55j8GCZYKE5u3Lj93tRXQupWN/qC4meLFGIyltYzBxrrYogTB9CocRhJ+iOhK2bdzwRi/J5btZNL96pWsZ/3EdXO/XSes3Sn1Af0fUj9FMZhPmsTKjvPdnD17JydQMmqDMxfiul6da7fWW4cFEe9iJ8D1fmQeX4QLIGnaEaqTEZIZP5lLrj3o4UqxOs1j8b7+/qTJ41O87Vx5hQ2F0Z//M/NpWuPnH7FrgyL1UWmt7CuqL+sImcq/xkmErxoSljLAjzs4SyYsoZONiA2ZHgk6wXN1p6lqtwazhR0Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0ZEYdbr2D3d3TK+bnLmOoKXmfqBF8/y8ew85QeifXk=;
 b=F4/bvGAapxkkweI3SNrNLKq4dYdBmy/7ti4+swCpiVBDF4qrvxVcnw7inP+/WYc1s30V+/0JrEVxCfccqtuNt2qfCudxpWE+BZcpYLzd54wvreweAGjXaNmUk82qMnOaoKyKsWtLd2P7zXgjHSZIjSVuWiFhLb28Xurg/662qYBXxkAMwBt6jjZV7dJpywx//T0fr+BqytVac25vWXXZeW++Xb+gPusCRtUTjTCMmyXBczJ/hvAqX8wZxgQphOvYmMshw5TtFl7aqei200MnaDYlxNWZ+s9ryp7Tk6lIV8+qH3ACZ4KT+o2BsDvbKOdmUlB2BxcWVXq1j5oJcby+ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0ZEYdbr2D3d3TK+bnLmOoKXmfqBF8/y8ew85QeifXk=;
 b=NMs/cVyqFdhH5/zugH9GxoIdoS/QBP9spfV/uaDbsVNBVzPUgO0oRcmUqzNAxRrWId8OC0Z+ZpCD2UCgMWZkh0WBQWrLSLffyBDxaf0qpTMlz4rgTdhqluwWIHtxAqZi+owwISO+LVdbBSyHMaI+u0eIl3pgxPP4iLwg9p3TBPE=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4400.eurprd08.prod.outlook.com (20.179.26.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.26; Wed, 13 Nov 2019 13:43:53 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2430.028; Wed, 13 Nov 2019
 13:43:53 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        nd <nd@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] drm/komeda: add rate limiting disable to
 err_verbosity
Thread-Topic: [PATCH v2 5/5] drm/komeda: add rate limiting disable to
 err_verbosity
Thread-Index: AQHVlWB4xMPbXmf91UG5tobxnmp6wKeGJX6AgAFh7oCAAFqbAIABQ/uA
Date:   Wed, 13 Nov 2019 13:43:53 +0000
Message-ID: <2040706.mPXGPD4v5A@e123338-lin>
References: <20191107114155.54307-1-mihail.atanassov@arm.com>
 <39367348.R9gcQaf2xt@e123338-lin>
 <CAKMK7uHB-mHmuBA-VkKuhUSRHQRu0wvHHJA+a=Q1fXSXaJgrpw@mail.gmail.com>
In-Reply-To: <CAKMK7uHB-mHmuBA-VkKuhUSRHQRu0wvHHJA+a=Q1fXSXaJgrpw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::31) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1441450a-cfa1-4e43-ed36-08d7683f8bc3
X-MS-TrafficTypeDiagnostic: VI1PR08MB4400:|VI1PR08MB4400:|AM0PR08MB3618:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3618BD83D9E46259CD4B441F8F760@AM0PR08MB3618.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 0220D4B98D
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(6486002)(66946007)(66066001)(86362001)(33716001)(6916009)(316002)(305945005)(256004)(14444005)(14454004)(7736002)(81166006)(81156014)(8676002)(8936002)(66476007)(66556008)(64756008)(71190400001)(71200400001)(66446008)(229853002)(6436002)(446003)(11346002)(476003)(26005)(6116002)(186003)(2906002)(486006)(9686003)(52116002)(99286004)(6512007)(478600001)(4326008)(5660300002)(54906003)(6246003)(25786009)(102836004)(3846002)(76176011)(386003)(6506007)(53546011)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4400;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: mNpzLSmslCOAzQKsU6+IwQdSjFBCUF1BV7QgHA/mPmYZOeGjaXxPpcPh7wMzDxKmnSK8YUJ3GUJYAjNQH++el636KvYaf62KClY8Q0qcqOpfK3OP+Pe812v7wIcPeAXHDA4Kl8CE0ZyxYRQe0K6wP6dNiTwE5MYFwpbax3kZ0xIxnMM2bqMyFeSrIzVo83Yu/BP08yetiEGEgowmyz/F6FN0m7lSHUlhRqXU8gZDmQNlWur7CRFbnlL/PZpe6J0ina+hIXJ7om15iHqkLXtqaud3YrnH78thbrAEm9qES5AEYmAvhM14fldmZ/SCdMCq5A0t6QgJ0VkYD2yRnJkdKVjgnQm+78HPXIf+WolnPE5YP0lFAH4tyUaJpGW4RloCxGkiM3m+tvs1TN7XdU7CImOFLqKjgBHeH7t1IHvOlF0/ao98+h1nnSzHEHpetEgr
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFFAAE3139026448B4031FD8C7679EF9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4400
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(39860400002)(136003)(346002)(376002)(1110001)(339900001)(199004)(189003)(102836004)(5660300002)(11346002)(446003)(486006)(126002)(2906002)(476003)(336012)(386003)(53546011)(14444005)(70586007)(6506007)(33716001)(26005)(3846002)(76176011)(25786009)(2486003)(50466002)(229853002)(54906003)(7736002)(436003)(305945005)(23676004)(8936002)(316002)(76130400001)(6116002)(81156014)(105606002)(81166006)(6512007)(6486002)(8676002)(14454004)(86362001)(478600001)(22756006)(47776003)(99286004)(70206006)(356004)(26826003)(6862004)(4326008)(6246003)(9686003)(66066001)(186003)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3618;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5bb44ab3-e3e1-4061-664c-08d7683f858b
NoDisclaimer: True
X-Forefront-PRVS: 0220D4B98D
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: whIh9glKLlB0sgb3kIPWNXu6fOlY/OS5G6NPA3jS8nb9Oldv+IljGOoRYoD2DZqB0NQTb8QYPoEILeNTyRM+uPZUR1AiPA4F9FivPaSA/zs+Od8++rCWTy2kPQNmSMNss07nIrEsFKNuD84/e7obnc+cjFi7eY/ML7Eh66l9QWL4Lug6f4qqe1CrTb7jYtie21DgRGyPdFl6ueYVQk2V7OHCzKlR5fCTa1o1wtHdSRvU59d59mz4ET2R7g/dgA5oERMgM7CGmFgkhb4MOUPd8GTQzDK5JafqEOR+vY+lCqKTP0nFgX5hL9z+K/D8obe19Ms77MgxICuSVUfkABDn1rDf3xlz2uLxCPjCkDDPbuqouz60Ops+amyU9Fb4UKhHYdroEGaYbEvAg7AGbV1JqIdX+FdvuuAEpHC7RsRnnW6+k5N0mGPqu6mxOwsgoNNE
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 13:44:03.2725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1441450a-cfa1-4e43-ed36-08d7683f8bc3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3618
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlc2RheSwgMTIgTm92ZW1iZXIgMjAxOSAxODoyNDoxNiBHTVQgRGFuaWVsIFZldHRlciB3
cm90ZToNCj4gT24gVHVlLCBOb3YgMTIsIDIwMTkgYXQgMjowMCBQTSBNaWhhaWwgQXRhbmFzc292
DQo+IDxNaWhhaWwuQXRhbmFzc292QGFybS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gTW9uZGF5
LCAxMSBOb3ZlbWJlciAyMDE5IDE1OjUzOjE0IEdNVCBMaXZpdSBEdWRhdSB3cm90ZToNCj4gPiA+
IE9uIFRodSwgTm92IDA3LCAyMDE5IGF0IDExOjQyOjQ0QU0gKzAwMDAsIE1paGFpbCBBdGFuYXNz
b3Ygd3JvdGU6DQo+ID4gPiA+IEl0J3MgcG9zc2libGUgdG8gZ2V0IG11bHRpcGxlIGV2ZW50cyBp
biBhIHNpbmdsZSBmcmFtZS9mbGlwLCBzbyBhZGQgYW4NCj4gPiA+ID4gb3B0aW9uIHRvIHByaW50
IHRoZW0gYWxsLg0KPiA+ID4gPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogSmFtZXMgUWlhbiBXYW5n
IChBcm0gVGVjaG5vbG9neSBDaGluYSkgPGphbWVzLnFpYW4ud2FuZ0Bhcm0uY29tPg0KPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBNaWhhaWwgQXRhbmFzc292IDxtaWhhaWwuYXRhbmFzc292QGFybS5j
b20+DQo+ID4gPg0KPiA+ID4gRm9yIHRoZSB3aG9sZSBzZXJpZXM6DQo+ID4gPg0KPiA+ID4gQWNr
ZWQtYnk6IExpdml1IER1ZGF1IDxsaXZpdS5kdWRhdUBhcm0uY29tPg0KPiA+DQo+ID4gVGhhbmtz
LCBhcHBsaWVkIHRvIGRybS1taXNjLW5leHQuDQo+IA0KPiBBbmQgbm93IGtvbWVkYSBkb2Vzbid0
IGV2ZW4gY29tcGlsZSBhbnltb3JlLiBJJ20gLi4uIGltcHJlc3NlZC4NCj4gDQoNCk1lYSBjdWxw
YSEgU29ycnkgYWJvdXQgdGhlIGJyZWFrYWdlLCBJIGRpZCBidWlsZC10ZXN0IGJ1dCBhcHBhcmVu
dGx5DQpub3QgdGhlIHJpZ2h0IGNoZWNrb3V0IDovLiBJJ2xsIGFkanVzdCBteSB3b3JrZmxvdyB0
byBtYWtlIHN1cmUgdGhpcw0KZG9lc24ndCBoYXBwZW4gYWdhaW4uDQoNCj4gSSBtZWFuIGdlbmVy
YWxseSBwZW9wbGUgYnJlYWsgb3RoZXIgcGVvcGxlJ3MgZHJpdmVyLCBub3QgdGhlaXIgb3duLg0K
PiAtRGFuaWVsDQo+IA0KPiA+ID4NCj4gPiA+IEJlc3QgcmVnYXJkcywNCj4gPiA+IExpdml1DQo+
ID4gPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4NCj4gPiA+ID4gIHYyOiBDbGVhbiB1cCBjb250aW51
YXRpb24gbGluZSB3YXJuaW5nIGZyb20gY2hlY2twYXRjaC4NCj4gPiA+ID4NCj4gPiA+ID4gIGRy
aXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2Rldi5oICAgfCAyICsrDQo+
ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9ldmVudC5j
IHwgMiArLQ0KPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
cm0vZGlzcGxheS9rb21lZGEva29tZWRhX2Rldi5oIGIvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNw
bGF5L2tvbWVkYS9rb21lZGFfZGV2LmgNCj4gPiA+ID4gaW5kZXggZDlmYzljNDg4NTlhLi4xNWY1
MmUzMDRjMDggMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxh
eS9rb21lZGEva29tZWRhX2Rldi5oDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hcm0v
ZGlzcGxheS9rb21lZGEva29tZWRhX2Rldi5oDQo+ID4gPiA+IEBAIC0yMjQsNiArMjI0LDggQEAg
c3RydWN0IGtvbWVkYV9kZXYgew0KPiA+ID4gPiAgI2RlZmluZSBLT01FREFfREVWX1BSSU5UX0lO
Rk9fRVZFTlRTIEJJVCgyKQ0KPiA+ID4gPiAgICAgLyogRHVtcCBEUk0gc3RhdGUgb24gYW4gZXJy
b3Igb3Igd2FybmluZyBldmVudC4gKi8NCj4gPiA+ID4gICNkZWZpbmUgS09NRURBX0RFVl9QUklO
VF9EVU1QX1NUQVRFX09OX0VWRU5UIEJJVCg4KQ0KPiA+ID4gPiArICAgLyogRGlzYWJsZSByYXRl
IGxpbWl0aW5nIG9mIGV2ZW50IHByaW50cyAobm9ybWFsbHkgb25lIHBlciBjb21taXQpICovDQo+
ID4gPiA+ICsjZGVmaW5lIEtPTUVEQV9ERVZfUFJJTlRfRElTQUJMRV9SQVRFTElNSVQgQklUKDEy
KQ0KPiA+ID4gPiAgfTsNCj4gPiA+ID4NCj4gPiA+ID4gIHN0YXRpYyBpbmxpbmUgYm9vbA0KPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21l
ZGFfZXZlbnQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2V2
ZW50LmMNCj4gPiA+ID4gaW5kZXggN2ZkNjI0NzYxYTJiLi5iZjI2OTY4M2Y4MTEgMTAwNjQ0DQo+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2V2
ZW50LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9r
b21lZGFfZXZlbnQuYw0KPiA+ID4gPiBAQCAtMTE5LDcgKzExOSw3IEBAIHZvaWQga29tZWRhX3By
aW50X2V2ZW50cyhzdHJ1Y3Qga29tZWRhX2V2ZW50cyAqZXZ0cywgc3RydWN0IGRybV9kZXZpY2Ug
KmRldikNCj4gPiA+ID4gICAgIC8qIHJlZHVjZSB0aGUgc2FtZSBtc2cgcHJpbnQsIG9ubHkgcHJp
bnQgdGhlIGZpcnN0IGV2dCBmb3Igb25lIGZyYW1lICovDQo+ID4gPiA+ICAgICBpZiAoZXZ0cy0+
Z2xvYmFsIHx8IGlzX25ld19mcmFtZShldnRzKSkNCj4gPiA+ID4gICAgICAgICAgICAgZW5fcHJp
bnQgPSB0cnVlOw0KPiA+ID4gPiAtICAgaWYgKCFlbl9wcmludCkNCj4gPiA+ID4gKyAgIGlmICgh
KGVycl92ZXJib3NpdHkgJiBLT01FREFfREVWX1BSSU5UX0RJU0FCTEVfUkFURUxJTUlUKSAmJiAh
ZW5fcHJpbnQpDQo+ID4gPiA+ICAgICAgICAgICAgIHJldHVybjsNCj4gPiA+ID4NCj4gPiA+ID4g
ICAgIGlmIChlcnJfdmVyYm9zaXR5ICYgS09NRURBX0RFVl9QUklOVF9FUlJfRVZFTlRTKQ0KPiA+
ID4gPiAtLQ0KPiA+ID4gPiAyLjIzLjANCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4g
PT09PT09PT09PT09PT09PT09PT0NCj4gPiA+IHwgSSB3b3VsZCBsaWtlIHRvIHwNCj4gPiA+IHwg
Zml4IHRoZSB3b3JsZCwgIHwNCj4gPiA+IHwgYnV0IHRoZXkncmUgbm90IHwNCj4gPiA+IHwgZ2l2
aW5nIG1lIHRoZSAgIHwNCj4gPiA+ICBcIHNvdXJjZSBjb2RlISAgLw0KPiA+ID4gICAtLS0tLS0t
LS0tLS0tLS0NCj4gPiA+ICAgICDCr1xfKOODhClfL8KvDQo+ID4gPg0KPiA+DQo+ID4NCj4gPiAt
LQ0KPiA+IE1paGFpbA0KPiA+DQo+ID4NCj4gPg0KPiANCj4gDQo+IA0KDQoNCi0tIA0KTWloYWls
DQoNCg0KDQo=
