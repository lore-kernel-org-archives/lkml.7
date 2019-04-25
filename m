Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796FAC282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0273A20661
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Vap53Xh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbfDYMgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:36:13 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:49463 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDYMgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:36:12 -0400
X-IronPort-AV: E=Sophos;i="5.60,393,1549954800"; 
   d="scan'208";a="31033441"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Apr 2019 05:36:10 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 25 Apr 2019 05:36:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WI+lVwDp73NV/VWk7hHw9QyxFK3Ep312eKmOewrk6M4=;
 b=Vap53Xh7U17BZDxAnda1edrC08visKbMvlnx0z3kcH0jpUdozB2+3FYTvcTJ8nKz1yQPh2xjhJLd65TlGhi+0RSsCIBRKFXo+1SeK8kLIVUD0/p/ev7pmzt3HKlLdPWhUjykIynyZ1RDBXEuZE4CPPJ80Fot4QSRmMt8Fgx33xQ=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1726.namprd11.prod.outlook.com (10.169.237.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 25 Apr 2019 12:36:05 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 12:36:05 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <thierry.reding@gmail.com>,
        <lee.jones@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [RESEND][PATCH v3 0/6] add LCD support for SAM9X60
Thread-Topic: [RESEND][PATCH v3 0/6] add LCD support for SAM9X60
Thread-Index: AQHU+2NzxFOsw6p3b0iYuTBfPVB4RQ==
Date:   Thu, 25 Apr 2019 12:36:05 +0000
Message-ID: <1556195748-11106-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0802CA0024.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::34) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbd72eb1-eed8-4c40-e363-08d6c97a957c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1726;
x-ms-traffictypediagnostic: MWHPR11MB1726:
x-microsoft-antispam-prvs: <MWHPR11MB172683C4311877A5352AB3E6873D0@MWHPR11MB1726.namprd11.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39850400004)(346002)(376002)(199004)(189003)(81156014)(7416002)(81166006)(97736004)(2201001)(53936002)(5660300002)(8676002)(2501003)(2906002)(86362001)(50226002)(305945005)(6436002)(68736007)(6486002)(72206003)(107886003)(71190400001)(14454004)(6512007)(8936002)(478600001)(186003)(66066001)(26005)(14444005)(256004)(476003)(7736002)(71200400001)(486006)(110136005)(54906003)(6506007)(386003)(6116002)(102836004)(66476007)(66446008)(66946007)(66556008)(36756003)(73956011)(64756008)(4326008)(52116002)(316002)(99286004)(3846002)(2616005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1726;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fkByWaEUo3AtDzssXCgZ0cpTS9aOEunnu4OQl45f6SfEjTXRTHM/b4hA08/v80XQpho+tjhj3cnb6/s3PnSJc5mQ8vYM0fnKEbStoloARmxXHfppfiAkuKvKXHsKL6NAip1wt8q994MaO2bGZZ5pZ/NTLC9C0PG+41shtvcAhErie9wwsHE3ncHD52cxQaql2CjcDP6ZS96gbViEFrK3BO0B4s7Jtc47fk5pCRiWh98nk8r8M5CJkhuvUGGYH/fneHmgG2GS5xA+v2Vjd8hx0bpKlaHny9h3Nvb9VLca86P1FbhbzgIoPdNR0T4QgQa5qL1sNunSWKanPYSnHvTYp1DceDwmPRukVHXVL4tevxVZ2z0GgPvzckF5Al9JRuXtdrgtZgJUFcIBdRTq1MHi1CyinJN6InMgj4A7pDfkDVs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd72eb1-eed8-4c40-e363-08d6c97a957c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 12:36:05.4760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1726
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCkhp
LA0KDQpUaGVzZSBwYXRjaGVzIGFkZHMgc3VwcG9ydCBmb3IgU0FNOVg2MCdzIExDRCBjb250cm9s
bGVyLg0KDQpGaXJzdCBwYXRjaGVzIGFkZCBvcHRpb24gdG8gc3BlY2lmeSBpZiBjb250cm9sbGVy
IGNsb2NrIHNvdXJjZSBpcyBmaXhlZC4NClNlY29uZCBwYXRjaCBhdm9pZCBhIHZhcmlhYmxlIGlu
aXRpYWxpemF0aW9uIGluIGF0bWVsX2hsY2RjX2NydGNfbW9kZV9zZXRfbm9mYigpLg0KVGhlIDNy
ZCBhZGQgY29tcGF0aWJsZXMgaW4gcHdtLWF0bWVsLWhsY2RjIGRyaXZlci4NClRoZSA0dGggcGF0
Y2ggZW5hYmxlcyBzeXNfY2xrIGluIHByb2JlIHNpbmNlIFNBTTlYNjAgbmVlZHMgdGhpcy4NClNw
ZWNpZmljIHN1cHBvcnQgd2FzIGFkZGVkIGFsc28gaW4gc3VzcGVuZC9yZXN1bWUgaG9va3MuDQpU
aGUgNXRoIHBhdGNoIGFkZHMgU0FNOVg2MCdzIExDRCBjb25maWd1cmF0aW9uIGFuZCBlbmFibGVk
IGl0Lg0KDQpJIHRvb2sgdGhlIGNoYW5nZXMgb2YgdGhpcyBzZXJpZXMgYW5kIGludHJvZHVjZWQg
YWxzbyBhIGZpeA0KKHRoaXMgaXMgdGhlIDZ0aCBwYXRjaCBpbiB0aGlzIHNlcmllcykgLSBpZiB5
b3Ugd2FudCB0byBzZW5kIGl0IHNlcGFyYXRlbHkNCkkgd291bGQgZ2xhZGx5IGRvIGl0Lg0KDQpJ
IHJlc2VuZCB0aGlzIHRvIGFsc28gaW5jbHVkZSBMZWUgSm9uZXMgZm9yIHB3bS1hdG1lbC1obGNk
YyBjaGFuZ2VzLg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQpDaGFuZ2VzIGluIHYz
Og0KLSBrZWVwIGNvbXBhdGlibGUgc3RyaW5nIG9uIHBhdGNoIDMvNiBvbiBhIHNpbmdsZSBsaW5l
IChJIGtlZXAgaGVyZSBhIHRhYg0KICBpbiBmcm9udCBvZiAiLmNvbXBhdGlibGUiIHRvIGJlIGFs
aWduZWQgd2l0aCB0aGUgcmVzdCBvZiB0aGUgY29kZSBpbg0KICBhdG1lbF9obGNkY19kdF9pZHNb
XSkNCi0gcGF0Y2hlcyA0LzcgYW5kIDMvNyBmcm9tIHYyIHdlcmUgYXBwbGllZCBzbyByZW1vdmUg
dGhlbSBmcm9tIHRoaXMgdmVyc2lvbg0KLSBhZGQgYSBmaXggZm9yIGF0bWVsX2hsY2RjIChwYXRj
aCA2LzYpDQoNCkNoYW5nZXMgaW4gdjI6DQotIHVzZSAifCIgb3BlcmF0b3IgaW4gcGF0Y2ggMS83
IHRvIHNldCBBVE1FTF9ITENEQ19DTEtTRUwgb24gY2ZnDQotIGNvbGxlY3QgQWNrZWQtYnksIFJl
dmlld2VkLWJ5IHRhZ3MNCg0KQ2xhdWRpdSBCZXpuZWEgKDQpOg0KICBkcm06IGF0bWVsLWhsY2Rj
OiBhZGQgY29uZmlnIG9wdGlvbiBmb3IgY2xvY2sgc2VsZWN0aW9uDQogIGRybTogYXRtZWwtaGxj
ZGM6IGF2b2lkIGluaXRpYWxpemluZyBjZmcgd2l0aCB6ZXJvDQogIHB3bTogYXRtZWwtaGxjZGM6
IGFkZCBjb21wYXRpYmxlIGZvciBTQU05WDYwIEhMQ0RDJ3MgUFdNDQogIGRybS9hdG1lbC1oY2xj
ZGM6IHJldmVydCBzaGlmdCBieSA4DQoNClNhbmRlZXAgU2hlcmlrZXIgTWFsbGlrYXJqdW4gKDIp
Og0KICBkcm06IGF0bWVsLWhsY2RjOiBlbmFibGUgc3lzX2NsayBkdXJpbmcgaW5pdGFsaXphdGlv
bi4NCiAgZHJtOiBhdG1lbC1obGNkYzogYWRkIHNhbTl4NjAgTENEIGNvbnRyb2xsZXINCg0KIGRy
aXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19jcnRjLmMgIHwgIDE4ICsrLS0N
CiBkcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfZGMuYyAgICB8IDEyMCAr
KysrKysrKysrKysrKysrKysrKysrKy0NCiBkcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRt
ZWxfaGxjZGNfZGMuaCAgICB8ICAgMiArDQogZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0
bWVsX2hsY2RjX3BsYW5lLmMgfCAgIDIgKy0NCiBkcml2ZXJzL3B3bS9wd20tYXRtZWwtaGxjZGMu
YyAgICAgICAgICAgICAgICAgICB8ICAgMSArDQogNSBmaWxlcyBjaGFuZ2VkLCAxMzIgaW5zZXJ0
aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi43LjQNCg0K
