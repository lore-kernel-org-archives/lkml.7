Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D72BC2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 03:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607982075E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 03:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfLZDJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 22:09:29 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2916 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726885AbfLZDJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 22:09:28 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 1BDA1EB4859CFFBCC120;
        Thu, 26 Dec 2019 11:09:24 +0800 (CST)
Received: from dggeme764-chm.china.huawei.com (10.3.19.110) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Dec 2019 11:09:23 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme764-chm.china.huawei.com (10.3.19.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 26 Dec 2019 11:09:23 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Thu, 26 Dec 2019 11:09:23 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Wanpeng Li <kernellwp@gmail.com>
CC:     Liran Alon <liran.alon@oracle.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] KVM: nvmx: retry writing guest memory after page fault
 injected
Thread-Topic: [PATCH] KVM: nvmx: retry writing guest memory after page fault
 injected
Thread-Index: AdW7lko+tW3NyOtpREmlZJcElxGdUw==
Date:   Thu, 26 Dec 2019 03:09:23 +0000
Message-ID: <d66b6e479a4e4113a86bee1c0682aa46@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.221.158]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCldhbnBlbmcgTGkgPGtlcm5lbGx3cEBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiBUaHUs
IDI2IERlYyAyMDE5IGF0IDEwOjMyLCBsaW5taWFvaGUgPGxpbm1pYW9oZUBodWF3ZWkuY29tPiB3
cm90ZToNCj4gPg0KPiA+ID4NCj4gPiA+SW4gYWRkaXRpb24sIGl0IHdpbGwgYmUgYXBwcmVjaWF0
ZWQgaWYgeW91IHdvdWxkIGFsc28gc3VibWl0IGt2bS11bml0LXRlc3QgdGhhdCB2ZXJpZmllcyB0
aGlzIGNvbmRpdGlvbi4NCj4gPg0KPiA+IEknZCBsaWtlIHRvIHN1Ym1pdCBrdm0tdW5pdC10ZXN0
IHRoYXQgdmVyaWZpZXMgdGhpcyBjb25kaXRpb24sIGJ1dCBJIA0KPiA+IGFtIG5vdCBmYW1pbGlh
ciB3aXRoIHRoZSBrdm0tdW5pdC10ZXN0IGNvZGUgeWV0IGFuZCBhbHNvIG5vdCBpbiBteSANCj4g
PiByZWNlbnQgdG9kbyBsaXN0LiBTbyBzdWNoIGEgcGF0Y2ggbWF5IGNvbWUgbGF0ZS4gSXQgd291
bGQgYmUgDQo+ID4gYXBwcmVjaWF0ZWQgdG9vIGlmIHlvdSBjb3VsZCBzdWJtaXQgdGhpcyBrdm0t
dW5pdC10ZXN0IHBhdGNoLiA6KQ0KPg0KPiBIbW0sIGRpZCB5b3UgdmVyaWZ5IHlvdXIgb3duIHBh
dGNoPyBQbGVhc2UgZ2l2ZSB0aGUgdGVzdGNhc2UuDQo+DQoNCkknYW0gc29ycnkgYnV0IHRoaXMg
aXMgYSBjb2RlIGluc3BlY3Rpb24gcGF0aC4gQW5kIEkgdGhpbmsgdGhpcyBmaXggaXMgY29ycmVj
dCBmcm9tIHRoZSBjb2RlIGxvZ2ljIGFuZA0KdGhpcyBiZWhhdmlvciBpcyBzaW1pbGFyIGFzIGhh
bmRsZV92bXdyaXRlLCBoYW5kbGVfdm1wdHJzdCwgaGFuZGxlX2ludmVwdCBhbmQgc28gb24uIFRo
YW5rcyENCg==
