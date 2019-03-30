Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17272C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E338B218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbfC3CdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 22:33:23 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2519 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730001AbfC3CdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 22:33:22 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 28E0E1AA322462581FF8;
        Sat, 30 Mar 2019 10:33:21 +0800 (CST)
Received: from DGGEMM506-MBS.china.huawei.com ([169.254.4.235]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0415.000;
 Sat, 30 Mar 2019 10:33:19 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "labbott@redhat.com" <labbott@redhat.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Todd Kjos <tkjos@android.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        =?utf-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Subject: RE: [PATCH] staging: android: ion: refactory ion_alloc for kernel
 driver use
Thread-Topic: [PATCH] staging: android: ion: refactory ion_alloc for kernel
 driver use
Thread-Index: AQHU5hvBBBKtnihC9E+86WTyiok4UaYh65sAgAGJ5AA=
Date:   Sat, 30 Mar 2019 02:33:18 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED24EBDE6F@DGGEMM506-MBS.china.huawei.com>
References: <1553884816-37850-1-git-send-email-prime.zeng@hisilicon.com>
 <20190329110258.GB32590@kadam>
In-Reply-To: <20190329110258.GB32590@kadam>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.222.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRGFuIENhcnBlbnRlciBbbWFpbHRv
OmRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbV0NCj5TZW50OiBGcmlkYXksIE1hcmNoIDI5LCAyMDE5
IDc6MDMgUE0NCj5UbzogWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT4NCj5D
YzogbGFiYm90dEByZWRoYXQuY29tOyBzdW1pdC5zZW13YWxAbGluYXJvLm9yZzsNCj5kZXZlbEBk
cml2ZXJkZXYub3N1b3NsLm9yZzsgVG9kZCBLam9zIDx0a2pvc0BhbmRyb2lkLmNvbT47IEdyZWcN
Cj5Lcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47DQo+bGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsNCj5s
aW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmc7IEFydmUgSGrDuG5uZXbDpWcgPGFydmVAYW5k
cm9pZC5jb20+Ow0KPkpvZWwgRmVybmFuZGVzIDxqb2VsQGpvZWxmZXJuYW5kZXMub3JnPjsgTWFy
dGlqbiBDb2VuZW4NCj48bWFjb0BhbmRyb2lkLmNvbT47IENocmlzdGlhbiBCcmF1bmVyIDxjaHJp
c3RpYW5AYnJhdW5lci5pbz4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSBzdGFnaW5nOiBhbmRyb2lk
OiBpb246IHJlZmFjdG9yeSBpb25fYWxsb2MgZm9yIGtlcm5lbA0KPmRyaXZlciB1c2UNCj4NCj5J
ZiB3ZSdyZSBnb2luZyB0byBleHBvcnQgaW9uX2FsbG9jKCkgZm9yIG90aGVyIGRyaXZlcnMgdG8g
dXNlIHRoZW4gbGV0J3MgbWFrZQ0KPmFuIGlvbl9mcmVlKCkgaGVscGVyIGZ1bmN0aW9uIGFzIHdl
bGwuDQo+DQoNCkdvb2QgY2F0Y2gsIHRoYW5rcy4gDQoNClJlZ2FyZHMNClplbmd0YW8gDQoNCj52
b2lkIGlvbl9mcmVlKHN0cnVjdCBkbWFfYnVmICpkbWFidWYpDQo+ew0KPglkbWFfYnVmX3B1dChk
bWFidWYpOw0KPn0NCj4NCj5yZWdhcmRzLA0KPmRhbiBjYXJwZW50ZXINCg0K
