Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48922C31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 00:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BFF20665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 00:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DsyKaheg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="o+STR06M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfHMAPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 20:15:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20761 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfHMAPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 20:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565655317; x=1597191317;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I5BUH+4Sq+xFTpc6mFQ+mMgWw41G1ncOymUx8Ld91S4=;
  b=DsyKaheg3qLdH+b1E+miDuXWlB23jtGWv6RE3+fhgC+ftbn9z1AMaz6K
   miq06Ptofaea0PlJYEiWMUjxVo8oDQ8FdCGNqIZajRk50d+VYmnFNeDow
   16T9EKWkFYuy861UjIn0/HKYaePlXGwK0LNusMu+cGUzgnRsTFrF/TQz7
   gaWAN5NktDAv8ZLmyz5+5lIKkRRInj+rX2H3l31lJDekbPDhzQkK48IEV
   FFFb6ZWJe95gLQZrz7uM/8e7GEvgZkAVXP/OVZ3qH0U9WPWmD9KtVcp22
   u4/BrhLMY4AljRv8HfDYE796slrOKIO1znsofTUxronxo+7AvHbbQKLrP
   A==;
IronPort-SDR: 3R5NBlQy/p3EeDeOY9rUp5Osj4hftsHVtIYxwIDhfl1v0od2gA6CxxEOLss+olMq4qffc0ElFB
 OBxC0jZbl1P1WVRUk4eFt69A6kIUQnzyHbvRvsln1zUZCMJSmfz6Ti8JLxB7H4jUdfLTWGiUic
 G3iA9e6dyV6jIsMbkxvG3DxAfOleixS0wq40IzPcEvsOSoK/xHgyS8iGocZ+PcszZGbUhMDmwl
 8ZxmrDIuGbd/J3a4uyjvwi5cpLZjUc7BfMsiU+IHglQul9KV0ZLzhh6eN8PEUvrKNpn53RAAfM
 hGM=
X-IronPort-AV: E=Sophos;i="5.64,379,1559491200"; 
   d="scan'208";a="120289057"
Received: from mail-co1nam04lp2058.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.58])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2019 08:15:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUeEZZGoLvIfDEvGZLtMcbP7n4Cc6nFRIpgyseub0UG2+SjsWYrMZ7I3mJFerGlYWEnl9L+6ExSDeOrr0STI8gsLm+GnmV5e+KvpaSTRB1U8wecN9S3ZGP0B81P7IPRKtsWnGQ+FdcZB6pkz3HxNKP9AfWgnOHbXaDrn9kWhDc0AEy1Bx3PZr0862TwjBg/0XaU6oEuWkmoIxrWjH0v/iGSFST3mTjC47U2kBxC7RC4x/ADl9m1MNyFniBBEZEcRdr3Ymk1qestdppKtH0bEApz01ZRoAYUpqSnD1BrXtca8may3v6KfzhIqH3d65HdV4x1qTbMwCcRKj2x0PLw8Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5BUH+4Sq+xFTpc6mFQ+mMgWw41G1ncOymUx8Ld91S4=;
 b=lfeApC/jfKAj4urys5QqbZkg+oIiVQ7zAcvzEhi8JnoZSOC5EcLOmaVqoyo5ZF+vOp5y34Gk0cpiOCEqQXEPopronQLC98mlwpPo5t6cLxpsC5kt6w9Jf2SFlr457zzk6FWA3rHn9WuIih++VuKWXpBWQp9q2p5It2OMKUsKgnAooCdp6Iv+qxjHeReAh74ugNlOfYuE/eptZErsbV+fKH4Lf46Ty1iTk2zmf1GGCR3zuHs3TCdfoDHa8u27cC9G9fBkE82MXGSzQ9k1TSZwh6I51fWV/qX2Lj5MQUsFfllSUVvn3U9EB+lOeFiYODJGzAqhn2QIOSpJpurvS4oW6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5BUH+4Sq+xFTpc6mFQ+mMgWw41G1ncOymUx8Ld91S4=;
 b=o+STR06ME34pa02YIPGG257pcJ9q5sBBNBIu8CahC5AYrVLwxvae8V5mcS/qc8a0k2f6FOWhFZA6zPMosmbnJQpEuFnrrgbECrd/z7UvAf83yKe/yNUwUXNuzczWT+uH6r1VOV5Ey8soTVcmUedIb5QnFlALe4N+qYXHjkdzGaA=
