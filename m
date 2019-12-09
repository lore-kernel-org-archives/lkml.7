Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6120AC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29560207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WjC6OSdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLIMTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:19:36 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:58290 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbfLIMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575893974; x=1607429974;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f1Ulg0wianJOtRmMoMDuC+5+OOThyz9aDKekIAtNX+s=;
  b=WjC6OSdLYEdPBH0bRGXggucm7ABS2F7xCTMVyIuYJrBBLzPkPpPLVV7+
   zraknecq0UxuUvvq28RahUAQbqmXO2sqHVAHmBz+l0gDJw3qWXXDROH/G
   AEjizT6lIdVjIMeUSuJMgZXuTsi0X1WZ/90OVH7bAELPKfHO8bqjX1XZU
   k=;
IronPort-SDR: bwHLj0d8dUyvWXkK5BxS0tnj22+Nye7y+w4pv3jOiRujlore5lzM7dgnT41bLZWYsZZYWFsbc0
 WmbohzyEjhLw==
X-IronPort-AV: E=Sophos;i="5.69,294,1571702400"; 
   d="scan'208";a="12419638"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 09 Dec 2019 12:19:20 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id 9F5A0A2468;
        Mon,  9 Dec 2019 12:19:19 +0000 (UTC)
Received: from EX13D32EUC004.ant.amazon.com (10.43.164.121) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 12:19:19 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D32EUC004.ant.amazon.com (10.43.164.121) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 12:19:18 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Mon, 9 Dec 2019 12:19:18 +0000
From:   "Durrant, Paul" <pdurrant@amazon.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: RE: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
 closed
Thread-Topic: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
 closed
Thread-Index: AQHVq3SCoU35oX1INEGjFwMD1PQM5aexs7UAgAAEWoCAAAHxUIAAAeGAgAAAtoA=
Date:   Mon, 9 Dec 2019 12:19:18 +0000
Message-ID: <63d653a04207451e9041c89acd04f2a2@EX13D32EUC003.ant.amazon.com>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-3-pdurrant@amazon.com>
 <20191209113926.GS980@Air-de-Roger>
 <b8a138ad-5770-65fa-f368-f7b4063702fa@suse.com>
 <3412e42d13224b6786613e58dc189ebf@EX13D32EUC003.ant.amazon.com>
 <8d66e520-3009-cde1-e24c-26d7476e5873@suse.com>
