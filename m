Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A52C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5799C206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="k8i7AO9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfF1IXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:23:24 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:29592 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfF1IXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:23:23 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,427,1557212400"; 
   d="scan'208";a="36241967"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2019 01:23:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 28 Jun 2019 01:23:17 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 28 Jun 2019 01:23:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=r3JFNbwLjG8BwBKha+IVuCxhZ2ghTB99SBaH993dl/nK6Xvi8oa+MzkSB+2J6GJK4wxXfzgzIZanUUXtQqCd0DOLkQy0/yNyvIeHJDhzSa6q4nnIXf5sJ4MfAs7tkY96Y44xqN10qeD+cGq9KCllxr8ki/1wG2hc0yWonMHnxP0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rv6BKJrQ/6eOJX8IyxQAdXhf27M7XATw+FdycBHLYbs=;
 b=q6m5NmbOQFdt9AZZMXScXrBdyxfjt8UurOOp6/iRVOzBN1Vv99hub/YL42P2aXjVnCWF+Jv6DJKoC2pkTzmQVUAqWr3W6X/NBthnrdoP0SFeKjJa4HVx8RnoR85g9YCUxO/PJ08Cl9Hf9QksdJRDtWI+WP3jAT9fWspqhlHrGxA=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rv6BKJrQ/6eOJX8IyxQAdXhf27M7XATw+FdycBHLYbs=;
 b=k8i7AO9bnhFcV59IAVN7PC24uj5SF9o85CAijesaFrdqc5OV1PI2hAjbLD6kCGQ4+g8Eqsej76EZNuiQ02iAWOx3BctuUijVGkX/5s77SnsqyyUmDtRYU56pUBE0KOB+VyC0XXzu00eBVaOR0RecLxXmmr77UnGBrmXjs2sdr9E=
Received: from DM5PR11MB1850.namprd11.prod.outlook.com (10.175.91.11) by
 DM5PR11MB1402.namprd11.prod.outlook.com (10.168.101.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 08:23:16 +0000
Received: from DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::5025:6c13:b07d:501e]) by DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::5025:6c13:b07d:501e%6]) with mapi id 15.20.2008.017; Fri, 28 Jun 2019
 08:23:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <dinguyen@kernel.org>, <linux-mtd@lists.infradead.org>
CC:     <marex@denx.de>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <tien.fong.chee@intel.com>
Subject: Re: [PATCHv6 2/2] mtd: spi-nor: cadence-quadspi: add reset control
Thread-Topic: [PATCHv6 2/2] mtd: spi-nor: cadence-quadspi: add reset control
Thread-Index: AQHVIdur3cT5P1lXJ0SybjCFjOpNoKaw0bWA
Date:   Fri, 28 Jun 2019 08:23:16 +0000
Message-ID: <3d592ca2-65c6-892e-6b7b-bf2cf0495386@microchip.com>
References: <20190613113138.8280-1-dinguyen@kernel.org>
 <20190613113138.8280-2-dinguyen@kernel.org>
