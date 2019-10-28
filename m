Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2549DCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E212B20717
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="w3DuIVlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403807AbfJ1Ql1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:41:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:62152 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733000AbfJ1Ql1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:41:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 09:41:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,240,1569308400"; 
   d="scan'208";a="350728527"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga004.jf.intel.com with ESMTP; 28 Oct 2019 09:41:26 -0700
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 28 Oct 2019 09:41:26 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX161.amr.corp.intel.com (10.18.125.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 28 Oct 2019 09:41:26 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.59) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 28 Oct 2019 09:41:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPAKZ8R+lsUvV7OAZDcH8mI0BysOkXjibqbhAQXUTLjuK8x2uuto/d2HNLypUXSsCwpcQm4IB26F2XMIdBDbT6dWdvCY2oDrMxlKR/TKCEAWjYbb5jBw61OjTJ6Gx5REX8Ckz7CsX5qggj4kU9V2szOjzR75PnAKyIffZWMhSI/J/Ip34+2Thf2ezOK1wE/XrjmHXO86SvtDJKOl2qQapiCwHKHwEhCB20dLL5H8rUF2CTg0C7ODODMlVuOWg6tsObrwpzTD7uTlerax3nLh8D9E2LufpNIhH7NjGSH7p/kIE8lE1xr30wPLUu68sEtcCCj36T65rqE1+YnODW6SqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udJ6kC3dussE6f9OfC9XeyAhiTsWpCgDNIIk4rgjChg=;
 b=Zidoh97yp/kjUpTTloYFwWQnGWm+/8WWmm3JtGObVfDEDBe7MRKUi90foH6awR/ep5zpxrfJ4Z4PRY6/csib469MGo6gRm8dRKWwmFpveQUwxyZPyHhGdBHu1ZbVtXaGDT1Gu2Il9520P2BUm4XkPOM/wdfOZ425Yte87BdTGxDxlOtwnuJHD/8qLK7AHCUghFEDhycem2XTZf1zARE6/sfFh9pFTD4vkFckZJzT9/ATKOc8WiLS6Vk27zFxN4oqvup5TmXKqG+JgyBPthOY9z13KUixj6kY1TuHd0BXCXvv6j0UAf63BnOwdBxEd+lr/TdbPTaZkMUMKn1yhi/3Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udJ6kC3dussE6f9OfC9XeyAhiTsWpCgDNIIk4rgjChg=;
 b=w3DuIVlzJ7NzN9NvhfwVEYxb7KNxKABGE4aW34lB3bdIW3D1UfIeLYzdd92Tbclp6VhboLWURCMErG+rl861mHWyORBY62OwKJqjVdVoc7PRJWGJmHlGU2GwgR7J1c8V3LiaBVzxzj4TPva1Is6yBnjbRBdvaOCfG4kzNwsaBE4=
