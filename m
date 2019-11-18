Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CB9C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60129222F6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="c+mZO+cL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKRTMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:12:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:59060 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfKRTMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:12:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 11:12:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="237037144"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga002.fm.intel.com with ESMTP; 18 Nov 2019 11:12:46 -0800
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 Nov 2019 11:12:46 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx124.amr.corp.intel.com (10.18.125.39) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 Nov 2019 11:12:46 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.59) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 18 Nov 2019 11:12:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvPiuvtZ/e1tJ1NFIPZJaeFUuqMWMLurdGPLBxh4vHH+pK52r0AOK2tiXDj612cGtzEofO5aGY0nTsck8XtgHywVtw8DpWOnXhLZBvhThbn5IijiVrJ+XIUBdysgWQr66bvGqINVSwoiXCPlU0nM0QCmPK+tUclLr+kYAScplJLkTqESHT38oFAwRgKkQMhffn/YbIVnHcXm1ZLJZeyi91hNaI4hgkhwlu1pa1WP5mwGgouIW7Y9U+uJUbihVaFrI1EKtSr3G4qGptkz3QBcbmNeE8nuQbnx8UxVYSiMOnEfOqNtmBCwKBb+5PkugNZC7CWjcDhKA8vQDjmi7Yc2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8tZPUMUgd5WPtWfA6V/f78dSsZlqPP2dXwzva08JxU=;
 b=FYJckcxQwrdrpsi/Fk4FPNoKKoXi+ZuPBCYUnqUBq/6ug7553gv8+XoM239B9IIHGMPWdGNikY7A0cJdM5qMHUS/FSHgnbXTeA3nJN+brwdXzxTOjBSxXYO5e9GEzABiumE9EKwOnD2iO88t0YCJPZXUz6uPH8J1Fto1KURFVjD0Up49TyMkCMLewVwxt5z9y5nkXR3DeVBbY0Py3P20cO6yoGmVnFvtu95IeVLWrqO6nBIUDPqb2Yh/694RK+bOeL0eTAkZWUk0+5moof2kRmVsD4jauh3JkNoC180fIhZEJ44lfikhW6Bv/c23C0ik/mdBkY7c6Z8d4XsL9/xU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8tZPUMUgd5WPtWfA6V/f78dSsZlqPP2dXwzva08JxU=;
 b=c+mZO+cLDMmpPwjKzWjCcGYsCA8mTXdOzlJk7kOzqs0h8mhDd/Lx8Pp0V1dcCF7pJsa6r3+dyY6DiD1/QZsCmEbwVr0rs806fki+QgHyA8CR0ITEGeewvVa3J86b/yd2aWmVR/7XGFt6PmYFktqg7S98YDhU0ndLJ5zKoncsGQ0=
