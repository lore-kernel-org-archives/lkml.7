Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E5CC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 05:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAE022CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 05:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ISgMpwRs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eP4F8n0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbfHVFjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 01:39:42 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:61904 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbfHVFjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 01:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566452389; x=1597988389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nhZg2iermVd3E78W6wl1Z6dDFBfD2bmQHw0Wi5AL6uI=;
  b=ISgMpwRsJ8+Ed7DmcWlIc8rVDGOPunMOUz/jx6FFesudLFYf7DBl+YWL
   Qd05e337ly4wr2BP7oDYQfm2cqKdXy0QJTQSJ3QTjbnanXSXo3cQ7Ohgl
   QR8SSOt8Y/yJ2VlB9B2/zu/AJFUV5wJ8SGCjbWsHNqZOClHvJ9bOIgo17
   QjRGe9QDMcwLQHb8T0Rmtn5AyqDxfXRNkrAdrQzoGrkw+VyxWXGaD1M/C
   S9KRlLHHGI+nkkI4jCZ0ULQhl0wNsGw/Y849Oel6PsazDNoRofaMDhO94
   HJ8loML5c/tHVOCRYIOFlw8qbEJMtl1Gjz1sNWm9j9anpe8d9Yc7SR1eS
   A==;
IronPort-SDR: cDQFSc647GwzYl/JnzMF6Zt07jsH+oPtX8HedjSwBbJaqqxPKc5fcYROIkBhd/WgAUIKuJTd71
 KonbCujHcHGW8uPTrxcdUWRfZIgQG2Ish4gOH7L0+FP2OuA70xIhztwwnA+UEG/B9jIhnoe1Nk
 xH4DUaEw+Vg+rbPWqDh4tQt7RsriN/a4RSJRKyXpXoxnpAkjlayyUqKPukbxnh+EQWxeruCOQa
 l9JKVOKqzS7dmcQcG9eHvHyG/WSCP2Gr6QhQEhAgg6A+ltXeI2Mp+xmAQJmRgHuIeD5Ry7gLvb
 CGU=
X-IronPort-AV: E=Sophos;i="5.64,415,1559491200"; 
   d="scan'208";a="216820974"
Received: from mail-sn1nam01lp2052.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.52])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2019 13:39:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFNc6/lZDuqhTLkpo4Y6djrPhgPBjFtLI9pr+pRI6KrOVd32TXL3C81ixft3qnXIl1iQLlD4+p6W83/9xnmZfblPbeOxca57H5BTnvqe9HwHaZCLho3wuzqv6n+je6tvFrlXvK/t1lEfNpNP69ccHh/dqiSSeu8tXVZvS8+/Z38p77mwzeFQj7H45iGoXpZjlUFGYKfCYv22fNziJb004ldy2VULCVLfUSWYjOKpf+UB/7keJZXMHoYfU2vXLdN9xu0lJ74E797WkI+C3ljCXsxkIp4Ek6m7Fv7K6y8u/NQNfAoKpF5Rq6twN0PyMwPfTExRsS4mU866S/5W7oiuCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhZg2iermVd3E78W6wl1Z6dDFBfD2bmQHw0Wi5AL6uI=;
 b=Nm3uYP0ZHDN44ZqUZZ4fCIJ3+fiJF1135PWBUiSTXSVwvssrIUoEIAvNBuTp711pu9aAj74F+IEWXB/CZ/HU1wROK49kLCXQudWgWCM4PBtAj4pPi7JMa4QgrrsI1TLBICDmGkiMww/nH+v3wQqd8/G0HPnsqKsgNLh4p9cCGsDtoUiPDMhdH9YJ6WpWjMN4S7Ehs/I9p1BIHFhsddMWE1dIrxYdYYHXChOUaPqOTpQls4poB4QNzrbaKIJ2mk81Ene4mq3t0e4XuGPGOMflTCayhpOUup1ahhdgO8adYgYXhRq9/yQGLODtlcSCmxEeKm2CmmtKl3SGmYeJXHaAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhZg2iermVd3E78W6wl1Z6dDFBfD2bmQHw0Wi5AL6uI=;
 b=eP4F8n0W7zkyvn2+T4s6WqYWrOsN6dvoM4Ih0Q4IQbcsl9yr3NiDUP+hQD4aSKnSpIb5Z1Gd08yvreRcmhVi/p0jUN75lt/xDL7FSCzYd+awkGyqPYf0P7yig7KWzQSXPdLVo8f1Oxx32mz8Y5gZXHRVk92evGnhNd30yyI2zhk=
