Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431FCC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 19:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56F020675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 19:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="LKolj9bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfD3Twl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 15:52:41 -0400
Received: from mail-eopbgr60118.outbound.protection.outlook.com ([40.107.6.118]:47920
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbfD3Twl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 15:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CltSQ+tEu+0tEJ3lFDpmWFfzw47uHifqGmiTuIsdZQ=;
 b=LKolj9bi9lmvU4rBfJo18EL0HTj4coL6+M/05OOTSI8o24YQiwY6ozQQtO5QDB6QjRzULEB666M9bYOP3BbQDb1PQV0tQR4dAy50gJqbhRZL4yIf5Q+FziZCuvk7LWRByfCG0DjDEXbvELu7z0fj6+evULvPWEElVQT0bk8oVqY=
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com (20.178.17.97) by
 AM0PR02MB4609.eurprd02.prod.outlook.com (20.178.17.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Tue, 30 Apr 2019 19:52:33 +0000
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::e80e:1cbb:5e37:b8c7]) by AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::e80e:1cbb:5e37:b8c7%2]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 19:52:33 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH 0/2] mux: a couple of patches for 5.2-rc1
Thread-Topic: [PATCH 0/2] mux: a couple of patches for 5.2-rc1
Thread-Index: AQHU/45Aj/Xkr8CzKUmxYl1+igFYNQ==
Date:   Tue, 30 Apr 2019 19:52:33 +0000
Message-ID: <20190430195226.8965-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1P189CA0028.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::41)
 To AM0PR02MB4563.eurprd02.prod.outlook.com (2603:10a6:208:ec::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33626432-a5e5-449b-5373-08d6cda562e8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM0PR02MB4609;
x-ms-traffictypediagnostic: AM0PR02MB4609:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR02MB460966E82B7EB85D382598F0BC3A0@AM0PR02MB4609.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(25786009)(66946007)(73956011)(81166006)(81156014)(66446008)(64756008)(66556008)(66476007)(8676002)(4326008)(97736004)(2906002)(68736007)(53936002)(74482002)(6116002)(6306002)(8936002)(6512007)(3846002)(36756003)(50226002)(6486002)(2501003)(6436002)(2351001)(5640700003)(26005)(316002)(186003)(7736002)(305945005)(52116002)(99286004)(102836004)(5660300002)(386003)(6506007)(54906003)(508600001)(486006)(86362001)(1076003)(966005)(14444005)(256004)(6916009)(2616005)(476003)(66066001)(14454004)(71200400001)(71190400001)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB4609;H:AM0PR02MB4563.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Xoqwi+ZhHWm/pFwmR+0PaPgsbggmYjXaoACpZSTnnapQmDj4X2JsvrMojZsice1Gx5grte0AMaAbuf9btMBiks+NnxIZpD/mkGNeBawVx5f5ywzYYvUzNqWw6nq1LLVsmKRCRhPgS2QRR+AH51L+MX7MLCtRvQmi5a2kpnZfJzAMzZQxqAbvh+fQ6qk6bPXbIgNYJt0tKI+lgDjiEsa7UWHMQIilCyclFcBqzmiiTkCNA23q0vLjFHWSaOAepxc8KwpByAiSiztr/jq3xjhhEWSBQUggy0HCYHxZllCSJ9T/XE+1UQVSo7ZmWN2pmqLuRdzjLjfY+co3SA2AbC/QiMwBflI7erOrJYhWxKnnevqm5cpssftWvzq6DGJ/2LIIIX1rf8+Sj1eOwrXgQS+TnmJ6Xre0QBJpWRR7vUfP5iI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 33626432-a5e5-449b-5373-08d6cda562e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 19:52:33.6207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KQSBzbWFsbCBhZGRpdGlvbiB0byB0aGUgbW1pbyBtdXggc28gdGhhdCBpdCBj
YW4gaGFuZGxlIG5vbi1zeXNjb24NCnJlZ21hcHMuIFRoZSBiaW5kaW5ncyBwYXRjaCBzaG91bGQg
cHJvYmFibHkgaGF2ZSBoYWQgUm9icyB0YWcsDQpidXQgYWZ0ZXIgYSBiaXQgb2YgYmFjayBhbmQg
Zm9ydGggSSBnb3QgdGhlIGltcHJlc3Npb24gdGhhdCBpdA0Kd2Fzbid0IHJlYWxseSBuZWVkZWQs
IHNpbmNlIGl0J3MgYmFzaWNhbGx5IGp1c3QgYSBmaWxlIHJlbmFtZQ0KcGx1cyBhZGRpdGlvbiBv
ZiBhIGNvbXBhdGlibGUgWzFdLiBUaGUgcGF0Y2hlcyBoYXZlIGJlZW4gaW4gLW5leHQNCmZvciBh
IHdlZWsgb3Igc28uDQoNCkJ1dCwgaWYgSSBtaXN1bmRlcnN0b29kIG9yIGlmIHlvdSBoYXZlIGEg
dGFnIHRvIHNwYXJlIFJvYiwgbm93DQppcyB0aGUgdGltZS4gOi0pDQoNCkNoZWVycywNClBldGVy
DQoNClsxXSBodHRwczovL21hcmMuaW5mby8/bD1kZXZpY2V0cmVlJm09MTU1MTIxODQzNTAzNTkw
DQoiVGhhdCB3b3VsZCBoYXZlIHNhdmVkIG1lIHJldmlld2luZyB0aGUgd2hvbGUgdGhpbmcgYWdh
aW4uLi4iDQoNClBhbmthaiBCYW5zYWwgKDIpOg0KICBkdC1iaW5kaW5nczogYWRkIHJlZ2lzdGVy
IGJhc2VkIGRldmljZXMnIG11eCBjb250cm9sbGVyIERUIGJpbmRpbmdzDQogIG11eDogbW1pbzog
YWRkIGdlbmVyaWMgcmVnbWFwIGJpdGZpZWxkLWJhc2VkIG11bHRpcGxleGVyDQoNCiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXV4L21taW8tbXV4LnR4dCB8ICA2MCAtLS0tLS0t
LS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL211eC9yZWctbXV4LnR4dCAg
fCAxMjkgKysrKysrKysrKysrKysrKysrKysrDQogZHJpdmVycy9tdXgvS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTIgKy0NCiBkcml2ZXJzL211eC9tbWlvLmMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNiArLQ0KIDQgZmlsZXMgY2hhbmdlZCwg
MTQwIGluc2VydGlvbnMoKyksIDY3IGRlbGV0aW9ucygtKQ0KIGRlbGV0ZSBtb2RlIDEwMDY0NCBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXV4L21taW8tbXV4LnR4dA0KIGNyZWF0
ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXV4L3JlZy1t
dXgudHh0DQoNCi0tIA0KMi4xMS4wDQoNCg==
