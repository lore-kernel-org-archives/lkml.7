Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71825C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 05:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478852071A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 05:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mUai4RMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfKZFod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 00:44:33 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:20359 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727423AbfKZFoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 00:44:32 -0500
X-UUID: 39a5fa8415ec40e18a9478d8dfc6e471-20191126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=dzgpYbPw2GcTu9Qfw6bsKf6XkWGkxyq2v9iUBwMZS0U=;
        b=mUai4RMrQDA/b+4dsWmLhFXM3t6tyUtCQIOKfo+kHbco4uCOWb+9djT3EZrgkltSuCN9ZHe4V6kUHMeTNMyMS6uaetW/QgqqOcgHiV16VYAGdZ9JXMYXjK/BU/nTUzTJN7OKcYqZsqg+nZ0V6fXpwj8lfeP9/nmhD0VquD3TTTo=;
X-UUID: 39a5fa8415ec40e18a9478d8dfc6e471-20191126
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <freddy.hsin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1798794899; Tue, 26 Nov 2019 13:44:30 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Nov 2019 13:44:20 +0800
Received: from mtkmbs07n1.mediatek.inc ([fe80::70f1:d3df:c909:49f2]) by
 mtkmbs07n1.mediatek.inc ([fe80::70f1:d3df:c909:49f2%18]) with mapi id
 15.00.1395.000; Tue, 26 Nov 2019 13:44:25 +0800
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
Subject: [PATCH v1 0/4] resubmit: add MTK reboot mode driver
Thread-Topic: [PATCH v1 0/4] resubmit: add MTK reboot mode driver
Thread-Index: AdWkHS9lan6XAqwgS0CI9B13wKdxcQ==
Date:   Tue, 26 Nov 2019 05:44:25 +0000
Message-ID: <1e143163435b4be885c9ec2687b18758@mtkmbs07n1.mediatek.inc>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrMTQ3NzJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy02ZDE5MzA1My0xMDEwLTExZWEtYjYxMC03MDIwODQwMTQ4MGNcYW1lLXRlc3RcNmQxOTMwNTUtMTAxMC0xMWVhLWI2MTAtNzAyMDg0MDE0ODBjYm9keS50eHQiIHN6PSIxNDAzIiB0PSIxMzIxOTIyMDkzMzQyNjY0NjciIGg9IkpaMEN6Z2NvcFdmOHhzRjA2UzFuYWRVWEtMMD0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
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
ZXJlbnQgYWN0aW9uIGFjY29yZGluZyB0byB0aGUgbW9kZSAgc3RvcmVkLg0KDQogRnJlZGR5IEhz
aW4gKDQpOg0KICBwb3dlcjogcmVzZXQ6IGFkZCByZWJvb3QgbW9kZSBkcml2ZXINCiAgd2F0Y2hk
b2c6IHBvcHVsYXRlIHJlYm9vdCBtb2RlIG5vZGUgaW4gdG9wcmd1IG5vZGUgb2YgTVRLIFJHVSAo
UmVzZXQNCiAgICBHZW5lcmF0aW9uIFVuaXQpDQogIHNvYzogbWVkaWF0ZWs6IGFkZCByZWJvb3Qt
bW9kZSBoZWFkZXINCiAgZHQtYmluZGluZzogcG93ZXI6IHJlc2V0OiBBZGQgZG9jdW1lbnRhdGlv
biBmb3IgTVRLIFJHVSAoUmVzZXQNCiAgICBHZXJuYXRpb24gVW5pdCkgcmVib290IGRyaXZlcg0K
DQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvcmVzZXQvbXRrLXJlYm9vdC50eHQgfCAg
IDMwICsrKysrDQogZHJpdmVycy9wb3dlci9yZXNldC9LY29uZmlnICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDExICsrDQogZHJpdmVycy9wb3dlci9yZXNldC9NYWtlZmlsZSAgICAgICAgICAg
ICAgICAgICAgICAgfCAgICAxICsNCiBkcml2ZXJzL3Bvd2VyL3Jlc2V0L210ay1yZWJvb3QuYyAg
ICAgICAgICAgICAgICAgICB8ICAxMTYgKysrKysrKysrKysrKysrKysrKysNCiBkcml2ZXJzL3dh
dGNoZG9nL210a193ZHQuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDMgKw0KIGluY2x1
ZGUvZHQtYmluZGluZ3Mvc29jL21lZGlhdGVrLGJvb3QtbW9kZS5oICAgICAgIHwgICAxNyArKysN
CiA2IGZpbGVzIGNoYW5nZWQsIDE3OCBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9yZXNldC9tdGstcmVib290
LnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3Bvd2VyL3Jlc2V0L210ay1yZWJvb3Qu
YyAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3Mvc29jL21lZGlhdGVrLGJv
b3QtbW9kZS5oDQo=
