Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3883C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CAB223A1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="KsUmPHBM";
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="KsUmPHBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbfGWM3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:29:44 -0400
Received: from mail-eopbgr140048.outbound.protection.outlook.com ([40.107.14.48]:40746
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726438AbfGWM3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector1-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyRMl0twNYCRtYudFG5qAq9Fr4a/+veQrIq9JHt7WcI=;
 b=KsUmPHBMCaANkXGgoB2Hqzsti0rJbGBEjVO+vFQtEEkvraFbheUdeiMxVVW1sE9QfjJgQsSACk3b2FVLtQNP1Rp7viLg+5Vc9X8pMxSZHsiMTbPr+qQMk1aIOws5HqcAm1IcyA2xgDEC77YO3IH6tx/xfyUbvrmG18gbyJhdk+U=
Received: from VI1PR04CA0086.eurprd04.prod.outlook.com (2603:10a6:803:64::21)
 by AM0PR04MB5475.eurprd04.prod.outlook.com (2603:10a6:208:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.16; Tue, 23 Jul
 2019 12:29:38 +0000
Received: from HE1EUR01FT008.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::202) by VI1PR04CA0086.outlook.office365.com
 (2603:10a6:803:64::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2094.12 via Frontend
 Transport; Tue, 23 Jul 2019 12:29:37 +0000
Authentication-Results: spf=pass (sender IP is 52.166.56.231)
 smtp.mailfrom=topicproducts.com; vger.kernel.org; dkim=pass (signature was
 verified) header.d=topicbv.onmicrosoft.com;vger.kernel.org; dmarc=none
 action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 52.166.56.231 as permitted sender)
 receiver=protection.outlook.com; client-ip=52.166.56.231;
 helo=westeu11-emailsignatures-cloud.codetwo.com;
Received: from westeu11-emailsignatures-cloud.codetwo.com (52.166.56.231) by
 HE1EUR01FT008.mail.protection.outlook.com (10.152.1.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Tue, 23 Jul 2019 12:29:36 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (104.47.5.54) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 23 Jul 2019 12:29:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JII0r/EDLOQtWSkfujC/16GfbWrYbKHPrAQzv5t/sLo+D57UY7IhznIDMgx9UAuHd/dSRoap7mpOcBZ0+21C7s4LsMqrGapXPPqmm6MhCQs6/douJgTAtuSelApW8GjJOvxTGSWTkb6+clYq59zRTXESj5okhpVCHzVth89gcsgfujH97bBo0llS6uhQu2zDsPeFm3X43A0KkozGmzg65kuwa7OGaplbmuPCLj+Rtgl+utJlAe3iwbVdxImg/9xA2asybGrh+F9x3tn2Fsy1suNaboOX8GV6r5FrgPttZv7Xe5T57F5gLGPQF8JbRhBZVnfJ8ywZF9Ze/Sty0drLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyRMl0twNYCRtYudFG5qAq9Fr4a/+veQrIq9JHt7WcI=;
 b=ABoq8qmg2YHKdqx4OnXBgJUDX+8sb+i9iS2I8Aq76FbZPKzCk1ORcMwXaLynvX8nRWAB75OzcxS1aDNbvz8y8n34k3r4jsVRtcRE2GTEuM/H4Dv/05IeSH+xtn8yJhoMb90yi1g0zvqJhU+dXAva3TuVW8qcfTlGzfAVQLRKJsinc9H39P0wmwsmGX3X7fDMZLuiQrFtaF5X5EOjt4p20hCF9DOpBLfG+j7cXK6v2oECteBrHtU39mNKq2+HiDx+2J0Axmz1JTnqeQqPt+NIXeRMgD+UZafvnQ30dM2QjSalRiNtYBhf5ZigIjAAAbhvZ9z5SXpMyalCCFv7FUpU7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=topicproducts.com;dmarc=pass action=none
 header.from=topic.nl;dkim=pass header.d=topic.nl;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector1-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyRMl0twNYCRtYudFG5qAq9Fr4a/+veQrIq9JHt7WcI=;
 b=KsUmPHBMCaANkXGgoB2Hqzsti0rJbGBEjVO+vFQtEEkvraFbheUdeiMxVVW1sE9QfjJgQsSACk3b2FVLtQNP1Rp7viLg+5Vc9X8pMxSZHsiMTbPr+qQMk1aIOws5HqcAm1IcyA2xgDEC77YO3IH6tx/xfyUbvrmG18gbyJhdk+U=
Received: from AM7PR04MB6934.eurprd04.prod.outlook.com (10.141.174.88) by
 AM7PR04MB7093.eurprd04.prod.outlook.com (52.135.58.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Tue, 23 Jul 2019 12:29:32 +0000
Received: from AM7PR04MB6934.eurprd04.prod.outlook.com
 ([fe80::b9ee:2fbb:bd36:514c]) by AM7PR04MB6934.eurprd04.prod.outlook.com
 ([fe80::b9ee:2fbb:bd36:514c%3]) with mapi id 15.20.2073.012; Tue, 23 Jul 2019
 12:29:32 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     Stephen Boyd <sboyd@kernel.org>,
        Colin King <colin.king@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] clk: Si5341/Si5340: remove redundant assignment to
 n_den
Thread-Topic: [PATCH][next] clk: Si5341/Si5340: remove redundant assignment to
 n_den
Thread-Index: AQHVQNPSw/wTnsVmPkq/mc8Kw4mkpabYIuaA
Date:   Tue, 23 Jul 2019 12:29:32 +0000
Message-ID: <e7bb11ba-c79d-3c2c-aebe-67796d518e63@topic.nl>
References: <20190701165020.19840-1-colin.king@canonical.com>
 <20190722212414.6EF8D21900@mail.kernel.org>
In-Reply-To: <20190722212414.6EF8D21900@mail.kernel.org>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-clientproxiedby: AM5PR0102CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::25) To AM7PR04MB6934.eurprd04.prod.outlook.com
 (2603:10a6:20b:10d::24)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [85.150.144.104]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 0bc19bd8-990c-489b-2b22-08d70f696d13
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM7PR04MB7093;
X-MS-TrafficTypeDiagnostic: AM7PR04MB7093:|AM0PR04MB5475:
X-Microsoft-Antispam-PRVS: <AM0PR04MB547542D8BC95D52AB7FA721896C70@AM0PR04MB5475.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;OLM:4125;
x-forefront-prvs: 0107098B6C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(376002)(39840400004)(396003)(199004)(189003)(8936002)(11346002)(256004)(65806001)(102836004)(65956001)(14444005)(66066001)(5660300002)(42882007)(186003)(2616005)(446003)(476003)(66556008)(66446008)(6506007)(31686004)(64756008)(26005)(66946007)(229853002)(66476007)(2906002)(4326008)(36756003)(44832011)(71190400001)(71200400001)(53546011)(52116002)(2501003)(486006)(68736007)(76176011)(386003)(316002)(6436002)(6512007)(14454004)(3846002)(6246003)(64126003)(6486002)(6116002)(53936002)(81156014)(81166006)(65826007)(54906003)(8676002)(7736002)(25786009)(99286004)(508600001)(305945005)(110136005)(31696002)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR04MB7093;H:AM7PR04MB6934.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: lZvQZWvKI4xfndx3J5hocix0CC9vxpU5XVTT0bgTVdnlsHTxfijddYGCTCDGbYstRkKlSRHGZTatRsF8THsZCjy6nJZh0kzjlCaLC7IJLTpCmDv0KwVl5dIz+BRxct8ey4aUndTHz68k+EH2rT2zpnwhkEnT9ardBdhI69lmhoRHRt1TefygopntxsukvW3zjKKU6UMz3GH9UaPi1/TOROOfX5L0ZmP6mQi8McRB2wxSfHWgfWp8uqgJqT72sGsyA01K0JX5f/2sBN3Lg9miD1A7jmpDnGm4JzmsgGX195k4TUDrWHtkwDA5yz4QQ2i6HFU/Mgg1zk1KuIcBz1CZmcYRTnPSG0l419LOu4w7QcX+pRrfacNhvQBCgfFGZ0UHhcj/rFBGF8TiLAEynj6hf/Ta4c8AMCRwgXcMF5BeQk0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1ACA19DDCAA21E419339604A56D75438@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7093
X-CodeTwo-MessageID: e2de85f9-336a-41cc-875c-30e6611d8e8a.20190723122934@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT008.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:52.166.56.231;IPV:NLI;CTRY:NL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39840400004)(396003)(136003)(346002)(376002)(2980300002)(189003)(199004)(6506007)(102836004)(186003)(53546011)(386003)(305945005)(36756003)(106002)(99286004)(7736002)(7636002)(7596002)(2486003)(508600001)(23676004)(25786009)(8676002)(2501003)(246002)(356004)(229853002)(31686004)(6246003)(50466002)(76176011)(65826007)(4326008)(6512007)(64126003)(446003)(6116002)(31696002)(336012)(6486002)(66066001)(8936002)(65956001)(14454004)(70206006)(11346002)(44832011)(2616005)(476003)(47776003)(42882007)(126002)(2906002)(26005)(316002)(5660300002)(58126008)(65806001)(14444005)(436003)(70586007)(110136005)(54906003)(3846002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5475;H:westeu11-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:westeu11-emailsignatures-cloud.codetwo.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2998b801-3c13-45d1-1978-08d70f696a2c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM0PR04MB5475;
X-Forefront-PRVS: 0107098B6C
X-Microsoft-Antispam-Message-Info: kjKRdTqZmaNQ8KrjFj2+tNR6hKDT/3NFn3ryPJqwzkqJ2ZtGAXEMgH/7kYVRMeO5ZLccMKlaxdImkbWI16zLGApXfbE8Y02Bru9+xpCMlfJ7HsWTFdK6k8qwExD18+RLrbvzAuPWIXQL6HV2RlWIxu1+mWwQ1G91ZgR9QxODySYBmJuuiW94cyjyAO+khEovKCbWD4uYJiiuuqp+s0HKppKtUJ+8AuMP7sMw+TUXX7vNXlYdD+ybdxDl/uSF2Ty7p2D1oBAYVEz745MpT3Ue53dsPvB35VW/X/rLsGlDz4Q36tg9GssJi9FCkjUn2iUcuZrJiHURPlK7/lyWbSOdjMDRZi81d56hwOoOR9TjMjfW3L4d83s8cg59AxGHsG1agzFBTT7VBQdUNDES1LYsQqW0//bXVvb+H2pGirHGr6M=
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2019 12:29:36.6315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc19bd8-990c-489b-2b22-08d70f696d13
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[52.166.56.231];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5475
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R29vZCBjYXRjaCwgdGhhbmtzLiBZb3UgaGF2ZSBteQ0KDQpBY2tlZC1ieTogTWlrZSBMb29pam1h
bnMgPG1pa2UubG9vaWptYW5zQHRvcGljLm5sPg0KDQoNCk9uIDIyLTA3LTE5IDIzOjI0LCBTdGVw
aGVuIEJveWQgd3JvdGU6DQo+IFBsZWFzZSBDYyBhdXRob3JzIG9mIGRyaXZlcnMgc28gdGhleSBj
YW4gYWNrL3Jldmlldy4NCj4gDQo+IEFkZGluZyBNaWtlIHRvIHRha2UgYSBsb29rLg0KPiANCj4g
UXVvdGluZyBDb2xpbiBLaW5nICgyMDE5LTA3LTAxIDA5OjUwOjIwKQ0KPj4gRnJvbTogQ29saW4g
SWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4+DQo+PiBUaGUgdmFyaWFibGUg
bl9kZW4gaXMgaW5pdGlhbGl6ZWQgaG93ZXZlciB0aGF0IHZhbHVlIGlzIG5ldmVyIHJlYWQNCj4+
IGFzIG5fZGVuIGlzIHJlLWFzc2lnbmVkIGEgbGl0dGxlIGxhdGVyIGluIHRoZSB0d28gcGF0aHMg
b2YgYQ0KPj4gZm9sbG93aW5nIGlmLXN0YXRlbWVudC4gIFJlbW92ZSB0aGUgcmVkdW5kYW50IGFz
c2lnbm1lbnQuDQo+Pg0KPj4gQWRkcmVzc2VzLUNvdmVyaXR5OiAoIlVudXNlZCB2YWx1ZSIpDQo+
PiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29t
Pg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvY2xrL2Nsay1zaTUzNDEuYyB8IDEgLQ0KPj4gICAxIGZp
bGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Ns
ay9jbGstc2k1MzQxLmMgYi9kcml2ZXJzL2Nsay9jbGstc2k1MzQxLmMNCj4+IGluZGV4IDcyNDI0
ZWI3ZTVmOC4uNmU3ODBjMmE5ZTZiIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9jbGsvY2xrLXNp
NTM0MS5jDQo+PiArKysgYi9kcml2ZXJzL2Nsay9jbGstc2k1MzQxLmMNCj4+IEBAIC01NDcsNyAr
NTQ3LDYgQEAgc3RhdGljIGludCBzaTUzNDFfc3ludGhfY2xrX3NldF9yYXRlKHN0cnVjdCBjbGtf
aHcgKmh3LCB1bnNpZ25lZCBsb25nIHJhdGUsDQo+PiAgICAgICAgICBib29sIGlzX2ludGVnZXI7
DQo+PiAgIA0KPj4gICAgICAgICAgbl9udW0gPSBzeW50aC0+ZGF0YS0+ZnJlcV92Y287DQo+PiAt
ICAgICAgIG5fZGVuID0gcmF0ZTsNCj4+ICAgDQo+PiAgICAgICAgICAvKiBzZWUgaWYgdGhlcmUn
cyBhbiBpbnRlZ2VyIHNvbHV0aW9uICovDQo+PiAgICAgICAgICByID0gZG9fZGl2KG5fbnVtLCBy
YXRlKTsNCg0KDQotLSANCk1pa2UgTG9vaWptYW5zDQo=
