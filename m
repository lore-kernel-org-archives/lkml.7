Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09172C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD00E2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="cbNqEWuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfDOOOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:14:24 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:38795 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfDOOOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:14:24 -0400
X-IronPort-AV: E=Sophos;i="5.60,353,1549954800"; 
   d="scan'208";a="29944499"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Apr 2019 07:14:00 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 15 Apr 2019 07:13:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyzC6pA9oB/TE6h9w0402qhWTSUqVJMDYVlr6yWoV9U=;
 b=cbNqEWuu69mgUPxXJq+jqmxSYX4+Qy9iYpK5YfkY1PsDF1y6tAhaE+k7gm9zpagSg9V7GhcYvY6ohRUqLVGESwRkKagEXNROB+0beOQFk/X/OSDmeaWdVV91rKpCfPak65MBgjn3VBYPQwqGGv3VgaVUOiRGwVvBEP1VDjgc9Z4=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1770.namprd11.prod.outlook.com (10.175.88.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Mon, 15 Apr 2019 14:13:52 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc%3]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 14:13:51 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <mchehab@kernel.org>,
        <ksloat@aampglobal.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH v2 2/4] media: v4l2-ctrl: fix flags for DO_WHITE_BALANCE
Thread-Topic: [PATCH v2 2/4] media: v4l2-ctrl: fix flags for DO_WHITE_BALANCE
Thread-Index: AQHU85VzJcq2N51RrkeUqJ+pLX+qwQ==
Date:   Mon, 15 Apr 2019 14:13:51 +0000
Message-ID: <1555337305-13767-3-git-send-email-eugen.hristev@microchip.com>
References: <1555337305-13767-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1555337305-13767-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR08CA0005.eurprd08.prod.outlook.com
 (2603:10a6:803:104::18) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c7d090a-29f5-48ea-be79-08d6c1ac95e8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR11MB1770;
x-ms-traffictypediagnostic: DM5PR11MB1770:
x-microsoft-antispam-prvs: <DM5PR11MB17704B3BACA8055A27310488E82B0@DM5PR11MB1770.namprd11.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(50226002)(107886003)(68736007)(8676002)(256004)(6512007)(446003)(2616005)(72206003)(2906002)(6436002)(2201001)(486006)(86362001)(8936002)(81156014)(81166006)(97736004)(11346002)(478600001)(14454004)(476003)(110136005)(52116002)(76176011)(25786009)(3846002)(102836004)(186003)(6506007)(386003)(66066001)(5660300002)(105586002)(106356001)(4326008)(54906003)(6486002)(305945005)(71190400001)(7736002)(99286004)(53936002)(6116002)(36756003)(71200400001)(316002)(4744005)(26005)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1770;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZG3DGqzzt3LU71xKug7zB1Ij/qqLS/cdpvu3nB2gjSnM9cdr5RO7mC8/cSNEunh+yr7Pahsoal3nKgsTc88rCKGcj5zsI5+kM4Z/kNmF7TcUMsu+sffcA0Q4Zvw2G0zYKikq4FowzAPQrjkDCOru8yvLqZ/qzLTmjY238E98twzu+byIirf73QqOfJJihz9XflpL49D6YweuKVg3Z++kwkYruRUC8e/JABArsUDsifNgt4aVBAiOEdpgiKXqWHMM3DGHbaR9yP9Ukxy8rnym2iWC8sVQiWNy9gTikfqyyrMaW0VWoX0PiAEwL5QOp5EE6DtT5JIM1VmpOR4RN4tU5Zouk2nMeLhB1Mg5B6GBWItXdqrQ7mnm5DkJThBYMheY7WVwGNg0/rEplznrcA3lT8imtTlvKlZdWXz3zMidO6k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7d090a-29f5-48ea-be79-08d6c1ac95e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 14:13:51.9122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1770
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KDQpDb250
cm9sIERPX1dISVRFX0JBTEFOQ0UgaXMgYSBidXR0b24sIHdpdGggcmVhZCBvbmx5IGFuZCBleGVj
dXRlLW9uLXdyaXRlIGZsYWdzLg0KQWRkaW5nIHRoaXMgY29udHJvbCBpbiB0aGUgcHJvcGVyIGxp
c3QgaW4gdGhlIGZpbGwgZnVuY3Rpb24uDQoNCkFmdGVyIGFkZGluZyBpdCBoZXJlLCB3ZSBjYW4g
c2VlIG91dHB1dCBvZiB2NGwyLWN0bCAtTA0KZG9fd2hpdGVfYmFsYW5jZSAweDAwOTgwOTBkIChi
dXR0b24pIDogZmxhZ3M9d3JpdGUtb25seSwgZXhlY3V0ZS1vbi13cml0ZQ0KDQpTaWduZWQtb2Zm
LWJ5OiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQotLS0NCiBk
cml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWN0cmxzLmMgfCAxICsNCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3Jl
L3Y0bDItY3RybHMuYyBiL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItY3RybHMuYw0KaW5k
ZXggYjFhZTJlNS4uMzg4ZWE5MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3Jl
L3Y0bDItY3RybHMuYw0KKysrIGIvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1jdHJscy5j
DQpAQCAtMTE1Myw2ICsxMTUzLDcgQEAgdm9pZCB2NGwyX2N0cmxfZmlsbCh1MzIgaWQsIGNvbnN0
IGNoYXIgKipuYW1lLCBlbnVtIHY0bDJfY3RybF90eXBlICp0eXBlLA0KIAljYXNlIFY0TDJfQ0lE
X0ZMQVNIX1NUUk9CRV9TVE9QOg0KIAljYXNlIFY0TDJfQ0lEX0FVVE9fRk9DVVNfU1RBUlQ6DQog
CWNhc2UgVjRMMl9DSURfQVVUT19GT0NVU19TVE9QOg0KKwljYXNlIFY0TDJfQ0lEX0RPX1dISVRF
X0JBTEFOQ0U6DQogCQkqdHlwZSA9IFY0TDJfQ1RSTF9UWVBFX0JVVFRPTjsNCiAJCSpmbGFncyB8
PSBWNEwyX0NUUkxfRkxBR19XUklURV9PTkxZIHwNCiAJCQkgIFY0TDJfQ1RSTF9GTEFHX0VYRUNV
VEVfT05fV1JJVEU7DQotLSANCjIuNy40DQoNCg==