In-Reply-To: <8d66e520-3009-cde1-e24c-26d7476e5873@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.211]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKw7xyZ2VuIEdyb8OfIDxqZ3Jv
c3NAc3VzZS5jb20+DQo+IFNlbnQ6IDA5IERlY2VtYmVyIDIwMTkgMTI6MDkNCj4gVG86IER1cnJh
bnQsIFBhdWwgPHBkdXJyYW50QGFtYXpvbi5jb20+OyBSb2dlciBQYXUgTW9ubsOpDQo+IDxyb2dl
ci5wYXVAY2l0cml4LmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHhl
bi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZzsgU3RlZmFubw0KPiBTdGFiZWxsaW5pIDxzc3Rh
YmVsbGluaUBrZXJuZWwub3JnPjsgQm9yaXMgT3N0cm92c2t5DQo+IDxib3Jpcy5vc3Ryb3Zza3lA
b3JhY2xlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtYZW4tZGV2ZWxdIFtQQVRDSCAyLzRdIHhlbmJ1
czogbGltaXQgd2hlbiBzdGF0ZSBpcyBmb3JjZWQgdG8NCj4gY2xvc2VkDQo+IA0KPiBPbiAwOS4x
Mi4xOSAxMzowMywgRHVycmFudCwgUGF1bCB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPj4gRnJvbTogSsO8cmdlbiBHcm/DnyA8amdyb3NzQHN1c2UuY29tPg0KPiA+
PiBTZW50OiAwOSBEZWNlbWJlciAyMDE5IDExOjU1DQo+ID4+IFRvOiBSb2dlciBQYXUgTW9ubsOp
IDxyb2dlci5wYXVAY2l0cml4LmNvbT47IER1cnJhbnQsIFBhdWwNCj4gPj4gPHBkdXJyYW50QGFt
YXpvbi5jb20+DQo+ID4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyB4ZW4tZGV2
ZWxAbGlzdHMueGVucHJvamVjdC5vcmc7DQo+IFN0ZWZhbm8NCj4gPj4gU3RhYmVsbGluaSA8c3N0
YWJlbGxpbmlAa2VybmVsLm9yZz47IEJvcmlzIE9zdHJvdnNreQ0KPiA+PiA8Ym9yaXMub3N0cm92
c2t5QG9yYWNsZS5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbWGVuLWRldmVsXSBbUEFUQ0ggMi80
XSB4ZW5idXM6IGxpbWl0IHdoZW4gc3RhdGUgaXMgZm9yY2VkDQo+IHRvDQo+ID4+IGNsb3NlZA0K
PiA+Pg0KPiA+PiBPbiAwOS4xMi4xOSAxMjozOSwgUm9nZXIgUGF1IE1vbm7DqSB3cm90ZToNCj4g
Pj4+IE9uIFRodSwgRGVjIDA1LCAyMDE5IGF0IDAyOjAxOjIxUE0gKzAwMDAsIFBhdWwgRHVycmFu
dCB3cm90ZToNCj4gPj4+PiBPbmx5IGZvcmNlIHN0YXRlIHRvIGNsb3NlZCBpbiB0aGUgY2FzZSB3
aGVuIHRoZSB0b29sc3RhY2sgbWF5IG5lZWQgdG8NCj4gPj4+PiBjbGVhbiB1cC4gVGhpcyBjYW4g
YmUgZGV0ZWN0ZWQgYnkgY2hlY2tpbmcgd2hldGhlciB0aGUgc3RhdGUgaW4NCj4gPj4geGVuc3Rv
cmUNCj4gPj4+PiBoYXMgYmVlbiBzZXQgdG8gY2xvc2luZyBwcmlvciB0byBkZXZpY2UgcmVtb3Zh
bC4NCj4gPj4+DQo+ID4+PiBJJ20gbm90IHN1cmUgSSBzZWUgdGhlIHBvaW50IG9mIHRoaXMsIEkg
d291bGQgZXhwZWN0IHRoYXQgYSBmYWlsdXJlIHRvDQo+ID4+PiBwcm9iZSBvciB0aGUgcmVtb3Zh
bCBvZiB0aGUgZGV2aWNlIHdvdWxkIGxlYXZlIHRoZSB4ZW5idXMgc3RhdGUgYXMNCj4gPj4+IGNs
b3NlZCwgd2hpY2ggaXMgY29uc2lzdGVudCB3aXRoIHRoZSBhY3R1YWwgZHJpdmVyIHN0YXRlLg0K
PiA+Pj4NCj4gPj4+IENhbiB5b3UgZXhwbGFpbiB3aGF0J3MgdGhlIGJlbmVmaXQgb2YgbGVhdmlu
ZyBhIGRldmljZSB3aXRob3V0IGENCj4gPj4+IGRyaXZlciBpbiBzdWNoIHVua25vd24gc3RhdGU/
DQo+ID4+DQo+ID4+IEFuZCBtb3JlIGNvbmNlcm5pbmc6IGRpZCB5b3UgY2hlY2sgdGhhdCBubyBm
cm9udGVuZC9iYWNrZW5kIGlzDQo+ID4+IHJlbHlpbmcgb24gdGhlIGNsb3NlZCBzdGF0ZSB0byBi
ZSB2aXNpYmxlIHdpdGhvdXQgY2xvc2luZyBoYXZpbmcgYmVlbg0KPiA+PiBzZXQgYmVmb3JlPw0K
PiA+DQo+ID4gQmxrZnJvbnQgZG9lc24ndCBzZWVtIHRvIG1pbmQgYW5kIEkgYmVsaWV2ZSB0aGUg
V2luZG93cyBQViBkcml2ZXJzIGNvcGUsDQo+IGJ1dCBJIGRvbid0IHJlYWxseSB1bmRlcnN0YW5k
IHRoZSBjb21tZW50IHNpbmNlIHRoaXMgcGF0Y2ggaXMgYWN0dWFsbHkNCj4gcmVtb3ZpbmcgYSBj
YXNlIHdoZXJlIHRoZSBiYWNrZW5kIHRyYW5zaXRpb25zIGRpcmVjdGx5IHRvIGNsb3NlZC4NCj4g
DQo+IEknbSBub3Qgc3BlYWtpbmcgb2YgYmxrZnJvbnQvYmxrYmFjayBvbmx5LCBidXQgb2YgbmV0
LCB0cG0sIHNjc2ksIHB2Y2FsbA0KPiBldGMuIGZyb250ZW5kcy9iYWNrZW5kcy4gQWZ0ZXIgYWxs
IHlvdSBhcmUgbW9kaWZ5aW5nIGEgZnVuY3Rpb24gY29tbW9uDQo+IHRvIGFsbCBQViBkcml2ZXIg
cGFpcnMuDQo+IA0KPiBZb3UgYXJlIHJlbW92aW5nIGEgc3RhdGUgc3dpdGMgdG8gImNsb3NlZCIg
aW4gY2FzZSB0aGUgc3RhdGUgd2FzIF9ub3RfDQo+ICJjbG9zaW5nIiBiZWZvcmUuDQoNClllcywg
d2hpY2ggQUZBSUsgaXMgYWdhaW5zdCB0aGUgaW50ZW50aW9uIG9mIHRoZSBnZW5lcmljIFBWIHBy
b3RvY29sIHN1Y2ggdGhhdCBpdCBldmVyIGV4aXN0ZWQgYW55d2F5Lg0KDQo+IFNvIGFueSBQViBk
cml2ZXIgcmVhY3RpbmcgdG8gImNsb3NlZCIgb2YgdGhlIG90aGVyIGVuZA0KPiBpbiBjYXNlIHRo
ZSBwcmV2aW91cyBzdGF0ZSBtaWdodCBub3QgaGF2ZSBiZWVuICJjbG9zaW5nIiBiZWZvcmUgaXMg
YXQNCj4gcmlzayB0byBtaXNiZWhhdmUgd2l0aCB5b3VyIHBhdGNoLg0KDQpXZWxsLCB0aGV5IHdp
bGwgc2VlIG5vdGhpbmcgbm93LiBJZiB0aGUgc3RhdGUgd2FzIG5vdCBjbG9zaW5nLCBpdCBnZXRz
IGxlZnQgYWxvbmUsIHNvIHRoZSBmcm9udGVuZCBzaG91bGRuJ3QgZG8gYW55dGhpbmcuIFRoZSBv
bmx5IHJpc2sgdGhhdCBJIGNhbiBzZWUgaXMgdGhhdCBzb21lIGZyb250ZW5kL2JhY2tlbmQgcGFp
ciBuZWVkZWQgYSBkaXJlY3QgNCAtPiA2IHRyYW5zaXRpb24gdG8gc3VwcG9ydCAndW5iaW5kJyBi
ZWZvcmUgYnV0IEFGQUlLIG5vdGhpbmcgaGFzIGV2ZXIgc3VwcG9ydGVkIHRoYXQsIGFuZCBibGsg
YW5kIG5ldCBjcmFzaCduJ2J1cm4gaWYgeW91IHRyeSB0aGF0IG9uIHVwc3RyZWFtIGFzIGl0IHN0
YW5kcy4gQSBjbGVhbiB1bnBsdWcgd291bGQgYWx3YXlzIHNldCBzdGF0ZSB0byA1IGZpcnN0LCBz
aW5jZSB0aGF0J3MgcGFydCBvZiB0aGUgdW5wbHVnIHByb3RvY29sLg0KDQogIFBhdWwNCg0KPiAN
Cj4gSnVlcmdlbg0K
