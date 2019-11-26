Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CE2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DB82073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FKICzkjM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qXRShpDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfKZTRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:17:04 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12038 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfKZTRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574795824; x=1606331824;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZT54o0O69RlBIcwiRDe5EUvaAiHKkrPNJTryzaKu+2o=;
  b=FKICzkjMMKmfil+cjLsF2Cj+jd3dfM37hPGYJVKpjvvrNwg/x06nBW+m
   5ytRIMq7eQL540v1qPq7jJEdyI4yQGpvLWS15W9Z4FTjSiZJeHIzUEQKc
   le+E4sHBDNmZyjL8OAsH7E3l8FIy43XzTxHuMqgrtr1tKxu1v0URqNaL5
   K98iyqiEwWj3fe8AupyTtsovWqvKhmmPRKJFsjIlJRMtrpT72VPaxfOGo
   LYuRr9zb/cQ23V5YVwypX4HD5qBgc2JJkNdJs19Ba4OoXsHf8blWik7iQ
   1supp2mG4rHNpIstmJHmRZP5BUTUvkLZU7UbUHvsZb8wPmku5FgqqrW4R
   A==;
IronPort-SDR: j9lMlvCJbAoGHNx5q9H2IwiQKK1cLs4dyNALnAkK3UifRFkgAJNMkNBdAJDNupuNK8yMFDQRiD
 Z/xucKbOMeNlb1R2KXG6/w0b+VWqKKlRua8RBMahMCYyKz1uLqMxBYtC/Sq+Jv/E/MkbeUXivv
 v4HSjwNfPa8lyejkKMI9yczVhXnvtzTA5rwxR5WieKuR02VzAXBv/26JvoVeO37tKTVxjuE5tc
 mK8gwFjcGWSsj7YTjnkhgYA3r1UW0T2AvsGT7Im50+hSLQ/bx2Scu0Bem+O212oQ/D7MrBlJ5k
 rIQ=
X-IronPort-AV: E=Sophos;i="5.69,246,1571673600"; 
   d="scan'208";a="124822636"
Received: from mail-sn1nam01lp2052.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.52])
  by ob1.hgst.iphmx.com with ESMTP; 27 Nov 2019 03:17:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3GdZAaO2zcAE3mzPlRwmvsx2AuSeDSRea2wa3EbBlrQm5tGipQ0GX/dSnw3JhxjTHZwxu80rQ2Z2FUyjkiwR1B17P08Y8uAF+OyRLaPoe6Fkc2UMTET9Ud2mKLQsTwceQrH2Hln+X3WyPxI42Pc/AwHVBlDwttXO4qSX1t/t+ZF2JOKU7uSRDnbq7c0qPdZDPGuLqThhGUXdE+udUJtoQyAKwY1X0BxJ059yG6MeVsyJFMUnNQr4M5LXjQB5Tu+3v/lg0vOGlPiOuti3Nu0L5kr6ZhpMFWmrjCfuPcbCDMNAyVtJyKBN4FNTr5jEP/N+j8XE7jNUm3o7gRYH0B68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT54o0O69RlBIcwiRDe5EUvaAiHKkrPNJTryzaKu+2o=;
 b=KcxfKFVXfsSYDcje/VSlJdaLRYI9RNKrbvdDe+BAsFOmRitMudcTpacSZ2Sh1JRjNwWwJFNx32vcGSA1SM1lXD/VWitbEAxZINmjiRfPbWJKPXXaGKgHIybIaIiN0DTeXma3qn3RMU+pGad/b7FGhz1F6C/dwhvYNqK99wCwl3/LrS5s1zqLuqsg3ttDcsrNKR5YtsHrFCkI+4fR+ARo2IXMHlu9U4BuLtoVw7Bk7TKzAqVzhv/iPcBCbi7McwAMvITBkole0kB2tzR6Q6LATUAeBKpn4HcAiqE8zoj1oSezXuPBD6RO9lAhTBeNIrZ1PHV8dIP68hmdPHQrmVa/9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT54o0O69RlBIcwiRDe5EUvaAiHKkrPNJTryzaKu+2o=;
 b=qXRShpDnNxelAI6TED479VhUj3Btj3qzUaALDHYhLMirKk9z/QSiUsDZS9vMalATXP1a7KQap7XgO/Kt5PmBCztgvl47eG3kGiR5fjT+Uq53hiRKBtfQLmBggZhv5Yp95jq5Uqva9ipDsSoMoa4OSqvtZVcpWASwOQ1WeDM8Xvc=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB4696.namprd04.prod.outlook.com (52.135.239.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 19:17:01 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::1d22:29b6:df03:86f7]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::1d22:29b6:df03:86f7%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 19:17:01 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        Anup Patel <Anup.Patel@wdc.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] RISC-V: Select Goldfish RTC driver for QEMU virt
 machine
