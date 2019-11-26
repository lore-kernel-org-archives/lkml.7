Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C652C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 05:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F399620865
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 05:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oUMqUk1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfKZFlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 00:41:09 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56679 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726039AbfKZFlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 00:41:09 -0500
X-UUID: 3dcba66704f9401ba9dd57b42492fb32-20191126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/Cwe3UUHM0yQKskqUxgp26U5istqx5lpf6OcF0l5Nt8=;
        b=oUMqUk1CbXhtbQ8xdXoCymCW3asRGBE2VC6G4zNwkE4OiPsI/95/N51L7lb39/RHLqHEG/JAoW2vq20oRnVbfioNWDoaS4XwhlsoScqljbR8safWbRyA3HQ6qDa9ArTZsfN3373Pyrnn3lSJrUEFvU9uYRbI+VsDoK3yABuA8N8=;
X-UUID: 3dcba66704f9401ba9dd57b42492fb32-20191126
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <freddy.hsin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 448703711; Tue, 26 Nov 2019 13:41:05 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Nov 2019 13:40:59 +0800
Received: from mtkmbs07n1.mediatek.inc ([fe80::70f1:d3df:c909:49f2]) by
 mtkmbs07n1.mediatek.inc ([fe80::70f1:d3df:c909:49f2%18]) with mapi id
 15.00.1395.000; Tue, 26 Nov 2019 13:40:59 +0800
From:   =?utf-8?B?RnJlZGR5IEhzaW4gKOi+m+aBkuixkCk=?= 
        <Freddy.Hsin@mediatek.com>
To:     "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     =?utf-8?B?Q2hhbmctQW4gQ2hlbiAo6Zmz5pi25a6JKQ==?= 
        <Chang-An.Chen@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?utf-8?B?RnJlZGR5IEhzaW4gKOi+m+aBkuixkCk=?= 
        <Freddy.Hsin@mediatek.com>
Subject: [PATCH v1 0/4] add MTK reboot mode driver
Thread-Topic: [PATCH v1 0/4] add MTK reboot mode driver
Thread-Index: AQHVpBqy2H5tN6/Y5EqFJBpWedHPR6ec8M2A
Date:   Tue, 26 Nov 2019 05:40:59 +0000
Message-ID: <bf2cac8e59584b9792e9134387a79fe0@mtkmbs07n1.mediatek.inc>
References: <1574746264-507-1-git-send-email-freddy.hsin@mediatek.com>
In-Reply-To: <1574746264-507-1-git-send-email-freddy.hsin@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrMTQ3NzJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1mMjhkOTdjYi0xMDBmLTExZWEtYjYxMC03MDIwODQwMTQ4MGNcYW1lLXRlc3RcZjI4ZDk3Y2QtMTAwZi0xMWVhLWI2MTAtNzAyMDg0MDE0ODBjYm9keS50eHQiIHN6PSIxMzk0IiB0PSIxMzIxOTIyMDcyNzg0Njg5OTEiIGg9IndReWk5OHEyVzRITkNlQS8zSVlXdGZMcFVRND0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: =?utf-8?B?5IyA5r2s5pWz5LWJ5p2z5pWT542z5r2p5IGuNA==?=
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.21.101.239]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBkcml2ZXIgcGFyc2VzIHRoZSByZWJvb3QgY29tbWFuZHMgbGlrZSAicmVib290IGJvb3Rs
b2FkZXIiDQogYW5kICJyZWJvb3QgcmVjb3ZlcnkiIHRvIGdldCBhIGJvb3QgbW9kZSBkZXNjcmli
ZWQgaW4gdGhlICBkZXZpY2UgdHJlZSAsIHRoZW4gY2FsbCB0aGUgd3JpdGUgaW50ZXJmYWUgdG8g
c3RvcmUgdGhlIGJvb3QgIG1vZGUgaW4gbXRrIFJHVSAocmVzZXQgZ2VuZXJhdGlvbiB1bml0KSBu
b24tdm9sYXRpbGUgcmVnaXN0ZXIsICB3aGljaCBjYW4gYmUgcmVhZCBieSB0aGUgYm9vdGxvYWRl
ciBhZnRlciBzeXN0ZW0gcmVib290LCB0aGVuICB0aGUgYm9vdGxvYWRlciBjYW4gdGFrZSBkaWZm
ZXJlbnQgYWN0aW9uIGFjY29yZGluZyB0byB0aGUgbW9kZSAgc3RvcmVkLg0KIA0KIEZyZWRkeSBI
c2luICg0KToNCiAgcG93ZXI6IHJlc2V0OiBhZGQgcmVib290IG1vZGUgZHJpdmVyDQogIHdhdGNo
ZG9nOiBwb3B1bGF0ZSByZWJvb3QgbW9kZSBub2RlIGluIHRvcHJndSBub2RlIG9mIE1USyBSR1Ug
KFJlc2V0DQogICAgR2VuZXJhdGlvbiBVbml0KQ0KICBzb2M6IG1lZGlhdGVrOiBhZGQgcmVib290
LW1vZGUgaGVhZGVyDQogIGR0LWJpbmRpbmc6IHBvd2VyOiByZXNldDogQWRkIGRvY3VtZW50YXRp
b24gZm9yIE1USyBSR1UgKFJlc2V0DQogICAgR2VybmF0aW9uIFVuaXQpIHJlYm9vdCBkcml2ZXIN
Cg0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3Jlc2V0L210ay1yZWJvb3QudHh0IHwg
ICAzMCArKysrKw0KIGRyaXZlcnMvcG93ZXIvcmVzZXQvS2NvbmZpZyAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAxMSArKw0KIGRyaXZlcnMvcG93ZXIvcmVzZXQvTWFrZWZpbGUgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAgMSArDQogZHJpdmVycy9wb3dlci9yZXNldC9tdGstcmVib290LmMg
ICAgICAgICAgICAgICAgICAgfCAgMTE2ICsrKysrKysrKysrKysrKysrKysrDQogZHJpdmVycy93
YXRjaGRvZy9tdGtfd2R0LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAzICsNCiBpbmNs
dWRlL2R0LWJpbmRpbmdzL3NvYy9tZWRpYXRlayxib290LW1vZGUuaCAgICAgICB8ICAgMTcgKysr
DQogNiBmaWxlcyBjaGFuZ2VkLCAxNzggaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0
NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvcmVzZXQvbXRrLXJlYm9v
dC50eHQNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wb3dlci9yZXNldC9tdGstcmVib290
LmMgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL3NvYy9tZWRpYXRlayxi
b290LW1vZGUuaA0K
