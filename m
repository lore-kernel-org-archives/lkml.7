Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A1AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6586622CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bwCBIBam";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Km/e7Pqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfH1Wcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:32:51 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64768 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfH1Wcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1567031571; x=1598567571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BnZjWVBxTN3AAzy8CtockO/Uc9G3NFIK+joUrS3Fsnw=;
  b=bwCBIBamfe5diB+6AQenuv9unIN++f8gnQV+7rRZQsjWXQgBdHGQPsnI
   K0iOeGo6xRSgD6SeuWRaqNMq9T5aCGEi1OXglqN49M06RBH84+GGkBZWc
   2vtWAz2tzk6rrigLhN7/hA9Z1n1yI6Rs1mjHLUSIKVzBcjN5Dt6HFyqrO
   xPtOgozVByG7voDlIvUtINTkM0YQ2bG5h9WZMcmeGVV1c4xK5V3Yu0hGc
   KYIZOUwERXV6XPwZUGoD5HNtwgybw7HDb03nfQ2jmHfcy4acdin9WmVrg
   XqeZ0z9M18EhRTFUhgWVs5HNbSTThYoxkyhpNwJJRc7pmq7RwqdGEKQGl
   Q==;
IronPort-SDR: zjlQsQ+ObgJ73l2qDF2CpJbGi8+R5akhWgHrRGv2/tLeKwHsVpvSdPvxMC4YrSs7boSEOcjUaL
 D8LFc8HdCLGJH7SgkKRJrva84DqM1XN7rNI1bamGNR2QAZnk54YRLEow2XBnzzBIQf7t9FljvT
 7WvoWzyDCBq7MhhuNhVuW2no5C5jt/jFvTuYcyovU0xB08MzkRrTWnPzoZgfkAz50ls7VAORux
 js4bp4omKrANrq8b8SjbnfraNJ2+8lfrqNxeoSsZWGkrY74/LO/+bPabtz+vxiiK6LePjI6DfA
 OT0=
X-IronPort-AV: E=Sophos;i="5.64,442,1559491200"; 
   d="scan'208";a="117815811"
Received: from mail-co1nam03lp2055.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.55])
  by ob1.hgst.iphmx.com with ESMTP; 29 Aug 2019 06:32:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmLrtBDi0MWdChBQcTd2hs5IzfhruCdAl7N+iiAhAgt5+4VbfNuCbWyboxy4jRUBq9czG0kau1FtBmMTHCPFF6Wvgcm1ecSqObUzgETi3UJdrmlzduHX2C5Fb8MieLNus8wP0EEOI1he17tgSkpi99ychxXh3aR8VbOzcZFcS0m40cDu/K5N1Ys1O8g81k+c2NUonlKL13qrZmWYjgKmf3t+xgyAPgW1fIn8gDS2YncPiMKjT+xA0CgxRf2eHEX8S8JH6dyrK5vx/bSJHPCjIj+n9CDgMSHlJJdTc9eiO5IN7ZVARGfu2eViakQ+3nfVxAMDQqmwSnQMUGikYqQo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnZjWVBxTN3AAzy8CtockO/Uc9G3NFIK+joUrS3Fsnw=;
 b=cER+lM/Ff1MZodwmTn3J3WJZ4T/HzrEKm7W1j1dSQ0MeGH+6UHm8kUC/4wZChj11xSlRDZweSMYhQA37UV7C5C2Nm/S0TAXVjbJU4ERanTXiA1Aia16b1iLu7J6Cqm6foG9ndgn4PqpQpe6CBkvP0pau0ZppnfB91Uf1ADTstQ0f35zBkk/4f46IifizT3PCWnSr1YN+rSClfn39SDKyLbUGvYklWweh3/s9W5Tpnwe7xnkTpT13t5G6Lr4RUDTSnXAW083fSRVfZDJLt3SkUw+8P4k3kUC/HQRzl8bsmcir6qXTYug1M9Vk8qSupsCqQNw+GTrYN5qNVHzBr40Snw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnZjWVBxTN3AAzy8CtockO/Uc9G3NFIK+joUrS3Fsnw=;
 b=Km/e7Pqre7PYOsVywsYS69TFr8EZC52dj4L7Pjmc03L+1ihYFZZVdlOxuMO4KD+xETrgy3ukTrN1CmW2Pta5GZpLQX0lqFmYqAvH0DSC155yzkxoIEKIN2J3/kyQt+TxJxJTZnG2e+6IHL7n0jQWLUxtI+nT4qKX1myQuilwad0=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
 BYAPR04MB4902.namprd04.prod.outlook.com (52.135.232.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16; Wed, 28 Aug 2019 22:32:48 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::702b:2326:3cee:c07a]) by BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::702b:2326:3cee:c07a%2]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 22:32:48 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "anup@brainfault.org" <anup@brainfault.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH v2] RISC-V: Fix FIXMAP area corruption on RV32 systems
