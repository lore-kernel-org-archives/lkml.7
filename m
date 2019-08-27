Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45BBC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543042077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J1KLp/6T";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BacZADLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfH0WTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 18:19:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:54390 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfH0WTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 18:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566944385; x=1598480385;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=srADbCKFuW9L8z1xWppi7GahM2SkRc+Fc0TpzzgENZ0=;
  b=J1KLp/6TcotGn8hUnbXzmx140kKYiBAPawUcjpUA3xAuZWYRyqKc8THO
   Ki78/FlhYVPLAvsnDDugwjvpbr2d9EwqsQu8M6eBkwNl2QXxI4Ay+sIm7
   /H2TtBxo326Rt4AwRWZ0jH5/OXmp/SCWT/GHixJZYmqqrj8RuwGSUYw/x
   XQniAQyCXd6WFlCHiNLgnTFwv3BcTDViold9OjFm1lnAjZ1LugPAqcTRZ
   Jn+eFD7u5Hnfn0nJHKV2aJGvLlNhjKDAF9+H8Ai/vzc9SGwv5+EpU1YV2
   EWSISjO3P4sLrR8HyjM9EYsTwT9iYj8jqi/JZBLwLoGqJ3S3cmHSw8wW4
   A==;
IronPort-SDR: 7n8qJB4v8VRO7L08q90WUAU5/uF4DNMKStlG2MtY4H5uUwOGqRDR1aNheN6WfVS62yX4URR3UG
 Id5+vUab75y4x315oZleAelioqhaaYPCeE6aW+WpJKHDi046H/QQ2mhLLb/Y8z2oVL8X21+DNk
 oGW6sfd2E25zAeyEP1+zUDyTWmfMG9pyTkR5pP13QjfsHk9szU0kKwCbiLiNvuqx0mPEbw8pj9
 nM/pUk8N69EKB9FgGyzxMvpQemNeSv19IgIlhAF9aS0LVt+nIX8Qd38v7uLqw5GfFoRJLW25ww
 6yk=
X-IronPort-AV: E=Sophos;i="5.64,438,1559491200"; 
   d="scan'208";a="223461272"
Received: from mail-sn1nam02lp2059.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.59])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2019 06:19:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRro36y2KJUx3b0YgkIRmIxKxjBpdqmKjuevEdmjjYIYe8eXSvxvS9l/ESBzXH29JdavKNe4Oi1gK2JxIDKsRsG/Nf04btMwSRsqe7YjAPx4MrrdAmFpJLzxYMSXWWu7r79Mfe0Q6oi61f4VwPLyy0FK0WXzJdidWoHspj7MvhTHTNKC9QKJGt5xxiWnNyqqgt4bRL/cXhE/aBylj5fnSVenpvBwGExSDW7yDeNHOQN0UFPqngZvp5HB/fhyL/LW5PO52t5PsT+p5NGY/eFPr3RlT04/tsEc0F4qVbVeKkBNhp8XfAQ6Iw8ViTNcMIh1t5MNQBsCp+SfIEBFaJE2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srADbCKFuW9L8z1xWppi7GahM2SkRc+Fc0TpzzgENZ0=;
 b=RhaKQAjNPyUJ3HdV35cDOk/soI8Kaaz5IxeVCyHo1BJ6ZvEcXEBB4uxEYthQiRLh+YgKz/Z945Z5NUqNB+ycdPsdndxfj6Yd8/0LdfS4oKynEAshYGNyE5LM0TwcrwWOAEm8xBfOLtfwFKh8BkIorqQydwd70kcZrgSwmsSyKO9z9bfwCezJ0nBKklQspwkQL3WTHknktVtoYIWrOlt5CoL2G8Y1zQTlJeIvioOSjobNdIMkZiNPxOvwt2vBQPHy6eCGjTLbC2HoBDK8wfamaN+Y96dNtkzsKXlYrgSTOZAgQ5dLlk5hdL0C4kpIEHV7pFcFN4YriZMfPTyHIO3nwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srADbCKFuW9L8z1xWppi7GahM2SkRc+Fc0TpzzgENZ0=;
 b=BacZADLjwg2tkMUcG3H0PvIWnHkLq9czgriJdvej74vfOJDC8GJcvW7TWyOmve06IYxUDfDbJqNs/TK/UDU6XZmFhdmHdzypFiS+maLY7Ce9PqA2mEnVFb5mxg02k1XxH45d2hd742uM4RioK9yRKxuneLxPSkNbq1vY/SOJ/8Y=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB4056.namprd04.prod.outlook.com (52.135.215.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 22:19:42 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e%4]) with mapi id 15.20.2178.020; Tue, 27 Aug 2019
 22:19:42 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "palmer@sifive.com" <palmer@sifive.com>
