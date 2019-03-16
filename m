Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED050C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 13:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30F5218A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 13:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="P208euU3";
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="P208euU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfCPNDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 09:03:33 -0400
Received: from mail-eopbgr10070.outbound.protection.outlook.com ([40.107.1.70]:13828
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbfCPNDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 09:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector1-TopicProducts-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSQZLWwc2aOfbIhPoUov/4czBJP6+8SD82nyj0xvyt8=;
 b=P208euU312I0dQ1a0zyG1ukUv/3xzg2UTQvQdd40oe4yC2GVOmm8Zij/7xQUDYX1LSQl3cvmtHWdmmDZZ6EBGtJnHRZM/4A9m6r/FMCE1ujWRtkdYQQvG0Km/Jsq/eZNIXn226rivLb5purib6VDJloEOfCkXmW+kL2MuCm3mUU=
Received: from AM6PR04CA0057.eurprd04.prod.outlook.com (2603:10a6:20b:f0::34)
 by DB7PR04MB4267.eurprd04.prod.outlook.com (2603:10a6:5:27::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Sat, 16 Mar
 2019 13:00:45 +0000
Received: from DB5EUR01FT021.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e02::208) by AM6PR04CA0057.outlook.office365.com
 (2603:10a6:20b:f0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.14 via Frontend
 Transport; Sat, 16 Mar 2019 13:00:45 +0000
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 52.236.92.113 as permitted sender)
 receiver=protection.outlook.com; client-ip=52.236.92.113;
 helo=eu2-emailsignatures-cloud.codetwo.com;
Received: from eu2-emailsignatures-cloud.codetwo.com (52.236.92.113) by
 DB5EUR01FT021.mail.protection.outlook.com (10.152.4.245) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1709.13 via Frontend Transport; Sat, 16 Mar 2019 13:00:45 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (104.47.8.57) by eu2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Sat, 16 Mar 2019 13:00:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector1-TopicProducts-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSQZLWwc2aOfbIhPoUov/4czBJP6+8SD82nyj0xvyt8=;
 b=P208euU312I0dQ1a0zyG1ukUv/3xzg2UTQvQdd40oe4yC2GVOmm8Zij/7xQUDYX1LSQl3cvmtHWdmmDZZ6EBGtJnHRZM/4A9m6r/FMCE1ujWRtkdYQQvG0Km/Jsq/eZNIXn226rivLb5purib6VDJloEOfCkXmW+kL2MuCm3mUU=
Received: from DB7PR04MB5260.eurprd04.prod.outlook.com (20.176.236.92) by
 DB7PR04MB5051.eurprd04.prod.outlook.com (20.176.234.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Sat, 16 Mar 2019 13:00:39 +0000
Received: from DB7PR04MB5260.eurprd04.prod.outlook.com
 ([fe80::b0b4:776c:f2bf:963c]) by DB7PR04MB5260.eurprd04.prod.outlook.com
 ([fe80::b0b4:776c:f2bf:963c%7]) with mapi id 15.20.1709.011; Sat, 16 Mar 2019
 13:00:39 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     Himanshu Jha <himanshujha199640@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "dpfrey@gmail.com" <dpfrey@gmail.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>
Subject: Re: [PATCH v3 2/2] iio/chemical/bme680: Fix SPI read interface
Thread-Topic: [PATCH v3 2/2] iio/chemical/bme680: Fix SPI read interface
Thread-Index: AQHU0+6wg2QFSf/lCUS4QDU+DIU4JKYOHP6AgAArpIA=
Date:   Sat, 16 Mar 2019 13:00:39 +0000
Message-ID: <929ccc7f-3fdd-d28b-d469-68f2373cdd82@topic.nl>
References: <1550238475-25698-1-git-send-email-mike.looijmans@topic.nl>
 <1551857508-4254-2-git-send-email-mike.looijmans@topic.nl>
 <20190316102425.GA26481@himanshu-Vostro-3559>
In-Reply-To: <20190316102425.GA26481@himanshu-Vostro-3559>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-clientproxiedby: AM6PR05CA0026.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::39) To DB7PR04MB5260.eurprd04.prod.outlook.com
 (2603:10a6:10:21::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [85.150.144.104]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 3b3ae73e-c547-4eec-4995-08d6aa0f673c
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5051;
X-MS-TrafficTypeDiagnostic: DB7PR04MB5051:|DB7PR04MB4267:
X-Microsoft-Antispam-PRVS: <DB7PR04MB4267D17FFBD06D1C58039A3E96450@DB7PR04MB4267.eurprd04.prod.outlook.com>
x-forefront-prvs: 09781D4C35
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(39830400003)(136003)(199004)(189003)(486006)(4326008)(25786009)(99286004)(31686004)(8936002)(14454004)(6436002)(2906002)(508600001)(81156014)(81166006)(64126003)(5660300002)(6916009)(8676002)(102836004)(6506007)(3846002)(53546011)(65826007)(186003)(386003)(26005)(6246003)(53936002)(6116002)(52116002)(97736004)(305945005)(7736002)(316002)(105586002)(11346002)(42882007)(1411001)(446003)(58126008)(2616005)(76176011)(74482002)(6512007)(229853002)(68736007)(54906003)(71190400001)(36756003)(71200400001)(6486002)(106356001)(44832011)(31696002)(476003)(65806001)(65956001)(256004)(66066001)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5051;H:DB7PR04MB5260.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: JR82JFdI2Sk897/d9J+f6yRGUXWG4Apcq4U0OX0yNSwagDTRfn+0dnd+Gg419iR/r0DTJxBSqG0ujSTbpmL3Rc8oK83gPz5O2pdUqAdT9L2sYQYslD8i6JV7/DB9WSGPjvPv34Jmp2ieGqmqtNetwOwnf0rOcjSb2jIi0yrw0Vzpy+lsge9vOKz4YjNA0A95eXUOFIfDQsboAs1AYVBMw2sB1U8DSOtdAWPLXEh0nNExQo6MSZkpsKyUySUMIZJIup9+vo4MjUPUQsW2sISd0LDa4l8uUsri4cQ5ioFB7iYmJUAs7z55Xts6TygakSssPscwp1aUDc4IOboEWqkQBKBwd8tTveT/aezFWTYQnHBz9iWm+gIQGG8+NdhbhKn4x1EsN+c7J5OWlt31mYsx3/lh7F0tjnKboetc9CPeL0o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93DA9A9768443D4E84BCF33D27BECF3D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5051
X-CodeTwo-MessageID: 20190316130041.767dcac3-7577-4b7c-8bfb-b8628107601a@eu2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT021.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:52.236.92.113;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39840400004)(376002)(346002)(2980300002)(189003)(199004)(246002)(74482002)(7636002)(7736002)(7596002)(305945005)(6116002)(186003)(436003)(508600001)(3846002)(11346002)(65956001)(66066001)(65806001)(446003)(65826007)(64126003)(54906003)(6246003)(229853002)(99286004)(316002)(106466001)(356004)(76176011)(8676002)(36756003)(2486003)(6916009)(6486002)(476003)(106002)(58126008)(6512007)(23676004)(53546011)(6506007)(6346003)(386003)(4326008)(50466002)(26005)(5660300002)(31696002)(1411001)(2906002)(25786009)(336012)(486006)(8936002)(14454004)(47776003)(31686004)(2616005)(44832011)(126002)(42882007)(102836004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4267;H:eu2-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:eu2-emailsignatures-cloud.codetwo.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1e36630d-4881-41ec-ca8f-08d6aa0f636e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600127)(710020)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4267;
X-Forefront-PRVS: 09781D4C35
X-Microsoft-Antispam-Message-Info: Q2oP72ux7kMqbVBmnYDPAajVYtTsF9deubRxmDUmoE1I+5VRkvorVKfGrDAbUrQokVJGnBD4+t1sZ1WmttBu+mOWzZGJf0LNtUd1WjMKegG38hAU8rjkZc2Inulx8hFByymngKKbBtJg68MGwc4G2/rYvINVDSegddBJe2lHaQcIfin+YrK0CJUxfxZiMv5v23U5LC1WcbHLxjNYwTta4vIuqoxC+iE1ipqMxl/LsH/p4t4uN+6cZAwY26nLxbsxooB84MVBFTRVUv7bQ4D3FTm2CEh9r13Hd9+KoSASKfjJFxfUsT8pZeSy/4YCX5N8Othd5dT8GStMm1E8sEbESumSBKAoDzsjXhQrZAxJ5UB2gkteQwSJYBS5c2SkuuFlcwG7hhXnS/fjBhwbxHOT8Ww0AF5khAhcbgb27+UZJB4=
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2019 13:00:45.2309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3ae73e-c547-4eec-4995-08d6aa0f673c
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[52.236.92.113];Helo=[eu2-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4267
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYtMDMtMTkgMTE6MjQsIEhpbWFuc2h1IEpoYSB3cm90ZToNCj4gT24gV2VkLCBNYXIgMDYs
IDIwMTkgYXQgMDg6MzE6NDhBTSArMDEwMCwgTWlrZSBMb29pam1hbnMgd3JvdGU6DQo+PiBUaGUg
U1BJIGludGVyZmFjZSBpbXBsZW1lbnRhdGlvbiB3YXMgY29tcGxldGVseSBicm9rZW4uDQo+Pg0K
Pj4gV2hlbiB1c2luZyB0aGUgU1BJIGludGVyZmFjZSwgdGhlcmUgYXJlIG9ubHkgNyBhZGRyZXNz
IGJpdHMsIHRoZSB1cHBlciBiaXQNCj4+IGlzIGNvbnRyb2xsZWQgYnkgYSBwYWdlIHNlbGVjdCBy
ZWdpc3Rlci4gVGhlIGNvcmUgbmVlZHMgYWNjZXNzIHRvIGJvdGgNCj4+IHJhbmdlcywgc28gaW1w
bGVtZW50IHJlZ2lzdGVyIHJlYWQvd3JpdGUgZm9yIGJvdGggcmVnaW9ucy4gVGhlIHJlZ21hcA0K
Pj4gcGFnaW5nIGZ1bmN0aW9uYWxpdHkgZGlkbid0IGFncmVlIHdpdGggYSByZWdpc3RlciB0aGF0
IG5lZWRzIHRvIGJlIHJlYWQNCj4+IGFuZCBtb2RpZmllZCwgc28gSSBpbXBsZW1lbnRlZCBhIGN1
c3RvbSBwYWdpbmcgYWxnb3JpdGhtLg0KPj4NCj4+IFRoaXMgZml4ZXMgdGhhdCB0aGUgZGV2aWNl
IHdvdWxkbid0IGV2ZW4gcHJvYmUgaW4gU1BJIG1vZGUuDQo+Pg0KPj4gVGhlIFNQSSBpbnRlcmZh
Y2UgdGhlbiBpc24ndCBkaWZmZXJlbnQgZnJvbSBJMkMsIG1lcmdlZCB0aGVtIGludG8gdGhlIGNv
cmUsDQo+PiBhbmQgdGhlIEkyQy9TUEkgbmFtZWQgcmVnaXN0ZXJzIGFyZSBubyBsb25nZXIgbmVl
ZGVkLg0KPj4NCj4+IEltcGxlbWVudGVkIHJlZ2lzdGVyIHZhbHVlIGNhY2hpbmcgZm9yIHRoZSBy
ZWdpc3RlcnMgdG8gcmVkdWNlIHRoZSBJMkMvU1BJDQo+PiBkYXRhIHRyYW5zZmVycyBjb25zaWRl
cmFibHkuDQo+Pg0KPj4gVGhlIGNhbGlicmF0aW9uIHNldCByZWFkcyBhcyBhbGwgemVyb2VzIHVu
dGlsIHNvbWUgdW5kZWZpbmVkIHBvaW50IGluIHRpbWUsDQo+PiBhbmQgSSBjb3VsZG4ndCBkZXRl
cm1pbmUgd2hhdCBtYWtlcyBpdCB2YWxpZC4gVGhlIGRhdGFzaGVldCBtZW50aW9ucyB0aGVzZQ0K
Pj4gcmVnaXN0ZXJzIGJ1dCBkb2VzIG5vdCBwcm92aWRlIGFueSBoaW50cyBvbiB3aGVuIHRoZXkg
YmVjb21lIHZhbGlkLCBhbmQgdGhleQ0KPj4gYXJlbid0IGV2ZW4gZW51bWVyYXRlZCBpbiB0aGUg
bWVtb3J5IG1hcC4gU28gY2hlY2sgdGhlIGNhbGlicmF0aW9uIGFuZA0KPj4gcmV0cnkgcmVhZGlu
ZyBpdCBmcm9tIHRoZSBkZXZpY2UgYWZ0ZXIgZWFjaCBtZWFzdXJlbWVudCB1bnRpbCBpdCBwcm92
aWRlcw0KPj4gc29tZXRoaW5nIHZhbGlkLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE1pa2UgTG9v
aWptYW5zIDxtaWtlLmxvb2lqbWFuc0B0b3BpYy5ubD4NCj4+IC0tLQ0KPiANCj4gSSBoYXZlIGJl
ZW4gdHJ5aW5nIHRvIHRlc3QgdGhpcyBwYXRjaCBpbiB0aGUgcGFzdCB3ZWVrIGFuZCBzdGlsbCBp
dA0KPiBmYWlsZWQgZXZlcnl0aW1lLg0KPiANCj4gRmlyc3QgSSB1c2VkIEFDUEkgdG8gZW51bWVy
YXRlIHRoZSBkZXZpY2UgaW4gUUVNVSBzZXR1cDoNCj4gDQo+IEFkZGVkIHNvbWUgcHJpbnRrcyBm
b3IgZGVidWdnaW5nOg0KPiANCj4gWyAgIDE0LjUxMDE5OF0gYm1lNjgwX3NwaSBzcGktQk1FMDY4
MDowMDogSnVtcGluZyB0byBjb3JlIGRyaXZlciBub3cgLi4uDQo+IFsgICAxNC41NDQ1MjhdIGJt
ZTY4MF9zcGkgc3BpLUJNRTA2ODA6MDA6IFBhZ2Ugc2V0dGluZyBkb25lLCBvbiBQYWdlIDowIG5v
dw0KPiBbICAgMTQuNTU0MzYzXSBibWU2ODBfc3BpIHNwaS1CTUUwNjgwOjAwOiBibWU2ODBfcmVn
bWFwX3NwaV93cml0ZTogb24gUGFnZSA6MCBub3cNCj4gWyAgIDE0LjU1NjE1MV0gYm1lNjgwX3Nw
aSBzcGktQk1FMDY4MDowMDogYm1lNjgwX3JlZ21hcF9zcGlfcmVhZDogb24gUGFnZSA6MCBub3cN
Cj4gWyAgIDE0LjU2NzgxNV0gYm1lNjgwX3NwaSBzcGktQk1FMDY4MDowMDogV3JvbmcgY2hpcCBJ
RCwgZ290IGZmIGV4cGVjdGVkIDYxDQo+IA0KDQpMb29rcyBsaWtlIHRoZSBTUEkgY29tbXVuaWNh
dGlvbiBpc24ndCB3b3JraW5nLiBBdCB0aGlzIHBvaW50IEknZCBjaGVjayANCnRoZSB3aXJlcyB1
c2luZyBhbiBvc2NpbG9zY29wZSBvciBhbmFseXplciBvciBzb21ldGhpbmcuDQoNCg0KPiBJIGFs
c28gdHJpZWQgYnlwYXNzaW5nIHRoaXMgYnkgcmVtb3ZpbmcgdGhlIGZvbGxvd2luZyBzbmlwcGV0
IGFuZCBmb3JjZQ0KPiByZWdpc3RyYXRpb24gdG8gc2VlIHdoYXQgaGFwcGVucyBuZXh0Og0KPiAN
Cj4gICA+ICsgICAgIHJldCA9IHJlZ21hcF93cml0ZShyZWdtYXAsIEJNRTY4MF9SRUdfU09GVF9S
RVNFVCwNCj4gICA+ICsgICAgICAgICAgICAgICAgICAgICAgICBCTUU2ODBfQ01EX1NPRlRSRVNF
VCk7DQo+ICAgPiArICAgICBpZiAocmV0IDwgMCkgew0KPiAgID4gKyAgICAgICAgICAgICBkZXZf
ZXJyKGRldiwgIkZhaWxlZCB0byByZXNldCBjaGlwXG4iKTsNCj4gICA+ICsgICAgICAgICAgICAg
cmV0dXJuIHJldDsNCj4gICA+ICsgICAgIH0NCj4gICA+ICsNCj4gICA+ICsgICAgIHJldCA9IHJl
Z21hcF9yZWFkKHJlZ21hcCwgQk1FNjgwX1JFR19DSElQX0lELCAmdmFsKTsNCj4gICA+ICsgICAg
IGlmIChyZXQgPCAwKSB7DQo+ICAgPiArICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiRXJyb3Ig
cmVhZGluZyBjaGlwIElEXG4iKTsNCj4gICA+ICsgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4g
ICA+ICsgICAgIH0NCj4gICA+ICsNCj4gICA+ICsgICAgIGlmICh2YWwgIT0gQk1FNjgwX0NISVBf
SURfVkFMKSB7DQo+ICAgPiArICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiV3JvbmcgY2hpcCBJ
RCwgZ290ICV4IGV4cGVjdGVkICV4XG4iLA0KPiAgID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdmFsLCBCTUU2ODBfQ0hJUF9JRF9WQUwpOw0KPiAgID4gKyAgICAgICAgICAgICByZXR1
cm4gLUVOT0RFVjsNCj4gICA+ICsgICAgIH0NCj4gICA+ICsNCj4gDQo+IEFuZCBpdCByZWdpc3Rl
cmVkIHN1Y2Nlc3NmdWxseSwgYnV0IGFsbCB0aGUgYm1lNjgwIGF0dHJpYnV0ZXMgd2VyZQ0KPiBn
aXZpbmcgd3JvbmcgdmFsdWVzIGxpa2UgdGVtcCB3YXMgY29uc3RhbnQgdG8gMC4wMDAwMDA3LCBy
ZXNpc3RhbmNlDQo+IHdhcyByZXNvdXJjZSBidXN5IGR1ZSB0byBpbnN1ZmZpZW50IHRhcmdldCB0
ZW1wZXJhdHVyZSBlcnJvci4NCj4gUHJldHR5IGV2ZXl0aGluZyB3YXMgbWVzc2VkIHVwIGF0IHRo
aXMgc3RhZ2UuDQoNCk1ha2VzIHBlcmZlY3Qgc2Vuc2UgaWYgaXQncyB1bmFibGUgdG8gcmVhZCB0
aGUgcmVnaXN0ZXJzLg0KDQpJZiB5b3UgY2Fubm90IHJlYWQgdGhlIGNoaXAgSUQsIG5vdGhpbmcg
d2lsbCB3b3JrLCBubyBwb2ludCBza2lwcGluZyB0aGF0Lg0KDQo+IFRoZW4gSSBidWlsZCBhbmQg
Ym9vdGVkIHRoZSBrZXJuZWwgb24gQmVhZ2xlQm9uZSBCbGFjayBXaXJlbGVzcyB3aXRoDQo+IERU
IG1hdGNoaW5nIHRoaXMgdGltZToNCj4gDQo+IGRlYmlhbkBiZWFnbGVib25lOn4kIHVuYW1lIC1h
DQo+IExpbnV4IGJlYWdsZWJvbmUgNC4xOS41LXRpLXI1ICMxeHJvc3MgU01QIFBSRUVNUFQgU2F0
IE1hciAxNiAxMjoxMTo1MCBJU1QgMjAxOSBhcm12N2wgR05VL0xpbnV4DQo+IGRlYmlhbkBiZWFn
bGVib25lOn4kIGRtZXNnIHwgZ3JlcCAnYm1lNjgwJw0KPiBbICAgMzAuMjY5MjA3XSBibWU2ODBf
c3BpIHNwaTAuMDogV3JvbmcgY2hpcCBJRCwgZ290IGZmIGV4cGVjdGVkIDYxDQo+IFsgIDM2MS44
Njc0MTBdIGJtZTY4MF9jb3JlOiBkaXNhZ3JlZXMgYWJvdXQgdmVyc2lvbiBvZiBzeW1ib2wgbW9k
dWxlX2xheW91dA0KDQpMb29rcyBsaWtlIGEgY29tcGlsYXRpb24gcHJvYmxlbSB3aXRoIHlvdXIg
a2VybmVsIG1vZHVsZT8NCg0KPiBkZWJpYW5AYmVhZ2xlYm9uZTp+JCBsc21vZCB8IGdyZXAgJ2Jt
ZScNCj4gYm1lNjgwX3NwaSAgICAgICAgICAgICAxNjM4NCAgMA0KPiBibWU2ODBfY29yZSAgICAg
ICAgICAgIDIwNDgwICAxIGJtZTY4MF9zcGkNCj4gZGViaWFuQGJlYWdsZWJvbmU6fiQgY2F0IC9z
eXMvYnVzL3NwaS9kZXZpY2VzL3NwaTAuMC8NCj4gbW9kYWxpYXMgICAgb2Zfbm9kZS8gICAgcG93
ZXIvICAgICAgc3RhdGlzdGljcy8gc3Vic3lzdGVtLyAgdWV2ZW50DQo+IGRlYmlhbkBiZWFnbGVi
b25lOn4kIGNhdCAvc3lzL2J1cy9zcGkvZGV2aWNlcy9zcGkwLjAvbW9kYWxpYXMNCj4gc3BpOmJt
ZTY4MA0KPiBkZWJpYW5AYmVhZ2xlYm9uZTp+JCBjYXQgL3N5cy9idXMvc3BpL2RldmljZXMvc3Bp
MC4wL29mX25vZGUvDQo+IGNvbXBhdGlibGUgICAgICAgICBuYW1lICAgICAgICAgICAgICAgcmVn
ICAgICAgICAgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5DQo+IGRlYmlhbkBiZWFnbGVib25lOn4k
IGNhdCAvc3lzL2J1cy9zcGkvZGV2aWNlcy9zcGkwLjAvb2Zfbm9kZS9jb21wYXRpYmxlDQo+IGJt
ZTY4MA0KPiBkZWJpYW5AYmVhZ2xlYm9uZTp+JCBjYXQgL3N5cy9idXMvc3BpL2RldmljZXMvc3Bp
MC4wL29mX25vZGUvbmFtZQ0KPiBibWU2ODANCj4gZGViaWFuQGJlYWdsZWJvbmU6fiQgZHRjIC1m
IC1JIGZzIC9wcm9jL2RldmljZS10cmVlIHwgZ3JlcCAtQTMgJ2JtZTY4MCcNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgIGJtZTY4MEAwIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJibWU2ODAiOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByZWcgPSA8MHgwPjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c3BpLW1heC1mcmVxdWVuY3kgPSA8MHg5ODk2ODA+Ow0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgfTsNCj4gDQo+IFNhbWUgZXJyb3IgYWdhaW4hDQo+IA0KPiBJIHJlYWxseSBkb24ndCBrbm93
IHdoZXJlIHRoZSBwcm9ibGVtIGlzIGFuZCBob3cgdG8gcmVjdGlmeSA/DQo+IA0KPiBPVE9ILCBJ
MkMgd29ya3MgbGlrZSBhIGNoYXJtIGFzIGl0IHVzZWQgdG8gd29yayBiZWZvcmU6DQoNClRoYXQn
cyByZWFzc3VyaW5nLCBnb29kIHRvIGtub3cgaSBkaWRuJ3Qga2lsbCB0aGF0IHBhcnQuDQoNCj4g
DQo+IHJvb3RAYmVhZ2xlYm9uZTovc3lzL2J1cy9paW8vZGV2aWNlcy9paW86ZGV2aWNlMSMgY2F0
IG5hbWUgaW5fdGVtcF9pbnB1dCBcDQo+IGluX3ByZXNzdXJlX2lucHV0IGluX2h1bWlkaXR5cmVs
YXRpdmVfaW5wdXQgaW5fcmVzaXN0YW5jZV9pbnB1dA0KPiANCj4gYm1lNjgwDQo+IDI2ODYwIC0t
PiB3L28geW91ciBwYXRjaCBpdCB1c2VkIHRvIGJlIDI2Ljg2MDAwIGRlZ0MNCj4gOTkwLjg3MDAw
MDAwMA0KPiA1NS4yNjUwMDAwMDANCj4gMTAwOTENCj4gDQo+IA0KPiBJJ20gc3RpbGwgYXNzdW1p
bmcgdGhhdCB0aGVyZSBpcyBzb21lIHByb2JsZW0gb24gbXkgc2lkZSwgYXMgaXQgd29ya3MNCj4g
Zmxhd2xlc3MgZm9yIHlvdS4gQnV0IGl0IGlzIHJlYWxseSBkaWZmaWN1bHQgZm9yIG1lIHRvIGZp
Z3VyZSBvdXQNCj4gZXhhY3RseSB3aGVyZSB0aGUgcHJvYmxlbSBjb3VsZCBiZSENCg0KSSB3b3Vs
ZCBub3QgZ28gYXMgZmFyIGFzIGNhbGxpbmcgaXQgImZsYXdsZXNzIi4gVGhlICJyZXNpc3RhbmNl
IiANCm1lYXN1cmVtZW50IHVzdWFsbHkgZmFpbHMgYSBmZXcgdGltZXMsIGFuZCB0aGUgY2FsaWJy
YXRpb24gdmFsdWVzIGFyZW4ndCANCmF2YWlsYWJsZSBhdCB0aGUgZmlyc3QgcmVhZCBhcHBhcmVu
dGx5LiBBZnRlciByZWFkaW5nIHRoZSB2YWx1ZXMgDQptdWx0aXBsZSB0aW1lcyAoaGludDogImdy
ZXAgLiAqIiBpcyByZWFsbHkgbmljZSBmb3Igc2hvd2luZyBmaWxlIA0KY29udGVudHMgaW4gYSBz
eXNmcyBkaXJlY3RvcnkpIHRoZSBjaGlwIGFwcGVhcnMgdG8gZnVuY3Rpb24gb2theS4gVGhhdCdz
IA0Kd2hhdCBteSBsYXN0IGNvbW1pdCBwYXJhZ3JhcGggd2FzIGV4cGxhaW5pbmcuDQoNCkl0J3Mg
YSBiaWcgaW1wcm92ZW1lbnQgb3ZlciB0aGUgcHJldmlvdXMgdmVyc2lvbiB3aGVyZSB0aGUgU1BJ
IGludGVyZmFjZSANCndvdWxkbid0IHdvcmsgYXQgYWxsLg0KDQotLSANCk1pa2UgTG9vaWptYW5z
DQo=
