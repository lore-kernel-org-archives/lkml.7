Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8733C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666C7206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Oh6TGp7g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QtNhmkru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfDYNfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:35:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:52281 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfDYNfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556199402; x=1587735402;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=36j7G1Da2dpPvO+9ydhJPf4NyaB4Rn4PcarmYY7mZk0=;
  b=Oh6TGp7grahjVdmIFxBJuBkrHjNNiLHOM6TD8N/QPHeKgaQ3IDwvOi9v
   MveZQawyc9egAQeRvaFHfitphOo3GvqwfsxgEt2K87d/Dw/FIsauyXgFX
   vCZtwA5jAcy4qB0k6iWEKTOJqUxJeWeZbXMMssC8FWW6NlAoSEzUR1PU2
   QSWWgco2Sz1yTiadBQfC3yQh4vMDHC5Bry/NDpHKmRRFL+NNuCS086rxd
   P77v/89T1J/OXY9QL7canBOWJF7MJ27l6rbO6TT/Ps/sggDptL1YKOJMr
   xBeo5Vc9GhY7+pgw+qzj0+UtnKslmpJcej7M96VOLHA/80tQFOx9jnqHO
   w==;
X-IronPort-AV: E=Sophos;i="5.60,393,1549900800"; 
   d="scan'208";a="205942685"
Received: from mail-by2nam01lp2056.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.56])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2019 21:36:40 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36j7G1Da2dpPvO+9ydhJPf4NyaB4Rn4PcarmYY7mZk0=;
 b=QtNhmkru5w+837EKmn2XT0tcrCYWQLgagNZGde4lv+pbCrHBRB8CIheFxXjvYMvAiNBAr3k67IUTwrY4NcRNt6zNhJWpihXhJUxkujoyQFdzVY+owhNiKG4hfUqCCnd4tj6ODVrn/plWT/SySnNUFs1cPgn66PePYFwn8pXf3Sc=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5631.namprd04.prod.outlook.com (20.178.255.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Thu, 25 Apr 2019 13:35:06 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 13:35:06 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] tty: Don't force RISCV SBI console as preferred console
