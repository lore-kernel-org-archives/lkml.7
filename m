Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88B5C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C35A217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="nHA1TrHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfEJLXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:23:45 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:61924 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfEJLXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:23:43 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,453,1549954800"; 
   d="scan'208";a="32481306"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 May 2019 04:23:42 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 10 May 2019 04:23:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdaiyIKcD+Ij4voBQqWKWs/6VTrWHtTD2MjTZuMJq0s=;
 b=nHA1TrHQa/Kdyeux6OrtPkWh+YFpIFGmpFaEv+VA16b/MIFUy0pWS62GZmP9TE10dqWYKEA5i4TGtke/k22FvtrMn6s8aZ0fgz1zyFZWpkLhfp3UhldPLIDOtZM41CArI2pfr9kwhVRtNJY9O3RQeuieFhdVZJ1Izqnjgujsbtc=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1935.namprd11.prod.outlook.com (10.175.54.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Fri, 10 May 2019 11:23:40 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 11:23:40 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 4/4] clk: at91: sckc: add support for SAM9X60
Thread-Topic: [PATCH v3 4/4] clk: at91: sckc: add support for SAM9X60
Thread-Index: AQHVByLRkxkV9DZjpEixl1qT+jadoA==
Date:   Fri, 10 May 2019 11:23:40 +0000
Message-ID: <1557487388-32098-5-git-send-email-claudiu.beznea@microchip.com>
References: <1557487388-32098-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1557487388-32098-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0031.eurprd07.prod.outlook.com
 (2603:10a6:800:90::17) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd260084-f17a-420e-8e4b-08d6d539f39b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1935;
