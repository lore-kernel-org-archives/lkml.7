Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB813C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18BA2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfCMJ5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:57:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:41455 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfCMJ5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:57:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 02:57:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,474,1544515200"; 
   d="scan'208";a="125064779"
Received: from irsmsx104.ger.corp.intel.com ([163.33.3.159])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2019 02:57:01 -0700
Received: from irsmsx156.ger.corp.intel.com (10.108.20.68) by
 IRSMSX104.ger.corp.intel.com (163.33.3.159) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 13 Mar 2019 09:57:00 +0000
Received: from irsmsx106.ger.corp.intel.com ([169.254.8.205]) by
 IRSMSX156.ger.corp.intel.com ([169.254.3.101]) with mapi id 14.03.0415.000;
 Wed, 13 Mar 2019 09:57:00 +0000
From:   "Hunter, Adrian" <adrian.hunter@intel.com>
To:     Ritesh Harjani <riteshh@codeaurora.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Asutosh Das <asutoshd@codeaurora.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V1 07/11] mmc: cqhci: add quirk for setting DCMD
 CMD_TIMING
Thread-Topic: [PATCH V1 07/11] mmc: cqhci: add quirk for setting DCMD
 CMD_TIMING
Thread-Index: AQHU0Le0DEbz0tvc5kGHA16nvPxyvKX+l9EAgADl9oCAAQR1AIAIZfKAgAB6E+A=
Date:   Wed, 13 Mar 2019 09:56:59 +0000
Message-ID: <363DA0ED52042842948283D2FC38E4649C48E59C@IRSMSX106.ger.corp.intel.com>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
 <1551504025-3541-7-git-send-email-skomatineni@nvidia.com>
 <a320c841-7e58-4d3e-5df6-61e10520d9d8@intel.com>
 <a544bc6d-7b23-53e8-16d0-ee0eaf576eb2@codeaurora.org>
 <BYAPR12MB33984D80A404EF919F3A86A0C24C0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <05a6e500-9dc9-1984-9576-44b3a9fdc595@codeaurora.org>
