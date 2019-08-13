Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D78C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCD12063F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="aDAo2116"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfHMJiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:38:13 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:47464 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfHMJiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:38:12 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Razvan.Stefanescu@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Razvan.Stefanescu@microchip.com";
  x-sender="Razvan.Stefanescu@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Razvan.Stefanescu@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Razvan.Stefanescu@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: hZ4tes5AtQ7fmsEgbDRkKuGV8BfpjwEPSYDhzA0d8S4vUQTMenKUXF/J4/z2JPegz3iTmc2OHa
 dRjJnQRe6EZkon01s827NHeSpsRBfjU/GA90YSAlPe6q3jrRS+7g2iK/d1WYKIwUPdDBH0jFnd
 s7R8uDc5ExmkQHpDX4eMj5j1/XwWnISHHQ3DNA4pG4TdZbc7QowiOhOyZlmvvBMfFmMQEpbZ7j
 QqzYSnULlVwVGCADg1peCjRTD1hl9Fjn3PWEFac5LK+7sPw9HaRF0/SBRN833R+VRMrvpYMp/8
 fbs=
X-IronPort-AV: E=Sophos;i="5.64,381,1559545200"; 
   d="scan'208";a="46344478"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Aug 2019 02:38:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 13 Aug 2019 02:38:02 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 13 Aug 2019 02:38:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Co1hCJV1Mb7rVl7oBhsrOsbhcokAO1Gd1mzvQxvCtsdMUJ1f4fp/I/pC6Gqf/O83Aukfd0A5m0T6ji7OrZcCTEtgxwCXGrt+EJfEdNhWCdnC8Y4kRdVPNLyEOrjjFC7pnBC8v11y+aCR3/VaoexTxWajtKdWMDQec4Lzrl3nhtgfUfxqQwFgEiHOoBWWrv4J/uYJuCYm5eaKoIzNR1MuGxaV4o526BjL0ojVpskgn7ZXBtPF6fNGYWNqtgLulP8C3yUuSt3jFQQ8SQbrjd7keseBwCctPzvVo9QK2OvtxlgZU6MzL5Ko2SBvb6Iy2OZ559SS69Pf8c3xkJa4URXblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60fGTrMSqS+7dszagI2W4cnKQJJeO62qRF/3nXNonuY=;
 b=i9KU35VV09R6Kqlpw8x9IUGQM2oepGdrAUVBEmjG059i6+biTRsMh26OaL+jI1PGv1VCSM8g+cKhhLuD9zfbq5Bf4jqtVbgNOTX2KbtZKAjEv3ISTMjjdONgrDDicWl+OCd6lWaaR6zuW3fOs8liP6JIHT8XlK7Eg1raJl+Zt/v82eKcO3KWDIZ94m/IXdNZA33A7Uj/Y1Z9w00EntUZYUu1EBBFDPAe+xrE4yuJF+zsPDkSk8dKaxfHMg4WJFc+/ICqOnVKEUm9EomeFQs/55hNl+fTi6KwN/KSUMILsyS05ZiBMSH+4zXyqc2a6zmDQo0z6gzVd9fLPbGjYn2AAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60fGTrMSqS+7dszagI2W4cnKQJJeO62qRF/3nXNonuY=;
 b=aDAo2116N74U5gZX/omzihXhHtJlCEwEETFSNY3SIKFucf4Aj1rIx8Rakli8MHYl+XLf8/e9vijF0MKQv5AS99V+j/fvcmWgSRLN/LOw/+DQSRe++9sJT7m9zx3HEc6Q4X8Wcxz+udp4DvISHFY0YQLTQ/qE//hIboxTj8NmBUk=
Received: from MWHPR11MB1358.namprd11.prod.outlook.com (10.169.233.136) by
 MWHPR11MB1279.namprd11.prod.outlook.com (10.169.237.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Tue, 13 Aug 2019 09:38:01 +0000
Received: from MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::6cfc:6aaf:c384:acae]) by MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::6cfc:6aaf:c384:acae%4]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 09:38:01 +0000
From:   <Razvan.Stefanescu@microchip.com>
To:     <ioana.ciornei@nxp.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <joe@perches.com>, <andrew@lunn.ch>, <ruxandra.radulescu@nxp.com>
Subject: Re: [PATCH v2 10/10] staging: fsl-dpaa2/ethsw: do not force user to
 bring interface down
Thread-Topic: [PATCH v2 10/10] staging: fsl-dpaa2/ethsw: do not force user to
 bring interface down
