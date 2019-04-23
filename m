Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5B0C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E6D218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="G84/pFxg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cGE5+Xyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfDWWnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:43:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40168 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728354AbfDWWnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:43:02 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NMcIk4029437;
        Tue, 23 Apr 2019 15:42:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=ft13XIUXs/na5BozApRenz43jZoigJPM9OJXpjnNQCo=;
 b=G84/pFxgFacKSO5kKlTWqYxS77lXI5gixEYMAUTfAF1MS0LV9HZ7H2CLJSE1qaS6VQh4
 WWkBehAGTXY/m+6sk/zPUqQf3Bf2dMOtjNfi6c1ret7jjEsv220DuCxcZEccQ5UOToGO
 r7C8Z7e/XiCttYsTUSm69HXS67Lq3kz5ZCI= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s293grmb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 23 Apr 2019 15:42:48 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 23 Apr 2019 15:42:47 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 23 Apr 2019 15:42:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ft13XIUXs/na5BozApRenz43jZoigJPM9OJXpjnNQCo=;
 b=cGE5+XyvaauqM7R6Ceg7rR0fsbOpjPu2beoJpb2OvkEXcjEP2L81UQcsy/ccxrNNB4zavjoJUq1LatR9TDNud251S+18RkCeup719jKcTSZjm98IjicPs7nrBLVH9wG7CsaHb5skFQHX1lXurx3rcaVfWhkpHOGbOBZgwmJAQUg=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1502.namprd15.prod.outlook.com (10.173.235.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Tue, 23 Apr 2019 22:42:46 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::9ccc:f6fa:40e2:f1cd]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::9ccc:f6fa:40e2:f1cd%10]) with mapi id 15.20.1813.017; Tue, 23 Apr
 2019 22:42:45 +0000
From:   Tao Ren <taoren@fb.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
CC:     Tao Ren <taoren@fb.com>
Subject: [PATCH net v2 2/2] net/ncsi: handle overflow when incrementing mac
 address
Thread-Topic: [PATCH net v2 2/2] net/ncsi: handle overflow when incrementing
 mac address