In-Reply-To: <05a6e500-9dc9-1984-9576-44b3a9fdc595@codeaurora.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjgzZWU5N2MtYmEyNy00YWMyLWE4ZDAtYTZlN2Y0NGE0OGM0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMEJPTUZ3MVJpbjY4empGb3dCK1pVT2FIdEwzMzV2NGhGM3FsUFBCT0ZSczQrckl3NUROeE42VjZJMVdRUlZRSiJ9
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaXRlc2ggSGFyamFuaSBbbWFp
bHRvOnJpdGVzaGhAY29kZWF1cm9yYS5vcmddDQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTMs
IDIwMTkgNDozMSBBTQ0KPiBUbzogU293amFueWEgS29tYXRpbmVuaSA8c2tvbWF0aW5lbmlAbnZp
ZGlhLmNvbT47IEh1bnRlciwgQWRyaWFuDQo+IDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gbWFyay5ydXRsYW5k
QGFybS5jb207IEFzdXRvc2ggRGFzIDxhc3V0b3NoZEBjb2RlYXVyb3JhLm9yZz4NCj4gQ2M6IHRo
aWVycnkucmVkaW5nQGdtYWlsLmNvbTsgSm9uYXRoYW4gSHVudGVyIDxqb25hdGhhbmhAbnZpZGlh
LmNvbT47DQo+IEFuaXJ1ZGRoYSBUdnMgUmFvIDxhbnJhb0BudmlkaWEuY29tPjsgbGludXgtdGVn
cmFAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtbW1jQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCBWMSAwNy8xMV0gbW1jOiBjcWhjaTogYWRkIHF1aXJrIGZvciBz
ZXR0aW5nIERDTUQNCj4gQ01EX1RJTUlORw0KPiANCj4gDQo+IE9uIDMvNy8yMDE5IDExOjQ2IFBN
LCBTb3dqYW55YSBLb21hdGluZW5pIHdyb3RlOg0KPiA+PiBPbiAzLzYvMjAxOSA2OjMwIFBNLCBB
ZHJpYW4gSHVudGVyIHdyb3RlOg0KPiA+Pj4gT24gMi8wMy8xOSA3OjIwIEFNLCBTb3dqYW55YSBL
b21hdGluZW5pIHdyb3RlOg0KPiA+Pj4+IFRoaXMgcGF0Y2ggYWRkcyBhIHF1aXJrIGZvciBzZXR0
aW5nIENNRF9USU1JTkcgdG8gMSBpbiBkZXNjcmlwdG9yDQo+ID4+Pj4gZm9yIERDTUQgd2l0aCBS
MUIgcmVzcG9uc2UgdHlwZSB0byBhbGxvdyB0aGUgY29tbWFuZCB0byBiZSBzZW50IHRvDQo+ID4+
Pj4gZGV2aWNlIGR1cmluZyBkYXRhIGFjdGl2aXR5IG9yIGJ1c3kgdGltZS4NCj4gPj4+Pg0KPiA+
Pj4+IFRlZ3JhMTg2IENRSENJIGhvc3QgaGFzIGJ1ZyB3aGVyZSBpdCBzZWxlY3RzIERBVEFfUFJF
U0VOVF9TRUxFQ1QNCj4gdG8NCj4gPj4+PiAxIGJ5IENRSENJIGNvbnRyb2xsZXIgZm9yIERDTURz
IHdpdGggUjFCIHJlc3BvbnNlIHR5cGUgYW5kIHNpbmNlDQo+ID4+Pj4gRENNRCBkb2VzIG5vdCB0
cmlnZ2VyIGFueSBkYXRhIHRyYW5zZmVyLCBEQ01EIHRhc2sgY29tcGxldGUNCj4gaGFwcGVucw0K
PiA+Pj4+IGxlYXZpbmcgdGhlIERBVEEgRlNNIG9mIGhvc3QgY29udHJvbGxlciBpbiB3YWl0IHN0
YXRlIGZvciBkYXRhLg0KPiA+Pj4+DQo+ID4+Pj4gVGhpcyBlZmZlY3RzIHRoZSBkYXRhIHRyYW5z
ZmVyIHRhc2sgaXNzdWVkIGFmdGVyIFIxQiBEQ01EIHRhc2sgYW5kDQo+ID4+Pj4gbm8gaW50ZXJy
dXB0IGlzIGdlbmVyYXRlZCBmb3IgdGhlIGRhdGEgdHJhbnNmZXIgdGFzay4NCj4gPj4+Pg0KPiA+
Pj4+IFNXIFdBUiBmb3IgdGhpcyBpc3N1ZSBpcyB0byBzZXQgQ01EX1RJTUlORyBiaXQgdG8gMSBp
biBEQ01EIHRhc2sNCj4gPj4+PiBkZXNjcmlwdG9yIGFuZCBhcyBEQ01EIHRhc2sgZGVzY3JpcHRv
ciBwcmVwYXJhdGlvbiBpcyBkb25lIGJ5IGNxaGNpDQo+ID4+Pj4gZHJpdmVyLCB0aGlzIHBhdGNo
IGFkZHMgY3FlcXVpcmsgdG8gaGFuZGxlIHRoaXMuDQo+ID4+Pj4NCj4gPj4+PiBTaWduZWQtb2Zm
LWJ5OiBTb3dqYW55YSBLb21hdGluZW5pIDxza29tYXRpbmVuaUBudmlkaWEuY29tPg0KPiA+Pj4+
IC0tLQ0KPiA+Pj4+ICAgIGRyaXZlcnMvbW1jL2hvc3QvY3FoY2kuYyB8IDUgKysrKy0NCj4gPj4+
PiAgICBkcml2ZXJzL21tYy9ob3N0L2NxaGNpLmggfCAxICsNCj4gPj4+PiAgICAyIGZpbGVzIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pj4+DQo+ID4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvY3FoY2kuYyBiL2RyaXZlcnMvbW1jL2hvc3QvY3Fo
Y2kuYw0KPiA+Pj4+IGluZGV4IGE4YWY2ODJhOTE4Mi4uYjM0YzA3MTI1ZjMyIDEwMDY0NA0KPiA+
Pj4+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvY3FoY2kuYw0KPiA+Pj4+ICsrKyBiL2RyaXZlcnMv
bW1jL2hvc3QvY3FoY2kuYw0KPiA+Pj4+IEBAIC01MjEsNyArNTIxLDEwIEBAIHN0YXRpYyB2b2lk
IGNxaGNpX3ByZXBfZGNtZF9kZXNjKHN0cnVjdA0KPiBtbWNfaG9zdCAqbW1jLA0KPiA+Pj4+ICAg
IAl9IGVsc2Ugew0KPiA+Pj4+ICAgIAkJaWYgKG1ycS0+Y21kLT5mbGFncyAmIE1NQ19SU1BfUjFC
KSB7DQo+ID4+Pj4gICAgCQkJcmVzcF90eXBlID0gMHgzOw0KPiA+Pj4+IC0JCQl0aW1pbmcgPSAw
eDA7DQo+ID4+Pj4gKwkJCWlmIChjcV9ob3N0LT5xdWlya3MgJg0KPiBDUUhDSV9RVUlSS19DTURf
VElNSU5HX1IxQl9EQ01EKQ0KPiA+Pj4+ICsJCQkJdGltaW5nID0gMHgxOw0KPiA+Pj4+ICsJCQll
bHNlDQo+ID4+Pj4gKwkJCQl0aW1pbmcgPSAweDA7DQo+ID4+PiBJIHdhcyB0aGlua2luZyBpdCB3
b3VsZCBiZSBuaWNlIGlmIHRoZXJlIHdhcyBhIGdlbmVyaWMgd2F5IGZvcg0KPiA+Pj4gZHJpdmVy
cyB0byBtYWtlIGNoYW5nZXMgdG8gZGVzY3JpcHRvcnMgYmVmb3JlIGEgdGFzayBpcyBzdGFydGVk
Lg0KPiA+Pj4gQ3VycmVudGx5IHRoZXJlIGlzDQo+ID4+PiBob3N0LT5vcHMtPndyaXRlX2woKSB3
aGljaCB3b3VsZCBtYWtlIGl0IHBvc3NpYmxlIGJ5IGNoZWNraW5nIGZvcg0KPiA+Pj4gaG9zdC0+
b3BzLT5DUUhDSV9UREJSDQo+ID4+PiByZWdpc3RlciBhbmQsIGluIHRoaXMgY2FzZSwgdGhlIERD
TUQgdGFnLiAgV2Ugd291bGQgbmVlZCB0byBleHBvcnQNCj4gPj4+IGdldF9kZXNjKCksIHBlcmhh
cHMgcmVuYW1lIGl0IGNxaGNpX2dldF9kZXNjKCkgYW5kIHB1dCBpdCBpbiBjcWhjaS5oDQo+ID4+
PiBzaW5jZSBpdCBpcyBhbiBpbmxpbmUgZnVuY3Rpb24uDQo+ID4+IFdlIHRha2Ugc3Bpbl9sb2Nr
X2lycXNhdmUgYWZ0ZXIgdGhlIGRlc2NyaXB0b3IgaXMgcHJlcGFyZWQgYW5kIGJlZm9yZQ0KPiB3
cml0aW5nIHRvIFREQlIuDQo+ID4+IE5vdCBzdXJlIGJ1dCB0b21vcnJvdyB0aGlzIG1heSBiZWNv
bWUgYSBsaW1pdGF0aW9uIGZvciBkcml2ZXJzIHRvIG1ha2UNCj4gY2hhbmdlcyB0byBkZXNjcmlw
dG9ycyBpZiB0aGV5IGVkaXQgZGVzY3JpcHRvcnMgaW4gaG9zdC0+b3BzLT53cml0ZV9sKCkgY2Fs
bC4NCj4gPj4gVGhvdWdoIGluIHRoaXMgY2FzZSBpdCBpcyBub3QgcmVxdWlyZWQgaGVyZS4NCj4g
Pj4NCj4gPj4+IEFsdGVybmF0aXZlbHkgd2UgY291bGQgYWRkIGhvc3QtPm9wcyBmb3IgZGVzY3Jp
cHRvciBwcmVwYXJhdGlvbi4NCj4gPj4gQm90aCB3YXlzIHNvdW5kcyBnb29kIHRvIG1lLg0KPiA+
PiBCdXQgbWF5YmUgYWRkaW5nIGEgaG9zdC0+b3BzIGZvciBkZXNjcmlwdG9yIHByZXBhcmF0aW9u
IGlzIGJldHRlciB3YXkNCj4gPj4gdG8gZ28sIHNpbmNlIHRoYXQgd2lsbCBiZSB0aGUgcmlnaHQg
aW50ZXJmYWNlIGV4cG9zZWQgdG8gbWFrZSBjaGFuZ2VzDQo+ID4+IHRvIGRlc2NyaXB0b3JzLg0K
PiA+Pg0KPiA+IERDTUQgZGVzY3JpcHRvciBhdHRyaWJ1dGVzIHJlbWFpbiBzYW1lIGZvciBhbnkg
aG9zdCBhbmQgYWxzbyB0YXNrDQo+IHBhcmFtZXRlcnMgYXMgUUJSIG5lZWQgdG8gYmUgZW5hYmxl
ZCB3aXRoIERDTUQuDQo+ID4gU28gSSBiZWxpZXZlIGl0IHNob3VsZCBiZSBvayBpZiB3ZSBqdXN0
IGFkZCBjYWxsYmFjayB0byBhbGxvdyBob3N0cyB0byB1cGRhdGUNCj4gY29tbWFuZCBwYXJhbWV0
ZXJzIG9mIERDTUQgZGVzY3JpcHRvciBvbmx5IHRocnUgY3FoY2lfaG9zdF9vcHMuDQo+IA0KPiBG
b3Igbm93IHdlIGNhbiBhZGQgaG9zdC0+b3BzIGFzIHVwZGF0ZV9kY21kX2Rlc2MgYW5kIHBhc3Mg
dGhlDQo+IHRhc2tfZGVzYyBvZiBEQ01EIGZvciB1cGRhdGluZyBhbnkgcGFyYW1zIHdoaWNoIGhv
c3QgbWF5IHdhbnQgdG8gdXBkYXRlLg0KPiANCj4gPg0KPiA+IEFsc28sIGRvbuKAmXQgc2VlIGFu
eSByZXF1aXJlbWVudCBmb3IgaG9zdCBzcGVjaWZpYyBUYXNrIHBhcmFtZXRlciB1cGRhdGVzDQo+
IGluIFRhc2sgZGVzY3JpcHRvciBzbyBub3Qgc3VyZSBpZiB0aGVyZSBpcyBhbnkgbmVlZCB0byBw
cm92aWRlIGNhbGxiYWNrIGZvciB0YXNrDQo+IGRlc2NyaXB0b3IgZGF0YSBwcmVwYXJhdGlvbiB0
byBob3N0cy4NCj4gPiBQbGVhc2UgY29uZmlybS4NCj4gDQo+IFN1cmUsIGZvciBub3cgdGhlIHJl
cXVpcmVtZW50IGhhcyBjb21lIHVwIG9ubHkgZm9yIERDTUQgZGVzYyB1cGRhdGUuDQo+IFN1cmUg
d2UgY2FuIGFkZCB0YXNrIGRlc2NyaXB0b3Igb3BzIGluIHRoZSBzaW1pbGFyIHdheSBsYXRlciB3
aGVuIHJlcXVpcmVkLg0KPiANCj4gQWRyaWFuLCBwbGVhc2UgY29uZmlybSBpZiB5b3UgYXJlIGZp
bmUgd2l0aCBib3RoIG9mIGFib3ZlPw0KDQpZZXMsIEkgYWdyZWUuICBTb3dqYW55YSdzIFYyIDA2
LzEwIHBhdGNoIGlzIHF1aXRlIG5hcnJvd2x5IGZvY3VzZWQsIHdoZXJlYXMNCnVwZGF0ZV9kY21k
X2Rlc2MgYXMgeW91IGRlc2NyaWJlZCBzZWVtcyBqdXN0IGFzIGVhc3kgdG8gaW1wbGVtZW50LCBi
dXQNCklzIG1vcmUgZmxleGlibGUuDQoNCj4gDQo+ID4NCj4gPj4+IFdoYXQgZG8gcGVvcGxlIHRo
aW5rPw0KPiA+Pj4NCj4gPj4+PiAgICAJCX0gZWxzZSB7DQo+ID4+Pj4gICAgCQkJcmVzcF90eXBl
ID0gMHgyOw0KPiA+Pj4+ICAgIAkJCXRpbWluZyA9IDB4MTsNCj4gPj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5oIGIvZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5oDQo+ID4+
Pj4gaW5kZXggOWU2ODI4NmEwN2I0Li5mOTZkODU2NWNjMDcgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEv
ZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5oDQo+ID4+Pj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9j
cWhjaS5oDQo+ID4+Pj4gQEAgLTE3MCw2ICsxNzAsNyBAQCBzdHJ1Y3QgY3FoY2lfaG9zdCB7DQo+
ID4+Pj4NCj4gPj4+PiAgICAJdTMyIHF1aXJrczsNCj4gPj4+PiAgICAjZGVmaW5lIENRSENJX1FV
SVJLX1NIT1JUX1RYRlJfREVTQ19TWgkweDENCj4gPj4+PiArI2RlZmluZSBDUUhDSV9RVUlSS19D
TURfVElNSU5HX1IxQl9EQ01ECTB4Mg0KPiA+Pj4+DQo+ID4+Pj4gICAgCWJvb2wgZW5hYmxlZDsN
Cj4gPj4+PiAgICAJYm9vbCBoYWx0ZWQ7DQo+ID4+Pj4NCg==
