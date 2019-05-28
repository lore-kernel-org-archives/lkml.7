Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49D9C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504092075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Oi3G7FSK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="z8QS2d/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfE1KfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:35:00 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44144 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfE1Ke7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559039727; x=1590575727;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XD4U6WNdMeLazvZiIYF9pNzBdkd00ZyjcdAzAXku1rg=;
  b=Oi3G7FSKsN1KXlrF3Gzlm4Bokem9VNADvCfsgpg95E9gS0RIR2gQv2sv
   zkG0zea0ZrCb0EcQS7JxVQNoSi/tAV+W+OdEvONRtw+a26jS2r9iUxKjP
   8MnwkRpYqzEhK/0cCMtnqKCDe0I77QniWGPal4LsXdXETP6bsoxzGPWmw
   CrsK3tLkwusTtWAZAEzg33VgcDBr80X+KqUN3oKJyyv9IjDbFpEZaU9to
   8Syf3dGOct2Z+SQYyUW8JR1UfQ9AhgDL9BvYmSKFCKQSGiCsWwcxxVe05
   5HOKDIc7CLjGFmwrR6vfdWf1DacqbKq0B0GrZXCAljf0IOMVaeOSRJn0o
   w==;
X-IronPort-AV: E=Sophos;i="5.60,521,1549900800"; 
   d="scan'208";a="208761731"
Received: from mail-dm3nam03lp2058.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.58])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2019 18:35:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XD4U6WNdMeLazvZiIYF9pNzBdkd00ZyjcdAzAXku1rg=;
 b=z8QS2d/zl6m9fGh0zHGqPsuIwyF3rmpIZwNELfKX8Qc6XjqgY2t8KN1JsUYz07ZXmNECHwwgL5TeuVEUnv3dnr43Vhs7tONOq3R6Wd77R0uYc2JvfpI6lNXCLuWBOj+uGVIPIZqVUine0ZIBN22fUY1bInf0UfUxGeH5WFY9YUQ=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5997.namprd04.prod.outlook.com (20.178.245.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Tue, 28 May 2019 10:34:56 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::98ab:5e60:9c5c:4e0e]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::98ab:5e60:9c5c:4e0e%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 10:34:56 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Karsten Merker <merker@debian.org>
CC:     Troy Benjegerdes <troy.benjegerdes@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Zong Li <zong@andestech.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Subject: RE: [v4 PATCH] RISC-V: Add an Image header that boot loader can
 parse.
Thread-Topic: [v4 PATCH] RISC-V: Add an Image header that boot loader can
 parse.
Thread-Index: AQHVEefPx78xcsUKv0KnMjJBKgt9jaZ/DuaAgACA6ICAABe4gIAARRCggABMrICAAB37sA==
Date:   Tue, 28 May 2019 10:34:56 +0000
Message-ID: <MN2PR04MB6061590CE56092CB79D96AA48D1E0@MN2PR04MB6061.namprd04.prod.outlook.com>
References: <20190524041814.7497-1-atish.patra@wdc.com>
 <CAKv+Gu9U56b50TrfriBfRFed_1aoXg2Y624tu7v5m2y+6DVq5w@mail.gmail.com>
 <20190527221619.fkxtzk4jpeyfoptf@excalibur.cnev.de>
 <3178D175-18AD-47D0-8D51-CB2900DFA572@sifive.com>
 <MN2PR04MB60610CF4829D5251A112CF9C8D1E0@MN2PR04MB6061.namprd04.prod.outlook.com>
 <20190528082248.awjwbz44lp6ak3m3@excalibur.cnev.de>
