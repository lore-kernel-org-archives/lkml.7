Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9922C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 13:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F532147A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 13:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfFPN5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 09:57:02 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6962 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbfFPN5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 09:57:02 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 4FD339C215E9BAA019A1;
        Sun, 16 Jun 2019 21:56:59 +0800 (CST)
Received: from DGGEMM507-MBX.china.huawei.com ([169.254.1.169]) by
 DGGEMM401-HUB.china.huawei.com ([10.3.20.209]) with mapi id 14.03.0439.000;
 Sun, 16 Jun 2019 21:56:49 +0800
From:   Nixiaoming <nixiaoming@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "skinsbursky@parallels.com" <skinsbursky@parallels.com>
CC:     "vvs@virtuozzo.com" <vvs@virtuozzo.com>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "Nadia.Derbey@bull.net" <Nadia.Derbey@bull.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
        "Huangjianhui (Alex)" <alex.huangjianhui@huawei.com>,
        Dailei <dylix.dailei@huawei.com>,
        Stanislav Kinsbursky <skinsbursky@parallels.com>,
        Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: RE: [PATCH] kernel/notifier.c: remove notifier_chain_register
Thread-Topic: [PATCH] kernel/notifier.c: remove notifier_chain_register
Thread-Index: AQHVIfmToZlGaGc/cESr8dpAvR4RxaaZdRCAgATUotA=
Date:   Sun, 16 Jun 2019 13:56:47 +0000
Deferred-Delivery: Sun, 16 Jun 2019 09:00:00 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12AC29744@dggemm507-mbx.china.huawei.com>
References: <1560434864-98664-1-git-send-email-nixiaoming@huawei.com>
 <20190613123823.bf75e7305e22dd1dcab04fb8@linux-foundation.org>
