Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEF9C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF9A24680
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bkWDs9UW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfLTDqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 22:46:14 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:9887 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727024AbfLTDqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 22:46:14 -0500
X-UUID: 925a2fa3e08b46a4946ed4428cad106a-20191220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=NSTNC8ojUfDT+QqUlxsgN+IId/aGcya1wEt805+6O/I=;
        b=bkWDs9UW1V6u8bCL1WZb70OcQbBfwDqUrE644JP4qAIup1UWdfL0IVgEa8y5N3VDDBK+1CRqnExetk5PLTpQOZ4qvNWkcULBdVoa7G5/rJzsYHcvnGIe3glDRgfAfNfncyYabuwg7uYA4lYpfO4YZyNC8Txlh+GVCF1Tb+Q7cHI=;
X-UUID: 925a2fa3e08b46a4946ed4428cad106a-20191220
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 778479085; Fri, 20 Dec 2019 11:46:09 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 20 Dec 2019 11:45:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 20 Dec 2019 11:46:06 +0800
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
Subject: [PATCH v11 00/10] Mediatek MT8183 scpsys support
Date:   Fri, 20 Dec 2019 11:45:54 +0800
Message-ID: <1576813564-23927-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C84FC9C5B614AE4979CECEE3C56478ADD57E74CC0E01985DD669D5AB984E61F02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gdjUuNS1yYzENCg0KY2hhbmdlcyBzaW5jZSB2MTA6DQot
IHNxdWFzaCBQQVRDSCAwNCBhbmQgUEFUQ0ggMDYgaW4gdjkgaW50byBpdHMgcHJldmlvdXMgcGF0
Y2gNCi0gYWRkICJpZ25vcmVfY2xyX2FjayIgZm9yIG11bHRpcGxlIHN0ZXAgYnVzIHByb3RlY3Rp
b24gY29udHJvbCB0byBoYXZlIGEgY2xlYW4gZGVmaW5pdGlvbiBvZiBwb3dlciBkb21haW4gZGF0
YQ0KLSBrZWVwIHRoZSBtYXNrIHJlZ2lzdGVyIGJpdCBkZWZpbml0aW9ucyBhbmQgZG8gdGhlIHNh
bWUgZm9yIE1UODE4Mw0KDQpjaGFuZ2VzIHNpbmNlIHY5Og0KLSBhZGQgbmV3IFBBVENIIDA0IGFu
ZCBQQVRDSCAwNiB0byByZXBsYWNlIGJ5IG5ldyBtZXRob2QgZm9yIGFsbCBjb21wYXRpYmxlcw0K
LSBhZGQgbmV3IFBBVENIIDA3IHRvIHJlbW92ZSBpbmZyYWNmZyBtaXNjIGRyaXZlcg0KLSBtaW5v
ciBjb2Rpbmcgc3l0bGUgZml4DQoNCmNoYW5nZXMgc2luY2Ugdjc6DQotIHJld29yZCBpbiBiaW5k
aW5nIGRvY3VtZW50IFtQQVRDSCAwMi8xNF0NCi0gZml4IGVycm9yIHJldHVybiBjaGVja2luZyBi
dWcgaW4gc3Vic3lzIGNsb2NrIGNvbnRyb2wgW1BBVENIIDEwLzE0XQ0KLSBhZGQgcG93ZXIgZG9t
YWlucyBwcm9wZXJpdHkgdG8gbWZnY2ZnIHBhdGNoIFtQQVRDSCAxNC8xNF0gZnJvbQ0KICBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMTI2MTk5Lw0KDQpjaGFuZ2VzIHNpbmNl
IHY2Og0KLSByZW1vdmUgdGhlIHBhdGNoIG9mIFNQRFggbGljZW5zZSBpZGVudGlmaWVyIGJlY2F1
c2UgaXQncyBhbHJlYWR5IGZpeGVkDQoNCmNoYW5nZXMgc2luY2UgdjU6DQotIGZpeCBkb2N1bWVu
dGF0aW9uIGluIFtQQVRDSCAwNC8xNF0NCi0gcmVtb3ZlIHVzZWxlc3MgdmFyaWFibGUgY2hlY2tp
bmcgYW5kIHJldXNlIEFQSSBvZiBjbG9jayBjb250cm9sIGluIFtQQVRDSCAwNi8xNF0NCi0gY29k
aW5nIHN0eWxlIGZpeCBvZiBidXMgcHJvdGVjdGlvbiBjb250cm9sIGluIFtQQVRDSCAwOC8xNF0N
Ci0gZml4IG5hbWluZyBvZiBuZXcgYWRkZWQgZGF0YSBpbiBbUEFUQ0ggMDkvMTRdDQotIHNtYWxs
IHJlZmFjdG9yIG9mIG11bHRpcGxlIHN0ZXAgYnVzIHByb3RlY3Rpb24gY29udHJvbCBpbiBbUEFU
Q0ggMTAvMTRdDQoNCmNoYW5nZXMgc2luY2UgdjQ6DQotIGFkZCBwcm9wZXJ0eSB0byBtdDgxODMg
c21pLWNvbW1vbg0KLSBzZXBlcmF0ZSByZWZhY3RvciBwYXRjaGVzIGFuZCBuZXcgYWRkIGZ1bmN0
aW9uDQotIGFkZCBwb3dlciBjb250cm9sbGVyIGRldmljZSBub2RlDQoNCldlaXlpIEx1ICgxMCk6
DQogIGR0LWJpbmRpbmdzOiBtZWRpYXRlazogQWRkIHByb3BlcnR5IHRvIG10ODE4MyBzbWktY29t
bW9uDQogIGR0LWJpbmRpbmdzOiBzb2M6IEFkZCBNVDgxODMgcG93ZXIgZHQtYmluZGluZ3MNCiAg
c29jOiBtZWRpYXRlazogQWRkIGJhc2ljX2Nsa19uYW1lIHRvIHNjcF9wb3dlcl9kYXRhDQogIHNv
YzogbWVkaWF0ZWs6IEFkZCBtdWx0aXBsZSBzdGVwIGJ1cyBwcm90ZWN0aW9uIGNvbnRyb2wNCiAg
c29jOiBtZWRpYXRlazogUmVtb3ZlIGluZnJhY2ZnIG1pc2MgZHJpdmVyIHN1cHBvcnQNCiAgc29j
OiBtZWRpYXRlazogQWRkIHN1YnN5cyBjbG9jayBjb250cm9sIGZvciBidXMgcHJvdGVjdGlvbg0K
ICBzb2M6IG1lZGlhdGVrOiBBZGQgZXh0cmEgc3JhbSBjb250cm9sDQogIHNvYzogbWVkaWF0ZWs6
IEFkZCBNVDgxODMgc2Nwc3lzIHN1cHBvcnQNCiAgYXJtNjQ6IGR0czogQWRkIHBvd2VyIGNvbnRy
b2xsZXIgZGV2aWNlIG5vZGUgb2YgTVQ4MTgzDQogIGFybTY0OiBkdHM6IEFkZCBwb3dlci1kb21h
aW5zIHByb3Blcml0eSB0byBtZmdjZmcNCg0KIC4uLi9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0
ZWssc21pLWNvbW1vbi50eHQgICAgIHwgICAyICstDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
c29jL21lZGlhdGVrL3NjcHN5cy50eHQgICAgfCAgMjAgKy0NCiBhcmNoL2FybTY0L2Jvb3QvZHRz
L21lZGlhdGVrL210ODE4My5kdHNpICAgICAgICAgICB8ICA2MyArKysNCiBkcml2ZXJzL3NvYy9t
ZWRpYXRlay9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICB8ICAxMCAtDQogZHJpdmVycy9z
b2MvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKy0NCiBkcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstaW5mcmFjZmcuYyAgICAgICAgICAgICAgICB8ICA3OSAtLS0N
CiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLWV4dC5jICAgICAgICAgICAgICB8IDEw
MSArKysrDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy5jICAgICAgICAgICAgICAg
ICAgfCA1NzggKysrKysrKysrKysrKysrLS0tLS0tDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvc2Nw
c3lzLWV4dC5oICAgICAgICAgICAgICAgICAgfCAgOTUgKysrKw0KIGluY2x1ZGUvZHQtYmluZGlu
Z3MvcG93ZXIvbXQ4MTgzLXBvd2VyLmggICAgICAgICAgIHwgIDI2ICsNCiBpbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9pbmZyYWNmZy5oICAgICAgICAgICAgICB8ICAzOSAtLQ0KIDExIGZpbGVz
IGNoYW5nZWQsIDczNiBpbnNlcnRpb25zKCspLCAyODAgZGVsZXRpb25zKC0pDQogZGVsZXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1pbmZyYWNmZy5jDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMtZXh0LmMNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLWV4dC5oDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTgzLXBvd2VyLmgNCiBkZWxl
dGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcuaA0K

