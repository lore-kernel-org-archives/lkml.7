Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07A0C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 05:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D18521734
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 05:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="gLnm9/SD";
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="gLnm9/SD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfEAFrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 01:47:12 -0400
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:41475
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbfEAFrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 01:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector1-TopicProducts-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLvYGUOhj788W9JG50EMK2htvNdJAQPXfV1Ht+8Lb28=;
 b=gLnm9/SD+1NgTPR7xdg6spqK8jGA2G8WTESPLrCCudty0M4kplrjxzm7uPx6ObEshqQuENBF+4WBcq/kqh43R42S9fxfnPN4JWLWhyyDiJ7JJk6GURDMFD2XHOvUP9QAoAXWmU3YrkBd4rUDWbrxhL69MoMi7UN/LsnkvNMvlkA=
Received: from HE1PR0401CA0072.eurprd04.prod.outlook.com (2603:10a6:3:19::40)
 by DB6PR0401MB2616.eurprd04.prod.outlook.com (2603:10a6:4:31::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1856.10; Wed, 1 May
 2019 05:47:01 +0000
Received: from HE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::205) by HE1PR0401CA0072.outlook.office365.com
 (2603:10a6:3:19::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.10 via Frontend
 Transport; Wed, 1 May 2019 05:47:01 +0000
Authentication-Results: spf=pass (sender IP is 52.166.56.231)
 smtp.mailfrom=topicproducts.com; vger.kernel.org; dkim=pass (signature was
 verified) header.d=topicbv.onmicrosoft.com;vger.kernel.org; dmarc=none
 action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 52.166.56.231 as permitted sender)
 receiver=protection.outlook.com; client-ip=52.166.56.231;
 helo=westeu11-emailsignatures-cloud.codetwo.com;
Received: from westeu11-emailsignatures-cloud.codetwo.com (52.166.56.231) by
 HE1EUR01FT011.mail.protection.outlook.com (10.152.0.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1835.14 via Frontend Transport; Wed, 1 May 2019 05:47:00 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.52) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 01 May 2019 05:46:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector1-TopicProducts-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLvYGUOhj788W9JG50EMK2htvNdJAQPXfV1Ht+8Lb28=;
 b=gLnm9/SD+1NgTPR7xdg6spqK8jGA2G8WTESPLrCCudty0M4kplrjxzm7uPx6ObEshqQuENBF+4WBcq/kqh43R42S9fxfnPN4JWLWhyyDiJ7JJk6GURDMFD2XHOvUP9QAoAXWmU3YrkBd4rUDWbrxhL69MoMi7UN/LsnkvNMvlkA=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (10.255.168.18) by
 AM6PR04MB5639.eurprd04.prod.outlook.com (20.179.0.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Wed, 1 May 2019 05:46:56 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::1c08:ee1b:f6a2:ded9]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::1c08:ee1b:f6a2:ded9%4]) with mapi id 15.20.1856.008; Wed, 1 May 2019
 05:46:56 +0000
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
Thread-Index: AQHU+nxyYxvizl1WFEGuRTW/KPv/CaZNgWQAgACChACAASu8AIAAlo8AgAQY7ACAAe53AA==
Date:   Wed, 1 May 2019 05:46:55 +0000
Message-ID: <c7f5184f-f484-e8ad-33ae-36b0da061113@topic.nl>
References: <20190424090216.18417-1-mike.looijmans@topic.nl>
 <155623344648.15276.18213024444708122458@swboyd.mtv.corp.google.com>
 <3ea2d720-f49b-586c-e402-07db289b39a8@topic.nl>
 <155632584222.168659.9675557812377718927@swboyd.mtv.corp.google.com>
 <cd52a35b-d289-24e1-70db-9d63fd9f6448@topic.nl>
 <155658342800.168659.4922821141203707564@swboyd.mtv.corp.google.com>
