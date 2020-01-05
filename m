Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0116AC3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4A4218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Mm9nNwvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgAEKqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 05:46:32 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:30299 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725897AbgAEKqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 05:46:31 -0500
X-UUID: 3bea9a535b7e4a3e9703a476143b1235-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lA5PzyXuyizUyRDDlXySD7ztXLzdwWD6WEfL0quguyU=;
        b=Mm9nNwvcdYTBoA0oIgEh/5DwLQGgeYYRRSdRxD50lHMY3FkH8/l5mKBMnksK+mTHCaENlYj4Zrsj1HONsJVPPnWQQCv7DbxpqTcRj3GuwRCfINawFm2qZ20mb7WftGqqvVR+0BQVLNgUTPWlFYiaPR0KvK2oiOEpnDK2Munbhx4=;
X-UUID: 3bea9a535b7e4a3e9703a476143b1235-20200105
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1689807649; Sun, 05 Jan 2020 18:46:25 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:00 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:44:56 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Jun Yan <jun.yan@mediatek.com>,
        Cui Zhang <zhang.cui@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Anan Sun <anan.sun@mediatek.com>
Subject: [PATCH v2 00/19] MT6779 IOMMU SUPPORT
Date:   Sun, 5 Jan 2020 18:45:04 +0800
Message-ID: <20200105104523.31006-1-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpUaGlzIHBhdGNoc2V0IGFkZHMgbXQ2Nzc5IGlvbW11IHN1cHBvcnQgYW5kIGFkanVzdHMgbXRr
IGlvbW11IHNvZnR3YXJlIGFyY2hpdGVjdHVyZSBtYWlubHkuDQoxLiBBZGQgbXQ2Nzc5IGJhc2lj
IGZ1bmN0aW9uLCBzdWNoIGFzIHNtaV9sYXJiIHBvcnQgZGVmaW5lLCByZWdpc3RlcnMgZGVmaW5l
IGFuZCBzbyBvbi4NCjIuIEluIGFkZGl0aW9uLCB0aGlzIHBhdGNoc2V0IHdpbGwgYWRqdXN0IGN1
cnJlbnQgbXRrIGlvbW11IFNXIGFyY2hpdGVjdHVyZSBtYWlubHkgdG8gYWRhcHQgYWxsIHRoZSBt
dGsgcGxhdGZvcm1zOg0KICAgRmlyc3RseSwgbXQ2Nzc5IGlvbW11IGNhbiBzdXBwb3J0IG1vcmUg
SFcgbW9kdWxlcywgYnV0IHNvbWUgbW9kdWxlcyBoYXZlIHNwZWNpYWwgcmVxdWlyZW1lbnRzIGZv
ciBpb3ZhIHJlZ2lvbiwNCiAgIGZvciBleGFtcGxlLCBDQ1Ugb25seSBjYW4gYWNjZXNzIDB4NDAw
MF8wMDAwfjB4NDdmZl9mZmZmLCBWUFUgb25seSBjYW4gYWNjZXNzIDB4N2RhMF8wMDAwfjB4N2Zi
Zl9mZmZmLiBDdXJyZW50DQogICBhcmNoaXRlY3R1cmUgb25seSBzdXBwb3J0IG9uZSBpb21tdSBk
b21haW4oaW5jbHVkZSAwfjRHQiksIGFsbCB0aGUgbW9kdWxlcyBhbGxvY2F0ZSBpb3ZhIGZyb20g
MH40R0IgcmVnaW9uLCBzbw0KICAgaXQgZG9lc24ndCBlbnN1cmUgdG8gYWxsb2NhdGUgZXhwZWN0
ZWQgaW92YSByZWdpb24gZm9yIHNwZWNpYWwgbW9kdWxlKENDVSBhbmQgVlBVKS4gSW4gb3JkZXIg
dG8gcmVzb2x2ZSB0aGUgcHJvYmxlbSwNCiAgIHdlIHdpbGwgY3JlYXRlIGRpZmZlcmVudCBpb21t
dSBkb21haW5zIGZvciBzcGVjaWFsIG1vZHVsZSwgYW5kIGV2ZXJ5IGRvbWFpbiBjYW4gaW5jbHVk
ZSBpb3ZhIHJlZ2lvbiB3aGljaCBtb2R1bGUgbmVlZHMuDQogICBTZWNvbmRseSwgYWxsIHRoZSBp
b21tdXMgc2hhcmUgb25lIHBhZ2UgdGFibGUgZm9yIGN1cnJlbnQgYXJjaGl0ZWN0dXJlIGJ5ICJt
dGtfaW9tbXVfZ2V0X200dV9kYXRhIiwgdG8gbWFrZSB0aGUNCiAgIGFyY2hpdGVjdHVyZSBsb29r
IGNsZWFybHksIHdlIHdpbGwgY3JlYXRlIGEgZ2xvYmFsIHBhZ2UgdGFibGUgZmlyc3RseShtdGtf
aW9tbXVfcGd0YWJsZSksIGFuZCBhbGwgdGhlIGlvbW11cyBjYW4NCiAgIHVzZSBpdC4gT25lIHBh
Z2UgdGFibGUgY2FuIGluY2x1ZGUgNEdCIGlvdmEgc3BhY2UsIHNvIG11bHRpcGxlIGlvbW11IGRv
bWFpbnMgYXJlIGNyZWF0ZWQgYmFzZWQgb24gdGhlIHNhbWUgcGFnZSB0YWJsZS4NCiAgIE5ldyBT
VyBhcmNoaXRlY3R1cmUgZGlhZ3JhbSBpcyBhcyBiZWxvdzoNCg0KICAgICAgICAgICAgICAgICAg
ICAgICAgIGlvbW11MCAgIGlvbW11MQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
ICAgIHwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLS0tLS0tLS0tDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8DQogICAgICAgICAgICAgICAgICAgICAgICBtdGtfaW9t
bXVfcGd0YWJsZQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KICAgICAgICAg
ICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgIHwNCiAgICAgIG10a19p
b21tdV9kb21haW4xICAgbXRrX2lvbW11X2RvbWFpbjIgICBtdGtfaW9tbXVfZG9tYWluMw0KICAg
ICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICB8DQogICAg
ICAgaW9tbXVfZ3JvdXAxICAgICAgICAgaW9tbXVfZ3JvdXAyICAgICAgICBpb21tdV9ncm91cDMN
CiAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgfA0K
ICAgICAgIGlvbW11X2RvbWFpbjEgICAgICAgaW9tbXVfZG9tYWluMiAgICAgICAgaW9tbXVfZG9t
YWluMw0KICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAg
ICB8DQogICAgIGlvdmEgcmVnaW9uMShub3JtYWwpICBpb3ZhIHJlZ2lvbjIoQ0NVKSAgIGlvdmEg
cmVnaW9uMyhWUFUpDQoNCmNoYW5nZSBub3RlczoNCiB2MjoNCiAgMS4gUmViYXNlIG9uIHY1LjUt
cmMxLg0KICAyLiBEZWxldGUgTTRVX1BPUlRfVU5LTk9XTiBkZWZpbmUgYmVjYXVzZSBvZiBub3Qg
dXNlIGl0Lg0KICAzLiBDb3JyZWN0IGNvZGluZyBmb3JtYXQuDQogIDQuIFJlbmFtZSBvZmZzZXQ9
MHg0OCByZWdpc3Rlci4NCiAgNS4gU3BsaXQgImlvbW11L21lZGlhdGVrOiBBZGQgbXQ2Nzc5IElP
TU1VIGJhc2ljIHN1cHBvcnQocGF0Y2ggdjEpIiB0byBzZXZlcmFsIHBhdGNoZXMocGF0Y2ggdjIp
Lg0KDQogdjE6DQogIGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1t
ZWRpYXRlay8yMDE5LU5vdmVtYmVyLzAyNDU2Ny5odG1sDQoNCg0KIENoYW8gSGFvICgxOSk6DQog
ICBkdC1iaW5kaW5nczogbWVkaWF0ZWs6IEFkZCBiaW5kaW5ncyBmb3IgTVQ2Nzc5DQogICBpb21t
dS9tZWRpYXRlazogQWRkIG00dTFfbWFzayB0byBkaXN0aW5ndWlzaCBtNHVfaWQNCiAgIGlvbW11
L21lZGlhdGVrOiBFeHRlbmQgbGFyYl9yZW1hcCB0byBsYXJiX3JlbWFwWzJdDQogICBpb21tdS9t
ZWRpYXRlazogUmVuYW1lIG9mZnNldD0weDQ4IHJlZ2lzdGVyDQogICBpb21tdS9tZWRpYXRlazog
UHV0IGludl9zZWxfcmVnIGluIHRoZSBwbGF0X2RhdGEgZm9yIHByZXBhcmluZyBhZGQNCiAgICAg
ICAgICAgICAgICAgICAweDJjIHN1cHBvcnQgaW4gbXQ2Nzc5DQogICBpb21tdS9tZWRpYXRlazog
QWRkIG5ldyBmbG93IHRvIGdldCBTVUJfQ09NTU9OIElEIGluIHRyYW5zbGF0aW9uIGZhdWx0DQog
ICBpb21tdS9tZWRpYXRlazogQWRkIFJFR19NTVVfV1JfTEVOIHJlZyBkZWZpbmUgcHJlcGFyZSBm
b3IgbXQ2Nzc5DQogICBpb21tdS9tZWRpYXRlazogQWRkIG10Njc3OSBiYXNpYyBzdXBwb3J0DQog
ICBpb21tdS9tZWRpYXRlazogQWRkIG10a19pb21tdV9wZ3RhYmxlIHN0cnVjdHVyZQ0KICAgaW9t
bXUvbWVkaWF0ZWs6IFJlbW92ZSBtdGtfaW9tbXVfZG9tYWluX2ZpbmFsaXNlDQogICBpb21tdS9t
ZWRpYXRlazogUmVtb3ZlIHBndGFibGUgaW5mbyBpbiBtdGtfaW9tbXVfZG9tYWluDQogICBpb21t
dS9tZWRpYXRlazogQ2hhbmdlIGdldCB0aGUgd2F5IG9mIG00dV9ncm91cA0KICAgaW9tbXUvbWVk
aWF0ZWs6IEFkZCBzbWlfbGFyYiBpbmZvIGFib3V0IGRldmljZQ0KICAgaW9tbXUvbWVkaWF0ZWs6
IEFkZCBtdGtfZG9tYWluX2RhdGEgc3RydWN0dXJlDQogICBpb21tdS9tZWRpYXRlazogUmVtb3Zl
IHRoZSB1c2FnZSBvZiBtNHVfZG9tIHZhcmlhYmxlDQogICBpb21tdS9tZWRpYXRlazogUmVtb3Zl
IG10a19pb21tdV9nZXRfbTR1X2RhdGEgYXBpDQogICBpb21tdS9tZWRpYXRlazogQWRkIGlvdmEg
cmVzZXJ2ZWQgZnVuY3Rpb24NCiAgIGlvbW11L21lZGlhdGVrOiBDaGFuZ2Ugc2luZ2xlIGRvbWFp
biB0byBtdWx0aXBsZSBkb21haW5zDQogICBpb21tdS9tZWRpYXRlazogQWRkIG11bHRpcGxlIG10
a19pb21tdV9kb21haW4gc3VwcG9ydCBmb3IgbXQ2Nzc5DQoNCiAgLi4uL2JpbmRpbmdzL2lvbW11
L21lZGlhdGVrLGlvbW11LnR4dCAgICAgICAgIHwgICAyICsNCiAgZHJpdmVycy9pb21tdS9tdGtf
aW9tbXUuYyAgICAgICAgICAgICAgICAgICAgIHwgNDkzICsrKysrKysrKysrKysrKy0tLQ0KICBk
cml2ZXJzL2lvbW11L210a19pb21tdS5oICAgICAgICAgICAgICAgICAgICAgfCAgNTAgKy0NCiAg
aW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQ2Nzc5LWxhcmItcG9ydC5oIHwgMjE1ICsrKysr
KysrDQogIDQgZmlsZXMgY2hhbmdlZCwgNjgzIGluc2VydGlvbnMoKyksIDc3IGRlbGV0aW9ucygt
KQ0KDQogLS0NCiAyLjE4LjANCg0K

