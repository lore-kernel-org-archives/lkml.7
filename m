Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AEEC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A762195D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="TiJrYAy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKRSLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 13:11:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:52731 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfKRSLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 13:11:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 10:11:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="204271701"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga007.fm.intel.com with ESMTP; 18 Nov 2019 10:11:19 -0800
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 Nov 2019 10:11:19 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 Nov 2019 10:11:18 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.57) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 18 Nov 2019 10:11:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GN2Uxq93iLNrCbGVkCYtbfIkPRJzo3/efwZc+otHt/iQKj5JG68gHHfH2Bw1ehO0JQo9tPvZ6dGs3I7GiE0ZztxsWK8oGmUSNCJ3Xcss+zZKhjRd5/hArREp6ZltWUQLX+kr9gPVlrs00oydHA/2DB9S/EreX60cFA/nafcivh5lPApbTo0T54OtGDYQmu6N5l4r0QGSF3sZVYZmuAlpkW/VE2rvmRnCWjYfrJjFoStuOzaLFcYa1DJhDU0Lt4e6Uw1BARWa9Z0AkzH5EDDnGfid+IYGvycf9ngMdt+TT1MRh/yvgF+LKymo9eBRPjWpC/dKUC2o2FP1t/89ILAoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijYLgXB9cJ4wamXaQV6GC+S7dDn7nQ3c+JKbKTNQZMQ=;
 b=Mk5ljxKQc9kpEymYjaSeW4DIDxj6TAHMhcWPBiNwRgBp0jh1IGgXfXvyb8e8/2QBml5tVi0ux9Ln5d4n4YwJ/UBfy0a2TUSZFFA56LL5z86qSK3LyGC+YDm0jrzyMT/MFkeRv+1QDGhRObXl7zOhoHOGCzgoyoqVJPR0VmsC/mPyZhD0q6EFEKeFidHDB06tLBJqCBBlYPRzEFG/AdOadeZvcSVGO4FtpDNBf1lxetz4lRiDZdcNKAmUMXB2QX+VS17yt2jtlbJu9a9WQzHb9Sdmzv6f/SCTHj0fV7yxRBha9g/xk0Uui1tCRyzwbd674TRNRYXcIl9F0UGjj2XsZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijYLgXB9cJ4wamXaQV6GC+S7dDn7nQ3c+JKbKTNQZMQ=;
 b=TiJrYAy264JLr2iBLDLiDuamaY6Kk66vtXiPPp7cjh+o+EotBPOfCJMPSkojKNTn4SoVGre/FnerQpH8VVISdUVIi5u+XbcwMBCx6kmSkeEV713Xh6jXSgwBkqlipiw648xpjjZSK5YW1B1jjVwvGdqT9DWdN7+goUIvXKcBhfo=