Thread-Index: AQHU+iXecLDtt1IY90eudJt4zx65pg==
Date:   Tue, 23 Apr 2019 22:42:45 +0000
Message-ID: <20190423224229.2522-1-taoren@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0078.namprd02.prod.outlook.com
 (2603:10b6:301:75::19) To MWHPR15MB1216.namprd15.prod.outlook.com
 (2603:10b6:320:23::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [2620:10d:c090:200::1:8f70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d33eb112-7767-48a9-b33f-08d6c83d00fc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1502;
x-ms-traffictypediagnostic: MWHPR15MB1502:
x-microsoft-antispam-prvs: <MWHPR15MB1502AC6775230EA601383109B2230@MWHPR15MB1502.namprd15.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(6486002)(50226002)(53936002)(316002)(6512007)(6436002)(14454004)(110136005)(81166006)(52116002)(1076003)(71200400001)(2501003)(478600001)(8936002)(99286004)(7416002)(71190400001)(81156014)(97736004)(2906002)(46003)(6116002)(7736002)(68736007)(386003)(66556008)(66446008)(8676002)(66476007)(66946007)(102836004)(25786009)(86362001)(6506007)(2201001)(486006)(2616005)(186003)(14444005)(64756008)(36756003)(256004)(476003)(5660300002)(73956011)(4326008)(305945005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1502;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w/R5f166ikQB/mawuBiNuX014n224zEcPBSsxbJ72uSodHx1JCf8acswNJfGRaM2iHn8KZdX26IjBmEnPsq0/czlzYF/1Qix/ZAxMCVIXpskzJevWbPYfLfvWx9vfLUqc7TX5D39HZGf+t5Rfj+dWgORGKDh62CBZA97zmcstVqnJ9AWcIy3X7XC/0qbWyC97uGMDVf62jcES5Mijnw6skrjOBAvf6D0iK5iVoxwaV9gjOA+7FYQhSy0qaiYX18HZT9NYjs4N7mlOwj16FRYT0cKIl+YC4iUVUsNP4UrxqySgNtOApAfjq9vgn0AXNIkYqPAgGCgJcRY2BiAKxrjvOvpd4qie8A/6k0YnmWhdn9IC4zh1wFts/rRIsD4uO4lUzSgVKxzXYtAnBHQndrnzHOm+xSDUt6Za4G4Gu5GEiM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d33eb112-7767-48a9-b33f-08d6c83d00fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 22:42:45.8198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1502
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_09:,,
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
aXhlZCBieSBjYWxsaW5nICJuZXRfYWRkcl9pbmMiIGZ1bmN0aW9uIHRvIGluY3JlbWVudA0KTUFD
IGFkZHJlc3M7IGJlc2lkZXMsIHRoZSBNQUMgYWRkcmVzcyBpcyBhbHNvIHZhbGlkYXRlZCBiZWZv
cmUgYXNzaWduaW5nDQp0byBCTUMuDQoNCkZpeGVzOiBjYjEwYzdjMGRmZDkgKCJuZXQvbmNzaTog
QWRkIE5DU0kgQnJvYWRjb20gT0VNIGNvbW1hbmQiKQ0KU2lnbmVkLW9mZi1ieTogVGFvIFJlbiA8
dGFvcmVuQGZiLmNvbT4NCi0tLQ0KIG5ldC9uY3NpL25jc2ktcnNwLmMgfCA2ICsrKysrLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KQ2hhbmdlcyBp
biB2MjoNCiAtIGluY3JlbWVudCBNQUMgYWRkcmVzcyBieSBjYWxsaW5nIG5ldF9hZGRyX2luYyBm
dW5jdGlvbi4NCiAtIHZhbGlkYXRlIE1BQyBhZGRyZXNzIGJlZm9yZSBhc3NpZ25pbmcgdG8gQk1D
Lg0KDQpkaWZmIC0tZ2l0IGEvbmV0L25jc2kvbmNzaS1yc3AuYyBiL25ldC9uY3NpL25jc2ktcnNw
LmMNCmluZGV4IGRjMDdmY2M3OTM4ZS4uODAyZGIwMWUzMDc1IDEwMDY0NA0KLS0tIGEvbmV0L25j
c2kvbmNzaS1yc3AuYw0KKysrIGIvbmV0L25jc2kvbmNzaS1yc3AuYw0KQEAgLTExLDYgKzExLDcg
QEANCiAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQogI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4N
CiAjaW5jbHVkZSA8bGludXgvbmV0ZGV2aWNlLmg+DQorI2luY2x1ZGUgPGxpbnV4L2V0aGVyZGV2
aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3NrYnVmZi5oPg0KIA0KICNpbmNsdWRlIDxuZXQvbmNz
aS5oPg0KQEAgLTY2Nyw3ICs2NjgsMTAgQEAgc3RhdGljIGludCBuY3NpX3JzcF9oYW5kbGVyX29l
bV9iY21fZ21hKHN0cnVjdCBuY3NpX3JlcXVlc3QgKm5yKQ0KIAluZGV2LT5wcml2X2ZsYWdzIHw9
IElGRl9MSVZFX0FERFJfQ0hBTkdFOw0KIAltZW1jcHkoc2FkZHIuc2FfZGF0YSwgJnJzcC0+ZGF0
YVtCQ01fTUFDX0FERFJfT0ZGU0VUXSwgRVRIX0FMRU4pOw0KIAkvKiBJbmNyZWFzZSBtYWMgYWRk
cmVzcyBieSAxIGZvciBCTUMncyBhZGRyZXNzICovDQotCXNhZGRyLnNhX2RhdGFbRVRIX0FMRU4g
LSAxXSsrOw0KKwlldGhfYWRkcl9pbmMoKHU4ICopc2FkZHIuc2FfZGF0YSk7DQorCWlmICghaXNf
dmFsaWRfZXRoZXJfYWRkcigoY29uc3QgdTggKilzYWRkci5zYV9kYXRhKSkNCisJCXJldHVybiAt
RU5YSU87DQorDQogCXJldCA9IG9wcy0+bmRvX3NldF9tYWNfYWRkcmVzcyhuZGV2LCAmc2FkZHIp
Ow0KIAlpZiAocmV0IDwgMCkNCiAJCW5ldGRldl93YXJuKG5kZXYsICJOQ1NJOiAnV3JpdGluZyBt
YWMgYWRkcmVzcyB0byBkZXZpY2UgZmFpbGVkXG4iKTsNCi0tIA0KMi4xNy4xDQoNCg==
