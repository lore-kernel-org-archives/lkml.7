Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CBDC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79962217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W82Cjtih";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SMlpLWY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbfHJF2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 01:28:30 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46226 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHJF2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 01:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565414909; x=1596950909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H19BYJBzil3oeX1+pm23kiDggcnBMJ9IuC2OKYG2Z0A=;
  b=W82CjtihrYI+Pl9RbwOd3sHYPIdVlJ/6XV6ZWpQ3cskbeOTA6WgZPST4
   fv6bIeEZ6NdnGDyIpDd5MvngMjlhuZ4+fNJLMmFfT3p7KZXDFHrx6NNGa
   wiJaEWi0sHXBbz3TMc9bKvYaG1i7Ox9WxQCVGmPXZ5iVqJReTtFoNqxCp
   6SSOhiEaETN12RlokONeiBtL3VYhAhOatAZvSVCsJBPl2U/P1xzEmV2+g
   iblex1nillGJdBrTh7zh0dcAT1Gy5+MKX3LQZJnEMPUBDr/VCWdUopnqs
   bGD9pIKIuHwG7bci5TIBldYImmeerPDFCZpgcnmB8eJ+YGQBUzCw1EW22
   Q==;
IronPort-SDR: LZlKgU2MpUJZn0JWMZuKOkslsR9tqGg/ZEWiSK5ee+qBUUZUk+QDQwoH+O/VRoziau/jCaD+fP
 Dro8yMdZ9AKKodGWzwB8hwhjLPdI9OjMll2W57gOgU44brLbsqcecyiaNFP/4JXsNBw7aVWBLy
 tWstyzAKqoeTeiwI5qBIwkxbUY0hw5hA1yyGtAcNxyG+it8ITgr6Tj/V1XyA0Zp1zMddDRU+nJ
 29pDsX1O25PZI3/gwJM8fVb60dStfTNtUzSBbr8m3fpcHHDJQ1oKY5sUkxNd5MiSGyMQgl2xvL
 qXM=
X-IronPort-AV: E=Sophos;i="5.64,368,1559491200"; 
   d="scan'208";a="116482323"
Received: from mail-dm3nam05lp2051.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.51])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2019 13:28:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7JSRgfqywNdffVpr1i8180KYzhWUEbCVJ8vprmJKB0v6TydkfIoiqKUi0Ac9AHIzKIYhbJcgRbErPtR6NBF7xv/40CqqUgKmPc0nwJBcKq3pC2puxjHdOZKRWRy8Y+G68aoGoluqKzX3sv4sbLj/7EYusX1G/13jSDsUf+PN+GIv7xie6LPIsJh5V88v0UE4ySgjdxhbVPiI1Vq5PWzW6F40fnS5bzXoWNbQ2Dsa8tUmZT7Wd0wSB/Xt1epugaxNOuQj6tVDeTSf2IY93s/IkN4Ldjsbqa/gUPSQM+8iWJaDthyou8UsFyhFoWuPmjERp2YnsrC2qWxC99qVwOcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H19BYJBzil3oeX1+pm23kiDggcnBMJ9IuC2OKYG2Z0A=;
 b=iWiIMch+rVcVqmgXisZkjYEYvkqFNn1OY3Rgl7plZJMN1S14acTDKLSEl50To7XesdHAo99XekcxyGn5wSClcmV3CGf2IhogiergpMipn8i/QKbeuOUUlRCFzehzH0BPTLu0LQolzBZ04GxHiZ+KDuIjlLzmPzDJA6RZITeV0urar3Bvvtmv3YsQpB+5+JdyzGRpjSAmVNN4r/QoAgArzOqiClmNSdFfNFMSESAvEIRjlnLGwgPpm46L98NeRfQjHhFmWzJKP/po7ZgLqM9f1gutn8x/s7s73C8AfvU/RJ3CRn4kfmUBxZTUt6wn62VQRAAWdWZoqHGh3x2hdUZLWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H19BYJBzil3oeX1+pm23kiDggcnBMJ9IuC2OKYG2Z0A=;
 b=SMlpLWY3abb3LAqk1yfjbgiZY/tZojVBGKNoCiNgQMV1bmwoC4rAqeVkI8xLxX0vShHWzcB1nk1rwhOh8aIbIJkXuDvox6q8YvgrQkwwdToCHrTg7PP+U69PDm0o/sw1E1Cp7ytC+Gw9sEOpAs5MRYz/aczhPg6zwCsSblA+/xQ=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB5637.namprd04.prod.outlook.com (20.179.56.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Sat, 10 Aug 2019 05:28:26 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926%7]) with mapi id 15.20.2115.005; Sat, 10 Aug 2019
 05:28:26 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     Anup Patel <anup@brainfault.org>