In-Reply-To: <155658342800.168659.4922821141203707564@swboyd.mtv.corp.google.com>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-clientproxiedby: AM0PR01CA0125.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::30) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d9::18)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.173.50.109]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 659d8a44-41b8-4d21-2029-08d6cdf86e71
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM6PR04MB5639;
X-MS-TrafficTypeDiagnostic: AM6PR04MB5639:|DB6PR0401MB2616:
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2616896981C72379DE846B37963B0@DB6PR0401MB2616.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 00246AB517
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(366004)(39840400004)(346002)(199004)(189003)(26005)(54906003)(4326008)(66946007)(6512007)(73956011)(14444005)(25786009)(42882007)(64756008)(256004)(66476007)(66556008)(74482002)(66446008)(102836004)(71200400001)(65826007)(5660300002)(71190400001)(31696002)(14454004)(53936002)(7736002)(6246003)(316002)(186003)(36756003)(508600001)(3846002)(44832011)(6506007)(305945005)(386003)(486006)(66066001)(53546011)(65956001)(65806001)(476003)(110136005)(68736007)(31686004)(6486002)(52116002)(229853002)(76176011)(58126008)(11346002)(446003)(2616005)(2501003)(6436002)(8936002)(64126003)(8676002)(2906002)(99286004)(81166006)(6116002)(81156014)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5639;H:AM6PR04MB6341.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: UWl2oRbQo7p8hwRBsAUD/X78pYaawgwdq6Jg/Zxt0F8C6JBY9y0OS7DYrpFIJMJQE19I2rZNUBYLjp3j+z1YQrb7A4lfUbt1lGuQ9qdaK5KIc8cYK7UOdjYfHKnLHXf8CnHjqwSPOH1+rHl4lOjZ9UhrjogzEPb1+LghGHPmInVr4d0rJ7KY+0d1shduJUkPRb3TBZTyeTVWo6dkUE7RWEA3X/0polZpr++LKUAtVKEE0+PZa2KJ5HTH5iSeDeMj1W/in4kawLOg8TIM5ukbSCLingM3snpOE83DkopWXBQeQdREonDmoGTEIaY1ufWSi+EAJVB210X5VQzfIYrSbWHLwizXXsxu3U1/d2ZC4l/N25UmNd4qsCn9nANHYIqFsbsr03vZO02BycXkD1i7vgBrUZzfPu67VFixZLl2eZs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32C2B3FF2E22AD4CA8DF503BA01496BD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5639
X-CodeTwo-MessageID: 20190501054658.6e717e8b-50b2-4dd6-b29d-6bac8bc63be5@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:52.166.56.231;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39840400004)(376002)(2980300002)(189003)(199004)(5660300002)(305945005)(7596002)(6486002)(6512007)(31696002)(76176011)(229853002)(7736002)(7636002)(50466002)(36756003)(2906002)(44832011)(58126008)(31686004)(336012)(2616005)(476003)(54906003)(42882007)(110136005)(446003)(316002)(11346002)(436003)(106002)(102836004)(386003)(6506007)(126002)(186003)(486006)(53546011)(26005)(4326008)(6246003)(25786009)(2486003)(74482002)(14454004)(6116002)(3846002)(246002)(65806001)(66066001)(47776003)(65956001)(99286004)(70206006)(2501003)(64126003)(508600001)(8676002)(356004)(8936002)(14444005)(65826007)(70586007)(23676004)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2616;H:westeu11-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:westeu11-emailsignatures-cloud.codetwo.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d7fae148-b7b9-4ef4-d12b-08d6cdf86b4b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(710020)(711020)(4605104)(2017052603328)(7193020);SRVR:DB6PR0401MB2616;
X-Forefront-PRVS: 00246AB517
X-Microsoft-Antispam-Message-Info: 39cTz87NjMaD/H8vm85PASViiqfEH9ThoSHCYagnLmck2BYMUsbbXK915Z+ftQ1Z6DVKpkpxIe5cuiawixroNZONVrqJ4evvjl/3l1L7QWtEbHkGd3k3xGbdciPlqDhYoH+EteTIh4GqmkGiT+OSz+g10CiczO3OF2lxRS2G55ERhmp1ZYmv90mBI/P6T0h82NjOIrCTXLi4xSb95sCPbj6+6yWLjW4buM9F4fTXEem5fpQW/X7Xis+gdZSE7IMhHf1ZjT3GvgXLqhRBrLqQj5V370eoCAVmeUKaltSOAPUWaT3f3fGOhtwclR4D/YHcWd6ykBdbrz/UnMV5NoAUmLz8FrQlZVX2GCESS7NM84s9BJLoC3vJOtAN1qUMFSTqxhUvzYGMXQrSH7uUHRD/7eWN6B8oH08lSPHlgEctHCM=
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2019 05:47:00.1719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 659d8a44-41b8-4d21-2029-08d6cdf86e71
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[52.166.56.231];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2616
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAtMDQtMTkgMDI6MTcsIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4gUXVvdGluZyBNaWtlIExv
b2lqbWFucyAoMjAxOS0wNC0yNyAwMjo0Mjo1NikNCj4+IE9uIDI3LTA0LTE5IDAyOjQ0LCBTdGVw
aGVuIEJveWQgd3JvdGU6DQo+Pj4gUXVvdGluZyBNaWtlIExvb2lqbWFucyAoMjAxOS0wNC0yNSAy
Mzo1MToxNSkNCj4+Pj4gT24gMjYtMDQtMTkgMDE6MDQsIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4+
Pj4+PiArDQo+Pj4+Pj4gK09wdGlvbmFsIHByb3BlcnRpZXM6DQo+Pj4+Pj4gKy0gc2lsYWJzLHBs
bC1tLW51bSwgc2lsYWJzLHBsbC1tLWRlbjogTnVtZXJhdG9yIGFuZCBkZW5vbWluYXRvciBmb3Ig
UExMDQo+Pj4+Pj4gKyAgZmVlZGJhY2sgZGl2aWRlci4gTXVzdCBiZSBzdWNoIHRoYXQgdGhlIFBM
TCBvdXRwdXQgaXMgaW4gdGhlIHZhbGlkIHJhbmdlLiBGb3INCj4+Pj4+PiArICBleGFtcGxlLCB0
byBjcmVhdGUgMTRHSHogZnJvbSBhIDQ4TUh6IHh0YWwsIHVzZSBtLW51bT0xNDAwMCBhbmQgbS1k
ZW49NDguIE9ubHkNCj4+Pj4+PiArICB0aGUgZnJhY3Rpb24gbWF0dGVycywgdXNpbmcgMzUwMCBh
bmQgMTIgd2lsbCBkZWxpdmVyIHRoZSBleGFjdCBzYW1lIHJlc3VsdC4NCj4+Pj4+PiArICBJZiB0
aGVzZSBhcmUgbm90IHNwZWNpZmllZCwgYW5kIHRoZSBQTEwgaXMgbm90IHlldCBwcm9ncmFtbWVk
IHdoZW4gdGhlIGRyaXZlcg0KPj4+Pj4+ICsgIHByb2JlcywgdGhlIFBMTCB3aWxsIGJlIHNldCB0
byAxNEdIei4NCj4+Pj4+DQo+Pj4+PiBDYW4gdGhpcyBiZSBkb25lIHZpYSBhc3NpZ25lZC1jbG9j
ay1yYXRlcz8gUG9zc2libHkgd2l0aCBhIHRhYmxlIGluIHRoZQ0KPj4+Pj4gY2xrIGRyaXZlciB0
byB0ZWxsIHVzIGhvdyB0byBnZW5lcmF0ZSB0aG9zZSByYXRlcy4NCj4+Pj4NCj4+Pj4gVGhlIFBM
TCBmcmVxdWVuY3kgY2hvaWNlIGRldGVybWluZXMgd2hvJ2xsIGdldCBqaXR0ZXIgYW5kIHdobyB3
b24ndC4gSXQncw0KPj4+PiByaWRpY3Vsb3VzbHkgYWNjdXJhdGUgdG9vLg0KPj4+Pg0KPj4+PiBG
b3IgZXhhbXBsZSwgaWYgeW91IG5lZWQgYSAyNiBNSHogYW5kIGEgMTAwIE1IeiBvdXRwdXQsIHRo
ZXJlJ3Mgbm8gc29sdXRpb24NCj4+Pj4gZm9yIHRoZSBQTEwgdGhhdCBtYWtlcyBib3RoIGNsb2Nr
cyBhbiBpbnRlZ2VyIGRpdmlkZXIgKFNJIGlzIHZhZ3VlIGFib3V0IGl0LA0KPj4+PiBidXQgYXBw
YXJlbnRseSBpbnRlZ2VyIGRpdmlkZXJzIGhhdmUgbGVzcyBqaXR0ZXIgb24gb3V0cHV0KS4gT25s
eSB0aGUgZW5kdXNlcg0KPj4+PiBjYW4gc2F5IHdoaWNoIGNsb2NrIHdpbGwgZ2V0IHRoZSBiZXR0
ZXIgcXVhbGl0eS4NCj4gDQo+IFJpZ2h0LiBTbyBtYXliZSB3ZSBtYWtlIHRhYmxlcyBvZiByYXRl
cyBhbmQgcHV0IGl0IGluIHRoZSBkcml2ZXIgYW5kDQo+IGtlZXAgYWRkaW5nIGNvZGUgaW4gdGhl
cmU/IEknbSB3b3JyaWVkIGFib3V0IGhhdmluZyB0aGVzZSBwcm9wZXJ0aWVzIGluDQo+IERUIGFu
ZCB0aGVuIGhhdmluZyB0byB3b3JrIGFyb3VuZCB0aGVtIGxhdGVyIG9uIGJ5ICJmaXhpbmciIHRo
ZSBEVC4gSWYNCj4gaXQncyBvbmx5IGluIHRoZSBkcml2ZXIgdGhlbiB3ZSdyZSBhYmxlIHRvIHR3
ZWFrIHRoZSB2YWx1ZXMgdG8gZ2V0DQo+IGJldHRlciBqaXR0ZXIgbnVtYmVycywgZXRjLg0KDQpQ
cm9ncmFtbWluZyB0aGUgbWFpbiBQTEwgaXMgZWFzeSwgbm8gdGFibGVzIHJlcXVpcmVkLg0KDQpJ
dCdzIGFsbCB1c2VyIGNob2ljZSwgdGhhdCdzIHRoZSBpc3N1ZSBoZXJlLiBEcml2ZXJzIHRoZW1z
ZWx2ZXMgY2Fubm90IG1ha2UgDQp0aGlzIGRlY2lzaW9uLg0KDQoodXNlciA9IHRoZSBwZXJzb24g
ZG9pbmcgYm9hcmQgc3VwcG9ydCwgd3JpdGluZyB0aGUgZGV2aWNldHJlZSBhbmQga2VybmVsIA0K
Y29uZmlnIGZvciBleGFtcGxlKQ0KDQpJbiBteSBleGFtcGxlLCB0aGUgY2hpcCBoYXMgbm8gaXNz
dWUgc3ludGhlc2l6aW5nIGJvdGggMjYgYW5kIDEwMCBNSHouIA0KRGVwZW5kaW5nIG9uIHRoZSBt
YWluIFBMTCBzZXR0aW5nLCBvbmUgbWF5IGhhdmUgbW9yZSBqaXR0ZXIgdGhhbiB0aGUgb3RoZXIu
IElmIA0KdGhlIFBMTCBpcyBzZXQgdG8gMTQuMCBHSHosIHRoZSAxMDAgTUh6IGNsb2NrIHdpbGwg
YmUgb2YgYmV0dGVyIHF1YWxpdHksIHdoaWxlIA0KaWYgdGhlIFBMTCBpcyBzZXQgdG8gMTMuNjI0
IEdIeiAoYW4gZXZlbiBtdWx0aXBsZSBvZiAyNiksIHRoZSAyNiBNSHogd2lsbCBoYXZlIA0KYmV0
dGVyIHF1YWxpdHkuDQoNCg0KPj4+Pj4+ICstIHNpbGFicyxyZXByb2dyYW06IFdoZW4gcHJlc2Vu
dCwgdGhlIGRyaXZlciB3aWxsIGFsd2F5cyBhc3N1bWUgdGhlIGRldmljZSBtdXN0DQo+Pj4+Pj4g
KyAgYmUgaW5pdGlhbGl6ZWQsIGFuZCBhbHdheXMgcGVyZm9ybXMgdGhlIHNvZnQtcmVzZXQgcm91
dGluZS4gU2luY2UgdGhpcyB3aWxsDQo+Pj4+Pj4gKyAgdGVtcG9yYXJpbHkgc3RvcCBhbGwgb3V0
cHV0IGNsb2NrcywgZG9uJ3QgZG8gdGhpcyBpZiB0aGUgY2hpcCBpcyBnZW5lcmF0aW5nDQo+Pj4+
Pj4gKyAgdGhlIENQVSBjbG9jayBmb3IgZXhhbXBsZS4NCj4+Pj4+DQo+Pj4+PiBDb3VsZCB0aGlz
IGJlIGRvbmUgd2l0aCB0aGUgcmVzZXQgZnJhbWV3b3JrPyBJdCBhbG1vc3Qgc291bmRzIGxpa2Ug
aWYNCj4+Pj4+IHRoZSBjbGsgaXMgYSBDTEtfSVNfQ1JJVElDQUwgdGhlbiB3ZSBzaG91bGRuJ3Qg
ZG8gdGhlIHJlc2V0LCBvdGhlcndpc2UNCj4+Pj4+IHdlIHByb2JhYmx5IHNob3VsZCByZXNldCB0
aGUgY2hpcCB3aGVuIHRoZSBkcml2ZXIgcHJvYmVzLiBJZiB3ZSBkb24ndA0KPj4+Pj4gaGF2ZSBh
IGNhc2Ugd2hlcmUgaXQncyBnb2luZyB0byBiZSBzdXBwbHlpbmcgYSBjcml0aWNhbCBjbGsgZm9y
IGEgbG9uZw0KPj4+Pj4gdGltZSB0aGVuIHBlcmhhcHMgd2Ugc2hvdWxkbid0IGV2ZW4gY29uc2lk
ZXIgdGhpcyB0b3BpYyB1bnRpbCBsYXRlci4NCj4+Pj4NCj4+Pj4gVGhlIGRyaXZlciBjYW4gc29y
dCBvZiBzZWUgdGhhdCB0aGUgY2hpcHMgaXMgYWxyZWFkeSBjb25maWd1cmVkLiBUaGlzIHRlbGxz
DQo+Pj4+IHRoZSBkcml2ZXIgd2hldGhlciB0aGF0J3MgZXhwZWN0ZWQgb3IganVzdCBjb2luY2lk
ZW5jZS4NCj4+Pj4NCj4+Pj4gTWF5YmUgaXQnZCBiZSBjbGVhcmVyIGlmIEkgcmV2ZXJzZWQgdGhl
IGxvZ2ljIGFuZCBuYW1lIHRoaXMNCj4+Pj4gInNpbGFicyxwcmVwcm9ncmFtbWVkIiwgd2hpY2gg
d2lsbCBza2lwIHRoZSBkcml2ZXIncyBpbml0aWFsaXphdGlvbiByb3V0aW5lPw0KPj4+Pg0KPj4+
DQo+Pj4gTWF5YmU/IElzIHRoZXJlIGFueSB3YXkgdG8gbG9vayBhdCBzb21lIHJlZ2lzdGVyIHRv
IGZpZ3VyZSBvdXQgZm9yIHN1cmUNCj4+PiBpZiBpdCdzIGJlZW4gcHJlLXByb2dyYW1tZWQgb3Ig
bm90PyBDb3VsZCBUT09MX1ZFUlNJT04gYmUgdXNlZCBvcg0KPj4+IEFDVElWRV9OVk1fQkFOSyBv
ciBERVNJR05fSUQwLTc/DQo+Pg0KPj4gSSd2ZSBleHBlcmltZW50YWxseSBkZXRlcm1pbmVkIHRo
YXQgVE9PTF9WRVJTSU9OIGFuZCBERVNJR05fSUR4DQo+PiBhcHBhcmVudGx5IGdldCBmaWxsZWQg
d2l0aCB6ZXJvZXMgYnkgdGhlIGNsb2NrYnVpbGRlciBhbnl3YXkuDQo+Pg0KPj4gQUNUSVZFX05W
TV9CQU5LIHdvcmtzIHJlbGlhYmx5IGZvciBzZWxmLXByb2dyYW1tZWQgY2hpcHMuDQo+Pg0KPj4g
VGhlIGZsYWcgaXMgYWJvdXQgImlzIHRoaXMgY2hpcCB1bmRlciBmdWxsIGtlcm5lbCBjb250cm9s
LCBvciBpcyBpdA0KPj4gZ2VuZXJhdGluZyBjbG9ja3MgdGhlIGtlcm5lbCBkb2Vzbid0IGtub3cg
YWJvdXQgKGUuZy4gZm9yIHJlYWx0aW1lIGNvcmVzDQo+PiBvciBGUEdBIGxvZ2ljKSIuDQo+Pg0K
PiANCj4gQWxyaWdodC4NCj4gDQo+Pg0KPj4NCj4+Pj4+PiArPT1DaGlsZCBub2Rlcz09DQo+Pj4+
Pj4gKw0KPj4+Pj4+ICtFYWNoIG9mIHRoZSBjbG9jayBvdXRwdXRzIGNhbiBiZSBvdmVyd3JpdHRl
biBpbmRpdmlkdWFsbHkgYnkNCj4+Pj4+PiArdXNpbmcgYSBjaGlsZCBub2RlIHRvIHRoZSBJMkMg
ZGV2aWNlIG5vZGUuIElmIGEgY2hpbGQgbm9kZSBmb3IgYSBjbG9jaw0KPj4+Pj4+ICtvdXRwdXQg
aXMgbm90IHNldCwgdGhlIGNvbmZpZ3VyYXRpb24gcmVtYWlucyB1bmNoYW5nZWQuDQo+Pj4+Pj4g
Kw0KPj4+Pj4+ICtSZXF1aXJlZCBjaGlsZCBub2RlIHByb3BlcnRpZXM6DQo+Pj4+Pj4gKy0gcmVn
OiBudW1iZXIgb2YgY2xvY2sgb3V0cHV0Lg0KPj4+Pj4+ICsNCj4+Pj4+PiArT3B0aW9uYWwgY2hp
bGQgbm9kZSBwcm9wZXJ0aWVzOg0KPj4+Pj4+ICstIHNpbGFicyxmb3JtYXQ6IE91dHB1dCBmb3Jt
YXQsIHNlZSBbMV0sIDE9ZGlmZmVyZW50aWFsLCAyPWxvdy1wb3dlciwgND1MVkNNT1MNCj4+Pj4+
PiArLSBzaWxhYnMsY29tbW9uLW1vZGU6IE91dHB1dCBjb21tb24gbW9kZSwgZGVwZW5kcyBvbiBz
dGFuZGFyZC4NCj4+Pj4+PiArLSBzaWxhYnMsYW1wbGl0dWRlOiBPdXRwdXQgYW1wbGl0dWRlLCBk
ZXBlbmRzIG9uIHN0YW5kYXJkLg0KPj4+Pj4+ICstIHNpbGFicyxzeW50aC1zb3VyY2U6IFNlbGVj
dCB3aGljaCBtdWx0aXN5bnRoIHRvIHVzZSBmb3IgdGhpcyBvdXRwdXQNCj4+Pj4+PiArLSBzaWxh
YnMsc3ludGgtZnJlcXVlbmN5OiBTZXRzIHRoZSBmcmVxdWVuY3kgZm9yIHRoZSBtdWx0aXN5bnRo
IGNvbm5lY3RlZCB0bw0KPj4+Pj4+ICsgIHRoaXMgb3V0cHV0LiBUaGlzIHdpbGwgYWZmZWN0IG90
aGVyIG91dHB1dHMgY29ubmVjdGVkIHRvIHRoaXMgbXVsdGlzeW50aC4gVGhlDQo+Pj4+Pj4gKyAg
c2V0dGluZyBpcyBhcHBsaWVkIGJlZm9yZSBzaWxhYnMsc3ludGgtbWFzdGVyIGFuZCBjbG9jay1m
cmVxdWVuY3kuDQo+Pj4+Pj4gKy0gc2lsYWJzLHN5bnRoLW1hc3RlcjogSWYgcHJlc2VudCwgdGhp
cyBvdXRwdXQgaXMgYWxsb3dlZCB0byBjaGFuZ2UgdGhlDQo+Pj4+Pj4gKyAgbXVsdGlzeW50aCBm
cmVxdWVuY3kgZHluYW1pY2FsbHkuDQo+Pj4+Pg0KPj4+Pj4gVGhlc2UgYWJvdmUgcHJvcGVydGll
cyBsb29rIGxpa2UgaGlnaGx5IGRldGFpbGVkIGNvbmZpZ3VyYXRpb24gZGF0YSB0bw0KPj4+Pj4g
bGV0IHRoZSBkcml2ZXIgY29uZmlndXJlIHRoZSBjbGsgb3V0cHV0IGV4YWN0bHkgaG93IGl0J3Mg
c3VwcG9zZWQgdG8gYmUNCj4+Pj4+IGNvbmZpZ3VyZWQuIENhbiB0aGVzZSBwcm9wZXJ0aWVzIGJl
IHJld3JpdHRlbiBpbiBtb3JlIGhpZ2gtbGV2ZWwgdGVybXMNCj4+Pj4+IHRoYXQgYSBzeXN0ZW0g
aW50ZWdyYXRvciB3b3VsZCB1bmRlcnN0YW5kPyBJZGVhbGx5LCBJIHNob3VsZG4ndCBoYXZlIHRv
DQo+Pj4+PiByZWFkIHRoZSBkYXRhc2hlZXQgYW5kIHRoZSBkcml2ZXIgYW5kIHRoZW4gZmlndXJl
IG91dCB3aGF0IERUIHByb3BlcnRpZXMNCj4+Pj4+IG5lZWQgdGhlIHZhbHVlcyBmcm9tIHRoZSBk
YXRhc2hlZXQgaW4gdGhlbSBzbyB0aGF0IHRoZSBkcml2ZXIgd3JpdGVzDQo+Pj4+PiB0aGVtIHRv
IGEgcGFydGljdWxhciByZWdpc3Rlci4gSSBkb24ndCBrbm93IGlmIHRoYXQncyBwb3NzaWJsZSBo
ZXJlLA0KPj4+Pj4gYmVjYXVzZSBJIGhhdmVuJ3QgcmVhZCB0aGUgZHJpdmVyIG9yIHRoZSBkYXRh
c2hlZXQgdG9vIGNsb3NlbHkgeWV0LCBidXQNCj4+Pj4+IHRoYXQgc2hvdWxkIGJlIHRoZSBnb2Fs
Lg0KPj4+Pg0KPj4+PiBUaGUgZGF0YXNoZWV0IGlzIG5vdCB2ZXJ5IGhlbHBmdWwgaW4gdGhpcyBy
ZWdhcmQuIFNpbGFicyBqdXN0IGFzc3VtZXMgeW91J2xsDQo+Pj4+IHVzZSB0aGVpciBjbG9ja2J1
aWxkZXIgc29mdHdhcmUgZm9yIHdyaXRpbmcgdGhlc2UgdmFsdWVzLCB3aGljaCBpcyBob3cgd2Ug
Z290DQo+Pj4+IHRvIHRoZSAiTFZEUyAzdjMiIHZhbHVlcy4NCj4+Pg0KPj4+IEkgaG9wZSB0aGF0
IGNhbiBiZSBkZXRlcm1pbmVkIGJ5IGxvb2tpbmcgYXQgdmRkPE4+LXN1cHBseSB2b2x0YWdlcz8N
Cj4+DQo+PiBOb3QgcmVhbGx5LCBhbmQgd2hlbiBhc2tlZCBmb3IgYSBiaXQgbW9yZSBkZXRhaWws
IFNpbGFicyBqdXN0IHNheXMgdG8NCj4+IHVzZSB0aGUgZXhjZWxsZW50IGRldmVsb3BlciBmcmll
bmRseSBjbG9ja2J1aWxkZXIgc29mdHdhcmUgdGhhdCBhbG1vc3QNCj4+IHJ1bnMgb24gYWxtb3N0
IGFueSBwbGF0Zm9ybS4NCj4+DQo+Pj4+IEkgY291bGQgcHV0IGluIGEgdGFibGUgb2YgImNvbW1v
biIgdmFsdWVzLCBzbyB0aGF0IHlvdSBjYW4gc2F5Og0KPj4+Pg0KPj4+PiBzaWxhYnMsb3V0cHV0
LXN0YW5kYXJkID0gImx2ZHMiOw0KPj4+Pg0KPj4+PiBBbmQgdGhlbiB1c2UgdGhlICJyYXciIHBy
b3BlcnRpZXMgdG8gZXhwYW5kIG9yIG92ZXJyaWRlIG9uIHRoYXQuDQo+Pj4+DQo+Pj4+IEV4dHJh
IGRlZmluZXMgbWlnaHQgaGVscCwgZS5nLjoNCj4+Pj4NCj4+Pj4gc2lsYWJzLGZvcm1hdCA9IDxT
STUzNDFfRk9STUFUX0RJRkZFUkVOVElBTD47DQo+Pj4NCj4+PiBJIHN1cHBvc2UgeW91J2xsIG5l
ZWQgdG8gcmV2ZXJzZSBlbmdpbmVlciB0aGUgY2xvY2sgYnVpbGRlciBzb2Z0d2FyZSB0bw0KPj4+
IGZpZ3VyZSBvdXQgd2h5IGEgU0k1MzQxX0ZPUk1BVF9ESUZGRVJFTlRJQUwgd291bGQgYmUgc3Bl
Y2lmaWVkIGluc3RlYWQNCj4+PiBvZiBzb21lIG90aGVyIHZhbHVlLiBJZGVhbGx5IHdlIGRvbid0
IG5lZWQgYW55IG9mIHRoZXNlIHZlbmRvciBzcGVjaWZpYw0KPj4+IHByb3BlcnRpZXMgYW5kIHRo
ZSBkcml2ZXJzIHVzaW5nIHRoZXNlIGNsa3MgY2FuIGFzayB0aGUgY2xrIGZyYW1ld29yayB0bw0K
Pj4+IGNvbmZpZ3VyZSB0aGVzZSBwcm9wZXJ0aWVzLCBvciB3ZSBuZWVkIHRvIGxvb2sgYXQgbWFr
aW5nIG1vcmUgcHJvcGVydGllcw0KPj4+IGxpa2UgJ2Fzc2lnbmVkLWNsb2NrLXBhcmVudHMnIHRo
YXQgbGV0cyB1cyBjb25maWd1cmUgdGhpbmdzIGdlbmVyaWNhbGx5Lg0KPj4NCj4+IFRoZXNlIHBy
b3BlcnRpZXMgYXJlIGFib3V0IGhvdyB5b3Ugc29sZGVyZWQgdGhpbmdzIHRvZ2V0aGVyLCBidXQg
eWVhaCwNCj4+IGlmIHRoZSBjbG9jayBvdXRwdXRzIGdvIHRvIGV4cGFuc2lvbiBzbG90cywgc29t
ZSBkcml2ZXIgb3IgZGV2aWNldHJlZQ0KPj4gZnJhZ21lbnQgY29udHJvbCB3b3VsZCBiZSBkZXNp
cmFibGUsIHNvIHlvdSBjYW4gc3dpdGNoIHRoZSBjbG9jayBtb2RlDQo+PiBmcm9tIGRpZmZlcmVu
dGlhbCB0byBzaW5nbGUgZW5kZWQgZm9yIGV4YW1wbGUuDQo+IA0KPiBIbW0uLiBQZXJoYXBzIHdl
IG5lZWQgYSBjbGtfc2V0X21vZGUoKSBBUEk/IFBvc3NpYmx5IGJlIGFuIGludGVybmFsIEFQSQ0K
PiB0aGF0IGxldHMgdGhlIERUIGNvbmZpZ3VyZSB0aGUgbW9kZSB0byBiZSBkaWZmZXJlbnRpYWwg
b3Igc2luZ2xlIGVuZGVkPw0KPiBOb2JvZHkgaGFzIHJlcXVpcmVkIHRoaXMgc28gZmFyIHNvIGl0
J3MgdmVyeSByYXJlLCBidXQgSSdkIGxpa2UgdG8gc2VlDQo+IHRoZSBwcm9wZXJ0aWVzIGJlY29t
ZSBzdGFuZGFyZCBpbnN0ZWFkIG9mIHZlbmRvciBzcGVjaWZpYyBpZiBwb3NzaWJsZS4NCj4gDQo+
Pg0KPj4NCj4+Pj4+PiArLSBhbHdheXMtb246IEltbWVkaWF0ZWx5IGFuZCBwZXJtYW5lbnRseSBl
bmFibGUgdGhpcyBvdXRwdXQuIFBhcnRpY3VsYXJ5DQo+Pj4+Pj4gKyAgdXNlZnVsIHdoZW4gY29t
YmluZWQgd2l0aCBhc3NpZ25lZC1jbG9ja3MsIHNpbmNlIHRoYXQgZG9lcyBub3QgcHJlcGFyZSBj
bG9ja3MuDQo+Pj4+Pg0KPj4+Pj4gTG9va3MgbGlrZSB5b3Ugd2FudCBDTEtfSVNfQ1JJVElDQUwg
aW4gRFQuIFdlJ3ZlIGhhZCB0aGF0IGRpc2N1c3Npb24NCj4+Pj4+IGJlZm9yZSBidXQgbWF5YmUg
d2Ugc2hvdWxkIHJldmlzaXQgaXQgaGVyZSBhbmQgYWRkIGEgd2F5IHRvIGluZGljYXRlDQo+Pj4+
PiB0aGF0IHNvbWUgY2xrIHNob3VsZCBuZXZlciBiZSB0dXJuZWQgb2ZmIGluc3RlYWQgb2YgYXNz
dW1pbmcgdGhhdCB3ZQ0KPj4+Pj4gY2FuIGRvIHRoaXMgZnJvbSBDIGNvZGUgYWxsIHRoZSB0aW1l
Lg0KPj4+Pg0KPj4+PiBNeSBpc3N1ZSB3YXMgdGhhdCBhc3NpZ25lZC1jbG9ja3MgZG9lcyBub3Qg
Y2FsbCBjbGtfcHJlcGFyZS4gSWYgdGhlIGNsb2NrIGlzDQo+Pj4+IG5vdCBydW5uaW5nLCBhc3Np
Z25lZC1jbG9ja3Mgd2lsbCBub3QgdHVybiBpdCBvbiAoYXQgbGVhc3QsIHRoYXQgaXMgdGhlIGNh
c2UNCj4+Pj4gb24gdGhlIDQuMTQga2VybmVsIEkgdGVzdGVkIHRoaXMgb24pLCBpdCBhcHBhcmVu
dGx5IG9ubHkgcHJldmVudHMgaXQgZnJvbQ0KPj4+PiBiZWluZyB0dXJuZWQgb2ZmIGJ5IG1hcmtp
bmcgaXQgYXMgImluIHVzZSIuIFRoaXMganVzdCBwcm92aWRlcyBhIHdheSB0byB1c2UNCj4+Pj4g
YXNzaWduZWQtY2xvY2tzLg0KPj4+Pg0KPj4+IERvIHlvdSB3YW50IHRoZSBjbGtzIHRvIGFsd2F5
cyBiZSBwcmVwYXJlZCBhbmQgZW5hYmxlZD8gV2hhdCB1c2UtY2FzZSBpcw0KPj4+IHRoaXM/IEl0
IHN0aWxsIGxvb2tzIGxpa2UgQ0xLX0lTX0NSSVRJQ0FMIGZsYWcgbmVlZHMgdG8gYmUgZXhwcmVz
c2VkIGluDQo+Pj4gRFQgaGVyZS4NCj4+DQo+PiBUaGUgdXNlIGNhc2UgaXMgcHJldHR5IHNpbXBs
ZSwgaXQncyBqdXN0IHRvIGVuYWJsZSB0aGUgY2xvY2suIE9yIGluIHRoaXMNCj4+IGNhc2UsICJw
cmVwYXJlIiBpdCwgYmVjYXVzZSB0aGUgSTJDIGNsaWVudCBuZWVkcyB0byBiZSBhYmxlIHRvIHNs
ZWVwIGFuZA0KPj4gYWxsIGFjdGlvbnMgbXVzdCBiZSBkb25lIGluIHRoZSBwcmVwYXJlIHBhcnQu
DQo+Pg0KPj4gU3VwcG9zZSBJIHVzZSB0aGUgc2k1MzQxIHRvIGdlbmVyYXRlIGEgMjZNSHogY2xv
Y2sgdGhhdCB3b3VsZCBub3JtYWxseQ0KPj4gYmUgcHJvdmlkZXMgYnkgYSBoYXJkd2FyZSBvc2Np
bGxhdG9yLiBUaGUgZHJpdmVyIGl0c2VsZiBkb2Vzbid0IGhhdmUgYW55DQo+PiBjbG9jayBwcm9w
ZXJ0aWVzIHRvIHNldC4gVGhlbiBJJ2QgcHV0IGludG8gdGhhdCBkZXZpY2UncyBkZXZpY2V0cmVl
IG5vZGUNCj4+IHRoZSBmb2xsb3dpbmc6DQo+Pg0KPj4gYXNzaWduZWQtY2xvY2tzID0gPCZzaTUz
NDEgMj47DQo+PiBhc3NpZ25lZC1jbG9jay1yYXRlcyA9IDwyNjAwMDAwMD47DQo+Pg0KPj4gV2hl
biB0aGUgc3lzdGVtIGJvb3RzLCB0aGUgY2xvY2sgZnJhbWV3b3JrIGluZGVlZCBjYWxscw0KPj4g
InNldF9yYXRlKDI2MDAwMDAwKSIgYmVmb3JlIHRoYXQgZHJpdmVyIHByb2JlcywgYnV0IGl0IG5l
dmVyIGNhbGxzDQo+PiAiY2xrX3ByZXBhcmUiLCBzbyB0aGUgY2xvY2sncyBmcmVxdWVuY3kgaXMg
c2V0IG9rYXkgYnV0IHRoZSBjbG9jayB3b24ndA0KPj4gYmUgcnVubmluZyBhbmQgdGhlIGRldmlj
ZSB3b24ndCBmdW5jdGlvbi4NCj4gDQo+IFdoeSBjYW4ndCB0aGF0IGRyaXZlciBjYWxsIGNsa19w
cmVwYXJlX2VuYWJsZSgpPyBJcyB0aGVyZSBzb21lIHNvcnQgb2YNCj4gYXNzdW1wdGlvbiB0aGF0
IHRoaXMgY2xrIHdpbGwgYWx3YXlzIGJlIGVuYWJsZWQgYW5kIG5vdCBoYXZlIGEgZHJpdmVyDQo+
IHRoYXQgY29uZmlndXJlcyB0aGUgcmF0ZSBhbmQgZ2F0ZXMvdW5nYXRlcyBpdD8NCg0KTm90IG9u
bHkgY2xrX3ByZXBhcmVfZW5hYmxlKCksIGJ1dCB0aGUgZHJpdmVyIGNvdWxkIGFsc28gY2FsbCBj
bGtfc2V0X3JhdGUoKSANCmFuZCBjbGtfc2V0X3BhcmVudCgpIGFuZCB0aGUgbGlrZXMsIGJ1dCBp
dCBkb2Vzbid0LCBzbyB0aGF0J3Mgd2h5IHRoZXJlIGlzIA0KImFzc2lnbmVkLWNsb2NrcyIgcmln
aHQ/DQoNClRoZXJlIGFyZSBtdWx0aXBsZSBzY2VuYXJpbydzLCBzaW1pbGFyIHRvIHdoeSByZWd1
bGF0b3JzIGFsc28gaGF2ZSBwcm9wZXJ0aWVzIA0KbGlrZSB0aGVzZS4NCg0KLSBUaGUgY2xvY2sg
aXMgcmVsYXRlZCB0byBoYXJkd2FyZSB0aGF0IHRoZSBrZXJuZWwgaXMgbm90IGF3YXJlIG9mLg0K
LSBUaGUgY2xvY2sgaXMgZm9yIGEgZHJpdmVyIHRoYXQgaXNuJ3QgYXdhcmUgb2YgaXRzIGNsb2Nr
IHJlcXVpcmVtZW50cy4gSXQgDQptaWdodCBiZSBhbiBleHRyYSBjbG9jayBmb3IgYW4gRlBHQSBp
bXBsZW1lbnRlZCBjb250cm9sbGVyIHRoYXQgbWltaWNzIA0KZXhpc3RpbmcgaGFyZHdhcmUuDQoN
CkknZCBhbHNvIGNvbnNpZGVyIHBhdGNoaW5nICJhc3NpZ25lZC1jbG9ja3MiIHRvIGNhbGwgImNs
a19wcmVwYXJlX2VuYWJsZSgpIiwgDQp3b3VsZCB0aGF0IG1ha2Ugc2Vuc2UsIG9yIGlzIGl0IGlu
dGVudGlvbmFsIHRoYXQgYXNzaWduZWQtY2xvY2tzIGRvZXNuJ3QgZG8gdGhhdD8NCg0KDQo=
