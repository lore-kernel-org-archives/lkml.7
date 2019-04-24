Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31837C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEA7218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BLkN3X/9";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UdridE4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfDXB3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:29:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34380 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728773AbfDXB3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:29:04 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3O1QQHu012036;
        Tue, 23 Apr 2019 18:28:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=w/7Yyr6lXJ+r2wdtn/ocpRUunhMgkW2lJF/webwfUIc=;
 b=BLkN3X/9BLlwA/Wcx/vqAUsRYGblklFpRnhNnDNYQkzvoGmEHPA8NHKz1GHog9Y+458S
 Br44s5fcC1hgVzpT9zd/qqguVPbQuW/CNRU8um8sJiGxYv1g1AGHeEfxsxWeNAaSpcbn
 qWVKHfhq+e/tlTg6WR09uJ87TA2hGMFTnWs= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2s27u3shha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 23 Apr 2019 18:28:44 -0700
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 23 Apr 2019 18:28:43 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 23 Apr 2019 18:28:43 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 23 Apr 2019 18:28:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/7Yyr6lXJ+r2wdtn/ocpRUunhMgkW2lJF/webwfUIc=;
 b=UdridE4Uqt/qcWA1rQ0/q7gmqoiwJpK7qyyVYuN9leuTz2x00EenWMKkRug7cpwWRhtG/J2fOK+38jSaucVfJL59sNKToqOwE5vz4BgOHXsLnokEUeuX1bO3yc+uNgpTBR8CgiQZ9MLPupwSwFuP0Z4KrvvmT3zOaDRAwyFuBPE=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1839.namprd15.prod.outlook.com (10.174.255.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Wed, 24 Apr 2019 01:28:41 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::9ccc:f6fa:40e2:f1cd]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::9ccc:f6fa:40e2:f1cd%10]) with mapi id 15.20.1813.017; Wed, 24 Apr
 2019 01:28:41 +0000
From:   Tao Ren <taoren@fb.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
CC:     Tao Ren <taoren@fb.com>
Subject: [PATCH net v3] net/ncsi: handle overflow when incrementing mac
 address
Thread-Topic: [PATCH net v3] net/ncsi: handle overflow when incrementing mac
 address