In-Reply-To: <20190613113138.8280-2-dinguyen@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0190.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::14) To DM5PR11MB1850.namprd11.prod.outlook.com
 (2603:10b6:3:112::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c16e11a-22a2-4f0c-e3fc-08d6fba1de84
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR11MB1402;
x-ms-traffictypediagnostic: DM5PR11MB1402:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM5PR11MB14025F22D806DDF9AD7AE82DF0FC0@DM5PR11MB1402.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(346002)(366004)(396003)(199004)(189003)(31696002)(6506007)(31686004)(2616005)(476003)(486006)(386003)(316002)(102836004)(53546011)(53936002)(6486002)(14454004)(54906003)(6512007)(99286004)(110136005)(76176011)(229853002)(446003)(6246003)(7736002)(11346002)(36756003)(256004)(52116002)(8936002)(8676002)(81156014)(81166006)(6306002)(2501003)(6436002)(68736007)(14444005)(66066001)(72206003)(86362001)(186003)(305945005)(25786009)(5660300002)(66556008)(71190400001)(71200400001)(64756008)(66946007)(73956011)(26005)(4326008)(2906002)(66446008)(3846002)(66476007)(6116002)(478600001)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1402;H:DM5PR11MB1850.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XMlaqP9bnxE0K0HO1MT5xNG6Noh6DfxAY1ak6aHTCeteZQiF5dYpNZyAG8TtmJs8L4sQPQ65M9ofcYAbi/UeGwo7KSkNesrWBjPnyXEINvqU3rFgeyfqyufKNe8lzHj1jwi//ceGNNorPisMNA87j3zGaAFLh5q8u1lC79fc8iGdiTm54MjTeNJlz5a5UL53OUsgG6RwyZnHeBwN6FuCaNwxK5IsYLXc26AyNKawn3+WRu42grCGsiHdFRijlHYUJCpSMF8v9v1oF3qQzmzO2QdI7bhKNTjzdeagFUpqm0l/9JkeOimZeUzPz+qsgOLrE01NOz23ktiVQGiTiudVRi4t9otEiRbSzjtU2O1va62M4fKii+u2jd+e3dtE4roWNzFjmdTu41L8LuiNYMpLOh6r2x7eGwZrexZ+siPnzgk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07CCCC1F5D7AEB46A69D1BBE2EF74AA6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c16e11a-22a2-4f0c-e3fc-08d6fba1de84
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 08:23:16.5845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1402
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA2LzEzLzIwMTkgMDI6MzEgUE0sIERpbmggTmd1eWVuIHdyb3RlOg0KPiBFeHRlcm5h
bCBFLU1haWwNCj4gDQo+IA0KPiBHZXQgdGhlIHJlc2V0IGNvbnRyb2wgcHJvcGVydGllcyBmb3Ig
dGhlIFFTUEkgY29udHJvbGxlciBhbmQgYnJpbmcgdGhlbQ0KPiBvdXQgb2YgcmVzZXQuIE1vc3Qg
d2lsbCBoYXZlIGp1c3Qgb25lIHJlc2V0IGJpdCwgYnV0IHRoZXJlIGlzIGFuIGFkZGl0aW9uYWwN
Cj4gT0NQIHJlc2V0IGJpdCB0aGF0IGlzIHVzZWQgRUNDLiBUaGUgT0NQIHJlc2V0IGJpdCB3aWxs
IGFsc28gbmVlZCB0byBnZXQNCj4gZGUtYXNzZXJ0ZWQgYXMgd2VsbC4gWzFdDQo+IA0KPiBUaGUg
cmVhc29uIHRoaXMgcGF0Y2ggaXMgbmVlZGVkIGlzIGluIHRoZSBjYXNlIHdoZXJlIGEgYm9vdGxv
YWRlciBsZWF2ZXMNCj4gdGhlIFFTUEkgY29udHJvbGxlciBpbiBhIHJlc2V0IHN0YXRlLCBvciBh
IHN0YXRlIHdoZXJlIGluaXQgY2Fubm90IG9jY3VyDQo+IHN1Y2Nlc3NmdWxseSwgdGhlIHBhdGNo
IHdpbGwgcHV0IHRoZSBRU1BJIGNvbnRyb2xsZXIgaW50byBhIGNsZWFuIHN0YXRlLg0KPiANCj4g
WzFdIGh0dHBzOi8vd3d3LmludGVsLmNvbS9jb250ZW50L3d3dy91cy9lbi9wcm9ncmFtbWFibGUv
aHBzL2FycmlhLTEwL2hwcy5odG1sI3JlZ19zb2NfdG9wL3NmbzE0Mjk4OTA1NzU5NTUuaHRtbA0K
PiANCj4gU3VnZ2VzdGVkLWJ5OiBUaWVuLUZvbmcgQ2hlZSA8dGllbi5mb25nLmNoZWVAaW50ZWwu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBEaW5oIE5ndXllbiA8ZGluZ3V5ZW5Aa2VybmVsLm9yZz4N
Cj4gLS0tDQo+IHY2OiBubyBuZWVkIHRvIGNoZWNrIGZvciByZXNldCBwb2ludGVyIGluIGFzc2Vy
dC9kZWFzc2VydCBhcyB0aGUgY2FsbCB0bw0KPiAgICAgYXNzZXJ0L2RlYXNzZXJ0IGlzIGFscmVh
ZHkgZG9pbmcgdGhlIGNoZWNraW5nDQo+IHY1OiByZW1vdmUgdWRlbGF5KG5vdCBuZWVkZWQpIG9u
IHRlc3RlZCBoYXJkd2FyZQ0KPiAgICAgZ3JvdXAgcmVzZXQgYXNzZXJ0L2RlYXNzZXJ0IHRvZ2V0
aGVyDQo+ICAgICB1cGRhdGUgY29tbWl0IG1lc3NhZ2Ugd2l0aCByZWFzb25pbmcgZm9yIHBhdGNo
DQo+IHY0OiBmaXggY29tcGlsZSBlcnJvcg0KPiB2MzogcmV0dXJuIGZ1bGwgZXJyb3IgYnkgdXNp
bmcgUFRSX0VSUihydHNjKQ0KPiAgICAgbW92ZSByZXNldCBjb250cm9sIGNhbGxzIHVudGlsIGFm
dGVyIHRoZSBjbG9jayBlbmFibGVzDQo+ICAgICB1c2UgdWRlbGF5KDIpIHRvIGJlIHNhZmUNCj4g
ICAgIEFkZCBvcHRpb25hbCBPQ1AoT3BlbiBDb3JlIFByb3RvY29sKSByZXNldCBzaWduYWwNCj4g
djI6IHVzZSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X29wdGlvbmFsX2V4Y2x1c2l2ZQ0KPiAgICAg
cHJpbnQgYW4gZXJyb3IgbWVzc2FnZQ0KPiAgICAgcmV0dXJuIC1FUFJPQkVfREVGRVINCj4gLS0t
DQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NhZGVuY2UtcXVhZHNwaS5jIHwgMjIgKysrKysrKysr
KysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NhZGVuY2UtcXVhZHNwaS5jIGIvZHJp
dmVycy9tdGQvc3BpLW5vci9jYWRlbmNlLXF1YWRzcGkuYw0KPiBpbmRleCA3OTI2Mjg3NTBlZWMu
LjczMjMyM2MyYWRiMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jYWRlbmNl
LXF1YWRzcGkuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NhZGVuY2UtcXVhZHNwaS5j
DQo+IEBAIC0zNCw2ICszNCw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gICNpbmNs
dWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9wbV9ydW50
aW1lLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9z
Y2hlZC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NwaS9zcGkuaD4NCj4gICNpbmNsdWRlIDxsaW51
eC90aW1lci5oPg0KPiBAQCAtMTMzNiw2ICsxMzM3LDggQEAgc3RhdGljIGludCBjcXNwaV9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXN0cnVjdCBjcXNwaV9zdCAqY3Fz
cGk7DQo+ICAJc3RydWN0IHJlc291cmNlICpyZXM7DQo+ICAJc3RydWN0IHJlc291cmNlICpyZXNf
YWhiOw0KPiArCXN0cnVjdCByZXNldF9jb250cm9sICpyc3RjOw0KPiArCXN0cnVjdCByZXNldF9j
b250cm9sICpyc3RjX29jcDsNCg0KIGRlY2xhcmUgcnN0YyBhbmQgcnN0Y19vY3Agb24gdGhlIHNh
bWUgbGluZSBhbmQNCkFwcGxpZWQgdG8gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvbXRkL2xpbnV4LmdpdCwNCnNwaS1ub3IvbmV4dCBicmFuY2guDQoNClRo
YW5rcywNCnRhDQoNCj4gIAljb25zdCBzdHJ1Y3QgY3FzcGlfZHJpdmVyX3BsYXRkYXRhICpkZGF0
YTsNCj4gIAlpbnQgcmV0Ow0KPiAgCWludCBpcnE7DQo+IEBAIC0xNDAyLDYgKzE0MDUsMjUgQEAg
c3RhdGljIGludCBjcXNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAg
CQlnb3RvIHByb2JlX2Nsa19mYWlsZWQ7DQo+ICAJfQ0KPiAgDQo+ICsJLyogT2J0YWluIFFTUEkg
cmVzZXQgY29udHJvbCAqLw0KPiArCXJzdGMgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X29wdGlv
bmFsX2V4Y2x1c2l2ZShkZXYsICJxc3BpIik7DQo+ICsJaWYgKElTX0VSUihyc3RjKSkgew0KPiAr
CQlkZXZfZXJyKGRldiwgIkNhbm5vdCBnZXQgUVNQSSByZXNldC5cbiIpOw0KPiArCQlyZXR1cm4g
UFRSX0VSUihyc3RjKTsNCj4gKwl9DQo+ICsNCj4gKwlyc3RjX29jcCA9IGRldm1fcmVzZXRfY29u
dHJvbF9nZXRfb3B0aW9uYWxfZXhjbHVzaXZlKGRldiwgInFzcGktb2NwIik7DQo+ICsJaWYgKElT
X0VSUihyc3RjX29jcCkpIHsNCj4gKwkJZGV2X2VycihkZXYsICJDYW5ub3QgZ2V0IFFTUEkgT0NQ
IHJlc2V0LlxuIik7DQo+ICsJCXJldHVybiBQVFJfRVJSKHJzdGNfb2NwKTsNCj4gKwl9DQo+ICsN
Cj4gKwlyZXNldF9jb250cm9sX2Fzc2VydChyc3RjKTsNCj4gKwlyZXNldF9jb250cm9sX2RlYXNz
ZXJ0KHJzdGMpOw0KPiArDQo+ICsJcmVzZXRfY29udHJvbF9hc3NlcnQocnN0Y19vY3ApOw0KPiAr
CXJlc2V0X2NvbnRyb2xfZGVhc3NlcnQocnN0Y19vY3ApOw0KPiArDQo+ICAJY3FzcGktPm1hc3Rl
cl9yZWZfY2xrX2h6ID0gY2xrX2dldF9yYXRlKGNxc3BpLT5jbGspOw0KPiAgCWRkYXRhICA9IG9m
X2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KPiAgCWlmIChkZGF0YSAmJiAoZGRhdGEtPnF1
aXJrcyAmIENRU1BJX05FRURTX1dSX0RFTEFZKSkNCj4gDQo=
