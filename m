Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D0CC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390A2218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bPKt8oBS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bo40wxxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfDXBn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:43:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43646 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726958AbfDXBn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:43:56 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3O1hVrY001203;
        Tue, 23 Apr 2019 18:43:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=EoBC2YYQEdiCYLgEjsrY1Ma8fce70PkHJPD3rdyfwPU=;
 b=bPKt8oBSyGHjKtzvvlgaKTr9ZhPzMHKXI16tSFqADo5iZa9LlyaT0NZxX4x9jzJdNa4A
 I/HrK5mw21VpzX9McFXWZBUEtloVfezeK4mDJXXVVTsc8ANvSh2U18DOl7Hpar/A9TiB
 7/K1U/ESKGPsDPpxxawjr9i91/zvvLThX/c= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s2dkxr4hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 23 Apr 2019 18:43:36 -0700
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 23 Apr 2019 18:43:36 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 23 Apr 2019 18:43:35 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 23 Apr 2019 18:43:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoBC2YYQEdiCYLgEjsrY1Ma8fce70PkHJPD3rdyfwPU=;
 b=bo40wxxLN/Vw2FrSaybc3CEhLyhRcU7/D8b76aphtAKK2Tre1mYAwtYfH8n2P4JJD5TL+C9UyRLPAQViM10Z7lSQTQPWhoC3yqQv1C3x8h7TWyVpVfbLJCT1SJrDdnZ/oxdm0WcUCiZndfZuS2KJL5TWaG3vAbSMBCWl/sOHYkw=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1583.namprd15.prod.outlook.com (10.173.235.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 01:43:32 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::9ccc:f6fa:40e2:f1cd]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::9ccc:f6fa:40e2:f1cd%10]) with mapi id 15.20.1813.017; Wed, 24 Apr
 2019 01:43:32 +0000
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
Subject: [PATCH net v4] net/ncsi: handle overflow when incrementing mac
 address
Thread-Topic: [PATCH net v4] net/ncsi: handle overflow when incrementing mac
 address
