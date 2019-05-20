Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07225C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D835F21743
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfETVwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:52:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:28830 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfETVwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:52:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 14:52:03 -0700
X-ExtLoop1: 1
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga005.fm.intel.com with ESMTP; 20 May 2019 14:52:02 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 20 May 2019 14:52:02 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.182]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.231]) with mapi id 14.03.0415.000;
 Mon, 20 May 2019 14:52:02 -0700
From:   "Yang, Fei" <fei.yang@intel.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chen Yu <chenyu56@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: RE: [REGRESSION] usb: gadget: f_fs: Allow scatter-gather buffers
Thread-Topic: [REGRESSION] usb: gadget: f_fs: Allow scatter-gather buffers
Thread-Index: AQHVBUSfP50+H4oA+0GPWiTwRhChu6ZjSo+AgABJVwCAADHfAIAFz8aAgABDQICAAQ2pAIAJdbYA///lWmCAAJ5FAP//vcHQ
Date:   Mon, 20 May 2019 21:52:02 +0000
Message-ID: <02E7334B1630744CBDC55DA8586225837F885FFD@ORSMSX103.amr.corp.intel.com>
References: <CALAqxLUMRaNxwTUi9QS7-Cy-Ve4+vteBm8-jW4yzZg_QTJVChA@mail.gmail.com>
 <7caebeb2-ea96-2276-3078-1e53f09ce227@collabora.com>
 <CALAqxLUfJYUtmQDC_aDMxW7KcPUawGoRq-PNUfmzQuNKh97FmQ@mail.gmail.com>
 <CALAqxLVUFfrPVVjR74V3PhhtcCytfp=cUYjo=BcJ14D1fkVXTw@mail.gmail.com>
 <7ec57c29-d1ab-dc4c-755d-a6009b9132b5@collabora.com>
 <CALAqxLUgnTB7aZ4edXCaG8SJsJzfY1_yNEPc6Losssw5Xy9-XA@mail.gmail.com>
 <36620156-d119-b1b2-989e-0c13b783296e@collabora.com>
 <db5665cf-6274-c254-720c-798fec79d131@collabora.com>
 <02E7334B1630744CBDC55DA8586225837F884D53@ORSMSX103.amr.corp.intel.com>
 <CALAqxLWVc6DnRHJ9gQ8orY7f53g4j+x3BWnoJdBv3sXDZVNpVg@mail.gmail.com>
