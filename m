Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD68C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323092064A
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="REhfMfmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389158AbfHAV3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:29:47 -0400
Received: from mail-eopbgr710076.outbound.protection.outlook.com ([40.107.71.76]:59648
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728045AbfHAV3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:29:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSNA6WJ7UubEShWIJut24/yuzXaUwuOo+Jg4jteBSUl/4r6rmGIMgeV1QYqtzjS2+0nry/HkIlCgXyVwh8FBYqKkciOs6L8n3qAd87Y/IfnuBNsffLCVv8RuuY5HwpqzqbTwjYk8gQcUBWCA4FrIPUUUgnOIH0BnWFLC8yhh+cB7fXMjyMqSRljgcSUiGsR6o3lnFkp0hCUCwoaQCmPbSLgEmgL6oue7FYS+AjfiTYvSZjymBljJ3nH+f0LILuvf8P/eBfOosSRG+g03yCIvEGfbLQuLufAgBTMk+ShtGm/j4uPTVbipm4kNHqXF2zbqob3vnpcf8LjENQm8qU34Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkGY5nFXkMteFtKXJpNQO0fDZVNvsEvfrXlegOtB1Fc=;
 b=iNpvAMDwsyhpCUNR5TnDQ9aoVCY2oM9aQEnxFSA51zEzkKiHuU3AFD9vuQb47FHSMhJUQzNRFhpegxLBdUAVlHsweZGXLvIUX1JyGKy1j2mdumfSOHZ8AozooWhGmyTzPXTXjFUhUcDY+c8ImkXBuM90q+HCeGfN2Oo901OEjF0dt6KW0rNOGXLIb1d0YwqdKOnP6zugDlfEaXQOl+Uz1uyBv34KbhiDN9zbuDhBchMryKv7w3COkQ2NBWHAeFeFlpvOOmwjVExtVMuj81x0GT4JzTM3f+h85K2YbFAa3rrMRw9iX8cfXrjOq3mEflJv+S2adYSWOhoWnfon3Dx9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkGY5nFXkMteFtKXJpNQO0fDZVNvsEvfrXlegOtB1Fc=;
 b=REhfMfmNo8NDSg9W6I7Ei56qZIBWTCED/dHGK6JaKwhE95OWzlGA5kFxtI+Gy4jOPDnfKHBBwZik7rq0RQhqH8JB9Wv0cvA+Y3PstHZkKKOEXyawOkeCJzGvi/1eyVdmH8WO1QM7cCdj4Zesfki+EQRp9aByc/BWbmAZ+KwRgFY=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3852.namprd12.prod.outlook.com (10.255.173.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Thu, 1 Aug 2019 21:29:43 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 21:29:43 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH] perf/x86/amd: Change NMI latency mitigation to use a
 timestamp
Thread-Topic: [PATCH] perf/x86/amd: Change NMI latency mitigation to use a
 timestamp
Thread-Index: AQHVSJr+u3qRs4Wxu0KQl/8M+KLjN6bmy3uAgAADw4A=
Date:   Thu, 1 Aug 2019 21:29:43 +0000
Message-ID: <b4597324-6eb8-31fa-e911-63f3b704c974@amd.com>
References: <833ee307989ac6bfb45efe823c5eca4b2b80c7cf.1564685848.git.thomas.lendacky@amd.com>
 <20190801211613.GB3578@hirez.programming.kicks-ass.net>
In-Reply-To: <20190801211613.GB3578@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR16CA0042.namprd16.prod.outlook.com
 (2603:10b6:805:ca::19) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76b8f494-b624-4a1b-f7ca-08d716c75e66
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3852;
x-ms-traffictypediagnostic: DM6PR12MB3852:
x-microsoft-antispam-prvs: <DM6PR12MB385280D72C40495F5F158DA5ECDE0@DM6PR12MB3852.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(6506007)(66066001)(26005)(6486002)(6246003)(54906003)(229853002)(296002)(6436002)(316002)(71200400001)(186003)(81156014)(6916009)(71190400001)(52116002)(53936002)(305945005)(99286004)(256004)(7736002)(8936002)(81166006)(31686004)(5660300002)(8676002)(102836004)(11346002)(76176011)(2616005)(476003)(3846002)(66946007)(14444005)(6512007)(6116002)(446003)(2906002)(4326008)(14454004)(478600001)(66556008)(36756003)(53546011)(7416002)(86362001)(66446008)(68736007)(386003)(66476007)(31696002)(25786009)(64756008)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3852;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7euxa0RT8a05J5ZdQp5uNhhlmFkTJGslLTIAVEjzMctnQlBkTz74ZA+Eylsbq1Trc6BOImASE5MJUdnlgXWnVCTQYZlnjOShY4XHJ80hAjpUY6SKAbLo4t6kkcn8PMTNTnOXa15kEqxDAjhWQUbuEA9ACJZtCsPZ1GoA+5v1wgwZfxyQ+vXpx59zpRVLI6ExPnUQ1OWlN2eNZWllXX+RDGuAC02R5N/7aePEkg2UQCW5AgE4vuxhT9PSC0u2bAzUgvHH/JEQWszkz1e5vBggE2LCmLqUBi/GFgcMFZmRKXgenoV/Fp7NxpNRfcproHRUlMnFpxUUzF4FCz1lFBwnbmQ7URp9kJog4FGV/OnyhuunWUJCozgu/mvFENnDiBGOGw8/BuZI/vARhBdH4U/lk0zYDFGs3yc53aGVz2xgxH0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99C5B0896C596E41AB7136B42F4924C6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b8f494-b624-4a1b-f7ca-08d716c75e66
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 21:29:43.6242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3852
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xLzE5IDQ6MTYgUE0sIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBUaHUsIEF1ZyAw
MSwgMjAxOSBhdCAwNjo1Nzo0MVBNICswMDAwLCBMZW5kYWNreSwgVGhvbWFzIHdyb3RlOg0KPj4g
RnJvbTogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4NCj4+DQo+PiBJdCB0
dXJucyBvdXQgdGhhdCB0aGUgTk1JIGxhdGVuY3kgd29ya2Fyb3VuZCBmcm9tIGNvbW1pdCA2ZDNl
ZGFhZTE2YzYNCj4+ICgieDg2L3BlcmYvYW1kOiBSZXNvbHZlIE5NSSBsYXRlbmN5IGlzc3VlcyBm
b3IgYWN0aXZlIFBNQ3MiKSBlbmRzIHVwDQo+PiBiZWluZyB0b28gY29uc2VydmF0aXZlIGFuZCBy
ZXN1bHRzIGluIHRoZSBwZXJmIE5NSSBoYW5kbGVyIGNsYWltaW5nIE5NSXMNCj4+IHRvIGVhc2ls
eSBvbiBBTUQgaGFyZHdhcmUgd2hlbiB0aGUgTk1JIHdhdGNoZG9nIGlzIGFjdGl2ZS4NCj4+DQo+
PiBUaGlzIGhhcyBhbiBpbXBhY3QsIGZvciBleGFtcGxlLCBvbiB0aGUgaHB3ZHQgKEhQRSB3YXRj
aGRvZyB0aW1lcikgbW9kdWxlLg0KPj4gVGhpcyBtb2R1bGUgY2FuIHByb2R1Y2UgYW4gTk1JIHRo
YXQgaXMgdXNlZCB0byByZXNldCB0aGUgc3lzdGVtLiBJdA0KPj4gcmVnaXN0ZXJzIGFuIE5NSSBo
YW5kbGVyIGZvciB0aGUgTk1JX1VOS05PV04gdHlwZSBhbmQgcmVsaWVzIG9uIHRoZSBmYWN0DQo+
PiB0aGF0IG5vdGhpbmcgaGFzIGNsYWltZWQgYW4gTk1JIHNvIHRoYXQgaXRzIGhhbmRsZXIgd2ls
bCBiZSBpbnZva2VkIHdoZW4NCj4+IHRoZSB3YXRjaGRvZyBkZXZpY2UgcHJvZHVjZXMgYW4gTk1J
LiBBZnRlciB0aGUgcmVmZXJlbmNlZCBjb21taXQsIHRoZQ0KPj4gaHB3ZHQgbW9kdWxlIGlzIHVu
YWJsZSB0byBwcm9jZXNzIGl0cyBnZW5lcmF0ZWQgTk1JIGlmIHRoZSBOTUkgd2F0Y2hkb2cgaXMN
Cj4+IGFjdGl2ZSwgYmVjYXVzZSB0aGUgY3VycmVudCBOTUkgbGF0ZW5jeSBtaXRpZ2F0aW9uIHJl
c3VsdHMgaW4gdGhlIE5NSQ0KPj4gYmVpbmcgY2xhaW1lZCBieSB0aGUgcGVyZiBOTUkgaGFuZGxl
ci4NCj4+DQo+PiBVcGRhdGUgdGhlIEFNRCBwZXJmIE5NSSBsYXRlbmN5IG1pdGlnYXRpb24gd29y
a2Fyb3VuZCB0bywgaW5zdGVhZCwgdXNlIGENCj4+IHdpbmRvdyBvZiB0aW1lLiBXaGVuZXZlciBh
IFBNQyBpcyBoYW5kbGVkIGluIHRoZSBwZXJmIE5NSSBoYW5kbGVyLCBzZXQgYQ0KPj4gdGltZXN0
YW1wIHdoaWNoIHdpbGwgYWN0IGFzIGEgcGVyZiBOTUkgd2luZG93LiBBbnkgTk1JcyBhcnJpdmlu
ZyB3aXRoaW4NCj4+IHRoYXQgd2luZG93IHdpbGwgYmUgY2xhaW1lZCBieSBwZXJmLiBBbnl0aGlu
ZyBvdXRzaWRlIHRoYXQgd2luZG93IHdpbGwNCj4+IG5vdCBiZSBjbGFpbWVkIGJ5IHBlcmYuIFRo
ZSB2YWx1ZSBmb3IgdGhlIE5NSSB3aW5kb3cgaXMgc2V0IHRvIDEwMCBtc2Vjcy4NCj4+IFRoaXMg
aXMgYSBjb25zZXJ2YXRpdmUgdmFsdWUgdGhhdCBlYXNpbHkgY292ZXJzIGFueSBOTUkgbGF0ZW5j
eSBpbiB0aGUNCj4+IGhhcmR3YXJlLiBXaGlsZSB0aGlzIHN0aWxsIHJlc3VsdHMgaW4gYSB3aW5k
b3cgaW4gd2hpY2ggdGhlIGhwd2R0IG1vZHVsZQ0KPj4gd2lsbCBub3QgcmVjZWl2ZSBpdHMgTk1J
LCB0aGUgd2luZG93IGlzIG5vdyBtdWNoLCBtdWNoIHNtYWxsZXIuDQo+IA0KPiBCbGVyZ2gsIEkg
c28gaGF0ZSBhbGwgdGhpcy4gVGhlIHByb3Bvc2VkIHBhdGNoIGlzIGJhc2ljYWxseSBkdWN0IHRh
cGUuDQoNClllYWgsIEknbSBub3QgYSBmYW4gZWl0aGVyLg0KDQo+IA0KPiBUaGUgaG9ycmlibHkg
cmV0YXJkZWQgeDg2IE5NSSBpbmZyYXN0cnVjdHVyZSBzdHJpa2VzIGFnYWluIDovDQo+IA0KPiBU
b207IGRvIHlvdSBoYXZlIGFueSBpZGVhIGhvdyBleHBlbnNpdmUgaXQgaXMgdG8gdHdpZGRsZSBD
UjggYW5kIHBsYXkNCj4gZ2FtZXMgd2l0aCBpbnRlcnJ1cHQgcHJpb3JpdGllcyBpbnN0ZWFkIG9m
IHBpbGluZyB3b3JsZCArIGRvZyBvbiB0aGlzDQo+IG9uZSBOTUkgbGluZT8gKGFzIGNvbXBhcmVk
IHRvIENMSS9TVEkpDQoNCkkgY2FuIGNoZWNrIG9uIHRoYXQuICBXaGF0IGFyZSB5b3UgdGhpbmtp
bmc/DQoNClRoYW5rcywNClRvbQ0KDQo+IA0K
