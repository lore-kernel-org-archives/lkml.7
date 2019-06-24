Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD5EC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41736208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="fZt+asrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfFXOie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:38:34 -0400
Received: from mail-eopbgr770122.outbound.protection.outlook.com ([40.107.77.122]:3187
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbfFXOid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector2-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88MwFkrLRW09sAI0A8nZ+7uIFYPFLZnkM+2+y68G3p4=;
 b=fZt+asrEt6KTqLMtERk30+GPJdPLcIjT/mTK+1qOWPGZsLO29hVJaAPXG4dguGxvjb+xhRsQJz3ysM790S06PVqATpes34BxZ7sPU3Oppi3ZDCXX0yoec6H5Uj4VZ7GboRwnSjssRDdXXSD7omtmTqw9qiHqo05BmShCQIAW+4U=
Received: from DM6PR01MB4090.prod.exchangelabs.com (20.176.104.151) by
 DM6PR01MB3929.prod.exchangelabs.com (20.176.66.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 14:38:29 +0000
Received: from DM6PR01MB4090.prod.exchangelabs.com
 ([fe80::f0f2:16e1:1db7:ccb3]) by DM6PR01MB4090.prod.exchangelabs.com
 ([fe80::f0f2:16e1:1db7:ccb3%7]) with mapi id 15.20.2008.017; Mon, 24 Jun 2019
 14:38:29 +0000
From:   Hoan Tran OS <hoan@os.amperecomputing.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Open Source Review <OpenSourceReview@amperecomputing.com>,
        Hoan Tran OS <hoan@os.amperecomputing.com>
Subject: [PATCH] arm64: Kconfig: Enable NODES_SPAN_OTHER_NODES config for NUMA
Thread-Topic: [PATCH] arm64: Kconfig: Enable NODES_SPAN_OTHER_NODES config for
 NUMA
Thread-Index: AQHVKpp8SjYC130sVEibrXL3FC+ASw==
Date:   Mon, 24 Jun 2019 14:38:28 +0000
Message-ID: <1561387098-23692-1-git-send-email-Hoan@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR18CA0064.namprd18.prod.outlook.com
 (2603:10b6:903:13f::26) To DM6PR01MB4090.prod.exchangelabs.com
 (2603:10b6:5:2a::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hoan@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [4.28.12.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5902007f-628d-46b4-3293-08d6f8b19e7a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR01MB3929;
x-ms-traffictypediagnostic: DM6PR01MB3929:
x-microsoft-antispam-prvs: <DM6PR01MB392952282822042DF2CB1D3AF1E00@DM6PR01MB3929.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(376002)(136003)(346002)(396003)(366004)(189003)(199004)(66446008)(68736007)(81156014)(6486002)(26005)(4326008)(186003)(256004)(6436002)(6506007)(486006)(386003)(102836004)(4744005)(71200400001)(71190400001)(305945005)(66556008)(64756008)(73956011)(99286004)(86362001)(2616005)(476003)(52116002)(25786009)(66946007)(2906002)(66066001)(7736002)(53936002)(81166006)(8936002)(107886003)(6512007)(110136005)(66476007)(316002)(50226002)(478600001)(5660300002)(14454004)(6116002)(3846002)(8676002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR01MB3929;H:DM6PR01MB4090.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i7A3tHJnWEj1++QD0H5pIvKApNpWhz/e9BS/mRVIoxRAplNFy3bga4sG/cNXrYVaaYWn3EvHh0uhd4mKRrqUORWp4YfkIDjAsmM1HiaCS2FvPMol5zeMs9qUb7mDHHSFhsiqYH5ZwkYym61QfJGMJJ50GnAw9t7NvfDaVwY/luEomjH8vIT5MsRErZeRKXATJcrvAIsux5eWoTZfS2VodvYd2F2XeUXvP3dIA7gPEF45vGvE5Hu/s7icgULTApPAeIJBgwEOZgsFxi38+jHpp0+gwt1LesB9LbC/hPWT8hiuu1jhL6rClb1D+9yA4CHkFl1+61LtKE0MKJgUjI5tSMh/oGsoPwj/L4tnKa2S0jm5YD+bgUrpTwWh42cDcey0Akp1dm/NsZOHz6fsrFDETOq0OqXQEHg7ubAq8aJ1QpU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5902007f-628d-46b4-3293-08d6f8b19e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 14:38:29.1030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hoan@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB3929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29tZSBOVU1BIG5vZGVzIGhhdmUgbWVtb3J5IHJhbmdlcyB0aGF0IHNwYW4gb3RoZXIgbm9kZXMu
DQpFdmVuIHRob3VnaCBhIHBmbiBpcyB2YWxpZCBhbmQgYmV0d2VlbiBhIG5vZGUncyBzdGFydCBh
bmQgZW5kIHBmbnMsDQppdCBtYXkgbm90IHJlc2lkZSBvbiB0aGF0IG5vZGUuDQoNClRoaXMgcGF0
Y2ggZW5hYmxlcyBOT0RFU19TUEFOX09USEVSX05PREVTIGNvbmZpZyBmb3IgTlVNQSB0byBzdXBw
b3J0DQp0aGlzIHR5cGUgb2YgTlVNQSBsYXlvdXQuDQoNClNpZ25lZC1vZmYtYnk6IEhvYW4gVHJh
biA8SG9hbkBvcy5hbXBlcmVjb21wdXRpbmcuY29tPg0KLS0tDQogYXJjaC9hcm02NC9LY29uZmln
IHwgNyArKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9LY29uZmlnIGIvYXJjaC9hcm02NC9LY29uZmlnDQppbmRleCA2OTdl
YTA1Li4yMWZjMTY4IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9LY29uZmlnDQorKysgYi9hcmNo
L2FybTY0L0tjb25maWcNCkBAIC04NzMsNiArODczLDEzIEBAIGNvbmZpZyBORUVEX1BFUl9DUFVf
RU1CRURfRklSU1RfQ0hVTksNCiBjb25maWcgSE9MRVNfSU5fWk9ORQ0KIAlkZWZfYm9vbCB5DQog
DQorIyBTb21lIE5VTUEgbm9kZXMgaGF2ZSBtZW1vcnkgcmFuZ2VzIHRoYXQgc3BhbiBvdGhlciBu
b2Rlcy4NCisjIEV2ZW4gdGhvdWdoIGEgcGZuIGlzIHZhbGlkIGFuZCBiZXR3ZWVuIGEgbm9kZSdz
IHN0YXJ0IGFuZCBlbmQgcGZucywNCisjIGl0IG1heSBub3QgcmVzaWRlIG9uIHRoYXQgbm9kZS4N
Citjb25maWcgTk9ERVNfU1BBTl9PVEhFUl9OT0RFUw0KKwlkZWZfYm9vbCB5DQorCWRlcGVuZHMg
b24gQUNQSV9OVU1BDQorDQogc291cmNlICJrZXJuZWwvS2NvbmZpZy5oeiINCiANCiBjb25maWcg
QVJDSF9TVVBQT1JUU19ERUJVR19QQUdFQUxMT0MNCi0tIA0KMi43LjQNCg0K
