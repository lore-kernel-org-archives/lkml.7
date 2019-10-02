Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33086C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CDF21A4A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R31Y5mLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfJBNEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:04:47 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:20989
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726775AbfJBNEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:04:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIUmy7ERW+ZZKJufXMUPPD/lQkUlcH9iT8AR/yafpz1iLpCrQNM2NV8azQvIDkpUiUqxtqaCUx8SV6NfNqchIj0zJHWP/M2UGdBwfp+k4SGUl6NiSd82UWtwLfIKrEs/lo7E8sRUmRu77K4gFEPI93mb8rIMr8wpFC3nvrqgJkJrT3lTTxiRRWt5j97CQvDPcL6jyntTJgtbI6DiynuJ37acQwUEbXPSygvj2Fa462SugHKUzLLQMJrzzRKOmmv9t8unwlPbuVI5rNheEA69WHtRaj/9s9FIlVCHuv49NLP/Z88ENkdCwDBIgcnYex9tCyQ1N9DPBC5eH+9MWLGqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPrfZE2ZzlgXwxvs9WgUYsD0eHrzsLPa8Nba2DpTt4o=;
 b=L+MMrpI3Z513NksZlIYED6VR7Nqg0JNvm77eFQEPMA8vdvEgpNuwytcoDhoLmj3y4Y9wm3O5BCQzX7iP0uiWWCniDTd3tlx7ROOKb8fICi+NhBbH/X/1ZigRlo0VOlztzpRnT2e0aIhlcl06WWBqI+TXCqRD6m8r1cU+kiF1Y2UfJW2aGv+a72Cp4jJGJwKph6bmWc8cfX3ueAdMcjAxGTimaBTiF7kz2GOtwKr+IYiNOsn9pef9L/CZsBSOl66lM/Gh9J1u0LA4tLe4uXuJxivmRCT7Fp9iEpUwqwc/leyPwBX6ubo559FEQd4ztL9aEsQjy3yEiv6nP5pNSKJ1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPrfZE2ZzlgXwxvs9WgUYsD0eHrzsLPa8Nba2DpTt4o=;
 b=R31Y5mLaFkn0bDIUhz/ak+oezkkqV5xYyrBFVEAEYXrPy1VymzIjiZyfDMor+Q35S/45NzxzUG5wW9Pdoh0vS6TDkXTWKQgJkWigxCEyO6tUBPk0NbQD/JOmoQcjfu4+dnrtCo7SCOHPwXHWC+gteRs7KApEHuGiQZN4Op/YK9Q=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3918.eurprd04.prod.outlook.com (52.134.17.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Wed, 2 Oct 2019 13:04:40 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::fd33:c447:3cab:c36]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::fd33:c447:3cab:c36%7]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 13:04:40 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Eddy Petrisor <eddy.petrisor@nxp.com>
