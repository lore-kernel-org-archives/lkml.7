Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC57C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DBC218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="AKU8Gkz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfB0XQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:16:50 -0500
Received: from mail-eopbgr710070.outbound.protection.outlook.com ([40.107.71.70]:19512
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728397AbfB0XQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 18:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0FNixxabY15ydB4MGdbdMT3GzaSi9OQInDegsfRZ/o=;
 b=AKU8Gkz7mWN7QY3BIX+mP55FBqrc8Ug0/wkG6tubeWcnVo2E4HAqS9GFL/+hOaZZSBvB2T2xXo7roOo/6I18BFn1mSKNoYx+nyidnGCs2I9cnbgTD5HFXiVW20lXSbKPZwEyaT5OJLQ3pN6rr/j7tGuUSuu434Ikyna5fFWwIOs=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4647.namprd05.prod.outlook.com (52.135.233.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.6; Wed, 27 Feb 2019 23:16:46 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5%4]) with mapi id 15.20.1665.012; Wed, 27 Feb 2019
 23:16:46 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] x86/percpu semantics and fixes
Thread-Topic: [PATCH 0/5] x86/percpu semantics and fixes
Thread-Index: AQHUzoWJaf0Z+yLnPU65WpuGGs/UqqX0R/eA
Date:   Wed, 27 Feb 2019 23:16:46 +0000
Message-ID: <5596B338-C90B-47CA-BDAD-2B0091EFCD9B@vmware.com>
References: <20190227101252.413192716@infradead.org>
In-Reply-To: <20190227101252.413192716@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e0cbd53-6daf-44bb-f0b9-08d69d09a4eb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4647;
x-ms-traffictypediagnostic: BYAPR05MB4647:
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4647;20:2ZkxrnAdWoPgNeZwexzhGy6RkR/tJXhrVOjpfPxXz7oR9UWmQSalaP5G6O6x6mUynvlp0dZWWDnGnXMDkC3FdBKsZ8l0A1N6a3CA9kfe0VF29eJOvutiYwVmjlAHSQgpGZO6khXYYap6kTEzR7tBvGGwMg2wmPQuUeaVjjoAaFQ=
x-microsoft-antispam-prvs: <BYAPR05MB46474AED2058D1894165B7CBD0740@BYAPR05MB4647.namprd05.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(39860400002)(346002)(366004)(189003)(199004)(53754006)(6436002)(446003)(486006)(256004)(11346002)(476003)(71190400001)(71200400001)(186003)(14444005)(83716004)(82746002)(2616005)(26005)(6246003)(305945005)(36756003)(7736002)(2906002)(6506007)(53546011)(53936002)(6512007)(8936002)(76176011)(6486002)(99286004)(102836004)(33656002)(8676002)(316002)(97736004)(66066001)(105586002)(81166006)(81156014)(54906003)(106356001)(5660300002)(4326008)(229853002)(14454004)(6116002)(3846002)(68736007)(478600001)(25786009)(6916009)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4647;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zb08QDKWUxLXt5MLBGGcNweKd3B4qbP17FtbFhD1tDlkGoy+N4HMrjGpFDx2GlPQED66q3ggsGHBPy1cNU20+/T2bdjQw34vJootEYaYVIqvCWbBp37cwLeP5YPjx3VL0QMB8Q1c+GseOZzwFEo1qAeYxfNslGEucLvnZ1nCuylfWQZOLK1pknRpX/m1SmbD95W/DwCCT21SW90pB81DZC8wopGnzT383MAIHtvnlsogxz/Smf+6bETb1Twb6S+AkwsWgSkLlXLO0TPQWpdVcVyZYEd87+F9THRLJBnQYZzZuURaIebu9ZQJ5JhhsNQSDvdRei+zsfuJxcxw/0oeK+wXOPp34sJLsLbYXmJZxxJg7HnLezG6ldN+6VCt8vqKJ4EaOOtCi/JdqrUAA3WA/Tdx8s/2TVywyqhWpVGuSkw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38F651BE1C3EDE43831CE054FC438925@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0cbd53-6daf-44bb-f0b9-08d69d09a4eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 23:16:46.4514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4647
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGZWIgMjcsIDIwMTksIGF0IDI6MTIgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBIaSBhbGwsDQo+IA0KPiBUaGlzIGlzIGEgY29sbGVj
dGlvbiBvZiB4ODYvcGVyY3B1IGNoYW5nZXMgdGhhdCBJIGhhZCBwZW5kaW5nIGFuZCBnb3QgcmVt
aW5kZWQNCj4gb2YgYnkgTGludXMnIGNvbW1lbnQgeWVzdGVyZGF5IGFib3V0IF9fdGhpc19jcHVf
eGNoZygpLg0KPiANCj4gVGhpcyB0aWRpZXMgdXAgdGhlIHg4Ni9wZXJjcHUgcHJpbWl0aXZlcyBh
bmQgZml4ZXMgYSBidW5jaCBvZiAnZmFsbG91dCcuDQo+IA0KPiBCdWlsdCBhbmQgYm9vdCB0ZXN0
ZWQgd2l0aCBDT05GSUdfREVCVUdfUFJFRU1QVD15Lg0KDQpPdmVyYWxsIHRoaXMgc2VyaWVzIGFm
ZmVjdHMgNzAgZnVuY3Rpb25zIGFuZCBzaG9ydGVucyB0aGUgY29kZSBieSAzMjYgYnl0ZXMuDQpf
bG9jYWxfYmhfZW5hYmxlKCkgZm9yIGV4YW1wbGUgaXMgc2hvcnRlbiBieSAxNCBieXRlcyAoMjYl
KS4NCg0KSSBtdXN0IGFkbWl0IHRoYXQgSSBhbHRob3VnaCBJIHBvaW50ZWQgc29tZSBvZiB0aGVz
ZSBpc3N1ZXMgYmVmb3JlLCBJIGFtIG5vdA0Kc3VyZSB3aGV0aGVyIHRoZXkgYXJlIHJlYWxseSBp
bXBvcnRhbnQuLi4NCg0KUmVjZW50bHksIEkgdHJpZWQgdG8gc2VlIGhvdyB0byBtYWtlIHRoZSBj
b21waWxlciB0byBnZW5lcmF0ZSDigJxiZXR0ZXIgY29kZeKAnQ0KZnJvbSBMaW51eC4gSSBzcHJp
bmtsZWQg4oCccHVyZeKAnSBhdHRyaWJ1dGUgb24gbWFueSBjb21tb24gZnVuY3Rpb24gKGUuZy4s
DQpwYWdlX3JtYXBwaW5nKCkpLCBzZ19uZXh0KCkpOyBzcHJpbmtsZWQgY29uc3QtYXR0cmlidXRl
IG9uIHNvbWUgb3RoZXJzDQooZS5nLiwgamlmZmllc190b19tc2VjcygpKTsgY3JlYXRlZCBhIGNv
bnN0LWFsaWFzIHZhcmlhYmxlIHNvIHRoZSBjb21waWxlcg0Kd291bGQgY29uc2lkZXIga2FzbHIg
dmFyaWFibGVzIGFuZCBzbWVfbWVfbWFzayBhcyBjb25zdGFudCBhZnRlcg0KaW5pdGlhbGl6YXRp
b24sIGFuZCBzbyBvbi4NCg0KSSB3YXMgdGhlbiBsb29raW5nIGF0IHRoZSBjaGFuZ2VkIGNvZGUs
IGFuZCB3aGlsZSBzb21lIGZ1bmN0aW9ucyB3ZXJlDQpzaG9ydGVyIGFuZCBzb21lIGxvbmdlciwg
bWFueSBjb21tb24gZnVuY3Rpb25zIGRpZCBsb29rIOKAnGJldHRlcuKAnS4gVGhlIG9ubHkNCnBy
b2JsZW0gd2FzIHRoYXQgYW55IGJlbmNobWFyayB0aGF0IEkgZGlkIG5vdCBzaG93IGFueSBtZWFz
dXJhYmxlIGltcGFjdC4NCg0KU28gcGVyaGFwcyBpdCBpcyBhIG1hdHRlciBvZiBtZWFzdXJlbWVu
dCwgYnV0IGV2ZW50dWFsbHkgcmlnaHQgbm93IHRoZXJlIGlzDQpubyBjbGVhbiB3aW4u