Thread-Index: AQHU+j8fb/NadFiWqkOTQghGXrE+GQ==
Date:   Wed, 24 Apr 2019 01:43:32 +0000
Message-ID: <20190424014310.24253-1-taoren@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:301:3b::18) To MWHPR15MB1216.namprd15.prod.outlook.com
 (2603:10b6:320:23::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [2620:10d:c090:200::5189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6f28ace-00a5-4db9-1f66-08d6c8564227
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1583;
x-ms-traffictypediagnostic: MWHPR15MB1583:
x-microsoft-antispam-prvs: <MWHPR15MB15831BD809E327455ABB0AD9B23C0@MWHPR15MB1583.namprd15.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(396003)(39860400002)(189003)(199004)(64756008)(52116002)(97736004)(316002)(6486002)(14454004)(99286004)(6436002)(110136005)(486006)(8676002)(5660300002)(53936002)(305945005)(7736002)(2616005)(476003)(81166006)(81156014)(6512007)(1076003)(8936002)(46003)(7416002)(36756003)(6506007)(2906002)(386003)(6116002)(25786009)(50226002)(71190400001)(71200400001)(102836004)(4326008)(478600001)(186003)(256004)(14444005)(86362001)(73956011)(66446008)(68736007)(66946007)(2201001)(66476007)(2501003)(66556008)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1583;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pGdFyqX0FszlMoWNwda97bHndhx1ASAlxC0mybhRN2d8qsnCIsNy5TmmyPnjnT6m6cI5LBYIvumdFYAus4CiQ4xYRTHyYwXdcGkDlJ8fiGRAA/0veYac2mAizIeIoDcc0x2oHNGv2rg7Ndz+Y7Vhzjtb80cVuMcWaeI+yqkrchm2wW9/bWvPdXtzwcP9zm22Kgi/q7FRjciIDGL85fD7Le8ZybepDzeqmTgIgDYKveHdweaaX4O6yW0eMDBqzMExCY6FeR/4onwtWqOQ4V4O84LXAE23hHPT8ZXk3FmTpxmhZosUwmLMHGGd+zONTD0jY3HrVh5Nl5MGqh5zfnweGZg1EITXKlbzvW/3nH93m6hctMIJQUX9xYh+AJkNbuL3XvVkW3esv+S88GKsmcFHfPn/3fq3FNHTDlmJi2NwQxI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f28ace-00a5-4db9-1f66-08d6c8564227
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 01:43:32.6950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1583
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
dGFvcmVuQGZiLmNvbT4NCi0tLQ0KIGluY2x1ZGUvbGludXgvZXRoZXJkZXZpY2UuaCB8IDEyICsr
KysrKysrKysrKw0KIG5ldC9uY3NpL25jc2ktcnNwLmMgICAgICAgICB8ICA2ICsrKysrLQ0KIDIg
ZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpDaGFuZ2Vz
IGluIHY0Og0KIC0gcmV2ZXJ0IHRoZSBjaGFuZ2VzIGluIGV0aF9hZGRyX2RlYygpIGZ1bmN0aW9u
IGNvbW1lbnQuDQpDaGFuZ2VzIGluIHYzOg0KIC0gc3F1YXNoIGNoYW5nZXMgaW4gImV0aGVyZGV2
aWNlLmgiIGludG8gdGhpcyBwYXRjaC4NCiAtIGZpeCBmb3JtYXQgaXNzdWUgaW4gZnVuY3Rpb24g
Y29tbWVudC4NCkNoYW5nZXMgaW4gdjI6DQogLSBpbmNyZW1lbnQgTUFDIGFkZHJlc3MgYnkgY2Fs
bGluZyBldGhfYWRkcl9pbmMoKSBmdW5jdGlvbi4NCiAtIHZhbGlkYXRlIE1BQyBhZGRyZXNzIGJl
Zm9yZSBhc3NpZ25pbmcgdG8gQk1DLg0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ldGhl
cmRldmljZS5oIGIvaW5jbHVkZS9saW51eC9ldGhlcmRldmljZS5oDQppbmRleCBlMmYzYjIxY2Q3
MmEuLmFhOGJmZDZmNzM4YyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvZXRoZXJkZXZpY2Uu
aA0KKysrIGIvaW5jbHVkZS9saW51eC9ldGhlcmRldmljZS5oDQpAQCAtNDQ4LDYgKzQ0OCwxOCBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgZXRoX2FkZHJfZGVjKHU4ICphZGRyKQ0KIAl1NjRfdG9fZXRo
ZXJfYWRkcih1LCBhZGRyKTsNCiB9DQogDQorLyoqDQorICogZXRoX2FkZHJfaW5jKCkgLSBJbmNy
ZW1lbnQgdGhlIGdpdmVuIE1BQyBhZGRyZXNzLg0KKyAqIEBhZGRyOiBQb2ludGVyIHRvIGEgc2l4
LWJ5dGUgYXJyYXkgY29udGFpbmluZyBFdGhlcm5ldCBhZGRyZXNzIHRvIGluY3JlbWVudC4NCisg
Ki8NCitzdGF0aWMgaW5saW5lIHZvaWQgZXRoX2FkZHJfaW5jKHU4ICphZGRyKQ0KK3sNCisJdTY0
IHUgPSBldGhlcl9hZGRyX3RvX3U2NChhZGRyKTsNCisNCisJdSsrOw0KKwl1NjRfdG9fZXRoZXJf
YWRkcih1LCBhZGRyKTsNCit9DQorDQogLyoqDQogICogaXNfZXRoZXJkZXZfYWRkciAtIFRlbGwg
aWYgZ2l2ZW4gRXRoZXJuZXQgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBkZXZpY2UuDQogICogQGRl
djogUG9pbnRlciB0byBhIGRldmljZSBzdHJ1Y3R1cmUNCmRpZmYgLS1naXQgYS9uZXQvbmNzaS9u
Y3NpLXJzcC5jIGIvbmV0L25jc2kvbmNzaS1yc3AuYw0KaW5kZXggZGMwN2ZjYzc5MzhlLi44MDJk
YjAxZTMwNzUgMTAwNjQ0DQotLS0gYS9uZXQvbmNzaS9uY3NpLXJzcC5jDQorKysgYi9uZXQvbmNz
aS9uY3NpLXJzcC5jDQpAQCAtMTEsNiArMTEsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9rZXJuZWwu
aD4NCiAjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KICNpbmNsdWRlIDxsaW51eC9uZXRkZXZpY2Uu
aD4NCisjaW5jbHVkZSA8bGludXgvZXRoZXJkZXZpY2UuaD4NCiAjaW5jbHVkZSA8bGludXgvc2ti
dWZmLmg+DQogDQogI2luY2x1ZGUgPG5ldC9uY3NpLmg+DQpAQCAtNjY3LDcgKzY2OCwxMCBAQCBz
dGF0aWMgaW50IG5jc2lfcnNwX2hhbmRsZXJfb2VtX2JjbV9nbWEoc3RydWN0IG5jc2lfcmVxdWVz
dCAqbnIpDQogCW5kZXYtPnByaXZfZmxhZ3MgfD0gSUZGX0xJVkVfQUREUl9DSEFOR0U7DQogCW1l
bWNweShzYWRkci5zYV9kYXRhLCAmcnNwLT5kYXRhW0JDTV9NQUNfQUREUl9PRkZTRVRdLCBFVEhf
QUxFTik7DQogCS8qIEluY3JlYXNlIG1hYyBhZGRyZXNzIGJ5IDEgZm9yIEJNQydzIGFkZHJlc3Mg
Ki8NCi0Jc2FkZHIuc2FfZGF0YVtFVEhfQUxFTiAtIDFdKys7DQorCWV0aF9hZGRyX2luYygodTgg
KilzYWRkci5zYV9kYXRhKTsNCisJaWYgKCFpc192YWxpZF9ldGhlcl9hZGRyKChjb25zdCB1OCAq
KXNhZGRyLnNhX2RhdGEpKQ0KKwkJcmV0dXJuIC1FTlhJTzsNCisNCiAJcmV0ID0gb3BzLT5uZG9f
c2V0X21hY19hZGRyZXNzKG5kZXYsICZzYWRkcik7DQogCWlmIChyZXQgPCAwKQ0KIAkJbmV0ZGV2
X3dhcm4obmRldiwgIk5DU0k6ICdXcml0aW5nIG1hYyBhZGRyZXNzIHRvIGRldmljZSBmYWlsZWRc
biIpOw0KLS0gDQoyLjE3LjENCg0K
