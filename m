Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512D9C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1659724103
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="rfYw7sxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbfDYM2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:28:46 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:17366 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfDYM2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:28:45 -0400
X-IronPort-AV: E=Sophos;i="5.60,393,1549954800"; 
   d="scan'208";a="32236326"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Apr 2019 05:28:44 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 25 Apr 2019 05:28:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLOItgOkagNtwzRih3ESsEC6WMRUTvpDPFWuSAcCvmo=;
 b=rfYw7sxV6ERx41tztbXQmHrRzqQPwD3THd/AqCq2rtE5C+wHZRBi/HMMvv7oaGRRrmEtfz4eEbt2shaO+fIC3Gwt01clVNHRG2CjojSY0QR78ttJqWE7VJJUJsBIcB0q2I0V74/5sGPZSwwdfdCn3YHma26uCJHhlboi3jOYu5g=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1470.namprd11.prod.outlook.com (10.172.53.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Thu, 25 Apr 2019 12:28:42 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 12:28:42 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <thierry.reding@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <Sandeep.Sheriker@microchip.com>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 5/6] drm: atmel-hlcdc: add sam9x60 LCD controller
Thread-Topic: [PATCH v3 5/6] drm: atmel-hlcdc: add sam9x60 LCD controller
Thread-Index: AQHU+2JrxZibZKRASUmuMtLyaD0eZQ==
Date:   Thu, 25 Apr 2019 12:28:42 +0000
Message-ID: <1556195285-10687-6-git-send-email-claudiu.beznea@microchip.com>
References: <1556195285-10687-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1556195285-10687-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0254.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::21) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b3420c6-47e8-4314-e3a4-08d6c9798d82
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1470;
x-ms-traffictypediagnostic: MWHPR11MB1470:
x-microsoft-antispam-prvs: <MWHPR11MB14701F553F61D2B27D860AD2873D0@MWHPR11MB1470.namprd11.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(66476007)(7736002)(81156014)(305945005)(66556008)(64756008)(66446008)(8936002)(68736007)(8676002)(73956011)(66946007)(81166006)(5660300002)(6486002)(3846002)(6116002)(6506007)(2501003)(386003)(76176011)(2201001)(102836004)(50226002)(99286004)(86362001)(36756003)(52116002)(4326008)(110136005)(54906003)(107886003)(66066001)(186003)(256004)(26005)(71190400001)(71200400001)(53936002)(25786009)(486006)(478600001)(72206003)(476003)(446003)(11346002)(2616005)(2906002)(97736004)(316002)(6436002)(6512007)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1470;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: amx9Mncc/IqCPZFHQPQzLRvRcCCmXF5owHmEHKjXKIvRjj2SbXb3PrU+Dq8yllw2a/J/MFKOmRLKGce1onWxaIeSCmFQ4nous3fWVt4JjyytYMFyRiztmYrGRM0xMzZB1WJhxd9vL9H3tflm/KmueMvk/hlo5TfiBTmDiusd0NBf913LdtkC2Y5EXcrGeAFp09E0nojSpdRcSRL5R1eVvWP8zj1RglJ0k5WO0klUdgsCQxPB0mVROVS6hGx26zUuoz8HvBIg4gDpSOapS2mTJLLqhW+vP6r3S2316fthD/37tjeJexQdEmpc0PpTqUdoBRGb05M16ApCFBIYf2ccg6siX3sBwgS1a8amAauKCg9PTlcyRyam2Hilla5cnLZHNBqebXFP8HM5YotIqFGILcfLbrJ/HwB23xQn3GNC2LI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3420c6-47e8-4314-e3a4-08d6c9798d82
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 12:28:42.6949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1470
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2FuZGVlcCBTaGVyaWtlciBNYWxsaWthcmp1biA8c2FuZGVlcHNoZXJpa2VyLm1hbGxp
a2FyanVuQG1pY3JvY2hpcC5jb20+DQoNCkFkZCB0aGUgTENEIGNvbnRyb2xsZXIgZm9yIFNBTTlY
NjAuDQoNClNpZ25lZC1vZmYtYnk6IFNhbmRlZXAgU2hlcmlrZXIgTWFsbGlrYXJqdW4gPHNhbmRl
ZXBzaGVyaWtlci5tYWxsaWthcmp1bkBtaWNyb2NoaXAuY29tPg0KW2NsYXVkaXUuYmV6bmVhQG1p
Y3JvY2hpcC5jb206IGFkZCBmaXhlZF9jbGtzcmMgb3B0aW9uIHRvDQogYXRtZWxfaGxjZGNfZGNf
c2FtOXg2MF0NClNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBt
aWNyb2NoaXAuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hs
Y2RjX2RjLmMgfCAxMDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5n
ZWQsIDEwMSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYXRt
ZWwtaGxjZGMvYXRtZWxfaGxjZGNfZGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9h
dG1lbF9obGNkY19kYy5jDQppbmRleCA4YmY1MWY4NTM3MjEuLmZiMmU3NjQ2ZGFlYiAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19kYy5jDQorKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfZGMuYw0KQEAgLTM2NCw2
ICszNjQsMTAzIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXRtZWxfaGxjZGNfZGNfZGVzYyBhdG1l
bF9obGNkY19kY19zYW1hNWQ0ID0gew0KIAkubmxheWVycyA9IEFSUkFZX1NJWkUoYXRtZWxfaGxj
ZGNfc2FtYTVkNF9sYXllcnMpLA0KIAkubGF5ZXJzID0gYXRtZWxfaGxjZGNfc2FtYTVkNF9sYXll
cnMsDQogfTsNCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IGF0bWVsX2hsY2RjX2xheWVyX2Rlc2Mg
YXRtZWxfaGxjZGNfc2FtOXg2MF9sYXllcnNbXSA9IHsNCisJew0KKwkJLm5hbWUgPSAiYmFzZSIs
DQorCQkuZm9ybWF0cyA9ICZhdG1lbF9obGNkY19wbGFuZV9yZ2JfZm9ybWF0cywNCisJCS5yZWdz
X29mZnNldCA9IDB4NjAsDQorCQkuaWQgPSAwLA0KKwkJLnR5cGUgPSBBVE1FTF9ITENEQ19CQVNF
X0xBWUVSLA0KKwkJLmNmZ3Nfb2Zmc2V0ID0gMHgyYywNCisJCS5sYXlvdXQgPSB7DQorCQkJLnhz
dHJpZGUgPSB7IDIgfSwNCisJCQkuZGVmYXVsdF9jb2xvciA9IDMsDQorCQkJLmdlbmVyYWxfY29u
ZmlnID0gNCwNCisJCQkuZGlzY19wb3MgPSA1LA0KKwkJCS5kaXNjX3NpemUgPSA2LA0KKwkJfSwN
CisJCS5jbHV0X29mZnNldCA9IDB4NjAwLA0KKwl9LA0KKwl7DQorCQkubmFtZSA9ICJvdmVybGF5
MSIsDQorCQkuZm9ybWF0cyA9ICZhdG1lbF9obGNkY19wbGFuZV9yZ2JfZm9ybWF0cywNCisJCS5y
ZWdzX29mZnNldCA9IDB4MTYwLA0KKwkJLmlkID0gMSwNCisJCS50eXBlID0gQVRNRUxfSExDRENf
T1ZFUkxBWV9MQVlFUiwNCisJCS5jZmdzX29mZnNldCA9IDB4MmMsDQorCQkubGF5b3V0ID0gew0K
KwkJCS5wb3MgPSAyLA0KKwkJCS5zaXplID0gMywNCisJCQkueHN0cmlkZSA9IHsgNCB9LA0KKwkJ
CS5wc3RyaWRlID0geyA1IH0sDQorCQkJLmRlZmF1bHRfY29sb3IgPSA2LA0KKwkJCS5jaHJvbWFf
a2V5ID0gNywNCisJCQkuY2hyb21hX2tleV9tYXNrID0gOCwNCisJCQkuZ2VuZXJhbF9jb25maWcg
PSA5LA0KKwkJfSwNCisJCS5jbHV0X29mZnNldCA9IDB4YTAwLA0KKwl9LA0KKwl7DQorCQkubmFt
ZSA9ICJvdmVybGF5MiIsDQorCQkuZm9ybWF0cyA9ICZhdG1lbF9obGNkY19wbGFuZV9yZ2JfZm9y
bWF0cywNCisJCS5yZWdzX29mZnNldCA9IDB4MjYwLA0KKwkJLmlkID0gMiwNCisJCS50eXBlID0g
QVRNRUxfSExDRENfT1ZFUkxBWV9MQVlFUiwNCisJCS5jZmdzX29mZnNldCA9IDB4MmMsDQorCQku
bGF5b3V0ID0gew0KKwkJCS5wb3MgPSAyLA0KKwkJCS5zaXplID0gMywNCisJCQkueHN0cmlkZSA9
IHsgNCB9LA0KKwkJCS5wc3RyaWRlID0geyA1IH0sDQorCQkJLmRlZmF1bHRfY29sb3IgPSA2LA0K
KwkJCS5jaHJvbWFfa2V5ID0gNywNCisJCQkuY2hyb21hX2tleV9tYXNrID0gOCwNCisJCQkuZ2Vu
ZXJhbF9jb25maWcgPSA5LA0KKwkJfSwNCisJCS5jbHV0X29mZnNldCA9IDB4ZTAwLA0KKwl9LA0K
Kwl7DQorCQkubmFtZSA9ICJoaWdoLWVuZC1vdmVybGF5IiwNCisJCS5mb3JtYXRzID0gJmF0bWVs
X2hsY2RjX3BsYW5lX3JnYl9hbmRfeXV2X2Zvcm1hdHMsDQorCQkucmVnc19vZmZzZXQgPSAweDM2
MCwNCisJCS5pZCA9IDMsDQorCQkudHlwZSA9IEFUTUVMX0hMQ0RDX09WRVJMQVlfTEFZRVIsDQor
CQkuY2Znc19vZmZzZXQgPSAweDRjLA0KKwkJLmxheW91dCA9IHsNCisJCQkucG9zID0gMiwNCisJ
CQkuc2l6ZSA9IDMsDQorCQkJLm1lbXNpemUgPSA0LA0KKwkJCS54c3RyaWRlID0geyA1LCA3IH0s
DQorCQkJLnBzdHJpZGUgPSB7IDYsIDggfSwNCisJCQkuZGVmYXVsdF9jb2xvciA9IDksDQorCQkJ
LmNocm9tYV9rZXkgPSAxMCwNCisJCQkuY2hyb21hX2tleV9tYXNrID0gMTEsDQorCQkJLmdlbmVy
YWxfY29uZmlnID0gMTIsDQorCQkJLnNjYWxlcl9jb25maWcgPSAxMywNCisJCQkucGhpY29lZmZz
ID0gew0KKwkJCQkueCA9IDE3LA0KKwkJCQkueSA9IDMzLA0KKwkJCX0sDQorCQkJLmNzYyA9IDE0
LA0KKwkJfSwNCisJCS5jbHV0X29mZnNldCA9IDB4MTIwMCwNCisJfSwNCit9Ow0KKw0KK3N0YXRp
YyBjb25zdCBzdHJ1Y3QgYXRtZWxfaGxjZGNfZGNfZGVzYyBhdG1lbF9obGNkY19kY19zYW05eDYw
ID0gew0KKwkubWluX3dpZHRoID0gMCwNCisJLm1pbl9oZWlnaHQgPSAwLA0KKwkubWF4X3dpZHRo
ID0gMjA0OCwNCisJLm1heF9oZWlnaHQgPSAyMDQ4LA0KKwkubWF4X3NwdyA9IDB4ZmYsDQorCS5t
YXhfdnB3ID0gMHhmZiwNCisJLm1heF9ocHcgPSAweDNmZiwNCisJLmZpeGVkX2Nsa3NyYyA9IHRy
dWUsDQorCS5ubGF5ZXJzID0gQVJSQVlfU0laRShhdG1lbF9obGNkY19zYW05eDYwX2xheWVycyks
DQorCS5sYXllcnMgPSBhdG1lbF9obGNkY19zYW05eDYwX2xheWVycywNCit9Ow0KKw0KIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGF0bWVsX2hsY2RjX29mX21hdGNoW10gPSB7DQog
CXsNCiAJCS5jb21wYXRpYmxlID0gImF0bWVsLGF0OTFzYW05bjEyLWhsY2RjIiwNCkBAIC0zODUs
NiArNDgyLDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGF0bWVsX2hsY2Rj
X29mX21hdGNoW10gPSB7DQogCQkuY29tcGF0aWJsZSA9ICJhdG1lbCxzYW1hNWQ0LWhsY2RjIiwN
CiAJCS5kYXRhID0gJmF0bWVsX2hsY2RjX2RjX3NhbWE1ZDQsDQogCX0sDQorCXsNCisJCS5jb21w
YXRpYmxlID0gIm1pY3JvY2hpcCxzYW05eDYwLWhsY2RjIiwNCisJCS5kYXRhID0gJmF0bWVsX2hs
Y2RjX2RjX3NhbTl4NjAsDQorCX0sDQogCXsgLyogc2VudGluZWwgKi8gfSwNCiB9Ow0KIE1PRFVM
RV9ERVZJQ0VfVEFCTEUob2YsIGF0bWVsX2hsY2RjX29mX21hdGNoKTsNCi0tIA0KMi43LjQNCg0K
