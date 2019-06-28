Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EABBC5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A152086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="t3LWMp68";
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="t3LWMp68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfF1GmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:42:16 -0400
Received: from mail-eopbgr50050.outbound.protection.outlook.com ([40.107.5.50]:41142
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726648AbfF1GmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:42:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=wjgX4vtRgJz9XlABmtwhVQAGPlT/F/GuXMUxc4okERsDACs6pdxuYXcZmQZy9794a9zyrzlWBMKnRSgL7+aLrSxsxvPCgDYEBTCbRBcd5fuD2hISwrEd9/Yx4iY03ScPmvpRvbjuozoFoD6+WuwUfkjL6lTYlM42XuAsCGGMEL0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwzE1sHOqaLUidb5inxc+PDrGziKwOnAADVzCn9e7nA=;
 b=pD1vUDSZLt1jIJfdUOfz+gtdMVRHA5X9QFeN6vFl1XlDqw+t2LN0MynB0omMqnYJoCaGN0uElEfInAyjshdB4CqTz7MaQ70JuooZOoVux+/J2U07aEN2uRELm7Ylw1EF2kURJokCGY5bHha4WIWIlJt6wAE4V0C2PzpjnZjN73Q=
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 52.166.56.231) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=topicproducts.com;dmarc=none action=none
 header.from=topic.nl;dkim=pass (signature was verified)
 header.d=topicbv.onmicrosoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector1-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwzE1sHOqaLUidb5inxc+PDrGziKwOnAADVzCn9e7nA=;
 b=t3LWMp68RqMcb8BZ7+gv+llKdMzdSiRrY53PnMR+8HM1ibedlKGtZKuNXOBkKextg7DRs58ikEFGr5yh5wSXcu4BZQ4+sGf0WplWvwlAQSZwY3gv/c3SxHKL/9pElK/52v5AQCOw194l7vLv3KpObxGh5nuhgxi5cedILSyaKj8=
Received: from AM3PR04CA0127.eurprd04.prod.outlook.com (2603:10a6:207::11) by
 AM6PR0402MB3943.eurprd04.prod.outlook.com (2603:10a6:209:1c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Fri, 28 Jun
 2019 06:42:10 +0000
Received: from VE1EUR01FT006.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e01::201) by AM3PR04CA0127.outlook.office365.com
 (2603:10a6:207::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Fri, 28 Jun 2019 06:42:10 +0000
Authentication-Results: spf=pass (sender IP is 52.166.56.231)
 smtp.mailfrom=topicproducts.com; kernel.org; dkim=pass (signature was
 verified) header.d=topicbv.onmicrosoft.com;kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 52.166.56.231 as permitted sender)
 receiver=protection.outlook.com; client-ip=52.166.56.231;
 helo=westeu11-emailsignatures-cloud.codetwo.com;
Received: from westeu11-emailsignatures-cloud.codetwo.com (52.166.56.231) by
 VE1EUR01FT006.mail.protection.outlook.com (10.152.2.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Fri, 28 Jun 2019 06:42:07 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (104.47.2.57) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 28 Jun 2019 06:42:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector1-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwzE1sHOqaLUidb5inxc+PDrGziKwOnAADVzCn9e7nA=;
 b=t3LWMp68RqMcb8BZ7+gv+llKdMzdSiRrY53PnMR+8HM1ibedlKGtZKuNXOBkKextg7DRs58ikEFGr5yh5wSXcu4BZQ4+sGf0WplWvwlAQSZwY3gv/c3SxHKL/9pElK/52v5AQCOw194l7vLv3KpObxGh5nuhgxi5cedILSyaKj8=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (10.255.168.18) by
 AM6PR04MB5510.eurprd04.prod.outlook.com (20.178.93.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.17; Fri, 28 Jun 2019 06:42:04 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d131:60b8:d270:2d31]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d131:60b8:d270:2d31%3]) with mapi id 15.20.2008.014; Fri, 28 Jun 2019
 06:42:03 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v3] clk: Add Si5341/Si5340 driver
Thread-Topic: [PATCH v3] clk: Add Si5341/Si5340 driver
Thread-Index: AQHVDLPMIEuInQjXdEeduGfQk/CG7aawPvwAgACgywA=
Date:   Fri, 28 Jun 2019 06:42:03 +0000
Message-ID: <41fd54ba-1acc-eb44-dcb0-0d52e570ae72@topic.nl>
References: <20190424090038.18353-1-mike.looijmans@topic.nl>
 <155623538292.15276.10999401088770081919@swboyd.mtv.corp.google.com>
 <20190517132352.31221-1-mike.looijmans@topic.nl>
 <20190627210633.A21EC2075E@mail.kernel.org>
