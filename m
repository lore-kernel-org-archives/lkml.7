Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F7CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7627218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCPLPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 07:15:11 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2096 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbfCPLPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 07:15:10 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 846055D5B77D776237B4;
        Sat, 16 Mar 2019 19:15:07 +0800 (CST)
Received: from DGGEML421-HUB.china.huawei.com (10.1.199.38) by
 DGGEML404-HUB.china.huawei.com (10.3.17.39) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sat, 16 Mar 2019 19:15:07 +0800
Received: from DGGEML529-MBX.china.huawei.com ([169.254.6.70]) by
 dggeml421-hub.china.huawei.com ([10.1.199.38]) with mapi id 14.03.0415.000;
 Sat, 16 Mar 2019 19:15:04 +0800
From:   chenjianguo <chenjianguo3@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liyou (leeyou, RTOS)" <leeyou.li@huawei.com>,
        "Joey Yan(Bo)" <joey.yanbo@huawei.com>,
        "Xiaowei (C)" <xiaowei774@huawei.com>,
        "zhanghan (Q)" <zhanghan23@huawei.com>,
        Yangyingliang <yangyingliang@huawei.com>,
        yaohongbo <yaohongbo@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: [PATCH] mbigen: don't clear eventid when free_irq
Thread-Topic: [PATCH] mbigen: don't clear eventid when free_irq
Thread-Index: AQHU2+lFVXrYmiTu3Umv8/dsRgn1aQ==
Date:   Sat, 16 Mar 2019 11:15:03 +0000
Message-ID: <D08D06C366851D40A251D08BEEAA0F9A04367BD6@dggeml529-mbx.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.177.192]
Content-Type: text/plain; charset="utf-8"
Content-ID: <371936ADF3DE3D4F8848CFE81CD78CF6@huawei.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmlhbmd1byBDaGVuIDxjaGVuamlhbmd1bzNAaHVhd2VpLmNvbT4NCg0KbWJpZ2VuX3dy
aXRlX21zZyBjbGVhcnMgZXZlbnRpZCBiaXRzIG9mIGEgbWJpZ2VuIHJlZ2lzdGVyDQp3aGVuIGZy
ZWUgYSBpbnRlcnJ1cHQsIGJlY2F1c2UgbXNpX2RvbWFpbl9kZWFjdGl2YXRlIG1lbXNldA0Kc3Ry
dWN0IG1zZyB0byB6ZXJvLiBUaGVuIG11bHRpcGxlIG1iaWdlbiBwaW5zIHdpdGggemVybyBldmVu
dGlkDQp3aWxsIHJlcG9ydCB0aGUgc2FtZSBpbnRlcnJ1cHQgbnVtYmVyLg0KDQpUaGUgZXZlbnRp
ZCBjbGVhciBjYWxsIHRyYWNlOg0KICAgICAgICAgICAgICAgIGZyZWVfaXJxDQogICAgICAgICAg
ICAgICAgX19mcmVlX2lycQ0KICAgICAgICAgICAgICAgIGlycV9zaHV0ZG93bg0KICAgICAgICAg
ICAgICAgIGlycV9kb21haW5fZGVhY3RpdmF0ZV9pcnENCiAgICAgICAgICAgICAgICBfX2lycV9k
b21haW5fZGVhY3RpdmF0ZV9pcnENCiAgICAgICAgICAgICAgICBfX2lycV9kb21haW5fZGVhY3Rp
dmF0ZV9pcnENCiAgICAgICAgICAgICAgICBtc2lfZG9tYWluX2RlYWN0aXZhdGUNCiAgICAgICAg
ICAgICAgICBwbGF0Zm9ybV9tc2lfd3JpdGVfbXNnDQogICAgICAgICAgICAgICAgbWJpZ2VuX3dy
aXRlX21zZw0KDQpTaWduZWQtb2ZmLWJ5OiBKaWFuZ3VvIENoZW4gPGNoZW5qaWFuZ3VvM0BodWF3
ZWkuY29tPg0KLS0tDQogIGRyaXZlcnMvaXJxY2hpcC9pcnEtbWJpZ2VuLmMgfCAzICsrKw0KICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2ly
cWNoaXAvaXJxLW1iaWdlbi5jIGIvZHJpdmVycy9pcnFjaGlwL2lycS1tYmlnZW4uYw0KaW5kZXgg
NTY3YjI5Yy4uZmFkNzI5MSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtbWJpZ2Vu
LmMNCisrKyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtbWJpZ2VuLmMNCkBAIC0xNjEsNiArMTYxLDkg
QEAgc3RhdGljIHZvaWQgbWJpZ2VuX3dyaXRlX21zZyhzdHJ1Y3QgbXNpX2Rlc2MgKmRlc2MsDQpz
dHJ1Y3QgbXNpX21zZyAqbXNnKQ0KICAgICAgICB2b2lkIF9faW9tZW0gKmJhc2UgPSBkLT5jaGlw
X2RhdGE7DQogICAgICAgIHUzMiB2YWw7DQoNCisgICAgICAgaWYgKCFtc2ctPmFkZHJlc3NfbG8g
JiYgIW1zZy0+YWRkcmVzc19oaSkNCisgICAgICAgICAgICAgICByZXR1cm47DQorDQogICAgICAg
IGJhc2UgKz0gZ2V0X21iaWdlbl92ZWNfcmVnKGQtPmh3aXJxKTsNCiAgICAgICAgdmFsID0gcmVh
ZGxfcmVsYXhlZChiYXNlKTsNCg0KLS0NCjEuOC41LjYNCg0KDQouDQoNCg0K
