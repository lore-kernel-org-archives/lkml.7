Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830B2C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E161206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="aJzcuNAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfFMPhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:37:32 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:16164 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfFMPha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:37:30 -0400
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
   d="scan'208";a="37225863"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2019 08:37:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 13 Jun 2019 08:37:26 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 13 Jun 2019 08:37:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuMignnHSk1wHStshTPWzkZhNKC/LFV8UppGFTq0Jmg=;
 b=aJzcuNABY9eHzOXX4HULzTXxX0LnmfwrheU53Kzu0cd8jGhn8WvqkfUmxyHu84vnbx9EHKl1SHHNDh2tb9w7K1BUhuCCCFOpXBTEirWLs6Sb2hYk5E3Isf+FR9ccymJ1IHcmKyc2NmFsNMrqmYCoOtBjozRXSquwUN5XKDEfPWA=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1343.namprd11.prod.outlook.com (10.169.232.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Thu, 13 Jun 2019 15:37:25 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::316b:7774:8db6:30ec]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::316b:7774:8db6:30ec%7]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 15:37:25 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@gmail.com>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 6/7] clk: at91: sckc: improve error path for sama5d4 sck
 registration
Thread-Topic: [PATCH 6/7] clk: at91: sckc: improve error path for sama5d4 sck
 registration