Thread-Topic: [PATCH v2] RISC-V: Fix FIXMAP area corruption on RV32 systems
Thread-Index: AQHVVkz2mzRBOANcr0Cpw6hsdQg8z6cOK+CAgAApSgCAAt47gA==
Date:   Wed, 28 Aug 2019 22:32:47 +0000
Message-ID: <e43024d42164377794d6ba85d4b80ec69db3eb67.camel@wdc.com>
References: <20190819051345.81097-1-anup.patel@wdc.com>
         <alpine.DEB.2.21.9999.1908261704500.10109@viisi.sifive.com>
         <CAAhSdy0XALGpc-bCuO7njiBT3p-YvLqhMnRTRu4Hd4gMKeQMTw@mail.gmail.com>
In-Reply-To: <CAAhSdy0XALGpc-bCuO7njiBT3p-YvLqhMnRTRu4Hd4gMKeQMTw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4774e1e8-0f89-48dc-3a12-08d72c07a771
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4902;
x-ms-traffictypediagnostic: BYAPR04MB4902:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB49028245AC523788F226D83890A30@BYAPR04MB4902.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(189003)(199004)(26005)(4326008)(25786009)(102836004)(256004)(186003)(14444005)(99286004)(54906003)(81156014)(316002)(36756003)(110136005)(6506007)(53546011)(76176011)(66066001)(118296001)(2616005)(8676002)(476003)(81166006)(6486002)(66476007)(5660300002)(229853002)(446003)(11346002)(6116002)(8936002)(86362001)(486006)(6512007)(3846002)(66446008)(478600001)(6246003)(2501003)(53936002)(66946007)(76116006)(71200400001)(305945005)(2906002)(66556008)(71190400001)(14454004)(7736002)(6436002)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4902;H:BYAPR04MB4901.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bQLdI4gNUvY3g6DLA12mn0IbQejho8Nw7mLzvaebmPnWWfWuyGh7VTG6/gZtQ6VmbnSTNPLnFd+VHPVZbHeGfysusRqmAOvYKnx9gNRB6VfcKx0SwKKHvO+GHwxg78HUDgoyixZ9EKg/N1NmScm4zCpwhGgDeDFWexQMhHXprm7mkWxFWfVUjyWgDXolwEPp6usztG8W1EvF5SRPuF4miOBMFw19Bdwm07xaiW/PlkUYpGy1oqVu57jFlXFgKdfWoa4bw5XyUSlFqO3plSBzPrB0CRSyucysr197ojKk7xUuNoY51z+MvYe614ZtAQcL5epantgrnpZ8L1RY3XQxrufK5UGUu2QialHXU+4kmh7Ii0jeeI0EViiQuUHU5/RlDwLqcM/T1tKBYBEDkkKFMUO64jfDt11Uaj1t0BaNtJs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <467585749D66CF40AB10302709E933A7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4774e1e8-0f89-48dc-3a12-08d72c07a771
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 22:32:47.8885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sWWLOC/ekEO13kRstxFbX+bKzLAsVQ02CGm08FwQoGdriTVAzFQnfY1YUinL8DrTi+aX90JHxKzqCrco1MDs6YG7U3daiOO8fyeZhD4zXNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4902
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTI3IGF0IDA4OjExICswNTMwLCBBbnVwIFBhdGVsIHdyb3RlOg0KPiBP
biBUdWUsIEF1ZyAyNywgMjAxOSBhdCA1OjQzIEFNIFBhdWwgV2FsbXNsZXkgPA0KPiBwYXVsLndh
bG1zbGV5QHNpZml2ZS5jb20+IHdyb3RlOg0KPiA+IEhlbGxvIEFudXAsDQo+ID4gDQo+ID4gT24g
TW9uLCAxOSBBdWcgMjAxOSwgQW51cCBQYXRlbCB3cm90ZToNCj4gPiANCj4gPiA+IEN1cnJlbnRs
eSwgdmFyaW91cyB2aXJ0dWFsIG1lbW9yeSBhcmVhcyBvZiBMaW51eCBSSVNDLVYgYXJlDQo+ID4g
PiBvcmdhbml6ZWQNCj4gPiA+IGluIGluY3JlYXNpbmcgb3JkZXIgb2YgdGhlaXIgdmlydHVhbCBh
ZGRyZXNzZXMgaXMgYXMgZm9sbG93czoNCj4gPiA+IDEuIFVzZXIgc3BhY2UgYXJlYSAoVGhpcyBp
cyBsb3dlc3QgYXJlYSBhbmQgc3RhcnRzIGF0IDB4MCkNCj4gPiA+IDIuIEZJWE1BUCBhcmVhDQo+
ID4gPiAzLiBWTUFMTE9DIGFyZWENCj4gPiA+IDQuIEtlcm5lbCBhcmVhIChUaGlzIGlzIGhpZ2hl
c3QgYXJlYSBhbmQgc3RhcnRzIGF0IFBBR0VfT0ZGU0VUKQ0KPiA+ID4gDQo+ID4gPiBUaGUgbWF4
aW11bSBzaXplIG9mIHVzZXIgc3BhY2UgYXJlYWQgaXMgcmVwcmVzZW50ZWQgYnkgVEFTS19TSVpF
Lg0KPiA+ID4gDQo+ID4gPiBPbiBSVjMyIHN5c3RlbXMsIFRBU0tfU0laRSBpcyBkZWZpbmVkIGFz
IFZNQUxMT0NfU1RBUlQgd2hpY2gNCj4gPiA+IGNhdXNlcyB0aGUNCj4gPiA+IHVzZXIgc3BhY2Ug
YXJlYSB0byBvdmVybGFwIHRoZSBGSVhNQVAgYXJlYS4gVGhpcyBhbGxvd3MgdXNlcg0KPiA+ID4g
c3BhY2UgYXBwcw0KPiA+ID4gdG8gcG90ZW50aWFsbHkgY29ycnVwdCB0aGUgRklYTUFQIGFyZWEg
YW5kIGtlcm5lbCBPRiBBUElzIHdpbGwNCj4gPiA+IGNyYXNoDQo+ID4gPiB3aGVuZXZlciB0aGV5
IGFjY2VzcyBjb3JydXB0ZWQgRkRUIGluIHRoZSBGSVhNQVAgYXJlYS4NCj4gPiA+IA0KPiA+ID4g
T24gUlY2NCBzeXN0ZW1zLCBUQVNLX1NJWkUgaXMgc2V0IHRvIGZpeGVkIDI1NkdCIGFuZCBubyBv
dGhlcg0KPiA+ID4gYXJlYXMNCj4gPiA+IGhhcHBlbiB0byBvdmVybGFwIHNvIHdlIGRvbid0IHNl
ZSBhbnkgRklYTUFQIGFyZWEgY29ycnVwdGlvbnMuDQo+ID4gPiANCj4gPiA+IFRoaXMgcGF0Y2gg
Zml4ZXMgRklYTUFQIGFyZWEgY29ycnVwdGlvbiBvbiBSVjMyIHN5c3RlbXMgYnkNCj4gPiA+IHNl
dHRpbmcNCj4gPiA+IFRBU0tfU0laRSB0byBGSVhBRERSX1NUQVJULg0KPiA+IA0KPiA+IFRoaXMg
cGFydCAtLSB0aGUgVEFTS19TSVpFIGNoYW5nZSAtLSBtYWtlcyBzZW5zZSB0byBtZS4NCj4gPiAN
Cj4gPiBIb3dldmVyLCB0aGUgcGF0Y2ggYWxzbyBjaGFuZ2VzIEZJWEFERFJfU0laRSB0byBiZSBk
ZWZpbmVkIGluIHRlcm1zDQo+ID4gb2YNCj4gPiBwYWdlIHRhYmxlLXJlbGF0ZWQgY29uc3RhbnRz
LiAgUHJldmlvdXNseSwgRklYQUREUl9TSVpFIHdhcyBiYXNlZA0KPiA+IG9uDQo+ID4gX19lbmRf
b2ZfZml4ZWRfYWRkcmVzc2VzLCBhcyBpdCBpcyBmb3IgbW9zdCBvdGhlciBhcmNoaXRlY3R1cmVz
Lg0KPiA+IFRoZSBwYXJ0DQo+ID4gb2YgdGhlIHBhdGNoIHRoYXQgY2hhbmdlcyBGSVhBRERSX1NJ
WkUgc2VlbXMgdW5yZWxhdGVkIHRvIHRoZQ0KPiA+IGFjdHVhbCBmaXguDQo+ID4gDQo+ID4gSWYg
dGhhdCdzIGluZGVlZCB0aGUgY2FzZSAtLSB0aGF0IHRoZSBjaGFuZ2UgdG8gRklYQUREUl9TSVpF
IGlzDQo+ID4gdW5yZWxhdGVkDQo+ID4gZnJvbSB0aGUgZml4IC0tIGNvdWxkIHlvdSBwbGVhc2Ug
c3BsaXQgdGhhdCBpbnRvIGEgc2VwYXJhdGUgcGF0Y2gsDQo+ID4gd2l0aCBhDQo+ID4gZGVzY3Jp
cHRpb24gb2YgdGhlIHJhdGlvbmFsZT8gIEkgdGhpbmsgSSB1bmRlcnN0YW5kIHdoeSB5b3UncmUN
Cj4gPiBwcm9wb3NpbmcNCj4gPiBpdCwgYnV0IGl0IHNlZW1zIG9kZCB0byBleHBsaWNpdGx5IGNv
bm5lY3QgaXQgdG8gcGFnZSB0YWJsZS1yZWxhdGVkDQo+ID4gY29uc3RhbnRzLCByYXRoZXIgdGhh
biB0aGUgY29udGVudHMgb2YgImVudW0gZml4ZWRfYWRkcmVzc2VzIiwgYW5kDQo+ID4gSSdtDQo+
ID4gcmVsdWN0YW50IHRvIG1lcmdlIHRoYXQgcGFydCBvZiB0aGlzIHBhdGNoIHdpdGhvdXQgYSBi
aXQgbW9yZQ0KPiA+IGRpc2N1c3Npb24uDQo+IA0KPiBUaGUgRklYQUREUl9TSVpFIGNoYW5nZSBp
cyByZWxhdGVkIHRvIHRoZSBUQVNLX1NJWkUgcmVxdWlyZW1lbnQgYW5kDQo+IGl0IGlzIG5vdCBh
IHNlcGFyYXRlIGNoYW5nZSBiZWNhdXNlOg0KPiANCj4gMS4gVEFTS19TSVpFIG11c3QgYmUgZXZl
bmx5IGRpdmlzaWJsZSBieSBQR0RJUl9TSVpFLiBUaGUNCj4gRklYQUREUl9TVEFSVA0KPiBpcyBk
ZWZpbmVkIGFzIChGSVhBRERSX1RPUCAtIEZJWEFERFJfU0laRSkuIFRoZSBvcmlnaW5hbCBGSVhB
RERSX1NJWkUNCj4gZGVmaW5lZCBpbi10ZXJtcyBvZiBfX2VuZF9vZl9maXhlZF9hZGRyZXNzZXMg
aXMgbm90IGEgbXVsdGlwbGUgb2YNCj4gUEdESVJfU0laRQ0KPiBoZW5jZSBpdCBtYWtlcyBzZW5z
ZSB0byBtYWtlIEZJWEFERFJfU0laRSBhcyBQR0RJUl9TSVpFLg0KPiANCj4gMi4gTGV0IHNheSB3
ZSBpZ25vcmUgcG9pbnQxIGFib3ZlIHRoZW4gc3RpbGwgd2UgY2Fubm90IGNvbnRpbnVlIHRvDQo+
IGV4cHJlc3MNCj4gRklYQUREUl9TSVpFIGluLXRlcm1zIG9mIF9fZW5kX29mX2ZpeGVkX2FkZHJl
c3NlcyBiZWNhdXNlIG9mIGN5Y2xpYw0KPiBoZWFkZXIgZGVwZW5kZW5jeSB3aGVyZSBhc20vZml4
bWFwLmggaW5jbHVkZXMgYXNtL3BndGFibGUuaCBhbmQNCj4gX19lbmRfb2ZfZml4ZWRfYWRkcmVz
c2VzIGlzIGRlZmluZWQgaW4gYXNtL2ZpeG1hcC5oLiBXZSBjZXJ0YWlubHkNCj4gbmVlZA0KPiB0
byBtb3ZlIEZJWEFERFJfVE9QLCBGSVhBRERSX1NUQVJULCBhbmQgRklYQUREUl9TSVpFIHRvDQo+
IGFzbS9wZ3RhYmxlLmggc28gdGhhdCB3ZSBjYW4gZXhwcmVzcyBUQVNLX1NJWkUgYXMgRklYQURE
Ul9TVEFSVA0KPiBmb3IgUlYzMi4gSWYgd2UgZG9uJ3Qgc2ltcGxpZnkgRklYQUREUl9TSVpFIHRo
ZW4gaXQgd2lsbCByZXN1bHQgaW4NCj4gY29tcGlsZQ0KPiBlcnJvcnMuDQoNClBpbmchDQoNCkFy
ZSB3ZSBnb2luZyB0byByZWdyZXNzIDMyLWJpdCBzdXBwb3J0IGluIDUuMz8NCg0KQWxpc3RhaXIN
Cg0KPiANCj4gUmVnYXJkcywNCj4gQW51cA0KPiANCj4gPiANCj4gPiA+IFdlIGFsc28gbW92ZSBG
SVhBRERSX1RPUCwgRklYQUREUl9TSVpFLCBhbmQgRklYQUREUl9TVEFSVCBkZWZpbmVzDQo+ID4g
PiB0bw0KPiA+ID4gYXNtL3BndGFibGUuaCBzbyB0aGF0IHdlIGNhbiBhdm9pZCBjeWNsaWMgaGVh
ZGVyIGluY2x1ZGVzLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbnVwIFBhdGVsIDxh
bnVwLnBhdGVsQHdkYy5jb20+DQo+ID4gPiBUZXN0ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFs
aXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCj4gPiA+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVs
bHdpZyA8aGNoQGxzdC5kZT4NCj4gPiA+IC0tLQ0KPiA+ID4gQ2hhbmdlcyBzaW5jZSB2MToNCj4g
PiA+IC0gRHJvcCBicmFjZXMgZnJvbSAiI2RlZmluZSBGSVhBRERSX1RPUCINCj4gPiA+IC0tLQ0K
PiA+ID4gIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vZml4bWFwLmggIHwgIDQgLS0tLQ0KPiA+ID4g
IGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vcGd0YWJsZS5oIHwgMTIgKysrKysrKysrKy0tDQo+ID4g
PiAgMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+
ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9maXhtYXAuaA0K
PiA+ID4gYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2ZpeG1hcC5oDQo+ID4gPiBpbmRleCA5YzY2
MDMzYzNhNTQuLjE2MWYyOGQwNGEwNyAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gvcmlzY3YvaW5j
bHVkZS9hc20vZml4bWFwLmgNCj4gPiA+ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vZml4
bWFwLmgNCj4gPiA+IEBAIC0zMCwxMCArMzAsNiBAQCBlbnVtIGZpeGVkX2FkZHJlc3NlcyB7DQo+
ID4gPiAgICAgICBfX2VuZF9vZl9maXhlZF9hZGRyZXNzZXMNCj4gPiA+ICB9Ow0KPiA+ID4gDQo+
ID4gPiAtI2RlZmluZSBGSVhBRERSX1NJWkUgICAgICAgICAoX19lbmRfb2ZfZml4ZWRfYWRkcmVz
c2VzICoNCj4gPiA+IFBBR0VfU0laRSkNCj4gPiA+IC0jZGVmaW5lIEZJWEFERFJfVE9QICAgICAg
ICAgIChWTUFMTE9DX1NUQVJUKQ0KPiA+ID4gLSNkZWZpbmUgRklYQUREUl9TVEFSVCAgICAgICAg
ICAgICAgICAoRklYQUREUl9UT1AgLQ0KPiA+ID4gRklYQUREUl9TSVpFKQ0KPiA+ID4gLQ0KPiA+
ID4gICNkZWZpbmUgRklYTUFQX1BBR0VfSU8gICAgICAgICAgICAgICBQQUdFX0tFUk5FTA0KPiA+
ID4gDQo+ID4gPiAgI2RlZmluZSBfX2Vhcmx5X3NldF9maXhtYXAgICBfX3NldF9maXhtYXANCj4g
PiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3BndGFibGUuaA0KPiA+ID4g
Yi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3BndGFibGUuaA0KPiA+ID4gaW5kZXggYTM2NGFiYTIz
ZDU1Li5jMjRhMDgzYjNlMTIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9hcmNoL3Jpc2N2L2luY2x1ZGUv
YXNtL3BndGFibGUuaA0KPiA+ID4gKysrIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9wZ3RhYmxl
LmgNCj4gPiA+IEBAIC00MjAsMTQgKzQyMCwyMiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcGd0YWJs
ZV9jYWNoZV9pbml0KHZvaWQpDQo+ID4gPiAgI2RlZmluZSBWTUFMTE9DX0VORCAgICAgIChQQUdF
X09GRlNFVCAtIDEpDQo+ID4gPiAgI2RlZmluZSBWTUFMTE9DX1NUQVJUICAgIChQQUdFX09GRlNF
VCAtIFZNQUxMT0NfU0laRSkNCj4gPiA+IA0KPiA+ID4gKyNkZWZpbmUgRklYQUREUl9UT1AgICAg
ICBWTUFMTE9DX1NUQVJUDQo+ID4gPiArI2lmZGVmIENPTkZJR182NEJJVA0KPiA+ID4gKyNkZWZp
bmUgRklYQUREUl9TSVpFICAgICBQTURfU0laRQ0KPiA+ID4gKyNlbHNlDQo+ID4gPiArI2RlZmlu
ZSBGSVhBRERSX1NJWkUgICAgIFBHRElSX1NJWkUNCj4gPiA+ICsjZW5kaWYNCj4gPiA+ICsjZGVm
aW5lIEZJWEFERFJfU1RBUlQgICAgKEZJWEFERFJfVE9QIC0gRklYQUREUl9TSVpFKQ0KPiA+ID4g
Kw0KPiA+ID4gIC8qDQo+ID4gPiAtICogVGFzayBzaXplIGlzIDB4NDAwMDAwMDAwMCBmb3IgUlY2
NCBvciAweGI4MDAwMDAgZm9yIFJWMzIuDQo+ID4gPiArICogVGFzayBzaXplIGlzIDB4NDAwMDAw
MDAwMCBmb3IgUlY2NCBvciAweDlmYzAwMDAwIGZvciBSVjMyLg0KPiA+ID4gICAqIE5vdGUgdGhh
dCBQR0RJUl9TSVpFIG11c3QgZXZlbmx5IGRpdmlkZSBUQVNLX1NJWkUuDQo+ID4gPiAgICovDQo+
ID4gPiAgI2lmZGVmIENPTkZJR182NEJJVA0KPiA+ID4gICNkZWZpbmUgVEFTS19TSVpFIChQR0RJ
Ul9TSVpFICogUFRSU19QRVJfUEdEIC8gMikNCj4gPiA+ICAjZWxzZQ0KPiA+ID4gLSNkZWZpbmUg
VEFTS19TSVpFIFZNQUxMT0NfU1RBUlQNCj4gPiA+ICsjZGVmaW5lIFRBU0tfU0laRSBGSVhBRERS
X1NUQVJUDQo+ID4gPiAgI2VuZGlmDQo+ID4gPiANCj4gPiA+ICAjaW5jbHVkZSA8YXNtLWdlbmVy
aWMvcGd0YWJsZS5oPg0KPiA+ID4gLS0NCj4gPiA+IDIuMTcuMQ0KPiA+ID4gDQo+ID4gDQo+ID4g
LSBQYXVsDQo=