Subject: Re: [RFC PATCH 0/2] Add support for SBI version to 0.2
Thread-Topic: [RFC PATCH 0/2] Add support for SBI version to 0.2
Thread-Index: AQHVXGav48Iq39BuIEaKaF29rj3wXqcPE5gAgAB+pYA=
Date:   Tue, 27 Aug 2019 22:19:42 +0000
Message-ID: <a31c39e8653bd04efe0051a5fd6f0238d33a80e7.camel@wdc.com>
References: <20190826233256.32383-1-atish.patra@wdc.com>
         <20190827144624.GA18535@infradead.org>
In-Reply-To: <20190827144624.GA18535@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3648a849-6b61-4a9c-498e-08d72b3ca8a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4056;
x-ms-traffictypediagnostic: BYAPR04MB4056:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BYAPR04MB405697829D25C9BB2324801CFAA00@BYAPR04MB4056.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(229853002)(99286004)(478600001)(2616005)(6916009)(486006)(118296001)(11346002)(446003)(76176011)(8676002)(14454004)(7416002)(2906002)(6116002)(6486002)(3846002)(26005)(81156014)(81166006)(6436002)(2501003)(5640700003)(1730700003)(476003)(305945005)(7736002)(186003)(6506007)(8936002)(2351001)(86362001)(76116006)(25786009)(966005)(5660300002)(4326008)(102836004)(36756003)(6512007)(256004)(71200400001)(316002)(54906003)(14444005)(6246003)(66066001)(71190400001)(66946007)(66556008)(64756008)(66446008)(66476007)(53936002)(6306002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4056;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8Cv6lczjJTLMjGeg5onD91MrOrIbTbMk3E11V27H5w4+8GiRc+5QhXPwh4DbIkdGfr5W+tPNanDR2h/z50N/I2f8B+yxMG0Juasr5Os1OVITfW8wm3bewsniZwryHlHqLvSDVlPw1e/lUpSdNMqrzi9h+rs93uP3BM5J9it/6dEBxrLMn3PkFATKj3rlQEUDn8kSMXaCPPHGunIYYMULRqVrP2v1+HGC77rxDphA28b4pXJb6oDktqrpu8LhrynjvJMSd7+VL3Yhm55Al6fgPTTBnuPcZhKIUM/Sgdl3/+lO7YPLka5e6M54Pcv/MsfvTZoaS9MI8266FsYTxXYeUW3Z5mSpkessp+OYydUuWW/PpaZCcAxkRLYz5aUtJO8SADhaSLlBQykG1f46vtLIObx+AEU1qi5D5+bA5zmTL8U=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E06CEAE083E03D4289BC18666CE15D12@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3648a849-6b61-4a9c-498e-08d72b3ca8a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 22:19:42.1523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qrN3tJNLFzrOlDWCfaqhAT9jyYrptHFr9w6HIP4Dw6ID+vuxdDAuH4ZLEoGYR9++KBf6SAqSR6P3CBS/UMyWhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTI3IGF0IDA3OjQ2IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gTW9uLCBBdWcgMjYsIDIwMTkgYXQgMDQ6MzI6NTRQTSAtMDcwMCwgQXRpc2ggUGF0
cmEgd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgYWltcyB0byBhZGQgc3VwcG9ydCBmb3Ig
U0JJIHNwZWNpZmljYXRpb24gdmVyc2lvbg0KPiA+IHYwLjIuIEl0IGRvZXNuJ3QgYnJlYWsgY29t
cGF0aWJpbGl0eSB3aXRoIGFueSB2MC4xIGltcGxlbWVudGF0aW9uLg0KPiA+IEludGVybmFsbHks
IGFsbCB0aGUgdjAuMSBjYWxscyBhcmUganVzdCByZW5hbWVkIHRvIGxlZ2FjeSB0byBiZSBpbg0K
PiA+IHN5bmMgd2l0aCBzcGVjaWZpY2F0aW9uIFsxXS4NCj4gPiANCj4gPiBUaGUgcGF0Y2hlcyBm
b3IgdjAuMiBzdXBwb3J0IGluIE9wZW5TQkkgYXJlIGF2YWlsYWJsZSBhdA0KPiA+IGh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9vcGVuc2JpLzIwMTktQXVndXN0LzAwMDQyMi5o
dG1sDQo+ID4gDQo+ID4gWzFdIA0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9yaXNjdi9yaXNjdi1z
YmktZG9jL2Jsb2IvbWFzdGVyL3Jpc2N2LXNiaS5hZG9jDQo+IA0KPiBJIHJlYWxseSBkb24ndCBs
aWtlIHRoZSBjdXJyZW50IGRlc2lnbiBvZiB0aGF0IFNCSSAwLjIgc3BlYywNCj4gYW5kIGRvbid0
IHRoaW5rIGltcGxlbWVudGluZyBpdCBhcy1pcyBpcyBoZWxwZnVsLg0KPiANCj4gRm9yIG9uZSB0
aGUgd2F5IGhvdyB0aGUgZXh0ZW5zaW9uIGlkIGlzIHBsYWNlZCBjcmVhdGVzIGEgY29tcGF0aWJp
bHR5DQo+IHByb2JsZW0sIG5vdCBhbGxvd2luZyB5b3VyIHRvIGltcGxlbWVudCBhIGJhY2t3YXJk
cyBjb21wYXRpYmxlIHNiaSwNCj4gd2hpY2ggc2VlbXMgYmFkLg0KPiANCg0KSSBkaWQgbm90IHVu
ZGVyc3RhbmQgdGhpcyBwYXJ0LiBBbGwgdGhlIGxlZ2FjeSBTQkkgY2FsbHMgYXJlIGRlZmluZWQg
YXMNCmEgc2VwYXJhdGUgZXh0ZW5zaW9uIElEIG5vdCBzaW5nbGUgZXh0ZW5zaW9uLiBIb3cgZGlk
IGl0IGJyZWFrIHRoZQ0KYmFja3dhcmQgY29tcGF0aWJpbGl0eSA/DQoNCkhlcmUgYXJlIHRoZSBm
ZXcgcG9zc2libGUgdXNlY2FzZXMNCg0KMS4gTmV3IGtlcm5lbCBjYW4gdXNlIFNCSSB2MC4yIGNh
bGxpbmcgY29udmVudGlvbiBmb3Igb2xkZXIgbGVnYWN5DQpjYWxscy4gSXQgd2lsbCBqdXN0IHNl
dCBhNiB0byB6ZXJvIChmdW5jdGlvbiBpZCkgJiBub3QgdXNlIHRoZSByZXR1cm4NCnZhbHVlIGlu
IGExLiBhMCBpcyBzdGlsbCByZXBvcnQgZXJyb3IgdmFsdWUuDQoNCjIuIE5ldyBrZXJuZWwgd2l0
aCBvbGRlciBTQkkgaW1wbGVtZW50YXRpb24gKGkuZS4gQkJMKSB3aWxsIGFsc28gd29yaw0KYXMg
c2JpX2dldF9zcGVjX3ZlcnNpb24gd2lsbCByZXR1cm4gZXJyb3IgYW5kIHNwZWNfdmVyc2lvbiB3
aWxsIGJlIHNldA0KMC4xLiBCQkwgbmV2ZXIgY2hlY2tzIGE2IG9yIHNldCBhMSB3aGljaCB3b3Jr
cyBmb3IgdGhlIGxlZ2FjeSBjYWxscy4NCg0KMy4gT2xkZXIga2VybmVsIHdpdGggbmV3IFNCSSBp
bXBsZW1lbnRhdGlvbihpLmUgT3BlblNCSSkgd2lsbCBuZXZlciB1c2UNCnYwLjIgY2FsbGluZyBj
b252ZW50aW9ucy4gT3BlblNCSSBuZXZlciB1c2UgYTYgb3Igc2V0IGExIGZvciBsZWdhY3kNCmNh
bGxzIGFueXdheXMuDQoNCkRpZCBJIG1pc3MgYW55IHVzZWNhc2UgPyANCg0KPiBTZWNvbmQganVz
dCBibGluZGx5IG1vdmluZyBhbGwgdGhlIGV4aXN0aW5nIGNhbGxzIHRvIGEgc2luZ2xlIGxlZ2Fj
eQ0KPiBleHRlbnNpb24gZG9lc24ndCBzZWVtIHVzZWZ1bC4gIFdlIG5lZWQgdG8gZGlmZmVyZW5j
aWF0ZSB0aGUgZXhpc3RpbmcNCj4gY2FsbHM6DQoNCkkgdGhpbmsgdGhlIGNvbmZ1c2lvbiBpcyBi
ZWNhdXNlIG9mIGxlZ2FjeSByZW5hbWluZy4gVGhleSBhcmUgbm90DQpzaW5nbGUgbGVnYWN5IGV4
dGVuc2lvbi4gVGhleSBhcmUgYWxsIHNlcGFyYXRlIGV4dGVuc2lvbnMuIFRoZSBzcGVjDQpqdXN0
IGNhbGxlZCBhbGwgdGhvc2UgZXh0ZW5zaW9ucyBhcyBjb2xsZWN0aXZlbHkgYXMgbGVnYWN5LiBT
byBJIGp1c3QNCnRyaWVkIHRvIG1ha2UgdGhlIHBhdGNoIHN5bmMgd2l0aCB0aGUgc3BlYy4NCg0K
SWYgdGhhdCdzIHRoZSBzb3VyY2Ugb2YgY29uZnVzaW9uLCBJIGNhbiByZW5hbWUgaXQgdG8gc2Jp
XzAuMV94IGluDQpzdGVhZCBvZiBsZWdhY3kuDQo+IA0KPiAgKDEpIGFjdHVhbGx5IGJvYXJkIHNw
ZWNpZmljIGFuZCBoYXZlIG5vdCBwbGFjZSBpbiBhIGNwdSBhYnN0cmFjdGlvbg0KPiAgICAgIGxh
eWVyOiBnZXRjaGFyL3B1dGNoYXIsIHRoZXNlIHNob3VsZCBqdXN0IG5ldmVyIGJlIGFkdmVydGlz
ZWQgaW4NCj4gYQ0KPiAgICAgICBub24tbGVnYWN5IHNldHVwLCBhbmQgdGhlIGRyaXZlcnMgdXNp
bmcgdGhlbSBzaG91bGQgbm90IHByb2JlDQo+ICAgICAgIG9uIGEgc2JpIDAuMisgc3lzdGVtDQoN
CkluIHRoYXQgY2FzZSwgd2UgaGF2ZSB0byB1cGRhdGUgdGhlIGRyaXZlcnMoZWFybHljb24tcmlz
Y3Ytc2JpICYNCmh2Y19yaXNjdl9zYmkpIGluIGtlcm5lbCBhcyB3ZWxsLiBPbmNlIHRoZXNlIHBh
dGNoZXMgYXJlIG1lcmdlZCwgbm9ib2R5DQp3aWxsIGJlIGFibGUgdG8gdXNlIGVhcmx5Y29uPXNi
aSBmZWF0dXJlIGluIG1haW5saW5lIGtlcm5lbC4NCg0KUGVyc29uYWxseSwgSSBhbSBmaW5lIHdp
dGggaXQuIEJ1dCB0aGVyZSB3ZXJlIHNvbWUgaW50ZXJlc3QgZHVyaW5nDQpSSVNDLVYgd29ya3No
b3AgaW4ga2VlcGluZyB0aGVzZSBmb3Igbm93IGZvciBlYXN5IGRlYnVnZ2luZyBhbmQgZWFybHkN
CmJyaW5ndXAuDQoNCg0KPiAgKDIpIHVzZWZ1bCBmb3IgY3VycmVudGx5IHRhcGVkIG91dCBjcHVz
IGFuZCBpbiB0aGUgbG9uZyBydW4gZm9yDQo+ICAgICAgdmlydHVhbGl6YXRpb24gdG8gYXZvaWQg
bW1pbyB0cmFwczogIGlwaXMsIHRpbWVycywgdGxiDQo+IHNob290ZG93bi4NCj4gICAgICBUaGVz
ZSBzaG91bGQgc3RheSBiYWNrd2FyZHMgY29tcGF0aWJsZSwgYnV0IGZvciBzYmkgMC4yIGJlDQo+
ICAgICAgbmVnb3RpYXRlZCBpbmRpdmlkdWFsbHkNCg0KV2Ugc3RpbGwgY2FuIGRvIHRoYXQgd2l0
aCBleGlzdGluZyBzY2hlbWUuDQoNCj4gICgzKSBpbiB0aGVvcnkgdXNlZnVsLCBidXQgZ2l2ZW4g
aG93IG11Y2ggb2YgYSBiaWcgaGFtbWVyIHNmZW5jZS5pDQo+ICAgICAgbm90IHVzZWZ1bCBpbiB0
aGVvcnk6IFNCSV9SRU1PVEVfRkVOQ0VfSSB3ZSBjYW4gZGVjaWRlIGlmIHdlDQo+IHdhbnQNCj4g
ICAgICB0byBlaXRoZXIgbm90IGFsbG93IGl0IGZvciBzYmkgMC4yKyBvciBhbHNvIG5lZ290aWF0
ZSBpdC4gIEknZA0KPiAgICAgIHBlcnNvbmFsbHkgZmF2b3Igbm90IGFkdmVydGlzaW5nIGl0IGFu
ZCBqdXN0IHVzZSBpcGlzIHRvDQo+IGltcGxlbWVudA0KPiAgICAgIGl0LiAgDQoNCk9uY2Ugd2Ug
aGF2ZSBuYXRpdmUgSVBJcywgc3VyZS4gT3RoZXJ3aXNlLCBzZmVuY2UuaSB1c2luZyBJUEkgdmlh
IFNCSQ0Kd2lsbCBiZSBldmVuIHNsb3dlciBjb21wYXJlZCB0b2RheS4gR2FyeSBoYWQgZG9uZSB0
aGUgc2FtZSB0aGluZyBmb3INCnNmZW5jZS52bWEgYW5kIGl0IHdhcyBub3QgZW5vY291cmFnZWQu
DQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA4NDU5NTkvIzIyNTc2OTg3
DQoNCj4gSWYgd2Ugd2FudCB1c2VmdWwgYWNjZWxlcmF0aW9uIG9mIGktY2FjaGUgc3luY2hyb25p
emF0aW9uDQo+ICAgICAgd2UnbGwgbmVlZCBhY3R1YWwgaW5zdHJ1Y3Rpb25zIHRoYXQgYXJlIG11
Y2ggbW9yZSBmaW5lIGdyYWluZWQNCj4gICAgICBpbiB0aGUgZnV0dXJlLg0KDQoNCi0tIA0KUmVn
YXJkcywNCkF0aXNoDQo=
