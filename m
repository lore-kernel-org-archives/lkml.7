Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDADC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 02:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326C5206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 02:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DE1IpPyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfKNCdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 21:33:45 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:10737 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726473AbfKNCdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 21:33:45 -0500
X-UUID: 273aaed76625470ebb4fee21e3be15fe-20191114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jdpcBWc7HBlDBSHQj9W7l/lAc9ZUoty9ehXTUgWCTGw=;
        b=DE1IpPyBL+mC1m1knTLKZFTpztGf8k13sLrkBIVTY6cyZX7Le3W/Huc0mCBlTe82eBmGGdmRI5p6xCcEzGIWGgk0rWP47CbEBZXXM86lDwTe2Kf1M/dQ7CGelnvi8/9ZPZkvSYG2hjOKWWyv05Lh/pAkHSveOOjHJTh2Q9HLqt0=;
X-UUID: 273aaed76625470ebb4fee21e3be15fe-20191114
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2040405152; Thu, 14 Nov 2019 10:33:30 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Nov 2019 10:33:21 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Nov 2019 10:33:20 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Tianping Fang <tianping.fang@mediatek.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [RFC PATCH] usb: mtu3: fix random remote wakeup
Date:   Thu, 14 Nov 2019 10:33:11 +0800
Message-ID: <1573698791-24310-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2075714ACED72CBB15C4DCA956E5D8B2E8C542FC8427F2F77C2C39642685507E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2FrZXVwX3NpZ25hbCB3aWxsIHRvZ2dsZSBzdGF0dXMgYWNjb3JkaW5nIHRvIHNzdXNiX2lwX3Ns
ZWVwIHNpZ25hbA0KYWZ0ZXIgZGVib3VuY2UgdGltZSwgc28gbmVlZCBhZGQgYSBkZWxheSB0aW1l
IGFuZCB3YWl0IGZvciB3YWtldXBfc2lnbmFsDQp0b2dnbGUgdG8gY29tcGxldGUsIHRoZW4gZW5h
YmxlIHRoZSByZW1vdGUgd2FrZXVwLiBNZWFud2hpbGUgcmVkdWNlIHRoZQ0KZGVib3VuY2UgdGlt
ZSBvZiB3YWtldXBfc2lnbmFsLiBUaGVzZSB3aWxsIGF2b2lkIHNwdXJpb3VzIHdha2V1cCBldmVu
dC4NCg0KU2lnbmVkLW9mZi1ieTogVGlhbnBpbmcgRmFuZyA8dGlhbnBpbmcuZmFuZ0BtZWRpYXRl
ay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRl
ay5jb20+DQotLS0NCk5vdGUsIGRlcGVuZHMgb24gZm9sbG93aW5nIHBhdGNoIG5vdCBtZXJnZWQ6
DQoNCiAgICBbdjMsMy83XSB1c2I6IG10dTM6IHN1cHBvcnQgaXAtc2xlZXAgd2FrZXVwIGZvciBN
VDgxODMNCiAgICBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMTIzMTUxLw0K
LS0tDQogZHJpdmVycy91c2IvbXR1My9tdHUzX2hvc3QuYyB8IDYgKysrKy0tDQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL210dTMvbXR1M19ob3N0LmMgYi9kcml2ZXJzL3VzYi9tdHUzL210dTNfaG9zdC5j
DQppbmRleCAxODJjOTQzOWMxNWEuLmNhNDhmZjc1MWM4YiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
dXNiL210dTMvbXR1M19ob3N0LmMNCisrKyBiL2RyaXZlcnMvdXNiL210dTMvbXR1M19ob3N0LmMN
CkBAIC01MywxMiArNTMsMTIgQEAgc3RhdGljIHZvaWQgc3N1c2Jfd2FrZXVwX2lwX3NsZWVwX3Nl
dChzdHJ1Y3Qgc3N1c2JfbXRrICpzc3VzYiwgYm9vbCBlbmFibGUpDQogCWNhc2UgU1NVU0JfVVdL
X1YwOg0KIAkJcmVnID0gc3N1c2ItPnV3a19yZWdfYmFzZSArIFBFUklfV0tfQ1RSTDA7DQogCQlt
c2sgPSAodTMyKShXQzBfSVNfRU4gfCBXQzBfSVNfQygweGYpIHwgV0MwX0lTX1ApOw0KLQkJdmFs
ID0gZW5hYmxlID8gKFdDMF9JU19FTiB8IFdDMF9JU19DKDB4OCkpIDogMDsNCisJCXZhbCA9IGVu
YWJsZSA/IChXQzBfSVNfRU4gfCBXQzBfSVNfQygweDMpKSA6IDA7DQogCQlicmVhazsNCiAJY2Fz
ZSBTU1VTQl9VV0tfVjE6DQogCQlyZWcgPSBzc3VzYi0+dXdrX3JlZ19iYXNlICsgUEVSSV9XS19D
VFJMMTsNCiAJCW1zayA9IFdDMV9JU19FTiB8IFdDMV9JU19DKDB4ZikgfCBXQzFfSVNfUDsNCi0J
CXZhbCA9IGVuYWJsZSA/IChXQzFfSVNfRU4gfCBXQzFfSVNfQygweDgpKSA6IDA7DQorCQl2YWwg
PSBlbmFibGUgPyAoV0MxX0lTX0VOIHwgV0MxX0lTX0MoMHgzKSkgOiAwOw0KIAkJYnJlYWs7DQog
CWNhc2UgU1NVU0JfVVdLX1YyOg0KIAkJcmVnID0gc3N1c2ItPnV3a19yZWdfYmFzZSArIFBFUklf
U1NVU0JfU1BNX0NUUkw7DQpAQCAtMTk3LDYgKzE5Nyw4IEBAIGludCBzc3VzYl9ob3N0X2Rpc2Fi
bGUoc3RydWN0IHNzdXNiX210ayAqc3N1c2IsIGJvb2wgc3VzcGVuZCkNCiAJCQkgICh2YWx1ZSAm
IFNTVVNCX0lQX1NMRUVQX1NUUyksIDEwMCwgMTAwMDAwKTsNCiAJaWYgKHJldCkNCiAJCWRldl9l
cnIoc3N1c2ItPmRldiwgImlwIHNsZWVwIGZhaWxlZCEhIVxuIik7DQorCWVsc2UgIC8qIHdhaXQg
Zm9yIHdha2V1cF9zaWduYWwgdG9nZ2xlIGRvbmUgYWZ0ZXIgZW50ZXIgaXAtc2xlZXAgKi8NCisJ
CXVzbGVlcF9yYW5nZSgyNDUsIDI1NSk7DQogDQogCXJldHVybiByZXQ7DQogfQ0KLS0gDQoyLjIz
LjANCg==