Thread-Topic: [PATCH 4/4] RISC-V: Select Goldfish RTC driver for QEMU virt
 machine
Thread-Index: AQHVo5NpbLpAkxeNREm+uBNHRoP7x6ed1QAA
Date:   Tue, 26 Nov 2019 19:17:01 +0000
Message-ID: <0614a2c6d04549da5a17f885ec70d4f2d2c4bcca.camel@wdc.com>
References: <20191125132147.97111-1-anup.patel@wdc.com>
         <20191125132147.97111-5-anup.patel@wdc.com>
In-Reply-To: <20191125132147.97111-5-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [2601:646:8280:fdf0:69be:1cca:a557:65ea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6ac0209-ef72-4746-0e2f-08d772a5372b
x-ms-traffictypediagnostic: BYAPR04MB4696:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4696EA2F6E30E023CF46B96BFA450@BYAPR04MB4696.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(199004)(189003)(446003)(86362001)(6116002)(2616005)(71200400001)(71190400001)(6512007)(11346002)(118296001)(46003)(36756003)(7736002)(6246003)(14454004)(4001150100001)(4326008)(2501003)(6636002)(14444005)(25786009)(256004)(76116006)(102836004)(305945005)(8936002)(81156014)(2906002)(66946007)(81166006)(5660300002)(316002)(186003)(99286004)(76176011)(110136005)(6506007)(54906003)(66556008)(478600001)(229853002)(6486002)(66446008)(64756008)(66476007)(8676002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4696;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zcpX01mA8EQHyGz98mqKeoeI4tmzWxUuIZDwbwiaCjhjyDU/xWsrHsuCWblBrtQhg50LE+fKi8kkZiACuUA7KnWRL5rUaLkmkVwVENFqmePGfzFc9xXKABSlNC4hgkAt9Q/luTcCTy15VihiyXRj8gJn8r8nKTvkK8IIo4hDWc6oN3sxlexhzqdp0GfE4uAQplAHGqpXZyhW4mNIDKb1wgPZS2A4L8DaRvRa3Db5HsMiPuBt3Jz3266QZZ6HT7nbGv/D8YlolgpYBUVyyFTQT38ScECAVWyrxz3h553+LAvJ2ie97A0OUj8VLDZiqxco48m/lRg//nVB2PMdG5JAcrlbOMqsgA3Ax+aEscYjc0QXhp4/IpNL+AJLMiL1EhwGmzcRFGni/GE4XBXJ/0eWkUkvYmzu8SNB1RPLiiJFUqc3F/IWQ+oyr79qcqavWDTq
Content-Type: text/plain; charset="utf-8"
Content-ID: <729417D03F4094458C7FE92D16C8A990@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ac0209-ef72-4746-0e2f-08d772a5372b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 19:17:01.5084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GqVxWgW8yyk+gnyUYpiH0jURKEQO9Fig0iSuNmnPwLRsA2hnqOn8dQfbzXnWT6AOunUh7u/5GwTgXXtxywJX3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTExLTI1IGF0IDEzOjIyICswMDAwLCBBbnVwIFBhdGVsIHdyb3RlOg0KPiBX
ZSBzZWxlY3QgR29sZGZpc2ggUlRDIGRyaXZlciB1c2luZyBRRU1VIHZpcnQgbWFjaGluZSBrY29u
ZmlnIG9wdGlvbg0KPiB0byBhY2Nlc3MgUlRDIGRldmljZSBvbiBRRU1VIHZpcnQgbWFjaGluZS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFudXAgUGF0ZWwgPGFudXAucGF0ZWxAd2RjLmNvbT4NCj4g
LS0tDQo+ICBhcmNoL3Jpc2N2L0tjb25maWcuc29jcyAgICAgICAgICAgfCAyICsrDQo+ICBhcmNo
L3Jpc2N2L2NvbmZpZ3MvZGVmY29uZmlnICAgICAgfCAxICsNCj4gIGFyY2gvcmlzY3YvY29uZmln
cy9ydjMyX2RlZmNvbmZpZyB8IDEgKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L0tjb25maWcuc29jcyBiL2FyY2gvcmlz
Y3YvS2NvbmZpZy5zb2NzDQo+IGluZGV4IGJhZTQ5MDdiNDg4MC4uNjVjZjM5ODY3YzYwIDEwMDY0
NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L0tjb25maWcuc29jcw0KPiArKysgYi9hcmNoL3Jpc2N2L0tj
b25maWcuc29jcw0KPiBAQCAtMjgsNiArMjgsOCBAQCBjb25maWcgU09DX1ZJUlQNCj4gICAgICAg
ICBzZWxlY3QgVklSVElPX0lOUFVUDQo+ICAgICAgICAgc2VsZWN0IFBPV0VSX1JFU0VUX1NZU0NP
Tg0KPiAgICAgICAgIHNlbGVjdCBQT1dFUl9SRVNFVF9TWVNDT05fUE9XRVJPRkYNCj4gKyAgICAg
ICBzZWxlY3QgR09MREZJU0gNCj4gKyAgICAgICBzZWxlY3QgUlRDX0RSVl9HT0xERklTSA0KPiAg
ICAgICAgIHNlbGVjdCBTSUZJVkVfUExJQw0KPiAgICAgICAgIGhlbHANCj4gICAgICAgICAgIFRo
aXMgZW5hYmxlcyBzdXBwb3J0IGZvciBRRU1VIFZpcnQgTWFjaGluZS4NCj4gZGlmZiAtLWdpdCBh
L2FyY2gvcmlzY3YvY29uZmlncy9kZWZjb25maWcNCj4gYi9hcmNoL3Jpc2N2L2NvbmZpZ3MvZGVm
Y29uZmlnDQo+IGluZGV4IGJmMzNiZDQwZWUwNy4uYzVlMDQzODRlYzNkIDEwMDY0NA0KPiAtLS0g
YS9hcmNoL3Jpc2N2L2NvbmZpZ3MvZGVmY29uZmlnDQo+ICsrKyBiL2FyY2gvcmlzY3YvY29uZmln
cy9kZWZjb25maWcNCj4gQEAgLTczLDYgKzczLDcgQEAgQ09ORklHX1VTQl9TVE9SQUdFPXkNCj4g
IENPTkZJR19VU0JfVUFTPXkNCj4gIENPTkZJR19NTUM9eQ0KPiAgQ09ORklHX01NQ19TUEk9eQ0K
PiArQ09ORklHX1JUQ19DTEFTUz15DQo+ICBDT05GSUdfRVhUNF9GUz15DQo+ICBDT05GSUdfRVhU
NF9GU19QT1NJWF9BQ0w9eQ0KPiAgQ09ORklHX0FVVE9GUzRfRlM9eQ0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9yaXNjdi9jb25maWdzL3J2MzJfZGVmY29uZmlnDQo+IGIvYXJjaC9yaXNjdi9jb25maWdz
L3J2MzJfZGVmY29uZmlnDQo+IGluZGV4IDIzNDIxM2I0ZWE3NC4uNzk3MmIxZDMyMWMxIDEwMDY0
NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2NvbmZpZ3MvcnYzMl9kZWZjb25maWcNCj4gKysrIGIvYXJj
aC9yaXNjdi9jb25maWdzL3J2MzJfZGVmY29uZmlnDQo+IEBAIC02OSw2ICs2OSw3IEBAIENPTkZJ
R19VU0JfT0hDSV9IQ0Q9eQ0KPiAgQ09ORklHX1VTQl9PSENJX0hDRF9QTEFURk9STT15DQo+ICBD
T05GSUdfVVNCX1NUT1JBR0U9eQ0KPiAgQ09ORklHX1VTQl9VQVM9eQ0KPiArQ09ORklHX1JUQ19D
TEFTUz15DQo+ICBDT05GSUdfRVhUNF9GUz15DQo+ICBDT05GSUdfRVhUNF9GU19QT1NJWF9BQ0w9
eQ0KPiAgQ09ORklHX0FVVE9GUzRfRlM9eQ0KDQpGaXhlZCBwYWxtZXIncyBlbWFpbCBhZGRyZXNz
Lg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQXRpc2ggUGF0cmEgPGF0aXNoLnBhdHJh
QHdkYy5jb20+DQoNCi0tIA0KUmVnYXJkcywNCkF0aXNoDQo=
