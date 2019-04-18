Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68FDC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A62B20869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="L5Vjfz6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389471AbfDRPeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:34:04 -0400
Received: from mail-eopbgr40045.outbound.protection.outlook.com ([40.107.4.45]:31207
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389294AbfDRPeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybKNueRChlQnwGjFHUnaD2VymDktSUQ6tYGBDSojFjU=;
 b=L5Vjfz6dCA81k9uzdTBoZNF7nhziMhu4URAeVDG7jHcs0f96fyAvOaw6GfvkG0G3NdLt4ZXxWAtmvAVKlGcsNohBkQ7+BtClmQcFQ58YJiQ/28ymFZJu28QSUwW2iudRpGEDZUF2LPboF5reAUSu3cp00D5GJ+M+BPoj+e4cvfo=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB4448.eurprd08.prod.outlook.com (20.179.24.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Thu, 18 Apr 2019 15:33:33 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::11b9:f687:dc3e:68cc]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::11b9:f687:dc3e:68cc%3]) with mapi id 15.20.1813.011; Thu, 18 Apr 2019
 15:33:33 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Carlos O'Donell <carlos@redhat.com>
CC:     nd <nd@arm.com>, Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH 2/5] glibc: sched_getcpu(): use rseq cpu_id TLS on Linux
 (v2)
Thread-Topic: [PATCH 2/5] glibc: sched_getcpu(): use rseq cpu_id TLS on Linux
 (v2)
Thread-Index: AQHU9HpZl2rnFP3D20yib30BAxg97aZCDzCA
Date:   Thu, 18 Apr 2019 15:33:33 +0000
Message-ID: <c9c53d4b-ed9b-f2d9-60b0-e5e805de0324@arm.com>
References: <20190416173216.9028-1-mathieu.desnoyers@efficios.com>
 <20190416173216.9028-3-mathieu.desnoyers@efficios.com>
In-Reply-To: <20190416173216.9028-3-mathieu.desnoyers@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P265CA0159.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::27) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a86ddca-cd31-4906-d1d4-08d6c4133723
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB4448;
x-ms-traffictypediagnostic: VI1PR08MB4448:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB4448DEE977FB8E8956B3075EED260@VI1PR08MB4448.eurprd08.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(366004)(199004)(189003)(97736004)(31696002)(14454004)(86362001)(65826007)(6246003)(3846002)(53936002)(305945005)(6486002)(6116002)(2906002)(31686004)(72206003)(478600001)(64126003)(5660300002)(26005)(386003)(53546011)(6506007)(476003)(68736007)(6512007)(6436002)(7736002)(446003)(2616005)(4326008)(11346002)(486006)(186003)(25786009)(102836004)(52116002)(99286004)(66066001)(229853002)(76176011)(256004)(8676002)(81166006)(81156014)(8936002)(44832011)(54906003)(110136005)(65956001)(316002)(65806001)(58126008)(7416002)(71190400001)(71200400001)(36756003)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4448;H:VI1PR08MB4223.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YCsLUx4KUKXHL0ZDI8iD2g9TjbV35oLFWiTtGXmnZ4E5nxJRjWwSCH+A181qwPkmK5Y0GKRMvITPOSOhBT2cFw7NrLrXhRaOPPqYQXJi/tGiIfkZT3iPpmFwDvQ9AFIrBIE7sXRlur3NlD7gu/7v81xSe1eiPQ5YM+D7uWOaya5kS+FLgAwafUdFRg0BNUEB8UooslceVjWHZrGa/mjZ3Kttv8H3FQeYEGyaWygrIBVXJdxiMjbU6StyZpWMHrj1su17Hv4sf58kXsGee2gc513xsMifyKHbTP9jr08Hteh5fYHlqSgfLIsP7eSEyMnQ9x1ERZky16nO+gvhIp35ZwiaYKw76mQF+VcOYjFBZSc9EZRFyJyq2urAoImTgi+Wm0cPR7r4aed/vyfYrPnd6v/qCT9eXqU11dM/0zg/e4o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E32C93A8CB8DF46A798F4AD2DCCAD17@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a86ddca-cd31-4906-d1d4-08d6c4133723
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 15:33:33.1773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4448
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDQvMjAxOSAxODozMiwgTWF0aGlldSBEZXNub3llcnMgd3JvdGU6DQo+IC0tLSBhL3N5
c2RlcHMvdW5peC9zeXN2L2xpbnV4L3NjaGVkX2dldGNwdS5jDQo+ICsrKyBiL3N5c2RlcHMvdW5p
eC9zeXN2L2xpbnV4L3NjaGVkX2dldGNwdS5jDQo+IEBAIC0zNywzICszNywyNiBAQCBzY2hlZF9n
ZXRjcHUgKHZvaWQpDQo+ICAgIHJldHVybiAtMTsNCj4gICNlbmRpZg0KPiAgfQ0KPiArDQo+ICsj
aWZkZWYgX19OUl9yc2VxDQo+ICsjaW5jbHVkZSA8c3lzL3JzZXEuaD4NCj4gKyNlbmRpZg0KPiAr
DQo+ICsjaWYgZGVmaW5lZCBfX05SX3JzZXEgJiYgZGVmaW5lZCBSU0VRX1NJRw0KPiArZXh0ZXJu
IF9fYXR0cmlidXRlX18gKCh0bHNfbW9kZWwgKCJpbml0aWFsLWV4ZWMiKSkpDQo+ICtfX3RocmVh
ZCB2b2xhdGlsZSBzdHJ1Y3QgcnNlcSBfX3JzZXFfYWJpOw0KDQppJ2QgZXhwZWN0IHN5cy9yc2Vx
LmggdG8gcHJvdmlkZSB0aGlzIGRlY2xhcmF0aW9uLg0KDQo+ICsNCj4gK2ludA0KPiArc2NoZWRf
Z2V0Y3B1ICh2b2lkKQ0KPiArew0KPiArICBpbnQgY3B1X2lkID0gX19yc2VxX2FiaS5jcHVfaWQ7
DQo+ICsNCj4gKyAgcmV0dXJuIGNwdV9pZCA+PSAwID8gY3B1X2lkIDogdnN5c2NhbGxfc2NoZWRf
Z2V0Y3B1ICgpOw0KPiArfQ0KPiArI2Vsc2UNCj4gK2ludA0KPiArc2NoZWRfZ2V0Y3B1ICh2b2lk
KQ0KPiArew0KPiArICByZXR1cm4gdnN5c2NhbGxfc2NoZWRfZ2V0Y3B1ICgpOw0KPiArfQ0KPiAr
I2VuZGlmDQo+IC0tIDIuMTcuMQ0KPiANCg0K
