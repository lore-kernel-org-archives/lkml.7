Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B50C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DA7204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="ry7llDxt";
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="ry7llDxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfF0Li2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 07:38:28 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:64222
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbfF0Li1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector1-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXJ9l2jRAtrc1nz8fSvHIKoZeUbPToJ4bn72k1rboAE=;
 b=ry7llDxtpgxOYDnYzQ541Sj1M1TzbccRRXZgEk4uCMfrsJ+yyyKLJL7KBUOAb8OdD4++UAwBuotXQ+ZYWcZMgjCtGFV57usSJA+vHF+4SkL3drQWJ9IpXOzhe2KOa+0ZarCebS4eGcayPD3lyukKuZ5vL/pVQIgm74ZSvoCazcY=
Received: from VI1PR04CA0118.eurprd04.prod.outlook.com (2603:10a6:803:f0::16)
 by AM6PR04MB4037.eurprd04.prod.outlook.com (2603:10a6:209:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Thu, 27 Jun
 2019 11:38:20 +0000
Received: from VE1EUR01FT050.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e01::200) by VI1PR04CA0118.outlook.office365.com
 (2603:10a6:803:f0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Thu, 27 Jun 2019 11:38:20 +0000
Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; vger.kernel.org; dkim=pass (signature was
 verified) header.d=topicbv.onmicrosoft.com;vger.kernel.org; dmarc=none
 action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 VE1EUR01FT050.mail.protection.outlook.com (10.152.3.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Thu, 27 Jun 2019 11:38:19 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (104.47.4.51) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 27 Jun 2019 11:38:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=TXTkL2//95bXrUjBGjsE6ACrQ8xvESZ2XsL1f+oCv5JbuUy5UrJZEgjda0NM2FOYVqjATystNmKUMiNKj2XiTV3JNFRyKqY29wq4tXOvE6ahnzzGKtKOYLGE1YaCTQkQDV9bXlXqz64pRyMsnEqBXv2El2qUMIw7czLM2cax0K0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXJ9l2jRAtrc1nz8fSvHIKoZeUbPToJ4bn72k1rboAE=;
 b=ebRePG1aAXmICWdkAp6JpUQY71fKhoLtH4woqADmRbAQjtXFqNsXnYytL6B/SLc/fU/m/xq33H/gsWAn4KLy9JZL9lus9+Bu19S9qhJOQXCFnZ/k1fJJRoX2KZ+dwbV5qz+Q2hz8LAGjrZYmLkAcibq/r/0eV8H1EKhWP004CNQ=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector1-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXJ9l2jRAtrc1nz8fSvHIKoZeUbPToJ4bn72k1rboAE=;
 b=ry7llDxtpgxOYDnYzQ541Sj1M1TzbccRRXZgEk4uCMfrsJ+yyyKLJL7KBUOAb8OdD4++UAwBuotXQ+ZYWcZMgjCtGFV57usSJA+vHF+4SkL3drQWJ9IpXOzhe2KOa+0ZarCebS4eGcayPD3lyukKuZ5vL/pVQIgm74ZSvoCazcY=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (10.255.168.18) by
 AM6PR04MB4664.eurprd04.prod.outlook.com (20.177.38.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Thu, 27 Jun 2019 11:38:16 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d131:60b8:d270:2d31]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d131:60b8:d270:2d31%3]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 11:38:16 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     Stephen Boyd <sboyd@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: Add silabs,si5341
Thread-Topic: [PATCH] dt-bindings: Add silabs,si5341
Thread-Index: AQHU+nxyYxvizl1WFEGuRTW/KPv/CaZNgWQAgACChACAASu8AIAAlo8AgAQY7ACAAe53AIBZCGsAgADuo4A=
Date:   Thu, 27 Jun 2019 11:38:16 +0000
Message-ID: <61fae574-2cea-cbdc-bc8a-3cc34c681d01@topic.nl>
References: <20190424090216.18417-1-mike.looijmans@topic.nl>
 <155623344648.15276.18213024444708122458@swboyd.mtv.corp.google.com>
 <3ea2d720-f49b-586c-e402-07db289b39a8@topic.nl>
 <155632584222.168659.9675557812377718927@swboyd.mtv.corp.google.com>
 <cd52a35b-d289-24e1-70db-9d63fd9f6448@topic.nl>
 <155658342800.168659.4922821141203707564@swboyd.mtv.corp.google.com>
 <c7f5184f-f484-e8ad-33ae-36b0da061113@topic.nl>
 <20190626212409.9C0E6208E3@mail.kernel.org>
In-Reply-To: <20190626212409.9C0E6208E3@mail.kernel.org>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-clientproxiedby: AM4PR08CA0065.eurprd08.prod.outlook.com
 (2603:10a6:205:2::36) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d9::18)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.173.50.109]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 80713586-9a57-4feb-4831-08d6faf3f441
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR04MB4664;
X-MS-TrafficTypeDiagnostic: AM6PR04MB4664:|AM6PR04MB4037:
X-Microsoft-Antispam-PRVS: <AM6PR04MB40372CB0909AAA056B21ABC896FD0@AM6PR04MB4037.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 008184426E
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(346002)(396003)(39840400004)(366004)(376002)(136003)(43544003)(189003)(199004)(73956011)(68736007)(65956001)(2906002)(4326008)(64756008)(66556008)(66446008)(31686004)(65826007)(99286004)(65806001)(8676002)(6436002)(229853002)(53936002)(31696002)(66476007)(66066001)(66946007)(486006)(386003)(6506007)(44832011)(14454004)(64126003)(476003)(54906003)(36756003)(102836004)(2501003)(110136005)(25786009)(5660300002)(76176011)(6246003)(81156014)(6512007)(8936002)(446003)(52116002)(71190400001)(316002)(2616005)(53546011)(11346002)(508600001)(14444005)(26005)(3846002)(42882007)(186003)(74482002)(81166006)(7736002)(305945005)(6116002)(6486002)(256004)(71200400001)(58126008)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4664;H:AM6PR04MB6341.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 5jaF0uCqsNxluwMtropuFeDwfA05wEmuoYbILtmG/DBEPimojqYBPcyb46+pmMrGXV0GKP3+wkfjEK0agDCH5tzOPxkS6DhHUFL1+ybyhzZbp0V0SBavR/2I+kmqFKZIle0l/zQ9n0sX4pUBFJjgRaI3oO6Pe7y3OM7a/G7bsQ5M4H8IkzueYq7GY8jRjjww/gV4AJ8+fllooIQsP/xcDfuWDrP1zoKGsUl7X1IDJ9TvluQJlh/TVVIH+qTX2C0CIzAXh0yK1oAyui8vHxJtZZoDLQbuFcffxfx4H1Rn3+v10TMT1ZTMPyP/rnvHUiBmipZuN7jQ7T37UJZwsCfET8W0NVWPTXMDj6PQ/17bCYeaCqF1k9XvkLRWPiXzCJa0MYBYAcNrC/vMzpfAvDi+VsQgAz5SNzqMo3QN9sEqo30=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0C58822B8E2B2438EA2A31B77E0D801@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4664
X-CodeTwo-MessageID: 20190627113818.75a4927f-f304-42ec-8083-13afc6c38f6c@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT050.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:40.68.112.65;IPV:NLI;CTRY:NL;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39840400004)(2980300002)(43544003)(199004)(189003)(64126003)(246002)(26005)(305945005)(6506007)(11346002)(7736002)(6246003)(23676004)(7596002)(2906002)(76176011)(386003)(6486002)(47776003)(53546011)(2486003)(6512007)(186003)(74482002)(8936002)(4326008)(31696002)(7636002)(229853002)(508600001)(31686004)(2501003)(446003)(102836004)(44832011)(65956001)(8676002)(99286004)(316002)(6116002)(126002)(50466002)(476003)(2616005)(70206006)(65826007)(25786009)(486006)(5660300002)(66066001)(336012)(14444005)(54906003)(356004)(42882007)(106002)(110136005)(3846002)(14454004)(58126008)(70586007)(36756003)(65806001)(436003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4037;H:westeu12-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:westeu12-emailsignatures-cloud.codetwo.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0b3aadc7-ba7a-4879-a5e1-08d6faf3f202
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR04MB4037;
X-Forefront-PRVS: 008184426E
X-Microsoft-Antispam-Message-Info: w2YDZKKyc03LybHNYIZAsawfXKZjeepygH7uq27Y2NQx22VGnkpWP8HZGXZSmw49NUqbJV9wV3coh6V8AzwR3SDwpdMNI2o12paknsziuhBYYGgeyT3r53TlXoXK03spAYRIThMEjM0zBu65VftPid6ZwfCHoDSUdUQPuwLpZPisMNW2jRpEzSp2s4sdbaRNj2jGX+SboldMt7POGPcUE9S0yUc1WAgYahqkpcFoLdj/R7v+swQOn7YmZfLL/AIgOg2+KQm+GCuvCZZWrx5jpUYLO036njD4YM8v5OexKeWp3rCcEf0pzytXX+JYOdQUCcFCgmVlXffXaE+t1XBcK4Z9UPc1vD4o11uS61OpK43aVE0PZzORJXYqqX1sMp6JTFkW+hG3QXE9KuRhm+zu1jLwEvEyDS/qfuIX2EM3m28=
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2019 11:38:19.7546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80713586-9a57-4feb-4831-08d6faf3f441
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYtMDYtMTkgMjM6MjQsIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4gU29ycnksIEknbSBnZXR0
aW5nIHRocm91Z2ggbXkgaW5ib3ggcGlsZSBhbmQgc2F3IHRoaXMgb25lLg0KPiANCj4gUXVvdGlu
ZyBNaWtlIExvb2lqbWFucyAoMjAxOS0wNC0zMCAyMjo0Njo1NSkNCj4+IE9uIDMwLTA0LTE5IDAy
OjE3LCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+Pj4NCj4+PiBXaHkgY2FuJ3QgdGhhdCBkcml2ZXIg
Y2FsbCBjbGtfcHJlcGFyZV9lbmFibGUoKT8gSXMgdGhlcmUgc29tZSBzb3J0IG9mDQo+Pj4gYXNz
dW1wdGlvbiB0aGF0IHRoaXMgY2xrIHdpbGwgYWx3YXlzIGJlIGVuYWJsZWQgYW5kIG5vdCBoYXZl
IGEgZHJpdmVyDQo+Pj4gdGhhdCBjb25maWd1cmVzIHRoZSByYXRlIGFuZCBnYXRlcy91bmdhdGVz
IGl0Pw0KPj4NCj4+IE5vdCBvbmx5IGNsa19wcmVwYXJlX2VuYWJsZSgpLCBidXQgdGhlIGRyaXZl
ciBjb3VsZCBhbHNvIGNhbGwgY2xrX3NldF9yYXRlKCkNCj4+IGFuZCBjbGtfc2V0X3BhcmVudCgp
IGFuZCB0aGUgbGlrZXMsIGJ1dCBpdCBkb2Vzbid0LCBzbyB0aGF0J3Mgd2h5IHRoZXJlIGlzDQo+
PiAiYXNzaWduZWQtY2xvY2tzIiByaWdodD8NCj4+DQo+PiBUaGVyZSBhcmUgbXVsdGlwbGUgc2Nl
bmFyaW8ncywgc2ltaWxhciB0byB3aHkgcmVndWxhdG9ycyBhbHNvIGhhdmUgcHJvcGVydGllcw0K
Pj4gbGlrZSB0aGVzZS4NCj4+DQo+PiAtIFRoZSBjbG9jayBpcyByZWxhdGVkIHRvIGhhcmR3YXJl
IHRoYXQgdGhlIGtlcm5lbCBpcyBub3QgYXdhcmUgb2YuDQo+PiAtIFRoZSBjbG9jayBpcyBmb3Ig
YSBkcml2ZXIgdGhhdCBpc24ndCBhd2FyZSBvZiBpdHMgY2xvY2sgcmVxdWlyZW1lbnRzLiBJdA0K
Pj4gbWlnaHQgYmUgYW4gZXh0cmEgY2xvY2sgZm9yIGFuIEZQR0EgaW1wbGVtZW50ZWQgY29udHJv
bGxlciB0aGF0IG1pbWljcw0KPj4gZXhpc3RpbmcgaGFyZHdhcmUuDQo+IA0KPiBBcmUgdGhlc2Ug
aHlwb3RoZXRpY2FsIHNjZW5hcmlvcyBvciBhY3R1YWwgc2NlbmFyaW9zIHlvdSBuZWVkIHRvDQo+
IHN1cHBvcnQ/DQoNCkFjdHVhbCBzY2VuYXJpbydzLg0KDQpDbG9ja3MgYXJlIHJlcXVpcmVkIGZv
ciBGUEdBIGxvZ2ljLCBhbmQgYSBzb21lIG9mIHRob3NlIGRvIG5vdCBpbnZvbHZlIA0Kc29mdHdh
cmUgZHJpdmVycyBhdCBhbGwuDQoNClRoZSBHVFIgdHJhbnNjZWl2ZXJzIG9uIHRoZSBYaWxpbngg
WnlucU1QIGNoaXBzIHVzZSB0aGVzZSBjbG9ja3MgZm9yIFNBVEEgYW5kIA0KUENJZSwgYnV0IHRo
ZSBkcml2ZXIgaW1wbGVtZW50YXRpb24gZnJvbSBYaWxpbnggZm9yIHRoZXNlIGlzIGZhciBmcm9t
IG1hdHVyZSwgDQpmb3IgZXhhbXBsZSBpdCBwYXNzZXMgdGhlIGNsb2NrIGZyZXF1ZW5jeSBhcyBh
IFBIWSBwYXJhbWV0ZXIgYW5kIGlzbid0IGV2ZW4gDQphd2FyZSBvZiB0aGUgY2xrIGZyYW1ld29y
ayBhdCB0aGUgbW9tZW50LiBYaWxpbnggaGFzbid0IGV2ZW4gYXR0ZW1wdGVkIA0Kc3VibWl0dGlu
ZyB0aGlzIDMgeWVhciBvbGQgZHJpdmVyIHRvIG1haW5saW5lLg0KDQoNCj4+IEknZCBhbHNvIGNv
bnNpZGVyIHBhdGNoaW5nICJhc3NpZ25lZC1jbG9ja3MiIHRvIGNhbGwgImNsa19wcmVwYXJlX2Vu
YWJsZSgpIiwNCj4+IHdvdWxkIHRoYXQgbWFrZSBzZW5zZSwgb3IgaXMgaXQgaW50ZW50aW9uYWwg
dGhhdCBhc3NpZ25lZC1jbG9ja3MgZG9lc24ndCBkbyB0aGF0Pw0KPj4NCj4gDQo+IEl0J3MgaW50
ZW50aW9uYWwgdGhhdCBhc3NpZ25lZC1jbG9ja3MgZG9lc24ndCByZWFsbHkgZG8gYW55dGhpbmcg
YmVzaWRlcw0KPiBzZXR1cCB0aGUgbGlzdCBvZiBjbGtzIHRvIG9wZXJhdGUgb24gd2l0aCB0aGUg
cmF0ZSBvciBwYXJlbnQgc2V0dGluZ3MNCj4gc3BlY2lmaWVkIGluIG90aGVyIHByb3BlcnRpZXMu
IFdlIHdvdWxkIG5lZWQgdG8gYWRkIGFub3RoZXIgcHJvcGVydHkNCj4gaW5kaWNhdGluZyB3aGlj
aCBjbGtzIHdlIHdhbnQgdG8gbWFyayBhcyAnY3JpdGljYWwnIG9yICdhbHdheXMtb24nLg0KPiAN
Cj4gVGhlcmUgaGF2ZSBiZWVuIHByaW9yIGRpc2N1c3Npb25zIHdoZXJlIHdlIGhhZCBkZXZlbG9w
ZXJzIHdhbnQgdG8gbWFyaw0KPiBjbGtzIHdpdGggdGhlIENMS19JU19DUklUSUNBTCBmbGFnIGZy
b20gRFQsIGJ1dCB3ZSBmZWx0IGxpa2UgdGhhdCB3YXMNCj4gcHV0dGluZyBTb0MgbGV2ZWwgZGV0
YWlscyBpbnRvIHRoZSBEVC4gV2hpbGUgdGhhdCB3YXMgY29ycmVjdCBmb3IgU29DDQo+IHNwZWNp
ZmljIGNsayBkcml2ZXJzLCBJIGNhbiBzZWUgYm9hcmQgZGVzaWducyB3aGVyZSBpdCdzIGNvbmZp
Z3VyYWJsZQ0KPiBhbmQgd2Ugd2FudCB0byBleHByZXNzIHRoYXQgYSBib2FyZCBoYXMgc29tZSBj
bGtzIHRoYXQgbXVzdCBiZSBlbmFibGVkDQo+IGVhcmx5IG9uIGFuZCBsZWZ0IGVuYWJsZWQgZm9y
ZXZlciBiZWNhdXNlIHRoZSBoYXJkd2FyZSBlbmdpbmVlciBoYXMNCj4gZGVzaWduIHRoZSBib2Fy
ZCB0aGF0IHdheS4gSW4gdGhpcyBjYXNlLCBtYXJraW5nIHRoZSBjbGsgd2l0aCB0aGUNCj4gQ0xL
X0lTX0NSSVRJQ0FMIGZsYWcgbmVlZHMgdG8gYmUgZG9uZSBmcm9tIERULg0KPiANCj4gSW4gZmFj
dCwgd2UgcHJldHR5IG11Y2ggYWxyZWFkeSBoYXZlIHN1cHBvcnQgZm9yIHRoaXMgd2l0aA0KPiBv
Zl9jbGtfZGV0ZWN0X2NyaXRpY2FsKCkuIE1heWJlIHdlIHNob3VsZCByZS11c2UgdGhhdCBiaW5k
aW5nIHdpdGgNCj4gJ2Nsb2NrLWNyaXRpY2FsJyB0byBsZXQgY2xrIHByb3ZpZGVycyBpbmRpY2F0
ZSB0aGF0IHRoZXkgaGF2ZSBzb21lIGNsa3MNCj4gdGhhdCBzaG91bGQgYmUgbWFya2VkIGNyaXRp
Y2FsIG9uY2UgdGhleSdyZSByZWdpc3RlcmVkLiBXZSBjb3VsZA0KPiBwcm9iYWJseSBhZGQgYW5v
dGhlciBwcm9wZXJ0eSB0b28gdGhhdCBpbmRpY2F0ZXMgY2VydGFpbiBjbGtzIGFyZQ0KPiBlbmFi
bGVkIG91dCBvZiB0aGUgYm9vdGxvYWRlciwgc2ltaWxhciB0byB0aGUgcmVndWxhdG9yLWJvb3Qt
b24NCj4gcHJvcGVydHksIGJ1dCB3aGVyZSBpdCB0YWtlcyBhIGNsb2NrLWNlbGxzIHdpZGUgbGlz
dCBmb3IgdGhlIHByb3ZpZGVyDQo+IHRoZSBwcm9wZXJ0eSBpcyBpbnNpZGUgb2YuDQo+IA0KPiBX
ZSBuZWVkIHRvIGJlIGNhcmVmdWwgdGhvdWdoIGFuZCBtYWtlIHN1cmUgdGhhdCBjbGsgZHJpdmVy
cyBkb24ndCBzdGFydA0KPiBwdXR0aW5nIGV2ZXJ5dGhpbmcgaW4gRFQuIEluIHlvdXIgZXhhbXBs
ZSwgaXQgc291bmRzIGxpa2UgeW91IGhhdmUgYQ0KPiBjb25zdW1lciBkcml2ZXIgdGhhdCB3YW50
cyB0byBtYWtlIHN1cmUgdGhlIGNsayBpcyBwcmVwYXJlZCBvciBlbmFibGVkDQo+IHdoZW4gdGhl
IGNvbnN1bWVyIHByb2Jlcy4gSW4gdGhpcyBjYXNlIHRoZSBwcmVwYXJlL2VuYWJsZSBjYWxscyBz
aG91bGQNCj4gYmUgcHV0IGRpcmVjdGx5IGludG8gdGhlIGNvbnN1bWVyIGRyaXZlciBzbyBpdCBj
YW4gbWFuYWdlIHRoZSBjbGsgc3RhdGUuDQo+IEZvciB0aGUgY2FzZSBvZiByYXRlcyBhbmQgcGFy
ZW50cywgaXQncyBlc3NlbnRpYWxseSBhIG9uZXNob3QNCj4gY29uZmlndXJhdGlvbiBvZiB0aGUg
cmF0ZSBvciB0aGUgcGFyZW50cyBvZiBhIGNsay4gV2UgZG9uJ3QgbmVlZCB0bw0KPiAidW5kbyIg
dGhlIGNvbmZpZ3VyYXRpb24gd2hlbiB0aGUgZGV2aWNlIGRyaXZlciBpcyByZW1vdmVkLiBGb3Ig
cHJlcGFyZQ0KPiBhbmQgZW5hYmxlIHRob3VnaCwgd2UgdHlwaWNhbGx5IHdhbnQgdG8gZGlzYWJs
ZSBjbGtzIHdoZW4gdGhlIGhhcmR3YXJlDQo+IGlzIG5vdCBpbiB1c2UgdG8gc2F2ZSBwb3dlci4g
QWRkaW5nIGEgcHJvcGVydHkgdG8gRFQgc2hvdWxkIG9ubHkgYmUgZG9uZQ0KPiB0byBpbmRpY2F0
ZSBhIGNsayBtdXN0IGFsd2F5cyBiZSBvbiBpbiB0aGlzIGJvYXJkIGNvbmZpZ3VyYXRpb24sIG5v
dCB0bw0KPiBhdm9pZCBjYWxsaW5nIGNsa19wcmVwYXJlX2VuYWJsZSgpIGluIHRoZSBkcml2ZXIg
cHJvYmUuDQo+IA0KPiBUbyBwdXQgaXQgYW5vdGhlciB3YXksIEknbSBsb29raW5nIHRvIGRlc2Ny
aWJlIGhvdyB0aGUgYm9hcmQgaXMgZGVzaWduZWQNCj4gYW5kIHRvIGluZGljYXRlIHRoYXQgY2Vy
dGFpbiBjbGtzIGFyZSBhbHdheXMgZW5hYmxlZCBhdCBwb3dlciBvbiBvciBhcmUNCj4gZW5hYmxl
ZCBieSB0aGUgYm9vdGxvYWRlci4gQ29uZmlndXJhdGlvbiBoYXMgaXQncyBwbGFjZSB0b28sIGp1
c3QgdGhhdA0KPiBjb25maWd1cmF0aW9uIGlzIGEgb25lc2hvdCBzb3J0IG9mIHRoaW5nIHRoYXQg
bmV2ZXIgbmVlZHMgdG8gY2hhbmdlIGF0DQo+IHJ1bnRpbWUuDQo+IA0KDQpJIGNhbiBzZWUgd2hl
cmUgeW91IGdvaW5nIHdpdGggdGhpcywgYW5kIHllcywgd2UgZGVmaW5pdGVseSBzaG91bGQgcHJv
bW90ZSANCnRoYXQgZHJpdmVycyBzaG91bGQgdGFrZSBjYXJlIG9mIHRoZWlyIGNsb2NrIChlbmFi
bGUpIHJlcXVpcmVtZW50cy4NCg0KRm9yIHRoZSBjYXNlIG9mICdjbG9jay1jcml0aWNhbCcsIHRo
YXQgd291bGQgc2VydmUgdGhlIHB1cnBvc2UgcXVpdGUgd2VsbCANCmluZGVlZC4gSXQgZG9lcyBh
ZGQgdGhlIHJpc2sgb2YgcGVvcGxlIHNwcmlua2xpbmcgdGhhdCBhbGwgb3ZlciB0aGUgZGV2aWNl
dHJlZS4NCg0KU2hvcnQgdGVybSwgSSBndWVzcyB0aGUgYmVzdCB0aGluZyB0byBkbyBoZXJlIGlz
IHRvIHJlbW92ZSB0aGUgImFsd2F5cy1vbiIgDQpwcm9wZXJ0eSBmcm9tIG15IHBhdGNoLg0KDQpJ
J2xsIHB1dCB0aGUgImNsb2NrLWNyaXRpY2FsIiBpZGVhIG9uIG15IGxpc3Qgb2YgZ2VuZXJpYyBj
bG9jayBwYXRjaGVzIHRvIA0Kc25lYWsgaW4gb24gb3RoZXIgYnVkZ2V0cywgaXQnbGwgYmUgcmln
aHQgYmVoaW5kICJhbGxvdyBzdWItMUh6IG9yIGZyYWN0aW9uYWwgDQpjbG9jayByYXRlIGFjY3Vy
YWN5IiAoeWVzIEkgYWN0dWFsbHkgaGF2ZSBhIHVzZSBjYXNlIGZvciB0aGF0KSBhbmQgImFsbG93
IA0KZnJlcXVlbmNpZXMgb3ZlciA0R0h6IiAodGhlIDE0R0h6IGNsb2NrIGluIHRoZSBTaTUzNDEg
bHVja2lseSBpc24ndCBhdmFpbGFibGUgDQpvbiB0aGUgb3V0c2lkZSBzbyBJIGNhbiBjaGVhdCku
Li4NCg==