Received: from SN6PR04MB3791.namprd04.prod.outlook.com (52.135.81.24) by
 SN6PR04MB4159.namprd04.prod.outlook.com (52.135.71.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Tue, 13 Aug 2019 00:15:15 +0000
Received: from SN6PR04MB3791.namprd04.prod.outlook.com
 ([fe80::5dbf:a641:a0da:4c32]) by SN6PR04MB3791.namprd04.prod.outlook.com
 ([fe80::5dbf:a641:a0da:4c32%3]) with mapi id 15.20.2157.011; Tue, 13 Aug 2019
 00:15:15 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "palmer@sifive.com" <palmer@sifive.com>
Subject: Re: [PATCH] RISC-V: Issue a local tlb flush if possible.
Thread-Topic: [PATCH] RISC-V: Issue a local tlb flush if possible.
Thread-Index: AQHVTxz5XkoGRRVrekixM0/zCIcSeKb3ngaAgACcGwA=
Date:   Tue, 13 Aug 2019 00:15:15 +0000
Message-ID: <f58814e156b918531f058acfac944abef34f5fb1.camel@wdc.com>
References: <20190810014309.20838-1-atish.patra@wdc.com>
         <20190812145631.GC26897@infradead.org>
In-Reply-To: <20190812145631.GC26897@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbbad3a9-701d-4dbe-d071-08d71f8350d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4159;
x-ms-traffictypediagnostic: SN6PR04MB4159:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4159EB53D7B8F03ACE483FB6FAD20@SN6PR04MB4159.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(7736002)(76176011)(8936002)(5660300002)(2501003)(186003)(14454004)(478600001)(99286004)(1730700003)(6116002)(81166006)(66066001)(6512007)(66476007)(66946007)(8676002)(91956017)(76116006)(66446008)(64756008)(2351001)(66556008)(81156014)(6916009)(256004)(3846002)(26005)(6506007)(305945005)(316002)(53936002)(229853002)(118296001)(5640700003)(14444005)(446003)(54906003)(486006)(6486002)(86362001)(71200400001)(2616005)(476003)(4326008)(36756003)(102836004)(25786009)(6436002)(6246003)(11346002)(71190400001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4159;H:SN6PR04MB3791.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vq2Xz8tC3bskWu0PU5T48TsSWDTBerstlUsRBZr4QgqjRxg7oFY2ToqtEWsim7rcT8WXxfYStkavuMbcp24zLoduQKB5kRa1yQzopMXDC61A2ux7y1xAU/NDPr8l1q/q+yeLlkQ1wROLcfyuOgFCLDBKHUgqpexmtWshEqa6gTMokwpl+qkbRfbla7U91UR7K671mDkdDQmbXiS1ZeptPT4Or82t58mj4WSdA/uQcb42DQWX+C0HC4WWMxsrrqoAAAGQj4h3FZ3rJIeOyIA/1XplFwh1tYnpUiZhX6NIoxPBpG55KZnOcvSTvAhUakTjTo/qAU+Vt2L+4sqW1AHAjCUKvSRaj6Egrehbb6a+V0SjseZa6RgxhPPXh/FfIeoKzMYHIrvEB8Uzfv1lbMZQyFusbw6wWKYUAr9iBxaJjl4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92E2C94787F9AD4A9C9452C8752FD816@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbad3a9-701d-4dbe-d071-08d71f8350d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 00:15:15.2763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FLTreNXqh7gyMae46DIOuHK/E9+ORc4hq+WUKWae6RY4Gtsx0Ji2k5vZNV69TeCGJCUok6KzaXE4n80G6JfJFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTEyIGF0IDA3OjU2IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gSSBhZ3JlZSB3aXRoIHRoZSBjb21tZW50IHRoYXQgd2UgcmVhbGx5IHNob3VsZCBtb3Zl
IHRoaXMgb3V0IG9mIGxpbmUNCj4gbm93LCBhbmQgDQoNCnN1cmUuDQoNCj4gYWxzbyB0aGF0IHdl
IGNhbiBzaW1wbGlmeSBpdCBmdXJ0aGVyLCB3aGljaCBhbHNvIGluY2x1ZGVzDQo+IG5vdCBib3Ro
ZXJpbmcgd2l0aCB0aGUgU0JJIGNhbGwgaWYgd2Ugd2VyZSB0aGUgb25seSBvbmxpbmUgQ1BVLg0K
DQpJIGFscmVhZHkgaGFkIHRoYXQgb3B0aW1pemF0aW9uIGluIG15IHBhdGNoLg0KDQo+IEkgYWxz
byB0aGluZyB3ZSBuZWVkIHRvIHVzZSBnZXRfY3B1L3B1dF9jcHUgdG8gYmUgcHJlZW1wdGlvbiBz
YWZlLg0KPiANCm9rLiBJIHdpbGwgdXBkYXRlIHRoYXQuDQoNCj4gQWxzbyB3aHkgd291bGQgd2Ug
bmVlZCB0byBkbyBhIGxvY2FsIGZsdXNoIGlmIHdlIGhhdmUgYSBtYXNrIHRoYXQNCj4gZG9lc24n
dCBpbmNsdWRlIHRoZSBsb2NhbCBDUFU/DQo+IA0KDQpJIHRob3VnaHQgaWYgaXQgcmVjaWV2ZXMg
YW4gZW1wdHkgY3B1bWFzaywgdGhlbiBpdCBzaG91bGQgYXQgbGVhc3QgZG8gYQ0KbG9jYWwgZmx1
c2ggaXMgdGhlIGV4cGVjdGVkIGJlaGF2aW9yLiBBcmUgeW91IHNheWluZyB0aGF0IHdlIHNob3Vs
ZA0KanVzdCBza2lwIGFsbCBhbmQgcmV0dXJuID8gDQoNCg0KPiBIb3cgYWJvdXQgc29tZXRoaW5n
IGxpa2U6DQo+IA0KPiB2b2lkIF9fcmlzY3ZfZmx1c2hfdGxiKHN0cnVjdCBjcHVtYXNrICpjcHVt
YXNrLCB1bnNpZ25lZCBsb25nIHN0YXJ0LA0KPiAJCXVuc2lnbmVkIGxvbmcgc2l6ZSkNCj4gew0K
PiAJdW5zaWduZWQgaW50IGNwdTsNCj4gDQo+IAlpZiAoIWNwdW1hc2spDQo+IAkJY3B1bWFzayA9
IGNwdV9vbmxpbmVfbWFzazsNCj4gDQo+IAljcHUgPSBnZXRfY3B1KCk7DQo+IAlpZiAoIWNwdW1h
c2sgfHwgY3B1bWFza190ZXN0X2NwdShjcHUsIGNwdW1hc2spIHsNCj4gCQlpZiAoKHN0YXJ0ID09
IDAgJiYgc2l6ZSA9PSAtMSkgfHwgc2l6ZSA+IFBBR0VfU0laRSkNCj4gCQkJbG9jYWxfZmx1c2hf
dGxiX2FsbCgpOw0KPiAJCWVsc2UgaWYgKHNpemUgPT0gUEFHRV9TSVpFKQ0KPiAJCQlsb2NhbF9m
bHVzaF90bGJfcGFnZShzdGFydCk7DQo+IAkJY3B1bWFza19jbGVhcl9jcHUoY3B1aWQsIGNwdW1h
c2spOw0KDQpUaGlzIHdpbGwgbW9kaWZ5IHRoZSBvcmlnaW5hbCBjcHVtYXNrIHdoaWNoIGlzIG5v
dCBjb3JyZWN0LiBjbGVhciBwYXJ0DQpoYXMgdG8gYmUgZG9uZSBvbiBobWFzayB0byBhdm9pZCBh
IGNvcHkuDQoNClJlZ2FyZHMsDQpBdGlzaA0KPiAJfQ0KPiANCj4gCWlmICghY3B1bWFza19lbXB0
eShjcHVtYXNrKSkgew0KPiAJICAJc3RydWN0IGNwdW1hc2sgaG1hc2s7DQo+IA0KPiAJCXJpc2N2
X2NwdWlkX3RvX2hhcnRpZF9tYXNrKGNwdW1hc2ssICZobWFzayk7DQo+IAkJc2JpX3JlbW90ZV9z
ZmVuY2Vfdm1hKGhtYXNrLmJpdHMsIHN0YXJ0LCBzaXplKTsNCj4gCX0NCj4gCXB1dF9jcHUoKTsN
Cj4gfQ0KDQo=
