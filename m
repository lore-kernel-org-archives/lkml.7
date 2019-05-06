Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D44C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DC820830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="GFEAaB3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfEFMmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:42:19 -0400
Received: from mail-eopbgr60102.outbound.protection.outlook.com ([40.107.6.102]:57157
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfEFMmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O62tVsgL+oWm4E088Z87lmV6N4dXK6oAaqLCJJb3U/c=;
 b=GFEAaB3IXSnHo55YpPO0KksWHXcKSYqri6M6E7W7CCYLlex09AfXOIQDTk219yY+cX/Nbkx+RvqNv8zIl/4QjinPuC+k724zLjiz78eEEZ3GSeLa4GvmUDArT1+uvRX3FlbTKpdd/x9+Kwl8ZWIQtcxtCpGbUydUeNvbQN/dvB4=
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com (20.178.17.97) by
 AM0PR02MB3954.eurprd02.prod.outlook.com (20.177.43.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.14; Mon, 6 May 2019 12:42:14 +0000
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::59ed:e49a:eab8:168f]) by AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::59ed:e49a:eab8:168f%3]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 12:42:14 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/3] lib/string: search for NUL with strchr/strnchr
Thread-Topic: [PATCH 0/3] lib/string: search for NUL with strchr/strnchr
Thread-Index: AQHVBAkhtell4TFN3kaipOcHUQ42QQ==
Date:   Mon, 6 May 2019 12:42:14 +0000
Message-ID: <20190506124205.6565-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0402CA0008.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::18) To AM0PR02MB4563.eurprd02.prod.outlook.com
 (2603:10a6:208:ec::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddabe592-c9cb-4db1-271e-08d6d2204429
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM0PR02MB3954;
x-ms-traffictypediagnostic: AM0PR02MB3954:
x-microsoft-antispam-prvs: <AM0PR02MB3954021B88CA08AD3677C9E8BC300@AM0PR02MB3954.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39830400003)(346002)(366004)(136003)(199004)(189003)(68736007)(1076003)(52116002)(99286004)(66946007)(4744005)(71190400001)(66066001)(73956011)(74482002)(102836004)(7736002)(2351001)(256004)(66446008)(14444005)(66476007)(305945005)(486006)(64756008)(476003)(5660300002)(54906003)(66556008)(2616005)(71200400001)(14454004)(50226002)(8676002)(26005)(186003)(8936002)(3846002)(6116002)(81156014)(81166006)(86362001)(6436002)(5640700003)(2501003)(6506007)(386003)(36756003)(6512007)(316002)(4326008)(6916009)(53936002)(2906002)(508600001)(25786009)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB3954;H:AM0PR02MB4563.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5DwSkGcai4dHXt29DbyS6bTjTpBgwTamroj7p3igIdk3MrDUfHO+WHWXxajF/7Uh8p02ArnfG9ypWEx/ep4K4Oqdn9O5ocAO0och1RvOubMMEiLT1BD/6a3bafVq47fFHigEt9cXa62Bb4/12OmOB3wqMtlBG5XgvklOqeL1aqV/hrY8OrIGflA8clb9nUY0B6RW8Gj1IuIpqohmCQ6+PaERJhRcHRiO2+fqLy34fiFM9hSMlAcAduaMmj+rrzLucpTLt/3v1f1zKyMrBoUKKyumDY+xQdwnIC9EbsYtPAmg2Xb2200gAd2Su0FQVqZd2Tz/nNujuz3YTk9u+wDWmmqLpDqfraA6KqHfV4I/Rje0Rivg1Cscz8kEGcEXJOiseWvfRFoZrpMsvVUr8TrZ4QdOv8TFJhPeAoGALePcUyw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ddabe592-c9cb-4db1-271e-08d6d2204429
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 12:42:14.7256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB3954
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkhDQoNCkkgbm90aWNlZCBhbiBpbmNvbnNpc3RlbmN5IHdoZXJlIHN0cmNociBhbmQgc3RybmNo
ciBkbyBub3QgYmVoYXZlIHRoZQ0Kc2FtZSB3aXRoIHJlc3BlY3QgdG8gdGhlIHRyYWlsaW5nIE5V
TC4gc3RyY2hyIGlzIHN0YW5kYXJkaXNlZCBhbmQgdGhlDQprZXJuZWwgZnVuY3Rpb24gY29uZm9y
bXMsIGFuZCB0aGUga2VybmVsIHJlbGllcyBvbiB0aGUgYmVoYXZpb3IuDQpTbywgbmF0dXJhbGx5
IHN0cmNociBzdGF5cyBhcy1pcyBhbmQgc3RybmNociBpcyB3aGF0IEkgY2hhbmdlLg0KDQpXaGls
ZSB3cml0aW5nIGEgZmV3IHRlc3RzIHRvIHZlcmlmeSB0aGF0IG15IG5ldyBzdHJuY2hyIGxvb3Ag
d2FzIHNhbmUsIEkNCm5vdGljZWQgdGhhdCB0aGUgdGVzdHMgZm9yIG1lbXNldDE2LzMyLzY0IGhh
ZCBhIHByb2JsZW0uIFNpbmNlIGl0J3MgYWxsDQphYm91dCB0aGUgbGliL3N0cmluZy5jIGZpbGUg
SSBtYWRlIGEgc2hvcnQgc2VyaWVzIG9mIGl0IGFsbC4uLg0KDQpCdXQgd2hlcmUgdG8gc2VuZCBp
dD8gZ2V0X21haW50YWluZXIgc3VnZ2VzdHMgbm8gdmljdGltLCBzbyBJJ20gYWltaW5nDQphdCB0
aG9zZSB0aGF0IHNpZ25lZC1vZmYgb24gdGhlIG1lbXNldDE2LzMyLzY0IGJ1Zy4uLg0KDQpDaGVl
cnMsDQpQZXRlcg0KDQpQZXRlciBSb3NpbiAoMyk6DQogIGxpYi9zdHJpbmc6IGFsbG93IHNlYXJj
aGluZyBmb3IgTlVMIHdpdGggc3RybmNocg0KICBsaWIvdGVzdF9zdHJpbmc6IGF2b2lkIG1hc2tp
bmcgbWVtc2V0MTYvMzIvNjQgZmFpbHVyZXMNCiAgbGliL3Rlc3Rfc3RyaW5nOiBhZGQgc29tZSB0
ZXN0Y2FzZXMgZm9yIHN0cmNociBhbmQgc3RybmNocg0KDQogbGliL3N0cmluZy5jICAgICAgfCAx
MSArKysrKysrLQ0KIGxpYi90ZXN0X3N0cmluZy5jIHwgODMgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KIDIgZmlsZXMgY2hhbmdlZCwgOTAg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjExLjANCg0K
