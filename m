Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2F6C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 23:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C4720818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 23:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="YKOeVSOL";
	dkim=pass (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="k2C5wjpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfEOX3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 19:29:49 -0400
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:28466 "EHLO
        rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfEOX1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 19:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2176; q=dns/txt; s=iport;
  t=1557962867; x=1559172467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5c5DQYhG/jJ1bAZEGeIak3Ak/+ZyMLBCUmfVcu3CWhY=;
  b=YKOeVSOLwxoonrCM+8VZGXEVDoyJOu7MwuW/NuoHyihWyZI7oKkIliwv
   m7hnIbx8tjFBCmHpDq7UB0Q4iRjiasJ6+2xZjckElufSaZSiWrVY2ixP2
   ZJYlPmeM6RWSgV01XbPUCyZHQDnWMRixobD8BLwDNFQmO7n4x9WiYVa44
   c=;
IronPort-PHdr: =?us-ascii?q?9a23=3AXodavhO+hIBlQdSIalYl6mtXPHoupqn0MwgJ65?=
 =?us-ascii?q?Eul7NJdOG58o//OFDEu6w/l0fHCIPc7f8My/HbtaztQyQh2d6AqzhDFf4ETB?=
 =?us-ascii?q?oZkYMTlg0kDtSCDBjgLPHjaSMzGuxJVURu+DewNk0GUMs=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BIAACbn9xc/4kNJK1kHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBgT1QA4E+IAQLKIQRg0cDhFKKIYIyJYk/jWaBLoEkA1QJAQE?=
 =?us-ascii?q?BDAEBLQIBAYRAAheCFCM0CQ4BAwEBBAEBAgEEbRwMhUoBAQEDARIREQwBATc?=
 =?us-ascii?q?BBAsCAQgYAgImAgICHxEVEAIEDgUigwCBawMODwECoGwCgTWIX3GBL4J5AQE?=
 =?us-ascii?q?FhQYNC4IPCYELKAGLTheBQD+BOAwTgkw+ghqFNDKCJosBIYI+mUQ5CQKCCY8?=
 =?us-ascii?q?Ig1YblW4tlC6MYwIEAgQFAg4BAQWBTziBV3AVZQGCQYIPg2+KU3KBKY9GAQE?=
X-IronPort-AV: E=Sophos;i="5.60,474,1549929600"; 
   d="scan'208";a="559990086"
Received: from alln-core-4.cisco.com ([173.36.13.137])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 15 May 2019 23:27:46 +0000
Received: from XCH-ALN-020.cisco.com (xch-aln-020.cisco.com [173.36.7.30])
        by alln-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id x4FNRkrL006165
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 15 May 2019 23:27:47 GMT
Received: from xhs-rcd-003.cisco.com (173.37.227.248) by XCH-ALN-020.cisco.com
 (173.36.7.30) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 May
 2019 18:27:46 -0500
Received: from xhs-rcd-003.cisco.com (173.37.227.248) by xhs-rcd-003.cisco.com
 (173.37.227.248) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 May
 2019 18:27:45 -0500
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-003.cisco.com (173.37.227.248) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 15 May 2019 18:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector1-cisco-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c5DQYhG/jJ1bAZEGeIak3Ak/+ZyMLBCUmfVcu3CWhY=;
 b=k2C5wjpzNm6JebKffy1MDc4+71TcoKwu1yqkdHxm4ggDYUZ2DZEql6GI1sulYpa3SYJOy7w6rbHdKiknbGSgLupmGq9DXFUx69SpCAsHc9DWXHFZBk3InhbcjSaquCs41owgT0HvcjzBQ7JrflLAjk4Nu44zDfbbDppG/GhxPLc=
Received: from BYAPR11MB3461.namprd11.prod.outlook.com (20.177.187.14) by
 BYAPR11MB2903.namprd11.prod.outlook.com (20.177.225.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Wed, 15 May 2019 23:27:44 +0000
Received: from BYAPR11MB3461.namprd11.prod.outlook.com
 ([fe80::494e:92a0:85c6:a3dd]) by BYAPR11MB3461.namprd11.prod.outlook.com
 ([fe80::494e:92a0:85c6:a3dd%7]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 23:27:44 +0000
From:   "Shreya Gangan (shgangan)" <shgangan@cisco.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Removal of dump_stack()s from /fs/ubifs/io.c
Thread-Topic: Removal of dump_stack()s from /fs/ubifs/io.c
Thread-Index: AQHVC2FVil2C0hxsCESyeW0kls9eBqZsX3uA
Date:   Wed, 15 May 2019 23:27:44 +0000
Message-ID: <5B190BFA-DF2A-4469-85E2-14A7347B7A8E@cisco.com>
References: <E44E4181-1CFB-493C-8023-147472049D19@cisco.com>
 <CAFLxGvysPg3FO4kT0QrRsYTr219WVttQMeat_StqbifTPrGLmA@mail.gmail.com>
In-Reply-To: <CAFLxGvysPg3FO4kT0QrRsYTr219WVttQMeat_StqbifTPrGLmA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shgangan@cisco.com; 
x-originating-ip: [2001:420:30d:1254:f50a:d60e:60dd:2496]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc127610-8c60-4b15-1220-08d6d98cef09
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR11MB2903;
x-ms-traffictypediagnostic: BYAPR11MB2903:
x-microsoft-antispam-prvs: <BYAPR11MB290368AF3D79CBEAE4E55335DB090@BYAPR11MB2903.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(366004)(396003)(346002)(189003)(199004)(6246003)(316002)(7736002)(4326008)(68736007)(6436002)(102836004)(229853002)(36756003)(14444005)(25786009)(256004)(53936002)(66946007)(66556008)(66446008)(64756008)(76116006)(73956011)(6486002)(66476007)(82746002)(2906002)(33656002)(305945005)(6512007)(8676002)(76176011)(5660300002)(486006)(6116002)(2616005)(11346002)(6506007)(478600001)(54906003)(81156014)(99286004)(53546011)(446003)(8936002)(6916009)(86362001)(186003)(71200400001)(71190400001)(83716004)(46003)(14454004)(476003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB2903;H:BYAPR11MB3461.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mXbNM1NZAQebI0Ib5s/qKGOAvPPjIfis/2IjDMklWQiCNndb06TqTHmzreI4Mbfac3lB+M4F7u+wcatOYLaC0TYTy+urtb+4aZt+SRqGSotIoMsyeNVg9TghoYFqpp0kFcnmOPg4s4clitFqMp/g98+CrXa6Rn5f0TEhNot+b7DifHhObOZqa5GLcASfJ5Pdx2o2IHTNLvgpiiqAuhb3HoWO0vdIfgJUOhg4vM8vaIbaELasue93Y7WpSLp4q0iCmVIQ+Ak/ezsJh1EUM2cZGQsz/nxqSbd43PSYXttKlK/Ub8KxufsFA4BVQ/QwnqJMD9qzf4Ns0rsx9namZoNWZZiwiHJv9QWAw+c5PGItQyHivPVdEsikh6SfJMg/vg3wRZXCm0guaMyEa7DQob8xcvbOBhLcRyamgEVYV8/LrfA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF2D337ED8479B47B4626A6289C37337@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dc127610-8c60-4b15-1220-08d6d98cef09
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 23:27:44.7232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2903
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.30, xch-aln-020.cisco.com
X-Outbound-Node: alln-core-4.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmljaGFyZCwNCg0KT24gNS8xNS8xOSwgMjowMSBQTSwgIlJpY2hhcmQgV2VpbmJlcmdlciIg
PHJpY2hhcmQud2VpbmJlcmdlckBnbWFpbC5jb20+IHdyb3RlOg0KDQo+IE9uIFdlZCwgTWF5IDE1
LCAyMDE5IGF0IDEwOjQ1IFBNIFNocmV5YSBHYW5nYW4gKHNoZ2FuZ2FuKSA8c2hnYW5nYW5AY2lz
Y28uY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpLA0KPiA+DQo+ID4gIC9mcy91Ymlmcy9pby5jIGhh
cyBkdW1wX3N0YWNrKCkgaW4gbXVsdGlwbGUgZnVuY3Rpb25zIHVwb24gZXJyb3JzIGFuZCBzb21l
dGltZXMgd2FybmluZ3MuDQo+ID4gU2luY2UgdGhlIGVycm9yIGFuZCB3YXJuaW5nIG1lc3NhZ2Vz
IHNlZW0gdG8gYmUgdW5pcXVlLCB0aGUgZnVuY3Rpb25hbCB2YWx1ZSBvZiB0aGVzZSBkdW1wX3N0
YWNrcyBpcyBub3QgYXBwYXJlbnQuDQo+ID4gV2h5IGFyZSB0aGVzZSBkdW1wX3N0YWNrcyByZXF1
aXJlZCBhbmQgd2hhdCBpc3N1ZXMgbWlnaHQgb2NjdXIgdXBvbiB0aGUgcmVtb3ZhbCBvZiB0aGVz
ZT8NCg0KPiBUaGV5IGFyZSBub3QgcmVxdWlyZWQsIGJ1dCB0aGV5IGFyZSBqdXN0IHVzZWZ1bC4g
V2hpbGUgeW91IGFyZSByaWdodCB0aGF0IHRoZSBsb2NhdGlvbnMgd2l0aGluIFVCSUZTIGFyZSB1
bmlxdWUsDQo+IHRoZXkgYXJlIG5vdCBmb3IgdGhlIHdob2xlIGtlcm5lbCBjb250ZXh0Lg0KPiBG
aWxlc3lzdGVtIGZ1bmN0aW9ucyBjYW4gZ2V0IGNhbGxlZCB2aWEgbWFueSBkaWZmZXJlbnQgcGF0
aHMgZnJvbSBWRlMuLi4NCg0KSXNuJ3QgdGhhdCB0cnVlIGZvciBhbnkga2VybmVsIGVycm9yIHRo
b3VnaC4NCldhbnQgdG8gdW5kZXJzdGFuZCB3aHkgaXQgd291bGQgYmUgZXNzZW50aWFsIGZvciB1
YmlmcyB0byBoYXZlIHRoZXNlIG92ZXIgdGhlIG90aGVyIGtlcm5lbCBtb2R1bGVzPyANCkNhbid0
IHRoZSBkZXZlbG9wZXIgYWRkIHRoZSBkdW1wX3N0YWNrIGxhdGVyIGZvciBkZWJ1Z2dpbmcgcmVh
c29ucz8NCg0KPiBXaHkgZG8geW91IHdhbnQgdG8gcmVtb3ZlIHRoZW0sIHdoYXQgaXMgdGhlIGJl
bmVmaXQ/DQoNClRoZSB3YXkgb3VyIHN5c3RlbSBpcyB1c2luZyB0aGUgdWJpZnMsIGZvciBhIGRl
dmljZSB3aGljaCBpcyAnbm8gbG9uZ2VyIHRoZXJlJyBjb3VsZCBiZSBmcmVxdWVudCANCidubyBz
dWNoIGRldmljZScgZXJyb3JzIHdoZW4NCjEuIHRoZXJlIG1pZ2h0IGJlIG11bHRpcGxlIHdyaXRl
IGFjY2Vzc2VzIHRvIHRoZSBmaWxlc3lzdGVtIGJlZm9yZSB0aGUgcmVzcG9uc2libGUgcHJvY2Vz
cyBpcyB0ZXJtaW5hdGVkIA0KMi4gdGhlIGZpbGVzeXN0ZW0gaXMgdW5tb3VudGVkIGFmdGVyIHRo
aXMNClRoZSByZXN1bHQgd291bGQgYmUgZmxvb2Rpbmcgb2YgdGhlIGNvbnNvbGUgb3IgbWVzc2Fn
ZSBsb2dzIHdpdGggYm90aCB0aGUgZXJyb3IgbWVzc2FnZXMgYW5kIHRoZSBkdW1wX3N0YWNrLA0K
bWFraW5nIGl0IHJlYWxseSB1Z2x5Lg0KSXMgdGhlcmUgYSBzcGVjaWZpYyB3YXkgYSAnbm8gc3Vj
aCBkZXZpY2UnIGlzc3VlIGlzIGhhbmRsZWQgdG8gYXZvaWQgdGhlIG1lc3NhZ2VzIGZyb20gZmxv
b2Rpbmcgd2l0aCB0aGUgZHVtcF9zdGFja3M/DQoNClJlZ2FyZHMsDQpTaHJleWENCg0K