Received: from SN6PR04MB3999.namprd04.prod.outlook.com (52.135.82.28) by
 SN6PR04MB4542.namprd04.prod.outlook.com (52.135.120.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 05:39:39 +0000
Received: from SN6PR04MB3999.namprd04.prod.outlook.com
 ([fe80::413c:37f2:e66d:1110]) by SN6PR04MB3999.namprd04.prod.outlook.com
 ([fe80::413c:37f2:e66d:1110%5]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 05:39:39 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@sifive.com" <palmer@sifive.com>
Subject: Re: [PATCH v3 1/3] RISC-V: Issue a local tlbflush if possible.
Thread-Topic: [PATCH v3 1/3] RISC-V: Issue a local tlbflush if possible.
Thread-Index: AQHVWIMVUivLbwS0nk+EJJcu32ceGqcGZd4AgAAlowCAAAc7gIAAFDcA
Date:   Thu, 22 Aug 2019 05:39:39 +0000
Message-ID: <6142d5abf18206d6ad7db9d89a3385651649b4a6.camel@wdc.com>
References: <20190822004644.25829-1-atish.patra@wdc.com>
         <20190822004644.25829-2-atish.patra@wdc.com>
         <20190822014642.GA11922@lst.de>
         <0f66583404f89ab2bd6c264ba653364ab8a3160e.camel@wdc.com>
         <20190822042717.GA14076@lst.de>
In-Reply-To: <20190822042717.GA14076@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [2601:646:8280:fdf0:69be:1cca:a557:65ea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e85df39-22d2-43f7-996b-08d726c32012
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR04MB4542;
x-ms-traffictypediagnostic: SN6PR04MB4542:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB45424C5A00681FF33E309147FAA50@SN6PR04MB4542.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(199004)(189003)(11346002)(305945005)(4326008)(66446008)(2501003)(64756008)(25786009)(91956017)(66476007)(71200400001)(66556008)(46003)(7736002)(118296001)(102836004)(6506007)(76116006)(8936002)(81156014)(54906003)(81166006)(71190400001)(256004)(229853002)(86362001)(1730700003)(6246003)(14454004)(76176011)(99286004)(478600001)(5640700003)(6486002)(6512007)(5660300002)(66946007)(53936002)(6436002)(6916009)(316002)(6116002)(2906002)(446003)(36756003)(8676002)(486006)(186003)(476003)(2616005)(2351001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4542;H:SN6PR04MB3999.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IlWqQ6A5ucYgEutLc8oeu8unU/Vao6KZptT0095Aoc0PI1SHaeK2HY5YSJeCifm6B+oAVIw/TrfY5ORNsY0t5Eoq6OH88aJX+mD4PpBznsfZR0tT+SRTnfJv6ABTNKdY9O4/17i/5ROKuf2A8AaVwOHUcSI51GVijmZ2iMGqBwDLtTUH9KJHsMKq97xll0ul6x8N3Gh9UInmRiCwvqT+4HF1hxhuk3PPUeNZEXqujt2/dR7VX5jxv93EXQyMPWYEJ083EOMrzA6HdyrG+jZ0V4gDTzptq+5LD3tJAkJwCVYTxc+ArODcNVxSAeGIen/OJSNPreWAVOrhPIfOZweKhl7mkOSxI4g6LYsEfONRgQx1QI2MlUBIzPZVY6SvJcBro1VszM8eg96JgdPerF0tbhSH+uxUgnbA28CJAffl3ME=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8D99045C8BF184983AD64E3F115E39A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e85df39-22d2-43f7-996b-08d726c32012
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 05:39:39.3793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lrGEo6WIJHWyIO5AECL7BcYyfDyNwDX3a/LohYehCsMDdLvylYiN5R9ycGB33EZLTmBrXVaameBvk1ByhzdsUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4542
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTIyIGF0IDA2OjI3ICswMjAwLCBoY2hAbHN0LmRlIHdyb3RlOg0KPiBP
biBUaHUsIEF1ZyAyMiwgMjAxOSBhdCAwNDowMToyNEFNICswMDAwLCBBdGlzaCBQYXRyYSB3cm90
ZToNCj4gPiBUaGUgZG93bnNpZGUgb2YgdGhpcyBpcyB0aGF0IGZvciBldmVyeSAhY21hc2sgY2Fz
ZSBpbiB0cnVlIFNNUA0KPiA+IChtb3JlDQo+ID4gY29tbW9uIHByb2JhYmx5KSBpdCB3aWxsIGV4
ZWN1dGUgMiBleHRyYSBjcHVtYXNrIGluc3RydWN0aW9ucy4gQXMNCj4gPiB0bGJmbHVzaCBwYXRo
IGlzIGluIHBlcmZvcm1hbmNlIGNyaXRpY2FsIHBhdGgsIEkgdGhpbmsgd2Ugc2hvdWxkDQo+ID4g
ZmF2b3INCj4gPiBtb3JlIGNvbW1vbiBjYXNlIChTTVAgd2l0aCBtb3JlIHRoYW4gMSBjb3JlKS4N
Cj4gDQo+IEFjdHVhbGx5LCBsb29raW5nIGF0IGJvdGggdGhlIGN1cnJlbnQgbWFpbmxpbmUgY29k
ZSwgYW5kIHRoZSBjb2RlDQo+IGZyb20gbXkNCj4gY2xlYW51cHMgdHJlZSBJIGRvbid0IHRoaW5r
IHJlbW90ZV9zZmVuY2Vfdm1hIC8gX19zYmlfdGxiX2ZsdXNoX3JhbmdlDQo+IGNhbiBldmVyIGJl
IGNhbGxlZCB3aXRoICBOVUxMIGNwdW1hc2ssIGFzIHdlIGFsd2F5cyBoYXZlIGEgdmFsaWQgbW0u
DQo+IA0KDQpZZXMuIFlvdSBhcmUgY29ycmVjdC4NCg0KQXMgYm90aCBjcHVtYXNrIGZ1bmN0aW9u
cyBoZXJlIHdpbGwgY3Jhc2ggaWYgY3B1bWFzayBpcyBudWxsLCB3ZSBzaG91bGQNCnByb2JhYmx5
IGxlYXZlIGEgaGFybWxlc3MgY29tbWVudCB0byB3YXJuIHRoZSBjb25zZXF1ZXVuY2Ugb2YgY3B1
bWFzaw0KYmVpbmcgbnVsbC4NCg0KPiBTbyB0aGlzIGlzIGEgYml0IG9mIGEgbW9vdCBwb2ludCwg
YW5kIHdlIGNhbiBkcm9wIGFuZGxpbmcgdGhhdCBjYXNlDQo+IGVudGlyZWx5LiAgV2l0aCB0aGF0
IHdlIGNhbiBhbHNvIHVzZSBhIHNpbXBsZSBpZiAvIGVsc2UgZm9yIHRoZSBsb2NhbA0KPiBjcHUg
b25seSB2cyByZW1vdGUgY2FzZS4gDQoNCkRvbmUuDQoNCj4gIEJ0dywgd2hhdCB3YXMgdGhlIHJl
YXNvbiB5b3UgZGlkbid0IGxpa2UNCj4gdXNpbmcgY3B1bWFza19hbnlfYnV0IGxpa2UgeDg2LCB3
aGljaCBzaG91bGQgYmUgbW9yZSBlZmZpY2llbnQgdGhhbg0KPiBjcHVtYXNrX3Rlc3RfY3B1ICsg
aHdlaWd0Pw0KDQpJIGhhZCBpdCBpbiB2MiBwYXRjaCBidXQgcmVtb3ZlZCBhcyBpdCBjYW4gcG90
ZW50aWFsbHkgcmV0dXJuIGdhcmJhZ2UNCnZhbHVlIGlmIGNwdW1hc2sgaXMgZW1wdHkuIA0KDQpI
b3dldmVyLCB3ZSBhcmUgYWxyZWFkeSBjaGVja2luZyBlbXB0eSBjcHVtYXNrIGJlZm9yZSB0aGUg
bG9jYWwgY3B1DQpjaGVjay4gSSB3aWxsIHJlcGxhY2UgY3B1bWFza190ZXN0X2NwdSArIGh3ZWln
aHQgd2l0aA0KY3B1bWFza19hbnlfYnV0KCkuDQoNCi0tIA0KUmVnYXJkcywNCkF0aXNoDQo=
