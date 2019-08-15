Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A896BC3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8952084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="llVx98ei";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kIZJN7hO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbfHOS5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 14:57:40 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38747 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbfHOS5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565895459; x=1597431459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5tJuRUTyp76o1BWy6VXz0ILglJJ1/IVy4qs4gLWOUz4=;
  b=llVx98eiyyKBO4ieupaWK5XmMt8nrk2rLQtbi+AGJZ9XLlaun0BSPCBC
   AreDLu2ZEkyWnAMvTZL9Nwp/0sVkOVYzGh9vNd4snRPBbEw8n3B2yN+vE
   5zqiKdmnBDPuoDdla5yBIcE14o4xomq/tZRvhBxehHkVHmEQLQ2ii1kW1
   EhvqP/ClqTV+8OnxLaqeKzoNzGpPpbAwyKgNWA+W4h+jnPwZSwBx8gtn9
   4xPcc+pG1vK2arngZoSGyprVCQN1o+gxju9MJVE682lir2PRiiNkrJSUE
   EB1/Cns+xuwcgIMB7sqOVDrtgFNDaFTdaOy3r5IAPyiJomL+sN8QWJXGj
   A==;
IronPort-SDR: LTAn3Tqhub7cEcPS91uAZYOBvBkwL+XSVAErPNrSdGnqP1y0qvWQ7wM2U1U3/RBuTwJBRstyvv
 7ZqTJU5SxWS+nnjFv9SFZ5YErGq5mzkwNMv3o+kUImYcPTAjNqMpJSPHMMS6tkeS1lzVG6kSUX
 LCwpYnbLISrfkZ1vrM1LKN7CLaGLNboe7vWkmFDuCPmym7e9sigb9jEN/0bZZR9gneuhwYkd4o
 hHE9lrEfm5NNrz8MS1WW/PTZhRQVY0tFjcbhJzbFmhT1SnNbF0WN6/fieZejxYM+SPz64RsAsk
 YPA=
X-IronPort-AV: E=Sophos;i="5.64,389,1559491200"; 
   d="scan'208";a="116872655"
Received: from mail-sn1nam04lp2050.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.50])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2019 02:57:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AP/q4qcyqAI5OIXZHY9/YrY9HMz/XKY9lQ2WqXj3jjB0YApFZPLtRsubgWZ749TCqhUw4rGJO3q2D6BMPQ9OHsYd5ULvA5fO8HbdaIZEeTSlJunlSGA1RSQK0KJlgNRgQRwT0cR0dI9r7l/REfDHujkB1T+1vQ9o50xqJMJYSQskNhu+XlvdQBqjSwlnNzCzIMYjN95lLC3iCbpJMo5iO4VFsXKMQS0gsOI4mHFgd6tqKp2MC8Ug9/stAXC3vF5AUgMIbg0xASngfKzn7UMZdD8kSfdFlqxqA+cMRWq86BFQa6nAfTy5F2ZiIMWddMb+0HLZmtTVY2Z0CcLdCEDBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tJuRUTyp76o1BWy6VXz0ILglJJ1/IVy4qs4gLWOUz4=;
 b=I+SLmxSsY9BcWAC6hscifZR1vrVY3oilS1IMVFLFlRvIHQbI9Gr3S+VIvT572ZMtJ2AlgZ4MsBvg4ti33gKovKOEJPb1YUngHGm4kVell73FqpJhjVwzBaHN2OJlFhNMub4SOCoRtVVPYO83nW07DuTSAOGrDGoM3WkECjrJNnm2nIDqpJtETql/dU2rXpABkauiLoUWjPCBwSUmV2rFTCXd5U5D9fHP6fjbCUBJUWk8Yt7zxD6jpqci3JA406HXNuOrjMxozHEl/ZNgcBy9oM5ab3mPp7vGV3CrbdeU1YiiU5TjId5sspvUO9XqOfZXBds/X6E+8kEioBYqCG07aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tJuRUTyp76o1BWy6VXz0ILglJJ1/IVy4qs4gLWOUz4=;
 b=kIZJN7hOP4UEGJd67Knoky5b/U2N8N7RGtgTfex2fOlxAbRqozaT67quDGv77LUa4Ixo7i0zcC3lQi9f7CPR6o7GcA8NkuJaauWazTck+cVlbnFQF4EK4lEq0p4TWos4meirN9MJlI9QtSLmqa7HTC5PA1VU0oRhQoeOz799rXE=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
 BYAPR04MB4053.namprd04.prod.outlook.com (52.135.215.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Thu, 15 Aug 2019 18:57:36 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::702b:2326:3cee:c07a]) by BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::702b:2326:3cee:c07a%2]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 18:57:36 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>
