Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251BDC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7C92075A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="oQ6vFIbJ";
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="oQ6vFIbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgAGHfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:35:45 -0500
Received: from mail-eopbgr00083.outbound.protection.outlook.com ([40.107.0.83]:34797
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbgAGHfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 02:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJk8+B4ljvQ1cv5vs04/7TXFgtgFKg+BdDg5FnCuI2E=;
 b=oQ6vFIbJ5Ug1McNjuV8FmxouVSsrIz8vDAtsV0GaaNkgotXvtK+cseklT4vnNasQUBCfnv4+6UYCIdmGoGzhR8QkR9EE6QcuveIeZbSliIBCDcpQw42rqyHmuCPLv/BvDmlaJuECjOpnfB/RJMC1GqFnfKwmVTxCSxppAfdmo60=
Received: from AM5PR04CA0032.eurprd04.prod.outlook.com (10.167.167.173) by
 VI1PR04MB5104.eurprd04.prod.outlook.com (20.177.50.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Tue, 7 Jan 2020 07:35:25 +0000
Received: from HE1EUR01FT064.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::208) by AM5PR04CA0032.outlook.office365.com
 (2603:10a6:206:1::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.15 via Frontend
 Transport; Tue, 7 Jan 2020 07:35:06 +0000
Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; baylibre.com; dkim=pass (signature was
 verified) header.d=topicbv.onmicrosoft.com;baylibre.com; dmarc=none
 action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 HE1EUR01FT064.mail.protection.outlook.com (10.152.1.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Tue, 7 Jan 2020 07:35:06 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (104.47.5.58) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 07 Jan 2020 07:35:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=appjn68urg+A78f6HE/TP+MVV1uKrG565Q/VbLpF6zKfEtW0AdBAQ44UeswpfZkVwWeuaWF8hZglMu674ckTLtucjQxYemOIpyw7mDiJ60681A5+hXK3+3aiOksm65PdHWDaaOrhFS8SXs13erVPBwJA2ErDIZej39whdL1ULPEDFvQoV2ij8RLXhdC9eerdxPb29eX6mDcCaxKd1SvXPRWTA/iWNfReglXhGGg7kHvqkvthiDAXfA8igzU6gnW8aoakP/ncXGCBtSNRX2CS+ljU9rACwz1/zgrRn58NlT01F8gKrfisIl7cniJRUsqCAtCUcHyKjDQLAFMhUHcfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJk8+B4ljvQ1cv5vs04/7TXFgtgFKg+BdDg5FnCuI2E=;
 b=R+cYZA5RpXr51FS3QYzJBnppxszAOzGqMvmeB1l4q1xiCo6RQAH0DPjM8wO7fOUKDy51hriXKJFs83FBG2mVrMxY86+rnOB0TWXqpFH6Jvhx8490nh666jRF3UnCUAMfOaIwCEF4nFB02ornMWD5wuA7wnBp0wc5Ql/ylNhZR89cQAuSESQ+5eLyL5mplXA1G98c2VWmQnqmBiJD1KfOCQ80oc9PfMBJWmgd2N5ShmB5HvRowk1mHl8b9YHiLIpPLW2j/6Oi0rFVisl3muL3ccTU/9AmnDSz/U1LyJSPFKdxBGKTjvzJLSMgwNWLqWk3JKYZFl3L0oBq4ri5+X+umA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJk8+B4ljvQ1cv5vs04/7TXFgtgFKg+BdDg5FnCuI2E=;
 b=oQ6vFIbJ5Ug1McNjuV8FmxouVSsrIz8vDAtsV0GaaNkgotXvtK+cseklT4vnNasQUBCfnv4+6UYCIdmGoGzhR8QkR9EE6QcuveIeZbSliIBCDcpQw42rqyHmuCPLv/BvDmlaJuECjOpnfB/RJMC1GqFnfKwmVTxCSxppAfdmo60=
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) by
 DB3PR0402MB3785.eurprd04.prod.outlook.com (52.134.71.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Tue, 7 Jan 2020 07:35:02 +0000
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::2921:6c3f:a653:732a]) by DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::2921:6c3f:a653:732a%6]) with mapi id 15.20.2602.015; Tue, 7 Jan 2020
 07:35:02 +0000