Subject: [PATCH v5 1/5] dt-bindings: arm: fsl: Add the S32V234-EVB board
Thread-Topic: [PATCH v5 1/5] dt-bindings: arm: fsl: Add the S32V234-EVB board
Thread-Index: AQHVeSHzRt15gcIyzkiIQ4Txg/5+kA==
Date:   Wed, 2 Oct 2019 13:04:39 +0000
Message-ID: <20191002130425.28905-2-stefan-gabriel.mirea@nxp.com>
References: <20191002130425.28905-1-stefan-gabriel.mirea@nxp.com>
In-Reply-To: <20191002130425.28905-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: PR0P264CA0194.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::14) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.240.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f627acc0-ee0d-4b92-eab0-08d74739157e
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR0402MB3918:|VI1PR0402MB3918:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3918BB5E0A2AB0801ECC41C6DF9C0@VI1PR0402MB3918.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(189003)(199004)(102836004)(2201001)(5660300002)(26005)(478600001)(76176011)(486006)(386003)(14454004)(50226002)(8676002)(8936002)(81156014)(305945005)(81166006)(6506007)(7736002)(7416002)(64756008)(6436002)(66556008)(66446008)(476003)(66066001)(2906002)(11346002)(2616005)(66476007)(6486002)(66946007)(25786009)(52116002)(2501003)(186003)(256004)(446003)(6512007)(6116002)(3846002)(36756003)(71190400001)(71200400001)(4744005)(4326008)(1076003)(86362001)(54906003)(99286004)(110136005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3918;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ffrcKV9octv4hUr04GUPxqd9ul8qDrUoWIosZTto5xX72hSM7LDFHN5audHzjvcYIq+9oEc0q8OV4LgVu2//G8B2/ZV8hpkG5d69LwKaQfIxUV7ZdW1FwQD8kaHAZUmTQ0nhB88Yn6ktB9eN34vOyA9TgwITyeaJMA5DfEPGuagiA/We4CRzXJ7AXo8JLK31mCkZ/BQNlywKcClVEwg+uETIgg3uOD9T3rLkkbnVj7cHJchSuttvT+ZZbwAC3eHi/CbNMhCMaezVjlzeRyQZafSug7F3h3fE08ikS1ezLqnqdEQK93ME1tcRBR8MUSPJnl3oUIzoB7zWZ7NueowGjFL7I8IxdkMoZg4ISetsCPu/WyKZKNDuDsAzsaPCyLgslSoKA0KBcd2r1aaw4pR+c1zqFMCbQtyIc4rL3HPKnPE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <645189E856AA654A9F01C6C622055648@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f627acc0-ee0d-4b92-eab0-08d74739157e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 13:04:39.8940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EcehjH3yVlK2x7Jza/0NxewzMEUAT07HW3LqwD+koHH6XzCQ/p3n2UPllTX2rh7roXzunSIzkuQfUzxg9f+KqA1xNazm2YlQN7u1r1uijWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRWRkeSBQZXRyaciZb3IgPGVkZHkucGV0cmlzb3JAbnhwLmNvbT4NCg0KQWRkIGVudHJ5
IGZvciB0aGUgTlhQIFMzMlYyMzQgQ3VzdG9tZXIgRXZhbHVhdGlvbiBCb2FyZCB0byB0aGUgYm9h
cmQvU29DDQpiaW5kaW5ncy4NCg0KU2lnbmVkLW9mZi1ieTogRWRkeSBQZXRyaciZb3IgPGVkZHku
cGV0cmlzb3JAbnhwLmNvbT4NClNpZ25lZC1vZmYtYnk6IFN0ZWZhbi1HYWJyaWVsIE1pcmVhIDxz
dGVmYW4tZ2FicmllbC5taXJlYUBueHAuY29tPg0KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxy
b2JoQGtlcm5lbC5vcmc+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL2ZzbC55YW1sIHwgNiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
DQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2Zz
bC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0K
aW5kZXggMWI0YjRlNjU3M2I1Li5jMjExZjRmODJlMjUgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sDQpAQCAtMzM1LDQgKzMzNSwxMCBAQCBw
cm9wZXJ0aWVzOg0KICAgICAgICAgICAgICAgLSBmc2wsbHMyMDg4YS1yZGINCiAgICAgICAgICAg
LSBjb25zdDogZnNsLGxzMjA4OGENCiANCisgICAgICAtIGRlc2NyaXB0aW9uOiBTMzJWMjM0IGJh
c2VkIEJvYXJkcw0KKyAgICAgICAgaXRlbXM6DQorICAgICAgICAgIC0gZW51bToNCisgICAgICAg
ICAgICAgIC0gZnNsLHMzMnYyMzQtZXZiICAgICAgICAgICAjIFMzMlYyMzQtRVZCMiBDdXN0b21l
ciBFdmFsdWF0aW9uIEJvYXJkDQorICAgICAgICAgIC0gY29uc3Q6IGZzbCxzMzJ2MjM0DQorDQog
Li4uDQotLSANCjIuMjIuMA0KDQo=
