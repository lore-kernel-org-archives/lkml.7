Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545A4C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2121522500
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="YygA7twT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbfI3Up0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:45:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:58620 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfI3UpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:45:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 11:23:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,568,1559545200"; 
   d="scan'208";a="190344117"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga008.fm.intel.com with ESMTP; 30 Sep 2019 11:23:53 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Sep 2019 11:23:53 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Sep 2019 11:23:52 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.55) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 30 Sep 2019 11:23:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbaWJzXg9aoKmRQoBvfrDw3B24XJZ8KLY+3PDuXMgDyITltsyqsYJHiKjYMEzr0vXfOFOUC1UzrlAwf5AK5csdNqa/vOLzYEol1M0G+MCqOLs+NNhUm0M36mNbOarFEdIuLNAk9lKLRDQpzNlkg+o74bcfbUdTR81Bk8Bw+rKV8YANgTyQb6pVtL1xCbNF3UOUh8L+X88pxDYLN/58fxP2k2PHvVi/0f4ysJ9ViHSNVh4Oy1p4cA9VQ/LsXlC8zX9ZVtJf9R+6QnJrdKPoeufMWWCtN7aso7SVsbbXJ1hSKosPlKJjUSMMrMrKYfW49lF8ufIS5j/IrRYyx86yKcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aK4FWLDnfSY9rH1UAZMZ1RyR822IidFk8SoWFAypLCU=;
 b=f5xARjp0JYkIPYj3rqRt9UXEHxSjtVzgqk3+Lrn8og92x6aoK0O5BPjXEjxwErSpt1/WiWocR1WA6U3MW5u5f17RKB6KM9w2W5Yjh0P6mMZfOmqiCEiTLBLbHMLF4ZrmIFbddsMsg+UPvted3h+IvN0Op4E4Ddt0ZEz4rvyrERq04h/ZR3OTTqQ93pBVmXVHvmdD2GxuBliCZzEnKhsZWXLlP0YY3IVxJlYyjtBHv5Ur9/71tdNlAp3e3lBskfFN3gF0MK55i5ICWHUs+P34ix/0p7qSuW4TvMcdrSXiveqEvGrAFwu/t7NL5YaVI+oZWMigrXoCDHM3znLVwttxng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aK4FWLDnfSY9rH1UAZMZ1RyR822IidFk8SoWFAypLCU=;
 b=YygA7twT67LIOMJanEhk9kMllPnuzSdCjhWpL7DkMS/t9sn9MO7NK8LtYVsLJm1zC5msmIh/ec5fsQvCKjvIypoU/wLe1KSm3llSwEUQAAOd9kfqq1XXTMxjrig/EBH0HqE+lA4jDjmgpCn6wIMTr0DkYBIZ+xj0/g7twCrF+cM=