In-Reply-To: <20190528082248.awjwbz44lp6ak3m3@excalibur.cnev.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-originating-ip: [103.56.183.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13dc0f05-66c1-47c9-d3a3-08d6e3582096
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB5997;
x-ms-traffictypediagnostic: MN2PR04MB5997:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB599778D3806CFEEEEE386C628D1E0@MN2PR04MB5997.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(39860400002)(136003)(376002)(189003)(199004)(13464003)(6246003)(7416002)(76176011)(74316002)(6916009)(14454004)(33656002)(186003)(25786009)(52536014)(305945005)(478600001)(72206003)(26005)(7736002)(256004)(561944003)(14444005)(66066001)(4326008)(71200400001)(71190400001)(486006)(8936002)(81166006)(6116002)(3846002)(99286004)(5660300002)(86362001)(9686003)(55016002)(476003)(6436002)(66946007)(73956011)(53546011)(66476007)(66556008)(6506007)(64756008)(66446008)(102836004)(7696005)(76116006)(446003)(2906002)(316002)(53936002)(8676002)(11346002)(54906003)(229853002)(68736007)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5997;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hXiH6hNnKyhjsH0z+8C/fqfqN40sV49tKMLkYKo9jdMksOwc6VHV8psYOaHjthdcseWurRvIFdpwqBxScjVB09/KABNVrru89n2fDXjo+n3TJ5BKf4EmGuw2wRtxNOl6RwxTjmgv0zQ35S301N+z4ft6pYGjyN4by5Mo8U0Uigl3ampj9XKIDVpfqLQey9mp6X/zT159LHG7uNSr/8PPXHUnrgU3MPClv+5uTETxE5EiCINbJzormUoEepHssXnzUTgs1WDrogypKgNF7irc7hkfm+eygmSVgtVHGFUj8Z+NCE23qfa8/83MuhOPkypkPPt4G6b3OnpLBvuWPhX+oTreN7KrTdS1dtmjMO8Gqe8SJWrCJqmi9FeH1cxY1bL1HwX/jwMpDSJ2bJaxEG9oFLiT5To7do43AuiNH/laeQ4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dc0f05-66c1-47c9-d3a3-08d6e3582096
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 10:34:56.0937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Anup.Patel@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5997
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2Fyc3RlbiBNZXJrZXIg
PG1lcmtlckBkZWJpYW4ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMjgsIDIwMTkgMTo1MyBQ
TQ0KPiBUbzogQW51cCBQYXRlbCA8QW51cC5QYXRlbEB3ZGMuY29tPg0KPiBDYzogVHJveSBCZW5q
ZWdlcmRlcyA8dHJveS5iZW5qZWdlcmRlc0BzaWZpdmUuY29tPjsgS2Fyc3RlbiBNZXJrZXINCj4g
PG1lcmtlckBkZWJpYW4ub3JnPjsgQWxiZXJ0IE91IDxhb3VAZWVjcy5iZXJrZWxleS5lZHU+OyBK
b25hdGhhbg0KPiBDb3JiZXQgPGNvcmJldEBsd24ubmV0PjsgQXJkIEJpZXNoZXV2ZWwgPGFyZC5i
aWVzaGV1dmVsQGxpbmFyby5vcmc+Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIExp
c3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBab25nIExpDQo+IDx6b25nQGFuZGVz
dGVjaC5jb20+OyBBdGlzaCBQYXRyYSA8QXRpc2guUGF0cmFAd2RjLmNvbT47IFBhbG1lcg0KPiBE
YWJiZWx0IDxwYWxtZXJAc2lmaXZlLmNvbT47IHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgTmlj
ayBLb3NzaWZpZGlzDQo+IDxtaWNrQGljcy5mb3J0aC5ncj47IGxpbnV4LXJpc2N2QGxpc3RzLmlu
ZnJhZGVhZC5vcmc7DQo+IG1hcmVrLnZhc3V0QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW3Y0
IFBBVENIXSBSSVNDLVY6IEFkZCBhbiBJbWFnZSBoZWFkZXIgdGhhdCBib290IGxvYWRlciBjYW4N
Cj4gcGFyc2UuDQo+IA0KPiBPbiBUdWUsIE1heSAyOCwgMjAxOSBhdCAwMzo1NDowMkFNICswMDAw
LCBBbnVwIFBhdGVsIHdyb3RlOg0KPiA+ID4gRnJvbTogVHJveSBCZW5qZWdlcmRlcyA8dHJveS5i
ZW5qZWdlcmRlc0BzaWZpdmUuY29tPg0KPiA+ID4gPiBPbiBNYXkgMjcsIDIwMTksIGF0IDU6MTYg
UE0sIEthcnN0ZW4gTWVya2VyIDxtZXJrZXJAZGViaWFuLm9yZz4NCj4gPiA+IHdyb3RlOg0KPiA+
ID4gPg0KPiA+ID4gPiBPbiBNb24sIE1heSAyNywgMjAxOSBhdCAwNDozNDo1N1BNICswMjAwLCBB
cmQgQmllc2hldXZlbCB3cm90ZToNCj4gPiA+ID4+IE9uIEZyaSwgMjQgTWF5IDIwMTkgYXQgMDY6
MTgsIEF0aXNoIFBhdHJhIDxhdGlzaC5wYXRyYUB3ZGMuY29tPg0KPiB3cm90ZToNCj4gPiA+ID4+
PiBDdXJyZW50bHksIHRoZSBsYXN0IHN0YWdlIGJvb3QgbG9hZGVycyBzdWNoIGFzIFUtQm9vdCBj
YW4gYWNjZXB0DQo+ID4gPiA+Pj4gb25seSB1SW1hZ2Ugd2hpY2ggaXMgYW4gdW5uZWNlc3Nhcnkg
YWRkaXRpb25hbCBzdGVwIGluDQo+ID4gPiA+Pj4gYXV0b21hdGluZyBib290IHByb2Nlc3MuDQo+
ID4gPiA+Pj4NCj4gPiA+ID4+PiBBZGQgYW4gaW1hZ2UgaGVhZGVyIHRoYXQgYm9vdCBsb2FkZXIg
dW5kZXJzdGFuZHMgYW5kIGJvb3QgTGludXgNCj4gPiA+ID4+PiBmcm9tIGZsYXQgSW1hZ2UgZGly
ZWN0bHkuDQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiBUaGlzIGhlYWRlciBpcyBiYXNlZCBvbiBBUk02
NCBib290IGltYWdlIGhlYWRlciBhbmQgcHJvdmlkZXMgYW4NCj4gPiA+ID4+PiBvcHBvcnR1bml0
eSB0byBjb21iaW5lIGJvdGggQVJNNjQgJiBSSVNDLVYgaW1hZ2UgaGVhZGVycyBpbg0KPiBmdXR1
cmUuDQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiBBbHNvIG1ha2Ugc3VyZSB0aGF0IFBFL0NPRkYgaGVh
ZGVyIGNhbiBjby1leGlzdCBpbiB0aGUgc2FtZQ0KPiA+ID4gPj4+IGltYWdlIHNvIHRoYXQgRUZJ
IHN0dWIgY2FuIGJlIHN1cHBvcnRlZCBmb3IgUklTQy1WIGluIGZ1dHVyZS4NCj4gPiA+ID4+PiBF
Rkkgc3BlY2lmaWNhdGlvbiBuZWVkcyBQRS9DT0ZGIGltYWdlIGhlYWRlciBpbiB0aGUgYmVnaW5u
aW5nIG9mDQo+ID4gPiA+Pj4gdGhlIGtlcm5lbCBpbWFnZSBpbiBvcmRlciB0byBsb2FkIGl0IGFz
IGFuIEVGSSBhcHBsaWNhdGlvbi4gSW4NCj4gPiA+ID4+PiBvcmRlciB0byBzdXBwb3J0IEVGSSBz
dHViLCBjb2RlMCBzaG91bGQgYmUgcmVwbGFjZWQgd2l0aCAiTVoiDQo+ID4gPiA+Pj4gbWFnaWMg
c3RyaW5nIGFuZCByZXM0KGF0IG9mZnNldCAweDNjKSBzaG91bGQgcG9pbnQgdG8gdGhlIHJlc3QN
Cj4gPiA+ID4+PiBvZiB0aGUgUEUvQ09GRiBoZWFkZXIgKHdoaWNoIHdpbGwgYmUgYWRkZWQgZHVy
aW5nIEVGSSBzdXBwb3J0KS4NCj4gPiA+ID4gWy4uLl0NCj4gPiA+ID4+PiBEb2N1bWVudGF0aW9u
L3Jpc2N2L2Jvb3QtaW1hZ2UtaGVhZGVyLnR4dCB8IDUwDQo+ID4gPiArKysrKysrKysrKysrKysr
KysNCj4gPiA+ID4+PiBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2ltYWdlLmggICAgICAgICAgICB8
IDY0DQo+ICsrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+Pj4gYXJjaC9yaXNjdi9rZXJu
ZWwvaGVhZC5TICAgICAgICAgICAgICAgICAgfCAzMiArKysrKysrKysrKysNCj4gPiA+ID4+PiAz
IGZpbGVzIGNoYW5nZWQsIDE0NiBpbnNlcnRpb25zKCspIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+
ID4gPj4+IERvY3VtZW50YXRpb24vcmlzY3YvYm9vdC1pbWFnZS1oZWFkZXIudHh0DQo+ID4gPiA+
Pj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vaW1hZ2UuaA0KPiA+
ID4gPj4+DQo+ID4gPiA+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vcmlzY3YvYm9vdC1p
bWFnZS1oZWFkZXIudHh0DQo+ID4gPiA+Pj4gYi9Eb2N1bWVudGF0aW9uL3Jpc2N2L2Jvb3QtaW1h
Z2UtaGVhZGVyLnR4dA0KPiA+ID4gPj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiA+Pj4g
aW5kZXggMDAwMDAwMDAwMDAwLi42OGFiYzIzNTNjZWMNCj4gPiA+ID4+PiAtLS0gL2Rldi9udWxs
DQo+ID4gPiA+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9yaXNjdi9ib290LWltYWdlLWhlYWRlci50
eHQNCj4gPiA+ID4+PiBAQCAtMCwwICsxLDUwIEBADQo+ID4gPiA+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBCb290IGltYWdlIGhlYWRlciBpbiBSSVNDLVYNCj4gPiA+ID4+PiAr
IExpbnV4DQo+ID4gPiA+Pj4gKw0KPiA+ID4gPj4+ICsgPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09DQo+ID4gPiA+Pj4gKw0KPiA+ID4gPj4+ICtBdXRob3I6IEF0
aXNoIFBhdHJhIDxhdGlzaC5wYXRyYUB3ZGMuY29tPiBEYXRlICA6IDIwIE1heSAyMDE5DQo+ID4g
PiA+Pj4gKw0KPiA+ID4gPj4+ICtUaGlzIGRvY3VtZW50IG9ubHkgZGVzY3JpYmVzIHRoZSBib290
IGltYWdlIGhlYWRlciBkZXRhaWxzIGZvcg0KPiA+ID4gPj4+ICtSSVNDLVYNCj4gPiA+IExpbnV4
Lg0KPiA+ID4gPj4+ICtUaGUgY29tcGxldGUgYm9vdGluZyBndWlkZSB3aWxsIGJlIGF2YWlsYWJs
ZSBhdA0KPiA+ID4gRG9jdW1lbnRhdGlvbi9yaXNjdi9ib290aW5nLnR4dC4NCj4gPiA+ID4+PiAr
DQo+ID4gPiA+Pj4gK1RoZSBmb2xsb3dpbmcgNjQtYnl0ZSBoZWFkZXIgaXMgcHJlc2VudCBpbiBk
ZWNvbXByZXNzZWQgTGludXgNCj4gPiA+ID4+PiAra2VybmVsDQo+ID4gPiBpbWFnZS4NCj4gPiA+
ID4+PiArDQo+ID4gPiA+Pj4gKyAgICAgICB1MzIgY29kZTA7ICAgICAgICAgICAgICAgIC8qIEV4
ZWN1dGFibGUgY29kZSAqLw0KPiA+ID4gPj4+ICsgICAgICAgdTMyIGNvZGUxOyAgICAgICAgICAg
ICAgICAvKiBFeGVjdXRhYmxlIGNvZGUgKi8NCj4gPiA+ID4+DQo+ID4gPiA+PiBBcG9sb2dpZXMg
Zm9yIG5vdCBtZW50aW9uaW5nIHRoaXMgaW4gbXkgcHJldmlvdXMgcmVwbHksIGJ1dCBnaXZlbg0K
PiA+ID4gPj4gdGhhdCB5b3UgYWxyZWFkeSBrbm93IHRoYXQgeW91IHdpbGwgbmVlZCB0byBwdXQg
dGhlIG1hZ2ljIHN0cmluZw0KPiA+ID4gPj4gTVogYXQgb2Zmc2V0IDB4MCwgaXQgbWFrZXMgbW9y
ZSBzZW5zZSB0byBub3QgcHV0IGFueSBjb2RlIHRoZXJlDQo+ID4gPiA+PiBhdCBhbGwsIGJ1dCBl
ZHVjYXRlIHRoZSBib290bG9hZGVyIHRoYXQgdGhlIGZpcnN0IGV4ZWN1dGFibGUNCj4gPiA+ID4+
IGluc3RydWN0aW9uIGlzIGF0IG9mZnNldCAweDIwLCBhbmQgcHV0IHRoZSBzcGFyZSBmaWVsZHMg
cmlnaHQNCj4gPiA+ID4+IGFmdGVyIGl0IGluIGNhc2UgeW91IGV2ZXIgbmVlZCBtb3JlIHRoYW4g
MiBzbG90cy4gKE9uIGFybTY0LCB3ZQ0KPiA+ID4gPj4gd2VyZSBsdWNreSB0byBiZSBhYmxlIHRv
IGZpbmQgYW4gb3Bjb2RlIHRoYXQgaGFwcGVuZWQgdG8gY29udGFpbg0KPiA+ID4gPj4gdGhlIE1a
IGJpdCBwYXR0ZXJuIGFuZCBhY3QgYWxtb3N0IGxpa2UgYSBOT1AsIGJ1dCBpdCBzZWVtcyBzaWxs
eQ0KPiA+ID4gPj4gdG8gcmVseSBvbiB0aGF0IGZvciBSSVNDLVYgYXMNCj4gPiA+ID4+IHdlbGwp
DQo+ID4gPiA+Pg0KPiA+ID4gPj4gU28gc29tZXRoaW5nIGxpa2UNCj4gPiA+ID4+DQo+ID4gPiA+
PiB1MTYgcGVfcmVzMTsgIC8qIE1aIGZvciBFRkkgYm9vdGFibGUgaW1hZ2VzLCBkb24ndCBjYXJl
IG90aGVyd2lzZSAqLw0KPiA+ID4gPj4gdTggbWFnaWNbNl07ICAgIC8qICJSSVNDVlwwIg0KPiA+
ID4gPj4NCj4gPiA+ID4+IHU2NCB0ZXh0X29mZnNldDsgICAgICAgICAgLyogSW1hZ2UgbG9hZCBv
ZmZzZXQsIGxpdHRsZSBlbmRpYW4gKi8NCj4gPiA+ID4+IHU2NCBpbWFnZV9zaXplOyAgICAgICAg
ICAgLyogRWZmZWN0aXZlIEltYWdlIHNpemUsIGxpdHRsZSBlbmRpYW4gKi8NCj4gPiA+ID4+IHU2
NCBmbGFnczsgICAgICAgICAgICAgICAgLyoga2VybmVsIGZsYWdzLCBsaXR0bGUgZW5kaWFuICov
DQo+ID4gPiA+Pg0KPiA+ID4gPj4gdTMyIGNvZGUwOyAgICAgICAgICAgICAgICAvKiBFeGVjdXRh
YmxlIGNvZGUgKi8NCj4gPiA+ID4+IHUzMiBjb2RlMTsgICAgICAgICAgICAgICAgLyogRXhlY3V0
YWJsZSBjb2RlICovDQo+ID4gPiA+Pg0KPiA+ID4gPj4gdTY0IHJlc2VydmVkWzJdOyAgICAgLyog
cmVzZXJ2ZWQgZm9yIGZ1dHVyZSB1c2UgKi8NCj4gPiA+ID4+DQo+ID4gPiA+PiB1MzIgdmVyc2lv
bjsgICAgICAgICAgICAgIC8qIFZlcnNpb24gb2YgdGhpcyBoZWFkZXIgKi8NCj4gPiA+ID4+IHUz
MiBwZV9yZXMyOyAgICAgICAgICAgICAgICAgLyogUmVzZXJ2ZWQgZm9yIFBFIENPRkYgb2Zmc2V0
ICovDQo+ID4gPiA+DQo+ID4gPiA+IEhlbGxvLA0KPiA+ID4gPg0KPiA+ID4gPiB3b3VsZG4ndCB0
aGF0IGltbWVkaWF0ZWx5IGJyZWFrIGV4aXN0aW5nIHN5c3RlbXMgKGluY2x1ZGluZyBxZW11DQo+
ID4gPiA+IHdoZW4gbG9hZGluZyBrZXJuZWxzIHdpdGggdGhlICIta2VybmVsIiBvcHRpb24pIHRo
YXQgcmVseSBvbiB0aGUNCj4gPiA+ID4gZmFjdCB0aGF0IHRoZSBrZXJuZWwgZW50cnkgcG9pbnQg
aXMgYWx3YXlzIGF0IHRoZSBrZXJuZWwgbG9hZA0KPiA+ID4gPiBhZGRyZXNzPyAgVGhlDQo+ID4g
PiA+IEFSTTY0IGhlYWRlciBhbmQgQXRpc2gncyBvcmlnaW5hbCBSSVNDLVYgcHJvcG9zYWwgYmFz
ZWQgb24gdGhlDQo+ID4gPiA+IEFSTTY0IGhlYWRlciBrZWVwIHRoZSBwcm9wZXJ0eSB0aGF0IGp1
bXBpbmcgdG8gdGhlIGtlcm5lbCBsb2FkDQo+ID4gPiA+IGFkZHJlc3MgYWx3YXlzIHdvcmtzLCBy
ZWdhcmRsZXNzIG9mIHdoYXQgdGhlIHBhcnRpY3VsYXIgaGVhZGVyDQo+ID4gPiA+IGxvb2tzIGxp
a2UgYW5kIHdoaWNoIHBvdGVudGlhbCBmdXR1cmUgZXh0ZW5zaW9ucyBpdCBpbmNsdWRlcywgYnV0
DQo+ID4gPiA+IHRoZSBwcm9wb3NlZCBjaGFuZ2UgYWJvdmUgd291bGRuJ3QgZG8gdGhhdC4NCj4g
PiA+ID4NCj4gPiA+ID4gQWx0aG91Z2ggSSBhZ3JlZSB0aGF0IGhhdmluZyB0byBpbnRlZ3JhdGUg
dGhlICJNWiIgc3RyaW5nIGFzIGFuDQo+ID4gPiA+IGluc3RydWN0aW9uIGlzbid0IHBhcnRpY3Vs
YXJseSBuaWNlLCBJIGRvbid0IHRoaW5rIHRoYXQgdGhpcyBpcyBhDQo+ID4gPiA+IHN1ZmZpY2ll
bnQganVzdGlmaWNhdGlvbiBmb3IgYnJlYWtpbmcgY29tcGF0aWJpbGl0eSB3aXRoIHByaW9yDQo+
ID4gPiA+IGtlcm5lbCByZWxlYXNlcyBhbmQvb3IgZXhpc3RpbmcgYm9vdCBmaXJtd2FyZS4gIE9u
IFJJU0MtViwgdGhlDQo+ID4gPiA+ICJNWiIgc3RyaW5nIGlzIGEgY29tcHJlc3NlZCBsb2FkIGlt
bWVkaWF0ZSB0byB4MjAvczQsIGkuZS4gYW4NCj4gPiA+ID4gaW5zdHJ1Y3Rpb24gdGhhdCBzaG91
bGQgYmUgImhhcm1sZXNzIiBhcyBmYXIgYXMgdGhlIGtlcm5lbCBib290DQo+ID4gPiA+IGZsb3cg
aXMgY29uY2VybmVkIGFzIHRoZQ0KPiA+ID4gPiB4MjAvczQgcmVnaXN0ZXIgQUZBSUsgZG9lc24n
dCBjb250YWluIGFueSBpbmZvcm1hdGlvbiB0aGF0IHRoZQ0KPiA+ID4gPiBrZXJuZWwgd291bGQg
dXNlLg0KPiA+ID4gPg0KPiA+ID4gPiBSZWdhcmRzLA0KPiA+ID4gPiBLYXJzdGVuDQo+ID4gPiA+
DQo+ID4gPg0KPiA+ID4gWWVzLCB0aGF0IHdvdWxkIGJyZWFrIGV4aXN0aW5nIHN5c3RlbXMuIEJl
c2lkZXMsIHRoZSBxZW11IC1rZXJuZWwNCj4gPiA+IG9wdGlvbiB1c2VzIHRoZSB2bWxpbnV4IGVs
ZiBmaWxlLCBhbmQgSSB0aGluayBhIGJldHRlciBzb2x1dGlvbiBpcw0KPiA+ID4gbWFrZSDigJhs
b2FkZWxm4oCZIHdvcmssIGFuZCBpbmNsdWRlIGEgc2Vjb25kIG1ldGhvZCBmb3IgRUZJLg0KPiA+
ID4NCj4gPiA+ICh1bmZvcnR1bmF0ZWx5LCBJIGhhZCB0byBkcm9wIHNvbWUgbGlzdHMgYXMgSeKA
mW0gaGF2aW5nIHRyb3VibGUNCj4gPiA+IHNlbmRpbmcgdG8gdGhlbSB2aWEgZ21haWwsIHNvIHRo
ZSBDQyBsaXN0IG9uIG15IHJlc3BvbnNlIGhhcyBiZWVuDQo+ID4gPiBsaW1pdGVkKQ0KPiA+DQo+
ID4gTm9wZXMsIGl0IHdvcmtzIHBlcmZlY3RseSBmaW5lIG9uIFFFTVUgUklTQy1WLg0KPiA+DQo+
ID4gSnVzdCBsaWtlIEFSTTY0LCB3ZSBhcmUgbHVja3kgZm9yIFJJU0MtViBhcyB3ZWxsLiBUaGUg
Ik1aIiBzdHJpbmcgaXMgYQ0KPiA+IGhhcm1sZXNzIGxvYWQgaW5zdHJ1Y3Rpb24gaW4gUklTQy1W
IHNvIHdlIGRvbid0IG5lZWQgYW55IGNoYW5nZXMgaW4gUUVNVS4NCj4gDQo+IEhlbGxvLA0KPiAN
Cj4ganVzdCB0byBhdm9pZCBtaXN1bmRlcnN0YW5kaW5nczogQXRpc2gsIGRvZXMgeW91ciAiTm9w
ZXMsIGl0IHdvcmtzIHBlcmZlY3RseQ0KPiBmaW5lIG9uIFFFTVUgUklTQy1WIiByZWZlciB0byB5
b3VyIG9yaWdpbmFsIGhlYWRlciBwcm9wb3NhbCBvciB0byBBcmQncw0KPiBtb2RpZmllZCBoZWFk
ZXIgcHJvcG9zYWw/ICBGb3IgeW91ciBwcm9wb3NhbCBJIGFncmVlIHRoYXQgaXQgd29ya3Mgd2l0
aG91dA0KDQpTb3JyeSBmb3IgdGhlIGNvbmZ1c2lvbi4gSSBtZWFudCBoZXJlIHRoYXQgYWRkaW5n
ICJNWiIgYXQgc3RhcnQgaW4gQXRpc2gncw0KcHJvcG9zZWQgaGVhZGVyIHdvcmtzIGZpbmUgb24g
UUVNVS4NCg0KPiBwcm9ibGVtcyBpbiBhbGwgY2FzZXMgdGhhdCBoYXZlIHdvcmtlZCBiZWZvcmUg
aW50cm9kdWN0aW9uIG9mIHRoZSBoZWFkZXIsDQo+IGkuZS4gYWRkaW5nIHlvdXIgcHJvcG9zZWQg
aGVhZGVyIGlzIGNvbXBsZXRlbHkgdHJhbnNwYXJlbnQsIGJ1dCBhcyBkZXNjcmliZWQNCj4gYWJv
dmUgSSBoYXZlIGRvdWJ0cyB0aGF0IHRoZSBzYW1lIGlzIHRydWUgZm9yIHRoZSAoZGlmZmVyZW50
KSBoZWFkZXIgZm9ybWF0DQo+IHRoYXQgQXJkIGhhcyBwcm9wb3NlZCBhYm92ZS4NCg0KWWVzLCBB
cmQncyBwcm9wb3NlZCBoZWFkZXIgd2lsbCBicmVhayBib290aW5nIG9uIGN1cnJlbnQgUUVNVSBh
bmQNCmV4aXN0aW5nIEhXLiBJIHRoaW5rIEFyZCdzIHByb3Bvc2VkIGhlYWRlciB3YXMgdG8gYWRk
cmVzcyB0aGUgY2FzZSBpZg0KIk1aIiB3YXMgbm90IGEgdmFsaWQgYW5kIGhhcm1sZXNzIGluc3Ry
dWN0aW9uIGluIFJJU0MtVi4gT3RoZXIgdGhhbg0KdGhhdCBBcmQncyBwcm9wb3NhbCBpcyBzaW1p
bGFyIHRvIEF0aXNoJ3MgcHJvcG9zYWwgYnV0IG9yZ2FuaXplZCBkaWZmZXJlbnRseS4NCg0KRm9y
IEF0aXNoJ3MgcHJvcG9zZWQgaGVhZGVyLCB3ZSBhcmUgY2VydGFpbmx5IHJlbHlpbmcgb24gdGhl
IGZhY3QgdGhhdA0KIk1aIiByZXByZXNlbnRzIGEgdmFsaWQgYW5kIGhhcm1sZXNzIGluc3RydWN0
aW9uIChqdXN0IGxpa2UgQVJNNjQpIGJ1dA0KdGhpcyBhcHByb2FjaCBpcyBhbGxvd2luZyB1cyB0
byBib290IExpbnV4IFJJU0MtViBrZXJuZWwgd2l0aG91dCBicmVha2luZw0KZXhpc3RpbmcgYm9v
dGluZyBtZXRob2RzLg0KDQpSZWdhcmRzLA0KQW51cA0K