In-Reply-To: <20190613123823.bf75e7305e22dd1dcab04fb8@linux-foundation.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.88.168]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAxNCBKdW4gMjAxOSAwMzozOCBBTSBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZv
dW5kYXRpb24ub3JnPiB3cm90ZToNCj5PbiBUaHUsIDEzIEp1biAyMDE5IDIyOjA3OjQ0ICswODAw
IFhpYW9taW5nIE5pIDxuaXhpYW9taW5nQGh1YXdlaS5jb20+IHdyb3RlOg0KPg0KPj4gUmVnaXN0
ZXJpbmcgdGhlIHNhbWUgbm90aWZpZXIgdG8gYSBob29rIHJlcGVhdGVkbHkgY2FuIGNhdXNlIHRo
ZSBob29rDQo+PiBsaXN0IHRvIGZvcm0gYSByaW5nIG9yIGxvc2Ugb3RoZXIgbWVtYmVycyBvZiB0
aGUgbGlzdC4NCj4+IC4uLi4uDQo+PiANCj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvbm90aWZpZXIu
YyBiL2tlcm5lbC9ub3RpZmllci5jDQo+PiBpbmRleCBkOWY1MDgxLi41NmVmZDU0IDEwMDY0NA0K
Pj4gLS0tIGEva2VybmVsL25vdGlmaWVyLmMNCj4+ICsrKyBiL2tlcm5lbC9ub3RpZmllci5jDQo+
PiBAQCAtMTksMjAgKzE5LDYgQEANCj4+ICAgKglhcmUgbGF5ZXJlZCBvbiB0b3Agb2YgdGhlc2Us
IHdpdGggYXBwcm9wcmlhdGUgbG9ja2luZyBhZGRlZC4NCj4+ICAgKi8NCj4+ICANCj4+IC1zdGF0
aWMgaW50IG5vdGlmaWVyX2NoYWluX3JlZ2lzdGVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAqKm5s
LA0KPj4gLQkJc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuKQ0KPj4gLXsNCj4+IC0Jd2hpbGUgKCgq
bmwpICE9IE5VTEwpIHsNCj4+IC0JCVdBUk5fT05DRSgoKCpubCkgPT0gbiksICJkb3VibGUgcmVn
aXN0ZXIgZGV0ZWN0ZWQiKTsNCj4+IC0JCWlmIChuLT5wcmlvcml0eSA+ICgqbmwpLT5wcmlvcml0
eSkNCj4+IC0JCQlicmVhazsNCj4+IC0JCW5sID0gJigoKm5sKS0+bmV4dCk7DQo+PiAtCX0NCj4+
IC0Jbi0+bmV4dCA9ICpubDsNCj4+IC0JcmN1X2Fzc2lnbl9wb2ludGVyKCpubCwgbik7DQo+PiAt
CXJldHVybiAwOw0KPj4gLX0NCj4NCj5SZWdpc3RlcmluZyBhbiBhbHJlYWR5LXJlZ2lzdGVyZWQg
bm90aWZpZXIgaXMgYSBidWcgKGV4Y2VwdCBmb3IgaW4NCj5uZXQvc3VucnBjL3JwY19waXBlLmMs
IGFwcGFyZW50bHkpLiAgVGhlIGVmZmVjdCBvZiB0aGlzIGNoYW5nZSBpcyB0bw0KPnJlbW92ZSB0
aGUgd2FybmluZyBhYm91dCB0aGUgcHJlc2VuY2Ugb2YgdGhlIGJ1Zywgc28gdGhlIGJ1ZyBpcyBs
ZXNzDQo+bGlrZWx5IHRvIGdldCBmaXhlZC4NCj4NCnRoYW5rcyBmb3IgeW91ciBndWlkYW5jZSwN
Cg0KU2hvdWxkIEkgbW9kaWZ5IHRoaXMgd2F5IA0KICAgMSBub3RpZmllcl9jaGFpbl9jb25kX3Jl
Z2lzdGVyKCkgYW5kIG5vdGlmaWVyX2NoYWluX3JlZ2lzdGVyKCkgc2hvdWxkIGJlIGNvbWJpbmVk
IGludG8gb25lIGZ1bmN0aW9uLg0KICAgMiBUaGUgd2FybmluZyBpbmZvcm1hdGlvbiBuZWVkcyB0
byBiZSBkaXNwbGF5ZWQgd2hpbGUgcHJvaGliaXRpbmcgZHVwbGljYXRlIHJlZ2lzdHJhdGlvbi4N
CgkJQEAgLTIzLDcgKzIzLDEwIEBAIHN0YXRpYyBpbnQgbm90aWZpZXJfY2hhaW5fcmVnaXN0ZXIo
c3RydWN0IG5vdGlmaWVyX2Jsb2NrICoqbmwsDQoJCQkJCQlzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sg
Km4pDQoJCSB7DQoJCQkJd2hpbGUgKCgqbmwpICE9IE5VTEwpIHsNCgkJLSAgICAgICAgICAgV0FS
Tl9PTkNFKCgoKm5sKSA9PSBuKSwgImRvdWJsZSByZWdpc3RlciBkZXRlY3RlZCIpOw0KCQkrICAg
ICAgICAgaWYgKHVubGlrZWx5KCgqbmwpID09IG4pKSB7DQoJCSsgICAgICAgICAgICAgICAgIFdB
Uk4oMSwgImRvdWJsZSByZWdpc3RlciBkZXRlY3RlZCIpOw0KCQkrICAgICAgICAgICAgICAgICBy
ZXR1cm4gMDsNCgkJKyAgICAgICAgIH0NCgkJCQkJCWlmIChuLT5wcmlvcml0eSA+ICgqbmwpLT5w
cmlvcml0eSkNCgkJCQkJCQkJYnJlYWs7DQoNCj5JIHRoaW5rIGl0IHdvdWxkIGJlIGJldHRlciB0
byByZW1vdmUgbm90aWZpZXJfY2hhaW5fY29uZF9yZWdpc3RlcigpIGFuZA0KPmJsb2NraW5nX25v
dGlmaWVyX2NoYWluX2NvbmRfcmVnaXN0ZXIoKSBhbmQgdG8gZmlndXJlIG91dCB3aHkNCj5uZXQv
c3VucnBjL3JwY19waXBlLmMgaXMgdXNpbmcgaXQgYW5kIHRvIHJlZG8gdGhlIHJwYyBjb2RlIHNv
IGl0IG5vDQo+bG9uZ2VyIGhhcyB0aGF0IG5lZWQuDQo+DQp0aGFua3MgZm9yIHlvdXIgZ3VpZGFu
Y2UsDQpJIHJlLWV4YW1pbmUgdGhlIHN1Ym1pc3Npb24gcmVjb3JkIGFuZCBhbmFseXplIGl0IGFz
IGZvbGxvd3MNCg0Kbm90aWZpZXJfY2hhaW5fY29uZF9yZWdpc3RlcigpIHdhcyBpbnRyb2R1Y2Vk
IGJ5IGNvbW1pdCA2NTQ2YmM0Mjc5MjQxZThmYTQzDQogKCJpcGM6IHJlLWVuYWJsZSBtc2dtbmkg
YXV0b21hdGljIHJlY29tcHV0aW5nIG1zZ21uaSBpZiDigIvigItzZXQgdG8gbmVnYXRpdmUiKQ0K
RnJvbSB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gaW5mb3JtYXRpb24sIGl0IHNob3VsZCBiZSBkb25l
IHRvIGF2b2lkIHJlcGVhdGVkIHJlZ2lzdHJhdGlvbnMsDQogYnV0IEkgZG9uJ3Qga25vdyB3aHkg
bm90IGRpcmVjdGx5IG1vZGlmeSBub3RpZmllcl9jaGFpbl9jb25kX3JlZ2lzdGVyKCkuDQogDQpu
b3RpZmllcl9jaGFpbl9jb25kX3JlZ2lzdGVyKCkgaXMgb25seSBjYWxsZWQgYnkgYmxvY2tpbmdf
bm90aWZpZXJfY2hhaW5fY29uZF9yZWdpc3RlcigpDQpibG9ja2luZ19ub3RpZmllcl9jaGFpbl9j
b25kX3JlZ2lzdGVyKCkgaGFzIGxlc3MgcHJvY2Vzc2luZyBvZiB0aGUgU1lTVEVNX0JPT1RJTkcg
c3RhdGUgDQp0aGFuIGJsb2NraW5nX25vdGlmaWVyX2NoYWluX2VnaXN0ZXIoKS4NCm1heSBhbHNv
IGJlIGEgYnVnLg0KDQppcGMvaXBjbnNfbm90aWZpZXIuYyBhbmQgdGhlIGNhbGwgdG8gYmxvY2tp
bmdfbm90aWZpZXJfY2hhaW5fY29uZF9yZWdpc3RlcigpIGFyZSByZW1vdmVkIA0KaW4gY29tbWl0
IDAwNTBlZTA1OWY3ZmM4NmIxZGYyNTIgKCJpcGMvbXNnOiBpbmNyZWFzZSBNU0dNTkksIHJlbW92
ZSBzY2FsaW5nIikuDQoNCm5vdyBibG9ja2luZ19ub3RpZmllcl9jaGFpbl9jb25kX3JlZ2lzdGVy
KCkgaXMgb25seSB1c2VkIGluIG5ldC9zdW5ycGMvcnBjX3BpcGUuYywgDQpjb21taXQgMmQwMDEz
MWFjYzY0MWIyY2I2ICgiU1VOUlBDOiBzZW5kIG5vdGlmaWNhdGlvbiBldmVudHMgb24gcGlwZWZz
IHNiIGNyZWF0aW9uIGFuZCBkZXN0cnVjdGlvbiIpDQpVc2luZyBibG9ja2luZ19ub3RpZmllcl9j
aGFpbl9jb25kX3JlZ2lzdGVyKCkgbWF5IGFsc28gYmUgdG8gYXZvaWQgZHVwbGljYXRlIHJlZ2lz
dHJhdGlvbnM/Pw0KDQp0aGFua3MNCg0K
