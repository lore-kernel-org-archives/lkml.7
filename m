Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E454C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422352086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pS7PSG8q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QHnaMbq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbfHOVcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 17:32:19 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54404 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730302AbfHOVcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 17:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565904739; x=1597440739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yYFSEQkHqKdpNXJTMbHP1qd8pqN9z/B8+2PPV1KS44g=;
  b=pS7PSG8qmtvneimVnZkRwgWvLM/OkYlS6dJt6RR6fygXEUK//IAB8ZJz
   Ia5mJgWgsM+f0Kn9kS95xZCWonQjzrrYfMBFlqZpoA1H1fFMR3lo5yr2O
   6RO5zXMgBKeI/RcDDkbwcB+IwlhVnrSwTCyVqPfUT2dU6sCa6XeT7i3rx
   U1jrp2S58tgV0Nz6WHXg1LpTsfMNBmbUVKe7/006BRDBbFZSJbZushc8Y
   gkUAPT0cpTi8IIbQXMiauTg8rgH5Ym2WUWywA5xx/+1aZrxwMKjAYadRK
   c+hGaV7qYcTWJEnoMwW2wGjC+Wsc65lUUhyXa8CiPJnensVkB2xvw1sLc
   Q==;
IronPort-SDR: 3CeGUfjsKYe/e8ZArBgLKScgQOp5k9DTlEO/GG1z+ai+LDo6zJthgEM94XABZlU0PcSV+oq95N
 bnuaowS6CtqoP8+XddNMcqkx21ZXZWP9gDr10dCuLYnTVNFM4dmZd6EisiQKX/TCdevMrgw/ig
 6j9HAZujJ++n405Y1Etsem8P7hJblKavLdEaSW/nWv+E1A1WLoTjf4+PrmSIrS0P8WGhordbpW
 toMjCA5yQbSPvjlrDpl7T0IjssvyYhOcjDfm7KejcrTZTD0Rm05o6Ujx27Wkko+i0m3JRHVVxl
 BXc=
X-IronPort-AV: E=Sophos;i="5.64,389,1559491200"; 
   d="scan'208";a="116881348"
Received: from mail-by2nam05lp2056.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.56])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2019 05:32:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMOAyDt+Mj6Oe+K/qu7wu/NUzwMvgy9RxZxQVyCai0NJAcXzSYkxJdAUTM0JGsxszV0+7vZRtz/XguA158RJGlbo+MN0d8MVgWbDn3dcqDabrUyv0rivnItcRPg9H3ALHDkEBpSnujq8Jc+7yVbmMQO30ZXAhRqi+xeWpAj6tUClMUdlMJP8x/uVfIcOffuyBZ4o6K739ydCLwhC1JhacMh9wp8SYWi0j0Nr0LHg2pUuYg/BT5tVaZDV113hn0mQhaklZwc6v04CHw7c4kjXbxhgHUnLukREGJtVN6wwwYc0K0ZSojbdtqjTgLdbf3FtgMpYET967JLQCvhDIEjO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYFSEQkHqKdpNXJTMbHP1qd8pqN9z/B8+2PPV1KS44g=;
 b=LQWwU2mARMSAFKdnelekR1rcfYJ08zbezSIMvMSaAF2yiDzA1Q/T1EnRVPXzYg4ZhPwyt9Z7kWROIsEJfaHqMI1r2jhOrTWpNUfBLn1PimhNV98Ht8Tto7HLdvf0Zuzxmj/ketY+EzkNYuNK9bglDcAY6jcEZNBVskoV3/7GbpyaPDEbCCafQR/CyicVbCXEVHZ02yQ6oW/+GgO/HMd0gyb9KIIZE1IoMizpZD7RPMX3LMxFnQGLJcd2TZ4wQFkOfT02ItVRwEvoaOqF78vKGK1TSHN2Nt5CocupCr5lhkkklRjV8AF138E9i8KajoBTMB3oSGlXYPqKoMmPTUPaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYFSEQkHqKdpNXJTMbHP1qd8pqN9z/B8+2PPV1KS44g=;
 b=QHnaMbq8jZEhXvpN7KjFj6qTe4bMeOZfWjWJEfWlazid8zhotkHE1+6W0s+YMmcJFxRlc18BQ8Ptxtj+4j1x0uw9IaugcKiaxCWDHt4ygD5jcqbrWu892Hs9wp1Er3MUs7ikYsAJoBRJnp0TJUqE+lEWqTTQufh3Bt+cZo73KGA=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
 BYAPR04MB6198.namprd04.prod.outlook.com (20.178.232.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 15 Aug 2019 21:32:17 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::702b:2326:3cee:c07a]) by BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::702b:2326:3cee:c07a%2]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 21:32:17 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "david.abdurachmanov@gmail.com" <david.abdurachmanov@gmail.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@sifive.com" <palmer@sifive.com>