Received: from MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) by
 MN2PR11MB3568.namprd11.prod.outlook.com (20.178.251.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Mon, 18 Nov 2019 18:11:17 +0000
Received: from MN2PR11MB3711.namprd11.prod.outlook.com
 ([fe80::e8c0:cc46:c44f:4718]) by MN2PR11MB3711.namprd11.prod.outlook.com
 ([fe80::e8c0:cc46:c44f:4718%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 18:11:17 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v3 0/7] x86/intel_pmc_core: Add Tiger Lake, Elkhart Lake
Thread-Topic: [PATCH v3 0/7] x86/intel_pmc_core: Add Tiger Lake, Elkhart Lake
Thread-Index: AQHVmw09Ng4h5B/XbUSLQOyDkS2U/KeQxdyAgAB50+A=
Date:   Mon, 18 Nov 2019 18:11:16 +0000
Message-ID: <MN2PR11MB3711EDFC967C295689E109DEF24D0@MN2PR11MB3711.namprd11.prod.outlook.com>
References: <cover.1573750525.git.gayatri.kammela@intel.com>
 <CAHp75Vfrd-BAZ7H_LuQfz32yaap1X3gEnqZ2-9EPQ+j_b0f93g@mail.gmail.com>
In-Reply-To: <CAHp75Vfrd-BAZ7H_LuQfz32yaap1X3gEnqZ2-9EPQ+j_b0f93g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmE4NzFjNDQtY2MwMS00OTgwLTgwNDEtMmI2YWE4OTg4Y2QwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVXFtSzN4ZmNcLzNmUzY1bXloWHR1ZjhPZDI1MUtkZm8yXC9RWVBBMkJIbndnTUZBQyt1RnZmUWhrb3lJWDFQSk9XIn0=
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [192.55.52.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2fb3425-23b1-4c69-b190-08d76c52b4c7
x-ms-traffictypediagnostic: MN2PR11MB3568:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3568D86A2587387565EB9B09F24D0@MN2PR11MB3568.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(396003)(39860400002)(376002)(189003)(199004)(6436002)(14444005)(316002)(6506007)(99286004)(186003)(26005)(74316002)(102836004)(7736002)(66066001)(76176011)(4326008)(4744005)(71200400001)(71190400001)(5660300002)(14454004)(81156014)(81166006)(6916009)(8676002)(305945005)(86362001)(478600001)(7696005)(6246003)(2906002)(9686003)(8936002)(52536014)(33656002)(11346002)(76116006)(6116002)(3846002)(229853002)(54906003)(256004)(486006)(25786009)(66446008)(446003)(64756008)(476003)(66946007)(66476007)(66556008)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR11MB3568;H:MN2PR11MB3711.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yfZ4y+AIDicqPrqoc+Oc7Oxcz67WQCMWSeMSwifHgxX+6L0UsfuyekZMA6g4Bs/zuxPGeOMjUTuhndT2562UVBYOrjEhyxjw7OHy4OwxBEM/doFAxJjMBT4GOlPYKpCDB0bBD3h6ofdKHrcEDNddxUHICtCnrzet3lxUSbFTwUynE0eaxFPhorPSQBU/RfULTi6DNU8bcX12IrafD7HqP0jd1YNt7RSTz/gzuELKgOPLzIGxCrVKqMrbj4DaAnlvDPFovt1FhP0Zeb1zRAp3Pvbv97JM2b01SQMktiGuj8AzQ8Z8ur2FZqCj7qtcfXd6XUewqisf1nfdVnhA+t1UlgQbmtoLT5WRg4Rz+xkXWJaZJ+KnQoDMwmqBL0zntek8YyaXOu9bf73jYuk6dTCp5zAD6NyTKkLOG+XPbzgHKJTShItvhD4BD2wINK9iR3kb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fb3425-23b1-4c69-b190-08d76c52b4c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 18:11:17.0439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TAhPGN/2LF8X2M8jcszvdy6u0bDqY9uztfiizeHSs/tdGDNNox3DkT1tu1q/xziuHybAAHdyBN1E7tc7CZwFt1eB6jmsBbp9jmBTXB3GLb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3568
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEFsbCB0aGUgaW5mb3JtYXRpb24gcmVnYXJkaW5nIHRoZSBQQ0ggSVBzIGFuZCBuYW1lcyBv
ZiBJUHMgd2lsbCBiZQ0KPiA+IGF2YWlsYWJsZSBpbiBJbnRlbCdzIFBsYXRmb3JtIENvbnRyb2xs
ZXIgSHViIChQQ0gpIEV4dGVybmFsIERlc2lnbg0KPiA+IFNwZWNpZmljYXRpb24gKEVEUykgZG9j
dW1lbnQgZXhwZWN0ZWQgdG8gYmUgcmVsZWFzZWQgaW4gMjAyMCBiZWZvcmUNCj4gPiBwcm9kdWN0
IGxhdW5jaC4NCj4gDQo+IFRoYW5rcywgdGhvdWdoIHlvdSBmb3Jnb3QgdG8gZml4IGFsbCBwcmVm
aXhlcyBpbiB0aGUgbWFpbHMuIFdlIGhhdmUNCj4gcGxhdGZvcm0veDg2OiAkRFJJVkVSX05BTUU6
IC4uLg0KPiANCkhpIEFuZHkhIFNvcnJ5IEkgdGhpbmsgSSBtaXN1bmRlcnN0b29kIHlvdXIgY29t
bWVudCBsYXN0IHRpbWUuIEp1c3QgdG8gbWFrZSBzdXJlLCB0aGUgcHJlZml4IHNob3VsZCB0aGUg
cGF0dGVybiBpbiB0aGlzIGNhc2UNCiJwbGF0Zm9ybS94ODY6IGludGVsX3BtY19jb3JlOiAiIGFu
ZCBzaG91bGQgYmUgc2FtZSBmb3IgYWxsIHRoZSBwYXRjaGVzIGluIHRoZSBzZXJpZXMgcmlnaHQ/
DQoNCj4gQWxzbyBjb25zaWRlciBNYXJpbydzIGNvbW1lbnQgKEkgZGlkbid0IGhlYXIgYmFjayBm
cm9tIHlvdSBvbiBpdCkuDQpTb3JyeSBhYm91dCB0aGF0LiBJIGFtIHBsYW5uaW5nIG9uIHNlbmRp
bmcgaXQgYSBzaW5nbGUgcGF0Y2ggZXhjbHVkaW5nIGl0IGZyb20gdGhlIHNlcmllcyBzaW5jZSB3
ZSByZWNlaXZlZCBhIHJlcXVlc3QgZnJvbSBEZWxsLiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91
IHRoaW5rIHRoaXMgcGF0Y2ggc2hvdWxkIGJlIGluY2x1ZGVkIGluIHRoZSBzZXJpZXMuIA0K
