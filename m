Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457BBC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A1021721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kcMgkEtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfJIMRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:17:13 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:49445 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729699AbfJIMRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:17:13 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: /B5xqw6ZRQcqDUyWhFaZzCpb/nzlC/t9uvmou9GcM0ptDO2eolTBE1Lpcurh3IwwVONzy5268I
 fHn9TRYbuDnvuO8qmsAu0jzaZgQeCx7r7N4fEY2cn0jlNh3jOh0Kf2OUhPHmdieyL5j8RsS4fr
 8iPLiWAuFBZN4KiKBf0SKRESeFPKD3ua+rI8LWsmn1ix/hzgfDkFc7NsQJVxkF/e6c5ViNlGHe
 6ldlZ2HVKqQaalEYlZhS5oj93DELa/Zw1NWCDfx9wVIW4sZpF6tTBiRPmNlXsoYVHyGMXWQOxx
 XYI=
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; 
   d="scan'208";a="49383324"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Oct 2019 05:17:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 9 Oct 2019 05:17:11 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 9 Oct 2019 05:17:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gN8Qx07bSxLiQExq2y+lpinXtrKVQaRSNZn3KI+CscwQKe4CGAxzVRFv0KF9slFuYIeD++117djpaxeY5B7KvKfYcZIVQ5gpptUTc1gE8W28hh9mvE9XPCgFG7zLNCMvPRcgiZdenhqg8XQHTRavHezUhtB+p5H/NynkLgNb2DFaNdBGzKOpTXofB5YJq5vfPEs2MyPVbma75K+yxeNQfxirBuH+py36E3GC7Tu+QFrvNcqxyJ6GUGnCTZwLl8Dkx+HXNcQA259dJRrZ4i+PCK2fZUDXEafP09xGK3b6ovA9cRC882JFWXP7ptTXaMI2qTFoD+M86XdlfTJ1m+tvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7OdLL4pPgL/gbwOhX2Ssl78A7o/CmMB22o9vA2mRmQ=;
 b=fAwmigcGTgHiQwEXIsCZc+yy8pAqZZe9w1p2OHYMBFfYcykmNR+k9AKGgRAerqPqGaeQIkla8BCXXUbrkcmfbCfpKWxXIsyvwMUFSn9qjlORbO1lyxYqSz/KSrX5yK9hrgRAr1cyg02kQBP2/CNG4YDvFnCQ7p0uWYuNJYcAQepY23f+ksufeI+ecnCqt1N3B0eF4sI1m655ZxhMOyOelCiyOXoqdCeIeVp4XGGtRYuvSK/noF7yZh/AEHmH1xNpeImoHSs2Z9G5/00YY2V0fYwo24oBeCbdwjQuMgKe6f3JcSaLm6+HU+xtY1Zisk59MJ6kKeiTHRVMs2OzsVe09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7OdLL4pPgL/gbwOhX2Ssl78A7o/CmMB22o9vA2mRmQ=;
 b=kcMgkEtwEcbLTmBwHD1+nSpFI4bwNC/FQjdAzpaZaBT+Y9uxVoRIhz/1BztrRId8ndZjnoHkcE3jozp2/33dA81W5B4O6STUNklR0yanNmjbws2F3FafHJEOlIuuL1bDdIGSaYaFVue3c6iEzeCogbsUi+W0G2P04v5wtTM+g+0=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.85) by
 DM6PR11MB4009.namprd11.prod.outlook.com (20.176.125.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 12:17:10 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::3874:9f3c:5325:d22]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::3874:9f3c:5325:d22%6]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 12:17:10 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: at91: add compatible for sam9x60
Thread-Topic: [PATCH] clk: at91: add compatible for sam9x60
Thread-Index: AQHVfpt5ONriexrfSEW8pLtSnh8Lvw==
Date:   Wed, 9 Oct 2019 12:17:10 +0000
Message-ID: <f8fabb4e-81be-6219-ec5c-8d236a8959e7@microchip.com>
References: <1570553186-24691-1-git-send-email-claudiu.beznea@microchip.com>
 <20191008165449.GA4254@piout.net>
