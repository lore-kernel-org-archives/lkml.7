Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD83C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 07:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FBA20700
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 07:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s4UJ2MyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfLPHBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 02:01:34 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:51523 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726664AbfLPHBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 02:01:32 -0500
X-UUID: 527d581f68cd4a88a4bb6cd18c86e93b-20191216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LBQmw8g/lBN+U5HmClQ11koWGJ9vlo2PzQAgKucOP1A=;
        b=s4UJ2MyAPd3GbNbJzWvbzdsreG14F0mZE3fmhBDGYV/EHY7ERSYt7QWUpSJCZ+L7cJo57veTbWR4Nxua3GWeYE9E503HmvmKrNzOEKHsveXBF1bhfVs6xghVtMsPRynjp1B18LHsJh0xf8AAUDSPIHbpKxb1kMBwD1SJK8wmfpo=;
X-UUID: 527d581f68cd4a88a4bb6cd18c86e93b-20191216
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2106935372; Mon, 16 Dec 2019 15:01:26 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 16 Dec
 2019 14:58:51 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Mon, 16 Dec 2019 15:01:03 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <sj.huang@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v2 2/2] pwm/mtk_disp: move the reg enable trigger in config
Date:   Mon, 16 Dec 2019 15:01:23 +0800
Message-ID: <20191216070123.114719-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191216070123.114719-1-jitao.shi@mediatek.com>
References: <20191216070123.114719-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 141E8398241799075EC85A7A7B45A1B57CF9BB987071516055CCF6A929DF7FAD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVtb3ZlIHRoZSByZWdpc3QgZW5hYmxlIHRyaWdnZXIgc2V0dGluZyBpbiBwcm9iZS4NCk1vdmUg
dGhlIHRyaWdnZXIgdG8gbXRrX2Rpc3BfcHdtX2NvbmZpZygpLg0KDQpTaWduZWQtb2ZmLWJ5OiBK
aXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3B3bS9wd20t
bXRrLWRpc3AuYyB8IDIwICsrKysrKystLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3B3
bS9wd20tbXRrLWRpc3AuYyBiL2RyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jDQppbmRleCBjN2Ix
NGFjYzkzMTYuLmMxYWFlNWI1NjkzYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcHdtL3B3bS1tdGst
ZGlzcC5jDQorKysgYi9kcml2ZXJzL3B3bS9wd20tbXRrLWRpc3AuYw0KQEAgLTEyMiw2ICsxMjIs
MTMgQEAgc3RhdGljIGludCBtdGtfZGlzcF9wd21fY29uZmlnKHN0cnVjdCBwd21fY2hpcCAqY2hp
cCwgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSwNCiAJCW10a19kaXNwX3B3bV91cGRhdGVfYml0cyht
ZHAsIG1kcC0+ZGF0YS0+Y29tbWl0LA0KIAkJCQkJIG1kcC0+ZGF0YS0+Y29tbWl0X21hc2ssDQog
CQkJCQkgMHgwKTsNCisJfSBlbHNlIHsNCisJCW10a19kaXNwX3B3bV91cGRhdGVfYml0cyhtZHAs
IG1kcC0+ZGF0YS0+YmxzX2RlYnVnLA0KKwkJCQkJIG1kcC0+ZGF0YS0+YmxzX2RlYnVnX21hc2ss
DQorCQkJCQkgbWRwLT5kYXRhLT5ibHNfZGVidWdfbWFzayk7DQorCQltdGtfZGlzcF9wd21fdXBk
YXRlX2JpdHMobWRwLCBtZHAtPmRhdGEtPmNvbjAsDQorCQkJCQkgbWRwLT5kYXRhLT5jb24wX3Nl
bCwNCisJCQkJCSBtZHAtPmRhdGEtPmNvbjBfc2VsKTsNCiAJfQ0KIA0KIAljbGtfZGlzYWJsZV91
bnByZXBhcmUobWRwLT5jbGtfbW0pOw0KQEAgLTIwNywxOSArMjE0LDYgQEAgc3RhdGljIGludCBt
dGtfZGlzcF9wd21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiANCiAJcGxh
dGZvcm1fc2V0X2RydmRhdGEocGRldiwgbWRwKTsNCiANCi0JLyoNCi0JICogRm9yIE1UMjcwMSwg
ZGlzYWJsZSBkb3VibGUgYnVmZmVyIGJlZm9yZSB3cml0aW5nIHJlZ2lzdGVyDQotCSAqIGFuZCBz
ZWxlY3QgbWFudWFsIG1vZGUgYW5kIHVzZSBQV01fUEVSSU9EL1BXTV9ISUdIX1dJRFRILg0KLQkg
Ki8NCi0JaWYgKCFtZHAtPmRhdGEtPmhhc19jb21taXQpIHsNCi0JCW10a19kaXNwX3B3bV91cGRh
dGVfYml0cyhtZHAsIG1kcC0+ZGF0YS0+YmxzX2RlYnVnLA0KLQkJCQkJIG1kcC0+ZGF0YS0+Ymxz
X2RlYnVnX21hc2ssDQotCQkJCQkgbWRwLT5kYXRhLT5ibHNfZGVidWdfbWFzayk7DQotCQltdGtf
ZGlzcF9wd21fdXBkYXRlX2JpdHMobWRwLCBtZHAtPmRhdGEtPmNvbjAsDQotCQkJCQkgbWRwLT5k
YXRhLT5jb24wX3NlbCwNCi0JCQkJCSBtZHAtPmRhdGEtPmNvbjBfc2VsKTsNCi0JfQ0KLQ0KIAly
ZXR1cm4gMDsNCiB9DQogDQotLSANCjIuMjEuMA0K

