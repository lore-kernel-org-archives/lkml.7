Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FEFC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D11A218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eSykp0f5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLRIbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:31:07 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:65506 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726545AbfLRIbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:31:04 -0500
X-UUID: a1ebee50a9734a45a6b25b5d560659a1-20191218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yBspQeq1i19eHRKjLjrxsBTdnmPay+POKrM4ighMVCs=;
        b=eSykp0f5Ifiy35AFTXFu81XbUdHwWNiQQUlR/udNnRP4CFKtLUIS3Fx6pX8hOJO2je+vGPqrF+5cZg6QCCpgLF6vY1eXTCSaEnuZ3w8WbEnLB2ctAoY+Mh0eDCujqECI9nAOc2vV13izRO1CNspPzpFZgwpPsYHjyXpu1AMunys=;
X-UUID: a1ebee50a9734a45a6b25b5d560659a1-20191218
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1247242172; Wed, 18 Dec 2019 16:30:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 18 Dec 2019 16:30:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 18 Dec 2019 16:30:28 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v10 00/12] Mediatek MT8183 scpsys support 
Date:   Wed, 18 Dec 2019 16:30:36 +0800
Message-ID: <1576657848-14711-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FC00DC92A68BF3A71890194469EE78B46795169719620892DA3AF4E9E07A85CC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gdjUuNS1yYzENCg0KY2hhbmdlcyBzaW5jZSB2OToNCi0g
YWRkIG5ldyBQQVRDSCAwNCBhbmQgUEFUQ0ggMDYgdG8gcmVwbGFjZSBieSBuZXcgbWV0aG9kIGZv
ciBhbGwgY29tcGF0aWJsZXMNCi0gYWRkIG5ldyBQQVRDSCAwNyB0byByZW1vdmUgaW5mcmFjZmcg
bWlzYyBkcml2ZXINCi0gbWlub3IgY29kaW5nIHN5dGxlIGZpeA0KDQpjaGFuZ2VzIHNpbmNlIHY3
Og0KLSByZXdvcmQgaW4gYmluZGluZyBkb2N1bWVudCBbUEFUQ0ggMDIvMTRdDQotIGZpeCBlcnJv
ciByZXR1cm4gY2hlY2tpbmcgYnVnIGluIHN1YnN5cyBjbG9jayBjb250cm9sIFtQQVRDSCAxMC8x
NF0NCi0gYWRkIHBvd2VyIGRvbWFpbnMgcHJvcGVyaXR5IHRvIG1mZ2NmZyBwYXRjaCBbUEFUQ0gg
MTQvMTRdIGZyb20NCiAgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTEyNjE5
OS8NCg0KY2hhbmdlcyBzaW5jZSB2NjoNCi0gcmVtb3ZlIHRoZSBwYXRjaCBvZiBTUERYIGxpY2Vu
c2UgaWRlbnRpZmllciBiZWNhdXNlIGl0J3MgYWxyZWFkeSBmaXhlZA0KDQpjaGFuZ2VzIHNpbmNl
IHY1Og0KLSBmaXggZG9jdW1lbnRhdGlvbiBpbiBbUEFUQ0ggMDQvMTRdDQotIHJlbW92ZSB1c2Vs
ZXNzIHZhcmlhYmxlIGNoZWNraW5nIGFuZCByZXVzZSBBUEkgb2YgY2xvY2sgY29udHJvbCBpbiBb
UEFUQ0ggMDYvMTRdDQotIGNvZGluZyBzdHlsZSBmaXggb2YgYnVzIHByb3RlY3Rpb24gY29udHJv
bCBpbiBbUEFUQ0ggMDgvMTRdDQotIGZpeCBuYW1pbmcgb2YgbmV3IGFkZGVkIGRhdGEgaW4gW1BB
VENIIDA5LzE0XQ0KLSBzbWFsbCByZWZhY3RvciBvZiBtdWx0aXBsZSBzdGVwIGJ1cyBwcm90ZWN0
aW9uIGNvbnRyb2wgaW4gW1BBVENIIDEwLzE0XQ0KDQpjaGFuZ2VzIHNpbmNlIHY0Og0KLSBhZGQg
cHJvcGVydHkgdG8gbXQ4MTgzIHNtaS1jb21tb24NCi0gc2VwZXJhdGUgcmVmYWN0b3IgcGF0Y2hl
cyBhbmQgbmV3IGFkZCBmdW5jdGlvbg0KLSBhZGQgcG93ZXIgY29udHJvbGxlciBkZXZpY2Ugbm9k
ZQ0KDQpXZWl5aSBMdSAoMTIpOg0KICBkdC1iaW5kaW5nczogbWVkaWF0ZWs6IEFkZCBwcm9wZXJ0
eSB0byBtdDgxODMgc21pLWNvbW1vbg0KICBkdC1iaW5kaW5nczogc29jOiBBZGQgTVQ4MTgzIHBv
d2VyIGR0LWJpbmRpbmdzDQogIHNvYzogbWVkaWF0ZWs6IEFkZCBiYXNpY19jbGtfbmFtZSB0byBz
Y3BfcG93ZXJfZGF0YQ0KICBzb2M6IG1lZGlhdGVrOiBVc2UgYmFzaWNfY2xrX25hbWUgZm9yIGFs
bCBjb21wYXRpYmxlcw0KICBzb2M6IG1lZGlhdGVrOiBBZGQgbXVsdGlwbGUgc3RlcCBidXMgcHJv
dGVjdGlvbiBjb250cm9sDQogIHNvYzogbWVkaWF0ZWs6IFVzZSBicF90YWJsZSBmb3IgYWxsIGNv
bXBhdGlibGVzDQogIHNvYzogbWVkaWF0ZWs6IFJlbW92ZSBpbmZyYWNmZyBtaXNjIGRyaXZlciBz
dXBwb3J0DQogIHNvYzogbWVkaWF0ZWs6IEFkZCBzdWJzeXMgY2xvY2sgY29udHJvbCBmb3IgYnVz
IHByb3RlY3Rpb24NCiAgc29jOiBtZWRpYXRlazogQWRkIGV4dHJhIHNyYW0gY29udHJvbA0KICBz
b2M6IG1lZGlhdGVrOiBBZGQgTVQ4MTgzIHNjcHN5cyBzdXBwb3J0DQogIGFybTY0OiBkdHM6IEFk
ZCBwb3dlciBjb250cm9sbGVyIGRldmljZSBub2RlIG9mIE1UODE4Mw0KICBhcm02NDogZHRzOiBB
ZGQgcG93ZXItZG9tYWlucyBwcm9wZXJpdHkgdG8gbWZnY2ZnDQoNCiAuLi4vbWVtb3J5LWNvbnRy
b2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24udHh0ICAgICB8ICAgMiArLQ0KIC4uLi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9zY3BzeXMudHh0ICAgIHwgIDIwICstDQogYXJjaC9h
cm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSAgICAgICAgICAgfCAgNjMgKysrDQog
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgfCAgMTAg
LQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgIHwg
ICAzICstDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWluZnJhY2ZnLmMgICAgICAgICAgICAg
ICAgfCAgNzkgLS0tDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy1leHQuYyAgICAg
ICAgICAgICAgfCAgOTkgKysrKw0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMuYyAg
ICAgICAgICAgICAgICAgIHwgNTc5ICsrKysrKysrKysrKysrKy0tLS0tLQ0KIGluY2x1ZGUvZHQt
YmluZGluZ3MvcG93ZXIvbXQ4MTgzLXBvd2VyLmggICAgICAgICAgIHwgIDI2ICsNCiBpbmNsdWRl
L2xpbnV4L3NvYy9tZWRpYXRlay9pbmZyYWNmZy5oICAgICAgICAgICAgICB8ICAzOSAtLQ0KIGlu
Y2x1ZGUvbGludXgvc29jL21lZGlhdGVrL3NjcHN5cy1leHQuaCAgICAgICAgICAgIHwgIDM5ICsr
DQogMTEgZmlsZXMgY2hhbmdlZCwgNjc5IGluc2VydGlvbnMoKyksIDI4MCBkZWxldGlvbnMoLSkN
CiBkZWxldGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWluZnJhY2ZnLmMN
CiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy1leHQu
Yw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210ODE4My1w
b3dlci5oDQogZGVsZXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL2lu
ZnJhY2ZnLmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsv
c2Nwc3lzLWV4dC5oDQo=

