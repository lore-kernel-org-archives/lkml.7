Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA5AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C3E20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="tyqXkcZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDKFyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:54:08 -0400
Received: from mail-eopbgr60061.outbound.protection.outlook.com ([40.107.6.61]:52766
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfDKFyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwZRpdEHQvPO+4y/YGswZvyJm+/pjrO66N3vae/mhdI=;
 b=tyqXkcZRIDxjyMXtm4DOPQiNp1ujf57eewBE4Ml8fphRVXUMMwRXYrJYkJzTRQu/4qxXNpLgNV+tcvUVh6AWZraFFBT2N7Ph+/kVHg/ZFRu0dNGSBWiyClHqRuR5LaBNT2B+3QCoD8bL975H5VCVvODasIsBWcVCbG4vlLmefWU=
Received: from AM6PR06MB5557.eurprd06.prod.outlook.com (20.178.94.211) by
 AM6PR06MB5461.eurprd06.prod.outlook.com (20.178.91.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Thu, 11 Apr 2019 05:54:04 +0000
Received: from AM6PR06MB5557.eurprd06.prod.outlook.com
 ([fe80::c0b4:b693:fdc7:e476]) by AM6PR06MB5557.eurprd06.prod.outlook.com
 ([fe80::c0b4:b693:fdc7:e476%4]) with mapi id 15.20.1792.009; Thu, 11 Apr 2019
 05:54:04 +0000
From:   Han Nandor <nandor.han@vaisala.com>
To:     "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Han Nandor <nandor.han@vaisala.com>
Subject: [PATCH v2 0/2] Use NVMEM as reboot-mode write interface
Thread-Topic: [PATCH v2 0/2] Use NVMEM as reboot-mode write interface
Thread-Index: AQHU8Cr3IuksBurIX0qE9ETHsNCMmw==
Date:   Thu, 11 Apr 2019 05:54:03 +0000
Message-ID: <20190411055341.9263-1-nandor.han@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0160.eurprd05.prod.outlook.com
 (2603:10a6:7:28::47) To AM6PR06MB5557.eurprd06.prod.outlook.com
 (2603:10a6:20b:9c::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nandor.han@vaisala.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.2
x-originating-ip: [193.143.230.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58f50371-ace8-4835-66c0-08d6be421989
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:AM6PR06MB5461;
x-ms-traffictypediagnostic: AM6PR06MB5461:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <AM6PR06MB5461593DF5808FC1E064BF86852F0@AM6PR06MB5461.eurprd06.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39850400004)(136003)(396003)(189003)(199004)(5660300002)(71190400001)(2616005)(305945005)(6116002)(478600001)(256004)(86362001)(97736004)(68736007)(2906002)(36756003)(7736002)(486006)(476003)(6436002)(8676002)(66066001)(1076003)(14454004)(71200400001)(105586002)(2201001)(6486002)(386003)(6506007)(26005)(99286004)(52116002)(4326008)(316002)(110136005)(14444005)(3846002)(53936002)(8936002)(2501003)(25786009)(81166006)(107886003)(186003)(50226002)(102836004)(106356001)(6512007)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR06MB5461;H:AM6PR06MB5557.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mGoBP6JJHsT7zIvL6ApB1e2HDXw/M4CL+MYVrs5iLxPaWALIlkoBhhiLc+NJrMamnhY1IebQH+c/g7EIgwKQ9occN7sM7oXHAxIp3Ofy0UqgKGzYbMDMGOmkYXGc/BqOpTWHspWOdomIHHNeQ0NYip+fUfKYa7gQUX6obRy53l/m/SXvq7uOgkLPEcLW1lDTvw6Jn0kJDbag1APCqV8vteIVC3IP26TGf7RDfNkP1h/poO/IjcAEPvLdL2POTu7LAW2GLQv97WtWDXgeX9+HoOUC3v9FgpkGV/Q5dRGqUrjPC6KPZ/gCFCoAhMbDmHRMxsj1Gg+msl7OtaFOrvJXPr+OiWy2xx5gnkDfn3UpsND8BuRJSRkpXsqPBrzg60nMcekL9UH/KXzdeuWZ4i6jNihvQtW6LB9vUuCqzdWlo2Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f50371-ace8-4835-66c0-08d6be421989
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 05:54:03.9167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVzY3JpcHRpb24NCi0tLS0tLS0tLS0tDQpFeHRlbmQgdGhlIHJlYm9vdCBtb2RlIGRyaXZlciB0
byB1c2UgYSBOVk1FTSBjZWxsIGFzIHdyaXRpbmcgaW50ZXJmYWNlLg0KDQpUZXN0aW5nDQotLS0t
LS0tDQpUaGUgdGVzdGluZyBpcyBkb25lIGJ5IGNvbmZpZ3VyaW5nIERUIGZyb20gYSBjdXN0b20g
Ym9hcmQuDQpUaGUgTlZNRU0gY2VsbCBpcyBjb25maWd1cmVkIGluIGFuIFJUQyBub24tdm9sYXRp
bGUgbWVtb3J5Lg0KS2VybmVsOiA0LjE0LjYwICh0aGUgcGF0Y2hzZXQgd2FzIHJlYmFzZWQgb24g
a2VybmVsIG1hc3RlcikNCg0KRFQgY29uZmlndXJhdGlvbnM6DQpgDQouLi4NCnJlYm9vdC1tb2Rl
LW52bWVtQDAgew0KICAgIGNvbXBhdGlibGUgPSAic2ltcGxlLW1mZCI7DQogICAgcmVib290LW1v
ZGUgew0KICAgICAgICBjb21wYXRpYmxlID0gIm52bWVtLXJlYm9vdC1tb2RlIjsNCiAgICAgICAg
bnZtZW0tY2VsbHMgPSA8JnJlYm9vdF9tb2RlPjsNCiAgICAgICAgbnZtZW0tY2VsbC1uYW1lcyA9
ICJyZWJvb3QtbW9kZSI7DQoNCiAgICAgICAgbW9kZS10ZXN0ICAgICAgID0gPDB4MjE5NjkxNDc+
Ow0KICAgIH07DQp9Ow0KLi4uDQpyZWJvb3RfbW9kZTogbnZtZW1fcmVib290X21vZGVAMCB7DQog
ICAgICAgIHJlZyA9IDwweDAwIDB4ND47DQp9Ow0KLi4uDQpgDQoNCjEuIFJlYm9vdCB0aGUgc3lz
dGVtIHVzaW5nIHRoZSBjb21tYW5kIGByZWJvb3QgdGVzdGANCg0KMi4gVmVyaWZ5IHRoYXQga2Vy
bmVsIGxvZ3Mgc2hvdyB0aGF0IHJlYm9vdCB3YXMgZG9uZSBpbiBtb2RlIGB0ZXN0YDoNClBBU1MN
CmBbICA0MTMuOTU3MTcyXSByZWJvb3Q6IFJlc3RhcnRpbmcgc3lzdGVtIHdpdGggY29tbWFuZCAn
dGVzdCcgYA0KDQozLiBTdG9wIGluIFUtQm9vdCBhbmQgdmVyaWZ5IHRoYXQgbW9kZSBgdGVzdGAg
bWFnaWMgdmFsdWUgaXMgcHJlc2VudA0KaW4gUlRDcyBub24tdm9sYXRpbGUgbWVtb3J5OiBQQVNT
DQoNCktlcm5lbDogNS4xLjAtcmMzDQoNCjEuIENvbmZpZ3VyZSBgYXJjaC9hcm0vY29uZmlncy9p
bXhfdjZfdjdfZGVmY29uZmlnYCB0byBjb250YWluIA0KYENPTkZJR19OVk1FTV9SRUJPT1RfTU9E
RT15YA0KMi4gVmVyaWZ5IHRoYXQgS2VybmVsIGNvbXBpbGVzIHN1Y2Nlc3NmdWw6IFBBU1MNCmAN
Cm1ha2UgQVJDSD1hcm0gQ1JPU1NfQ09NUElMRT1hcm0tbGludXgtZ251LSBpbXhfdjZfdjdfZGVm
Y29uZmlnIHpJbWFnZQ0KLi4uDQpDQyAgICAgIGRyaXZlcnMvcG93ZXIvcmVzZXQvbnZtZW0tcmVi
b290LW1vZGUubw0KLi4uDQpLZXJuZWw6IGFyY2gvYXJtL2Jvb3QvekltYWdlIGlzIHJlYWR5DQpg
DQpDaGFuZ2VzIHNpbmNlIHYxOg0KLS0tLS0tLS0tLS0tLS0tLS0NCiAtIHNwbGl0IHRoZSBkb2N1
bWVudGF0aW9uIG9uIGEgc2VwYXJhdGUgcGF0Y2gNCiAtIGFkZCBhIG1pc3NpbmcgaGVhZGVyDQoN
Ck5hbmRvciBIYW4gKDIpOg0KICBwb3dlcjogcmVzZXQ6IG52bWVtLXJlYm9vdC1tb2RlOiB1c2Ug
TlZNRU0gYXMgcmVib290IG1vZGUgd3JpdGUNCiAgICBpbnRlcmZhY2UNCiAgZHQtYmluZGluZ3M6
IHBvd2VyOiByZXNldDogYWRkIGRvY3VtZW50IGZvciBOVk1FTSBiYXNlZCByZWJvb3QtbW9kZQ0K
DQogLi4uL3Bvd2VyL3Jlc2V0L252bWVtLXJlYm9vdC1tb2RlLnR4dCAgICAgICAgIHwgMzIgKysr
KysrKysNCiBkcml2ZXJzL3Bvd2VyL3Jlc2V0L0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAg
OSArKysNCiBkcml2ZXJzL3Bvd2VyL3Jlc2V0L01ha2VmaWxlICAgICAgICAgICAgICAgICAgfCAg
MSArDQogZHJpdmVycy9wb3dlci9yZXNldC9udm1lbS1yZWJvb3QtbW9kZS5jICAgICAgIHwgNzYg
KysrKysrKysrKysrKysrKysrKw0KIDQgZmlsZXMgY2hhbmdlZCwgMTE4IGluc2VydGlvbnMoKykN
CiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bv
d2VyL3Jlc2V0L252bWVtLXJlYm9vdC1tb2RlLnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL3Bvd2VyL3Jlc2V0L252bWVtLXJlYm9vdC1tb2RlLmMNCg0KLS0gDQoyLjE3LjINCg0K
