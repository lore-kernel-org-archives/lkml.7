Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7938C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A466522319
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="otXZbru4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKRTPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:15:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:4974 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfKRTPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:15:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 11:15:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="289354199"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 18 Nov 2019 11:15:17 -0800
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 Nov 2019 11:15:17 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 Nov 2019 11:15:17 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.56) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 18 Nov 2019 11:15:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izLCreKgIBsCBnch59rhTMgOMdCTqPZrLJD98bdJCRSlJWFozYNA5LxPzRei02PRa7z5dYT6BuaVh39WWbETUYf6qnq4oZDORa/EqsfISir9+Rm7FUI0PmUapvRMko86DzrgP9JhJbERSy4xLXX81sLocyqdhXoYCtR+z08PqhdJjLAwMwEOWaeHkPLdxBTMu0PJhbvtNEk8XuCxLH7y1ZlmbxFk0FKVjQBg4BxXCN1NoV6baP457V1dkbVF0OWdcMx0OqBzHKg3+seCGKPLBFxIZ387bl5snEvoNkTOcqA8kRQMcqgnpD7Z5a/yaGr7+tNw1c7YrCRVukto8k3P5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqS++4TJzhvVjmrIAGVI2utKM4T0ALrj76ARQhBzv5U=;
 b=dPgLkA31W2VhvIFnPtN5A3XQ1/Xiwq6b03cZ1WTJPJlgny1AlGh7lWWCD7i8MD3trDt1lMKYUbhfu/NuG1BrcppjCXtWab2oMvYVVaO7Ek6Tad+LnYnBCb5C2MzoCN4fRDvheU8qanH28k1vLc2rYfXc773vk0pVbbcgBXSKAwNuRVqOrI6gjhz2JC/nlC1ipEyAZNuQVblJxkEotIIHjpyRN6qgY9/Orv489RZLg7a0Hg2B/ErkVxtxn8FSf0VfTSbFHpZtPubIBM05Vvhl32yT7F7RtFdHPeujZfnVdUiBy2hctfsHrJe4iwCYn3Wd7BYZF20eR1tY29W11mp7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqS++4TJzhvVjmrIAGVI2utKM4T0ALrj76ARQhBzv5U=;
 b=otXZbru40JUU8mx+mGUWBQvEieKK9XGm7tgafxh889xUHqAxga8Kk5AM3sjOxhsl9S0Ayowj0kaQK0MpMTO6c/ASxefH8CTEN9fIFzH3QXxA9vlkLznMhvJzgs8ehqf6Jk/VOpIuneHHdnvfzxAPxRS6hmNNyxysvEglHDElb24=