CC:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH] RISC-V: Issue a local tlb flush if possible.
Thread-Topic: [PATCH] RISC-V: Issue a local tlb flush if possible.
Thread-Index: AQHVTxz5XkoGRRVrekixM0/zCIcSeKbzubCA//+rmIA=
Date:   Sat, 10 Aug 2019 05:28:26 +0000
Message-ID: <E22786A6-CEB2-458D-8063-132C12A9B129@wdc.com>
References: <20190810014309.20838-1-atish.patra@wdc.com>
 <CAAhSdy1bnBoOdYJHm97JyG5oiY6PuLqamedx4BnfbrhVvmv6Xw@mail.gmail.com>
In-Reply-To: <CAAhSdy1bnBoOdYJHm97JyG5oiY6PuLqamedx4BnfbrhVvmv6Xw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [2601:646:8280:fdf0:e052:7623:d31b:9c5c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdaf782e-1d1e-4ae3-964c-08d71d539205
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5637;
x-ms-traffictypediagnostic: BYAPR04MB5637:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB5637166BA69A82FA1E184B70FAD10@BYAPR04MB5637.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 012570D5A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(189003)(199004)(6506007)(7736002)(6486002)(966005)(305945005)(71200400001)(76176011)(229853002)(8936002)(102836004)(53546011)(66446008)(64756008)(256004)(2906002)(66476007)(11346002)(2616005)(6916009)(446003)(54906003)(316002)(14454004)(76116006)(478600001)(66556008)(71190400001)(6306002)(36756003)(6436002)(81156014)(53936002)(476003)(66946007)(46003)(8676002)(99286004)(6116002)(486006)(186003)(6246003)(6512007)(4326008)(5660300002)(33656002)(25786009)(81166006)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5637;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wY6uMWTdtnCs7wHLp07M0Fin13CNlTDdHTzyQsNhRAu7qsWk7354rb5fGv9E8SOtjz0toBP5+pNinc1z9q92DefitBo1ZYxp05fkAR3onKpQXeXT8wQoJI1yuM1oINLMeVp2Pib2ePqa/1jOiU6Qslw6NmKEn/Azu6u3GJw1HNc2N9aTIaWu2Xb/KjMF2OUd7ZJ3NNBGtSzOyHItFSnAUrzhghKCaXheiJhQpLbvTin1WOFL7aTSbpNgSfGRyyqfXfHOxmUtwcnjnFK7mOpoqh/qzFzzK78NLSBEJzQOjDJAjlepKQDlNtMn1qH+L334T2cyGHzcGevTdfc1PBBplphNwsaQq5A9x6tM9AbWvQXCIjFyVMa9VNT4YhdmXjqIGDXObckp5WZjG816xT6AqjsBPANwYJ7xHDOR8UnpElc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9601567EC384A94A88C670EC065004FA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdaf782e-1d1e-4ae3-964c-08d71d539205
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2019 05:28:26.3376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5637
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDgvOS8xOSwgODozMCBQTSwgIkFudXAgUGF0ZWwiIDxhbnVwQGJyYWluZmF1bHQu
b3JnPiB3cm90ZToNCg0KICAgIE9uIFNhdCwgQXVnIDEwLCAyMDE5IGF0IDc6MTMgQU0gQXRpc2gg
UGF0cmEgPGF0aXNoLnBhdHJhQHdkYy5jb20+IHdyb3RlOg0KICAgID4NCiAgICA+IEluIFJJU0Mt
ViwgdGxiIGZsdXNoIGhhcHBlbnMgdmlhIFNCSSB3aGljaCBpcyBleHBlbnNpdmUuDQogICAgPiBJ
ZiB0aGUgdGFyZ2V0IGNwdW1hc2sgY29udGFpbnMgYSBsb2NhbCBoYXJ0aWQsIHNvbWUgY29zdA0K
ICAgID4gY2FuIGJlIHNhdmVkIGJ5IGlzc3VpbmcgYSBsb2NhbCB0bGIgZmx1c2ggYXMgd2UgZG8g
dGhhdA0KICAgID4gaW4gT3BlblNCSSBhbnl3YXlzLg0KICAgID4NCiAgICA+IFNpZ25lZC1vZmYt
Ynk6IEF0aXNoIFBhdHJhIDxhdGlzaC5wYXRyYUB3ZGMuY29tPg0KICAgID4gLS0tDQogICAgPiAg
YXJjaC9yaXNjdi9pbmNsdWRlL2FzbS90bGJmbHVzaC5oIHwgMzMgKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLQ0KICAgID4gIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KICAgID4NCiAgICA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2luY2x1
ZGUvYXNtL3RsYmZsdXNoLmggYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3RsYmZsdXNoLmgNCiAg
ICA+IGluZGV4IDY4N2RkMTk3MzVhNy4uYjMyYmE0ZmE1ODg4IDEwMDY0NA0KICAgID4gLS0tIGEv
YXJjaC9yaXNjdi9pbmNsdWRlL2FzbS90bGJmbHVzaC5oDQogICAgPiArKysgYi9hcmNoL3Jpc2N2
L2luY2x1ZGUvYXNtL3RsYmZsdXNoLmgNCiAgICA+IEBAIC04LDYgKzgsNyBAQA0KICAgID4gICNk
ZWZpbmUgX0FTTV9SSVNDVl9UTEJGTFVTSF9IDQogICAgPg0KICAgID4gICNpbmNsdWRlIDxsaW51
eC9tbV90eXBlcy5oPg0KICAgID4gKyNpbmNsdWRlIDxsaW51eC9zY2hlZC5oPg0KICAgID4gICNp
bmNsdWRlIDxhc20vc21wLmg+DQogICAgPg0KICAgID4gIC8qDQogICAgPiBAQCAtNDYsMTQgKzQ3
LDM4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCByZW1vdGVfc2ZlbmNlX3ZtYShzdHJ1Y3QgY3B1bWFz
ayAqY21hc2ssIHVuc2lnbmVkIGxvbmcgc3RhcnQsDQogICAgPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBzaXplKQ0KICAgID4gIHsNCiAgICA+ICAg
ICAgICAgc3RydWN0IGNwdW1hc2sgaG1hc2s7DQogICAgPiArICAgICAgIHN0cnVjdCBjcHVtYXNr
IHRtYXNrOw0KICAgID4gKyAgICAgICBpbnQgY3B1aWQgPSBzbXBfcHJvY2Vzc29yX2lkKCk7DQog
ICAgPg0KICAgID4gICAgICAgICBjcHVtYXNrX2NsZWFyKCZobWFzayk7DQogICAgPiAtICAgICAg
IHJpc2N2X2NwdWlkX3RvX2hhcnRpZF9tYXNrKGNtYXNrLCAmaG1hc2spOw0KICAgID4gLSAgICAg
ICBzYmlfcmVtb3RlX3NmZW5jZV92bWEoaG1hc2suYml0cywgc3RhcnQsIHNpemUpOw0KICAgID4g
KyAgICAgICBjcHVtYXNrX2NsZWFyKCZ0bWFzayk7DQogICAgPiArDQogICAgPiArICAgICAgIGlm
IChjbWFzaykNCiAgICA+ICsgICAgICAgICAgICAgICBjcHVtYXNrX2NvcHkoJnRtYXNrLCBjbWFz
ayk7DQogICAgPiArICAgICAgIGVsc2UNCiAgICA+ICsgICAgICAgICAgICAgICBjcHVtYXNrX2Nv
cHkoJnRtYXNrLCBjcHVfb25saW5lX21hc2spOw0KICAgIA0KICAgIFRoaXMgY2FuIGJlIGZ1cnRo
ZXIgc2ltcGxpZmllZC4NCiAgICANCiAgICBXZSBjYW4gdG90YWxseSBhdm9pZCB0bWFzaywgY3B1
bWFza19jb3B5KCksIGFuZCBjcHVtYXNrX2NsZWFyKCkNCiAgICBieSBkaXJlY3RseSB1cGRhdGlu
ZyBobWFzay4NCiAgICANCkFoaCB5ZXMuIFRoYW5rcyBmb3IgcG9pbnRpbmcgb3V0Lg0KDQogICAg
SW4gYWRkaXRpb24gdG8gdGhpcyBwYXRjaCwgd2Ugc2hvdWxkIGFsc28gaGFuZGxlIHRoZSBjYXNl
IG9mDQogICAgZW1wdHkgaGFydCBtYXNrIGluIE9wZW5TQkkuDQogICAgDQpZZXMuIEkgaGF2ZSBm
ZXcgb3RoZXIgZml4ZXMgYXMgd2VsbCAoYXJvdW5kIGZpZm8gcmFjZSBjb25kaXRpb24gYW5kIGxv
Y2FsIGZsdXNoaW5nIGluIE9wZW5TQkkpLg0KSSB3aWxsIHNlbmQgdGhlbSBzb29uLg0KDQpSZWdh
cmRzLA0KQXRpc2gNCiAgICA+ICsNCiAgICA+ICsgICAgICAgaWYgKGNwdW1hc2tfdGVzdF9jcHUo
Y3B1aWQsICZ0bWFzaykpIHsNCiAgICA+ICsgICAgICAgICAgICAgICAvKiBTYXZlIHRyYXAgY29z
dCBieSBpc3N1aW5nIGEgbG9jYWwgdGxiIGZsdXNoIGhlcmUgKi8NCiAgICA+ICsgICAgICAgICAg
ICAgICBpZiAoKHN0YXJ0ID09IDAgJiYgc2l6ZSA9PSAtMSkgfHwgKHNpemUgPiBQQUdFX1NJWkUp
KQ0KICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAgbG9jYWxfZmx1c2hfdGxiX2FsbCgpOw0K
ICAgID4gKyAgICAgICAgICAgICAgIGVsc2UgaWYgKHNpemUgPT0gUEFHRV9TSVpFKQ0KICAgID4g
KyAgICAgICAgICAgICAgICAgICAgICAgbG9jYWxfZmx1c2hfdGxiX3BhZ2Uoc3RhcnQpOw0KICAg
ID4gKyAgICAgICAgICAgICAgIGNwdW1hc2tfY2xlYXJfY3B1KGNwdWlkLCAmdG1hc2spOw0KICAg
ID4gKyAgICAgICB9IGVsc2UgaWYgKGNwdW1hc2tfZW1wdHkoJnRtYXNrKSkgew0KICAgID4gKyAg
ICAgICAgICAgICAgIC8qIGNwdW1hc2sgaXMgZW1wdHkuIFNvIGp1c3QgZG8gYSBsb2NhbCBmbHVz
aCAqLw0KICAgID4gKyAgICAgICAgICAgICAgIGxvY2FsX2ZsdXNoX3RsYl9hbGwoKTsNCiAgICA+
ICsgICAgICAgICAgICAgICByZXR1cm47DQogICAgPiArICAgICAgIH0NCiAgICA+ICsNCiAgICA+
ICsgICAgICAgaWYgKCFjcHVtYXNrX2VtcHR5KCZ0bWFzaykpIHsNCiAgICA+ICsgICAgICAgICAg
ICAgICByaXNjdl9jcHVpZF90b19oYXJ0aWRfbWFzaygmdG1hc2ssICZobWFzayk7DQogICAgPiAr
ICAgICAgICAgICAgICAgc2JpX3JlbW90ZV9zZmVuY2Vfdm1hKGhtYXNrLmJpdHMsIHN0YXJ0LCBz
aXplKTsNCiAgICA+ICsgICAgICAgfQ0KICAgID4gIH0NCiAgICA+DQogICAgPiAtI2RlZmluZSBm
bHVzaF90bGJfYWxsKCkgc2JpX3JlbW90ZV9zZmVuY2Vfdm1hKE5VTEwsIDAsIC0xKQ0KICAgID4g
LSNkZWZpbmUgZmx1c2hfdGxiX3BhZ2Uodm1hLCBhZGRyKSBmbHVzaF90bGJfcmFuZ2Uodm1hLCBh
ZGRyLCAwKQ0KICAgID4gKyNkZWZpbmUgZmx1c2hfdGxiX2FsbCgpIHJlbW90ZV9zZmVuY2Vfdm1h
KE5VTEwsIDAsIC0xKQ0KICAgID4gKyNkZWZpbmUgZmx1c2hfdGxiX3BhZ2Uodm1hLCBhZGRyKSBm
bHVzaF90bGJfcmFuZ2Uodm1hLCBhZGRyLCAoYWRkcikgKyBQQUdFX1NJWkUpDQogICAgPiAgI2Rl
ZmluZSBmbHVzaF90bGJfcmFuZ2Uodm1hLCBzdGFydCwgZW5kKSBcDQogICAgPiAgICAgICAgIHJl
bW90ZV9zZmVuY2Vfdm1hKG1tX2NwdW1hc2soKHZtYSktPnZtX21tKSwgc3RhcnQsIChlbmQpIC0g
KHN0YXJ0KSkNCiAgICA+ICAjZGVmaW5lIGZsdXNoX3RsYl9tbShtbSkgXA0KICAgID4gLS0NCiAg
ICA+IDIuMjEuMA0KICAgID4NCiAgICA+DQogICAgPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KICAgID4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQog
ICAgPiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQogICAgPiBodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2DQogICAgDQogICAgUmVn
YXJkcywNCiAgICBBbnVwDQogICAgDQoNCg==
