Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F1BC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B472F20878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfDYQBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:01:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:55642 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfDYQBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:01:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 09:01:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,394,1549958400"; 
   d="scan'208";a="134338718"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga007.jf.intel.com with ESMTP; 25 Apr 2019 09:01:16 -0700
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 25 Apr 2019 09:01:16 -0700
Received: from orsmsx102.amr.corp.intel.com ([169.254.3.144]) by
 ORSMSX158.amr.corp.intel.com ([169.254.10.159]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 09:01:16 -0700
From:   "Yang, Fei" <fei.yang@intel.com>
To:     John Stultz <john.stultz@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        "andrzej.p@collabora.com" <andrzej.p@collabora.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        "Linux USB List" <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Josh Gao <jmgao@google.com>,
        Alistair Strachan <astrachan@google.com>,
        "Shen, JingX" <jingx.shen@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: RE: [PATCH V2] usb: gadget: f_fs: don't free buffer prematurely
Thread-Topic: [PATCH V2] usb: gadget: f_fs: don't free buffer prematurely
Thread-Index: AQHU3t5XE8/CBxAewk+Cmpw9nrOH2aYVLtiAgAAcHQCAE3R5gIAjc+4AgAC5BwCAAFRHAA==
Date:   Thu, 25 Apr 2019 16:01:15 +0000
Message-ID: <02E7334B1630744CBDC55DA8586225837F82FB35@ORSMSX102.amr.corp.intel.com>
References: <1553059940-127038-1-git-send-email-fei.yang@intel.com>
 <CALAqxLUW9XCq0WqTzpYGZ7B_4CVdsXY6t_dyuwhnOTJ7HajrwQ@mail.gmail.com>
 <CALAqxLUwB4vYiCM1Yi2CizMu-FvEoBB-eNqwaTFi2b=gnvCCZQ@mail.gmail.com>
 <CALAqxLXE2Be_a3utjDP2+0mCfHeEypw_PqJPwkoyDM-F2F=jBA@mail.gmail.com>
 <20190424165052.GF21916@kroah.com>
 <CALAqxLXwoTaWLgw9u_Z6H6fW-a-6DzXAcZkaGBKpkEJAbBtJ5w@mail.gmail.com>
In-Reply-To: <CALAqxLXwoTaWLgw9u_Z6H6fW-a-6DzXAcZkaGBKpkEJAbBtJ5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGE4ODA0ZDQtZThiMy00NmI5LWFmNGYtMjNmMTBiNmI3Mzc5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaVpcLzJSZHkyRWlXZWprMFhzdnkrK2ZTU29oSXc5MUNyUHUyVGhWNCtMdmk4VjhHZVc4VmhyQllEcDJOeEVqRHAifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBXZWQsIEFwciAyNCwgMjAxOSBhdCA5OjUwIEFNIEdyZWcgS0ggPGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnPiB3cm90ZToNCj4gPg0KPiA+IE9uIFR1ZSwgQXByIDAyLCAyMDE5IGF0IDEw
OjI2OjUxQU0gKzA3MDAsIEpvaG4gU3R1bHR6IHdyb3RlOg0KPiA+ID4gT24gV2VkLCBNYXIgMjAs
IDIwMTkgYXQgMTE6MjEgQU0gSm9obiBTdHVsdHogPGpvaG4uc3R1bHR6QGxpbmFyby5vcmc+IHdy
b3RlOg0KPiA+ID4gPiBPbiBXZWQsIE1hciAyMCwgMjAxOSBhdCA5OjQwIEFNIEpvaG4gU3R1bHR6
IDxqb2huLnN0dWx0ekBsaW5hcm8ub3JnPiB3cm90ZToNCj4gPiA+ID4gPiBPbiBUdWUsIE1hciAx
OSwgMjAxOSBhdCAxMDozMiBQTSA8ZmVpLnlhbmdAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4g
PiBFbHNld2hlcmUgaXQgc2VlbXMgdGhlIGZmcyBkcml2ZXIgdGFrZXMgZWZmb3J0IHRvIGRyb3Ag
YW55IGxvY2tzIA0KPiA+ID4gPiA+IGJlZm9yZSBjYWxsaW5nIHVzYl9lcF9kZXF1ZXVlKCksIHNv
IHRoaXMgc2VlbXMgbGlrZSB0aGF0IHNob3VsZCANCj4gPiA+ID4gPiBiZSBhZGRyZXNzZWQsIGJ1
dCBpdCBhbHNvIHNlZW1zIGxpa2UgcmVjZW50IGNoYW5nZSB0byB0aGUgZHdjMyANCj4gPiA+ID4g
PiBkcml2ZXIgaGFzIGJlZW4gbWFkZSB0byBhdm9pZCBzbGVlcGluZyBpbiB0aGF0IHBhdGggKHNl
ZSBmZWM5MDk1YmRlZjQgKCJ1c2I6DQo+ID4gPiA+ID4gZHdjMzogZ2FkZ2V0OiByZW1vdmUgd2Fp
dF9lbmRfdHJhbnNmZXIiKSksIHdoaWNoIG1heSBiZSB3aHkgSSdtIA0KPiA+ID4gPiA+IG5vdCBz
ZWVpbmcgdGhlIHByb2JsZW0gd2l0aCBtYWlubGluZSAoYW5kIHlvdXIgcGF0Y2ggaGVyZSwgb2Yg
Y29hcnNlKS4NCj4gPiA+ID4gPiBCdXQgdGhhdCBhbHNvIGRvZXNuJ3QgY2xhcmlmeSBpZiBpdHMg
c3RpbGwgYSBwb3RlbnRpYWwgaXNzdWUgdy8NCj4gPiA+ID4gPiBub24tZHdjMyBwbGF0Zm9ybXMu
DQo+ID4gPiA+DQo+ID4gPiA+IEZlbGlwZTogR2l2ZW4gQWxhbidzIHBvaW50LCBkb2VzIGl0IG1h
a2Ugc2Vuc2UgdG8gbWFyayB0aGUgY29tbWl0cyANCj4gPiA+ID4gdGhhdCByZW1vdmUgdGhlIHBv
c3NpYmxlIHNsZWVwIGZyb20gd2FpdF9ldmVudF9sb2NrX2lycSgpIGluDQo+ID4gPiA+IGR3YzNf
Z2FkZ2V0X2VwX2RlcXVldWUoKSAgZm9yIC1zdGFibGU/DQo+ID4gPiA+DQo+ID4gPiA+IEFnYWlu
c3QgNC4xOS4zMCwgdGhlIGZvbGxvd2luZyBzZXQgbWFuYWdlcyB0byBjaGVycnktcGljayBjbGVh
bmx5Og0KPiA+ID4gPiBnaXQgY2hlcnJ5LXBpY2sgMWEyMmVjNjQzNTgwNjI2ZjQzOWM4NTgzZWRh
ZmRjYzczNzk4ZjJmYg0KPiA+ID4gPiBnaXQgY2hlcnJ5LXBpY2sgMDlmZTFmOGQ3ZTJmNDYxMjc1
YjFjZGQ4MzJmMmNmYTVlOWJlMzQ2ZA0KPiA+ID4gPiBnaXQgY2hlcnJ5LXBpY2sgYzNhY2Q1OTAx
NDE0ODQ3MGRjNTg1MTk4NzBmYmM3Nzk3ODViNGJmNw0KPiA+ID4gPiBnaXQgY2hlcnJ5LXBpY2sg
Nzc0NmE4ZGZiM2Y5YzkxYjNhMGI2M2ExZDVjMjY2NDQxMGU2NDk4ZA0KPiA+ID4gPiBnaXQgY2hl
cnJ5LXBpY2sgZDU0NDNiYmY1ZmM4ZjgzODljY2UxNDZiMWZjMjk4N2NkZDIyOWQxMg0KPiA+ID4g
PiBnaXQgY2hlcnJ5LXBpY2sgZDRmMWFmZTVlODk2YzE4YWUwMTA5OWE4NWRhYjVlMWExOThiZDJh
OA0KPiA+ID4gPiBnaXQgY2hlcnJ5LXBpY2sgZmVjOTA5NWJkZWY0ZTdjOTg4YWRiNjAzZDBkNGY5
MmVlNzM1ZDRhMQ0KPiA+ID4gPiAjIFRvIGdldCB0aGluZ3MgYnVpbGRpbmcsIHJldmVydCBtb2Rp
ZmllZCAtc3RhYmxlIGZpeCBnaXQgcmV2ZXJ0IA0KPiA+ID4gPiAyNWFkMTdkICNwaWNrIGFjdHVh
bCB1cHN0cmVhbSBmaXggcmVwbGFjaW5nIHRoZSBwcmV2aW91cyBnaXQgDQo+ID4gPiA+IGNoZXJy
eS1waWNrIGJkNjc0MjI0OWI5Y2E5MTg1NjVlNGUzYWJhYTA2NjY1ZTU4N2Y0YjUNCj4gPiA+ID4N
Cj4gPiA+ID4gKFRob3VnaCBJJ20gYWx3YXlzIGEgYml0IGhlc2l0YW50IHdpdGggLXN0YWJsZSBi
YWNrcG9ydHMgb24gDQo+ID4gPiA+IHN1YnN5c3RlbXMgSSBkb24ndCBrbm93IHdlbGwuIFNvIEkn
bSBub3Qgc3VyZSBpZiB0aGlzIHNldCBpcyBmdWxseSANCj4gPiA+ID4gY29ycmVjdC4pDQo+ID4g
PiA+DQo+ID4gPiA+IFRoaXMgc2V0IHNlZW1zIHRvIGF2b2lkIHRoZSBjcmFzaCBvbiByZWJvb3Qg
SSB3YXMgc2VlaW5nLg0KPiA+ID4gPg0KPiA+ID4gPiBBbmQgb2YgY291cnNlLCBJJ20gc3VyZSBn
ZXR0aW5nIHRoYXQgc2V0IGJhY2twb3J0ZWQgdG8gNC4xNCBhbmQgDQo+ID4gPiA+IDQuOSAoYW5k
IG1heWJlIGV2ZW4gNC40LCBJIG5lZWQgdG8gY2hlY2spIHdpbGwgYmUgbGVzcyBjbGVhbi4NCj4g
PiA+DQo+ID4gPiBBbHNvLCAgSSBqdXN0IHdhbnRlZCB0byBmb2xsb3cgdXAgb24gdGhpcyBhcyB3
ZWxsLiBEb2VzIHRoZSBhYm92ZSANCj4gPiA+IHNldCBvZiBjaGVycnktcGlja3MgbG9vayBvayB0
byBvdGhlcnMgZm9yIDQuMTktc3RhYmxlPyAgRG9lcyBhbnlvbmUgDQo+ID4gPiBoYXZlIHN1Z2dl
c3Rpb25zIG9uIGhvdyB0aGV5J2QgbGlrZSB0byBzZWUgYmFja3BvcnRzIHRvIDQuMTQsIDQuOSBh
bmQgNC40Pw0KPiA+DQo+ID4gSWYgdGhleSBhcmUgb2ssIGNhbiBzb21lb25lIHNlbmQgbWUgdGhl
IGNvbW1pdHMgYXMgYSBzZXJpZXMgb2YgDQo+ID4gcGF0Y2hlcywgYXMgZG9pbmcgdGhlIGFib3Zl
IHJlYWxseSBkb2Vzbid0IGhlbHAgbXVjaCA6KQ0KPiANCj4gWWVhLCBzbyBJJ20gaGFwcHkgdG8g
c2VuZCB0aGF0IHNldCB0byB5b3UgZm9yIDQuMTksIGFzc3VtaW5nIEZlbGlwZSBvciBzb21lb25l
IGVsc2UgT0tzIGl0Lg0KPiBJJ20gc3RpbGwgYXQgYSBiaXQgb2YgYSBsb3NzIGZvciB3aGF0IHRv
IGRvIGZvciBvbGRlciAoNC4xNC80LjkvNC40KSAtc3RhYmxlIGtlcm5lbHMsIGFzIGl0cyBnb2lu
ZyB0byBiZSBkaWZmaWN1bHQgdG8gYmFja3BvcnQgdGhvc2UuDQoNClRoZSBwYXRjaCBtZW50aW9u
ZWQgaW4gdGhlIHRpdGxlIG9mIHRoaXMgdGhyZWFkIGRvZXNuJ3QgYXBwbHkgdG8gb2xkZXIga2Vy
bmVscy4gVGhlIGtlcm5lbCBwYW5pYyB3YXMgaW50cm9kdWNlZCBpbiA1LjAtcmNYLg0KDQoNCg==
