Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8570FC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEB324C21
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="Na2RgsmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfFDLff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:35:35 -0400
Received: from mail-eopbgr20096.outbound.protection.outlook.com ([40.107.2.96]:9639
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727170AbfFDLfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector1-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvSJyGtCMjMHYZ8+/wie/cfb3STQSQQ1DeRdIvzTUvY=;
 b=Na2RgsmKbRzvETRiu46nv5AuffnZTURjbj/kTl2WUHp+KoNnjX5GLkQGbYGo1ZXxuU4/i8A1NrwSNiD6pUrmLKzE6fsSQUrW70UOs/8DEnyC71JIwzwLzBHLTIDcqTbfuER8gvDpQ2UqmqhXovcLge7dcZeDG/owV0A4bBeYEbU=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.170.235.155) by
 VI1PR02MB4445.eurprd02.prod.outlook.com (20.178.11.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.21; Tue, 4 Jun 2019 11:35:30 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::d45e:25f0:5b42:30e2]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::d45e:25f0:5b42:30e2%2]) with mapi id 15.20.1943.018; Tue, 4 Jun 2019
 11:35:30 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] habanalabs: Read upper bits of trace buffer from RWPHI
Thread-Topic: [PATCH] habanalabs: Read upper bits of trace buffer from RWPHI
Thread-Index: AQHVGsmdcXQepJAB1Ee56KtlMbauWQ==
Date:   Tue, 4 Jun 2019 11:35:30 +0000
Message-ID: <20190604113519.4666-1-ttayar@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0502CA0023.eurprd05.prod.outlook.com
 (2603:10a6:203:91::33) To VI1PR02MB3054.eurprd02.prod.outlook.com
 (2603:10a6:802:17::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11182ad2-8ba6-4653-28c5-08d6e8e0bf9e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR02MB4445;
x-ms-traffictypediagnostic: VI1PR02MB4445:
x-microsoft-antispam-prvs: <VI1PR02MB444504EB318FD861AF8CDF25D2150@VI1PR02MB4445.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(136003)(39850400004)(189003)(199004)(66066001)(1076003)(5660300002)(26005)(74482002)(6436002)(71200400001)(6486002)(68736007)(486006)(36756003)(86362001)(71190400001)(2501003)(2616005)(476003)(2351001)(99286004)(6506007)(81166006)(256004)(50226002)(2906002)(81156014)(8676002)(186003)(8936002)(316002)(4326008)(305945005)(1361003)(14454004)(478600001)(66556008)(6916009)(386003)(5640700003)(66946007)(66446008)(64756008)(66476007)(73956011)(6512007)(102836004)(3846002)(6116002)(52116002)(25786009)(7736002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4445;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R43F6c50g7xjBwVy9jo2n/Tg2s8E2m3NXCHby9h+p4JlGD8yTT8klRHJ6ltgPwoEaGmy4dYeR9dHjJXg59P2WZVlyjcNRgQ9IwpBXLuVZX0RR1hDu4vyabszrnJTXuJYr9nHNip3d8E0RTbxmVyMn2Qm2ZGcUxO8XM5NXnnB0OijKO0epbvxZ76RA2hxoygvUiO3it8QXHjHgD5WbUIX+2roSHu+EgJ/YnLml6EmQK51yKJzByNva0LfqffaIUOc/tUGlTkvdfI8MKDzMp3kve2qxqYRO6ceJMaGd9xURrFFh1cdu6zYco4om/y93Afn1HrzDEaZGfeOJwcIQUAxBes5Qi8C1+ivUa9V2pI443A7zyl/yC/NAlrgrRxkkjDrT28g6S0ZJglZ5lLi22W/EAsx8sZCXI2pnUQ3yt3YhUQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 11182ad2-8ba6-4653-28c5-08d6e8e0bf9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 11:35:30.7683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttayar@habana.ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4445
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHRyYWNlIGJ1ZmZlciBhZGRyZXNzIGlzIDQwIGJpdHMgd2lkZS4NClRoZSBlbmQgb2YgdGhl
IGJ1ZmZlciBpcyBzZXQgaW4gdGhlIFJXUCByZWdpc3RlciAobG93ZXIgMzIgYml0cyksIGFuZCBp
bg0KdGhlIFJXUEhJIHJlZ2lzdGVyICh1cHBlciA4IGJpdHMpLg0KQ3VycmVudGx5IG9ubHkgdGhl
IGxvd2VyIDMyIGJpdHMgYXJlIHJlYWQsIGFuZCB0aGlzIHBhdGNoIGZpeGVzIGl0IGFuZA0KY29u
Y2F0ZW5hdGVzIHRoZSB1cHBlciA4IGJpdHMgdG8gdGhlIG91dHB1dCBhZGRyZXNzLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBUb21lciBUYXlhciA8dHRheWFyQGhhYmFuYS5haT4NCi0tLQ0KIGRyaXZlcnMv
bWlzYy9oYWJhbmFsYWJzL2dveWEvZ295YV9jb3Jlc2lnaHQuYyB8IDE0ICsrKysrKysrKysrKy0t
DQogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvaGFiYW5hbGFicy9nb3lhL2dveWFfY29yZXNpZ2h0LmMg
Yi9kcml2ZXJzL21pc2MvaGFiYW5hbGFicy9nb3lhL2dveWFfY29yZXNpZ2h0LmMNCmluZGV4IDM5
ZjYyY2U3MjY2MC4uZDdlYzdhZDg0Y2M2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9taXNjL2hhYmFu
YWxhYnMvZ295YS9nb3lhX2NvcmVzaWdodC5jDQorKysgYi9kcml2ZXJzL21pc2MvaGFiYW5hbGFi
cy9nb3lhL2dveWFfY29yZXNpZ2h0LmMNCkBAIC00MjUsOCArNDI1LDE4IEBAIHN0YXRpYyBpbnQg
Z295YV9jb25maWdfZXRyKHN0cnVjdCBobF9kZXZpY2UgKmhkZXYsDQogCQlXUkVHMzIoYmFzZV9y
ZWcgKyAweDI4LCAwKTsNCiAJCVdSRUczMihiYXNlX3JlZyArIDB4MzA0LCAwKTsNCiANCi0JCWlm
IChwYXJhbXMtPm91dHB1dF9zaXplID49IHNpemVvZih1MzIpKQ0KLQkJCSoodTMyICopIHBhcmFt
cy0+b3V0cHV0ID0gUlJFRzMyKGJhc2VfcmVnICsgMHgxOCk7DQorCQlpZiAocGFyYW1zLT5vdXRw
dXRfc2l6ZSA+PSBzaXplb2YodTY0KSkgew0KKwkJCXUzMiByd3AsIHJ3cGhpOw0KKw0KKwkJCS8q
DQorCQkJICogVGhlIHRyYWNlIGJ1ZmZlciBhZGRyZXNzIGlzIDQwIGJpdHMgd2lkZS4gVGhlIGVu
ZCBvZg0KKwkJCSAqIHRoZSBidWZmZXIgaXMgc2V0IGluIHRoZSBSV1AgcmVnaXN0ZXIgKGxvd2Vy
IDMyDQorCQkJICogYml0cyksIGFuZCBpbiB0aGUgUldQSEkgcmVnaXN0ZXIgKHVwcGVyIDggYml0
cykuDQorCQkJICovDQorCQkJcndwID0gUlJFRzMyKGJhc2VfcmVnICsgMHgxOCk7DQorCQkJcndw
aGkgPSBSUkVHMzIoYmFzZV9yZWcgKyAweDNjKSAmIDB4ZmY7DQorCQkJKih1NjQgKikgcGFyYW1z
LT5vdXRwdXQgPSAoKHU2NCkgcndwaGkgPDwgMzIpIHwgcndwOw0KKwkJfQ0KIAl9DQogDQogCXJl
dHVybiAwOw0KLS0gDQoyLjE3LjENCg0K
