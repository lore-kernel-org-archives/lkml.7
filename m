Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6176EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F642089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfDXLTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:19:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:8966 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfDXLTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:19:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 04:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; 
   d="scan'208";a="133952521"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga007.jf.intel.com with ESMTP; 24 Apr 2019 04:19:08 -0700
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 24 Apr 2019 04:19:07 -0700
Received: from bgsmsx151.gar.corp.intel.com (10.224.48.42) by
 fmsmsx123.amr.corp.intel.com (10.18.125.38) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 24 Apr 2019 04:19:07 -0700
Received: from bgsmsx104.gar.corp.intel.com ([169.254.5.147]) by
 BGSMSX151.gar.corp.intel.com ([169.254.3.73]) with mapi id 14.03.0415.000;
 Wed, 24 Apr 2019 16:49:04 +0530
From:   "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
CC:     "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] thermal: intel: int340x: processor_thermal_device:
 simplify to get driver data
Thread-Topic: [PATCH] thermal: intel: int340x: processor_thermal_device:
 simplify to get driver data
Thread-Index: AQHU85oQRCyCGO1uw0+mmC488xli6KY9DQSAgAp/TwCAAAKQAIADqJww
Date:   Wed, 24 Apr 2019 11:19:03 +0000
Message-ID: <3C3E65E75D9910479323816378A812E7414CDA84@BGSMSX104.gar.corp.intel.com>
References: <1555339710-28028-1-git-send-email-sumeet.r.pawnikar@intel.com>
         <20190415162809.GU9224@smile.fi.intel.com>
         <1555922784.26198.20.camel@intel.com>
 <1555923334.26198.25.camel@intel.com>
