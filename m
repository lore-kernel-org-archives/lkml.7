Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADD3C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E6525328
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="FjU8OleT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfE3IqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:46:06 -0400
Received: from mail-eopbgr70131.outbound.protection.outlook.com ([40.107.7.131]:14004
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726031AbfE3IqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector1-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmZ4re9OSeI53YY1QNkXH/gRoZ2eJFx/M7C/tapPg7s=;
 b=FjU8OleT6rwaVPgO2mvGaF4BZQXQBTMTSt0DhNAP8IYF8vCX0qVP0lriQMj8DtyNqKImLfrUm7fLrp4rm700rZCIUvAaKIJOA/1rrT6IZdIid+p1kjr8yG2+6aqr867Y8TTz4vCgHp2+bR7YOt91E6SQuU9APTghQu5Ax49uEkI=
Received: from DB7PR02MB4411.eurprd02.prod.outlook.com (20.178.41.22) by
 DB7PR02MB4956.eurprd02.prod.outlook.com (20.178.44.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.22; Thu, 30 May 2019 08:46:01 +0000
Received: from DB7PR02MB4411.eurprd02.prod.outlook.com
 ([fe80::ce5:7d93:d1e2:5bcf]) by DB7PR02MB4411.eurprd02.prod.outlook.com
 ([fe80::ce5:7d93:d1e2:5bcf%4]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 08:46:01 +0000
From:   Dalit Ben Zoor <dbenzoor@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] habanalabs: make tpc registers secured
Thread-Topic: [PATCH 1/3] habanalabs: make tpc registers secured
Thread-Index: AQHVFsQbSvCCrEqYO0+DAKjVH6kA6w==
Date:   Thu, 30 May 2019 08:46:01 +0000
Message-ID: <20190530084554.31968-1-dbenzoor@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::21) To DB7PR02MB4411.eurprd02.prod.outlook.com
 (2603:10a6:10:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dbenzoor@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fd8beb6-a447-4d3c-098a-08d6e4db3e10
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB7PR02MB4956;
x-ms-traffictypediagnostic: DB7PR02MB4956:
x-microsoft-antispam-prvs: <DB7PR02MB4956D7CA3DB9435BA05798A4DC180@DB7PR02MB4956.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(136003)(376002)(346002)(39850400004)(366004)(396003)(199004)(189003)(8936002)(50226002)(25786009)(4326008)(14454004)(66446008)(64756008)(66556008)(66476007)(81166006)(81156014)(8676002)(73956011)(66946007)(2501003)(36756003)(68736007)(86362001)(66066001)(6486002)(2351001)(53936002)(74482002)(102836004)(316002)(1361003)(6436002)(5640700003)(6916009)(5660300002)(386003)(6506007)(7736002)(305945005)(476003)(2616005)(99286004)(6116002)(3846002)(52116002)(478600001)(71190400001)(26005)(186003)(71200400001)(486006)(6512007)(2906002)(14444005)(1076003)(256004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR02MB4956;H:DB7PR02MB4411.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zEMp3LAUsnkXfetGxN0y1Cl9klHgXg57bxb2hjH9UGPZnFh/GMjYaPRCDdax+rjEqnvn3pTsRG3x7QodGdHxF9BoVk6073PfR/A41WHurz7ZJ/wkNAj6SUg6gjd4r7KxPOoIyElOP0zXio2x71y3kGJ0pmCtqSfHjiTpt5GWzcF7cIQXYmIyqOa9c4Lxy7oeNr1zFsoHS38UqL52vOjgBB5/L0WqXMpDw/XiY7jRNRyDyUC8OodgA+fMEn8k+jEwPKK5ZY78CzXmGv3Vi8qgkRsTW03oxhZD0JE3xlBiSD0WORtjPAZ5IAN0Vl868cYZLY2WVf4kgjKMCduvJFVYlRckYn0je/G0uU8+f4acgwD7ZvnNR4LeNtDl9DVDIajonNSblnEt8cPdAn0HeeM5M9JptYoR3WHhVBJPjaI2X5E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd8beb6-a447-4d3c-098a-08d6e4db3e10
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 08:46:01.3660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbenzoor@habana.ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4956
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2V0IHByb3RlY3Rpb24gYml0cyBmb3Igc29tZSB0cGMgcmVnaXN0ZXJzIHRoYXQgc2hvdWxkIHRv
IGJlDQpzZWN1cmVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBEYWxpdCBCZW4gWm9vciA8ZGJlbnpvb3JA
aGFiYW5hLmFpPg0KLS0tDQogZHJpdmVycy9taXNjL2hhYmFuYWxhYnMvZ295YS9nb3lhX3NlY3Vy
aXR5LmMgfCAxNiArKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9oYWJhbmFsYWJzL2dveWEvZ295YV9z
ZWN1cml0eS5jIGIvZHJpdmVycy9taXNjL2hhYmFuYWxhYnMvZ295YS9nb3lhX3NlY3VyaXR5LmMN
CmluZGV4IGQ5NWQxYjJmODYwZC4uZDZlYzEyYjNlNjkyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9t
aXNjL2hhYmFuYWxhYnMvZ295YS9nb3lhX3NlY3VyaXR5LmMNCisrKyBiL2RyaXZlcnMvbWlzYy9o
YWJhbmFsYWJzL2dveWEvZ295YV9zZWN1cml0eS5jDQpAQCAtNjc3LDYgKzY3NywxNyBAQCBzdGF0
aWMgdm9pZCBnb3lhX2luaXRfdHBjX3Byb3RlY3Rpb25fYml0cyhzdHJ1Y3QgaGxfZGV2aWNlICpo
ZGV2KQ0KIAlnb3lhX3BiX3NldF9ibG9jayhoZGV2LCBtbVRQQzBfUkRfUkVHVUxBVE9SX0JBU0Up
Ow0KIAlnb3lhX3BiX3NldF9ibG9jayhoZGV2LCBtbVRQQzBfV1JfUkVHVUxBVE9SX0JBU0UpOw0K
IA0KKwlwYl9hZGRyID0gKG1tVFBDMF9DRkdfU0VNQVBIT1JFICYgfjB4RkZGKSArIFBST1RfQklU
U19PRkZTOw0KKwl3b3JkX29mZnNldCA9ICgobW1UUEMwX0NGR19TRU1BUEhPUkUgJiBQUk9UX0JJ
VFNfT0ZGUykgPj4gNykgPDwgMjsNCisNCisJbWFzayA9IDEgPDwgKChtbVRQQzBfQ0ZHX1NFTUFQ
SE9SRSAmIDB4N0YpID4+IDIpOw0KKwltYXNrIHw9IDEgPDwgKChtbVRQQzBfQ0ZHX1ZGTEFHUyAm
IDB4N0YpID4+IDIpOw0KKwltYXNrIHw9IDEgPDwgKChtbVRQQzBfQ0ZHX1NGTEFHUyAmIDB4N0Yp
ID4+IDIpOw0KKwltYXNrIHw9IDEgPDwgKChtbVRQQzBfQ0ZHX0xGU1JfUE9MWU5PTSAmIDB4N0Yp
ID4+IDIpOw0KKwltYXNrIHw9IDEgPDwgKChtbVRQQzBfQ0ZHX1NUQVRVUyAmIDB4N0YpID4+IDIp
Ow0KKw0KKwlXUkVHMzIocGJfYWRkciArIHdvcmRfb2Zmc2V0LCB+bWFzayk7DQorDQogCXBiX2Fk
ZHIgPSAobW1UUEMwX0NGR19DRkdfQkFTRV9BRERSRVNTX0hJR0ggJiB+MHhGRkYpICsgUFJPVF9C
SVRTX09GRlM7DQogCXdvcmRfb2Zmc2V0ID0gKChtbVRQQzBfQ0ZHX0NGR19CQVNFX0FERFJFU1Nf
SElHSCAmDQogCQkJUFJPVF9CSVRTX09GRlMpID4+IDcpIDw8IDI7DQpAQCAtNjg0LDYgKzY5NSwx
MSBAQCBzdGF0aWMgdm9pZCBnb3lhX2luaXRfdHBjX3Byb3RlY3Rpb25fYml0cyhzdHJ1Y3QgaGxf
ZGV2aWNlICpoZGV2KQ0KIAltYXNrIHw9IDEgPDwgKChtbVRQQzBfQ0ZHX0NGR19TVUJUUkFDVF9W
QUxVRSAmIDB4N0YpID4+IDIpOw0KIAltYXNrIHw9IDEgPDwgKChtbVRQQzBfQ0ZHX1NNX0JBU0Vf
QUREUkVTU19MT1cgJiAweDdGKSA+PiAyKTsNCiAJbWFzayB8PSAxIDw8ICgobW1UUEMwX0NGR19T
TV9CQVNFX0FERFJFU1NfSElHSCAmIDB4N0YpID4+IDIpOw0KKwltYXNrIHw9IDEgPDwgKChtbVRQ
QzBfQ0ZHX0NGR19TVUJUUkFDVF9WQUxVRSAmIDB4N0YpID4+IDIpOw0KKwltYXNrIHw9IDEgPDwg
KChtbVRQQzBfQ0ZHX1RQQ19TVEFMTCAmIDB4N0YpID4+IDIpOw0KKwltYXNrIHw9IDEgPDwgKCht
bVRQQzBfQ0ZHX01TU19DT05GSUcgJiAweDdGKSA+PiAyKTsNCisJbWFzayB8PSAxIDw8ICgobW1U
UEMwX0NGR19UUENfSU5UUl9DQVVTRSAmIDB4N0YpID4+IDIpOw0KKwltYXNrIHw9IDEgPDwgKCht
bVRQQzBfQ0ZHX1RQQ19JTlRSX01BU0sgJiAweDdGKSA+PiAyKTsNCiANCiAJV1JFRzMyKHBiX2Fk
ZHIgKyB3b3JkX29mZnNldCwgfm1hc2spOw0KIA0KLS0gDQoyLjE3LjENCg0K