Subject: Re: [PATCH v5 2/2] RISC-V: Setup initial page tables in two stages
Thread-Topic: [PATCH v5 2/2] RISC-V: Setup initial page tables in two stages
Thread-Index: AQHVN3xcQ1Fn35uAxU+uy0ugjEz8uab8xqoAgAADpYCAABb1gIAAEJuA
Date:   Thu, 15 Aug 2019 21:32:17 +0000
Message-ID: <89abd38c67eb3e02551b8a3a1705c9bf591cfbcf.camel@wdc.com>
References: <20190607060049.29257-1-anup.patel@wdc.com>
         <20190607060049.29257-3-anup.patel@wdc.com>
         <alpine.DEB.2.21.9999.1907101703150.3422@viisi.sifive.com>
         <847fb8c879bbd2c3fd41dc1e428b3217253acebb.camel@wdc.com>
         <CAEn-LTpz_iL0Ts5GG9J6oESN76DcjBaNs-Oz-c9CcpbmRiN5Sw@mail.gmail.com>
         <alpine.DEB.2.21.9999.1908151327490.18249@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1908151327490.18249@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ba77f8c-a291-4478-984d-08d721c80be9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB6198;
x-ms-traffictypediagnostic: BYAPR04MB6198:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB619816048E40A5D8B1F9048890AC0@BYAPR04MB6198.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(199004)(189003)(45080400002)(486006)(25786009)(6116002)(81156014)(6486002)(86362001)(446003)(76116006)(81166006)(66946007)(3846002)(2616005)(476003)(66446008)(64756008)(66556008)(66476007)(6436002)(6506007)(99286004)(11346002)(76176011)(305945005)(7736002)(6246003)(4326008)(5660300002)(71200400001)(2906002)(316002)(36756003)(229853002)(110136005)(118296001)(71190400001)(26005)(8936002)(6512007)(102836004)(54906003)(14454004)(53936002)(186003)(14444005)(256004)(478600001)(8676002)(66066001)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6198;H:BYAPR04MB4901.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZQmrKoCLUz7QNp3g8Je9yFh6VKg7Qn3/UaTDh7q+6DLZxOqtCO7k/583tO1CrpOGiSzdXQ2+1CeA2V4V2C5Yc1ruL6QqmnVV5UNqtUAj0+Z+cG0UsAZIsc8mk84nkATZaYogUrhBB8eHgXNzvA3R+T9uwh3BvIMXzd951O+JLd1tAwMdyDp9wgbBa1CiCrjXN3iqOK9XqgogKUxSUjD3OfSlcuLQheVwB2DYNAoLd9NNEzjL/Dku0yHrdyhqeQGeHtK7v6zZv7WLhLxAhJPS9K1Rajwk9xD1SXLMKPUgAGul1FRutG4bFX98AXA539hdhIQdxK644J/EJTYZo+EMT3gpcdAKz4CvEnKKAdVl6PE4ZgE6y2fShGqrdNcY5cxsoTaUUltTvbfQRHqev0AoqsvRppy+gJm1HKErewCeB78=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3045C1B9C4BC145A1DB8DCB94CB00DE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba77f8c-a291-4478-984d-08d721c80be9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 21:32:17.1719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DeN7juKIIWV4rNNnWrmKpyso0bOBeBupJ8tXa+M7WACouQAHALaYnvsDYDONqirr4TDFTUtEQ+aQlqz/1ILS00EWefVPL/e61R/eYmnwFJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTE1IGF0IDEzOjI5IC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBPbiBUaHUsIDE1IEF1ZyAyMDE5LCBEYXZpZCBBYmR1cmFjaG1hbm92IHdyb3RlOg0KPiANCj4g
PiBZZXMsIEkgZG8gc2VlIHRob3NlIGluIEZlZG9yYS9SSVNDViBidWlsZCBmYXJtIGV2ZXJ5IG1v
cm5pbmcsIGJ1dA0KPiA+IHdpdGgNCj4gPiByaXNjdjY0IGFuZCA1LjIuMC1yYzcga2VybmVsLg0K
PiANCj4gWy4uLl0NCj4gDQo+ID4gZmVkb3JhLXJpc2N2LTQgbG9naW46IFsxNzg4NzYuNDA2MTIy
XSBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbA0KPiA+IHBhZ2luZw0KPiA+IHJlcXVlc3QgYXQgdmly
dHVhbCBhZGRyZXNzIDAwMDAwMDAwMDAwMTJhMjgNCj4gPiBmZWRvcmEtcmlzY3YtNyBsb2dpbjog
WzE3OTgzLjA3NDg0N10gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nDQo+ID4gcmVxdWVz
dCBhdCB2aXJ0dWFsIGFkZHJlc3MgMGZmZmZmZGZmNWUxNDcwMA0KPiANCj4gQWxpc3RhaXIsIHlv
dSdyZSBzZWVpbmcgcGFuaWNzIGltbWVkaWF0ZWx5IGFmdGVyIHRoZSB1c2Vyc3BhY2UNCj4gdHJh
bnNpdGlvbiwgDQo+IHJpZ2h0PyAgMTAwJSBvZiB0aGUgdGltZT8NCg0KWWVzLCBqdXN0IGFmdGVy
IGluaXQgKHN5c3RlbWQpIGlzIHN0YXJ0ZWQuIEkgc2VlIHRoaXMgMTAwJSBvZiB0aGUgdGltZQ0K
d2l0aCAzMi1iaXQgUklTQy1WLg0KDQpIZXJlIGlzIGFuIHVwZGF0ZWQgbG9nIHdpdGggYSBsaXR0
bGUgbW9yZSBjb250ZXh0Og0KDQpbICAgIDEuMjI3MDcyXSBFWFQ0LWZzICh2ZGEpOiBtb3VudGVk
IGZpbGVzeXN0ZW0gd2l0aCBvcmRlcmVkIGRhdGENCm1vZGUuIE9wdHM6IChudWxsKQ0KWyAgICAx
LjIyODE0OF0gVkZTOiBNb3VudGVkIHJvb3QgKGV4dDQgZmlsZXN5c3RlbSkgb24gZGV2aWNlIDI1
NDowLg0KWyAgICAxLjI3NDQ4Nl0gRnJlZWluZyB1bnVzZWQga2VybmVsIG1lbW9yeTogMTkySw0K
WyAgICAxLjI3NDc4OF0gVGhpcyBhcmNoaXRlY3R1cmUgZG9lcyBub3QgaGF2ZSBrZXJuZWwgbWVt
b3J5DQpwcm90ZWN0aW9uLg0KWyAgICAxLjI3NTI5OF0gUnVuIC9zYmluL2luaXQgYXMgaW5pdCBw
cm9jZXNzDQpbICAgIDEuNjgyNzQ5XSBzeXN0ZW1kWzFdOiBzeXN0ZW1kIDI0Mi0xOS1nZGIyZTM2
NysgcnVubmluZyBpbiBzeXN0ZW0NCm1vZGUuICgtUEFNIC1BVURJVCAtU0VMSU5VWCArSU1BIC1B
UFBBUk1PUiArU01BQ0sgK1NZU1ZJTklUICtVVE1QDQotTElCQ1JZUFRTRVRVUCAtR0NSWVBUIC1H
TlVUTFMgK0FDTCArWFogLUxaNCAtU0VDQ09NUCArQkxLSUQgLUVMRlVUSUxTDQorS01PRCAtSURO
MiAtSUROIC1QQ1JFMiBkZWZhdWx0LWhpZXJhcmNoeT1oeWJyaWQpDQpbICAgIDEuNjg1NTM2XSBV
bmFibGUgdG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsDQphZGRyZXNz
IDlmZjAwYzE1DQpbICAgIDEuNjg2MTYwXSBPb3BzIFsjMV0NClsgICAgMS42ODY0MDldIE1vZHVs
ZXMgbGlua2VkIGluOg0KWyAgICAxLjY4NjgyNl0gQ1BVOiAwIFBJRDogMSBDb21tOiBzeXN0ZW1k
IE5vdCB0YWludGVkIDUuMy4wLXJjNCAjMQ0KWyAgICAxLjY4NzM4OF0gc2VwYzogYzA1ZDJmNzQg
cmEgOiBjMDRiZDYwYyBzcCA6IGRmMDRmY2UwDQpbICAgIDEuNjg3ODE3XSAgZ3AgOiBjMDdhZjRh
OCB0cCA6IGRmMDUwMDAwIHQwIDogMDAwMDAwZmMNClsgICAgMS42ODgzMjldICB0MSA6IDAwMDAw
MDAyIHQyIDogMDAwMDAzZWYgczAgOiBkZjA0ZmNmMA0KWyAgICAxLjY4ODc2M10gIHMxIDogZGY3
MDkwZjggYTAgOiA5ZmYwMGMxNSBhMSA6IGMwNzJmNGE4DQpbICAgIDEuNjg5MTg2XSAgYTIgOiAw
MDAwMDAwMCBhMyA6IDAwMDAwMDAxIGE0IDogMDAwMDAwMDENClsgICAgMS42ODk1ODddICBhNSA6
IGRmNmY4MTM4IGE2IDogMDAwMDAwMmYgYTcgOiBkZTYyYTAwMA0KWyAgICAxLjY4OTk3MF0gIHMy
IDogYzA3MmY0YTggczMgOiAwMDAwMDAwMCBzNCA6IDAwMDAwMDAwDQpbICAgIDEuNjkwMzU1XSAg
czUgOiBjMDdiMTAwMCBzNiA6IDAwNDAwY2MwIHM3IDogMDAwMDA0MDANClsgICAgMS42OTA3MzJd
ICBzOCA6IGRlNDk2MDE4IHM5IDogMDAwMDAwMDAgczEwOiBmZmZmZjAwMA0KWyAgICAxLjY5MTEx
NF0gIHMxMTogZGU0OTYwMzAgdDMgOiBkZTYyYjAwMCB0NCA6IDAwMDAwMDAwDQpbICAgIDEuNjkx
NDkxXSAgdDUgOiAwMDAwMDAwMCB0NiA6IDAwMDAwMDgwDQpbICAgIDEuNjkxNzk3XSBzc3RhdHVz
OiAwMDAwMDEwMCBzYmFkYWRkcjogOWZmMDBjMTUgc2NhdXNlOiAwMDAwMDAwZA0KWyAgICAxLjY5
Mjg2MV0gLS0tWyBlbmQgdHJhY2UgN2FlZDM2MTZjYWNjMjBlYSBdLS0tDQpbICAgIDEuNjk1MzU4
XSBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogQXR0ZW1wdGVkIHRvIGtpbGwgaW5pdCENCmV4
aXRjb2RlPTB4MDAwMDAwMGINClsgICAgMS42OTYxNThdIC0tLVsgZW5kIEtlcm5lbCBwYW5pYyAt
IG5vdCBzeW5jaW5nOiBBdHRlbXB0ZWQgdG8ga2lsbA0KaW5pdCEgZXhpdGNvZGU9MHgwMDAwMDAw
YiBdLS0tDQoNCj4gDQo+IElmIHNvLCB0aGlzIGlzIHByb2JhYmx5IGEgZGlmZmVyZW50IGJ1Zy4g
IE1vc3QgbGlrZWx5IHRoZSBUTEINCj4gZmx1c2hpbmcgDQo+IGlzc3VlLg0KDQpJJ20gbm90IHN1
cmUuIEkgaGF2ZSB0cmllZCB3aXRoIEF0aXNoJ3MgT3BlblNCSSBhbmQga2VybmVsIHBhdGNoZXMg
YnV0DQp0aGF0IGRpZG4ndCBoZWxwLg0KDQpSZXZlcnRpbmcganVzdCB0aGlzIHBhdGNoIGRvZXMg
ZnVsbHkgZml4IHRoZSBwcm9ibGVtIHRob3VnaC4NCg0KQWxpc3RhaXINCg0KPiANCj4gDQo+IC0g
UGF1bA0K
