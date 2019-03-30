Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49571C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E37218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbfC3Ccn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 22:32:43 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2518 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730001AbfC3Ccn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 22:32:43 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id CAE351048FD665FCF21D;
        Sat, 30 Mar 2019 10:32:40 +0800 (CST)
Received: from DGGEMM506-MBS.china.huawei.com ([169.254.4.235]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0415.000;
 Sat, 30 Mar 2019 10:32:36 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "labbott@redhat.com" <labbott@redhat.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Todd Kjos <tkjos@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        =?utf-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        "Christian Brauner" <christian@brauner.io>
Subject: RE: [PATCH] staging: android: ion: refactory ion_alloc for kernel
 driver use
Thread-Topic: [PATCH] staging: android: ion: refactory ion_alloc for kernel
 driver use
Thread-Index: AQHU5hvBBBKtnihC9E+86WTyiok4UaYiP5oAgAE0bMA=
Date:   Sat, 30 Mar 2019 02:32:35 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED24EBDE4F@DGGEMM506-MBS.china.huawei.com>
References: <1553884816-37850-1-git-send-email-prime.zeng@hisilicon.com>
 <20190329160336.GB5906@kroah.com>
In-Reply-To: <20190329160336.GB5906@kroah.com>
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogR3JlZyBLcm9haC1IYXJ0bWFuIFtt
YWlsdG86Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmddDQo+U2VudDogU2F0dXJkYXksIE1hcmNo
IDMwLCAyMDE5IDEyOjA0IEFNDQo+VG86IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNv
bi5jb20+DQo+Q2M6IGxhYmJvdHRAcmVkaGF0LmNvbTsgc3VtaXQuc2Vtd2FsQGxpbmFyby5vcmc7
DQo+ZGV2ZWxAZHJpdmVyZGV2Lm9zdW9zbC5vcmc7IFRvZGQgS2pvcyA8dGtqb3NAYW5kcm9pZC5j
b20+Ow0KPmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmc7DQo+bGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnOyBBcnZlIEhqw7hu
bmV2w6VnIDxhcnZlQGFuZHJvaWQuY29tPjsNCj5Kb2VsIEZlcm5hbmRlcyA8am9lbEBqb2VsZmVy
bmFuZGVzLm9yZz47IE1hcnRpam4gQ29lbmVuDQo+PG1hY29AYW5kcm9pZC5jb20+OyBDaHJpc3Rp
YW4gQnJhdW5lciA8Y2hyaXN0aWFuQGJyYXVuZXIuaW8+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0g
c3RhZ2luZzogYW5kcm9pZDogaW9uOiByZWZhY3RvcnkgaW9uX2FsbG9jIGZvciBrZXJuZWwNCj5k
cml2ZXIgdXNlDQo+DQo+T24gU2F0LCBNYXIgMzAsIDIwMTkgYXQgMDI6NDA6MTZBTSArMDgwMCwg
WmVuZyBUYW8gd3JvdGU6DQo+PiBUaGVyZSBhcmUgdHdvIHJlYXNvbnMgZm9yIHRoaXMgcGF0Y2g6
DQo+PiAxLiBUaGVyZSBhcmUgc29tZSBwb3RlbnRpYWwgcmVxdWlyZW1lbnRzIGZvciBpb25fYWxs
b2MgaW4ga2VybmVsDQo+PiBzcGFjZSwgc29tZSBtZWRpYSBkcml2ZXJzIG5lZWQgdG8gYWxsb2Nh
dGUgbWVkaWEgYnVmZmVycyBmcm9tIGlvbg0KPj4gaW5zdGVhZCBvZiBidWRkeSBvciBkbWEgZnJh
bWV3b3JrLCB0aGlzIGlzIG1vcmUgY29udmllbnQgYW5kIGNsZWFuDQo+PiB2ZXJ5IGZvciBtZWRp
YSBkcml2ZXJzLiBBbmQgSW4gdGhhdCBjYXNlLCBpb24gaXMgdGhlIG9ubHkgbWVkaWEgYnVmZmVy
DQo+PiBwcm92aWRlciwgaXQncyBtb3JlIGVhc2llciB0byBtYWludGFpbi4NCj4NCj5BcyB0aGlz
IHJlYWxseSBpcyBqdXN0IERNQSwgd2hhdCBpcyB3cm9uZyB3aXRoIHRoZSBleGlzdGluZyBkbWEg
ZnJhbWV3b3JrDQo+dGhhdCBtYWtlcyBpdCBoYXJkIHRvIHVzZT8gIFlvdSBoYXZlIHNlZW4gYWxs
IG9mIHRoZSBjaGFuZ2VzIHJlY2VudGx5IHRvIGl0LA0KPnJpZ2h0Pw0KDQpUaGUgY3VycmVudCBk
bWEgZnJhbWV3b3JrIGlzIHBvd2VyZnVsIGVub3VnaCh0byBtZSwgYW5kIG1vcmUgY29tcGxleCBe
X14pDQosIENNQSwgSU9NTVUgYXJlIGFsbCBpbnRlZ3JhdGVkLCBpdCdzIGdvb2QuIEJ1dCBidWZm
ZXIgc2hhcmluZywgc3RhdGlzdGljcywgZGVidWcsDQogYXJlIG5vdCBzbyBmcmllbmRseSBmb3Ig
bWVkaWEgZHJpdmVycyhlYWNoIGRyaXZlciBoYXMgdG8gZG8gYWxsLCBidXQgZHVwbGljYXRlIGpv
YnMpLg0KDQo+DQo+dGhhbmtzLA0KPg0KPmdyZWcgay1oDQo=
