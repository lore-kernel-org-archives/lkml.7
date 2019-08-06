Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A815FC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B30206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JWrGbIQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbfHFFmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 01:42:10 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:59982
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfHFFmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:42:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZ35JDsyjhCLc9U8CNwez0+TkhbruOLENHIiA6vQHTJGgU374AQUbcXllfSpH1jAtDR9wDOaqNuCNLywrbOHU5VLylkkvCd0d4nNx7pTZfbkvxj5XVrgyznUniDdJ885lkSeQLWjXJnnuG965zWScuIKDdOafgID4qLL+3vqzVUXjQhcL8DK9ZywzlwLbAUu+RjpuE/0iGwOz7mWIfU6aYNbCdJe62FFHlxKmZ78pMHauudfxYDQWaKyANorBCYfVhTwoMVQbUITizaFGoIx7foaRGHvYCj0Ge6tVJcRTu95QmZua8YazwN/528fthPLPykN8cX8+fQ3jFlOfeDtKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySpnPtj+nAJhw3HWY0KdSsGAi8eKVcZHPYzTDwzW0iA=;
 b=j3YTQKf2bVx/HH0syXmodIDO/W8VK0RTZupRp7NuH2jLkCGmJtKoVZy6kTxRQBWeh2t3/0bXLWEnxwlgclZBJjC3UjJkAnLbZT3gl6UMPuogHfHeOw7QVO3fJ3WGNw1GBchV3L7ApsK9oj+2Fs800DkAXV6Leqex7xi5P+NBFmdMH+qNf2jDMaiebvcam2raM3Qd8SCGtu8WDw6S+ai55lF0wHMYvbob0RBuqwBnqzFKvts/FqMU5Pvvrxx29yn3HN7ffa8yzqrNujJfv1PkgViM/juuF+MItcW2AL/zFFNgID9hiPRVRWHSchrlf+ewHG634gZBH6K6HYsZfZKMLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySpnPtj+nAJhw3HWY0KdSsGAi8eKVcZHPYzTDwzW0iA=;
 b=JWrGbIQ6BH1fWSOKf4EAFZYRPYg5wFjxmBs0DMiZYz/bN/tka5TlK1SRiLLYP2Uvt38ORhbnE91mxVWACZ362zMjAKKGS1TMjy5j4viuvrmR1wFW46/Qpr5O2SRu+hNvGc8aaZQ+D86aCkIB5tdqAKarEE7j/ciavQ4FlROyo1E=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3915.eurprd04.prod.outlook.com (52.134.71.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Tue, 6 Aug 2019 05:42:06 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 05:42:05 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "j.neuschaefer@gmx.net" <j.neuschaefer@gmx.net>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        Leo Li <leoyang.li@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 1/4] dt-bindings: arm: imx: Add the soc binding for
 i.MX8MN
Thread-Topic: [PATCH V4 1/4] dt-bindings: arm: imx: Add the soc binding for
 i.MX8MN
Thread-Index: AQHVJkWH8FCDNlj8C0OpehzGXmDK06bt5qDg
Date:   Tue, 6 Aug 2019 05:42:05 +0000
Message-ID: <DB3PR0402MB39162CCE914A9C250CC203BFF5D50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190619022145.42398-1-Anson.Huang@nxp.com>
In-Reply-To: <20190619022145.42398-1-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 637edd3b-8101-4843-3777-08d71a30d0cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3915;
x-ms-traffictypediagnostic: DB3PR0402MB3915:
x-microsoft-antispam-prvs: <DB3PR0402MB391563657ADE1D3EFC05F6F2F5D50@DB3PR0402MB3915.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(189003)(199004)(66446008)(66556008)(44832011)(305945005)(74316002)(7736002)(8936002)(14454004)(8676002)(478600001)(99286004)(186003)(26005)(81156014)(4326008)(446003)(33656002)(11346002)(53936002)(486006)(81166006)(2501003)(9686003)(71200400001)(25786009)(6246003)(476003)(6116002)(316002)(2906002)(3846002)(2201001)(68736007)(6506007)(66066001)(76116006)(229853002)(110136005)(7696005)(6436002)(52536014)(71190400001)(256004)(76176011)(55016002)(86362001)(4744005)(64756008)(7416002)(102836004)(66946007)(66476007)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3915;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7zFdRHDwW2sKsZGoC4D0tJQAEmfG+egYV81Axgm/ifaIFIXWZknjk1AgMTwcua6ztvjZC18/6IL1PtjK6zt63bWNqi/W9FRHMz/BJ2JnfXtV1vgo1/6ecrWtbkbc95TsxYkWiSkOOxnnqOKOqDjLhMYLDbbCuT6VUUbyIWZ2LDmI2xRyOYk7kfox466h4ZPfNbuoz0ROIXEPWaQloQu468dKYG48pq+BYw5kf9XzRYAXZlw/IbdHLqaXJUUE/4BmUYi74MBXWL3FAHPzar7wyPKX6iV0FUwgetKmKfz3b+Wq26c512M5Jjn6ENfW0GolO0VCfAAAc6EtzUVxAmQb040AS8wPW0+FBSurjvxKX0JEuFYDZMmQ6sP6KgJksS0cB3Sgp6pgeEOmrKTpIyw9HiyWzLNJeVfZqPdF7XrAQBM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637edd3b-8101-4843-3777-08d71a30d0cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 05:42:05.8726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZyBmb3IgdGhpcyBwYXRjaCBzZXJpZXMuLi4NCg0KPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5z
b24uSHVhbmdAbnhwLmNvbT4NCj4gDQo+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgc29jICYgYm9hcmQg
YmluZGluZyBmb3IgaS5NWDhNTi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxB
bnNvbi5IdWFuZ0BueHAuY29tPg0KPiBSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2Vy
bmVsLm9yZz4NCj4gLS0tDQo+IE5vIGNoYW5nZS4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sIHwgNiArKysrKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPiBpbmRleCA0MDcxMzhlLi5iMzVhYmIxIDEwMDY0
NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1s
DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwN
Cj4gQEAgLTE3Nyw2ICsxNzcsMTIgQEAgcHJvcGVydGllczoNCj4gICAgICAgICAgICAgICAgLSBm
c2wsaW14OG1tLWV2ayAgICAgICAgICAgICMgaS5NWDhNTSBFVksgQm9hcmQNCj4gICAgICAgICAg
ICAtIGNvbnN0OiBmc2wsaW14OG1tDQo+IA0KPiArICAgICAgLSBkZXNjcmlwdGlvbjogaS5NWDhN
TiBiYXNlZCBCb2FyZHMNCj4gKyAgICAgICAgaXRlbXM6DQo+ICsgICAgICAgICAgLSBlbnVtOg0K
PiArICAgICAgICAgICAgICAtIGZzbCxpbXg4bW4tZGRyNC1ldmsgICAgICAgICAgICAjIGkuTVg4
TU4gRERSNCBFVksgQm9hcmQNCj4gKyAgICAgICAgICAtIGNvbnN0OiBmc2wsaW14OG1uDQo+ICsN
Cj4gICAgICAgIC0gZGVzY3JpcHRpb246IGkuTVg4UVhQIGJhc2VkIEJvYXJkcw0KPiAgICAgICAg
ICBpdGVtczoNCj4gICAgICAgICAgICAtIGVudW06DQo+IC0tDQo+IDIuNy40DQoNCg==