Received: from [192.168.80.121] (81.173.50.109) by AM3PR07CA0144.eurprd07.prod.outlook.com (2603:10a6:207:8::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.4 via Frontend Transport; Tue, 7 Jan 2020 07:35:01 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
Subject: Re: [PATCH] clk, clk-si5341: Support multiple input ports
Thread-Topic: [PATCH] clk, clk-si5341: Support multiple input ports
Thread-Index: AQHVq2M1pWA4XPdJX0+266vowD3Q76fe5W+AgAAduQA=
Date:   Tue, 7 Jan 2020 07:35:01 +0000
Message-ID: <865d0c3c-666a-2b2e-585f-24bd3522e530@topic.nl>
References: <20191205115734.6987-1-mike.looijmans@topic.nl>
 <20200107054837.DB91F2075A@mail.kernel.org>
In-Reply-To: <20200107054837.DB91F2075A@mail.kernel.org>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
x-clientproxiedby: AM3PR07CA0144.eurprd07.prod.outlook.com
 (2603:10a6:207:8::30) To DB3PR0402MB3947.eurprd04.prod.outlook.com
 (2603:10a6:8:7::19)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.173.50.109]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 5757f226-e501-407b-0f32-08d793441db8
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3785:|VI1PR04MB5104:
X-Microsoft-Antispam-PRVS: <VI1PR04MB5104A9EA73B0D64DB2F91BDC963F0@VI1PR04MB5104.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 027578BB13
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(346002)(136003)(39840400004)(396003)(376002)(366004)(199004)(189003)(316002)(2616005)(52116002)(6486002)(16576012)(8936002)(66946007)(66476007)(66556008)(66446008)(64756008)(110136005)(956004)(4326008)(44832011)(71200400001)(186003)(53546011)(508600001)(31686004)(31696002)(5660300002)(26005)(16526019)(54906003)(42882007)(8676002)(81166006)(36756003)(81156014)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3785;H:DB3PR0402MB3947.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: N3Js6gOGaq0M1YCL75GRcxeIAdq1oQM+hRFFip5oWTT7k8JDoU97zdhleKxc64k5hOVWLvGhYhj5MVGkrd+dsXp7zytHvKavR5mMeOJvJujYZOOaaXxZ6RO3qATwR9YorMkc+ZBx7DVVOqr1KtqYCthm4HgOlnd9DKZc1BG6VmaLDumu5gVYlwyeBJ0cs33a850JE5R6BGWuFWS/qD9Lr0IVNXau+MCc4AOpfb+To2vgMRMjLczwpJ69RmJvEJPnKrIEu9ASzpfMMalrdlsHjTPz+YaaCUtD63bO4QgD2XK7bB1TkeqwmQagodCbHSANWmgkEZXxZ7wrPgNohAQFtDyByj2zOuZdXD5W3dzDJeE8R7GMbke1iMYmCeCNemu+o0CA/k1o15c4IqUnUuwbtVEUvn/NlIsoIKFrk2Yiq+2cnb0pAckTBKna50bmD8/i
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BCDD0FF14865F47819557E5B756C7D1@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3785
X-CodeTwo-MessageID: 44378090-31dc-4bbb-a95e-d41421b16d77.20200107073504@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT064.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:40.68.112.65;IPV:;CTRY:NL;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(39840400004)(189003)(199004)(956004)(42882007)(356004)(2616005)(336012)(31686004)(316002)(508600001)(16576012)(110136005)(54906003)(6486002)(16526019)(8936002)(36756003)(8676002)(70206006)(70586007)(44832011)(31696002)(26005)(7636002)(246002)(7596002)(5660300002)(2906002)(4326008)(53546011)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5104;H:westeu12-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:westeu12-emailsignatures-cloud.codetwo.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a6b2bb9b-da79-4ce9-e409-08d793441b20
X-Forefront-PRVS: 027578BB13
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6sT9pucneiAyJWst7BhquuEBCo+qMiCwuPgutVY9Natw4TAq0RU16ww5QyyCPgzCAvgN2ZyoEPpXxfRD3GS5lc/fJE0Dd4dNNTI8ubGtdSz1bOG7ZgNlOhTfzHA7CwGzD8Lf33am3yNE2iGCgZwJjxHGog6GIDvy+wkouytRC8vxZvE6Q/MbFOkEgq/AnExQ65qHkQ3B+8pWZzti7P7Czi65NSqrbsh3oXGbg6ibj2RycNXGs/c7tilDdR4abSn/0lAMl6BW7yxuo++3UqL0e3aJdU6wr8waoyugpWCeinjF1sFR8eKUpY89Ldo+8eDHYkTT9U9A4FSz6cIVvhdkRS2ylk4T8KWC7ie+KsCdPdoe3YBO5U3SurSnLgTfuAEjUmvHHXNnwVbwmDOY7FIy9tPEOjFaKTplNB6QNFWt+DupDgBACitGxPyzN9hM7j1J
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2020 07:35:06.0474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5757f226-e501-407b-0f32-08d793441db8
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAwNy0wMS0yMDIwIDA2OjQ4LCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+IFF1b3RpbmcgTWlr
ZSBMb29pam1hbnMgKDIwMTktMTItMDUgMDM6NTc6MzQpDQo+PiBUaGUgU2k1MzQxIGFuZCBTaTUz
NDAgaGF2ZSBtdWx0aXBsZSBpbnB1dCBjbG9jayBvcHRpb25zLiBTbyBmYXIsIHRoZSBkcml2ZXIN
Cj4+IG9ubHkgc3VwcG9ydGVkIHRoZSBYVEFMIGlucHV0LCB0aGlzIGFkZHMgc3VwcG9ydCBmb3Ig
dGhlIHRocmVlIGV4dGVybmFsDQo+PiBjbG9jayBpbnB1dHMgYXMgd2VsbC4NCj4+DQo+PiBJZiB0
aGUgY2xvY2sgY2hpcCBpcyd0IHByb2dyYW1tZWQgYXQgYm9vdCwgdGhlIGRyaXZlciB3aWxsIGRl
ZmF1bHQgdG8gdGhlDQo+IA0KPiBpc24ndA0KPiANCj4+IFhUQUwgaW5wdXQgYXMgYmVmb3JlLiBJ
ZiB0aGVyZSBpcyBubyAieHRhbCIgY2xvY2sgaW5wdXQgYXZhaWxhYmxlLCBpdCB3aWxsDQo+PiBw
aWNrIHRoZSBmaXJzdCBjb25uZWN0ZWQgaW5wdXQgKGUuZy4gImluMCIpIGFzIHRoZSBpbnB1dCBj
bG9jayBmb3IgdGhlIFBMTC4NCj4+IE9uZSBjYW4gdXNlIGNsb2NrLWFzc2lnbmVkLXBhcmVudHMg
dG8gc2VsZWN0IGEgcGFydGljdWxhciBjbG9jayBhcyBpbnB1dC4NCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBNaWtlIExvb2lqbWFucyA8bWlrZS5sb29pam1hbnNAdG9waWMubmw+DQo+IA0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2Nsay1zaTUzNDEuYyBiL2RyaXZlcnMvY2xrL2Nsay1zaTUz
NDEuYw0KPj4gaW5kZXggNmU3ODBjMmE5ZTZiLi5mN2RiYTc2OTgwODMgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL2Nsay9jbGstc2k1MzQxLmMNCj4+ICsrKyBiL2RyaXZlcnMvY2xrL2Nsay1zaTUz
NDEuYw0KPj4gQEAgLTQsNyArNCw2IEBADQo+PiAgICAqIENvcHlyaWdodCAoQykgMjAxOSBUb3Bp
YyBFbWJlZGRlZCBQcm9kdWN0cw0KPj4gICAgKiBBdXRob3I6IE1pa2UgTG9vaWptYW5zIDxtaWtl
Lmxvb2lqbWFuc0B0b3BpYy5ubD4NCj4+ICAgICovDQo+PiAtDQo+PiAgICNpbmNsdWRlIDxsaW51
eC9jbGsuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRlci5oPg0KPj4gICAjaW5j
bHVkZSA8bGludXgvZGVsYXkuaD4NCj4gDQo+IEkgdGhpbmsgd2UgY2FuIGRvIHdpdGhvdXQgdGhp
cyBodW5rLg0KPiANCj4+IEBAIC0zOTAsNyArNDEwLDExMiBAQCBzdGF0aWMgdW5zaWduZWQgbG9u
ZyBzaTUzNDFfY2xrX3JlY2FsY19yYXRlKHN0cnVjdCBjbGtfaHcgKmh3LA0KPj4gICAgICAgICAg
cmV0dXJuICh1bnNpZ25lZCBsb25nKXJlczsNCj4+ICAgfQ0KPj4gICANCj4+ICtzdGF0aWMgaW50
IHNpNTM0MV9jbGtfZ2V0X3NlbGVjdGVkX2lucHV0KHN0cnVjdCBjbGtfc2k1MzQxICpkYXRhKQ0K
Pj4gK3sNCj4+ICsgICAgICAgaW50IGVycjsNCj4+ICsgICAgICAgdTMyIHZhbDsNCj4+ICsNCj4+
ICsgICAgICAgZXJyID0gcmVnbWFwX3JlYWQoZGF0YS0+cmVnbWFwLCBTSTUzNDFfSU5fU0VMLCAm
dmFsKTsNCj4+ICsgICAgICAgaWYgKGVyciA8IDApDQo+PiArICAgICAgICAgICAgICAgcmV0dXJu
IGVycjsNCj4+ICsNCj4+ICsgICAgICAgcmV0dXJuICh2YWwgJiBTSTUzNDFfSU5fU0VMX01BU0sp
ID4+IFNJNTM0MV9JTl9TRUxfU0hJRlQ7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyB1bnNpZ25l
ZCBjaGFyIHNpNTM0MV9jbGtfZ2V0X3BhcmVudChzdHJ1Y3QgY2xrX2h3ICpodykNCj4gDQo+IFBs
ZWFzZSB1c2UgdTggZm9yIG5vdy4NCj4gDQo+PiArew0KPj4gKyAgICAgICBzdHJ1Y3QgY2xrX3Np
NTM0MSAqZGF0YSA9IHRvX2Nsa19zaTUzNDEoaHcpOw0KPj4gKyAgICAgICBpbnQgcmVzID0gc2k1
MzQxX2Nsa19nZXRfc2VsZWN0ZWRfaW5wdXQoZGF0YSk7DQo+PiArDQo+PiArICAgICAgIGlmIChy
ZXMgPCAwKQ0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiAwOyAvKiBBcHBhcmVudGx5IHdlIGNh
bm5vdCByZXBvcnQgZXJyb3JzICovDQo+IA0KPiBGb3Igbm93IHRoaXMgaXMgdGhlIGNhc2UuIEkn
bGwgcmVraWNrIHRoZSBzZXJpZXMgdG8gY29udmVydCB0aGlzIEFQSSB0bw0KPiBhIGZ1bmN0aW9u
IHRoYXQgcmV0dXJucyBjbGtfaHcgcG9pbnRlcnMuDQo+ICAgDQo+PiArDQo+PiArICAgICAgIHJl
dHVybiByZXM7DQo+PiArfQ0KPj4gKw0KPiBbLi4uXQ0KPj4gQEAgLTk4NSw3ICsxMTEwLDggQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCByZWdtYXBfcmFuZ2Ugc2k1MzQxX3JlZ21hcF92b2xhdGlsZV9y
YW5nZVtdID0gew0KPj4gICAgICAgICAgcmVnbWFwX3JlZ19yYW5nZSgweDAwMEMsIDB4MDAxMiks
IC8qIFN0YXR1cyAqLw0KPj4gICAgICAgICAgcmVnbWFwX3JlZ19yYW5nZSgweDAwMUMsIDB4MDAx
RSksIC8qIHJlc2V0LCBmaW5jL2ZkZWMgKi8NCj4+ICAgICAgICAgIHJlZ21hcF9yZWdfcmFuZ2Uo
MHgwMEUyLCAweDAwRkUpLCAvKiBOVk0sIGludGVycnVwdHMsIGRldmljZSByZWFkeSAqLw0KPj4g
LSAgICAgICAvKiBVcGRhdGUgYml0cyBmb3Igc3ludGggY29uZmlnICovDQo+PiArICAgICAgIC8q
IFVwZGF0ZSBiaXRzIGZvciBQIGRpdmlkZXIgYW5kIHN5bnRoIGNvbmZpZyAqLw0KPj4gKyAgICAg
ICByZWdtYXBfcmVnX3JhbmdlKFNJNTM0MV9QWF9VUEQsIFNJNTM0MV9QWF9VUEQpLA0KPj4gICAg
ICAgICAgcmVnbWFwX3JlZ19yYW5nZShTSTUzNDFfU1lOVEhfTl9VUEQoMCksIFNJNTM0MV9TWU5U
SF9OX1VQRCgwKSksDQo+PiAgICAgICAgICByZWdtYXBfcmVnX3JhbmdlKFNJNTM0MV9TWU5USF9O
X1VQRCgxKSwgU0k1MzQxX1NZTlRIX05fVVBEKDEpKSwNCj4+ICAgICAgICAgIHJlZ21hcF9yZWdf
cmFuZ2UoU0k1MzQxX1NZTlRIX05fVVBEKDIpLCBTSTUzNDFfU1lOVEhfTl9VUEQoMikpLA0KPj4g
QEAgLTExMjIsNiArMTI0OCw3IEBAIHN0YXRpYyBpbnQgc2k1MzQxX2luaXRpYWxpemVfcGxsKHN0
cnVjdCBjbGtfc2k1MzQxICpkYXRhKQ0KPj4gICAgICAgICAgc3RydWN0IGRldmljZV9ub2RlICpu
cCA9IGRhdGEtPmkyY19jbGllbnQtPmRldi5vZl9ub2RlOw0KPj4gICAgICAgICAgdTMyIG1fbnVt
ID0gMDsNCj4+ICAgICAgICAgIHUzMiBtX2RlbiA9IDA7DQo+PiArICAgICAgIGludCBzZWw7DQo+
PiAgIA0KPj4gICAgICAgICAgaWYgKG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAic2lsYWJzLHBs
bC1tLW51bSIsICZtX251bSkpIHsNCj4+ICAgICAgICAgICAgICAgICAgZGV2X2VycigmZGF0YS0+
aTJjX2NsaWVudC0+ZGV2LA0KPj4gQEAgLTExMzUsNyArMTI2MiwxMSBAQCBzdGF0aWMgaW50IHNp
NTM0MV9pbml0aWFsaXplX3BsbChzdHJ1Y3QgY2xrX3NpNTM0MSAqZGF0YSkNCj4+ICAgICAgICAg
IGlmICghbV9udW0gfHwgIW1fZGVuKSB7DQo+PiAgICAgICAgICAgICAgICAgIGRldl9lcnIoJmRh
dGEtPmkyY19jbGllbnQtPmRldiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAiUExMIGNv
bmZpZ3VyYXRpb24gaW52YWxpZCwgYXNzdW1lIDE0R0h6XG4iKTsNCj4+IC0gICAgICAgICAgICAg
ICBtX2RlbiA9IGNsa19nZXRfcmF0ZShkYXRhLT5weHRhbCkgLyAxMDsNCj4+ICsgICAgICAgICAg
ICAgICBzZWwgPSBzaTUzNDFfY2xrX2dldF9zZWxlY3RlZF9pbnB1dChkYXRhKTsNCj4+ICsgICAg
ICAgICAgICAgICBpZiAoc2VsIDwgMCkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biBzZWw7DQo+PiArDQo+PiArICAgICAgICAgICAgICAgbV9kZW4gPSBjbGtfZ2V0X3JhdGUoZGF0
YS0+aW5wdXRfY2xrW3NlbF0pIC8gMTA7DQo+PiAgICAgICAgICAgICAgICAgIG1fbnVtID0gMTQw
MDAwMDAwMDsNCj4+ICAgICAgICAgIH0NCj4+ICAgDQo+PiBAQCAtMTE0MywxMSArMTI3NCw1MiBA
QCBzdGF0aWMgaW50IHNpNTM0MV9pbml0aWFsaXplX3BsbChzdHJ1Y3QgY2xrX3NpNTM0MSAqZGF0
YSkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBTSTUzNDFfUExMX01fTlVNLCBtX251bSwg
bV9kZW4pOw0KPj4gICB9DQo+PiAgIA0KPj4gK3N0YXRpYyBpbnQgc2k1MzQxX2Nsa19zZWxlY3Rf
YWN0aXZlX2lucHV0KHN0cnVjdCBjbGtfc2k1MzQxICpkYXRhKQ0KPj4gK3sNCj4+ICsgICAgICAg
aW50IHJlczsNCj4+ICsgICAgICAgaW50IGVycjsNCj4+ICsgICAgICAgaW50IGk7DQo+PiArDQo+
PiArICAgICAgIHJlcyA9IHNpNTM0MV9jbGtfZ2V0X3NlbGVjdGVkX2lucHV0KGRhdGEpOw0KPj4g
KyAgICAgICBpZiAocmVzIDwgMCkNCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gcmVzOw0KPj4g
Kw0KPj4gKyAgICAgICAvKiBJZiB0aGUgY3VycmVudCByZWdpc3RlciBzZXR0aW5nIGlzIGludmFs
aWQsIHBpY2sgdGhlIGZpcnN0IGlucHV0ICovDQo+PiArICAgICAgIGlmICghZGF0YS0+aW5wdXRf
Y2xrW3Jlc10pIHsNCj4+ICsgICAgICAgICAgICAgICBkZXZfZGJnKCZkYXRhLT5pMmNfY2xpZW50
LT5kZXYsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAiSW5wdXQgJWQgbm90IGNvbm5lY3Rl
ZCwgcmVyb3V0aW5nXG4iLCByZXMpOw0KPj4gKyAgICAgICAgICAgICAgIHJlcyA9IC1FTk9ERVY7
DQo+PiArICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IFNJNTM0MV9OVU1fSU5QVVRTOyAr
K2kpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChkYXRhLT5pbnB1dF9jbGtbaV0p
IHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVzID0gaTsNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICB9DQo+PiArICAgICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAgICAgIGlmIChyZXMg
PCAwKSB7DQo+IA0KPiBXaGF0IGlmIHJlcyBpcyA9PSBTSTUzNDFfTlVNX0lOUFVUUz8NCg0KQ2Fu
bm90IGhhcHBlbiwgImkiIGNhbiBiZSBTSTUzNDFfTlVNX0lOUFVUUyBidXQgInJlcyIgaXMgb25s
eSBzZXQgdG8gDQpub24tbmVnYXRpdmUgaWYgYSBtYXRjaCB3YXMgZm91bmQuDQoNCj4gDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKCZkYXRhLT5pMmNfY2xpZW50LT5kZXYsDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJObyBjbG9jayBpbnB1dCBhdmFpbGFi
bGVcbiIpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJlczsNCj4+ICsgICAg
ICAgICAgICAgICB9DQo+PiArICAgICAgIH0NCj4+ICsNCj4+ICsgICAgICAgLyogTWFrZSBzdXJl
IHRoZSBzZWxlY3RlZCBjbG9jayBpcyBhbHNvIGVuYWJsZWQgYW5kIHJvdXRlZCAqLw0KPj4gKyAg
ICAgICBlcnIgPSBzaTUzNDFfY2xrX3JlcGFyZW50KGRhdGEsIHJlcyk7DQo+PiArICAgICAgIGlm
IChlcnIgPCAwKQ0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+PiArDQo+PiArICAg
ICAgIGVyciA9IGNsa19wcmVwYXJlX2VuYWJsZShkYXRhLT5pbnB1dF9jbGtbcmVzXSk7DQo+IA0K
PiBJcyBpdCBwb3NzaWJsZSB0byBkbyB0aGlzIHNldHVwIGFuZCBjb25maWd1cmF0aW9uIHN0dWZm
IHdoZW4gdGhlIGNsayBpcw0KPiBwcmVwYXJlZCBieSBzb21ldGhpbmc/IE1heWJlIEkndmUgYXNr
ZWQgdGhpcyBiZWZvcmUgYnV0IEknZCBwcmVmZXIgdGhhdA0KPiB0aGlzIGRyaXZlciBpcyBhIGNs
ayBwcm92aWRlciBhbmQgbm90IGEgY2xrIGNvbnN1bWVyLiBJZiBzb21lIGRlZmF1bHQNCj4gc2V0
dXAgbmVlZHMgdG8gYmUgZG9uZSwgcHJlZmVyYWJseSBkbyB0aGF0IHZpYSBkaXJlY3QgcmVnaXN0
ZXIgd3JpdGVzIG9yDQo+IGJ5IGNhbGxpbmcgdGhlIGNsa19vcHMgZnVuY3Rpb25zIGRpcmVjdGx5
IGluc3RlYWQgb2YgZ29pbmcgdGhyb3VnaCB0aGUNCj4gZnJhbWV3b3JrLCBwcmVmZXJhYmx5IGJl
Zm9yZSByZWdpc3RlcmluZyB0aGUgY2xrcyB0byB0aGUgZnJhbWV3b3JrLg0KDQpJIHN1cHBvc2Ug
aXQgd291bGQgYmUgcG9zc2libGUgdG8gZG8gc28sIGFuZCBJIGRvIHJlY2FsbCBzb21lIGRpc2N1
c3Npb24gaW4gDQp0aGUgcGFzdC4NCg0KVGhlIHJlYXNvbiBmb3IgdGhlIGNhbGwgaGVyZSBpcyB0
aGF0IHRoZSBpbnB1dCBjbG9jayBtdXN0IGJlIHVwIGFuZCBydW5uaW5nIGF0IA0KdGhpcyBwb2lu
dCwgYmVjYXVzZSBpdCBkcml2ZXMgdGhlIH4xNEdIeiBQTEwgdGhhdCBkcml2ZXMgYWxsIG90aGVy
IGNsb2Nrcy4gVGhlIA0KaW5wdXQgY2xvY2sgd2lsbCB1bmRvdWJ0ZWRseSBiZSBhIGNyeXN0YWwg
b3IgZml4ZWQtZnJlcXVlbmN5IG9zY2lsbGF0b3IuDQoNCk15IG1haW4gcmVhc29uIGZvciBkb2lu
ZyB0aGlzIGhlcmUgaXMgdGhhdCB0aGUgY2xvY2sgY2hpcCBpcyBvZnRlbiANCnByZS1wcm9ncmFt
bWVkIGFuZCBhbHJlYWR5IHVwIGFuZCBydW5uaW5nIGF0IGJvb3QuIEl0IG1pZ2h0IGV2ZW4gYmUg
cHJvdmlkaW5nIA0KdGhlIENQVSBjbG9jay4uLg0KDQpDYW4gd2UgcG9zdHBvbmUgdGhpcyB0byBh
IG5ldyBwYXRjaD8gSXQnZCBiZSBxdWl0ZSBhIGJpZyBjaGFuZ2UgdG8gYWx0ZXIgdGhpcywgDQph
bmQgdGhlIGNsa19wcmVwYXJlX2VuYWJsZSB3YXMgYWxyZWFkeSB0aGVyZS4NCg0KPiANCj4+ICsg
ICAgICAgaWYgKGVyciA8IDApDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4+ICsN
Cj4+ICsgICAgICAgcmV0dXJuIHJlczsNCj4+ICt9DQo+PiArDQoNCkknbGwgc2VuZCBhIHYyIHdp
dGggdGhlIGFib3ZlIGNoYW5nZXMgKGV4Y2VwdCB0aGF0IGxhc3Qgb25lKQ0KDQo=