Received: from MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) by
 MN2PR11MB3693.namprd11.prod.outlook.com (20.178.252.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Mon, 18 Nov 2019 19:15:15 +0000
Received: from MN2PR11MB3711.namprd11.prod.outlook.com
 ([fe80::e8c0:cc46:c44f:4718]) by MN2PR11MB3711.namprd11.prod.outlook.com
 ([fe80::e8c0:cc46:c44f:4718%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 19:15:15 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v3 0/7] x86/intel_pmc_core: Add Tiger Lake, Elkhart Lake
Thread-Topic: [PATCH v3 0/7] x86/intel_pmc_core: Add Tiger Lake, Elkhart Lake
Thread-Index: AQHVmw09Ng4h5B/XbUSLQOyDkS2U/KeQxdyAgAB50+CAAATXAIAADIgw
Date:   Mon, 18 Nov 2019 19:15:15 +0000
Message-ID: <MN2PR11MB37115C1CFC4BA1930A7E63C3F24D0@MN2PR11MB3711.namprd11.prod.outlook.com>
References: <cover.1573750525.git.gayatri.kammela@intel.com>
 <CAHp75Vfrd-BAZ7H_LuQfz32yaap1X3gEnqZ2-9EPQ+j_b0f93g@mail.gmail.com>
 <MN2PR11MB3711EDFC967C295689E109DEF24D0@MN2PR11MB3711.namprd11.prod.outlook.com>
 <20191118182346.GB32742@smile.fi.intel.com>
In-Reply-To: <20191118182346.GB32742@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWM4NzI3ODAtZWMwZi00MzY4LWIwMzctY2ZiZmNjZTZiYTcyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMjJsbzErTFBQdzlBTzNsWWJtRENYVW9YV0VydjlDTVFcL1IxdnFZd2E5UGJITVVCSEtIR3oxYnVsOElzMWkydGwifQ==
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [192.55.52.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c3db2e3-ad1b-458a-9a3a-08d76c5ba48c
x-ms-traffictypediagnostic: MN2PR11MB3693:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3693E53DB6873036A0AE0A35F24D0@MN2PR11MB3693.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(66476007)(66556008)(64756008)(9686003)(6436002)(25786009)(8936002)(66946007)(478600001)(6506007)(476003)(256004)(14444005)(66446008)(71190400001)(102836004)(305945005)(71200400001)(186003)(33656002)(76116006)(7736002)(11346002)(74316002)(446003)(3846002)(14454004)(486006)(7696005)(76176011)(6116002)(26005)(2906002)(6246003)(4744005)(107886003)(55016002)(5660300002)(6916009)(4326008)(81156014)(99286004)(52536014)(316002)(81166006)(8676002)(229853002)(66066001)(86362001)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR11MB3693;H:MN2PR11MB3711.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6FhUWOW1MR4AbnJZRFH6SOqD2PVjWlt0Zm8XatebOpcIkIGp6eTHSN0dzHL6Dcn11bIuFsfitFzpuv79CJasYxaSEs3OIY1wtohlXi7y8UVimXA/lrm0RzhNkDCKfWxY8fXITm07dhNkiPYvfk0kO+phfmUCbMqXdwfI2hqyXlJEKOl/8H4hfZX3YelzBwrUGXVP39QanE0jSEBsM0IcsNYPmqs+C1Wn9l15zw9VuQSXrx9yLCMYE8MPO/MQrrYXSc3oRrOqD0wQpsq44eIrgXDhhGE3nQYy4aJvsSD2wtZXkM5Pfx3Q6At0EAVI3wwfLtWu+3kiO10Q1fre2BpqrL5RMkfHJYHSy7FCBzsAomCU1i7bW2+QTttaP2z3YP+QRMt43ISU5u35JXLh0BiWPSWfCV1o0JuxFmtwh4R5mXhUt5VzIqjoae6eB6mFQK2j
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3db2e3-ad1b-458a-9a3a-08d76c5ba48c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 19:15:15.3387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wxlGXYfD3TqX4tPBPJm33iBNHGwEQ1XQXCkAGTCrO3hMZqXu0UaRNxqSvGucb5VYui3XsN9EKWcjNZIiLqA9Pg/UW45RcTrB1FuZzty1RUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3693
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEhpIEFuZHkhIFNvcnJ5IEkgdGhpbmsgSSBtaXN1bmRlcnN0b29kIHlvdXIgY29tbWVudCBs
YXN0IHRpbWUuIEp1c3QgdG8NCj4gPiBtYWtlIHN1cmUsIHRoZSBwcmVmaXggc2hvdWxkIHRoZSBw
YXR0ZXJuIGluIHRoaXMgY2FzZQ0KPiA+ICJwbGF0Zm9ybS94ODY6IGludGVsX3BtY19jb3JlOiAi
IGFuZCBzaG91bGQgYmUgc2FtZSBmb3IgYWxsIHRoZSBwYXRjaGVzIGluDQo+IHRoZSBzZXJpZXMg
cmlnaHQ/DQo+IA0KPiBJIGRpZG4ndCBkZWVwbHkgY2hlY2sgbXlzZWxmLCBidXQgc291bmRzIHJp
Z2h0Lg0KVGhhbmtzIGZvciBjb25maXJtaW5nIQ0KPiANCj4gPiA+IEFsc28gY29uc2lkZXIgTWFy
aW8ncyBjb21tZW50IChJIGRpZG4ndCBoZWFyIGJhY2sgZnJvbSB5b3Ugb24gaXQpLg0KPiA+IFNv
cnJ5IGFib3V0IHRoYXQuIEkgYW0gcGxhbm5pbmcgb24gc2VuZGluZyBpdCBhIHNpbmdsZSBwYXRj
aCBleGNsdWRpbmcgaXQgZnJvbQ0KPiB0aGUgc2VyaWVzIHNpbmNlIHdlIHJlY2VpdmVkIGEgcmVx
dWVzdCBmcm9tIERlbGwuIFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UNCj4gdGhpbmsgdGhpcyBw
YXRjaCBzaG91bGQgYmUgaW5jbHVkZWQgaW4gdGhlIHNlcmllcy4NCj4gDQo+IEkgdGhpbmsgd2Ug
a2VlcCBnb29kIHJlbGF0aW9uc2hpcCB3aXRoIERlbGwuDQpZZWFoIPCfmIoNCkFuZHksIGJlZm9y
ZSBJIHNlbmQgb3V0IHY0IG9mIHRoaXMgc2VyaWVzICh3aXRoIHR3byBwYXRjaGVzIGRyb3BwZWQg
YW5kIGFkZHJlc3NpbmcgeW91ciBjb21tZW50IGFib3V0IHByZWZpeCksICBhcmUgdGhlcmUgYW55
IG5ldyBjb21tZW50cyBvbiB0aGUgcmVzdCBvZiBwYXRjaGVzPyBPciBzaGFsbCBJIGdvIGFoZWFk
IGFuZCBzdWJtaXQgdjQ/IFBsZWFzZSBzdWdnZXN0Lg0KDQo=
