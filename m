Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF31C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B7722DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="lZ+N/X3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfHTRSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:18:15 -0400
Received: from mail-eopbgr800050.outbound.protection.outlook.com ([40.107.80.50]:12678
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbfHTRSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:18:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC6pdr33t9zX68aR1OBfT7qz3P6i3V4YEUXctHyYOZcyACvOTGNOUmx7xquInqjWyGnSeEdfthy6UHnIX8qHQqgjHiyPxhcCvzLM5aIfCifYeG8u0MovoLFpTCE5BjPmt6tJFxfuqACv1792kSmqkDtP7zvYkNbvEZtNGPOPC7/qEdxjvOjf4ukjHoPOBsbanGZ6UFd36HsvhHXXNtncH+BiF2Z5nMNY904trmydw3PuxKIEfXIjB0xIC907Fym+xQWafAGtq0/NOAa+gxnm8DR+sTvRf3uA8xNwnb1nCVSJMY1bUWok/nag4fJjPbwkuWsSlVwrz7oqvX0MWdZg0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOz7qU7fDQ5BH6SDtl8a4bexqbyZuWaIVyo3m969zKk=;
 b=X6G93p9PGueL3CPhpfsB98U9eYhaqfL1hD7pp25AL41YofK2Q2eU9sMOUNEjFE245yNhntdiKg++qvISfbU/INYJdC3V3HNGSd1fDIC/G1B5brOeyb2FeXEcDRC3GwonoqcvTJv/vUB21yUYVkJDa3vOX/VMzdp7ibF1jSrGHYUjkreZEZjtEcQElGGPuxXXSx87mrgDV+JXfNhJLKEhyvoE680ZWZNgDu9Cip5UtkhuU8skT7ewpOe4R6fzkK0kBdAYKrphIdGrqIzYixJLrq4Oi3bYItScbaHwK7/sqB+2Tzj5AmyUAufBK52MjhTVHRD6dht5zv5pNkc6UmJJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOz7qU7fDQ5BH6SDtl8a4bexqbyZuWaIVyo3m969zKk=;
 b=lZ+N/X3Xk+CxqT6AvuemGg8D8wfthm62FwFuAQ6sgNkDcujS1GnpY07ha6lLtHkBlEK3BB6I9WWPXtGc/R//EdqlTh7tEFhI9rAK7Ki1VsuMghE0bS4+siAFicN6lhsKO7paeLZn2o+AedSnLbykYU6/xIZenVBqGfNkBOj9J18=
Received: from MN2PR05MB6974.namprd05.prod.outlook.com (52.135.39.23) by
 MN2PR05MB6879.namprd05.prod.outlook.com (52.135.39.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.11; Tue, 20 Aug 2019 17:18:00 +0000
Received: from MN2PR05MB6974.namprd05.prod.outlook.com
 ([fe80::dc18:4e26:f427:61c0]) by MN2PR05MB6974.namprd05.prod.outlook.com
 ([fe80::dc18:4e26:f427:61c0%2]) with mapi id 15.20.2199.011; Tue, 20 Aug 2019
 17:18:00 +0000
From:   Darren Hart <dvhart@vmware.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0gKFZNd2FyZSk=?= 
        <thomas_os@shipmail.org>, Pv-drivers <Pv-drivers@vmware.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Doug@vmware.com" <Doug@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Doug Covelli <dcovelli@vmware.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Pv-drivers] [PATCH 1/4] x86/vmware: Update platform detection
 code for VMCALL/VMMCALL hypercalls
Thread-Topic: [Pv-drivers] [PATCH 1/4] x86/vmware: Update platform detection
 code for VMCALL/VMMCALL hypercalls
Thread-Index: AQHVVdIChxL9g5IkSk+B96eswFKTo6cBSH2AgAMCTIA=
Date:   Tue, 20 Aug 2019 17:18:00 +0000
Message-ID: <BD402DB5-8709-4D6B-BBBD-6406252441A7@vmware.com>
References: <20190818143316.4906-1-thomas_os@shipmail.org>
 <20190818143316.4906-2-thomas_os@shipmail.org>
 <alpine.DEB.2.21.1908182118260.1923@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908182118260.1923@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dvhart@vmware.com; 
x-originating-ip: [173.85.155.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f00b15c6-9061-41f2-d861-08d725925a29
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR05MB6879;
x-ms-traffictypediagnostic: MN2PR05MB6879:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR05MB68798375446A7ED66BA01080B2AB0@MN2PR05MB6879.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(199004)(189003)(76116006)(8676002)(4744005)(91956017)(81156014)(66446008)(66946007)(66556008)(6436002)(81166006)(229853002)(71200400001)(33656002)(86362001)(71190400001)(53936002)(6246003)(66066001)(256004)(66476007)(64756008)(36756003)(5660300002)(99286004)(6512007)(8936002)(6486002)(11346002)(186003)(3846002)(6116002)(446003)(2616005)(53546011)(486006)(316002)(54906003)(6506007)(4326008)(305945005)(26005)(476003)(14454004)(6916009)(76176011)(2906002)(7736002)(478600001)(25786009)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6879;H:MN2PR05MB6974.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wJvoB5CinnM52pw3XhBKzjDSxBNoIE7TFCpMMCIC6TfbBH+dXGAaSEjwPwiri9qY61Dto99FuIhQl89Sh25vpG6PPK7z5tV4QA1NQF5dhBrIgE0oxgdGCtsDcU95oeltt6IAqQVJJV3XMV7XJFz5rCMl3XbOZEt2dF1m8mzG3rUcKIgag06uSICAvMFS44ODw2D4LAc+3W16wYYXW3nRHY42+rIawrKkDdVVQn+tFcZ5V2A/xDkGXXCkivW4jhjg95H19a6beoHmKsBjpsEVOEkqgCbga9gzYgw8HqbZoUlTZL8q0VVhZM6+q7S89vA3/kkbztmdcY9IB0hMQ4XnlZDX7pGaG9FaQKRTXXzOOHqMWlOs8D9PWN4l5/TH6qIQL5qNhNqLKYfVTlsD0kz9A5pELSRmhJPqoHBpu2sk31k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5220B06BB4D0EE4496970DE2B4B3E6F0@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00b15c6-9061-41f2-d861-08d725925a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 17:18:00.3258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G85iJbZWgxpoF3a7kW/XeoTo3fzcomm6YrpNlBjW3EXUlJlCM9oUdI1ZsTUAMBf8jS2W+Gx79RE7kles1EM7vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6879
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEF1ZyAxOCwgMjAxOSwgYXQgMTI6MjAgUE0sIFRob21hcyBHbGVpeG5lciA8dGdseEBs
aW51dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+IFdoaWxlIGF0IGl0IGNvdWxkIHlvdSBwbGVhc2Ug
YXNrIHlvdXIgbGVnYWwgZm9sa3Mgd2hldGhlciB0aGF0IGN1c3RvbQ0KPiBsaWNlbnNlIGJvaWxl
cnBsYXRlIGNhbiBnbyBhd2F5IGFzIHdlbGw/DQoNCklmIHlvdeKAmXJlIHJlZmVycmluZyB0byB0
aGUgR1BMIGJvaWxlcnBsYXRlIHdpdGgg4oCcbm8gd2FycmFudHkiIGFuZCBwaHlzaWNhbA0KYWRk
cmVzcywgdGhlbiB5ZXMsIGFzIGEgbWF0dGVyIG9mIGJlc3QgcHJhY3RpY2UgKGF0IFZNd2FyZSks
IHRoYXQgY2FuIGFuZA0Kc2hvdWxkIGFsbCBiZSByZW1vdmVkIHdoZW4gYWRkaW5nIHRoZSBTUERY
IGlkZW50aWZpZXIgLSBhbmQgb2YgY291cnNlLCBhcw0KeW91IHNhaWQsIGJlIGRvbmUgYXMgYSBz
ZXBhcmF0ZSBwYXRjaC4NCg0KVGhhbmtzLA0KDQotLSANCkRhcnJlbiBIYXJ0DQo=
