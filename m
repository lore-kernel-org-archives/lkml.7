Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B8CC17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BBB222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="J/FpmF6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfKMLMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 06:12:53 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:47410 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfKMLMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:12:52 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: YsxYRHhZlze133Hqa+SNjMIxUp++hNpwwicLmMfYBYz+7GQNbcStk9xhY1BWtB2TYDm/NyG3zV
 gRpgvUKtJ4lEk115PYgeda/rDGqCN4gYQKfTemafR/DbjCswJ5gOImtc0cxzRTaBmoVQ+Utfz0
 pHsPQ8ri+eqtM6cRr9wpxUm/USyhDOTUJgyZU3+ktoWi2lYuYDkTYSHerq2KWrfR39aKdt5pL9
 6E84KyjtJTjZKeroNAsfOqFpQEAzU9aeobqjNzbN83Omn3e5SG22VhfGFAPA+T5OEtQZkGKont
 jOU=
X-IronPort-AV: E=Sophos;i="5.68,300,1569308400"; 
   d="scan'208";a="56886200"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Nov 2019 04:12:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Nov 2019 04:12:51 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 Nov 2019 04:12:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kC/nPWtEYncgv1ftpQms+eudhk8EAT907J6Hp3J+1UbbtWXlYvnHTFXr4GrpUsOZHQRha6d6KLFzK6i1ajR0gLmh3cE546kHtIi/SiYoMpmBaOOsK3VgSMAIWiLjxnL3qbmAx5R5Fy2+uwPkxDhPrm7W+iPkpam9KTkovtcbRtLe905MJetXjtWfSXWBrMD2O6qO6mQBdCPd2LGUSuCdzYn8a379ROhrlnfoj4y5CTER5r5OpmoJH4wMkCIxjgA6G/qpyUXuUBrv3FJKNYhngundfhJAgJQAjB8Whrwj7CrfvWfVaU/IG5o0gWFEcsgk5PINn2wybC6uel6iLwLEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMeEYAp2IURT/GnEG42jlpDCGRrT8LGYBNWlEPB3C1U=;
 b=UljzBtPzUGPKLmyUkRiASZfW1piVSxxc6AoyZtKbQnwZL5z+OfpTQbx7k6cplGoI6rYGtUVeLKiWfXs2CQLHZapW4mabDAjduQPQ0ld8AlK5u9BKz6RYWqOL2W4OjApG4H9bkiKfE87FsVw/ZqfdBsm/qIzhzSD6/fg/nJRO0SZzwoIUK+WWNcOvbWVo494jDi5lLWpey02aYW91egkQ6yDUtmmmqXjPqPqZoC9qmyqQdDzn2SVFf/VXd0xK2k3ApU6LHfSrplFGJlSKSxOWzzrWbXFSKnVxpnOYLDZhm5BkFf+V+gcukQz3ElZxIZRKn1Y43y8AATsV3p6zl3W8mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMeEYAp2IURT/GnEG42jlpDCGRrT8LGYBNWlEPB3C1U=;
 b=J/FpmF6EdmNrhn8nBhcIpfaU3W2vTf7ogO+45N+vFWRhfpjVimTkP81Jfxu+XP3mjuHSJRmz+m6GqRa6wP718umdMjlQhgnVlBtOfIBPpxBuhzmsS5YY/Wocyc0BOMxqnXUhICUHXJMgYrytBC3HqHvKbyti/m8b/SJPEndyMPM=
Received: from BYAPR11MB3224.namprd11.prod.outlook.com (20.177.127.88) by
 BYAPR11MB3207.namprd11.prod.outlook.com (20.177.184.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 11:12:49 +0000
Received: from BYAPR11MB3224.namprd11.prod.outlook.com
 ([fe80::f4eb:2c83:7aec:ee98]) by BYAPR11MB3224.namprd11.prod.outlook.com
 ([fe80::f4eb:2c83:7aec:ee98%3]) with mapi id 15.20.2430.023; Wed, 13 Nov 2019
 11:12:49 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <tglx@linutronix.de>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <daniel.lezcano@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] clocksource/drivers/timer-microchip-pit64b: add
 Microchip PIT64B support
