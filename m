Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ED5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F86324653
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YPjk6VtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLJGrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 01:47:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:11717 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727177AbfLJGrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 01:47:20 -0500
X-UUID: b7ca566db4f24045947646012bbe6a5d-20191210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=c+JQZu06rnps/PbFJByt62MWheUf4sOHuIAnwN3BMkM=;
        b=YPjk6VtJrl8cDG5r3PFAAuYJTRhuGHzoI5atvdK0uCAMQZkpmI1y/0laWaemnzfs+HJwFNkhheNUDTnNFOjca9Y3x+ZYC04r5OYUPsrYdLW4+iE4kGGYAjVHw+Y0WrF38UBdmQRvH+tTPATr5hfG68JIN+RR6mmQkJlAPlq77Io=;
X-UUID: b7ca566db4f24045947646012bbe6a5d-20191210
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1044536345; Tue, 10 Dec 2019 14:47:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Dec 2019 14:46:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Dec 2019 14:47:16 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v9 0/9] Mediatek MT8183 scpsys support
Date:   Tue, 10 Dec 2019 14:46:44 +0800
Message-ID: <1575960413-6900-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gdjUuNS1yYzENCg0KY2hhbmdlcyBzaW5jZSB2NzoNCi0g
cmV3b3JkIGluIGJpbmRpbmcgZG9jdW1lbnQgW1BBVENIIDAyLzE0XQ0KLSBmaXggZXJyb3IgcmV0
dXJuIGNoZWNraW5nIGJ1ZyBpbiBzdWJzeXMgY2xvY2sgY29udHJvbCBbUEFUQ0ggMTAvMTRdDQot
IGFkZCBwb3dlciBkb21haW5zIHByb3Blcml0eSB0byBtZmdjZmcgcGF0Y2ggW1BBVENIIDE0LzE0
XSBmcm9tDQogIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTExMjYxOTkvDQoN
CmNoYW5nZXMgc2luY2UgdjY6DQotIHJlbW92ZSB0aGUgcGF0Y2ggb2YgU1BEWCBsaWNlbnNlIGlk
ZW50aWZpZXIgYmVjYXVzZSBpdCdzIGFscmVhZHkgZml4ZWQNCg0KY2hhbmdlcyBzaW5jZSB2NToN
Ci0gZml4IGRvY3VtZW50YXRpb24gaW4gW1BBVENIIDA0LzE0XQ0KLSByZW1vdmUgdXNlbGVzcyB2
YXJpYWJsZSBjaGVja2luZyBhbmQgcmV1c2UgQVBJIG9mIGNsb2NrIGNvbnRyb2wgaW4gW1BBVENI
IDA2LzE0XQ0KLSBjb2Rpbmcgc3R5bGUgZml4IG9mIGJ1cyBwcm90ZWN0aW9uIGNvbnRyb2wgaW4g
W1BBVENIIDA4LzE0XQ0KLSBmaXggbmFtaW5nIG9mIG5ldyBhZGRlZCBkYXRhIGluIFtQQVRDSCAw
OS8xNF0NCi0gc21hbGwgcmVmYWN0b3Igb2YgbXVsdGlwbGUgc3RlcCBidXMgcHJvdGVjdGlvbiBj
b250cm9sIGluIFtQQVRDSCAxMC8xNF0NCg0KY2hhbmdlcyBzaW5jZSB2NDoNCi0gYWRkIHByb3Bl
cnR5IHRvIG10ODE4MyBzbWktY29tbW9uDQotIHNlcGVyYXRlIHJlZmFjdG9yIHBhdGNoZXMgYW5k
IG5ldyBhZGQgZnVuY3Rpb24NCi0gYWRkIHBvd2VyIGNvbnRyb2xsZXIgZGV2aWNlIG5vZGUNCg0K
V2VpeWkgTHUgKDkpOg0KICBkdC1iaW5kaW5nczogbWVkaWF0ZWs6IEFkZCBwcm9wZXJ0eSB0byBt
dDgxODMgc21pLWNvbW1vbg0KICBkdC1iaW5kaW5nczogc29jOiBBZGQgTVQ4MTgzIHBvd2VyIGR0
LWJpbmRpbmdzDQogIHNvYzogbWVkaWF0ZWs6IEFkZCBiYXNpY19jbGtfaWQgdG8gc2NwX3Bvd2Vy
X2RhdGENCiAgc29jOiBtZWRpYXRlazogQWRkIG11bHRpcGxlIHN0ZXAgYnVzIHByb3RlY3Rpb24g
Y29udHJvbA0KICBzb2M6IG1lZGlhdGVrOiBBZGQgc3Vic3lzIGNsb2NrIGNvbnRyb2wgZm9yIGJ1
cyBwcm90ZWN0aW9uDQogIHNvYzogbWVkaWF0ZWs6IEFkZCBleHRyYSBzcmFtIGNvbnRyb2wNCiAg
c29jOiBtZWRpYXRlazogQWRkIE1UODE4MyBzY3BzeXMgc3VwcG9ydA0KICBhcm02NDogZHRzOiBB
ZGQgcG93ZXIgY29udHJvbGxlciBkZXZpY2Ugbm9kZSBvZiBNVDgxODMNCiAgYXJtNjQ6IGR0czog
QWRkIHBvd2VyLWRvbWFpbnMgcHJvcGVyaXR5IHRvIG1mZ2NmZw0KDQogLi4uL21lbW9yeS1jb250
cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnR4dCAgICAgfCAgIDIgKy0NCiAuLi4vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dCAgICB8ICAyMCArLQ0KIGFyY2gv
YXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgICAgICAgICAgIHwgIDYzICsrKysN
CiBkcml2ZXJzL3NvYy9tZWRpYXRlay9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICB8ICAg
MiArLQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMtZXh0LmMgICAgICAgICAgICAg
IHwgIDk5ICsrKysrKw0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMuYyAgICAgICAg
ICAgICAgICAgIHwgMzg5ICsrKysrKysrKysrKysrKysrKystLQ0KIGluY2x1ZGUvZHQtYmluZGlu
Z3MvcG93ZXIvbXQ4MTgzLXBvd2VyLmggICAgICAgICAgIHwgIDI2ICsrDQogaW5jbHVkZS9saW51
eC9zb2MvbWVkaWF0ZWsvc2Nwc3lzLWV4dC5oICAgICAgICAgICAgfCAgMzkgKysrDQogOCBmaWxl
cyBjaGFuZ2VkLCA2MTQgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMtZXh0LmMNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDgxODMtcG93ZXIuaA0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9zY3BzeXMtZXh0LmgN
Cg==