Thread-Index: AQHU+j0M9s4jWyUgckSZ8ZAgrSQZoQ==
Date:   Wed, 24 Apr 2019 01:28:41 +0000
Message-ID: <20190424012819.2833-1-taoren@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0041.namprd12.prod.outlook.com
 (2603:10b6:301:2::27) To MWHPR15MB1216.namprd15.prod.outlook.com
 (2603:10b6:320:23::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [2620:10d:c090:200::5189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c69465e-5d36-4998-dfe1-08d6c8542eb6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1839;
x-ms-traffictypediagnostic: MWHPR15MB1839:
x-microsoft-antispam-prvs: <MWHPR15MB1839F3BDDB068634A9044674B23C0@MWHPR15MB1839.namprd15.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(366004)(396003)(39860400002)(199004)(189003)(6486002)(6436002)(86362001)(2201001)(1076003)(256004)(68736007)(97736004)(186003)(36756003)(14444005)(71200400001)(71190400001)(2616005)(476003)(52116002)(6116002)(316002)(66946007)(486006)(14454004)(386003)(110136005)(2501003)(6506007)(8676002)(46003)(4326008)(73956011)(102836004)(25786009)(478600001)(7736002)(6512007)(8936002)(66476007)(81156014)(53936002)(66446008)(64756008)(81166006)(66556008)(2906002)(99286004)(5660300002)(305945005)(50226002)(7416002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1839;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TsJq1u6HLLgfiSR0NJVemU/jGJAuY0/erwqf5W9dUx4CYn5I+j5Uly3S+Wfvh2mx3nuT2cmT3Ghv8IXYYVeKGuerZYZno42oKsuzt3tvD2E3jqq0yisZRi6MBXWM/XJR60OwCw6PN2G9Vx0nvZO3aVBZTDaJwUzcC9HIvU/vTEYd9ZKHp+gBlCafSgQB+QqGfH5YbfRTDDpUZGs5C5hZw9OqeZw6dcCI6J7ZZAjtXaqZaLX+7zF9hCsrXd3ixjj8l7r7+Ks5K7WxgrgDTT7UlN8ZXEpY4U3/9jvZma5dkTwEPG930eRX/wIQv+p09ZuaBiQ8kReoCjKSWd0KuYLu8uhfDi70fE30PA4g27cZ+r3taOObii4SSK4J69TJCURW1iecXS+wlxByzke5ucsjAumnstBc+KK1h0XFoipTt6c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c69465e-5d36-4998-dfe1-08d6c8542eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 01:28:41.1553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1839
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UHJldmlvdXNseSBCTUMncyBNQUMgYWRkcmVzcyBpcyBjYWxjdWxhdGVkIGJ5IHNpbXBseSBhZGRp
bmcgMSB0byB0aGUNCmxhc3QgYnl0ZSBvZiBuZXR3b3JrIGNvbnRyb2xsZXIncyBNQUMgYWRkcmVz
cywgYW5kIGl0IHByb2R1Y2VzIGluY29ycmVjdA0KcmVzdWx0IHdoZW4gbmV0d29yayBjb250cm9s
bGVyJ3MgTUFDIGFkZHJlc3MgZW5kcyB3aXRoIDB4RkYuDQoNClRoZSBwcm9ibGVtIGNhbiBiZSBm
aXhlZCBieSBjYWxsaW5nIGV0aF9hZGRyX2luYygpIGZ1bmN0aW9uIHRvIGluY3JlbWVudA0KTUFD
IGFkZHJlc3M7IGJlc2lkZXMsIHRoZSBNQUMgYWRkcmVzcyBpcyBhbHNvIHZhbGlkYXRlZCBiZWZv
cmUgYXNzaWduaW5nDQp0byBCTUMuDQoNCkZpeGVzOiBjYjEwYzdjMGRmZDkgKCJuZXQvbmNzaTog
QWRkIE5DU0kgQnJvYWRjb20gT0VNIGNvbW1hbmQiKQ0KU2lnbmVkLW9mZi1ieTogVGFvIFJlbiA8
dGFvcmVuQGZiLmNvbT4NCi0tLQ0KIGluY2x1ZGUvbGludXgvZXRoZXJkZXZpY2UuaCB8IDE1ICsr
KysrKysrKysrKystLQ0KIG5ldC9uY3NpL25jc2ktcnNwLmMgICAgICAgICB8ICA2ICsrKysrLQ0K
IDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KQ2hh
bmdlcyBpbiB2MzoNCiAtIHNxdWFzaCBjaGFuZ2VzIGluICJldGhlcmRldmljZS5oIiBpbnRvIHRo
aXMgcGF0Y2guDQogLSBmaXggZm9ybWF0IGlzc3VlIGluIGZ1bmN0aW9uIGNvbW1lbnQuDQpDaGFu
Z2VzIGluIHYyOg0KIC0gaW5jcmVtZW50IE1BQyBhZGRyZXNzIGJ5IGNhbGxpbmcgZXRoX2FkZHJf
aW5jKCkgZnVuY3Rpb24uDQogLSB2YWxpZGF0ZSBNQUMgYWRkcmVzcyBiZWZvcmUgYXNzaWduaW5n
IHRvIEJNQy4NCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZXRoZXJkZXZpY2UuaCBiL2lu
Y2x1ZGUvbGludXgvZXRoZXJkZXZpY2UuaA0KaW5kZXggZTJmM2IyMWNkNzJhLi5hYzVjYTc1NGUz
NjIgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L2V0aGVyZGV2aWNlLmgNCisrKyBiL2luY2x1
ZGUvbGludXgvZXRoZXJkZXZpY2UuaA0KQEAgLTQzNiw4ICs0MzYsNyBAQCBzdGF0aWMgaW5saW5l
IHZvaWQgdTY0X3RvX2V0aGVyX2FkZHIodTY0IHUsIHU4ICphZGRyKQ0KIH0NCiANCiAvKioNCi0g
KiBldGhfYWRkcl9kZWMgLSBEZWNyZW1lbnQgdGhlIGdpdmVuIE1BQyBhZGRyZXNzDQotICoNCisg
KiBldGhfYWRkcl9kZWMoKSAtIERlY3JlbWVudCB0aGUgZ2l2ZW4gTUFDIGFkZHJlc3MNCiAgKiBA
YWRkcjogUG9pbnRlciB0byBhIHNpeC1ieXRlIGFycmF5IGNvbnRhaW5pbmcgRXRoZXJuZXQgYWRk
cmVzcyB0byBkZWNyZW1lbnQNCiAgKi8NCiBzdGF0aWMgaW5saW5lIHZvaWQgZXRoX2FkZHJfZGVj
KHU4ICphZGRyKQ0KQEAgLTQ0OCw2ICs0NDcsMTggQEAgc3RhdGljIGlubGluZSB2b2lkIGV0aF9h
ZGRyX2RlYyh1OCAqYWRkcikNCiAJdTY0X3RvX2V0aGVyX2FkZHIodSwgYWRkcik7DQogfQ0KIA0K
Ky8qKg0KKyAqIGV0aF9hZGRyX2luYygpIC0gSW5jcmVtZW50IHRoZSBnaXZlbiBNQUMgYWRkcmVz
cy4NCisgKiBAYWRkcjogUG9pbnRlciB0byBhIHNpeC1ieXRlIGFycmF5IGNvbnRhaW5pbmcgRXRo
ZXJuZXQgYWRkcmVzcyB0byBpbmNyZW1lbnQuDQorICovDQorc3RhdGljIGlubGluZSB2b2lkIGV0
aF9hZGRyX2luYyh1OCAqYWRkcikNCit7DQorCXU2NCB1ID0gZXRoZXJfYWRkcl90b191NjQoYWRk
cik7DQorDQorCXUrKzsNCisJdTY0X3RvX2V0aGVyX2FkZHIodSwgYWRkcik7DQorfQ0KKw0KIC8q
Kg0KICAqIGlzX2V0aGVyZGV2X2FkZHIgLSBUZWxsIGlmIGdpdmVuIEV0aGVybmV0IGFkZHJlc3Mg
YmVsb25ncyB0byB0aGUgZGV2aWNlLg0KICAqIEBkZXY6IFBvaW50ZXIgdG8gYSBkZXZpY2Ugc3Ry
dWN0dXJlDQpkaWZmIC0tZ2l0IGEvbmV0L25jc2kvbmNzaS1yc3AuYyBiL25ldC9uY3NpL25jc2kt
cnNwLmMNCmluZGV4IGRjMDdmY2M3OTM4ZS4uODAyZGIwMWUzMDc1IDEwMDY0NA0KLS0tIGEvbmV0
L25jc2kvbmNzaS1yc3AuYw0KKysrIGIvbmV0L25jc2kvbmNzaS1yc3AuYw0KQEAgLTExLDYgKzEx
LDcgQEANCiAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQogI2luY2x1ZGUgPGxpbnV4L2luaXQu
aD4NCiAjaW5jbHVkZSA8bGludXgvbmV0ZGV2aWNlLmg+DQorI2luY2x1ZGUgPGxpbnV4L2V0aGVy
ZGV2aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3NrYnVmZi5oPg0KIA0KICNpbmNsdWRlIDxuZXQv
bmNzaS5oPg0KQEAgLTY2Nyw3ICs2NjgsMTAgQEAgc3RhdGljIGludCBuY3NpX3JzcF9oYW5kbGVy
X29lbV9iY21fZ21hKHN0cnVjdCBuY3NpX3JlcXVlc3QgKm5yKQ0KIAluZGV2LT5wcml2X2ZsYWdz
IHw9IElGRl9MSVZFX0FERFJfQ0hBTkdFOw0KIAltZW1jcHkoc2FkZHIuc2FfZGF0YSwgJnJzcC0+
ZGF0YVtCQ01fTUFDX0FERFJfT0ZGU0VUXSwgRVRIX0FMRU4pOw0KIAkvKiBJbmNyZWFzZSBtYWMg
YWRkcmVzcyBieSAxIGZvciBCTUMncyBhZGRyZXNzICovDQotCXNhZGRyLnNhX2RhdGFbRVRIX0FM
RU4gLSAxXSsrOw0KKwlldGhfYWRkcl9pbmMoKHU4ICopc2FkZHIuc2FfZGF0YSk7DQorCWlmICgh
aXNfdmFsaWRfZXRoZXJfYWRkcigoY29uc3QgdTggKilzYWRkci5zYV9kYXRhKSkNCisJCXJldHVy
biAtRU5YSU87DQorDQogCXJldCA9IG9wcy0+bmRvX3NldF9tYWNfYWRkcmVzcyhuZGV2LCAmc2Fk
ZHIpOw0KIAlpZiAocmV0IDwgMCkNCiAJCW5ldGRldl93YXJuKG5kZXYsICJOQ1NJOiAnV3JpdGlu
ZyBtYWMgYWRkcmVzcyB0byBkZXZpY2UgZmFpbGVkXG4iKTsNCi0tIA0KMi4xNy4xDQoNCg==