Thread-Topic: [PATCH] tty: Don't force RISCV SBI console as preferred console
Thread-Index: AQHU+2uxkGjV+x23F0K05mNsSIEedQ==
Date:   Thu, 25 Apr 2019 13:35:06 +0000
Message-ID: <20190425133435.56065-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:40::32) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.207.55.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26d70f3c-4ee4-4339-a9eb-08d6c982d3e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB5631;
x-ms-traffictypediagnostic: MN2PR04MB5631:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB5631D3A88549F6133226D86A8D3D0@MN2PR04MB5631.namprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(81166006)(81156014)(2616005)(8936002)(110136005)(2171002)(50226002)(6116002)(3846002)(54906003)(97736004)(6436002)(8676002)(386003)(6506007)(305945005)(86362001)(36756003)(6486002)(7736002)(6512007)(186003)(25786009)(14444005)(26005)(1076003)(256004)(99286004)(5660300002)(486006)(2906002)(73956011)(55236004)(71200400001)(14454004)(71190400001)(52116002)(66476007)(66556008)(64756008)(4326008)(476003)(316002)(66066001)(72206003)(102836004)(53936002)(68736007)(44832011)(66446008)(478600001)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5631;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wq6uKU5r3Ny5pcyPe1OuHotEmuYTuDZSRv6Q1mIbxc4r+ZbsE52lQB9bDwHRuwML/UddVVuqn18r6rdSc0Qc0W2kSgHzYVzIun5n55Ro7vKX567297ktvWruXtPvdMMXY2XSfBsnDS064OWnKCX9Q4qI/Widml6lSO06D2FzM/tH2MI8nae+6Sm9BRmu0kStyDUvHkbBbPWMZKNctcrPSr4XOy03vsvwLzzO7RgQmuAQh+8Zz3ss0AeT1igrNoG9iVAw/GrfOHhnP2cZIZz8YmrGFr8Q7bWtANS10hVGfPG1vljdqItmNbOmMJ927/g4V+RxwNc8Md1nkWonyAPJNQUszFBIEWpwndaImubmgy3WkSfQaxzRlx75n7YzuSiJrpzx1ymFnBhQOMg87ECAR0jlh+zzB/eba+3slXOQ0E8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d70f3c-4ee4-4339-a9eb-08d6c982d3e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 13:35:06.2931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIExpbnV4IGtlcm5lbCB3aWxsIGF1dG8tZGlzYWJsZXMgYWxsIGJvb3QgY29uc29sZXMgd2hl
bmV2ZXIgaXQNCmdldHMgYSBwcmVmZXJyZWQgcmVhbCBjb25zb2xlLg0KDQpDdXJyZW50bHkgb24g
UklTQy1WIHN5c3RlbXMsIGlmIHdlIGhhdmUgYSByZWFsIGNvbnNvbGUgd2hpY2ggaXMgbm90DQpS
SVNDViBTQkkgY29uc29sZSB0aGVuIGJvb3QgY29uc29sZXMgKHN1Y2ggYXMgZWFybHljb249c2Jp
KSBhcmUgbm90DQphdXRvLWRpc2FibGVkIHdoZW4gYSByZWFsIGNvbnNvbGUgKHR0eVMwIG9yIHR0
eVNJRjApIGlzIGF2YWlsYWJsZS4NClRoaXMgcmVzdWx0cyBpbiBkdXBsaWNhdGUgcHJpbnRzIGF0
IGJvb3QtdGltZSBhZnRlciBrZXJuZWwgc3RhcnRzDQp1c2luZyByZWFsIGNvbnNvbGUgKGkuZS4g
dHR5UzAgb3IgdHR5U0lGMCkgaWYgImVhcmx5Y29uPSIga2VybmVsDQpwYXJhbWV0ZXIgd2FzIHBh
c3NlZCBieSBib290bG9hZGVyLg0KDQpUaGUgcmVhc29uIGZvciBhYm92ZSBpc3N1ZSBpcyB0aGF0
IFJJU0NWIFNCSSBjb25zb2xlIGFsd2F5cyBhZGRzDQppdHNlbGYgYXMgcHJlZmVycmVkIGNvbnNv
bGUgd2hpY2ggaXMgY2F1c2luZyBvdGhlciByZWFsIGNvbnNvbGVzDQp0byBiZSBub3QgdXNlZCBh
cyBwcmVmZXJyZWQgY29uc29sZS4NCg0KSWRlYWxseSAiY29uc29sZT0iIGtlcm5lbCBwYXJhbWV0
ZXIgcGFzc2VkIGJ5IGJvb3Rsb2FkZXJzIHNob3VsZA0KYmUgdGhlIG9uZSBzZWxlY3RpbmcgYSBw
cmVmZXJyZWQgcmVhbCBjb25zb2xlLg0KDQpUaGlzIHBhdGNoIGZpeGVzIGFib3ZlIGlzc3VlIGJ5
IG5vdCBmb3JjaW5nIFJJU0NWIFNCSSBjb25zb2xlIGFzDQpwcmVmZXJyZWQgY29uc29sZS4NCg0K
Rml4ZXM6IGFmYTZiMWNjZmFkNSAoInR0eTogTmV3IFJJU0MtViBTQkkgY29uc29sZSBkcml2ZXIi
KQ0KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNClNpZ25lZC1vZmYtYnk6IEFudXAgUGF0ZWwg
PGFudXAucGF0ZWxAd2RjLmNvbT4NCi0tLQ0KIGRyaXZlcnMvdHR5L2h2Yy9odmNfcmlzY3Zfc2Jp
LmMgfCAxIC0NCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy90dHkvaHZjL2h2Y19yaXNjdl9zYmkuYyBiL2RyaXZlcnMvdHR5L2h2Yy9odmNfcmlz
Y3Zfc2JpLmMNCmluZGV4IDc1MTU1YmRlMmI4OC4uMzFmNTNmYTc3ZTRhIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy90dHkvaHZjL2h2Y19yaXNjdl9zYmkuYw0KKysrIGIvZHJpdmVycy90dHkvaHZjL2h2
Y19yaXNjdl9zYmkuYw0KQEAgLTUzLDcgKzUzLDYgQEAgZGV2aWNlX2luaXRjYWxsKGh2Y19zYmlf
aW5pdCk7DQogc3RhdGljIGludCBfX2luaXQgaHZjX3NiaV9jb25zb2xlX2luaXQodm9pZCkNCiB7
DQogCWh2Y19pbnN0YW50aWF0ZSgwLCAwLCAmaHZjX3NiaV9vcHMpOw0KLQlhZGRfcHJlZmVycmVk
X2NvbnNvbGUoImh2YyIsIDAsIE5VTEwpOw0KIA0KIAlyZXR1cm4gMDsNCiB9DQotLSANCjIuMTcu
MQ0KDQo=
