Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174FCC31E43
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E458221721
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ZpDt8TZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391140AbfFJPUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:20:12 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:63801 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390367AbfFJPUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:20:11 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Codrin.Ciubotariu@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="Codrin.Ciubotariu@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Codrin.Ciubotariu@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,575,1557212400"; 
   d="scan'208";a="33786257"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jun 2019 08:20:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 10 Jun 2019 08:20:10 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 10 Jun 2019 08:20:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8JCT5Kbub/4EXAub56AxlvqButQls5lDc4iPWwIpZY=;
 b=ZpDt8TZeBKYUccF6dc4ALbubMyzxSpRMRi/bFObH6gNTJWQGeycaoEXDVLGoQWLMSJEO05PQxhW9uK39TV9ca+ygZrQEn3jAqjyfBt01x0L57nmUURIhAgzYOy6lUhXDgCgMbdaXCtFzMqTPF/0LUSMOy+gISfrPMfQdDBVq36w=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.169.252.10) by
 CY4PR11MB1862.namprd11.prod.outlook.com (10.175.80.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.17; Mon, 10 Jun 2019 15:20:08 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::e595:70a9:abee:aeb8]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::e595:70a9:abee:aeb8%4]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 15:20:07 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <sboyd@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH] clk: at91: generated: Truncate divisor to GENERATED_MAX_DIV +
 1
Thread-Topic: [PATCH] clk: at91: generated: Truncate divisor to
 GENERATED_MAX_DIV + 1
Thread-Index: AQHVH5/8vNlxgKOf4EOJZ39uA10p3w==
Date:   Mon, 10 Jun 2019 15:20:07 +0000
Message-ID: <20190610151712.16572-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0011.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::21) To CY4PR11MB1256.namprd11.prod.outlook.com
 (2603:10b6:903:25::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8eb4e3a-909b-4c2a-406a-08d6edb71eb7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR11MB1862;
x-ms-traffictypediagnostic: CY4PR11MB1862:
x-microsoft-antispam-prvs: <CY4PR11MB18623D4FB8473DA9FD80FFACE7130@CY4PR11MB1862.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:291;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(346002)(366004)(396003)(189003)(199004)(1076003)(72206003)(54906003)(486006)(110136005)(50226002)(478600001)(68736007)(2616005)(86362001)(5660300002)(2906002)(25786009)(476003)(186003)(305945005)(4326008)(7736002)(316002)(107886003)(8936002)(81156014)(14454004)(8676002)(81166006)(52116002)(66476007)(6436002)(73956011)(64756008)(6486002)(66946007)(66556008)(53936002)(2501003)(6512007)(99286004)(6116002)(3846002)(6636002)(102836004)(386003)(6506007)(26005)(256004)(71200400001)(66446008)(36756003)(71190400001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1862;H:CY4PR11MB1256.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +zgjZ2HYP8U9OxQUx2tKYQlFlu/BmQrMpsWHYhVwnpXWe1Osj8iZPX9dkPDtZR6bzyFc08LTHOLJyzp9OAPemK2DBocwV5bgG1LbfKjslqe3BFjlf9144znv71FsZ1Z8YfX7AcIwKAg16/BCdmkPvPEaZ2qA8Vtrp6UT+Vn9Jvq4WNiTU9XuiClaRqPnUh5bJBkXXqem4v0t3V0tc1wuQ7YllThwNrnlrK18V5kQ4RBC63iRaPRscmWE8e9zNRYj8x56OwgA7OLlZwikIOne32WXnmp8SGhgkY20xbtTFH14YLpIl0yLrycTVZF/gAOxMy6GQ+emnp4kyuwX/bnZ+HAFL87/YmMf0xEa/r1MrcNELvd0b5lrjHSXSNUCj/Kz2cG+NUmqDi6JBcKYqt7W4zQX31i9wIFvjD8aIYi5seM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e8eb4e3a-909b-4c2a-406a-08d6edb71eb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 15:20:07.6083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Codrin.Ciubotariu@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1862
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ29kcmluIENpdWJvdGFyaXUgPGNvZHJpbi5jaXVib3Rhcml1QG1pY3JvY2hpcC5jb20+
DQoNCkluIGNsa19nZW5lcmF0ZWRfZGV0ZXJtaW5lX3JhdGUoKSwgaWYgdGhlIGRpdmlzb3IgaXMg
Z3JlYXRlciB0aGFuDQpHRU5FUkFURURfTUFYX0RJViArIDEsIHRoZW4gdGhlIHdyb25nIGJlc3Rf
cmF0ZSB3aWxsIGJlIHJldHVybmVkLg0KSWYgY2xrX2dlbmVyYXRlZF9zZXRfcmF0ZSgpIHdpbGwg
YmUgY2FsbGVkIGxhdGVyIHdpdGggdGhpcyB3cm9uZw0KcmF0ZSwgaXQgd2lsbCByZXR1cm4gLUVJ
TlZBTCwgc28gdGhlIGdlbmVyYXRlZCBjbG9jayB3b24ndCBjaGFuZ2UNCml0cyB2YWx1ZS4gRG8g
bm8gbGV0IHRoZSBkaXZpc29yIGJlIGdyZWF0ZXIgdGhhbiBHRU5FUkFURURfTUFYX0RJViArIDEu
DQoNCkZpeGVzOiA4YzdhYTYzMjg5NDcgKCJjbGs6IGF0OTE6IGNsay1nZW5lcmF0ZWQ6IHJlbW92
ZSB1c2VsZXNzIGRpdmlzb3IgbG9vcCIpDQpTaWduZWQtb2ZmLWJ5OiBDb2RyaW4gQ2l1Ym90YXJp
dSA8Y29kcmluLmNpdWJvdGFyaXVAbWljcm9jaGlwLmNvbT4NCi0tLQ0KIGRyaXZlcnMvY2xrL2F0
OTEvY2xrLWdlbmVyYXRlZC5jIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0OTEvY2xrLWdlbmVyYXRlZC5jIGIvZHJp
dmVycy9jbGsvYXQ5MS9jbGstZ2VuZXJhdGVkLmMNCmluZGV4IDVmMTg4NDc5NjVjMS4uMjkwY2Zm
ZTM1ZGViIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9jbGstZ2VuZXJhdGVkLmMNCisr
KyBiL2RyaXZlcnMvY2xrL2F0OTEvY2xrLWdlbmVyYXRlZC5jDQpAQCAtMTQ2LDYgKzE0Niw4IEBA
IHN0YXRpYyBpbnQgY2xrX2dlbmVyYXRlZF9kZXRlcm1pbmVfcmF0ZShzdHJ1Y3QgY2xrX2h3ICpo
dywNCiAJCQljb250aW51ZTsNCiANCiAJCWRpdiA9IERJVl9ST1VORF9DTE9TRVNUKHBhcmVudF9y
YXRlLCByZXEtPnJhdGUpOw0KKwkJaWYgKGRpdiA+IEdFTkVSQVRFRF9NQVhfRElWICsgMSkNCisJ
CQlkaXYgPSBHRU5FUkFURURfTUFYX0RJViArIDE7DQogDQogCQljbGtfZ2VuZXJhdGVkX2Jlc3Rf
ZGlmZihyZXEsIHBhcmVudCwgcGFyZW50X3JhdGUsIGRpdiwNCiAJCQkJCSZiZXN0X2RpZmYsICZi
ZXN0X3JhdGUpOw0KLS0gDQoyLjIwLjENCg0K
