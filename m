Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B7EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EC8206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="PzOD0gsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfFMPhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:37:24 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:16151 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733290AbfFMPhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:37:22 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,369,1557212400"; 
   d="scan'208";a="37225840"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2019 08:37:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 13 Jun 2019 08:37:20 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 13 Jun 2019 08:37:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta0X/y6abik2Sk+vzjIhGrYsydqzWMDUwL32cP5cKvc=;
 b=PzOD0gskIPgZWSxa2QHtT59I8i/xGVWukXgpann/+Fh8zTOgeq3f+QHfPNonPHRZkW12rrSMzJx2ZgB3GV+L+2+W48XhF7O++EvKq5gXjIvKQU/EQcQxLqE1Gj4QF0Rse7PrAVRIyNrwaugc1HAd/3AW0QlAcqS/LOx+1lrh8vo=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1822.namprd11.prod.outlook.com (10.175.54.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 15:37:19 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::316b:7774:8db6:30ec]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::316b:7774:8db6:30ec%7]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 15:37:19 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@gmail.com>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 4/7] clk: at91: sckc: improve error path for sam9x5 sck
 register
Thread-Topic: [PATCH 4/7] clk: at91: sckc: improve error path for sam9x5 sck
 register
Thread-Index: AQHVIf3iLxQmEIlvT06BHQnabFDXmw==
Date:   Thu, 13 Jun 2019 15:37:19 +0000
Message-ID: <1560440205-4604-5-git-send-email-claudiu.beznea@microchip.com>
References: <1560440205-4604-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1560440205-4604-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0174.eurprd09.prod.outlook.com
 (2603:10a6:800:120::28) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f53fef9-a73d-4d6f-a092-08d6f0150507
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1822;
x-ms-traffictypediagnostic: MWHPR11MB1822:
x-microsoft-antispam-prvs: <MWHPR11MB18226A24BBC433F7299464CA87EF0@MWHPR11MB1822.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:170;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(39860400002)(396003)(189003)(199004)(14454004)(478600001)(110136005)(54906003)(256004)(68736007)(2906002)(72206003)(316002)(71200400001)(71190400001)(2501003)(36756003)(50226002)(4326008)(107886003)(25786009)(6512007)(8676002)(8936002)(81156014)(2616005)(476003)(446003)(11346002)(6436002)(6486002)(81166006)(5660300002)(66066001)(99286004)(305945005)(53936002)(7736002)(52116002)(76176011)(66946007)(3846002)(6116002)(86362001)(486006)(66446008)(66556008)(186003)(26005)(6506007)(73956011)(386003)(102836004)(64756008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1822;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OzBln7AzC8fe2ZkTuP3b8BL4hoGJkFOnvT0zAaN2uNittqDJ4xvJt+2LMFSJ5i0eEf9SLPl6aF3z5lhATn1IgHalKdMySUPySLzR367v4WbJRgqwDqfuqcyAByEiacAgmSpwBymbtEtzo+ncSwNLAqIQBY2OAKeMAvMRtj1iOGxV8dyQPq7puGflsog1iBPGN/q45630C4uimgGxxppUyI8aCKBKBtZrgC/E2SPaXUajfRc+N03fmV98YetQ0RHKC8rURXI4php6CEn1ToalkiuQF3Is2vQxmaUfEMlPg8EQgXhno9dERmwMQ9vcuRs889G30lqrUqQVAoAPfyUyC5Xeyq4lynh54gJI+dyreTKTjWTxk4mYInITKdfzAPJz0CNsiXDRXNavqNxhV9c1QrKf3JRLJXLTSrj8fGgzuu0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f53fef9-a73d-4d6f-a092-08d6f0150507
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 15:37:19.1411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: claudiu.beznea@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCklt
cHJvdmUgZXJyb3IgcGF0aCBmb3Igc2FtOXg1IHNsb3cgY2xvY2sgcmVnaXN0cmF0aW9uLg0KDQpT
aWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvY2xrL2F0OTEvc2NrYy5jIHwgNTAgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNl
cnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0
OTEvc2NrYy5jIGIvZHJpdmVycy9jbGsvYXQ5MS9zY2tjLmMNCmluZGV4IDJhNjc3YzU2ZjkwMS4u
YTJiOTA1YzkxMDg1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9zY2tjLmMNCisrKyBi
L2RyaXZlcnMvY2xrL2F0OTEvc2NrYy5jDQpAQCAtMzcxLDE2ICszNzEsMTcgQEAgc3RhdGljIHZv
aWQgX19pbml0IGF0OTFzYW05eDVfc2NrY19yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlX25vZGUgKm5w
LA0KIAl2b2lkIF9faW9tZW0gKnJlZ2Jhc2UgPSBvZl9pb21hcChucCwgMCk7DQogCXN0cnVjdCBk
ZXZpY2Vfbm9kZSAqY2hpbGQgPSBOVUxMOw0KIAljb25zdCBjaGFyICp4dGFsX25hbWU7DQotCXN0
cnVjdCBjbGtfaHcgKmh3Ow0KKwlzdHJ1Y3QgY2xrX2h3ICpzbG93X3JjLCAqc2xvd19vc2MsICpz
bG93Y2s7DQogCWJvb2wgYnlwYXNzOw0KKwlpbnQgcmV0Ow0KIA0KIAlpZiAoIXJlZ2Jhc2UpDQog
CQlyZXR1cm47DQogDQotCWh3ID0gYXQ5MV9jbGtfcmVnaXN0ZXJfc2xvd19yY19vc2MocmVnYmFz
ZSwgcGFyZW50X25hbWVzWzBdLCAzMjc2OCwNCi0JCQkJCSAgIDUwMDAwMDAwLCByY19vc2Nfc3Rh
cnR1cF91cywNCi0JCQkJCSAgIGJpdHMpOw0KLQlpZiAoSVNfRVJSKGh3KSkNCisJc2xvd19yYyA9
IGF0OTFfY2xrX3JlZ2lzdGVyX3Nsb3dfcmNfb3NjKHJlZ2Jhc2UsIHBhcmVudF9uYW1lc1swXSwN
CisJCQkJCQkzMjc2OCwgNTAwMDAwMDAsDQorCQkJCQkJcmNfb3NjX3N0YXJ0dXBfdXMsIGJpdHMp
Ow0KKwlpZiAoSVNfRVJSKHNsb3dfcmMpKQ0KIAkJcmV0dXJuOw0KIA0KIAl4dGFsX25hbWUgPSBv
Zl9jbGtfZ2V0X3BhcmVudF9uYW1lKG5wLCAwKTsNCkBAIC0zODgsNyArMzg5LDcgQEAgc3RhdGlj
IHZvaWQgX19pbml0IGF0OTFzYW05eDVfc2NrY19yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlX25vZGUg
Km5wLA0KIAkJLyogRFQgYmFja3dhcmQgY29tcGF0aWJpbGl0eSAqLw0KIAkJY2hpbGQgPSBvZl9n
ZXRfY29tcGF0aWJsZV9jaGlsZChucCwgImF0bWVsLGF0OTFzYW05eDUtY2xrLXNsb3ctb3NjIik7
DQogCQlpZiAoIWNoaWxkKQ0KLQkJCXJldHVybjsNCisJCQlnb3RvIHVucmVnaXN0ZXJfc2xvd19y
YzsNCiANCiAJCXh0YWxfbmFtZSA9IG9mX2Nsa19nZXRfcGFyZW50X25hbWUoY2hpbGQsIDApOw0K
IAkJYnlwYXNzID0gb2ZfcHJvcGVydHlfcmVhZF9ib29sKGNoaWxkLCAiYXRtZWwsb3NjLWJ5cGFz
cyIpOw0KQEAgLTM5OSwyMyArNDAwLDM2IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBhdDkxc2FtOXg1
X3Nja2NfcmVnaXN0ZXIoc3RydWN0IGRldmljZV9ub2RlICpucCwNCiAJfQ0KIA0KIAlpZiAoIXh0
YWxfbmFtZSkNCi0JCXJldHVybjsNCi0NCi0JaHcgPSBhdDkxX2Nsa19yZWdpc3Rlcl9zbG93X29z
YyhyZWdiYXNlLCBwYXJlbnRfbmFtZXNbMV0sIHh0YWxfbmFtZSwNCi0JCQkJCTEyMDAwMDAsIGJ5
cGFzcywgYml0cyk7DQotCWlmIChJU19FUlIoaHcpKQ0KLQkJcmV0dXJuOw0KKwkJZ290byB1bnJl
Z2lzdGVyX3Nsb3dfcmM7DQogDQotCWh3ID0gYXQ5MV9jbGtfcmVnaXN0ZXJfc2FtOXg1X3Nsb3co
cmVnYmFzZSwgInNsb3djayIsIHBhcmVudF9uYW1lcywgMiwNCi0JCQkJCSAgIGJpdHMpOw0KLQlp
ZiAoSVNfRVJSKGh3KSkNCi0JCXJldHVybjsNCisJc2xvd19vc2MgPSBhdDkxX2Nsa19yZWdpc3Rl
cl9zbG93X29zYyhyZWdiYXNlLCBwYXJlbnRfbmFtZXNbMV0sDQorCQkJCQkgICAgICB4dGFsX25h
bWUsIDEyMDAwMDAsIGJ5cGFzcywgYml0cyk7DQorCWlmIChJU19FUlIoc2xvd19vc2MpKQ0KKwkJ
Z290byB1bnJlZ2lzdGVyX3Nsb3dfcmM7DQogDQotCW9mX2Nsa19hZGRfaHdfcHJvdmlkZXIobnAs
IG9mX2Nsa19od19zaW1wbGVfZ2V0LCBodyk7DQorCXNsb3djayA9IGF0OTFfY2xrX3JlZ2lzdGVy
X3NhbTl4NV9zbG93KHJlZ2Jhc2UsICJzbG93Y2siLCBwYXJlbnRfbmFtZXMsDQorCQkJCQkgICAg
ICAgMiwgYml0cyk7DQorCWlmIChJU19FUlIoc2xvd2NrKSkNCisJCWdvdG8gdW5yZWdpc3Rlcl9z
bG93X29zYzsNCiANCiAJLyogRFQgYmFja3dhcmQgY29tcGF0aWJpbGl0eSAqLw0KIAlpZiAoY2hp
bGQpDQotCQlvZl9jbGtfYWRkX2h3X3Byb3ZpZGVyKGNoaWxkLCBvZl9jbGtfaHdfc2ltcGxlX2dl
dCwgaHcpOw0KKwkJcmV0ID0gb2ZfY2xrX2FkZF9od19wcm92aWRlcihjaGlsZCwgb2ZfY2xrX2h3
X3NpbXBsZV9nZXQsDQorCQkJCQkgICAgIHNsb3djayk7DQorCWVsc2UNCisJCXJldCA9IG9mX2Ns
a19hZGRfaHdfcHJvdmlkZXIobnAsIG9mX2Nsa19od19zaW1wbGVfZ2V0LCBzbG93Y2spOw0KKw0K
KwlpZiAoV0FSTl9PTihyZXQpKQ0KKwkJZ290byB1bnJlZ2lzdGVyX3Nsb3djazsNCisNCisJcmV0
dXJuOw0KKw0KK3VucmVnaXN0ZXJfc2xvd2NrOg0KKwlhdDkxX2Nsa191bnJlZ2lzdGVyX3NhbTl4
NV9zbG93KHNsb3djayk7DQordW5yZWdpc3Rlcl9zbG93X29zYzoNCisJYXQ5MV9jbGtfdW5yZWdp
c3Rlcl9zbG93X29zYyhzbG93X29zYyk7DQordW5yZWdpc3Rlcl9zbG93X3JjOg0KKwlhdDkxX2Ns
a191bnJlZ2lzdGVyX3Nsb3dfcmNfb3NjKHNsb3dfcmMpOw0KIH0NCiANCiBzdGF0aWMgY29uc3Qg
c3RydWN0IGNsa19zbG93X2JpdHMgYXQ5MXNhbTl4NV9iaXRzID0gew0KLS0gDQoyLjcuNA0KDQo=
