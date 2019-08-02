Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C61C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9122B2184B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LhOiLXf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394979AbfHBOds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:33:48 -0400
Received: from mail-eopbgr810048.outbound.protection.outlook.com ([40.107.81.48]:38016
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731131AbfHBOdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:33:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=es2RThQhvWfy2aqbhk+tLfzPT7K7hTs405SGQl+/mPKe+DChcJ4kUeZ16kOLv42vBS3MdpeImS+IMcDLAiNfL5eH5txBpfH0GyfL9zRVMcF9RE/tSko146qTk1OqrNz+0n0JNiHhkaTeAM+Lgs9kH0AQ7veH4FaX8d44WXYw6MaBfjWKCmF3zaHCVrAL4KbGWzKDEioCc1T/YhykWA6v/7fk0bOP2SMzW7HxK8uqhTbpvKmJMAzgQ4hGo33uM/SrewwkL8ZbJF+T42i9zDB4/0x+o2dilIiSQJ0KQq6eiVjz/u7IkblvbF6+pLJR24EycKnFkLlVChkaqHmZeqMxsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6ygsfc0urj/noYAlsIJ1nOEUXM5ZedPS/nVfJ05/iY=;
 b=e+3qnXfzfV+7jp62k1QY+4bzZGGeP1fSJ3Cr21K7t3JaH3Cd09QuXjODUnPrArYf9lh93zC/yCtpSg9kRn4mzE5IfddsmvfqDD1Crgi5n0KgKlXsQFhXMUqNp+golGhzLDi0P1P8pJmaP3I5YMWns2NiZCEvfRn0XouwLFjkKAEsb8+HFOl1KVqWdXwa1sLqRpsxXbWJ8ahlh6mz14UPhqr6cC3AyllWBZM2+q+XCTK3wr4KXACudpDYTLVYcFWjmMKuf8PMh+asG06HTUftT8KskJBrwqEAbwWXgQ9VyvZ5PFY86cePXej34htNpc/9lBui7PZBYZbYW3qOkOzMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6ygsfc0urj/noYAlsIJ1nOEUXM5ZedPS/nVfJ05/iY=;
 b=LhOiLXf1eb46xxZlT/ahivu9495yBnShAb89L5s+Z9CKafTGeOzSJOeItxTbvHGcSOjc18XoLZGR4frZFa9cWFRBXVr8jMN+DMdb/uHJo9KeF20R44MhUTyw5FyeQpckflLR6+EXzIGn4iVomInfPSMCWo/OtNu/+uOUYYJaPsI=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2811.namprd12.prod.outlook.com (20.176.117.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 2 Aug 2019 14:33:42 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 14:33:42 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH] perf/x86/amd: Change NMI latency mitigation to use a
 timestamp
Thread-Topic: [PATCH] perf/x86/amd: Change NMI latency mitigation to use a
 timestamp
Thread-Index: AQHVSJr+u3qRs4Wxu0KQl/8M+KLjN6bmy3uA//+v8oCAAFUigIAAA92AgAADOYCAARWjgA==
Date:   Fri, 2 Aug 2019 14:33:41 +0000
Message-ID: <925c3458-aeae-a44b-ddd5-40a1e173a307@amd.com>
References: <833ee307989ac6bfb45efe823c5eca4b2b80c7cf.1564685848.git.thomas.lendacky@amd.com>
 <20190801211613.GB3578@hirez.programming.kicks-ass.net>
 <b4597324-6eb8-31fa-e911-63f3b704c974@amd.com>
 <alpine.DEB.2.21.1908012331550.1789@nanos.tec.linutronix.de>
 <20190801214813.GB2332@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1908012352390.1789@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908012352390.1789@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0026.namprd02.prod.outlook.com
 (2603:10b6:803:2e::12) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26fadec2-ef6f-42e7-daa2-08d717566a7c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB2811;
x-ms-traffictypediagnostic: DM6PR12MB2811:
x-microsoft-antispam-prvs: <DM6PR12MB28113B76EAC40A4DC6CCB164ECD90@DM6PR12MB2811.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:214;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(66066001)(76176011)(2906002)(7736002)(25786009)(54906003)(296002)(2616005)(14454004)(11346002)(446003)(316002)(6486002)(486006)(110136005)(52116002)(6436002)(4326008)(81166006)(86362001)(476003)(478600001)(99286004)(53936002)(36756003)(305945005)(31696002)(81156014)(8676002)(31686004)(71200400001)(71190400001)(26005)(7416002)(186003)(6246003)(256004)(64756008)(66446008)(66556008)(102836004)(66476007)(66946007)(229853002)(5660300002)(6506007)(8936002)(6512007)(6116002)(3846002)(53546011)(386003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2811;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hiPF1PEWK5EpMrPLJd+o0QvEiJGTNCt4spJqy4zEYuXdTMAUDn2ji+vVzxZQPOU6ey55j3kvU9Y8yKrIGtvGTJiklmZ/4E9U6QBiupfUoEZlCVO8S6u9tpf2vD8tb3jyju272N4RnqbdpyqwF9XgSfhOm8NG7EhK3AjanFFl70zYVg/YUC6x8JJRZQigiCwzL/vrAYWATS0vJZAeWs8SxMIqOzlL8+kcbcdIAgp5RhmrGGcCS35BYDit9uJUJwRploZ4jmAJr9iKBGgImk3HPR3mlspoZXSdYMVuqd5I7pxIKvx4aXTUgUthTINk/XP2ybCD/n6MBltOBikUrRwe/BRaaiWEY45RwT8ltwTvzO0oJBAfV0Gsi7fRAPBvjHmKKM0ZydmhPg39nANLRAVUo9D2YhErR+GOaoaNrymdhb4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E58C4BCF93A94D49BDDE3E248873E20B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fadec2-ef6f-42e7-daa2-08d717566a7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 14:33:42.0436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xLzE5IDQ6NTkgUE0sIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gT24gVGh1LCAxIEF1
ZyAyMDE5LCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+IE9uIFRodSwgQXVnIDAxLCAyMDE5IGF0
IDExOjM0OjIzUE0gKzAyMDAsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4+PiBBdm9pZCB0aGUg
d2hvbGUgTk1JIG1lc3MsIG1ha2UgdGhlIFBNQyBpbnRlcnJ1cHQgYSBwcm9wZXIgdmVjdG9yIGlu
IHRoZQ0KPj4+IGhpZ2hlc3QgcHJpbyBidWNrZXQgYW5kIGluc3RlYWQgb2YgdXNpbmcgQ0xJL1NU
SSB1c2UgQ1I4LiBUaGF0IHdvdWxkIGhhdmUNCj4+PiB0aGUgYWRkaXRpb25hbCBhZHZhbnRhZ2Ug
dGhhdCB3ZSBjb3VsZCBwcmV2ZW50IHBlcmYgIk5NSSIgdGhlbiBvY2NzaW9uYWxseSA6KQ0KPj4N
Cj4+IEV4YWN0bHksIGFuZCBub3Qgb25seSB0aGUgUE1DLCB3ZSBjYW4gYmFzaWNhbGx5IHN0YXJ0
IGdpdmluZyBvdXQgYWN0dWFsDQo+PiB2ZWN0b3JzIG9uIHJlZ2lzdGVyX25taV9oYW5kbGVyKCkg
YW5kIGRvIGF3YXkgd2l0aCBhbGwgdGhhdCBzaGFyZWQgbGluZQ0KPj4gY3JhcC4NCj4+DQo+PiBB
bmQgdGhlbiB0aGUgYWN0dWFsIE5NSSBsaW5lIHdpbGwgYmUgbW9zdGx5IGVtcHR5IGFnYWluLCBh
bmQgaXQgY2FuIHJlYWQNCj4+IGl0cyBzdHVwaWQgc2xvdyByZWFzb24gcG9ydCBhZ2Fpbi4NCj4+
DQo+PiBPbmUgY29tcGxpY2F0aW9uIHRob3VnaDsgSVJFVCBldCBhbCBvbmx5IGRvIEVGTEFHUywg
bm90IENSOCwgc28gdGhhdCdzDQo+PiBnb2luZyB0byBiZSBtYXNzaXZlIGZ1biA6LSgNCg0KVGFs
a2luZyB0byB0aGUgaGFyZHdhcmUgZm9sa3MsIHRoZXkgc2F5IHNldHRpbmcgQ1I4IGlzIGEgc2Vy
aWFsaXppbmcNCmluc3RydWN0aW9uIGFuZCBoYXMgdG8gY29tbXVuaWNhdGUgb3V0IHRvIHRoZSBB
UElDLCBzbyBpdCdzIGJldHRlciB0bw0KdXNlIENMSS9TVEkuDQoNClRoYW5rcywNClRvbQ0KDQo+
Pg0KPj4gRGlkIEkgc2F5IEkgaGF0ZXMgdGhlIHg4NiBpbnRlcnJ1cHQgc2NoZW1lPw0KPiANCj4g
WW91J3JlIG5vdCBhbG9uZS4NCj4gDQo+IFRoYXQgc3R1ZmYgZGVmaW5pdGVseSB2aW9sYXRlcyBh
cnRpY2xlIDMgb2YgdGhlIENvbnZlbnRpb24gZm9yIHRoZQ0KPiBQcm90ZWN0aW9uIG9mIEh1bWFu
IFJpZ2h0cyBhbmQgRnVuZGFtZW50YWwgRnJlZWRvbXMuDQo+IA0KPiANCg==