In-Reply-To: <20191008165449.GA4254@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR10CA0095.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::24) To DM6PR11MB3225.namprd11.prod.outlook.com
 (2603:10b6:5:59::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191009151701835
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3704880f-b05d-4449-e5a4-08d74cb29c21
x-ms-traffictypediagnostic: DM6PR11MB4009:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4009EC22E7F8EFBA7819E85287950@DM6PR11MB4009.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(136003)(346002)(396003)(189003)(199004)(14454004)(31696002)(66946007)(478600001)(66446008)(256004)(66476007)(66556008)(64756008)(186003)(446003)(26005)(2616005)(229853002)(6116002)(8936002)(81166006)(71190400001)(8676002)(36756003)(86362001)(71200400001)(81156014)(486006)(476003)(11346002)(3846002)(76176011)(6916009)(4326008)(7736002)(53546011)(102836004)(52116002)(25786009)(99286004)(6486002)(66066001)(386003)(6506007)(6436002)(2906002)(5660300002)(31686004)(6246003)(6512007)(316002)(305945005)(54906003)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB4009;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uA/4uGRXWV6NZN2fs6kfCNbuFVv5z+VE94NqHTnelTth+KN7iLX9u6qH69SinuvAeQ/DW48D7dCxhcpoPovVLzwjJ26D2ULXeDl8eOrRX6oHCK3BxXtY20m97J2Pxk7/zPNrSKHqZn1XCPjN0jjW5u0NlCjwim8nAjkgWW5IpGIg+HHsUfmO/3/Qkwuxql6rJTkmKzNifxCEjGAKPqy7uzhocj2+QizXtWBzZUZZMTy1ZYqKbuqJUa77Os9o9GmHYhwP8JOAxVp0mai5vBmaUpadTxQgmaBv1zMSiEfY+8kHG8fA8kX7Jq/ZYmyu8GSV1tzET6LPmqgtwhjOu8vZycr4TjwS7khZjV6QGEr13m4m6Z5wMx1zlHjPeG0XOuboA/RNOHOf4UykSrFaldCtxUmgt50lIQ9YseUSYy2W7CM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F43B7904A770BC4689100B45F00F892D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3704880f-b05d-4449-e5a4-08d74cb29c21
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 12:17:10.6190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: teh3WiyfYkXOsTdCrMG/fpXyyDdNgFUkX4O5iw84w+NKUZyyzC6y7X8cLtdRdEvXLHtGsfaiPUOc7Mla2va5Y+KS9hU4LD0KA8H+zurG590=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDA4LjEwLjIwMTkgMTk6NTQsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBI
aSwNCj4gDQo+IE9uIDA4LzEwLzIwMTkgMTk6NDY6MjYrMDMwMCwgQ2xhdWRpdSBCZXpuZWEgd3Jv
dGU6DQo+PiBBZGQgY29tcGF0aWJsZSBmb3IgU0FNOVg2MCdzIFBNQy4NCj4gDQo+IEkgdGhpbmsg
dGhlIGNvbW1pdCBsb2cgY291bGQgYmUgY2xlYXJlciBhbmQgbWVudGlvbiB3aHkgdGhpcyBpcyBu
ZWVkZWQNCj4gYW5kIHRoZSBjb21wYXRpYmxlIHN0cmluZyBpbiBzYW05eDYwIGlzIG5vdCBzdWZm
aWNpZW50Lg0KDQpJIGhhZCBpc3N1ZXMgd2l0aCB3YWtpbmcgdXAgZnJvbSBVTFAxIHdpdGhvdXQg
ZXZlbiBoYXZpbmcgY29uZmlndXJpbmcNCndha2V1cCBzb3VyY2VzLg0KDQpCdXQsIGludmVzdGln
YXRpbmcgbW9yZSBJIGRpc2NvdmVyZWQgdGhhdCB0aGlzIHBhdGNoIGJyZWFrcyBvdGhlciB0aGlu
Z3MNCnNvIHBsZWFzZSBpZ25vcmUgaXQuDQoNClNvcnJ5IGZvciB0aGUgbm9pc2UsDQpDbGF1ZGl1
IEJlem5lYQ0KDQo+IA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1
ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9jbGsvYXQ5MS9w
bWMuYyB8IDEgKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9hdDkxL3BtYy5jIGIvZHJpdmVycy9jbGsvYXQ5MS9wbWMu
Yw0KPj4gaW5kZXggZGIyNDUzOWQ1NzQwLi4yNDk3NWJjYTYwOGUgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL2Nsay9hdDkxL3BtYy5jDQo+PiArKysgYi9kcml2ZXJzL2Nsay9hdDkxL3BtYy5jDQo+
PiBAQCAtMjcxLDYgKzI3MSw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc3lzY29yZV9vcHMgcG1jX3N5c2Nv
cmVfb3BzID0gew0KPj4gIA0KPj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHNh
bWE1ZDJfcG1jX2R0X2lkc1tdID0gew0KPiANCj4gTWF5YmUgcmVuYW1lIHRoZSBhcnJheT8NCj4g
DQo+PiAgCXsgLmNvbXBhdGlibGUgPSAiYXRtZWwsc2FtYTVkMi1wbWMiIH0sDQo+PiArCXsgLmNv
bXBhdGlibGUgPSAibWljcm9jaGlwLHNhbTl4NjAtcG1jIiB9LA0KPj4gIAl7IC8qIHNlbnRpbmVs
ICovIH0NCj4+ICB9Ow0KPj4gIA0KPj4gLS0gDQo+PiAyLjcuNA0KPj4NCj4gDQo=