Received: from MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) by
 MN2PR11MB3981.namprd11.prod.outlook.com (20.179.151.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 28 Oct 2019 16:41:24 +0000
Received: from MN2PR11MB3711.namprd11.prod.outlook.com
 ([fe80::e8c0:cc46:c44f:4718]) by MN2PR11MB3711.namprd11.prod.outlook.com
 ([fe80::e8c0:cc46:c44f:4718%7]) with mapi id 15.20.2387.021; Mon, 28 Oct 2019
 16:41:24 +0000
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
Thread-Index: AQHVdJpC9P0UAFBW3ky74xzBGKR04ac/CLOAgAWECKCAK+aHMA==
Date:   Mon, 28 Oct 2019 16:41:24 +0000
Message-ID: <MN2PR11MB37113F569E63A2CF3D2AC70BF2660@MN2PR11MB3711.namprd11.prod.outlook.com>
References: <20190926192603.18647-1-gayatri.kammela@intel.com>
 <CAHp75Vcrp2ffDCE=tm2dwSEhwfPCPWGhb-Nw0v-7ga2y=_dL8w@mail.gmail.com>
 <BL0PR11MB31709BA9A5F4E4F5455D913CF2820@BL0PR11MB3170.namprd11.prod.outlook.com>
In-Reply-To: <BL0PR11MB31709BA9A5F4E4F5455D913CF2820@BL0PR11MB3170.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDA0MDYzNmItYWRhOC00MmYxLWJkZTAtZmUyYzI2MWVjYzA1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiM2NcL213ZmpROStyZXA1ZkhKK1BcLzVzRGZRTUtrVlVMOCtJUWpCM0MxT2NpZnRraXpWZUlteWQxb1wvUVBTc05yZiJ9
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [192.55.52.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfeccb53-b730-49a5-fa18-08d75bc5abb2
x-ms-traffictypediagnostic: MN2PR11MB3981:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3981FDBAD3DE73CF6A89D942F2660@MN2PR11MB3981.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(136003)(39860400002)(346002)(13464003)(199004)(189003)(81156014)(7696005)(66066001)(81166006)(64756008)(52536014)(66476007)(66556008)(66446008)(6916009)(6436002)(5660300002)(66946007)(4326008)(9686003)(4744005)(74316002)(478600001)(54906003)(316002)(55016002)(8676002)(8936002)(25786009)(14454004)(256004)(76176011)(102836004)(71190400001)(71200400001)(76116006)(6116002)(33656002)(6246003)(3846002)(11346002)(53546011)(86362001)(476003)(99286004)(186003)(2906002)(7736002)(229853002)(6506007)(446003)(486006)(26005)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR11MB3981;H:MN2PR11MB3711.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cDJDJyM2VEVss5x/tV23zGPrEAxe94p4GoMniyHMTQ9Dq9Pj/rmn/nXKAXJ1fDNyBeHKKj1v8VxtL9oQAX/GXYhLGexGquw1/4sfbYRw8VqXWQXlgmTqAykHvFvOVKTEaoDFBk7YRKWZzB3yANbTStdGZQfiQi7QPNS5gfKC20ow1Ht/V6j2Yau1SZo2gZrOV/U4quQJ/APswuCO5dm1Al3hSiyas3nNEu5eIPwo7uaDe9YTXKBMlMy/ZMvO5X2Z/KcfaTg6PT8Occ1VMgAF/eZS6LS1Ot9kSeIHLFUwxPpl9h9xHwF3zezhlN8Fio04g5Y1+ZZyAnPv8xFYKvyPpmTXPVL1YJfrpRx4UmGZIAjwMwab2ngJpxGeaFhIzk0GKaq7IOFECG4SvNTu7y7yFlHBO8qJYMDV6L3kSST9hEv+c51Zo4/2dytUdRPTq8zl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bfeccb53-b730-49a5-fa18-08d75bc5abb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 16:41:24.1493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OqWWpda2i8u2XoRNUei6GwnUHc5yAjSrXVPqrEUTt4lBNuxR8o8nUR03R6OPqvYNp5TXRPJ57fTV6xA43ub31iJB4nbj36eJXpn85Uve9uA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3981
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLYW1tZWxhLCBHYXlhdHJpDQo+
IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDMwLCAyMDE5IDExOjI0IEFNDQo+IFRvOiBBbmR5IFNo
ZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IENjOiBQbGF0Zm9ybSBEcml2
ZXIgPHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnPjsgU29tYXlhamksDQo+IFZp
c2h3YW5hdGggPHZpc2h3YW5hdGguc29tYXlhamlAaW50ZWwuY29tPjsgRGFycmVuIEhhcnQNCj4g
PGR2aGFydEBpbmZyYWRlYWQub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBQcmVzdG9waW5lLCBDaGFybGVzIEQNCj4gPGNo
YXJsZXMuZC5wcmVzdG9waW5lQGludGVsLmNvbT47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz47DQo+IFBhbmRydXZhZGEsIFNyaW5pdmFzIDxzcmluaXZhcy5wYW5kcnV2YWRh
QGludGVsLmNvbT47IEFuZHkgU2hldmNoZW5rbw0KPiA8YW5kcml5LnNoZXZjaGVua29AbGludXgu
aW50ZWwuY29tPjsgTGlhbmcsIEthbiA8a2FuLmxpYW5nQGludGVsLmNvbT47DQo+IEJveCwgRGF2
aWQgRSA8ZGF2aWQuZS5ib3hAaW50ZWwuY29tPjsgQmhhcmR3YWosIFJham5lZXNoDQo+IDxyYWpu
ZWVzaC5iaGFyZHdhakBpbnRlbC5jb20+OyBMdWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29t
Pg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYxIDAvNV0gQWRkIFRpZ2VyIExha2UvRWxraGFydCBM
YWtlIHN1cHBvcnQgdG8gcG1jX2NvcmUNCj4gZHJpdmVyDQo+IA0KPiA+IE9uIFRodSwgU2VwIDI2
LCAyMDE5IGF0IDk6NDMgUE0gR2F5YXRyaSBLYW1tZWxhDQo+ID4gPGdheWF0cmkua2FtbWVsYUBp
bnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhhbmsgeW91IGZvciB0aGUgc2VyaWVzLCBJJ2xs
IGNvbW1lbnQgdGhlbSBsYXRlci4NCj4gVGhhbmsgeW91IEFuZHkhDQo+ID4NCg0KSGkgQW5keSEg
SSdtIHdvbmRlcmluZyBpZiB5b3UgaGF2ZSBhbnkgY29tbWVudHMgZm9yIHRoaXMgcGF0Y2ggc2Vy
aWVzLiBUaGFua3MhDQo=