x-ms-traffictypediagnostic: MWHPR11MB1935:
x-microsoft-antispam-prvs: <MWHPR11MB1935DC9E2B92B7B827199F46870C0@MWHPR11MB1935.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(366004)(376002)(199004)(189003)(256004)(52116002)(478600001)(3846002)(99286004)(72206003)(68736007)(26005)(5660300002)(6116002)(66446008)(110136005)(107886003)(2906002)(4326008)(186003)(386003)(6506007)(66476007)(64756008)(66946007)(102836004)(66556008)(54906003)(2501003)(76176011)(14454004)(6512007)(73956011)(6436002)(2616005)(6486002)(7736002)(305945005)(53936002)(66066001)(25786009)(316002)(71200400001)(71190400001)(86362001)(11346002)(446003)(8676002)(81166006)(50226002)(36756003)(81156014)(476003)(8936002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1935;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /lNEvNvGyAiHfebKVe57YDsQV9DlXQHXY2IQ4zsrNDQcig4oT2gdElCKVIkrRqiD4grSlKRZ5TL/tDJVGzi4UUMzxsNY3CeNITWsfiiwSzpr7+Ve3kAtGed3jScuBZeXqascNk3Xy1SkfgS26oomy95XPghQWxpAZkjctwjRKVo84bXELUKS0/R33aotHOeSInfpw8zH7CU8e4/U8bV0Q+kEo/aOc2xIzidHnDr1ILCc3EB5kVa2JUEYR6Smmfsnj8OLyW/kGQsvNa6L7G0tRJSdip87nDWNeLEmexj2eFSYDIf4SEw6v0K9XT0o9QgB5JIyMU/kjAaGfFcu91uPXUa4OAtBzvEnc4+IkH2rkUSMZPKp7HQy3TWiPia+Rd04dyH0ji1G99C5MK2vUq1KAVeuIv1k9T7nvZzJXAG1AgA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bd260084-f17a-420e-8e4b-08d6d539f39b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 11:23:40.2549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1935
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCkFk
ZCBzdXBwb3J0IGZvciBTQU05WDYwJ3Mgc2xvdyBjbG9jay4NCg0KU2lnbmVkLW9mZi1ieTogQ2xh
dWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQotLS0NCiBkcml2ZXJz
L2Nsay9hdDkxL3Nja2MuYyB8IDc0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNzQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jbGsvYXQ5MS9zY2tjLmMgYi9kcml2ZXJzL2Nsay9hdDkxL3Nja2Mu
Yw0KaW5kZXggMmE0YWM1NDhkZTgwLi4yYzQxMGY0MWI0MTMgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2Nsay9hdDkxL3Nja2MuYw0KKysrIGIvZHJpdmVycy9jbGsvYXQ5MS9zY2tjLmMNCkBAIC00MTUs
NiArNDE1LDgwIEBAIHN0YXRpYyB2b2lkIF9faW5pdCBvZl9zYW1hNWQzX3Nja2Nfc2V0dXAoc3Ry
dWN0IGRldmljZV9ub2RlICpucCkNCiBDTEtfT0ZfREVDTEFSRShzYW1hNWQzX2Nsa19zY2tjLCAi
YXRtZWwsc2FtYTVkMy1zY2tjIiwNCiAJICAgICAgIG9mX3NhbWE1ZDNfc2NrY19zZXR1cCk7DQog
DQorc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfc2xvd19iaXRzIGF0OTFzYW05eDYwX2JpdHMgPSB7
DQorCS5jcl9vc2MzMmVuID0gQklUKDEpLA0KKwkuY3Jfb3NjMzJieXAgPSBCSVQoMiksDQorCS5j
cl9vc2NzZWwgPSBCSVQoMjQpLA0KK307DQorDQorc3RhdGljIHZvaWQgX19pbml0IG9mX3NhbTl4
NjBfc2NrY19zZXR1cChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQ0KK3sNCisJdm9pZCBfX2lvbWVt
ICpyZWdiYXNlID0gb2ZfaW9tYXAobnAsIDApOw0KKwlzdHJ1Y3QgY2xrX2h3X29uZWNlbGxfZGF0
YSAqY2xrX2RhdGE7DQorCXN0cnVjdCBjbGtfaHcgKnNsb3dfcmMsICpzbG93X29zYzsNCisJY29u
c3QgY2hhciAqeHRhbF9uYW1lOw0KKwljb25zdCBjaGFyICpwYXJlbnRfbmFtZXNbMl0gPSB7ICJz
bG93X3JjX29zYyIsICJzbG93X29zYyIgfTsNCisJYm9vbCBieXBhc3M7DQorCWludCByZXQ7DQor
DQorCWlmICghcmVnYmFzZSkNCisJCXJldHVybjsNCisNCisJc2xvd19yYyA9IGNsa19od19yZWdp
c3Rlcl9maXhlZF9yYXRlKE5VTEwsIHBhcmVudF9uYW1lc1swXSwgTlVMTCwgMCwNCisJCQkJCSAg
ICAgMzI3NjgpOw0KKwlpZiAoSVNfRVJSKHNsb3dfcmMpKQ0KKwkJcmV0dXJuOw0KKw0KKwl4dGFs
X25hbWUgPSBvZl9jbGtfZ2V0X3BhcmVudF9uYW1lKG5wLCAwKTsNCisJaWYgKCF4dGFsX25hbWUp
DQorCQlnb3RvIHVucmVnaXN0ZXJfc2xvd19yYzsNCisNCisJYnlwYXNzID0gb2ZfcHJvcGVydHlf
cmVhZF9ib29sKG5wLCAiYXRtZWwsb3NjLWJ5cGFzcyIpOw0KKwlzbG93X29zYyA9IGF0OTFfY2xr
X3JlZ2lzdGVyX3Nsb3dfb3NjKHJlZ2Jhc2UsIHBhcmVudF9uYW1lc1sxXSwNCisJCQkJCSAgICAg
IHh0YWxfbmFtZSwgNTAwMDAwMCwgYnlwYXNzLA0KKwkJCQkJICAgICAgJmF0OTFzYW05eDYwX2Jp
dHMpOw0KKwlpZiAoSVNfRVJSKHNsb3dfb3NjKSkNCisJCWdvdG8gdW5yZWdpc3Rlcl9zbG93X3Jj
Ow0KKw0KKwljbGtfZGF0YSA9IGt6YWxsb2Moc2l6ZW9mKCpjbGtfZGF0YSkgKyAoMiAqIHNpemVv
ZihzdHJ1Y3QgY2xrX2h3ICopKSwNCisJCQkgICBHRlBfS0VSTkVMKTsNCisJaWYgKCFjbGtfZGF0
YSkNCisJCWdvdG8gdW5yZWdpc3Rlcl9zbG93X29zYzsNCisNCisJLyogTURfU0xDSyBhbmQgVERf
U0xDSy4gKi8NCisJY2xrX2RhdGEtPm51bSA9IDI7DQorCWNsa19kYXRhLT5od3NbMF0gPSBjbGtf
aHdfcmVnaXN0ZXJfZml4ZWRfcmF0ZShOVUxMLCAibWRfc2xjayIsDQorCQkJCQkJICAgICAgcGFy
ZW50X25hbWVzWzBdLA0KKwkJCQkJCSAgICAgIDAsIDMyNzY4KTsNCisJaWYgKElTX0VSUihjbGtf
ZGF0YS0+aHdzWzBdKSkNCisJCWdvdG8gY2xrX2RhdGFfZnJlZTsNCisNCisJY2xrX2RhdGEtPmh3
c1sxXSA9IGF0OTFfY2xrX3JlZ2lzdGVyX3NhbTl4NV9zbG93KHJlZ2Jhc2UsICJ0ZF9zbGNrIiwN
CisJCQkJCQkJIHBhcmVudF9uYW1lcywgMiwNCisJCQkJCQkJICZhdDkxc2FtOXg2MF9iaXRzKTsN
CisJaWYgKElTX0VSUihjbGtfZGF0YS0+aHdzWzFdKSkNCisJCWdvdG8gdW5yZWdpc3Rlcl9tZF9z
bGNrOw0KKw0KKwlyZXQgPSBvZl9jbGtfYWRkX2h3X3Byb3ZpZGVyKG5wLCBvZl9jbGtfaHdfb25l
Y2VsbF9nZXQsIGNsa19kYXRhKTsNCisJaWYgKFdBUk5fT04ocmV0KSkNCisJCWdvdG8gdW5yZWdp
c3Rlcl90ZF9zbGNrOw0KKw0KKwlyZXR1cm47DQorDQordW5yZWdpc3Rlcl90ZF9zbGNrOg0KKwlj
bGtfaHdfdW5yZWdpc3RlcihjbGtfZGF0YS0+aHdzWzFdKTsNCit1bnJlZ2lzdGVyX21kX3NsY2s6
DQorCWNsa19od191bnJlZ2lzdGVyKGNsa19kYXRhLT5od3NbMF0pOw0KK2Nsa19kYXRhX2ZyZWU6
DQorCWtmcmVlKGNsa19kYXRhKTsNCit1bnJlZ2lzdGVyX3Nsb3dfb3NjOg0KKwljbGtfaHdfdW5y
ZWdpc3RlcihzbG93X29zYyk7DQordW5yZWdpc3Rlcl9zbG93X3JjOg0KKwljbGtfaHdfdW5yZWdp
c3RlcihzbG93X3JjKTsNCit9DQorQ0xLX09GX0RFQ0xBUkUoc2FtOXg2MF9jbGtfc2NrYywgIm1p
Y3JvY2hpcCxzYW05eDYwLXNja2MiLA0KKwkgICAgICAgb2Zfc2FtOXg2MF9zY2tjX3NldHVwKTsN
CisNCiBzdGF0aWMgaW50IGNsa19zYW1hNWQ0X3Nsb3dfb3NjX3ByZXBhcmUoc3RydWN0IGNsa19o
dyAqaHcpDQogew0KIAlzdHJ1Y3QgY2xrX3NhbWE1ZDRfc2xvd19vc2MgKm9zYyA9IHRvX2Nsa19z
YW1hNWQ0X3Nsb3dfb3NjKGh3KTsNCi0tIA0KMi43LjQNCg0K
