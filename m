Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C31C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFB620863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="rjW6qig6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfFRRmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:42:10 -0400
Received: from mail-eopbgr800042.outbound.protection.outlook.com ([40.107.80.42]:57558
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729209AbfFRRmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6JzkPR9QDBk+QB3uy5PkkeQhwYX3KI/2LLcSwk5al0=;
 b=rjW6qig6fjWShvsiuOghfkNOo5S+Jzgl7V3lNJRxl39QtR+8nlyjnPl+hjZ/u4UBpM5GVF+Nhvh+gXuZEiFT8KYB5D2NIcxk4ELRV5Pqx6aXq9QlEZiX0RiQP0hLFqSfOO5LMDNyEU7u4lwAU/cVH66tC5GyhQrNmb3dC+OO9yo=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6630.namprd05.prod.outlook.com (20.179.60.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.12; Tue, 18 Jun 2019 17:42:06 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2008.007; Tue, 18 Jun 2019
 17:42:06 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Borislav Petkov <bp@suse.de>,
        Toshi Kani <toshi.kani@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/3] resource: find_next_iomem_res() improvements
Thread-Topic: [PATCH 0/3] resource: find_next_iomem_res() improvements
Thread-Index: AQHVIaTGJ7ym4R/nDEy6A26DLGCJOaag/0oAgAC3tYA=
Date:   Tue, 18 Jun 2019 17:42:06 +0000
Message-ID: <9387A285-B768-4B58-B91B-61B70D964E6E@vmware.com>
References: <20190613045903.4922-1-namit@vmware.com>
 <CAPcyv4hpWg5DWRhazS-ftyghiZP-J_M-7Vd5tiUd5UKONOib8g@mail.gmail.com>
In-Reply-To: <CAPcyv4hpWg5DWRhazS-ftyghiZP-J_M-7Vd5tiUd5UKONOib8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 583d96b3-9c55-4bb4-123d-08d6f414481e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6630;
x-ms-traffictypediagnostic: BYAPR05MB6630:
x-microsoft-antispam-prvs: <BYAPR05MB663062DBB97317948E0F9B9CD0EA0@BYAPR05MB6630.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(8676002)(7416002)(305945005)(8936002)(6512007)(68736007)(81156014)(7736002)(2906002)(3846002)(66066001)(6116002)(316002)(66946007)(5660300002)(64756008)(66556008)(66446008)(86362001)(66476007)(11346002)(446003)(14444005)(256004)(73956011)(76116006)(6916009)(36756003)(2616005)(33656002)(54906003)(14454004)(76176011)(102836004)(81166006)(6486002)(186003)(476003)(486006)(26005)(478600001)(6246003)(53936002)(25786009)(71190400001)(6506007)(99286004)(6436002)(71200400001)(4326008)(53546011)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6630;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C5ILFoWOoBxqi0qVa1f/8QUZRdIyMIwIq52U7FNHhGS8q9gzPCjaGcbsp4fwMqBT4kYCv7Ynzk+a0KZ67XK/Etkz3xRIw6bgYqP3REIgILb2oXhlpgEdeU1pPlSB4GF2ySx8sxgjdeqSW9G5dthU1ATrb6QAe3NontDGBql73J7k8fCKPXPOtgop3mvdGc/85Fq/Y65EPK9ypTqf73QYaNhsPkmhg4WPY6IsWkjIZ/tsUhoiQPlea7w6pkjbk3NWBS6ooTA8rhwQKtXQ4ridrDW2nO8Kh9CziK3WfDWfgeI/EIMDyw13/xeNYt8TW9B8oZiBiKV4szSp5GV/mms+jfFf1GiGii7qffe+hb9hMYWa1j2NlbuqRUDNmEqkErbsnGGVEHxinSuMKYSaO5Ok3BU90+plULJPW/HlM6L0gbg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B3066CA312C354E921B3D0BA8A0EE0D@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583d96b3-9c55-4bb4-123d-08d6f414481e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 17:42:06.4138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gMTcsIDIwMTksIGF0IDExOjQ0IFBNLCBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxp
YW1zQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIEp1biAxMiwgMjAxOSBhdCA5OjU5
IFBNIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4gUnVubmluZyBzb21l
IG1pY3JvYmVuY2htYXJrcyBvbiBkYXgga2VlcHMgc2hvd2luZyBmaW5kX25leHRfaW9tZW1fcmVz
KCkNCj4+IGFzIGEgcGxhY2UgaW4gd2hpY2ggc2lnbmlmaWNhbnQgYW1vdW50IG9mIHRpbWUgaXMg
c3BlbnQuIEl0IGFwcGVhcnMgdGhhdA0KPj4gaW4gb3JkZXIgdG8gZGV0ZXJtaW5lIHRoZSBjYWNo
ZWFiaWxpdHkgdGhhdCBpcyByZXF1aXJlZCBmb3IgdGhlIFBURSwNCj4+IGxvb2t1cF9tZW10eXBl
KCkgaXMgY2FsbGVkLCBhbmQgdGhpcyBvbmUgdHJhdmVyc2VzIHRoZSByZXNvdXJjZXMgbGlzdCBp
bg0KPj4gYW4gaW5lZmZpY2llbnQgbWFubmVyLiBUaGlzIHBhdGNoLXNldCB0cmllcyB0byBpbXBy
b3ZlIHRoaXMgc2l0dWF0aW9uLg0KPiANCj4gTGV0J3MganVzdCBkbyB0aGlzIGxvb2t1cCBvbmNl
IHBlciBkZXZpY2UsIGNhY2hlIHRoYXQsIGFuZCByZXBsYXkgaXQNCj4gdG8gbW9kaWZpZWQgdm1m
X2luc2VydF8qIHJvdXRpbmVzIHRoYXQgdHJ1c3QgdGhlIGNhbGxlciB0byBhbHJlYWR5DQo+IGtu
b3cgdGhlIHBncHJvdF92YWx1ZXMuDQoNCklJVUMsIG9uZSBkZXZpY2UgY2FuIGhhdmUgbXVsdGlw
bGUgcmVnaW9ucyB3aXRoIGRpZmZlcmVudCBjaGFyYWN0ZXJpc3RpY3MsDQp3aGljaCByZXF1aXJl
IGRpZmZlcmVuY2UgY2FjaGFiaWxpdHkuIEFwcGFyZW50bHksIHRoYXQgaXMgdGhlIHJlYXNvbiB0
aGVyZQ0KaXMgYSB0cmVlIG9mIHJlc291cmNlcy4gUGxlYXNlIGJlIG1vcmUgc3BlY2lmaWMgYWJv
dXQgd2hlcmUgeW91IHdhbnQgdG8NCmNhY2hlIGl0LCBwbGVhc2UuDQoNClBlcmhhcHMgeW91IHdh
bnQgdG8gY2FjaGUgdGhlIGNhY2hhYmlsaXR5LW1vZGUgaW4gdm1hLT52bV9wYWdlX3Byb3QgKHdo
aWNoIEkNCnNlZSBiZWluZyBkb25lIGluIHF1aXRlIGEgZmV3IGNhc2VzKSwgYnV0IEkgZG9u4oCZ
dCBrbm93IHRoZSBjb2RlIHdlbGwgZW5vdWdoDQp0byBiZSBjZXJ0YWluIHRoYXQgZXZlcnkgdm1h
IHNob3VsZCBoYXZlIGEgc2luZ2xlIHByb3RlY3Rpb24gYW5kIHRoYXQgaXQNCnNob3VsZCBub3Qg
Y2hhbmdlIGFmdGVyd2FyZHMuDQoNCg==
