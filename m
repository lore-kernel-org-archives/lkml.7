Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44363C282E1
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 19:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084882064A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 19:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="j7ny9HEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfDUTJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 15:09:37 -0400
Received: from mail-eopbgr00045.outbound.protection.outlook.com ([40.107.0.45]:18293
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbfDUTJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 15:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3mm7nbeo4oaYvLFZpG8Hd1YoUCaNzJ2tgaQQg5naXA=;
 b=j7ny9HEbM+rM2Mz/Sk3FuIOwNiEBzj7czm9mq3cAoJCSVVvY+UeZ9jNctCOviwSdHQssWs6rJTahCURC3Jqqjw4PiqP8jDdjtrGug92oNicLp75liFqKwY+NkLwHUmQnQrCFTbCZmjFnNsqWwDX7ka0viW3q3X6juJKUsOjO/k8=
Received: from DB7PR06MB5563.eurprd06.prod.outlook.com (20.178.104.212) by
 DB7PR06MB4726.eurprd06.prod.outlook.com (20.177.123.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Sun, 21 Apr 2019 19:09:28 +0000
Received: from DB7PR06MB5563.eurprd06.prod.outlook.com
 ([fe80::edef:902c:11a7:478]) by DB7PR06MB5563.eurprd06.prod.outlook.com
 ([fe80::edef:902c:11a7:478%6]) with mapi id 15.20.1813.017; Sun, 21 Apr 2019
 19:09:28 +0000
From:   Han Nandor <nandor.han@vaisala.com>
To:     "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Han Nandor <nandor.han@vaisala.com>
Subject: [PATCH v3 0/2] Use NVMEM as reboot-mode write interface
Thread-Topic: [PATCH v3 0/2] Use NVMEM as reboot-mode write interface
Thread-Index: AQHU+HW9BAqFj/4GY0aVwG6nlnrHjg==
Date:   Sun, 21 Apr 2019 19:09:28 +0000
Message-ID: <20190421190913.1478-1-nandor.han@vaisala.com>
References: <fc60b885f1b447ce55950184c7921cfc1c96ade6>
In-Reply-To: <fc60b885f1b447ce55950184c7921cfc1c96ade6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0060.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::28) To DB7PR06MB5563.eurprd06.prod.outlook.com
 (2603:10a6:10:83::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nandor.han@vaisala.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.2
x-originating-ip: [91.195.247.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1381bdeb-f3e5-46ba-5491-08d6c68cdfd0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DB7PR06MB4726;
x-ms-traffictypediagnostic: DB7PR06MB4726:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <DB7PR06MB4726D19830690F32FCCD35F485210@DB7PR06MB4726.eurprd06.prod.outlook.com>
x-forefront-prvs: 0014E2CF50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39840400004)(376002)(346002)(366004)(396003)(189003)(199004)(446003)(6512007)(486006)(71200400001)(66446008)(66476007)(36756003)(2501003)(26005)(14454004)(8936002)(81156014)(25786009)(316002)(81166006)(8676002)(110136005)(2906002)(1076003)(14444005)(6506007)(76176011)(476003)(256004)(86362001)(11346002)(68736007)(66556008)(64756008)(71190400001)(2616005)(73956011)(66946007)(186003)(2201001)(102836004)(386003)(11926002)(97736004)(5660300002)(7736002)(6486002)(478600001)(99286004)(53936002)(52116002)(4326008)(5790100002)(3846002)(66066001)(6116002)(6436002)(107886003)(305945005)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR06MB4726;H:DB7PR06MB5563.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uE0/tBo17dhiZXfl9A9WlldUUglSaLC/wMmm0i0zrCq8T+wxtHvL7tA9fULKQmo3qidr2Icm9LzLRYQdjE/IF63/OiDwLIx5ulSZWRLCRCbCXTTWyxI4J6SsidoJpcxt+2Pu9M25A256z51eVFAOBxeVsuZjkqeGSG16TI0eKhLvzLrtpgM0Pf9Z43YSX995NJoR9tsZMv6yxg4W868ErkEiHSx8HbiA+/Hq+rTeDMrEtIHsVSsJ4Ufgv5peltRFOO5BxVJVvieVPZbt5Uy6KFnj1FHYQj04QKRAPqu2ub3UMSSd7Bm5QJvalryTONOH8JgYP/MqKEvH+r+c9jk7fQvmuPAL0GEb782ns+ZOqtA4/e7e2a/oKdhfX5cZz2W4fuxLFa63SOP1evOiPErqyPJidKhAC9yL1+kfbVMSfjQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1381bdeb-f3e5-46ba-5491-08d6c68cdfd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2019 19:09:28.4255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4726
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
CkNoYW5nZXMgc2luY2UgdjI6DQotLS0tLS0tLS0tLS0tLS0tDQogLSBjaGFuZ2UgdGhlIG1vZHVs
ZSBsaWNlbnNlIHRvIEdQTCBzaW5jZSBHUEwgdjIgaXMgZGVwcmVjYXRlZA0KDQpOYW5kb3IgSGFu
ICgyKToNCiAgcG93ZXI6IHJlc2V0OiBudm1lbS1yZWJvb3QtbW9kZTogdXNlIE5WTUVNIGFzIHJl
Ym9vdCBtb2RlIHdyaXRlDQogICAgaW50ZXJmYWNlDQogIGR0LWJpbmRpbmdzOiBwb3dlcjogcmVz
ZXQ6IGFkZCBkb2N1bWVudCBmb3IgTlZNRU0gYmFzZWQgcmVib290LW1vZGUNCg0KIC4uLi9wb3dl
ci9yZXNldC9udm1lbS1yZWJvb3QtbW9kZS50eHQgICAgICAgICB8IDMyICsrKysrKysrDQogZHJp
dmVycy9wb3dlci9yZXNldC9LY29uZmlnICAgICAgICAgICAgICAgICAgIHwgIDkgKysrDQogZHJp
dmVycy9wb3dlci9yZXNldC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgIHwgIDEgKw0KIGRyaXZl
cnMvcG93ZXIvcmVzZXQvbnZtZW0tcmVib290LW1vZGUuYyAgICAgICB8IDc2ICsrKysrKysrKysr
KysrKysrKysNCiA0IGZpbGVzIGNoYW5nZWQsIDExOCBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9yZXNldC9u
dm1lbS1yZWJvb3QtbW9kZS50eHQNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wb3dlci9y
ZXNldC9udm1lbS1yZWJvb3QtbW9kZS5jDQoNCi0tIA0KMi4xNy4yDQoNCg==