Received: from BL0PR11MB3170.namprd11.prod.outlook.com (10.167.234.74) by
 BL0PR11MB3524.namprd11.prod.outlook.com (20.177.146.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 18:23:51 +0000
Received: from BL0PR11MB3170.namprd11.prod.outlook.com
 ([fe80::392e:e204:36d0:5351]) by BL0PR11MB3170.namprd11.prod.outlook.com
 ([fe80::392e:e204:36d0:5351%5]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 18:23:51 +0000
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
Thread-Index: AQHVdJpC9P0UAFBW3ky74xzBGKR04ac/CLOAgAWECKA=
Date:   Mon, 30 Sep 2019 18:23:50 +0000
Message-ID: <BL0PR11MB31709BA9A5F4E4F5455D913CF2820@BL0PR11MB3170.namprd11.prod.outlook.com>
References: <20190926192603.18647-1-gayatri.kammela@intel.com>
 <CAHp75Vcrp2ffDCE=tm2dwSEhwfPCPWGhb-Nw0v-7ga2y=_dL8w@mail.gmail.com>
In-Reply-To: <CAHp75Vcrp2ffDCE=tm2dwSEhwfPCPWGhb-Nw0v-7ga2y=_dL8w@mail.gmail.com>
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
x-originating-ip: [134.134.136.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8f17c2b-ed38-45fa-38d8-08d745d357df
x-ms-traffictypediagnostic: BL0PR11MB3524:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB35247EBDFF02BA236A67C5B4F2820@BL0PR11MB3524.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(376002)(366004)(39850400004)(189003)(199004)(86362001)(7736002)(305945005)(74316002)(476003)(446003)(14444005)(486006)(11346002)(256004)(316002)(54906003)(6916009)(8676002)(81156014)(66066001)(6116002)(2906002)(3846002)(102836004)(8936002)(81166006)(229853002)(53546011)(66476007)(66556008)(66446008)(64756008)(66946007)(76116006)(99286004)(6246003)(26005)(33656002)(5660300002)(71190400001)(52536014)(71200400001)(186003)(6506007)(76176011)(4744005)(4326008)(6436002)(9686003)(55016002)(25786009)(7696005)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR11MB3524;H:BL0PR11MB3170.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bWMFvdJMn9MDsT+HYbL+n2CfBa7Q/wp+11tvha+wGf6RZ5WlQaEJPhET3cOSbkquU7/sAB+/BS0uPujNHjaQNoS5i0gw0cBCxvWOPe72r/0NYee1/DUt7AHLaqTbeA4ZAPEA5hRPbVkuejicioD4mH2M0TVBCJS75J5tCSlH7LoHhi8E2/2OvdjPD2vBWg3qtEK0ux/c9OHCCs6EZZJqSJGvqOOQPv6l+eJd4mkqDTZUuCKonuXQY4/R3UQYYUNfKM8lMfFXtcnCx3BKur98xOdMl6KU8plKldvvAv8F65TS8101cwnzF7ym0u0Cfomgye8xkffNsmJoI/NKnVMU6SmqxaC25vOOfolwTKj00jHzenHOK3L1/y8MNKeZRSF88ppxEkFWZ4metFWC0xIS1DzI7hBYzjutOGKkigQyIvg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f17c2b-ed38-45fa-38d8-08d745d357df
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 18:23:50.8698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BPUJm01uT4/u/f/pi0YdWhFYMGJxolBsjMWXcjT5RbS3l+nRT+uWbXqHKkK6oi6cxcUSG21E50au7bWZMmx0zE4zlKh3Vr3PoVlq1SzOqlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3524
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUaHUsIFNlcCAyNiwgMjAxOSBhdCA5OjQzIFBNIEdheWF0cmkgS2FtbWVsYQ0KPiA8Z2F5
YXRyaS5rYW1tZWxhQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBz
ZXJpZXMsIEknbGwgY29tbWVudCB0aGVtIGxhdGVyLg0KVGhhbmsgeW91IEFuZHkhDQo+IA0KPiBG
b3Igbm93LCBjaGVjayBob3cgdG8gcHJvcGVybHkgc2V0dXAgcHJlZml4IGZvciBhbGwgcGF0Y2hl
cy4gVGhlIFRpdGxlIGFsbA0KPiBicm9rZW4uDQpJJ20gc29ycnkgYWJvdXQgdGhhdC4gSSB3aWxs
IGZpeCBpdCBpbiB2Mg0KPiANCj4gPiBQYXRjaCAxOiBDbGVhbnMgdXAgdGVybWluYXRpb24gbGlu
ZXMNCj4gPiBQYXRjaCAyOiBSZWZhY3RvciBkcml2ZXIgZm9yIGVhc2Ugb2YgYWRkaW5nIG5ldyBT
b0NzIFBhdGNoIDM6IFJlZmFjdG9yDQo+ID4gZGVidWdmcyBlbnRyeSBmb3IgUENIIElQcyBwb3dl
ciBnYXRpbmcgc3RhdHVzIFBhdGNoIDQ6IEFkZCBUaWdlciBMYWtlDQo+ID4gbGVnYWN5IHN1cHBv
cnQgdG8gcG1jX2NvcmUgUGF0Y2ggNTogQWRkIEVsa2hhcnQgTGFrZSBsZWdhY3kgc3VwcG9ydCB0
bw0KPiA+IHBtY19jb3JlDQo+ID4NCj4gPiBBbGwgdGhlIGluZm9ybWF0aW9uIHJlZ2FyZGluZyB0
aGUgUENIIElQcyBhbmQgbmFtZXMgb2YgSVBzIHdpbGwgYmUNCj4gPiBhdmFpbGFibGUgaW4gKmZ1
dHVyZSogSW50ZWwncyBQbGF0Zm9ybSBDb250cm9sbGVyIEh1YiAoUENIKSBFeHRlcm5hbA0KPiA+
IERlc2lnbiBTcGVjaWZpY2F0aW9uDQo+ID4gKEVEUykgZG9jdW1lbnQuDQo+IA0KPiBXaGVuPw0K
SSB3YXMgdG9sZCBpdCB3aWxsIGJlIGF2YWlsYWJsZSBpbiB0aGUgdXBjb21pbmcgcmVsZWFzZSBv
ZiBFRFMgZG9jdW1lbnQuIEkgYW0gbm90IGF3YXJlIG9mIHRoZSB0aW1lbGluZS4gSSB3aWxsIHVw
ZGF0ZSB0aGUgdGltZWxpbmUgaW4gdjIuDQoNCg==
