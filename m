Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB48C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CC92071C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CDr6tLSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfKUJN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:13:57 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53690 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726573AbfKUJNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:13:35 -0500
X-UUID: 3d625471e6004124976e63e1f86407d1-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=z8Sy2iqPMC8IL+xRKywGw86kYgTHn2BKv7itrUQoNkg=;
        b=CDr6tLSa2hJdfSmn7f1DCFVa5cgOk1kD25q6DQlyQ+rO86xQGMELuZvhegPZ+x5QSmvffDWCa7NyCDdd8EyN6ySG1mQqykazNpdO6l8h6uKroU6rNo6pfs0yttSIA5fyrJilimcS5jdzyJtYRfpC/fUE/DcGnqfTsK0dhJqAtHE=;
X-UUID: 3d625471e6004124976e63e1f86407d1-20191121
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1230215225; Thu, 21 Nov 2019 17:13:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 17:13:05 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 17:13:29 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v1 04/12] mailbox: mediatek: cmdq: clear task in channel before shutdown
Date:   Thu, 21 Nov 2019 17:12:24 +0800
Message-ID: <1574327552-11806-5-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RG8gc3VjY2VzcyBjYWxsYmFjayBpbiBjaGFubmVsIHdoZW4gc2h1dGRvd24uIEZvciB0aG9zZSB0
YXNrIG5vdCBmaW5pc2gsDQpjYWxsYmFjayB3aXRoIGVycm9yIGNvZGUgdGh1cyBjbGllbnQgaGFz
IGNoYW5jZSB0byBjbGVhbnVwIG9yIHJlc2V0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMg
SHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5jIHwgICAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKw0K
IDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guYw0KaW5kZXggZmQ1MTliNi4uYzEyYTc2OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbWFp
bGJveC9tdGstY21kcS1tYWlsYm94LmMNCisrKyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1t
YWlsYm94LmMNCkBAIC00NTAsNiArNDUwLDMyIEBAIHN0YXRpYyBpbnQgY21kcV9tYm94X3N0YXJ0
dXAoc3RydWN0IG1ib3hfY2hhbiAqY2hhbikNCiANCiBzdGF0aWMgdm9pZCBjbWRxX21ib3hfc2h1
dGRvd24oc3RydWN0IG1ib3hfY2hhbiAqY2hhbikNCiB7DQorCXN0cnVjdCBjbWRxX3RocmVhZCAq
dGhyZWFkID0gKHN0cnVjdCBjbWRxX3RocmVhZCAqKWNoYW4tPmNvbl9wcml2Ow0KKwlzdHJ1Y3Qg
Y21kcSAqY21kcSA9IGRldl9nZXRfZHJ2ZGF0YShjaGFuLT5tYm94LT5kZXYpOw0KKwlzdHJ1Y3Qg
Y21kcV90YXNrICp0YXNrLCAqdG1wOw0KKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KKw0KKwlzcGlu
X2xvY2tfaXJxc2F2ZSgmdGhyZWFkLT5jaGFuLT5sb2NrLCBmbGFncyk7DQorCWlmIChsaXN0X2Vt
cHR5KCZ0aHJlYWQtPnRhc2tfYnVzeV9saXN0KSkNCisJCWdvdG8gZG9uZTsNCisNCisJV0FSTl9P
TihjbWRxX3RocmVhZF9zdXNwZW5kKGNtZHEsIHRocmVhZCkgPCAwKTsNCisNCisJLyogbWFrZSBz
dXJlIGV4ZWN1dGVkIHRhc2tzIGhhdmUgc3VjY2VzcyBjYWxsYmFjayAqLw0KKwljbWRxX3RocmVh
ZF9pcnFfaGFuZGxlcihjbWRxLCB0aHJlYWQpOw0KKwlpZiAobGlzdF9lbXB0eSgmdGhyZWFkLT50
YXNrX2J1c3lfbGlzdCkpDQorCQlnb3RvIGRvbmU7DQorDQorCWxpc3RfZm9yX2VhY2hfZW50cnlf
c2FmZSh0YXNrLCB0bXAsICZ0aHJlYWQtPnRhc2tfYnVzeV9saXN0LA0KKwkJCQkgbGlzdF9lbnRy
eSkgew0KKwkJY21kcV90YXNrX2V4ZWNfZG9uZSh0YXNrLCAtRUNPTk5BQk9SVEVEKTsNCisJCWtm
cmVlKHRhc2spOw0KKwl9DQorDQorCWNtZHFfdGhyZWFkX2Rpc2FibGUoY21kcSwgdGhyZWFkKTsN
CisJY2xrX2Rpc2FibGUoY21kcS0+Y2xvY2spOw0KK2RvbmU6DQorCXNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJnRocmVhZC0+Y2hhbi0+bG9jaywgZmxhZ3MpOw0KIH0NCiANCiBzdGF0aWMgY29uc3Qg
c3RydWN0IG1ib3hfY2hhbl9vcHMgY21kcV9tYm94X2NoYW5fb3BzID0gew0KLS0gDQoxLjcuOS41
DQo=