Received: from MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) by
 MN2PR11MB3693.namprd11.prod.outlook.com (20.178.252.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Mon, 18 Nov 2019 19:12:28 +0000
Received: from MN2PR11MB3711.namprd11.prod.outlook.com
 ([fe80::e8c0:cc46:c44f:4718]) by MN2PR11MB3711.namprd11.prod.outlook.com
 ([fe80::e8c0:cc46:c44f:4718%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 19:12:28 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v3 0/7] x86/intel_pmc_core: Add Tiger Lake, Elkhart Lake
Thread-Topic: [PATCH v3 0/7] x86/intel_pmc_core: Add Tiger Lake, Elkhart Lake
Thread-Index: AQHVmw09Ng4h5B/XbUSLQOyDkS2U/KeQxdyAgAB50+CAAAN4gIAADjyw
Date:   Mon, 18 Nov 2019 19:12:28 +0000
Message-ID: <MN2PR11MB3711A3644CE2D81392F8F0F6F24D0@MN2PR11MB3711.namprd11.prod.outlook.com>
References: <cover.1573750525.git.gayatri.kammela@intel.com>
 <CAHp75Vfrd-BAZ7H_LuQfz32yaap1X3gEnqZ2-9EPQ+j_b0f93g@mail.gmail.com>
 <MN2PR11MB3711EDFC967C295689E109DEF24D0@MN2PR11MB3711.namprd11.prod.outlook.com>
 <9b880cb6585d4608814598517fe5d675@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <9b880cb6585d4608814598517fe5d675@AUSX13MPC105.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTU3NDFlNGYtOTQ3MC00MzAyLWI4NjktNGI5MzMzYzFhMmU1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMTJ4R1c0bGNnZkdOVTBiSnBYM0N3c0VsSTlEZXVzUnFPanpJUEl0OXM2bXhwS3hmMkY4YjdDejh5VkZMMk9pSiJ9
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [192.55.52.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e4f64ae-596a-42c1-e10c-08d76c5b412c
x-ms-traffictypediagnostic: MN2PR11MB3693:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3693B66F0B799E339B547CF0F24D0@MN2PR11MB3693.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(66476007)(66556008)(64756008)(9686003)(6436002)(25786009)(8936002)(66946007)(478600001)(6506007)(476003)(256004)(14444005)(66446008)(71190400001)(102836004)(305945005)(71200400001)(186003)(33656002)(76116006)(7736002)(11346002)(74316002)(446003)(3846002)(14454004)(486006)(7696005)(76176011)(6116002)(26005)(2906002)(6246003)(4744005)(55016002)(5660300002)(4326008)(81156014)(99286004)(52536014)(316002)(81166006)(8676002)(229853002)(66066001)(86362001)(54906003)(2501003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR11MB3693;H:MN2PR11MB3711.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uXm82nfW+P51eqX4TIkqYH3fRD8OtwPPGwbjDL3P0aBEudScqC7EnytzxbfaqhJSuYd1/CacoP/AahJsrdRuN75ZfDO4rBSJNZo3qPhd5v9EgPa/7pCnREoanpds8LCdMSla5H3+knnows5qIKi+t3FH/CYPIhUGNLosCfd1glbVjmeAWlLKCdL7NI0nCXiKMMoo5rLyW8ia7XyDfjFR7q5Gznheb2CUCAGWtuJSL9AAF6DRMIbZGxn6ABfXui7sZKs/CrmaJ4FxVvQKTwAEMtaAE/mEY45YRhiY14wYhlci3N1pkZdK5mem1DEKt5YEi50zRlVMO4/ROBDIPnkWfVdmrr/Q4zDOND8m8J2Qbq5dz8mxJb1pbd0byF8ogZPMlc9H5hhrfXbQhrgOyXlUDCXNvhsmuyjh0RTrHTyLdxDlzdA9NQDSAFCl4LodVf1u
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4f64ae-596a-42c1-e10c-08d76c5b412c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 19:12:28.5639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JkIKn7w/RzWr3MTdt/XoR5zJFYkcx/zUuGu76JKlHPh9s6iGJ+nsFJeQWZABQT9S6IRoJmb6L5dvoREsaVwQFWYgtZ0tHKuWHxxNhK2Dq5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3693
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gPiBBbHNvIGNvbnNpZGVyIE1hcmlvJ3MgY29tbWVudCAoSSBkaWRuJ3QgaGVhciBi
YWNrIGZyb20geW91IG9uIGl0KS4NCj4gPiBTb3JyeSBhYm91dCB0aGF0LiBJIGFtIHBsYW5uaW5n
IG9uIHNlbmRpbmcgaXQgYSBzaW5nbGUgcGF0Y2ggZXhjbHVkaW5nDQo+ID4gaXQgZnJvbSB0aGUg
c2VyaWVzIHNpbmNlIHdlIHJlY2VpdmVkIGEgcmVxdWVzdCBmcm9tIERlbGwuIFBsZWFzZSBsZXQN
Cj4gPiBtZSBrbm93IGlmIHlvdSB0aGluayB0aGlzIHBhdGNoIHNob3VsZCBiZSBpbmNsdWRlZCBp
biB0aGUgc2VyaWVzLg0KPiANCj4gSnVzdCB0byBtYWtlIGl0IGNsZWFyIHRvIHRob3NlIG9uIHRo
ZSBsaXN0IC0gdGhlIHJlcXVlc3QgZnJvbSBEZWxsIHdhcyBvZmYgbGlzdA0KPiBhbmQgc2VwYXJh
dGVseSBmcm9tIG15IGNvbW1lbnQgaW4gYWRqdXN0aW5nIHRoZSBvcmRlcmluZy4gIEEgY29udmVu
aWVudA0KPiBzaWRlIGVmZmVjdCBpcyB0aGF0IGl0IHdpbGwgdGFrZSBpbnRvIGNvbnNpZGVyYXRp
b24gbXkgY29tbWVudCB0b28gOikNCkkgaGF2ZSBqdXN0IHNlbnQgdjEgb2YgQ29tZXQgTGFrZSBw
YXRjaCBpbiBhIG5ldyBzZXJpZXMuIFRoYW5rcyBNYXJpbyEg8J+Yig0K