Thread-Topic: [PATCH v2 2/2] clocksource/drivers/timer-microchip-pit64b: add
 Microchip PIT64B support
Thread-Index: AQHVmhNDyW1jqO+VV0e5ZbsiASmYwg==
Date:   Wed, 13 Nov 2019 11:12:48 +0000
Message-ID: <3dc21a11-ac75-2040-62a9-540cf0f6d5ed@microchip.com>
References: <1572880204-4514-1-git-send-email-claudiu.beznea@microchip.com>
 <1572880204-4514-3-git-send-email-claudiu.beznea@microchip.com>
 <alpine.DEB.2.21.1911041851230.17054@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911041851230.17054@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0068.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::45) To BYAPR11MB3224.namprd11.prod.outlook.com
 (2603:10b6:a03:77::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191113131240659
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46e5dcf3-9887-46e9-d3fc-08d7682a6ac1
x-ms-traffictypediagnostic: BYAPR11MB3207:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB32070CB7B8B39B5AEF9F6B5587760@BYAPR11MB3207.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(396003)(136003)(199004)(189003)(71200400001)(64756008)(186003)(86362001)(53546011)(66446008)(6116002)(6436002)(6486002)(54906003)(305945005)(66066001)(66946007)(66476007)(66556008)(102836004)(256004)(14444005)(316002)(6246003)(31686004)(71190400001)(229853002)(478600001)(6512007)(7736002)(52116002)(25786009)(6506007)(2616005)(76176011)(6916009)(8936002)(486006)(31696002)(81166006)(14454004)(26005)(446003)(99286004)(11346002)(386003)(2906002)(4326008)(5660300002)(476003)(8676002)(36756003)(3846002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3207;H:BYAPR11MB3224.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vOuJP2LFDwdHRdCj34y3Kk+36ZnKQQUnxJGwYc7L044dYpZQdiouw7bFAE6Z18fryeLhupJETLn1avho7p0o2SzY1oJ2pZLvEKBw7uMcp7wLfgNKCSBL5VeXs5/1YY69ZZ0UBKWYg4+aTuYD4eT1tVTbNO+c1SjEfpc4nfYLduK36oYPLf0ufVOcfzanhwAlzClb2m0hXa5vk4475D30+4+/+F4ZENarsazFHwt42AQG7MemNYA1kVM+XZpDh8YVAfgCQSEOu/ext1U54ElmYTbcY1y3N1qHaJjPpcbxh8ZhWoR7ltk4nDejHJJzxrFb4Z0T8JMteQaR0wQVaJlEEhxmpE4GrIPGGpwwE4MWm9qyq4G+cn6MdAqYJNChjyZz3FQf5x9DX9N59MGMMAKuiai7R8uZExackGRFx+/4LBL+KyS5Gx3tiuCMcEcNN4GN
Content-Type: text/plain; charset="utf-8"
Content-ID: <5691F41A79D601419049A548418D0037@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e5dcf3-9887-46e9-d3fc-08d7682a6ac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 11:12:48.7745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 02s+9L8Lx8jn8/7uWc599IFEayyjuRWXVzqqMeAkrElqFI37E9EFyuuoJktjImQUq6crTlBEOXsFa09QjTbc7FhkLDj9VrrVL/HhsO5loV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA0LjExLjIwMTkgMjE6MDUsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gT24gTW9u
LCA0IE5vdiAyMDE5LCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+ICtzdHJ1Y3QgbWNocF9waXQ2
NGJfY29tbW9uX2RhdGEgew0KPj4gKwl2b2lkIF9faW9tZW0gKmJhc2U7DQo+PiArCXN0cnVjdCBj
bGsgKnBjbGs7DQo+PiArCXN0cnVjdCBjbGsgKmdjbGs7DQo+PiArCXU2NCBjeWNsZXM7DQo+PiAr
CXU4IHByZXM7DQoNClsuLi5dDQoNCj4+ICtzdGF0aWMgaW50IF9faW5pdCBtY2hwX3BpdDY0Yl9w
cmVzX2NvbXB1dGUodTMyICpwcmVzLCB1MzIgY2xrX3JhdGUsDQo+PiArCQkJCQkgICB1MzIgbWF4
X3JhdGUpDQo+PiArew0KPj4gKwl1MzIgdG1wOw0KPj4gKw0KPj4gKwlmb3IgKCpwcmVzID0gMDsg
KnByZXMgPCBNQ0hQX1BJVDY0Ql9QUkVTX01BWDsgKCpwcmVzKSsrKSB7DQo+PiArCQl0bXAgPSBj
bGtfcmF0ZSAvICgqcHJlcyArIDEpOw0KPj4gKwkJaWYgKHRtcCA8PSBtYXhfcmF0ZSkNCj4+ICsJ
CQlicmVhazsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlpZiAoKnByZXMgPT0gTUNIUF9QSVQ2NEJfUFJF
U19NQVgpDQo+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICsNCj4+ICsJcmV0dXJuIDA7DQo+PiAr
fQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgX19pbml0IG1jaHBfcGl0NjRiX3ByZXNfcHJlcGFyZShz
dHJ1Y3QgbWNocF9waXQ2NGJfY29tbW9uX2RhdGEgKmNkLA0KPj4gKwkJCQkJICAgdW5zaWduZWQg
bG9uZyBtYXhfcmF0ZSkNCj4+ICt7DQo+PiArCXVuc2lnbmVkIGxvbmcgcGNsa19yYXRlLCBkaWZm
ID0gMCwgYmVzdF9kaWZmID0gVUxPTkdfTUFYOw0KPj4gKwlsb25nIGdjbGtfcm91bmQgPSAwOw0K
Pj4gKwl1MzIgcHJlcywgYmVzdF9wcmVzID0gMDsNCj4+ICsJaW50IHJldCA9IDA7DQo+PiArDQo+
PiArCXBjbGtfcmF0ZSA9IGNsa19nZXRfcmF0ZShjZC0+cGNsayk7DQo+PiArCWlmICghcGNsa19y
YXRlKQ0KPj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+PiArDQo+PiArCWlmIChjZC0+Z2Nsaykgew0K
Pj4gKwkJZ2Nsa19yb3VuZCA9IGNsa19yb3VuZF9yYXRlKGNkLT5nY2xrLCBtYXhfcmF0ZSk7DQo+
PiArCQlpZiAoZ2Nsa19yb3VuZCA8IDApDQo+PiArCQkJZ290byBwY2xrOw0KPj4gKw0KPj4gKwkJ
aWYgKHBjbGtfcmF0ZSAvIGdjbGtfcm91bmQgPCAzKQ0KPj4gKwkJCWdvdG8gcGNsazsNCj4+ICsN
Cj4+ICsJCXJldCA9IG1jaHBfcGl0NjRiX3ByZXNfY29tcHV0ZSgmcHJlcywgZ2Nsa19yb3VuZCwg
bWF4X3JhdGUpOw0KPj4gKwkJaWYgKHJldCkNCj4+ICsJCQliZXN0X2RpZmYgPSBhYnMoZ2Nsa19y
b3VuZCAtIG1heF9yYXRlKTsNCj4+ICsJCWVsc2UNCj4+ICsJCQliZXN0X2RpZmYgPSBhYnMoZ2Ns
a19yb3VuZCAvIChwcmVzICsgMSkgLSBtYXhfcmF0ZSk7DQo+PiArCQliZXN0X3ByZXMgPSBwcmVz
Ow0KPj4gKwl9DQo+PiArDQo+PiArcGNsazoNCj4+ICsJLyogQ2hlY2sgaWYgcmVxdWVzdGVkIHJh
dGUgY291bGQgYmUgb2J0YWluZWQgdXNpbmcgUENMSy4gKi8NCj4+ICsJcmV0ID0gbWNocF9waXQ2
NGJfcHJlc19jb21wdXRlKCZwcmVzLCBwY2xrX3JhdGUsIG1heF9yYXRlKTsNCj4+ICsJaWYgKHJl
dCkNCj4+ICsJCWRpZmYgPSBhYnMocGNsa19yYXRlIC0gbWF4X3JhdGUpOw0KPj4gKwllbHNlDQo+
PiArCQlkaWZmID0gYWJzKHBjbGtfcmF0ZSAvIChwcmVzICsgMSkgLSBtYXhfcmF0ZSk7DQo+PiAr
DQo+PiArCWlmIChiZXN0X2RpZmYgPiBkaWZmKSB7DQo+PiArCQkvKiBVc2UgUENMSy4gKi8NCj4+
ICsJCWNkLT5nY2xrID0gTlVMTDsNCj4+ICsJCWJlc3RfcHJlcyA9IHByZXM7DQo+PiArCX0gZWxz
ZSB7DQo+PiArCQljbGtfc2V0X3JhdGUoY2QtPmdjbGssIGdjbGtfcm91bmQpOw0KPj4gKwl9DQo+
PiArDQo+PiArCWNkLT5wcmVzID0gYmVzdF9wcmVzOw0KPj4gKw0KPj4gKwlwcl9pbmZvKCJQSVQ2
NEI6IHVzaW5nIGNsaz0lcyB3aXRoIHByZXNjYWxlciAldSwgZnJlcT0lbHUgW0h6XVxuIiwNCj4+
ICsJCWNkLT5nY2xrID8gImdjbGsiIDogInBjbGsiLCBjZC0+cHJlcywNCj4+ICsJCWNkLT5nY2xr
ID8gZ2Nsa19yb3VuZCAvIChjZC0+cHJlcyArIDEpDQo+PiArCQkJIDogcGNsa19yYXRlIC8gKGNk
LT5wcmVzICsgMSkpOw0KPj4gKw0KPj4gKwlyZXR1cm4gMDsNCj4gDQo+IExvdHMgb2YgdW5kb2N1
bWVudGVkIGZ1bmN0aW9uYWxpdHkgd2hpY2ggb3BlbiBjb2RlcyBzdHVmZiB3aGljaCBleGlzdHMN
Cj4gYWxyZWFkeSBpbiB0aGUgY2xrIGZyYW1ld29yayBBRkFJQ1QuDQo+IA0KPiBXaHkgYXJlIHlv
dSBub3Qgc2ltcGx5IGltcGxlbWVudGluZyB0aGlzIGFzIGNsayBmcmFtZXdvcmsgY29tcG9uZW50
cz8NCj4gDQo+IA0KPiAgICAgICAgICAgICB8LS0tLS18DQo+ICAgZ2NsayAtLS0tPnwgICAgIHwg
ICAgfC0tLS0tLS0tLXwNCj4gICAgICAgICAgICAgfCBNVVggfC0tLT58IERpdmlkZXIgfC0+DQo+
ICAgcGNsayAtLS0tPnwgICAgIHwgICAgfC0tLS0tLS0tLXwNCj4gICAgICAgICAgICAgfC0tLS0t
fA0KPiANCj4gd2hpY2ggaXMgZXhheHRseSBob3cgeW91ciBoYXJkd2FyZSBsb29rcyBsaWtlLiBU
aGUgY2xrIGZyYW1ld29yayBoYXMgYWxsDQo+IHRoZSBzZWxlY3Rpb24gbWVjaGFuaXNtcyBpbiBw
bGFjZSBhbmQgYWxsIHRoaXMgY29uZGl0aW9uYWwgY2xvY2sgc3R1ZmYgY2FuDQo+IGJlIHJlbW92
ZWQgYWxsIG92ZXIgdGhlIHBsYWNlIHNpbXBseSBiZWNhdXNlIHlvdSBqdXN0IGFzayBmb3IgdGhl
IGRlc2lyZWQNCj4gZnJlcXVlbmN5IG9uIGluaXQuIEFsc28gc3VzcGVuZC9yZXN1bWUgYW5kIGFs
bCB0aGUgb3RoZXIgc3R1ZmYganVzdCB3b3Jrcw0KPiB3aXRob3V0IGFsbCB0aGUgbWVzcyBpbnZv
bHZlZC4NCj4gDQoNCldpdGggcmVnYXJkcyB0byB0aGlzOiBnY2xrIGFuZCBwY2xrIGFyZSBjbG9j
ayBpbnB1dHMgdG8gUElUNjRCIGhhcmR3YXJlDQpibG9jaywgR0NMSyByYXRlIGNvdWxkIGJlIHJl
cXVlc3RlZCBhbmQgc2V0IGZyb20gY2xvY2sgc3Vic3lzdGVtLCBQQ0xLIHJhdGUNCmlzIGZpeGVk
IGFuZCBjb3VsZCBub3QgYmUgc2V0IHZpYSBjbG9jayBzdWJzeXN0ZW0uDQpQQ0xLIGlzIHRoZSBv
bmUgdGhhdCBpcyBmZWVkaW5nIHRoZSBQSVQ2NEIgaGFyZHdhcmUgYmxvY2suIFRoZSBoYXJkd2Fy
ZQ0KYmxvY2sgd291bGQgbm90IHdvcmsgd2l0aG91dCBpdC4gQXQgdGhlIHNhbWUgdGltZSBpdCBj
b3VsZCBiZSBzZWxlY3RlZCBhcw0KY2xvY2sgc291cmNlIGZvciBQSVQ2NEIncyB0aW1lci4NCkdD
TEsgY291bGQgb25seSBiZSBzZWxlY3RlZCBhcyBjbG9jayBzb3VyY2UgZm9yIFBJVDY0QidzIHRp
bWVyLiBQSVQ2NEINCmhhcmR3YXJlIGJsb2NrIHdpdGggaXRzIHRpbWVyIGZ1bmN0aW9uYWxpdHkg
Y291bGQgd29yayB3aXRoIG9ubHkgUENMSyBidXQNCmNvdWxkIG5vdCB3b3JrIG9ubHkgd2l0aCBH
Q0xLLg0KDQpUaGUgYmxvY2sgZGlhZ3JhbSBpcyBhcyB5b3UgcG9pbnRlZCBpdDoNCg0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFBJVDY0Qg0KUE1DICAgICAgICAgICAgICstLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQotLS0tKyAgICAgICAgICAgfCAgIHwtLS0t
LXwgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCiAgICB8LS0+Z2NsayAtLT58LS0+fCAgICAg
fCAgICB8LS0tLS0tLS0tfCAgKy0tLS0tKyAgfA0KICAgIHwgICAgICAgICAgIHwgICB8IE1VWCB8
LS0tPnwgRGl2aWRlciB8LT58dGltZXJ8ICB8DQogICAgfC0tPnBjbGsgLS0+fC0tPnwgICAgIHwg
ICAgfC0tLS0tLS0tLXwgICstLS0tLSsgIHwNCi0tLS0rICAgICAgICAgICB8ICAgfC0tLS0tfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgfA0KICAgICAgICAgICAgICAgIHwgICAgICBeICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8DQogICAgICAgICAgICAgICAgfCAgICAgc2VsICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwNCiAgICAgICAgICAgICAgICArLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KDQpUaGUgZGl2aWRlciBjb3VsZCBiZSBiL3cgMSBhbmQg
MTYuDQpQZXJpcGhlcmFsIGNsb2NrIHJhdGUsIG9uIHRoZSBwbGF0Zm9ybSB0aGF0IEknbSB1c2lu
ZywgaXMgZml4ZWQgYXQgMjAwTUh6Lg0KSW4gdGhpcyBjYXNlIHRoZSBtaW5pbXVtIGNsb2NrIHJh
dGUgdGhhdCBjb3VsZCBiZSB1c2VkIGZvciBwZXJpcGhlcmFsIGNsb2NrDQppcyAyMDBNSHovMTYg
PSAxMiw1TWh6Lg0KR2VuZXJpYyBjbG9jayByYXRlIHZhcnkgZGVwZW5kaW5nIG9uIGl0cyBjbG9j
ayBzb3VyY2UgYW5kIGRpdmlkZXJzLg0KTG93ZXN0IGNsb2NrIHNvdXJjZSBvZiBnZW5lcmljIGNs
b2NrIGNvdWxkIGJlIDMyS2h6LCBoaWdoZXN0IGNsb2NrIHNvdXJjZQ0KZm9yIGdlbmVyaWMgY2xv
Y2sgY291bGQgYmUgNjAwTWh6IChvbiB0aGUgcGxhdGZvcm0gdGhhdCBJJ20gdXNpbmcpLg0KDQpJ
bXBsZW1lbnRpbmcgYSBjbG9jayBkcml2ZXIgZm9yIHRoaXMgYXMgeW91IHBvaW50ZWQgaXQgd291
bGQgaW52b2x2ZQ0KYnJlYWtpbmcgdGhlIHRpbWVyJ3MgZHJpdmVyIGluIDIgcGFydHM6IG9uZQ0K
cmVsYXRlZCB0byBjbG9jayBzZWxlY3Rpb24sIG9uZSByZWxhdGVkIHRvIHRpbWVyJ3MgZnVuY3Rp
b25hbGl0aWVzLg0KDQpTaW5jZSwgSSdtIHRoaW5raW5nLCB0aGUgcmlnaHQgcGxhY2UgdG8gcHV0
IHRoaXMgZHJpdmVyIGlzIGF0OTEgY2xvY2sgdHJlZQ0KKGRyaXZlcnMvY2xrL2F0OTEvKSBJIHNo
b3VsZCB0YWtlIGEgc3lzY29uIHRvIFBJVDY0QiBpbiB0aGVyZSBzbyB0aGF0IHRvIGJlDQphYmxl
IHRvIHNldCB0aGUgcHJvcGVyIFBJVDY0QidzIGJpdHMgZm9yIE1VWCBzZWxlY3Rpb24gYW5kIGRp
dmlkZXIuDQpCcmVha2luZyB0aGlzIGluIG11bHRpcGxlIGJsb2NrcyB3aWxsIGNvbXBsaWNhdGUg
YSBiaXQgdGhlIHRoaW5ncyAoZS5nLiBJDQp3b3VsZCBuZWVkIHRvIHNlbGVjdCAyIGNvbmZpZyBm
bGFncyBmb3IgUElUNjRCIGJsb2NrKS4NCg0KSW4gdGhlIERUIGJpbmRpbmdzIEkgc2hvdWxkIGFu
eXdheSBuZWVkIHRvIGhhdmUgYSBwaGFuZGxlIHRvIHRoZSBwZXJpcGhlcmFsDQpjbG9jayBhbmQg
b25lIHJlbGF0ZWQgdG8gdGhlIE1VWC4NCg0KcG1jOiBwbWNAZmZmZmZjMDAgew0KCWNvbXBhdGli
bGUgPSAibWljcm9jaGlwLHNhbTl4NjAtcG1jIiwgInN5c2NvbiI7DQoJcmVnID0gPDB4ZmZmZmZj
MDAgMHgyMDA+Ow0KCWludGVycnVwdHMgPSA8MSBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+Ow0KCSNj
bG9jay1jZWxscyA9IDwyPjsNCgljbG9ja3MgPSA8JmNsazMyayAxPiwgPCZjbGszMmsgMD4sIDwm
bWFpbl94dGFsPjsNCgljbG9jay1uYW1lcyA9ICJ0ZF9zbGNrIiwgIm1kX3NsY2siLCAibWFpbl94
dGFsIjsNCn07DQoNCnBpdDY0YjogdGltZXJAZjAwMjgwMDAgew0KCWNvbXBhdGlibGUgPSAibWlj
cm9jaGlwLHNhbTl4NjAtcGl0NjRiIjsNCglyZWcgPSA8MHhmMDAyODAwMCAweDEwMD47DQoJaW50
ZXJydXB0cyA9IDwzNyBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+Ow0KCWNsb2NrcyA9IDwmcG1jIFBN
Q19UWVBFX1BFUklQSEVSQUwgMzc+LCA8JnBtYyBQTUNfVFlQRV9NVVg+Ow0KCWNsb2NrLW5hbWVz
ID0gInBjbGsiLCAibXV4IjsNCn07DQoNCk9uZSBhc3BlY3QgaGVyZSBpcyB0aGF0IFBDTEsgc2hv
dWxkIGJlIGVuYWJsZWQgYWxsIHRoZSB0aW1lIGFuZCB0aGUgbXV4DQpzaG91bGQgb25seSBzZWxl
Y3QgYi93IFBDTEsgYW5kIEdDTEsuIEFuZCB0aGUgbXV4IGlzIG5vdCBhY3R1YWxseSBwYXJ0IG9m
DQp0aGUgUE1DLg0KDQpPbmUgb3RoZXIgc2ltcGxlciB0aGluZyB0aGF0IEkgY2FuIGRvIGlzIHRv
IGFzc2lnbiBHQ0xLIHJhdGUgZGlyZWN0bHkgZnJvbQ0KZGV2aWNlIHRyZWUgd2l0aCAiYXNzaWdu
ZWQtY2xvY2stcmF0ZXMiIHByb3BlcnR5IGFuZCBnbyBhbGwgdGhlIHRpbWUNCmRpcmVjdGx5IHdp
dGggR0NMSyAoYXNzdW1pbmcgUENMSyByYXRlL0dDTEsgcmF0ZSByYXRpbyBpcyBhbGwgdGhlIHRp
bWUgdGhlDQpnb29kIG9uZSAoaXQgc2hvdWxkIGJlIGF0IGxlYXN0IDMgZm9yIHRoaXMgSVApKSBh
bmQgaW4gdGhpcyBkcml2ZXIgdG8NCnNlbGVjdCBhbGwgdGhlIHRpbWUgdGhlIEdDTEsgY2xvY2su
DQoNClRoYW5rIHlvdSwNCkNsYXVkaXUgQmV6bmVhDQoNCg0KWy4uLl0NCg0KPiANCj4gU28gdGhl
IGZpcnN0IGludm9jYXRpb24gb2YgdGhpcyBpbml0IGZ1bmN0aW9uIGlzIHN1cHBvc2VkIHRvIGlu
aXQgdGhlIGNsb2NrDQo+IGV2ZW50IGRldmljZSBhbmQgdGhlIHNlY29uZCBvbmUgaW5pdHMgdGhl
IGNsb2NrIHNvdXJjZS4gQW5kIGJvdGggYWxsb2NhdGUNCj4gY29tbW9uIGRhdGEuIEhvdyBpcyB0
aGF0IGNvbW1vbj8NCj4gDQo+IFRoYW5rcywNCj4gDQo+IAl0Z2x4DQo+IA0KPiANCg==
