Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E22CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3100B2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502561AbfJYKnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:43:33 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2491 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394452AbfJYKnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:43:32 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id CD703B4639AC788C5382;
        Fri, 25 Oct 2019 18:43:30 +0800 (CST)
Received: from dggeme716-chm.china.huawei.com (10.1.199.112) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 25 Oct 2019 18:43:30 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme716-chm.china.huawei.com (10.1.199.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 25 Oct 2019 18:43:30 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Fri, 25 Oct 2019 18:43:29 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86: get rid of odd out jump label in pdptrs_changed
Thread-Topic: [PATCH] KVM: x86: get rid of odd out jump label in
 pdptrs_changed
Thread-Index: AdWLGakuf4Ho+IrsTTKDazv6iSUzCw==
Date:   Fri, 25 Oct 2019 10:43:29 +0000
Message-ID: <10ec16d6c0c54cbc8166e7ef0cd5860e@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.184.189.20]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyNS8xMC8xOSwgUGFvbG8gQm9uemluaSAgd3JvdGU6DQo+T24gMjUvMTAvMTkgMDQ6MDEs
IE1pYW9oZSBMaW4gd3JvdGU6DQo+PiAtCWlmIChyIDwgMCkNCj4+IC0JCWdvdG8gb3V0Ow0KPj4g
LQljaGFuZ2VkID0gbWVtY21wKHBkcHRlLCB2Y3B1LT5hcmNoLndhbGtfbW11LT5wZHB0cnMsIHNp
emVvZihwZHB0ZSkpICE9IDA7DQo+PiAtb3V0Og0KPj4gKwlpZiAociA+PSAwKQ0KPj4gKwkJY2hh
bmdlZCA9IG1lbWNtcChwZHB0ZSwgdmNwdS0+YXJjaC53YWxrX21tdS0+cGRwdHJzLA0KPj4gKwkJ
CQkgc2l6ZW9mKHBkcHRlKSkgIT0gMDsNCj4+ICANCj4+ICAJcmV0dXJuIGNoYW5nZWQ7DQo+DQo+
RXZlbiBiZXR0ZXI6DQo+DQo+CWlmIChyIDwgMCkNCj4JCXJldHVybiB0cnVlOw0KPg0KPglyZXR1
cm4gbWVtY21wKC4uLikgIT0gMDsNCj4NCj5QYW9sbw0KDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2Vz
dGlvbi4gSSB3aWxsIHNlbmQgYSBwYXRjaCB2MiB0byBjb21wbGV0ZSBpdC4gTWFueSB0aGFua3Mu
DQo=
