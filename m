Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90F6C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFC021773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KwGN3zP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfDWLQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:16:10 -0400
Received: from mail-eopbgr150044.outbound.protection.outlook.com ([40.107.15.44]:37859
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbfDWLQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AFjQc3G3PXGaQwfYlRjnNCuT/lDeAD2bIvlbwWdCMs=;
 b=KwGN3zP/MWFhtct8NO7vlN5Blc9aTGdGAvOFV+ZNpldPC+8kNVpOpwkvml6UoeHHqPxNHQHAYuErOasa26x9qptN0yE4BdkDll58w6Cw3p/q4byyqUDuMYVnYAA8Qp86XzfnpI18bcU7DqEMWKjINQ9UGiFHTXcJmhvUxJzGsRw=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB3565.eurprd08.prod.outlook.com (20.177.61.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 11:16:03 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::11b9:f687:dc3e:68cc]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::11b9:f687:dc3e:68cc%3]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 11:16:03 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     nd <nd@arm.com>, Joseph Myers <joseph@codesourcery.com>,
        Will Deacon <Will.Deacon@arm.com>, carlos <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup and
 thread creation (v8)
Thread-Topic: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup and
 thread creation (v8)
Thread-Index: AQHU9HpbUigwBDiNHkaVVFlkWH4PtKZAhB6AgAAE+oCAAD0+gIABIvSAgAAl0IBuJwpORvyO4hCAgAAA5YCAABgtgP//+lMAgAdmBgA=
Date:   Tue, 23 Apr 2019 11:16:03 +0000
Message-ID: <a1bd2595-b7ae-b06b-9c71-802901ed8587@arm.com>
References: <20190416173216.9028-1-mathieu.desnoyers@efficios.com>
 <1770787324.668.1555530989646.JavaMail.zimbra@efficios.com>
 <1066731871.915.1555593471194.JavaMail.zimbra@efficios.com>
 <6cbfea7b-9d83-74a5-9cd2-af56a5d68818@arm.com>
 <1055153722.1072.1555602067220.JavaMail.zimbra@efficios.com>
 <79996d13-2ba2-ed7d-b202-e7d38f1fd870@arm.com>
 <604915684.1299.1555607449814.JavaMail.zimbra@efficios.com>
 <846db7ef-f75e-53b8-3c4c-461ec730a17e@arm.com>
 <1531569198.1389.1555611422188.JavaMail.zimbra@efficios.com>
In-Reply-To: <1531569198.1389.1555611422188.JavaMail.zimbra@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P265CA0414.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::18) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc586be2-6cf6-4bdb-f3ef-08d6c7dd129d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3565;
x-ms-traffictypediagnostic: VI1PR08MB3565:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB356587599FB9D36788259ADEED230@VI1PR08MB3565.eurprd08.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(39860400002)(396003)(189003)(199004)(65956001)(3846002)(386003)(6506007)(305945005)(65806001)(7736002)(66066001)(6512007)(26005)(6486002)(53546011)(93886005)(102836004)(25786009)(6246003)(53936002)(36756003)(7416002)(6916009)(8676002)(81156014)(81166006)(8936002)(186003)(229853002)(2906002)(256004)(11346002)(446003)(2616005)(6116002)(31686004)(486006)(44832011)(476003)(58126008)(5660300002)(86362001)(64756008)(54906003)(31696002)(68736007)(316002)(66446008)(64126003)(71200400001)(14454004)(4744005)(4326008)(66946007)(65826007)(478600001)(71190400001)(6436002)(97736004)(72206003)(99286004)(66476007)(66556008)(73956011)(76176011)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3565;H:VI1PR08MB4223.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Cm0JvAqPdnLFzNTcTvbW5aTNjMdi5xYC7M+Irnmy+uGDA6juwh6d7ZF+9RmGItMQZk3rJALKjOfZiU12EP0expaPuaoekZYgx1Q/YuIfNTBkIY5Bj+UQKq7/7q7wMRTjOhKU4vsqnBpwVHod3IbdCY6AMuMYjuDCKeuiZ9MvrNfrSyl88VybWQI3wfbxvm1TJeqqYZe1xmZwHqrDu9CMLaVwPNBrJuaNHzT54Fqp32D3ag5g6eoHmULRidcb12u7TCIt/olVHNs34tErvUgUE2zfyic08ch3+b1ExsJnjjZyvVLwqm2Yrt1xEIpYJsXKBGprW5mFzIDQB9xBlpcB6e6ilwSwJwykFU5O1d9TA2kpwlVuPE6UrAXtNsR28dQRomiGFehaO5IltLfYnOKlaZYdOPcHWUi4zXfEclznBMs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <683B99399D7B2B4FAF62C9C4A80FA203@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc586be2-6cf6-4bdb-f3ef-08d6c7dd129d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 11:16:03.7478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3565
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDQvMjAxOSAxOToxNywgTWF0aGlldSBEZXNub3llcnMgd3JvdGU6DQo+IC0tLS0tIE9u
IEFwciAxOCwgMjAxOSwgYXQgMTozNyBQTSwgU3phYm9sY3MgTmFneSBTemFib2xjcy5OYWd5QGFy
bS5jb20gd3JvdGU6DQo+PiB5b3UgaGF2ZSB0byBhZGQgYSBkb2N1bWVudGF0aW9uIGNvbW1lbnQg
c29tZXdoZXJlDQo+PiBleHBsYWluaW5nIGlmIFJTRVFfU0lHIGlzIHRoZSB2YWx1ZSB0aGF0J3Mg
cGFzc2VkIHRvDQo+PiB0aGUga2VybmVsIGFuZCB0aGVuIGFhcmNoNjQgYXNtIGNvZGUgaGFzIHRv
IHVzZQ0KPj4NCj4+IC5pbnN0IGVuZGlhbmZpeHVwKFJTRVFfU0lHKSAvLyBvcg0KPj4gLndvcmQg
UlNFUV9TSUcNCj4gDQo+IFVzaW5nICIud29yZCIgd29uJ3QgYWxsb3cgb2JqZHVtcCB0byBzaG93
IHRoZSBpbnN0cnVjdGlvbiBpdA0KPiBtYXBzIHRvLiBJdCB3aWxsIGNvbnNpZGVyIGl0IGFzIGRh
dGEuIFNvIC5pbnN0IGlzIHByZWZlcnJlZCBoZXJlLg0KDQppcyB0aGVyZSBzb21lIHNwZWNpZmlj
IHJlYXNvbiB5b3UgcHJlZmVyIC5pbnN0Pw0KDQpkaXNhc3NlbWJsaW5nIGEgY2FuYXJ5IHZhbHVl
IGFzIGRhdGEgKHRoYXQgaXMNCm5ldmVyIGV4ZWN1dGVkLCBidXQgbG9hZGVkIGFuZCBjb21wYXJl
ZCBieSB0aGUNCmtlcm5lbCBhcyBkYXRhKSBzb3VuZHMgbW9yZSBzZW1hbnRpY2FsbHkgY29ycmVj
dA0KdG8gbWUgdGhhbiBzaG93aW5nIGl0IGFzIGFuIGluc3RydWN0aW9uLg0KDQppIGd1ZXNzIGhh
dmluZyBpdCBhcyBhbiBpbnN0cnVjdGlvbiBjYW4gYXZvaWQNCmlzc3VlcyBpZiBzb21lIHRvb2xz
IGRpc2xpa2UgLndvcmQgaW4gLnRleHQsDQpidXQgb3RoZXJ3aXNlIC53b3JkIHNlZW1zIGJldHRl
ci4NCg==
