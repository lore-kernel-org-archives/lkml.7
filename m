Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4003C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 04:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A15220840
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 04:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="mADRDAGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKLEIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 23:08:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:63792 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfKLEIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 23:08:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 20:08:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,295,1569308400"; 
   d="scan'208";a="404112271"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga005.fm.intel.com with ESMTP; 11 Nov 2019 20:08:17 -0800
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 11 Nov 2019 20:08:16 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 11 Nov 2019 20:08:16 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.58) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 11 Nov 2019 20:08:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkVBwaZ+CU7AN16AlnLnRJztbIfB9RwsDD1/XCzr4oO4bZbNPLwe8xckBUpBNMTb2xzDxN8qHiQyXA2B6EcRIJJNL7fKgUNGoxoG7XcDDwJBWNZKkWmfIkMW7pJeNHIVwDVRd5URGAGyVSzttz9DQC+kx2+tStv8hvW/q37fr2DqPr/VBKd5HtKjLRaEOjqzdZFbeAayuo/QfRwuyLZ8y0jnBX018IguFK9rR4yULMH+U0XivsnoJkoT/FiTZQfRUvWGmEizuDN2IJ83aC8/0n27XVfh+C2yyoK7w1Ox6nDsWIvHXrHLS5AcWoi2BuiLO9I2pWMipXeZitK5xIzCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aLW1VmKa2QhToFGdFQYmLE97XyIyeDNU/Vox3y6+Cg=;
 b=KZShrUZ6eZFQOE3X9tKJ0XdtF1CUzKz7/LVzThGJFaU/vkW7eI4wwsBT3HknvY77R9WfQvlnqBVwsK4Pp6XzaOOckd4+CgqjQ7T09Zfhb5AaLHm1oWhfijRHJaY760nW+io8cWTqKr/PmOfElbUqD4GOqyhN3cSD7e9goTXqNQok+9I3EDyDUatDiXmr57dWq5wF3ypN860dw8CfCqwgRknBaeHRSsl+8/XTuxZNViSQcX4lAJq4c4cLZ2wH9nBBIjl5r9e2VdYFe4JgPqcCsttsRsvIA5aB7ZcBcwTFfHznXPjc4wZJX+bqk5LK/eVymoj7nDJtKmOn9VP2rMroew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aLW1VmKa2QhToFGdFQYmLE97XyIyeDNU/Vox3y6+Cg=;
 b=mADRDAGh7PlRF9iEozyGij6XBGqJB4Ot7OUalAkYQOEN8+AChWPma58C1qpyCuBmtmYa+2bw7kLjJhNmvx3uo2WFtph6FfCRe8QX032tk8gBZUYM2zDm22O+NT51MmsWPMrOkgkAKeXIM5bJx2L6a5yk9oXSqlplIYOtiTueWtw=