In-Reply-To: <CALAqxLWVc6DnRHJ9gQ8orY7f53g4j+x3BWnoJdBv3sXDZVNpVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzQzZmNlMzctZmEwYy00ZGQxLTlhNzEtYmQ4OGYzNTlkYzM2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSnhWOU1jZUI3YnEyYjdcL0ozMlRraTU5RnkrVWhxOHZzSDY3bVJvVk81WGFDNHlaXC9nKzI0eWUwZlhwdlNCa3ZDIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+PiBPbmUgcXVlc3Rpb24gdGhhdCBjb21lcyB0byBteSBtaW5kIGlzIHRoaXM6IERvZXMgdGhl
IFVTQiANCj4+Pj4gdHJhbnNtaXNzaW9uIHN0YWxsIChlLmcuIGVuZHBvaW50IHN0YWxsKSBvciBu
b3Q/IEluIG90aGVyIHdvcmRzLCBpcyANCj4+Pj4gYWRiIGNvbm5lY3Rpb24gYnJva2VuIGJlY2F1
c2UgVVNCIHN0b3BzIHRyYW5zbWl0dGluZyBhbnl0aGluZywgb3IgDQo+Pj4+IGJlY2F1c2UgdGhl
IGRhdGEgaXMgdHJhbnNtaXR0ZWQgYnV0IGl0cyBpbnRlZ3JpdHkgaXMgYnJva2VuIGR1cmluZyAN
Cj4+Pj4gdHJhbnNtaXNzaW9uIGFuZCB0aGF0IGNhdXNlcyBhZGIvYWRiZCBjb25mdXNpb24gd2hp
Y2ggcmVzdWx0cyBpbiBzdG9wcGluZyB0aGVpciBvcGVyYXRpb24/DQo+Pj4+IERvZXMgYW55dGhp
bmcga2VlcCBoYXBwZW5pbmcgb24gRnVuY3Rpb25GUyB3aGVuIGFkYiBjb25uZWN0aW9uIGlzIA0K
Pj4+PiBicm9rZW4/DQo+Pj4NCj4+PkFueSBkaXNjb3ZlcmllcyBhYm91dCB0aGUgcHJvYmxlbT8N
Cj4+DQo+PiBJbiBteSBkZWJ1Z2dpbmcsIEknbSBzZWVpbmcgYSBsb3Qgb2YgcmVxdWVzdHMgcXVl
dWVkIHVwIHRocm91Z2ggDQo+PiBmZnNfZXBmaWxlX2lvIChyZXR1cm5pbmcgLUVJT0NCUVVFVUVE
KSwgYnV0IG9ubHkgYSBmZXcgb2YgdGhlbSBjYW1lIGJhY2sgdGhyb3VnaCBmZnNfZXBmaWxlX2Fz
eW5jX2lvX2NvbXBsZXRlIC0+IGZmc191c2VyX2NvcHlfd29ya2VyLg0KPj4gSSBkb27igJl0IHRo
aW5rIHRoZXJlIGlzIGEgVVNCIHRyYW5zbWlzc2lvbiBzdGFsbCB0aG91Z2gsIGJlY2F1c2UgaWYg
SSANCj4+IG1hbnVhbGx5IGRpc2FibGUgaW9fZGF0YS0+dXNlX3NnLCBldmVyeXRoaW5nIGdvZXMg
YmFjayB0byBub3JtYWwuIFNvIGl0IGxvb2tzIG1vcmUgbGlrZWx5IHRvIGJlIGEgYnVmZmVyIGhh
bmRsaW5nIHByb2JsZW0gaW4gdGhlIERXQzMgZHJpdmVyLg0KPg0KPiBZZWEsIEkgYWxzbyBkaWQg
cmVjb25maXJtIHRoYXQgcmV2ZXJ0aW5nIDc3MmE3YTcyNGY2LCBvciBzZXR0aW5nDQo+IGdhZGdl
dC0+c2dfc3VwcG9ydGVkIHRvIGZhbHNlIG1ha2VzIHRoZSBpc3NzdWUgZ28gYXdheS4NCj4NCj4g
QW5kIGFmdGVyIHNwZW5kaW5nIGEgYnVuY2ggb2YgdGltZSB0cnlpbmcgdG8gdHJhY2UgdGhyb3Vn
aCB0aGUgY29kZSBsYXN0IHdlZWssIGluIHBhcnRpY3VsYXIgdGhlIHNnX3N1cHBvcnRlZCBjaGVj
a3MsIGJ1dCBJJ20gbm90IHNlZWluZyBhbnl0aGluZyB0aGF0IGlzIHN0YW5kaW5nIG91dCB3aXRo
IHRoZSBmX2ZzIGxvZ2ljLg0KPg0KPiBJJ2Qgc3RhcnQgdG8gYWdyZWUgaXQgbWlnaHQgYmUgYSBi
dWZmZXIgaGFuZGxpbmcgcHJvYmxlbSBpbiBkd2MzLCBidXQgaXQgZmVlbHMgb2RkIHRoYXQgSSdt
IGFsc28gc2VlaW5nIHRoaXMgdy8gZHdjMiBoYXJkd2FyZSBhcyB3ZWxsLiBNYXliZSB0aGUgIHNh
bWUgYnVnIHdhcyBjb3BpZWQgaW50byBib3RoIGRyaXZlcnM/DQo+DQo+IEknbGwgdHJ5IHRvIGRp
ZyBhIGxpdHRsZSBvbiB0aGF0IHRoZW9yeSB0b2RheS4NCg0KT25lIG9mIHRoZSBwcm9ibGVtcyBh
cHBlYXJzIHRvIGJlIHRoYXQgcmVxLT5udW1fbWFwcGVkX3NncyB3YXMgbGVmdCB1bmluaXRpYWxp
emVkLiBJIG1hZGUgdGhlIGZvbGxvd2luZyBjaGFuZ2UgYW5kIGdvdCBhIGxvdCBtb3JlIHJlcXVl
c3RzIGNvbXBsZXRlZC4NCkhvd2V2ZXIgdGhpcyBjaGFuZ2UgaXMgbm90IHN1ZmZpY2llbnQgdG8g
c29sdmUgdGhlIGFkYiBpc3N1ZSwgdGhlIHVzYiByZXF1ZXN0cyB3b3VsZCBldmVudHVhbGx5IGdl
dCBzdHVjayB3aXRob3V0IGdldHRpbmcgYSBtYXRjaGluZyBmZnNfZXBmaWxlX2FzeW5jX2lvX2Nv
bXBsZXRlLiANCg0KQEAgLTEwNjcsNiArMTA2Nyw3IEBAIHN0YXRpYyBzc2l6ZV90IGZmc19lcGZp
bGVfaW8oc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBmZnNfaW9fZGF0YSAqaW9fZGF0YSkNCiAg
ICAgICAgICAgICAgICAgICAgICAgIHJlcS0+YnVmID0gTlVMTDsNCiAgICAgICAgICAgICAgICAg
ICAgICAgIHJlcS0+c2cgPSBpb19kYXRhLT5zZ3Quc2dsOw0KICAgICAgICAgICAgICAgICAgICAg
ICAgcmVxLT5udW1fc2dzID0gaW9fZGF0YS0+c2d0Lm5lbnRzOw0KKyAgICAgICAgICAgICAgICAg
ICAgICAgcmVxLT5udW1fbWFwcGVkX3NncyA9IHJlcS0+bnVtX3NnczsNCiAgICAgICAgICAgICAg
ICB9IGVsc2Ugew0KICAgICAgICAgICAgICAgICAgICAgICAgcmVxLT5idWYgPSBkYXRhOw0KICAg
ICAgICAgICAgICAgIH0NCkBAIC0xMTEwLDYgKzExMTEsNyBAQCBzdGF0aWMgc3NpemVfdCBmZnNf
ZXBmaWxlX2lvKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3QgZmZzX2lvX2RhdGEgKmlvX2RhdGEp
DQogICAgICAgICAgICAgICAgICAgICAgICByZXEtPmJ1ZiA9IE5VTEw7DQogICAgICAgICAgICAg
ICAgICAgICAgICByZXEtPnNnID0gaW9fZGF0YS0+c2d0LnNnbDsNCiAgICAgICAgICAgICAgICAg
ICAgICAgIHJlcS0+bnVtX3NncyA9IGlvX2RhdGEtPnNndC5uZW50czsNCisgICAgICAgICAgICAg
ICAgICAgICAgIHJlcS0+bnVtX21hcHBlZF9zZ3MgPSByZXEtPm51bV9zZ3M7DQogICAgICAgICAg
ICAgICAgfSBlbHNlIHsNCiAgICAgICAgICAgICAgICAgICAgICAgIHJlcS0+YnVmID0gZGF0YTsN
CiAgICAgICAgICAgICAgICB9DQo=