Thread-Index: AQHVUbTVMddUTIisX0my4SMNGS3LRKb40iKA
Date:   Tue, 13 Aug 2019 09:38:01 +0000
Message-ID: <9f932adb-fb6d-2973-f5af-6ba9a83be454@microchip.com>
References: <1565686479-32577-1-git-send-email-ioana.ciornei@nxp.com>
 <1565686479-32577-11-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1565686479-32577-11-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0084.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::24) To MWHPR11MB1358.namprd11.prod.outlook.com
 (2603:10b6:300:23::8)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af502aea-ced6-4c5d-716d-08d71fd1eee4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR11MB1279;
x-ms-traffictypediagnostic: MWHPR11MB1279:
x-microsoft-antispam-prvs: <MWHPR11MB127955C53B1CE149AEF05165E8D20@MWHPR11MB1279.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(66446008)(53546011)(66476007)(81166006)(14444005)(66556008)(66946007)(102836004)(6116002)(26005)(6506007)(3846002)(446003)(6512007)(52116002)(186003)(386003)(99286004)(2906002)(8936002)(64756008)(31686004)(2501003)(36756003)(76176011)(81156014)(11346002)(14454004)(2616005)(476003)(486006)(478600001)(256004)(8676002)(54906003)(6436002)(66066001)(7736002)(71190400001)(71200400001)(305945005)(110136005)(31696002)(316002)(5660300002)(86362001)(6246003)(229853002)(25786009)(4326008)(6486002)(53936002)(2201001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1279;H:MWHPR11MB1358.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Cg5Xf/9Dx9B8A4bHc/sa/CuPKxqzQ1J9E5fj7slCNLUhsc85eoJqIURgf0hHfaRm9yaQRSdlEbdaX/6sYSu5Svr5VprLUojY5k6HWR7A50R5L7TPQHKMJ8l6TShJsZB0ONIUYvEiBLcM8uEB3MTHxFpZfyw7VK9M6Lqyrk91m6breu4OwqO1KY3qrUESOGWal5R0tpJ0+8SzNCZ+oy+jo9jeGA4hN6YxfEcCEJYRkCgy3xlWIQZdUCUo4cS3vJPjjwTtqCjZYq+3GUwuc6Jcw5Iwt/1o7mpeHIDzPXYcGwN6y0dZUJbZ74brWalQYT/JTcFa2yu2wyzckVvpN6k4cM9Znmyv15zGbgLylrVW1fdD1wd7Q621JGh4OU29B4QG4GDFuDdGJL0yLmNWS7GZ3rBI8XI+GJkL4uslPgWPzmM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B769A0DD95F4154E90F2A6D864F2F9AB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: af502aea-ced6-4c5d-716d-08d71fd1eee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 09:38:01.5947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+uYO6hGmkY7nM8l10u3maR0vPM90DuX2ngdQ8MpzD8rsKQr1mukBDwdqLPP3TOEeombwPNy6833qiCBYU729aKHKl7/yXlpm76lTtb/d5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1279
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEzLzA4LzIwMTkgMTE6NTQsIElvYW5hIENpb3JuZWkgd3JvdGU6DQo+IExpbmsgc2V0
dGluZ3MgY2FuIGJlIGNoYW5nZWQgb25seSB3aGVuIHRoZSBpbnRlcmZhY2UgaXMgZG93bi4gRGlz
YWJsZQ0KPiBhbmQgcmUtZW5hYmxlIHRoZSBpbnRlcmZhY2UsIGlmIG5lY2Vzc2FyeSwgYmVoaW5k
IHRoZSBzY2VuZXMgc28gdGhhdCB3ZSBkbw0KPiBub3QgZm9yY2UgdXNlcnMgdG8gYW4gaWYgZG93
bi91cCBzZXF1ZW5jZS4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1
bm4uY2g+DQo+IFNpZ25lZC1vZmYtYnk6IElvYW5hIENpb3JuZWkgPGlvYW5hLmNpb3JuZWlAbnhw
LmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+ICAgLSBhZGRlZCBSZXBvcnRlZC1ieSB0
YWcNCj4gDQo+ICAgZHJpdmVycy9zdGFnaW5nL2ZzbC1kcGFhMi9ldGhzdy9ldGhzdy1ldGh0b29s
LmMgfCAzMiArKysrKysrKysrKysrKysrKystLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIz
IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zdGFnaW5nL2ZzbC1kcGFhMi9ldGhzdy9ldGhzdy1ldGh0b29sLmMgYi9kcml2ZXJzL3N0YWdp
bmcvZnNsLWRwYWEyL2V0aHN3L2V0aHN3LWV0aHRvb2wuYw0KPiBpbmRleCAwZjlmODM0NWU1MzQu
Ljk5ZDY1OGZlZmExNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL2ZzbC1kcGFhMi9l
dGhzdy9ldGhzdy1ldGh0b29sLmMNCj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL2ZzbC1kcGFhMi9l
dGhzdy9ldGhzdy1ldGh0b29sLmMNCj4gQEAgLTg4LDE2ICs4OCwyMSBAQCBzdGF0aWMgdm9pZCBl
dGhzd19nZXRfZHJ2aW5mbyhzdHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2LA0KPiAgIAkJCSBjb25z
dCBzdHJ1Y3QgZXRodG9vbF9saW5rX2tzZXR0aW5ncyAqbGlua19rc2V0dGluZ3MpDQo+ICAgew0K
PiAgIAlzdHJ1Y3QgZXRoc3dfcG9ydF9wcml2ICpwb3J0X3ByaXYgPSBuZXRkZXZfcHJpdihuZXRk
ZXYpOw0KPiArCXN0cnVjdCBldGhzd19jb3JlICpldGhzdyA9IHBvcnRfcHJpdi0+ZXRoc3dfZGF0
YTsNCj4gICAJc3RydWN0IGRwc3dfbGlua19jZmcgY2ZnID0gezB9Ow0KPiAtCWludCBlcnIgPSAw
Ow0KPiAtDQo+IC0JLyogRHVlIHRvIGEgdGVtcG9yYXJ5IE1DIGxpbWl0YXRpb24sIHRoZSBEUFNX
IHBvcnQgbXVzdCBiZSBkb3duDQo+IC0JICogaW4gb3JkZXIgdG8gYmUgYWJsZSB0byBjaGFuZ2Ug
bGluayBzZXR0aW5ncy4gVGFraW5nIHN0ZXBzIHRvIGxldA0KPiAtCSAqIHRoZSB1c2VyIGtub3cg
dGhhdC4NCj4gLQkgKi8NCj4gLQlpZiAobmV0aWZfcnVubmluZyhuZXRkZXYpKSB7DQo+IC0JCW5l
dGRldl9pbmZvKG5ldGRldiwgIlNvcnJ5LCBpbnRlcmZhY2UgbXVzdCBiZSBicm91Z2h0IGRvd24g
Zmlyc3QuXG4iKTsNCj4gLQkJcmV0dXJuIC1FQUNDRVM7DQo+ICsJYm9vbCBpZl9ydW5uaW5nOw0K
PiArCWludCBlcnIgPSAwLCByZXQ7DQo+ICsNCj4gKwkvKiBJbnRlcmZhY2UgbmVlZHMgdG8gYmUg
ZG93biB0byBjaGFuZ2UgbGluayBzZXR0aW5ncyAqLw0KPiArCWlmX3J1bm5pbmcgPSBuZXRpZl9y
dW5uaW5nKG5ldGRldik7DQo+ICsJaWYgKGlmX3J1bm5pbmcpIHsNCj4gKwkJZXJyID0gZHBzd19p
Zl9kaXNhYmxlKGV0aHN3LT5tY19pbywgMCwNCj4gKwkJCQkgICAgICBldGhzdy0+ZHBzd19oYW5k
bGUsDQo+ICsJCQkJICAgICAgcG9ydF9wcml2LT5pZHgpOw0KPiArCQlpZiAoZXJyKSB7DQo+ICsJ
CQluZXRkZXZfZXJyKG5ldGRldiwgImRwc3dfaWZfZGlzYWJsZSBlcnIgJWRcbiIsIGVycik7DQo+
ICsJCQlyZXR1cm4gZXJyOw0KPiArCQl9DQo+ICAgCX0NCj4gICANCj4gICAJY2ZnLnJhdGUgPSBs
aW5rX2tzZXR0aW5ncy0+YmFzZS5zcGVlZDsNCj4gQEAgLTExNSw2ICsxMjAsMTUgQEAgc3RhdGlj
IHZvaWQgZXRoc3dfZ2V0X2RydmluZm8oc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldiwNCj4gICAJ
CQkJICAgcG9ydF9wcml2LT5pZHgsDQo+ICAgCQkJCSAgICZjZmcpOw0KPiAgIA0KPiArCWlmIChp
Zl9ydW5uaW5nKSB7DQo+ICsJCXJldCA9IGRwc3dfaWZfZW5hYmxlKGV0aHN3LT5tY19pbywgMCwN
Cj4gKwkJCQkgICAgIGV0aHN3LT5kcHN3X2hhbmRsZSwNCj4gKwkJCQkgICAgIHBvcnRfcHJpdi0+
aWR4KTsNCj4gKwkJaWYgKHJldCkgew0KPiArCQkJcmV0dXJuIHJldDsNCj4gKwkJCW5ldGRldl9l
cnIobmV0ZGV2LCAiZHBzd19pZl9lbmFibGUgZXJyICVkXG4iLCByZXQpOw0KSGVsbG8sDQoNClRo
ZXNlIGxhc3QgdHdvIGxpbmVzIG5lZWQgdG8gYmUgc3dhcHBlZC4NCg0KQmVzdCByZWdhcmRzLA0K
UmF6dmFuDQoNCg==