Thread-Index: AQHVIf3m83vVP0B1JUCHfcMSnaofCA==
Date:   Thu, 13 Jun 2019 15:37:25 +0000
Message-ID: <1560440205-4604-7-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: 59b0c989-6bf8-41d2-f972-08d6f01508b2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1343;
x-ms-traffictypediagnostic: MWHPR11MB1343:
x-microsoft-antispam-prvs: <MWHPR11MB13431F894942F3C18032E59187EF0@MWHPR11MB1343.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:386;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(136003)(346002)(189003)(199004)(81156014)(14454004)(486006)(102836004)(50226002)(8936002)(81166006)(99286004)(110136005)(71190400001)(71200400001)(54906003)(53936002)(6436002)(316002)(72206003)(68736007)(8676002)(52116002)(478600001)(2501003)(446003)(25786009)(476003)(386003)(5660300002)(2616005)(86362001)(6506007)(36756003)(11346002)(76176011)(64756008)(6512007)(4326008)(26005)(66476007)(66556008)(2906002)(6116002)(73956011)(66946007)(66446008)(3846002)(107886003)(7736002)(256004)(6486002)(305945005)(186003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1343;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H4+Dz7PbdAY6Obg5kK6sVIM/SODfBjFJhdcfSaNwaWs2VmOvGcfeVtDBOagqjqaFc9qRL+OWXlZg5fgxVd5DPdDQIb9tEzK62EAUXav4yfqSZIKlUQ3fHnNW3CeerjvgIeJWHMy0tewCbA6dV4QcPXioydmpdTpVhffn1V1M5Gxj3SrPjkMg0kluRnNZD8M1f2C399Yz1M8VMBpH8+HiSXdXfL+ArNQbYJkJXwS6uZ0Gae6gtdGmiz9ey7OlsAr3gqTwkMtb3sPjprVnHWGRJN2a0M/sPfUYsLL/wq5p4MLTaquoeX91EA/d2NBxdsXtkde3kgOuFHLZ8u2eJ5vhgsD3RCXpWPXfPnV4TxVOr68xNIhGAS9kiLK0pt66JFqA4hizck/GhfxcCws47zWywYbCDqpQjN8YhtNJL0XE7Lc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b0c989-6bf8-41d2-f972-08d6f01508b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 15:37:25.2922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: claudiu.beznea@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCklt
cHJvdmUgZXJyb3IgcGF0aCBmb3Igc2FtYTVkNCBzY2sgcmVnaXN0cmF0aW9uLg0KDQpTaWduZWQt
b2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCi0t
LQ0KIGRyaXZlcnMvY2xrL2F0OTEvc2NrYy5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAx
NSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0OTEvc2NrYy5jIGIv
ZHJpdmVycy9jbGsvYXQ5MS9zY2tjLmMNCmluZGV4IGM2MWI2YzlkZGI5NC4uZjdhZDNlOTQxNGRj
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9zY2tjLmMNCisrKyBiL2RyaXZlcnMvY2xr
L2F0OTEvc2NrYy5jDQpAQCAtNTY4LDcgKzU2OCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY2xr
X3Nsb3dfYml0cyBhdDkxc2FtYTVkNF9iaXRzID0gew0KIHN0YXRpYyB2b2lkIF9faW5pdCBvZl9z
YW1hNWQ0X3Nja2Nfc2V0dXAoc3RydWN0IGRldmljZV9ub2RlICpucCkNCiB7DQogCXZvaWQgX19p
b21lbSAqcmVnYmFzZSA9IG9mX2lvbWFwKG5wLCAwKTsNCi0Jc3RydWN0IGNsa19odyAqaHc7DQor
CXN0cnVjdCBjbGtfaHcgKnNsb3dfcmMsICpzbG93Y2s7DQogCXN0cnVjdCBjbGtfc2FtYTVkNF9z
bG93X29zYyAqb3NjOw0KIAlzdHJ1Y3QgY2xrX2luaXRfZGF0YSBpbml0Ow0KIAljb25zdCBjaGFy
ICp4dGFsX25hbWU7DQpAQCAtNTc4LDE3ICs1NzgsMTggQEAgc3RhdGljIHZvaWQgX19pbml0IG9m
X3NhbWE1ZDRfc2NrY19zZXR1cChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQ0KIAlpZiAoIXJlZ2Jh
c2UpDQogCQlyZXR1cm47DQogDQotCWh3ID0gY2xrX2h3X3JlZ2lzdGVyX2ZpeGVkX3JhdGVfd2l0
aF9hY2N1cmFjeShOVUxMLCBwYXJlbnRfbmFtZXNbMF0sDQotCQkJCQkJICAgICAgTlVMTCwgMCwg
MzI3NjgsDQotCQkJCQkJICAgICAgMjUwMDAwMDAwKTsNCi0JaWYgKElTX0VSUihodykpDQorCXNs
b3dfcmMgPSBjbGtfaHdfcmVnaXN0ZXJfZml4ZWRfcmF0ZV93aXRoX2FjY3VyYWN5KE5VTEwsDQor
CQkJCQkJCSAgIHBhcmVudF9uYW1lc1swXSwNCisJCQkJCQkJICAgTlVMTCwgMCwgMzI3NjgsDQor
CQkJCQkJCSAgIDI1MDAwMDAwMCk7DQorCWlmIChJU19FUlIoc2xvd19yYykpDQogCQlyZXR1cm47
DQogDQogCXh0YWxfbmFtZSA9IG9mX2Nsa19nZXRfcGFyZW50X25hbWUobnAsIDApOw0KIA0KIAlv
c2MgPSBremFsbG9jKHNpemVvZigqb3NjKSwgR0ZQX0tFUk5FTCk7DQogCWlmICghb3NjKQ0KLQkJ
cmV0dXJuOw0KKwkJZ290byB1bnJlZ2lzdGVyX3Nsb3dfcmM7DQogDQogCWluaXQubmFtZSA9IHBh
cmVudF9uYW1lc1sxXTsNCiAJaW5pdC5vcHMgPSAmc2FtYTVkNF9zbG93X29zY19vcHM7DQpAQCAt
NjAyLDE3ICs2MDMsMjkgQEAgc3RhdGljIHZvaWQgX19pbml0IG9mX3NhbWE1ZDRfc2NrY19zZXR1
cChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQ0KIAlvc2MtPmJpdHMgPSAmYXQ5MXNhbWE1ZDRfYml0
czsNCiANCiAJcmV0ID0gY2xrX2h3X3JlZ2lzdGVyKE5VTEwsICZvc2MtPmh3KTsNCi0JaWYgKHJl
dCkgew0KLQkJa2ZyZWUob3NjKTsNCi0JCXJldHVybjsNCi0JfQ0KKwlpZiAocmV0KQ0KKwkJZ290
byBmcmVlX3Nsb3dfb3NjX2RhdGE7DQogDQotCWh3ID0gYXQ5MV9jbGtfcmVnaXN0ZXJfc2FtOXg1
X3Nsb3cocmVnYmFzZSwgInNsb3djayIsIHBhcmVudF9uYW1lcywgMiwNCi0JCQkJCSAgICZhdDkx
c2FtYTVkNF9iaXRzKTsNCi0JaWYgKElTX0VSUihodykpDQotCQlyZXR1cm47DQorCXNsb3djayA9
IGF0OTFfY2xrX3JlZ2lzdGVyX3NhbTl4NV9zbG93KHJlZ2Jhc2UsICJzbG93Y2siLA0KKwkJCQkJ
ICAgICAgIHBhcmVudF9uYW1lcywgMiwNCisJCQkJCSAgICAgICAmYXQ5MXNhbWE1ZDRfYml0cyk7
DQorCWlmIChJU19FUlIoc2xvd2NrKSkNCisJCWdvdG8gdW5yZWdpc3Rlcl9zbG93X29zYzsNCiAN
Ci0Jb2ZfY2xrX2FkZF9od19wcm92aWRlcihucCwgb2ZfY2xrX2h3X3NpbXBsZV9nZXQsIGh3KTsN
CisJcmV0ID0gb2ZfY2xrX2FkZF9od19wcm92aWRlcihucCwgb2ZfY2xrX2h3X3NpbXBsZV9nZXQs
IHNsb3djayk7DQorCWlmIChXQVJOX09OKHJldCkpDQorCQlnb3RvIHVucmVnaXN0ZXJfc2xvd2Nr
Ow0KKw0KKwlyZXR1cm47DQorDQordW5yZWdpc3Rlcl9zbG93Y2s6DQorCWF0OTFfY2xrX3VucmVn
aXN0ZXJfc2FtOXg1X3Nsb3coc2xvd2NrKTsNCit1bnJlZ2lzdGVyX3Nsb3dfb3NjOg0KKwljbGtf
aHdfdW5yZWdpc3Rlcigmb3NjLT5odyk7DQorZnJlZV9zbG93X29zY19kYXRhOg0KKwlrZnJlZShv
c2MpOw0KK3VucmVnaXN0ZXJfc2xvd19yYzoNCisJY2xrX2h3X3VucmVnaXN0ZXIoc2xvd19yYyk7
DQogfQ0KIENMS19PRl9ERUNMQVJFKHNhbWE1ZDRfY2xrX3Nja2MsICJhdG1lbCxzYW1hNWQ0LXNj
a2MiLA0KIAkgICAgICAgb2Zfc2FtYTVkNF9zY2tjX3NldHVwKTsNCi0tIA0KMi43LjQNCg0K