In-Reply-To: <1555923334.26198.25.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWZjNTRkYzQtY2Y4Ny00NTNlLTlhOGUtNzFkYmVjY2YzZjdlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ0ZYaUR5aHdkRGdwb1E2MDZ0T0pCV1lkTEJBTHQ5R3Fvd1dWUUJ4NSs1VzhmcFJYc1YyN2hwOWwrVkZEdnhEcyJ9
x-ctpclassification: CTP_NT
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGxpbnV4LXBtLW93bmVyQHZn
ZXIua2VybmVsLm9yZyBbbWFpbHRvOmxpbnV4LXBtLQ0KPm93bmVyQHZnZXIua2VybmVsLm9yZ10g
T24gQmVoYWxmIE9mIFpoYW5nIFJ1aQ0KPlNlbnQ6IE1vbmRheSwgQXByaWwgMjIsIDIwMTkgMjoy
NiBQTQ0KPlRvOiBTaGV2Y2hlbmtvLCBBbmRyaXkgPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNv
bT47IFBhd25pa2FyLCBTdW1lZXQgUg0KPjxzdW1lZXQuci5wYXduaWthckBpbnRlbC5jb20+DQo+
Q2M6IGVkdWJlenZhbEBnbWFpbC5jb207IGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc7DQo+c3Jp
bml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb207IGxpbnV4LXBtQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hd
IHRoZXJtYWw6IGludGVsOiBpbnQzNDB4OiBwcm9jZXNzb3JfdGhlcm1hbF9kZXZpY2U6DQo+c2lt
cGxpZnkgdG8gZ2V0IGRyaXZlciBkYXRhDQo+DQo+T24g5LiALCAyMDE5LTA0LTIyIGF0IDE2OjQ2
ICswODAwLCBaaGFuZyBSdWkgd3JvdGU6DQo+PiBPbiDkuIAsIDIwMTktMDQtMTUgYXQgMTk6Mjgg
KzAzMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4+ID4NCj4+ID4gT24gTW9uLCBBcHIgMTUs
IDIwMTkgYXQgMDg6MTg6MzBQTSArMDUzMCwgU3VtZWV0IFBhd25pa2FyIHdyb3RlOg0KPj4gPiA+
DQo+PiA+ID4NCj4+ID4gPiBGcm9tOiAiUGF3bmlrYXIsIFN1bWVldCBSIiA8c3VtZWV0LnIucGF3
bmlrYXJAaW50ZWwuY29tPg0KPj4gPiA+DQo+anVzdCBvbmUgY29tbWVudCwgdGhlIGF1dGhvciBu
YW1lIHlvdSB1c2VkIGlzIG5vdCBjb25zaXN0ZW50IHdpdGggdGhlIG5hbWUNCj55b3UgdXNlZCBm
b3IgeW91ciBTaWduZWQtb2ZmLWJ5ICdQYXduaWthciwgU3VtZWV0IFIgPHN1bWVldC5yLnBhd24N
Cj5pa2FyQGludGVsLmNvbT4nLCBhbmQgY2hlY2twYXRjaCBjb21wbGFpbnMgYWJvdXQgbWlzc2lu
ZyBTaWduZWQtb2ZmLWJ5IGZyb20NCj5wYXRjaCBhdXRob3IuDQo+UGxlYXNlIGZpeCB5b3VyIGdp
dGNvbmZpZyBhbmQgcnVuIGNoZWNrcGF0Y2ggYmVmb3JlIHNlbmRpbmcgbmV4dCB0aW1lLg0KPg0K
U3VyZSwgd2lsbCBmaXggdGhpcyBnb2luZyBmb3J3YXJkLiANCg0KVGhhbmtzLA0KU3VtZWV0LiAN
Cg0KPnRoYW5rcywNCj5ydWkNCj4NCj4+ID4gPiBUaGlzIHNpbXBsaWZpZXMgZ2V0dGluZyB0aGUg
J2RyaXZlcl9kYXRhJyBmcm9tICdzdHJ1Y3QgZGV2aWNlJw0KPj4gPiA+IGRpcmVjdGx5Lg0KPj4g
PiA+IEdvaW5nIHRocm91Z2ggcGxhdGZvcm1fZGV2aWNlIG9yIHBjaV9kZXYgaXMgbm90IHJlcXVp
cmVkLiBBbHNvDQo+PiA+ID4gcmVtb3ZlcyBjb25kaXRpb24gY2hlY2sgYXMgdGhlIHByaXZhdGUg
ZGF0YSBzdG9yZWQgd2l0aCBkZXYNCj4+ID4gPiBwb2ludGVyLCBtZWFucyBpcnJlc3BlY3RpdmUg
b2YgZW51bWVyYXRpb24gbW9kZSwgd2UgY2FuIHVzZQ0KPj4gPiA+IGRldl9nZXRfZHJ2ZGF0YSgp
Lg0KPj4gPiA+IFRoaXMgcmVtb3ZlcyB0aGUgdW5uZWNlc3Nhcnkgc3RlcCBiYWNrIGFuZCBmb3J0
aC4NCj4+ID4gPg0KPj4gPiBJbmRlZWQsIGdvb2QgY2xlYW4gdXAhDQo+PiA+IFJldmlld2VkLWJ5
OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT4NCj4+ID4NCj4+
IFRoYW5rcywgcGF0Y2ggYXBwbGllZC4NCj4+DQo+PiAtcnVpDQo+PiA+DQo+PiA+ID4NCj4+ID4g
Pg0KPj4gPiA+IFNpZ25lZC1vZmYtYnk6IFN1bWVldCBQYXduaWthciA8c3VtZWV0LnIucGF3bmlr
YXJAaW50ZWwuY29tPg0KPj4gPiA+IC0tLQ0KPj4gPiA+IMKgLi4uL2ludDM0MHhfdGhlcm1hbC9w
cm9jZXNzb3JfdGhlcm1hbF9kZXZpY2UuY8KgwqDCoMKgwqB8wqDCoMKgMTEgKy0tLS0tDQo+PiA+
ID4gLS0NCj4+ID4gPiAtLS0NCj4+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMTAgZGVsZXRpb25zKC0pDQo+PiA+ID4NCj4+ID4gPiBkaWZmIC0tZ2l0DQo+PiA+ID4gYS9k
cml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFsL3Byb2Nlc3Nvcl90aGVybWFsX2Rl
dmljZS4NCj4+ID4gPiBjDQo+PiA+ID4gYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90
aGVybWFsL3Byb2Nlc3Nvcl90aGVybWFsX2RldmljZS4NCj4+ID4gPiBjDQo+PiA+ID4gaW5kZXgg
OGUxY2Y0ZC4uMmE3Y2JhYSAxMDA2NDQNCj4+ID4gPiAtLS0NCj4+ID4gPiBhL2RyaXZlcnMvdGhl
cm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvcHJvY2Vzc29yX3RoZXJtYWxfZGV2aWNlLg0KPj4g
PiA+IGMNCj4+ID4gPiArKysNCj4+ID4gPiBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4
X3RoZXJtYWwvcHJvY2Vzc29yX3RoZXJtYWxfZGV2aWNlLg0KPj4gPiA+IGMNCj4+ID4gPiBAQCAt
ODEsMjIgKzgxLDEzIEBAIGVudW0gcHJvY190aGVybWFsX2VtdW1fbW9kZV90eXBlIHsNCj4+ID4g
PiDCoAkJCQkJc3RydWN0IGRldmljZV9hdHRyaWJ1dGUNCj4+ID4gPiAqYXR0ciwgXA0KPj4gPiA+
IMKgCQkJCQljaGFyICpidWYpIFwNCj4+ID4gPiDCoHsgXA0KPj4gPiA+IC0Jc3RydWN0IHBjaV9k
ZXYgKnBjaV9kZXY7IFwNCj4+ID4gPiAtCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXY7IFwN
Cj4+ID4gPiAtCXN0cnVjdCBwcm9jX3RoZXJtYWxfZGV2aWNlICpwcm9jX2RldjsgXA0KPj4gPiA+
ICsJc3RydWN0IHByb2NfdGhlcm1hbF9kZXZpY2UgKnByb2NfZGV2ID0NCj4+ID4gPiBkZXZfZ2V0
X2RydmRhdGEoZGV2KTsgXA0KPj4gPiA+IMKgCVwNCj4+ID4gPiDCoAlpZiAocHJvY190aGVybWFs
X2VtdW1fbW9kZSA9PSBQUk9DX1RIRVJNQUxfTk9ORSkgeyBcDQo+PiA+ID4gwqAJCWRldl93YXJu
KGRldiwgIkF0dGVtcHRlZCB0byBnZXQgcG93ZXIgbGltaXQgYmVmb3JlIGRldmljZQ0KPndhcw0K
Pj4gPiA+IGluaXRpYWxpemVkIVxuIik7IFwNCj4+ID4gPiDCoAkJcmV0dXJuIDA7IFwNCj4+ID4g
PiDCoAl9IFwNCj4+ID4gPiDCoAlcDQo+PiA+ID4gLQlpZiAocHJvY190aGVybWFsX2VtdW1fbW9k
ZSA9PSBQUk9DX1RIRVJNQUxfUExBVEZPUk1fREVWKQ0KPj4gPiA+IHsNCj4+ID4gPiBcDQo+PiA+
ID4gLQkJcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShkZXYpOyBcDQo+PiA+ID4gLQkJcHJvY19k
ZXYgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsgXA0KPj4gPiA+IC0JfSBlbHNlIHsgXA0K
Pj4gPiA+IC0JCXBjaV9kZXYgPSB0b19wY2lfZGV2KGRldik7IFwNCj4+ID4gPiAtCQlwcm9jX2Rl
diA9IHBjaV9nZXRfZHJ2ZGF0YShwY2lfZGV2KTsgXA0KPj4gPiA+IC0JfSBcDQo+PiA+ID4gwqAJ
cmV0dXJuIHNwcmludGYoYnVmLCAiJWx1XG4iLFwNCj4+ID4gPiDCoAkodW5zaWduZWQgbG9uZylw
cm9jX2Rldi0+cG93ZXJfbGltaXRzW2luZGV4XS5zdWZmaXggKiAxMDAwKTsgXA0KPj4gPiA+IMKg
fQ0KPj4gPiA+IC0tDQo+PiA+ID4gMS43LjkuNQ0K