In-Reply-To: <20190627210633.A21EC2075E@mail.kernel.org>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-clientproxiedby: AM0PR05CA0056.eurprd05.prod.outlook.com
 (2603:10a6:208:be::33) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d9::18)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.173.50.109]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 98a0d053-0f09-4061-a2be-08d6fb93bec5
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR04MB5510;
X-MS-TrafficTypeDiagnostic: AM6PR04MB5510:|AM6PR0402MB3943:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3943E72F8ECDACE8F310ECBF96FC0@AM6PR0402MB3943.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:7691;
x-forefront-prvs: 00826B6158
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(39840400004)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(51914003)(14454004)(73956011)(66946007)(110136005)(54906003)(446003)(68736007)(31686004)(58126008)(2616005)(316002)(11346002)(71200400001)(5660300002)(71190400001)(476003)(42882007)(186003)(52116002)(66476007)(99286004)(386003)(6506007)(64756008)(53546011)(76176011)(66446008)(65826007)(66556008)(26005)(6246003)(14444005)(7736002)(44832011)(74482002)(6116002)(229853002)(64126003)(31696002)(8676002)(102836004)(6436002)(6486002)(3846002)(486006)(2906002)(2501003)(4326008)(25786009)(8936002)(6512007)(36756003)(53936002)(508600001)(66066001)(81156014)(65956001)(256004)(81166006)(65806001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5510;H:AM6PR04MB6341.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: dL7Kb0CBtmlMlwzk2rEimtVVuLtUczwxFRLbh+upuSQk/ROnb7G3MuPe+wU4rIcifzRNzLAPad/6CTqCYy+2pXOVSDBOVrbl3a6YMua7+daMKdE6MiytOLQS5dLqOj2gMVA8DrEMJf9+yyw1mccWE243IqgKjhwYJHYd4zdKkNYkSD1wJ+V7+dr5/mMxZNQQHMhEGrvXcblSrxPHt8QlwweA3Lv4+Z07OoPJhFaIl8VxYZn9XyrFcb6g2dD28w18YZ2chqzbCIGIcC20lRJwQGqwMxiBzah4Oc2q9Q+sWwqfcLQ2YX2bm76wiYsRA1HIZMOp9RQ1W/p+Dd6MOWvrWTEKaWojSFsL6kDBBNGFNOgHeZREFtzwuAaoWb0dHkbP/7/3pZNz/unlDKuzaKlWyum78U9w69FZT2kSISwNE1E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F486ACA22FAE94994A00FE546945DA0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5510
X-CodeTwo-MessageID: 41365bf4-4b82-4e73-aab5-b82dfe198b49.20190628064205@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT006.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:52.166.56.231;IPV:NLI;CTRY:NL;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(39840400004)(2980300002)(189003)(51914003)(199004)(14454004)(508600001)(26005)(436003)(356004)(3846002)(42882007)(246002)(229853002)(102836004)(11346002)(36756003)(58126008)(25786009)(7596002)(4326008)(305945005)(8676002)(316002)(31686004)(8936002)(336012)(486006)(6246003)(106002)(2501003)(6512007)(54906003)(7636002)(7736002)(47776003)(110136005)(2486003)(53546011)(186003)(74482002)(44832011)(65806001)(76176011)(23676004)(64126003)(99286004)(6116002)(6506007)(65826007)(70586007)(14444005)(66066001)(65956001)(386003)(446003)(70206006)(31696002)(6486002)(476003)(2616005)(126002)(50466002)(2906002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3943;H:westeu11-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:westeu11-emailsignatures-cloud.codetwo.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: bc6926b2-c1c7-4380-0e96-08d6fb93bafc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR0402MB3943;
X-Forefront-PRVS: 00826B6158
X-Microsoft-Antispam-Message-Info: 8/0d2CuqEeMmGENP9f9QEmqUQ3qJmWHSYdc4BrkPn8Cfw+tm2puML/eSkmk9jsu5RlqmSO2C8+2zgsNU7zu7CossszWgOUO6Kj6Su63+gkf+T6mWJ39teclDDR4zXsy6HObpMEqst0tDOjWpU/1BPqtfMwIuS2zABS6GSvM4lVcutxWK4D2J82SMYXBXSWUSsvHVmtoRB1YwrlhQ+n/3wZQnkIZNbU8Xl++F0PUNlAO7zLgOCV9tQUYSiV7mHt5qM2co3VUDEz9KGKdhmGzgMgLhAJYAlJuCLfdMNijIccsjtCA78GAvfb8a2I9jSvE9T2azr9Tyba++d8BRgFvHl155uNThXcT2CjmS0mOAdCRP0dYbOC5ff9ZSDZRvh5flCfiAORLUY1z8cBguq6o/C5bmP+A3+H7BMl1R2VCfoaY=
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2019 06:42:07.9336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a0d053-0f09-4061-a2be-08d6fb93bec5
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[52.166.56.231];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjctMDYtMTkgMjM6MDYsIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4gUXVvdGluZyBNaWtlIExv
b2lqbWFucyAoMjAxOS0wNS0xNyAwNjoyMzo1MikNCj4+IEFkZHMgYSBkcml2ZXIgZm9yIHRoZSBT
aTUzNDEgYW5kIFNpNTM0MCBjaGlwcy4gVGhlIGRyaXZlciBkb2VzIG5vdCBmdWxseQ0KPj4gc3Vw
cG9ydCBhbGwgZmVhdHVyZXMgb2YgdGhlc2UgY2hpcHMsIGJ1dCBhbGxvd3MgdGhlIGNoaXAgdG8g
YmUgdXNlZA0KPj4gd2l0aG91dCBhbnkgc3VwcG9ydCBmcm9tIHRoZSAiY2xvY2tidWlsZGVyIHBy
byIgc29mdHdhcmUuDQo+Pg0KPj4gSWYgdGhlIGNoaXAgaXMgcHJlcHJvZ3JhbW1lZCwgdGhhdCBp
cywgeW91IGJvdWdodCBvbmUgd2l0aCBzb21lIGRlZmF1bHRzDQo+PiBidXJuZWQgaW4sIG9yIHlv
dSBwcm9ncmFtbWVkIHRoZSBOVk0gaW4gc29tZSB3YXksIHRoZSBkcml2ZXIgd2lsbCBqdXN0DQo+
PiB0YWtlIG92ZXIgdGhlIGN1cnJlbnQgc2V0dGluZ3MgYW5kIG9ubHkgY2hhbmdlIHRoZW0gb24g
ZGVtYW5kLiBPdGhlcndpc2UNCj4+IHRoZSBpbnB1dCBtdXN0IGJlIGEgZml4ZWQgWFRBTCBpbiBp
dHMgbW9zdCBiYXNpYyBjb25maWd1cmF0aW9uIChubw0KPj4gcHJlZGl2aWRlcnMsIG5vIGZlZWRi
YWNrLCBldGMuKS4NCj4+DQo+PiBUaGUgZHJpdmVyIHN1cHBvcnRzIGR5bmFtaWMgY2hhbmdlcyBv
ZiBtdWx0aXN5bnRoLCBvdXRwdXQgZGl2aWRlcnMgYW5kDQo+PiBlbmFibGluZyBvciBwb3dlcmlu
ZyBkb3duIG91dHB1dHMgYW5kIG11bHRpc3ludGhzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE1p
a2UgTG9vaWptYW5zIDxtaWtlLmxvb2lqbWFuc0B0b3BpYy5ubD4NCj4+IC0tLQ0KPiANCj4gQXBw
bGllZCB0byBjbGstbmV4dCArIHNvbWUgZml4ZXMuIEknbSBub3Qgc3VwZXIgdGhyaWxsZWQgYWJv
dXQgdGhlIGtIeg0KPiB0aGluZyBidXQgd2UgZG9uJ3QgaGF2ZSBhIHNvbHV0aW9uIGZvciBpdCBy
aWdodCBub3cgc28gbWlnaHQgYXMgd2VsbA0KPiBjb21lIGJhY2sgdG8gaXQgbGF0ZXIuDQoNClRo
YW5rcyBmb3IgdGhlIGZpeGVzLiBBbmQgSSdtIG5vdCBleGFjdGx5IHByb3VkIG9mIHRoYXQga0h6
IHBhcnQgZWl0aGVyLg0KDQpXaGlsZSB0aGlua2luZyBhYm91dCBhIHNvbHV0aW9uLCBJJ3ZlIGFs
c28gaGFkIGEgdXNlIGNhc2UgZm9yIGxlc3MgdGhhbiAxSHogDQpmcmVxdWVuY3kgYWRqdXN0bWVu
dCAoYSB2aWRlbyBjbG9jayB0byAiZm9sbG93IiBhbm90aGVyIG9uZSkuIFRoZXNlIGNsb2NrIA0K
Z2VuZXJhdG9ycyBhbGxvdyBmb3IgcmlkaWN1bG91cyByYW5nZXMgYW5kIGFjY3VyYWN5LCB5b3Ug
Y2FuIHJlcXVlc3QgaXQgdG8gDQpnZW5lcmF0ZSBhIDIwMDAwMDAwMC4wMDA1IEh6IGNsb2NrLg0K
DQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2Nsay1zaTUzNDEuYyBiL2RyaXZlcnMvY2xr
L2Nsay1zaTUzNDEuYw0KPiBpbmRleCAxYTMxMDgzNWI1M2MuLjcyNDI0ZWI3ZTVmOCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9jbGsvY2xrLXNpNTM0MS5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2Ns
ay1zaTUzNDEuYw0KPiBAQCAtMzc0LDcgKzM3NCw3IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIHNp
NTM0MV9jbGtfcmVjYWxjX3JhdGUoc3RydWN0IGNsa19odyAqaHcsDQo+ICAgCSAqLw0KPiAgIAlz
aGlmdCA9IDA7DQo+ICAgCXJlcyA9IG1fbnVtOw0KPiAtCXdoaWxlIChyZXMgJiAweGZmZmYwMDAw
MDAwMCkgew0KPiArCXdoaWxlIChyZXMgJiAweGZmZmYwMDAwMDAwMFVMTCkgew0KPiAgIAkJKytz
aGlmdDsNCj4gICAJCXJlcyA+Pj0gMTsNCj4gICAJfQ0KPiBAQCAtOTIxLDcgKzkyMSw3IEBAIHN0
YXRpYyBpbnQgc2k1MzQxX3dyaXRlX211bHRpcGxlKHN0cnVjdCBjbGtfc2k1MzQxICpkYXRhLA0K
PiAgIAlyZXR1cm4gMDsNCj4gICB9DQo+ICAgDQo+IC1jb25zdCBzdHJ1Y3Qgc2k1MzQxX3JlZ19k
ZWZhdWx0IHNpNTM0MV9wcmVhbWJsZVtdID0gew0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBzaTUz
NDFfcmVnX2RlZmF1bHQgc2k1MzQxX3ByZWFtYmxlW10gPSB7DQo+ICAgCXsgMHgwQjI1LCAweDAw
IH0sDQo+ICAgCXsgMHgwNTAyLCAweDAxIH0sDQo+ICAgCXsgMHgwNTA1LCAweDAzIH0sDQo+IEBA
IC05OTQsNyArOTk0LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCByZWdtYXBfcmFuZ2Ugc2k1MzQx
X3JlZ21hcF92b2xhdGlsZV9yYW5nZVtdID0gew0KPiAgIAlyZWdtYXBfcmVnX3JhbmdlKFNJNTM0
MV9TWU5USF9OX1VQRCg0KSwgU0k1MzQxX1NZTlRIX05fVVBEKDQpKSwNCj4gICB9Ow0KPiAgIA0K
PiAtY29uc3Qgc3RydWN0IHJlZ21hcF9hY2Nlc3NfdGFibGUgc2k1MzQxX3JlZ21hcF92b2xhdGls
ZSA9IHsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcmVnbWFwX2FjY2Vzc190YWJsZSBzaTUzNDFf
cmVnbWFwX3ZvbGF0aWxlID0gew0KPiAgIAkueWVzX3JhbmdlcyA9IHNpNTM0MV9yZWdtYXBfdm9s
YXRpbGVfcmFuZ2UsDQo+ICAgCS5uX3llc19yYW5nZXMgPSBBUlJBWV9TSVpFKHNpNTM0MV9yZWdt
YXBfdm9sYXRpbGVfcmFuZ2UpLA0KPiAgIH07DQo+IEBAIC0xMDE2LDcgKzEwMTYsNiBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IHJlZ21hcF9jb25maWcgc2k1MzQxX3JlZ21hcF9jb25maWcgPSB7DQo+
ICAgCS5yZWdfYml0cyA9IDgsDQo+ICAgCS52YWxfYml0cyA9IDgsDQo+ICAgCS5jYWNoZV90eXBl
ID0gUkVHQ0FDSEVfUkJUUkVFLA0KPiAtCS5tYXhfcmVnaXN0ZXIgPSAwLA0KPiAgIAkucmFuZ2Vz
ID0gc2k1MzQxX3JlZ21hcF9yYW5nZXMsDQo+ICAgCS5udW1fcmFuZ2VzID0gQVJSQVlfU0laRShz
aTUzNDFfcmVnbWFwX3JhbmdlcyksDQo+ICAgCS5tYXhfcmVnaXN0ZXIgPSBTSTUzNDFfUkVHSVNU
RVJfTUFYLA0KPiBAQCAtMTMyOCw3ICsxMzI3LDcgQEAgTU9EVUxFX0RFVklDRV9UQUJMRShpMmMs
IHNpNTM0MV9pZCk7DQo+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgY2xrX3Np
NTM0MV9vZl9tYXRjaFtdID0gew0KPiAgIAl7IC5jb21wYXRpYmxlID0gInNpbGFicyxzaTUzNDAi
IH0sDQo+ICAgCXsgLmNvbXBhdGlibGUgPSAic2lsYWJzLHNpNTM0MSIgfSwNCj4gLQl7IH0sDQo+
ICsJeyB9DQo+ICAgfTsNCj4gICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBjbGtfc2k1MzQxX29m
X21hdGNoKTsNCj4gICANCj4gDQoNCg==
