Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0DCC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 13:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C782183F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 13:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbfC3Nkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 09:40:46 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:51280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730831AbfC3Nkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 09:40:46 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id DAF708276B325FDA99FB;
        Sat, 30 Mar 2019 21:40:42 +0800 (CST)
Received: from DGGEMM527-MBS.china.huawei.com ([169.254.5.15]) by
 DGGEMM406-HUB.china.huawei.com ([10.3.20.214]) with mapi id 14.03.0415.000;
 Sat, 30 Mar 2019 21:40:39 +0800
From:   Nixiaoming <nixiaoming@huawei.com>
To:     Mukesh Ojha <mojha@codeaurora.org>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "soren.brinkmann@xilinx.com" <soren.brinkmann@xilinx.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] clk:Fix divide-by-zero in
 divider_ro_round_rate_parent
Thread-Topic: [PATCH v2 1/2] clk:Fix divide-by-zero in
 divider_ro_round_rate_parent
Thread-Index: AQHU5qBJh9LbArp11Eqpo8yyxj7a96YjZuMAgADHXeA=
Date:   Sat, 30 Mar 2019 13:40:38 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12AAC8ED0@DGGEMM527-MBS.china.huawei.com>
References: <1553913085-51237-1-git-send-email-nixiaoming@huawei.com>
 <fcbcceb2-e59b-465a-ec36-cde354425898@codeaurora.org>
In-Reply-To: <fcbcceb2-e59b-465a-ec36-cde354425898@codeaurora.org>
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

T24gMy8zMC8yMDE5IDU6NDQgUE0sIE11a2VzaCBPamhhIHdyb3RlOg0KPk9uIDMvMzAvMjAxOSA4
OjAxIEFNLCBuaXhpYW9taW5nIHdyb3RlOg0KPj4gSW4gdGhlIGZ1bmN0aW9uIGRpdmlkZXJfcmVj
YWxjX3JhdGUoKSBUaGUganVkZ21lbnQgb2YgdGhlIHJldHVybiB2YWx1ZSBvZg0KPj4gX2dldF9k
aXYoKSBpbmRpY2F0ZXMgdGhhdCB0aGUgcmV0dXJuIHZhbHVlIG9mIF9nZXRfZGl2KCkgbWF5IGJl
IDAuDQo+DQo+cy9tYXkgYmUvY2FuIGJlDQoNClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50cy4N
Ckkgd2lsbCBmaXggaXQgaW4gYSBsYXRlciBwYXRjaC4NCj4NCj4+IEluIG9yZGVyIHRvIGF2b2lk
IHRoZSBkaXZpZGUtYnktemVybyBlcnJvciwgYWRkIGNoZWNrIHRoZSByZXR1cm4gdmFsdWVzLg0K
PnMvYWRkIGNoZWNrIHRoZS9hZGQgY2hlY2sgZm9yDQo+DQpUaGFuayB5b3UgZm9yIHlvdXIgY29t
bWVudHMuDQpJIHdpbGwgZml4IGl0IGluIGEgbGF0ZXIgcGF0Y2guDQoNCj4+IG9mIF9nZXRfZGl2
KCkgaW4gdGhlIGRpdmlkZXJfcm9fcm91bmRfcmF0ZV9wYXJlbnQoKQ0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IG5peGlhb21pbmcgPG5peGlhb21pbmdAaHVhd2VpLmNvbT4NCj4NCj4NCj5QbGVhc2Ug
Zml4IHRoZSBjb21taXQgdGV4dC4NCj5SZXZpZXdlZC1ieTogTXVrZXNoIE9qaGEgPG1vamhhQGNv
ZGVhdXJvcmEub3JnPg0KPg0KPkNoZWVycywNCj4tTXVrZXNoDQo+DQoNClRoYW5rcw0K
