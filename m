Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9BBC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0782084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ViqiAvGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfDILH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:07:59 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:55266 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfDILHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:07:31 -0400
X-IronPort-AV: E=Sophos;i="5.60,329,1549954800"; 
   d="scan'208";a="29738799"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Apr 2019 04:07:31 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 9 Apr 2019 04:07:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6s1nWARTIMRFUwGY6P6J1OogmuU26pUvHe/kHTlwWM=;
 b=ViqiAvGvqvYNhApYWVBgjhHT/Eh3qPxksuMPksarWOA3LdYr/9ZyN6yCMZvuWENdj5o6t75b9ztNcu+8MP35QGLsmRWC8LVLlvfMjclveTYrZpHuQdu02PF8ZgSX811lJwdO24wnOn5pJ4J1Al78h3V8vzkw0ExzoFI9TLgK9Sg=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB0011.namprd11.prod.outlook.com (10.164.155.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Tue, 9 Apr 2019 11:07:28 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc%3]) with mapi id 15.20.1771.021; Tue, 9 Apr 2019
 11:07:28 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>,
        <Nicolas.Ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>
CC:     <ksloat@aampglobal.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH 3/7] media: v4l2-ctrl: fix flags for DO_WHITE_BALANCE
Thread-Topic: [PATCH 3/7] media: v4l2-ctrl: fix flags for DO_WHITE_BALANCE
Thread-Index: AQHU7sRqHQc5o/omJUKgoFlGXxju8Q==
Date:   Tue, 9 Apr 2019 11:07:26 +0000
Message-ID: <1554807715-2353-4-git-send-email-eugen.hristev@microchip.com>
References: <1554807715-2353-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1554807715-2353-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0054.eurprd09.prod.outlook.com
 (2603:10a6:802:28::22) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41bf65b5-c38d-4e87-876b-08d6bcdb8c91
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR11MB0011;
x-ms-traffictypediagnostic: DM5PR11MB0011:
x-microsoft-antispam-prvs: <DM5PR11MB0011EFA666BB3F1842C3AE9FE82D0@DM5PR11MB0011.namprd11.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(396003)(39850400004)(199004)(189003)(256004)(81166006)(66066001)(486006)(8676002)(36756003)(446003)(476003)(5660300002)(81156014)(50226002)(8936002)(71200400001)(71190400001)(2616005)(11346002)(6512007)(106356001)(105586002)(7736002)(305945005)(478600001)(4326008)(2201001)(186003)(99286004)(76176011)(6486002)(107886003)(68736007)(97736004)(72206003)(110136005)(14454004)(316002)(53936002)(52116002)(26005)(54906003)(6436002)(6506007)(6116002)(2501003)(2906002)(3846002)(386003)(25786009)(4744005)(102836004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0011;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FHSFLV/hif9zZEWGO1cKjkGQb+YTIPlpvL9Nm+9ImA1jLBPx09onlSSoRMC+8yqjFBfl8h5j3gsnw+J96Z78+QF05EIvTo3Di81EF3CceyfSN2wXz6pEpDtTKCF7GKq9NxvWz6wpQzkqCIKk06lEMQ5geMdDvrJY7KA+L+isdv86DMjWOCBNCDPu2/5HlomZebpa6If1RLK8x3Bu2gbxr7t2WwwSOrNLYznswNSLghN3NMVLQPGbo9zKibbvODNKxebwscFQKhQ3X/ebrLugvtw72Wmdlt9rD3RrR999CLT0KYEwVKpcOPi864AJbh8MXRQFzfgME5i+iC+Bp43it/qtWRsQp+1edq2RVlFGkkewV0GYe57A95IMBbzSNprcmYOqHkNKaZW3TAT/gQW2N4fRo9GbZiECFwAdzoNRBTo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bf65b5-c38d-4e87-876b-08d6bcdb8c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 11:07:26.7145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0011
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
ZXggYjc5ZDNiYi4uZGMzMmZiNyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3Jl
L3Y0bDItY3RybHMuYw0KKysrIGIvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1jdHJscy5j
DQpAQCAtMTE1MCw2ICsxMTUwLDcgQEAgdm9pZCB2NGwyX2N0cmxfZmlsbCh1MzIgaWQsIGNvbnN0
IGNoYXIgKipuYW1lLCBlbnVtIHY0bDJfY3RybF90eXBlICp0eXBlLA0KIAljYXNlIFY0TDJfQ0lE
X0ZMQVNIX1NUUk9CRV9TVE9QOg0KIAljYXNlIFY0TDJfQ0lEX0FVVE9fRk9DVVNfU1RBUlQ6DQog
CWNhc2UgVjRMMl9DSURfQVVUT19GT0NVU19TVE9QOg0KKwljYXNlIFY0TDJfQ0lEX0RPX1dISVRF
X0JBTEFOQ0U6DQogCQkqdHlwZSA9IFY0TDJfQ1RSTF9UWVBFX0JVVFRPTjsNCiAJCSpmbGFncyB8
PSBWNEwyX0NUUkxfRkxBR19XUklURV9PTkxZIHwNCiAJCQkgIFY0TDJfQ1RSTF9GTEFHX0VYRUNV
VEVfT05fV1JJVEU7DQotLSANCjIuNy40DQoNCg==