Subject: Re: [PATCH v5 2/2] RISC-V: Setup initial page tables in two stages
Thread-Topic: [PATCH v5 2/2] RISC-V: Setup initial page tables in two stages
Thread-Index: AQHVN3xcQ1Fn35uAxU+uy0ugjEz8uab8xqoA
Date:   Thu, 15 Aug 2019 18:57:36 +0000
Message-ID: <847fb8c879bbd2c3fd41dc1e428b3217253acebb.camel@wdc.com>
References: <20190607060049.29257-1-anup.patel@wdc.com>
         <20190607060049.29257-3-anup.patel@wdc.com>
         <alpine.DEB.2.21.9999.1907101703150.3422@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1907101703150.3422@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3ce8c94-7c0c-4c2f-7115-08d721b27036
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4053;
x-ms-traffictypediagnostic: BYAPR04MB4053:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4053A48F47EED52FFB8BF40F90AC0@BYAPR04MB4053.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(189003)(199004)(76176011)(66446008)(66946007)(2501003)(81166006)(8676002)(316002)(81156014)(305945005)(6246003)(6486002)(110136005)(6436002)(71190400001)(5660300002)(54906003)(99286004)(71200400001)(86362001)(26005)(6512007)(118296001)(76116006)(4326008)(66066001)(6636002)(229853002)(6306002)(186003)(64756008)(66556008)(66476007)(14444005)(256004)(14454004)(7736002)(45080400002)(446003)(478600001)(102836004)(8936002)(966005)(6506007)(53936002)(11346002)(25786009)(36756003)(486006)(476003)(3846002)(6116002)(2616005)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4053;H:BYAPR04MB4901.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R24NjAeqj/vVD70TLf11uZnSbKJI5llVcVJWCNYbOPyul6OaVTs+Skh74Tr8Nz8vy431Bcg+JuEOpfzfrcRWqWMFHlZxS+/5I4y6H23G+YavGnFDzb+ehZZ6uGApONXEfMHWh325yPots0hfI26FW2BUjsugiKmF5Gn75QCx1V9EWG51ogdxzVAFjTScCms+hT77YBMnW+AowZagigybOQIoCnREH/X75teB92zFS29HwEQ+s87da7O8GbPhS2iOeK3D5WTI1+8QwaX/1H4N8rwBQQh2eIiIkNeXSsVp3vTPH1fW0gh857+UbaVfEL+oBFYVgMTQiG53SGwKCQz3wHB71zP9Bz6zKOA66LzV8PJtPXYZDHH5MS/LHn50nz7DS1i7ptTIlDAQRUzeX8pBspTqpwUGddjxguflQKi40UM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70F8B7504394A14EB9DB24468D12D5FB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ce8c94-7c0c-4c2f-7115-08d721b27036
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 18:57:36.4916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VL2RCflwdQoKncDeyc63+8W/QBsl031W9NT63SdAa8i267/ywUBChzaqhDojQlpsP5T2LywlIQo+LEe6JVsnMcgCd9f43GGuXpfluKvas+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA3LTEwIGF0IDE3OjA1IC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBPbiBGcmksIDcgSnVuIDIwMTksIEFudXAgUGF0ZWwgd3JvdGU6DQo+IA0KPiA+IEN1cnJlbnRs
eSwgdGhlIHNldHVwX3ZtKCkgZG9lcyBpbml0aWFsIHBhZ2UgdGFibGUgc2V0dXAgaW4gb25lLXNo
b3QNCj4gPiB2ZXJ5IGVhcmx5IGJlZm9yZSBlbmFibGluZyBNTVUuIER1ZSB0byB0aGlzLCB0aGUg
c2V0dXBfdm0oKSBoYXMgdG8NCj4gPiBtYXANCj4gPiBhbGwgcG9zc2libGUga2VybmVsIHZpcnR1
YWwgYWRkcmVzc2VzIHNpbmNlIGl0IGRvZXMgbm90IGtub3cgc2l6ZQ0KPiA+IGFuZA0KPiA+IGxv
Y2F0aW9uIG9mIFJBTS4gVGhpcyBtZWFucyB3ZSBoYXZlIGtlcm5lbCBtYXBwaW5ncyBmb3Igbm9u
LQ0KPiA+IGV4aXN0ZW50DQo+ID4gUkFNIGFuZCBhbnkgYnVnZ3kgZHJpdmVyIChvciBrZXJuZWwp
IGNvZGUgZG9pbmcgb3V0LW9mLWJvdW5kIGFjY2Vzcw0KPiA+IHRvIFJBTSB3aWxsIG5vdCBmYXVs
dCBhbmQgY2F1c2UgdW5kZXJ0ZXJtaW5pc3RpYyBiZWhhdmlvdXIuDQo+ID4gDQo+ID4gRnVydGhl
ciwgdGhlIHNldHVwX3ZtKCkgY3JlYXRlcyBQTUQgbWFwcGluZ3MgKGkuZS4gMk0gbWFwcGluZ3Mp
IGZvcg0KPiA+IFJWNjQgc3lzdGVtcy4gVGhpcyBtZWFucyBmb3IgUEFHRV9PRkZTRVQ9MHhmZmZm
ZmZlMDAwMDAwMDAwIChpLmUuDQo+ID4gTUFYUEhZU01FTV8xMjhHQj15KSwgdGhlIHNldHVwX3Zt
KCkgd2lsbCByZXF1aXJlIDEyOSBwYWdlcyAoaS5lLg0KPiA+IDUxNiBLQikgb2YgbWVtb3J5IGZv
ciBpbml0aWFsIHBhZ2UgdGFibGVzIHdoaWNoIGlzIG5ldmVyIGZyZWVkLiBUaGUNCj4gPiBtZW1v
cnkgcmVxdWlyZWQgZm9yIGluaXRpYWwgcGFnZSB0YWJsZXMgd2lsbCBmdXJ0aGVyIGluY3JlYXNl
IGlmDQo+ID4gd2UgY2hvc2UgYSBsb3dlciB2YWx1ZSBvZiBQQUdFX09GRlNFVCAoZS5nLiAweGZm
ZmZmZjAwMDAwMDAwMDApDQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIHR3by1zdGFn
ZWQgaW5pdGlhbCBwYWdlIHRhYmxlIHNldHVwLCBhcw0KPiA+IGZvbGxvd3M6DQo+ID4gMS4gRWFy
bHkgKGkuZS4gc2V0dXBfdm0oKSk6IFRoaXMgc3RhZ2UgbWFwcyBrZXJuZWwgaW1hZ2UgYW5kIERU
QiBpbg0KPiA+IGEgZWFybHkgcGFnZSB0YWJsZSAoaS5lLiBlYXJseV9wZ19kaXIpLiBUaGUgZWFy
bHlfcGdfZGlyIHdpbGwgYmUNCj4gPiB1c2VkDQo+ID4gb25seSBieSBib290IEhBUlQgc28gaXQg
Y2FuIGJlIGZyZWVkIGFzLXBhcnQgb2YgaW5pdCBtZW1vcnkgZnJlZS0NCj4gPiB1cC4NCj4gPiAy
LiBGaW5hbCAoaS5lLiBzZXR1cF92bV9maW5hbCgpKTogVGhpcyBzdGFnZSBtYXBzIGFsbCBwb3Nz
aWJsZSBSQU0NCj4gPiBiYW5rcyBpbiB0aGUgZmluYWwgcGFnZSB0YWJsZSAoaS5lLiBzd2FwcGVy
X3BnX2RpcikuIFRoZSBib290IEhBUlQNCj4gPiB3aWxsIHN0YXJ0IHVzaW5nIHN3YXBwZXJfcGdf
ZGlyIGF0IHRoZSBlbmQgb2Ygc2V0dXBfdm1fZmluYWwoKS4gQWxsDQo+ID4gbm9uLWJvb3QgSEFS
VHMgZGlyZWN0bHkgdXNlIHRoZSBzd2FwcGVyX3BnX2RpciBjcmVhdGVkIGJ5IGJvb3QNCj4gPiBI
QVJULg0KPiA+IA0KPiA+IFdlIGhhdmUgZm9sbG93aW5nIGFkdmFudGFnZXMgd2l0aCB0aGlzIG5l
dyBhcHByb2FjaDoNCj4gPiAxLiBLZXJuZWwgbWFwcGluZ3MgZm9yIG5vbi1leGlzdGVudCBSQU0g
ZG9uJ3QgZXhpc3RzIGFueW1vcmUuDQo+ID4gMi4gTWVtb3J5IGNvbnN1bWVkIGJ5IGluaXRpYWwg
cGFnZSB0YWJsZXMgaXMgbm93IGluZHBlbmRlbnQgb2YgdGhlDQo+ID4gY2hvc2VuIFBBR0VfT0ZG
U0VULg0KPiA+IDMuIE1lbW9yeSBjb25zdW1lZCBieSBpbml0aWFsIHBhZ2UgdGFibGVzIG9uIFJW
NjQgc3lzdGVtIGlzIDIgcGFnZXMNCj4gPiAoaS5lLiA4IEtCKSB3aGljaCBoYXMgc2lnbmlmaWNh
bnRseSByZWR1Y2VkIGFuZCB0aGVzZSBwYWdlcyB3aWxsIGJlDQo+ID4gZnJlZWQgYXMtcGFydCBv
ZiB0aGUgaW5pdCBtZW1vcnkgZnJlZS11cC4NCj4gPiANCj4gPiBUaGUgcGF0Y2ggYWxzbyBwcm92
aWRlcyBhIGZvdW5kYXRpb24gZm9yIGltcGxlbWVudGluZyBzdHJpY3Qga2VybmVsDQo+ID4gbWFw
cGluZ3Mgd2hlcmUgd2UgcHJvdGVjdCBrZXJuZWwgdGV4dCBhbmQgcm9kYXRhIHVzaW5nIFBURQ0K
PiA+IHBlcm1pc3Npb25zLg0KPiA+IA0KPiA+IFN1Z2dlc3RlZC1ieTogTWlrZSBSYXBvcG9ydCA8
cnBwdEBsaW51eC5pYm0uY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFudXAgUGF0ZWwgPGFudXAu
cGF0ZWxAd2RjLmNvbT4NCj4gDQo+IFRoYW5rcywgdXBkYXRlZCB0byBhcHBseSBhbmQgdG8gZml4
IGEgY2hlY2twYXRjaCB3YXJuaW5nLCBhbmQNCj4gcXVldWVkLiAgDQo+IA0KPiBUaGlzIG1heSBu
b3QgbWFrZSBpdCBpbiBmb3IgdjUuMy1yYzE7IGlmIG5vdCwgd2UnbGwgc3VibWl0IGl0IGxhdGVy
Lg0KDQpJJ20gc2VlaW5nIHRoaXMgZmFpbHVyZSBvbiBSVjMyIHdoaWNoIEkgYmlzZWN0ZWQgdG8g
dGhpcyBwYXRjaDoNCg0KWyAgICAxLjgyMDQ2MV0gc3lzdGVtZFsxXTogc3lzdGVtZCAyNDItMTkt
Z2RiMmUzNjcrIHJ1bm5pbmcgaW4gc3lzdGVtDQptb2RlLiAoLVBBTSAtQVVESVQgLVNFTElOVVgg
K0lNQSAtQVBQQVJNT1IgK1NNQUNLICtTWVNWSU5JVCArVVRNUA0KLUxJQkNSWVBUU0VUVVAgLUdD
UllQVCAtR05VVExTICtBQ0wgK1haIC1MWjQgLVNFQ0NPTVAgK0JMS0lEIC1FTEZVVElMUw0KK0tN
T0QgLUlETjIgLUlETiAtUENSRTIgZGVmYXVsdC1oaWVyYXJjaHk9aHlicmlkKQ0KWyAgICAxLjgy
NDMyMF0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbA0K
YWRkcmVzcyA5ZmYwMGMxNQ0KWyAgICAxLjgyNDk3M10gT29wcyBbIzFdDQpbICAgIDEuODI1MTYy
XSBNb2R1bGVzIGxpbmtlZCBpbjoNClsgICAgMS44MjU1MzZdIENQVTogMCBQSUQ6IDEgQ29tbTog
c3lzdGVtZCBOb3QgdGFpbnRlZCA1LjIuMC1yYzcgIzENClsgICAgMS44MjYwMzldIHNlcGM6IGMw
NWMzYzc4IHJhIDogYzA0YjVhNzQgc3AgOiBkZjA0N2NlMA0KWyAgICAxLjgyNjUxNF0gIGdwIDog
YzA3YTEwMzggdHAgOiBkZjA0YzAwMCB0MCA6IDAwMDAwMGZjDQpbICAgIDEuODI2OTE5XSAgdDEg
OiAwMDAwMDAwMiB0MiA6IDAwMDAwM2VmIHMwIDogZGYwNDdjZjANClsgICAgMS44MjczMjJdICBz
MSA6IGRmNzA5MGY4IGEwIDogOWZmMDBjMTUgYTEgOiBjMDcyMTY2Yw0KWyAgICAxLjgyNzcyM10g
IGEyIDogMDAwMDAwMDAgYTMgOiAwMDAwMDAwMSBhNCA6IDAwMDAwMDAxDQpbICAgIDEuODI4MTA0
XSAgYTUgOiBkZjZmODEzOCBhNiA6IDAwMDAwMDJmIGE3IDogZGU2MmEwMDANClsgICAgMS44Mjg1
MzRdICBzMiA6IGMwNzIxNjZjIHMzIDogMDAwMDAwMDAgczQgOiAwMDAwMDAwMA0KWyAgICAxLjgy
ODkzMV0gIHM1IDogYzA3YTIwMDAgczYgOiAwMDQwMGNjMCBzNyA6IDAwMDAwNDAwDQpbICAgIDEu
ODI5MzE5XSAgczggOiBkZTQ5MTAxOCBzOSA6IDAwMDAwMDAwIHMxMDogZmZmZmYwMDANClsgICAg
MS44Mjk3MDJdICBzMTE6IGRlNDkxMDMwIHQzIDogZGU2MmIwMDAgdDQgOiAwMDAwMDAwMA0KWyAg
ICAxLjgzMDA5MF0gIHQ1IDogMDAwMDAwMDAgdDYgOiAwMDAwMDA4MA0KWyAgICAxLjgzMDM5Ml0g
c3N0YXR1czogMDAwMDAxMDAgc2JhZGFkZHI6IDlmZjAwYzE1IHNjYXVzZTogMDAwMDAwMGQNClsg
ICAgMS44MzE2MTZdIC0tLVsgZW5kIHRyYWNlIDQ5YTkyNmExYTUzMDBjMDAgXS0tLQ0KWyAgICAx
LjgzNTc3Nl0gS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IEF0dGVtcHRlZCB0byBraWxsIGlu
aXQhDQpleGl0Y29kZT0weDAwMDAwMDBiDQpbICAgIDEuODM2NTc1XSAtLS1bIGVuZCBLZXJuZWwg
cGFuaWMgLSBub3Qgc3luY2luZzogQXR0ZW1wdGVkIHRvIGtpbGwNCmluaXQhIGV4aXRjb2RlPTB4
MDAwMDAwMGIgXS0tLQ0KDQpEb2VzIGFueW9uZSBlbHNlIHNlZSB0aGlzPw0KDQpBIHNpbXBsZSBy
ZXZlcnQgb2YgdGhpcyBwYXRjaCBvbiA1LjMtcmM0IGZpeGVzIHRoZSBpc3N1ZSBmb3IgbWUuDQoN
CkFsaXN0YWlyDQoNCj4gDQo+IA0KPiAtIFBhdWwNCj4gDQo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdA0K
PiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YNCg==