Received: from MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) by
 MN2PR11MB4303.namprd11.prod.outlook.com (52.135.37.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 04:08:01 +0000
Received: from MN2PR11MB3711.namprd11.prod.outlook.com
 ([fe80::e8c0:cc46:c44f:4718]) by MN2PR11MB3711.namprd11.prod.outlook.com
 ([fe80::e8c0:cc46:c44f:4718%7]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 04:08:00 +0000
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
Subject: RE: [PATCH v1 0/5] Add Tiger Lake/Elkhart Lake support to pmc_core
 driver
Thread-Topic: [PATCH v1 0/5] Add Tiger Lake/Elkhart Lake support to pmc_core
 driver
Thread-Index: AQHVdJpC9P0UAFBW3ky74xzBGKR04ac/CLOAgAWECKCAK+aHMIAPozaAgAcdnIA=
Date:   Tue, 12 Nov 2019 04:08:00 +0000
Message-ID: <MN2PR11MB371171B63CAA8272596DC2DDF2770@MN2PR11MB3711.namprd11.prod.outlook.com>
References: <20190926192603.18647-1-gayatri.kammela@intel.com>
 <CAHp75Vcrp2ffDCE=tm2dwSEhwfPCPWGhb-Nw0v-7ga2y=_dL8w@mail.gmail.com>
 <BL0PR11MB31709BA9A5F4E4F5455D913CF2820@BL0PR11MB3170.namprd11.prod.outlook.com>
 <MN2PR11MB37113F569E63A2CF3D2AC70BF2660@MN2PR11MB3711.namprd11.prod.outlook.com>
 <CAHp75Vc=+ZLLqv0_w6NzW5j8BLhCBVoNzFtQ7856c6WsogYTUg@mail.gmail.com>
In-Reply-To: <CAHp75Vc=+ZLLqv0_w6NzW5j8BLhCBVoNzFtQ7856c6WsogYTUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWE2ODBiYzMtOTVmMC00NzNhLThmYzMtZGQ4N2RlMGYyYTM0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiczdkVHhnSWo1RFRwWlZQS3dlclJTaHlaNXl6TmdjaUI0S2NcL3FEb2tEUFFFd3E3VDVTbER4UmlINGRCYWMxd3QifQ==
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [192.55.52.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96854c87-f203-4655-9534-08d76725e876
x-ms-traffictypediagnostic: MN2PR11MB4303:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB430331688433073333BD280DF2770@MN2PR11MB4303.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(376002)(39860400002)(346002)(189003)(199004)(478600001)(9686003)(6246003)(55016002)(256004)(53546011)(6506007)(33656002)(14454004)(25786009)(476003)(11346002)(446003)(186003)(66066001)(5660300002)(76176011)(26005)(486006)(7696005)(81166006)(74316002)(99286004)(66946007)(76116006)(4326008)(54906003)(8936002)(66556008)(2906002)(81156014)(4744005)(8676002)(66476007)(66446008)(305945005)(64756008)(7736002)(3846002)(6116002)(71190400001)(71200400001)(86362001)(316002)(6916009)(102836004)(6436002)(229853002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR11MB4303;H:MN2PR11MB3711.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bAcctcDcB6AD68eR8A+/wVh/jnlWEP7znUSe2yr7yq9TyTVLdXlfiZICLEIWLVr6umqUh+62zraDmQIrsHuI1Zj2umaIneDY/bTw518q1buAXM0XVkqmUheE8U+AUU343dM4vpNXOqV7yJiKAqQvIL0J08ZV1SQKHGsHkukq/UB7XaHb/LDVJ5CAR4teW+GhSF/C/tb3w/+doMnQHxElwmsddjZu4EcT0OVbvUsgb8fzmTLHflQqAfyjG9zMSescnlRO3XDvMUALuyi8+fOk/pcw1fuIMGp4m6FC3hcrp8HRw6g8z/09GmOGPqrqVAhGY54FD+YyBEqvRxydKBo93NGJniBurKlPLdO7ggTS2BXd+Ha3PSOCuZt0L6V9kfCm9Sn+8JbXIRKoPZ1XFJ+XMfr/xGyOvVJ44toxhIfoE8gJ0pDIv9iLUGip8+5VqEQh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 96854c87-f203-4655-9534-08d76725e876
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 04:08:00.4702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OpaVjPlxk62hUPp+9Ryn2efBVfvzn3yBeQWgDCF9Ee9D8X/1Lv+ai/ZS3pszCouFH96UpwX8kJPmccf45WPaOmQIMyylm0u2glx/KZYeV2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4303
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gU3ViamVjdDogUkU6IFtQQVRDSCB2MSAwLzVdIEFkZCBUaWdlciBMYWtlL0Vsa2hhcnQg
TGFrZSBzdXBwb3J0IHRvDQo+ID4gPiBwbWNfY29yZSBkcml2ZXINCj4gPiA+DQo+ID4gPiA+IE9u
IFRodSwgU2VwIDI2LCAyMDE5IGF0IDk6NDMgUE0gR2F5YXRyaSBLYW1tZWxhDQo+ID4gPiA+IDxn
YXlhdHJpLmthbW1lbGFAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmsg
eW91IGZvciB0aGUgc2VyaWVzLCBJJ2xsIGNvbW1lbnQgdGhlbSBsYXRlci4NCj4gPiA+IFRoYW5r
IHlvdSBBbmR5IQ0KPiA+ID4gPg0KPiA+DQo+ID4gSGkgQW5keSEgSSdtIHdvbmRlcmluZyBpZiB5
b3UgaGF2ZSBhbnkgY29tbWVudHMgZm9yIHRoaXMgcGF0Y2ggc2VyaWVzLg0KPiBUaGFua3MhDQo+
IA0KPiBQbGVhc2UsIGFkZHJlc3MgYWJvdmUgbWVudGlvbmVkIGNvbW1lbnRzIGFuZCBzZW5kIGEg
djIuIEknbGwgcHVzaCBpdCB0bw0KPiByZXZpZXcgYnJhbmNoLg0KDQpUaGFuayB5b3UgQW5keSEg
U29ycnkgZm9yIHRoZSBkZWxheS4gSSBzZW50IHYyIG9mIHRoZSBzZXJpZXMuIFRoYW5rcyENCg==
