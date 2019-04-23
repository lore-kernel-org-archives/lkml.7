Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD089C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F78218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TxKIv6xm";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NsLe2lVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfDWWmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:42:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40004 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726075AbfDWWmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:42:21 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NMcH7Y029431;
        Tue, 23 Apr 2019 15:41:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=TnIVP2AOcNSru7Ihxa+LwJ974PfLayBnsBZC7rrSHOI=;
 b=TxKIv6xm9w0uw9u84sZqSP2atKEkr1Ar3w5LZ3xmKgoqaIg6QwXVG6ksnwh51oODDSzR
 kIMsCH1sfpxtaTXfj7TZ9mQUmy+oDCEcQjmZu0wa1M1lamuKM/sTzTeYSmIbZ20e56YE
 Z5YAFnyrJIPhG7BM5a3uRj1x62MKEQilANg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s293grm96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 23 Apr 2019 15:41:59 -0700
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 23 Apr 2019 15:41:58 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 23 Apr 2019 15:41:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnIVP2AOcNSru7Ihxa+LwJ974PfLayBnsBZC7rrSHOI=;
 b=NsLe2lVSJNQs2tLzXYgTInGxw4aw07b2lmegqTG0+jWyQAbWvNpxdw/UBOwUtebeaNUOMY73S8u8oY2a8EN3q67d85mfTIlzmwcd7PHKgBd4bj5OGr6tb2a+e0v7cmQuXD8EW9bAFPqHt1CPBWXhGIkNuVKQ8SvXgA0k+UxcZZw=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1776.namprd15.prod.outlook.com (10.174.255.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Tue, 23 Apr 2019 22:41:56 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::9ccc:f6fa:40e2:f1cd]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::9ccc:f6fa:40e2:f1cd%10]) with mapi id 15.20.1813.017; Tue, 23 Apr
 2019 22:41:56 +0000
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
Subject: [PATCH net 1/2] net: add eth_addr_inc in etherdevice.h
Thread-Topic: [PATCH net 1/2] net: add eth_addr_inc in etherdevice.h
Thread-Index: AQHU+iXBL3XM+2QubECFPb9Ujl9Lng==
Date:   Tue, 23 Apr 2019 22:41:56 +0000
Message-ID: <20190423224138.1295-1-taoren@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0015.namprd10.prod.outlook.com (2603:10b6:301::25)
 To MWHPR15MB1216.namprd15.prod.outlook.com (2603:10b6:320:23::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [2620:10d:c090:200::1:8f70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5697a053-c2cc-4646-ceaf-08d6c83ce399
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1776;
x-ms-traffictypediagnostic: MWHPR15MB1776:
x-microsoft-antispam-prvs: <MWHPR15MB177669000D8A6EA1E67E84AAB2230@MWHPR15MB1776.namprd15.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(136003)(366004)(376002)(189003)(199004)(6486002)(2201001)(97736004)(71190400001)(2906002)(86362001)(6436002)(71200400001)(5660300002)(6506007)(486006)(2616005)(476003)(386003)(14454004)(81156014)(102836004)(99286004)(1076003)(4744005)(8936002)(81166006)(8676002)(256004)(36756003)(52116002)(46003)(68736007)(6116002)(2501003)(186003)(50226002)(4326008)(110136005)(66946007)(305945005)(73956011)(6512007)(25786009)(7416002)(316002)(478600001)(66446008)(64756008)(7736002)(66476007)(66556008)(53936002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1776;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nclHTF2d1RKMJPXhuN7cubRR5+ZD4oNgDZ84517YtHfigOyi8wL0a9E75Ggf0uDSaTgmvqocO+Z3x6w3H8BymzbYx3ihLkd6kEQuvg3XRVA4oCH3Zp7oDyEjgZe5DrzvuqYbJlPEjujYxtIDaiLLSOCYoOmSNF95U9utseXc1nx5pVu3bMdfgLVHYKIruWfV0dyGQmGYdf3us3UN7Rl7nMWf8tTPeYmt4Iu34xJB9h8W5obDbm3KgT4peckm/J8obDWnm5YVK5H4fqXox1PhiE1UkD+9ZiTdVM5Nqe24IyuyFWaJWH9S7TzaOQI7R6I6f2dKpIlIv5S5KwC3qPBl+JbjLR5+uj0ARgiRHrf7dZDATesn3UwozxY27GbAPleOtccBY6ltFoBYfamNV6Ei/qSjJgUmEAWVxEdb8ALrEqY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5697a053-c2cc-4646-ceaf-08d6c83ce399
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 22:41:56.5207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1776
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGV0aF9hZGRyX2luYyBmdW5jdGlvbiBpbiBldGhlcmRldmljZS5oIHRvIGluY3JlbWVudCBN
QUMgYWRkcmVzcy4gT25lDQpvZiB0aGUgdXNlIGNhc2VzIGlzIGluIG5jc2kgc3RhY2ssIHdoZXJl
IHRoZSBob3N0J3MgTUFDIGFkZHJlc3MgbmVlZHMgdG8NCmJlIGluY3JlbWVudGVkIHRvIGdldCBC
TUMncyBNQUMgYWRkcmVzcy4NCg0KU2lnbmVkLW9mZi1ieTogVGFvIFJlbiA8dGFvcmVuQGZiLmNv
bT4NCi0tLQ0KIGluY2x1ZGUvbGludXgvZXRoZXJkZXZpY2UuaCB8IDEzICsrKysrKysrKysrKysN
CiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9ldGhlcmRldmljZS5oIGIvaW5jbHVkZS9saW51eC9ldGhlcmRldmljZS5oDQppbmRl
eCBlMmYzYjIxY2Q3MmEuLmQ0OGUzYTcyNGM1NCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgv
ZXRoZXJkZXZpY2UuaA0KKysrIGIvaW5jbHVkZS9saW51eC9ldGhlcmRldmljZS5oDQpAQCAtNDQ4
LDYgKzQ0OCwxOSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZXRoX2FkZHJfZGVjKHU4ICphZGRyKQ0K
IAl1NjRfdG9fZXRoZXJfYWRkcih1LCBhZGRyKTsNCiB9DQogDQorLyoqDQorICogZXRoX2FkZHJf
aW5jIC0gSW5jcmVtZW50IHRoZSBnaXZlbiBNQUMgYWRkcmVzcw0KKyAqDQorICogQGFkZHI6IFBv
aW50ZXIgdG8gYSBzaXgtYnl0ZSBhcnJheSBjb250YWluaW5nIEV0aGVybmV0IGFkZHJlc3MgdG8g
aW5jcmVtZW50DQorICovDQorc3RhdGljIGlubGluZSB2b2lkIGV0aF9hZGRyX2luYyh1OCAqYWRk
cikNCit7DQorCXU2NCB1ID0gZXRoZXJfYWRkcl90b191NjQoYWRkcik7DQorDQorCXUrKzsNCisJ
dTY0X3RvX2V0aGVyX2FkZHIodSwgYWRkcik7DQorfQ0KKw0KIC8qKg0KICAqIGlzX2V0aGVyZGV2
X2FkZHIgLSBUZWxsIGlmIGdpdmVuIEV0aGVybmV0IGFkZHJlc3MgYmVsb25ncyB0byB0aGUgZGV2
aWNlLg0KICAqIEBkZXY6IFBvaW50ZXIgdG8gYSBkZXZpY2Ugc3RydWN0dXJlDQotLSANCjIuMTcu
MQ0KDQo=
