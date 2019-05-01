Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CDAC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE759204EC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="SpLz1/hY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEAOWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 10:22:15 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:51455 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfEAOWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 10:22:15 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Don.Brace@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Don.Brace@microchip.com";
  x-sender="Don.Brace@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Don.Brace@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Don.Brace@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,418,1549954800"; 
   d="scan'208";a="32746201"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 May 2019 07:22:13 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 1 May 2019 07:22:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50vmknJVvRDmPCbJnyejZDcdjeIQuxMGhiRz14l3S/A=;
 b=SpLz1/hYqX7qfmaFCe7IFchP+T8JfUJdNorU5/H9mi8lU/NeXCWXi9OinwRh9WPnZ61waf2/pw5t03Gq7OaIT/AWbu5g4PAc8e8/wVA9N4OsFEjEjeYssu7Cb0x4quK/BFFrYyT+eOEOhr7i3YEo8kJ7htyKsQCE6f6mjzensL0=
Received: from SN6PR11MB2767.namprd11.prod.outlook.com (52.135.92.154) by
 SN6PR11MB2944.namprd11.prod.outlook.com (52.135.124.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Wed, 1 May 2019 14:22:11 +0000
Received: from SN6PR11MB2767.namprd11.prod.outlook.com
 ([fe80::1156:dec2:39e1:38d]) by SN6PR11MB2767.namprd11.prod.outlook.com
 ([fe80::1156:dec2:39e1:38d%4]) with mapi id 15.20.1835.018; Wed, 1 May 2019
 14:22:11 +0000
From:   <Don.Brace@microchip.com>
To:     <erwanaliasr1@gmail.com>
CC:     <e.velu@criteo.com>, <don.brace@microsemi.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <esc.storagedev@microsemi.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: smartpqi: Reporting unhandled SCSI errors
Thread-Topic: [PATCH] scsi: smartpqi: Reporting unhandled SCSI errors
Thread-Index: AQHU38uXoZs0A2zxv06Dd6XfxkS+HqY1WkmAgCE4dZA=
Date:   Wed, 1 May 2019 14:22:11 +0000
Message-ID: <SN6PR11MB2767E3FB513853E9666779B9E13B0@SN6PR11MB2767.namprd11.prod.outlook.com>
References: <20190321094928.4198-1-e.velu@criteo.com>
 <CAL2JzuyHb_gfu5Suf3yaMF1883JN1667yhEwpdmoiqYrUTO2YA@mail.gmail.com>
In-Reply-To: <CAL2JzuyHb_gfu5Suf3yaMF1883JN1667yhEwpdmoiqYrUTO2YA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.54.225.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82991a16-5c29-4546-6638-08d6ce406688
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN6PR11MB2944;
x-ms-traffictypediagnostic: SN6PR11MB2944:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR11MB29446EB15EA55FB6DD84C861E13B0@SN6PR11MB2944.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 00246AB517
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(376002)(346002)(13464003)(199004)(189003)(1411001)(7696005)(14454004)(966005)(6116002)(3846002)(478600001)(72206003)(2906002)(102836004)(6506007)(86362001)(316002)(186003)(66066001)(26005)(9686003)(6306002)(55016002)(53936002)(229853002)(74316002)(6246003)(7736002)(305945005)(25786009)(54906003)(11346002)(99286004)(66556008)(66946007)(64756008)(486006)(4326008)(446003)(68736007)(52536014)(33656002)(8936002)(476003)(6916009)(5660300002)(8676002)(6436002)(81166006)(81156014)(71190400001)(71200400001)(256004)(76176011)(73956011)(66446008)(66476007)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB2944;H:SN6PR11MB2767.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5rIF8oeTEqcuoXwNfU2EGPLYzTwmskxePIDHWXgt+klIMG9ZOHsTgqmutZEkiT1F2QN8gI2jn2dk3j9WgB7YNCldJ4hhbZSbrCiWzT5xr1L5Jsx4CjFGrC9+z4304Wf5oq/aD5gpzkSmhloqXXpYd9K9NNJ8h9GYgwrLFaC4YMiprFlmpdNLqPa0uoRvbyi39OnNOn57unosEZ8hYgQZ7Vnl2adTxV8dSATa99pQ3jgN5mD3ydovwn+suyR9QVteATV5pgzzilK/96WKa9yuZWUxz7ob61f8XJyza1Ja9eqG1PMcVNIfkp9Hd1596dm+OvwFq08NSUJQ8q2DuBWSVHkhEkpJ4TUshDj6fHH+0lZwEVlRsle0NEJC9U3y1YYItIkCjvqqDppeeHtS+D9+So+zGhKlSw37d7H0eSD4U/0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 82991a16-5c29-4546-6638-08d6ce406688
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2019 14:22:11.1366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2944
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGxpbnV4LXNjc2ktb3duZXJAdmdlci5r
ZXJuZWwub3JnIFttYWlsdG86bGludXgtc2NzaS1vd25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJl
aGFsZiBPZiBFcndhbiBWZWx1DQpTZW50OiBXZWRuZXNkYXksIEFwcmlsIDEwLCAyMDE5IDY6MDMg
QU0NCkNjOiBFcndhbiBWZWx1IDxlLnZlbHVAY3JpdGVvLmNvbT47IERvbiBCcmFjZSA8ZG9uLmJy
YWNlQG1pY3Jvc2VtaS5jb20+OyBKYW1lcyBFLkouIEJvdHRvbWxleSA8amVqYkBsaW51eC5pYm0u
Y29tPjsgTWFydGluIEsuIFBldGVyc2VuIDxtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbT47IG9w
ZW4gbGlzdDpNSUNST1NFTUkgU01BUlQgQVJSQVkgU01BUlRQUUkgRFJJVkVSIChzbWFydHBxaSkg
PGVzYy5zdG9yYWdlZGV2QG1pY3Jvc2VtaS5jb20+OyBvcGVuIGxpc3Q6TUlDUk9TRU1JIFNNQVJU
IEFSUkFZIFNNQVJUUFFJIERSSVZFUiAoc21hcnRwcWkpIDxsaW51eC1zY3NpQHZnZXIua2VybmVs
Lm9yZz47IG9wZW4gbGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NClN1YmplY3Q6
IFJlOiBbUEFUQ0hdIHNjc2k6IHNtYXJ0cHFpOiBSZXBvcnRpbmcgdW5oYW5kbGVkIFNDU0kgZXJy
b3JzDQoNCkhpIHRoZXJlICENCkFueSByZWFjdGlvbnMgdG8gdGhpcyBvbmUgPyBJIGRpZG4ndCBn
b3QgYSBzaW5nbGUgY29tbWVudC4NCkNoZWVycywNCkVyd2FuLA0KDQpMZSBqZXUuIDIxIG1hcnMg
MjAxOSDDoCAxMDo0OSwgRXJ3YW4gVmVsdSA8ZXJ3YW5hbGlhc3IxQGdtYWlsLmNvbT4gYSDDqWNy
aXQgOg0KPg0KPiBXaGVuIGEgSEFSRFdBUkVfRVJST1IgaXMgdHJpZ2dlcmVkIGZvciBhc2M9MHgz
ZSwgdGhlIGFjdHVhbCBjb2RlIGlzIG9ubHkgY29uc2lkZXJpbmcgdGhlIGNhc2Ugd2hlcmUgYXNj
cT0weDEuDQo+DQo+IEZvbGxvd2luZyB0aGUgaHR0cDovL3d3dy50MTAub3JnL2xpc3RzL2FzYy1u
dW0uaHRtI0FTQ18zRSBzcGVjaWZpY2F0aW9uLCBvdGhlciB2YWx1ZXMgbWF5IG9jY3VyIGxpa2Ug
YSB0aW1lb3V0IChhc2NxPTB4MikuDQo+DQo+IFRoaXMgcGF0Y2ggaXMgYWJvdXQgcHJpbnRpbmcg
YW4gZXJyb3IgbWVzc2FnZSB3aGVuIGEgbm9uLWhhbmRsZWQgbWVzc2FnZSBpcyByZWNlaXZlZC4N
Cj4gVGhpcyBjb3VsZCBoZWxwIGRpYWdub3NlIGEgcG9zc2libGUgbWlzcy1iZWhhdmlvciBvZiB0
aGUgY29udHJvbGxlciBhbmQvb3IgYSBtaXNzaW5nIGltcGxlbWVudGF0aW9uIGluIHRoZSBMaW51
eCBLZXJuZWwuDQo+DQo+IFRoaXMgcGF0Y2gga2VlcHMgdGhlIGV4YWN0IHNhbWUgZXJyb3IgaGFu
ZGxpbmcgYnV0IHByaW50cyBhIG1lc3NhZ2UgaWYgYW4gYXNjcSAhPSAxIGluY29tZS4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogRXJ3YW4gVmVsdSA8ZS52ZWx1QGNyaXRlby5jb20+DQpBY2tlZC1ieTog
RG9uIEJyYWNlIDxkb24uYnJhY2VAbWljcm9zZW1pLmNvbT4NCg0K
