Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE82C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B94521841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfCTRap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:30:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:58410 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbfCTRan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:30:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 10:30:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,249,1549958400"; 
   d="scan'208";a="156758002"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga001.fm.intel.com with ESMTP; 20 Mar 2019 10:30:42 -0700
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 20 Mar 2019 10:30:41 -0700
Received: from orsmsx102.amr.corp.intel.com ([169.254.3.192]) by
 ORSMSX163.amr.corp.intel.com ([169.254.9.144]) with mapi id 14.03.0415.000;
 Wed, 20 Mar 2019 10:30:41 -0700
From:   "Yang, Fei" <fei.yang@intel.com>
To:     Josh Gao <jmgao@google.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jerry Zhang <zhangjerry@google.com>,
        "andrzej.p@collabora.com" <andrzej.p@collabora.com>,
        "plr.vincent@gmail.com" <plr.vincent@gmail.com>,
        "Shen, JingX" <jingx.shen@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] usb: gadget: f_fs: don't free buffer prematurely
Thread-Topic: [PATCH V2] usb: gadget: f_fs: don't free buffer prematurely
Thread-Index: AQHU3t5XE8/CBxAewk+Cmpw9nrOH2aYUewwAgAAAnICAAEQVkA==
Date:   Wed, 20 Mar 2019 17:30:40 +0000
Message-ID: <02E7334B1630744CBDC55DA8586225837F7FB506@ORSMSX102.amr.corp.intel.com>
References: <1553059940-127038-1-git-send-email-fei.yang@intel.com>
 <CAAHfpN_2rUu+kCCgOV+RdqCU5+XRe_c3KkJk6FNv50FG+5_qwg@mail.gmail.com>
 <CAAHfpN_uVBR5X7e4Bb=OsMVqudB9rVD7rqLhTfix6Pa+-iVwWw@mail.gmail.com>
In-Reply-To: <CAAHfpN_uVBR5X7e4Bb=OsMVqudB9rVD7rqLhTfix6Pa+-iVwWw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzIxYmZhNzktMWNhMy00ODAxLWJlZTMtZGFmNTg3ZGY0ZTMxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoib3BGNVJ0Z0Q1VjJMN2xkaktNNEZOV2tKbjhNSktiNEVGWXVNUHRrUEVSVEh0dU5JckxMRDE5ZWdqWXE1ekRPUyJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUdWUsIE1hciAxOSwgMjAxOSBhdCAxMDo1NiBQTSBKb3NoIEdhbyA8am1nYW9AZ29vZ2xl
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUdWUsIE1hciAxOSwgMjAxOSBhdCAxMDozMiBQTSA8
ZmVpLnlhbmdAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBGcm9tOiBGZWkgWWFuZyA8
ZmVpLnlhbmdAaW50ZWwuY29tPg0KPiA+ID4NCj4gPiA+IFRoZSBmb2xsb3dpbmcga2VybmVsIHBh
bmljIGhhcHBlbnMgZHVlIHRvIHRoZSBpb19kYXRhIGJ1ZmZlciBnZXRzIA0KPiA+ID4gZGVhbGxv
Y2F0ZWQgYmVmb3JlIHRoZSBhc3luYyBpbyBpcyBjb21wbGV0ZWQuIEFkZCBhIGNoZWNrIGZvciB0
aGUgDQo+ID4gPiBjYXNlIHdoZXJlIGlvX2RhdGEgYnVmZmVyIHNob3VsZCBiZSBkZWFsbG9jYXRl
ZCBieSBmZnNfdXNlcl9jb3B5X3dvcmtlci4NCj4gPg0KPiA+IEl0IGxvb2tzIGxpa2UgdGhpcyBo
YXBwZW5lZCBiZWNhdXNlIGRhdGEgZ290IHJlbmFtZWQgdG8gaW9fZGF0YSwgd2hpY2ggDQo+ID4g
bWFkZSB0aGUgYGRhdGEgPSBOVUxMYCBtYXJrZWQgd2l0aCAiRG8gbm90IGtmcmVlIHRoZSBidWZm
ZXIgaW4gdGhpcyANCj4gPiBmdW5jdGlvbiIgbm90IGRvIHdoYXQgaXQgd2FzIGhvcGluZy4gVGhp
cyBzaG91bGQgcHJvYmFibHkgZWl0aGVyIA0KPiA+IGRlbGV0ZSB0aGUgYXNzaWdubWVudCBhYm92
ZSBvciBmaXggdGhlIGFzc2lnbm1lbnQgdG8gcmVmZXIgdG8gaW9fZGF0YT8gDQo+ID4gKEVJT0NC
UVVFVUVEIHByZXN1bWFibHkgY2FuJ3QgY29tZSBmcm9tDQo+ID4gZWxzZXdoZXJlPykNCj4gDQo+
IChleGNlcHQgZmZzX2ZyZWVfYnVmZmVyIGRvZXNuJ3QgY2hlY2sgZm9yIG51bGwsIHNvIHByb2Jh
Ymx5IHRoZSBmb3JtZXIpDQoNCkkgZG9u4oCZdCBzZWUgRUlPQ0JRVUVVRUQgY29taW5nIGZyb20g
YW55d2hlcmUgZWxzZSBpbiB0aGUgY29udGV4dCBvZiBlcGZpbGVfaW8sIGJ1dCB5b3UgYXJlIHJp
Z2h0IGl0J3MgaGFyZA0KdG8gYmUgMTAwJSBzdXJlIGFib3V0IHRoYXQuDQpNYXliZSBJIHNob3Vs
ZCBzaW1wbHkgY2hlY2sgZm9yIChkYXRhID09IE5VTEwpIHNvIHRoYXQgdGhlIG9yaWdpbmFsIGxv
Z2ljIHJlbWFpbnMgaW50YWN0LA0KSWYgKGRhdGEpDQoJZmZzX2ZyZWVfYnVmZmVyKGlvX2RhdGEp
Ow0KDQoNCg==
