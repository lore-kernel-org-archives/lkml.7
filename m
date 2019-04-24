Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7915BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AD221773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfDXPfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:35:04 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2568 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731121AbfDXPfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:35:03 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 528527EAAA004929808A;
        Wed, 24 Apr 2019 23:34:57 +0800 (CST)
Received: from DGGEMM507-MBX.china.huawei.com ([169.254.1.118]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0415.000;
 Wed, 24 Apr 2019 23:34:54 +0800
From:   Nixiaoming <nixiaoming@huawei.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "chao.xie@marvell.com" <chao.xie@marvell.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "mojha@codeaurora.org" <mojha@codeaurora.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "soren.brinkmann@xilinx.com" <soren.brinkmann@xilinx.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] clk:mmp: clk-mix.c fix divide-by-zero
Thread-Topic: [PATCH v3 2/2] clk:mmp: clk-mix.c fix divide-by-zero
Thread-Index: AQHU5v/jsCMLKtXulUG+5bCCd/VhFqZJ/JKAgAGbAnA=
Date:   Wed, 24 Apr 2019 15:34:54 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12AB29F8A@dggemm507-mbx.china.huawei.com>
References: <1553954142-65515-1-git-send-email-nixiaoming@huawei.com>
 <155606042712.15276.6873845293187802041@swboyd.mtv.corp.google.com>
In-Reply-To: <155606042712.15276.6873845293187802041@swboyd.mtv.corp.google.com>
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

T24gV2VkLCBBcHIgMjQsIDIwMTkgYXQgNzowMCBBTSBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5l
bC5vcmc+IHdyb3RlOg0KPlF1b3Rpbmcgbml4aWFvbWluZyAoMjAxOS0wMy0zMCAwNjo1NTo0MikN
Cj4+IFRoZSBfZ2V0X2RpdigpIGZ1bmN0aW9uIGhhcyBhIGJyYW5jaCB3aXRoIGEgcmV0dXJuIHZh
bHVlIG9mIDANCj4+IEFkZCBhIGNoZWNrIG9uIHRoZSByZXR1cm4gdmFsdWUgb2YgX2dldF9kaXYo
KSB0byBhdm9pZCBkaXZpZGUtYnktemVybw0KPj4gDQo+DQo+QXJlIHlvdSBzZWVpbmcgdGhpcyBp
biBwcmFjdGljZT8gT3IganVzdCB0cnlpbmcgdG8gYXZvaWQgYSBkaXYtYnktemVybw0KPmNhc2Ug
dGhhdCB5b3UndmUgZm91bmQgZnJvbSBpbnNwZWN0aW9uPyANCj4NClRoaXMgcG90ZW50aWFsIGJ1
ZyBpcyBmb3VuZCBieSBjb2RlIGluc3BlY3Rpb24uDQpfZ2V0X2RpdigpIGlzIGRlZmluZWQgYXMg
YSBzdGF0aWMgZnVuY3Rpb24gd2hpY2ggaXMgb25seSByZWZlcmVkIHR3aWNlIA0KaW4gZHJpdmVy
cy9jbGsvbW1wL2Nsay1taXguYy4gSW4gYm90aCBjYXNlcyB0aGUgcmV0dXJuIHZhbHVlIG9mIF9n
ZXRfZGl2KCkNCiBpcyB1c2VkIGFzIGRpdmlkZXIgd2l0aG91dCBhbnkgY2hlY2suDQogSWYgX2dl
dF9kaXYoKSBuZXZlciByZXR1cm5zIDAsIHRoZW4gdGhlIGJyYW5jaCByZXR1cm5pbmcgMCBpcyBk
ZWFkIGNvZGUsDQpvciB0aGUgcmV0dXJuIHZhbHVlIHNob3VsZCBiZSBjaGVjayB0byBhdm9pZCBk
aXZpZGluZyBieSB6ZXJvIGVycm9yLiANCg0KdGhhbmtzDQoNCj4+IFNpZ25lZC1vZmYtYnk6IG5p
eGlhb21pbmcgPG5peGlhb21pbmdAaHVhd2VpLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBNdWtlc2gg
T2poYSA8bW9qaGFAY29kZWF1cm9yYS5vcmc+DQo+DQo=
