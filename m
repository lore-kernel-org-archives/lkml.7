Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B5FFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219A921D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbfKHIrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 03:47:23 -0500
Received: from mga05.intel.com ([192.55.52.43]:6125 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfKHIrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 03:47:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 00:47:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,280,1569308400"; 
   d="scan'208";a="205932721"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga003.jf.intel.com with ESMTP; 08 Nov 2019 00:47:21 -0800
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 8 Nov 2019 00:47:21 -0800
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 8 Nov 2019 00:47:21 -0800
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.60]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.2]) with mapi id 14.03.0439.000;
 Fri, 8 Nov 2019 16:47:19 +0800
From:   "Zeng, Jason" <jason.zeng@intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Zeng, Jason" <jason.zeng@intel.com>
Subject: RE: [PATCH] intel-iommu: Turn off translations at shutdown
Thread-Topic: [PATCH] intel-iommu: Turn off translations at shutdown
Thread-Index: AQHVlgnIrRA21rplp0+PB/+PXXgW6aeA7hBA
Date:   Fri, 8 Nov 2019 08:47:19 +0000
Message-ID: <8D8B600C3EC1B64FAD4503F0B66C61F23BB95B@SHSMSX103.ccr.corp.intel.com>
References: <20191107205914.10611-1-deepa.kernel@gmail.com>
 <1672a5861c82c2e3c0c54b5311fd413a8eee5e64.camel@infradead.org>
In-Reply-To: <1672a5861c82c2e3c0c54b5311fd413a8eee5e64.camel@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmNlODA4ZTEtZjdhNC00Y2Y1LTgyNTMtZDVlNDZiMjBjMDllIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOUtHNThaWTZwQWRidndTclFhRDl0dVpcL1E1Um5cL1wvQkVjZCtoVTAyUThcL2RxdGxDSSt2SXE0VUc2K0lHaysybHYifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhdmlkIFdvb2Rob3VzZSA8
ZHdtdzJAaW5mcmFkZWFkLm9yZz4NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciA4LCAyMDE5IDM6
NTQgUE0NCj4gVG86IERlZXBhIERpbmFtYW5pIDxkZWVwYS5rZXJuZWxAZ21haWwuY29tPjsgam9y
b0A4Ynl0ZXMub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IFplbmcsIEphc29uIDxqYXNvbi56ZW5nQGlu
dGVsLmNvbT47DQo+IFRpYW4sIEtldmluIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gaW50ZWwtaW9tbXU6IFR1cm4gb2ZmIHRyYW5zbGF0aW9ucyBhdCBzaHV0
ZG93bg0KPiANCj4gT24gVGh1LCAyMDE5LTExLTA3IGF0IDEyOjU5IC0wODAwLCBEZWVwYSBEaW5h
bWFuaSB3cm90ZToNCj4gPiBUaGUgaW50ZWwtaW9tbXUgZHJpdmVyIGFzc3VtZXMgdGhhdCB0aGUg
aW9tbXUgc3RhdGUgaXMNCj4gPiBjbGVhbmVkIHVwIGF0IHRoZSBzdGFydCBvZiB0aGUgbmV3IGtl
cm5lbC4NCj4gPiBCdXQsIHdoZW4gd2UgdHJ5IHRvIGtleGVjIGJvb3Qgc29tZXRoaW5nIG90aGVy
IHRoYW4gdGhlDQo+ID4gTGludXgga2VybmVsLCB0aGUgY2xlYW51cCBjYW5ub3QgYmUgcmVsaWVk
IHVwb24uDQo+ID4gSGVuY2UsIGNsZWFudXAgYmVmb3JlIHdlIGdvIGRvd24gZm9yIHJlYm9vdC4N
Cj4gPg0KPiA+IEtlZXBpbmcgdGhlIGNsZWFudXAgYXQgaW5pdGlhbGl6YXRpb24gYWxzbywgaW4g
Y2FzZSBCSU9TDQo+ID4gbGVhdmVzIHRoZSBJT01NVSBlbmFibGVkLg0KPiA+DQo+ID4gSSBjb25z
aWRlcmVkIHR1cm5pbmcgb2ZmIGlvbW11IG9ubHkgZHVyaW5nIGtleGVjIHJlYm9vdCwNCj4gPiBi
dXQgYSBjbGVhbiBzaHV0ZG93biBzZWVtcyBhbHdheXMgYSBnb29kIGlkZWEuIEJ1dCBpZg0KPiA+
IHNvbWVvbmUgd2FudHMgdG8gbWFrZSBpdCBjb25kaXRpb25hbCwgd2UgY2FuIGRvIHRoYXQuDQo+
IA0KPiBUaGlzIGlzIGdvaW5nIHRvIGJyZWFrIHRoaW5ncyBmb3IgdGhlIFZNTSBsaXZlIHVwZGF0
ZSBzY2hlbWUgdGhhdCBKYXNvbg0KPiBwcmVzZW50ZWQgYXQgS1ZNIEZvcnVtLCBpc24ndCBpdD8N
Cj4gDQo+IEluIHRoYXQgY2FzZSB3ZSByZWx5IG9uIHRoZSBJT01NVSBzdGlsbCBvcGVyYXRpbmcg
ZHVyaW5nIHRoZQ0KPiB0cmFuc2l0aW9uLg0KDQpGb3IgVk1NIGxpdmUgdXBkYXRlIGNhc2UsIHdl
IHNob3VsZCBiZSBhYmxlIHRvIGRldGVjdCBhbmQgYnlwYXNzDQp0aGUgc2h1dGRvd24gdGhhdCBE
ZWVwYSBpbnRyb2R1Y2VkIGhlcmUsIHNvIGtlZXAgSU9NTVUgc3RpbGwgb3BlcmF0aW5nPw0KDQpU
aGFua3MsDQpKYXNvbg0K
