Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3982BC32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A8120665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfHNBUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 21:20:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3937 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726597AbfHNBUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 21:20:34 -0400
Received: from dggemi404-hub.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id D99AD20CFFE8B555D744;
        Wed, 14 Aug 2019 09:20:32 +0800 (CST)
Received: from DGGEMI524-MBX.china.huawei.com ([169.254.7.6]) by
 dggemi404-hub.china.huawei.com ([10.3.17.142]) with mapi id 14.03.0439.000;
 Wed, 14 Aug 2019 09:20:24 +0800
From:   chengzhihao <chengzhihao1@huawei.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
CC:     Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHViaWZzOiB1Ymlmc190bmNfc3RhcnRfY29tbWl0?=
 =?utf-8?B?OiBGaXggT09CIGluIGxheW91dF9pbl9nYXBz?=
Thread-Topic: [PATCH] ubifs: ubifs_tnc_start_commit: Fix OOB in
 layout_in_gaps
Thread-Index: AQHVPsBTBWetoNcJ1UaytZ+21M4VxabhWCiAgAETrKCAFtDaAIAAv90Q
Date:   Wed, 14 Aug 2019 01:20:23 +0000
Message-ID: <0B80F9D4116B2F4484E7279D5A66984F7BD738@dggemi524-mbx.china.huawei.com>
References: <1563602720-113903-1-git-send-email-chengzhihao1@huawei.com>
 <CAFLxGvxEAGtQDFm4G3orY+M9yuthDA4j0+u=HbE9DKuo7H8WCg@mail.gmail.com>
 <0B80F9D4116B2F4484E7279D5A66984F7A7472@dggemi524-mbx.china.huawei.com>
 <CAFLxGvz__aw+BnfmGS3XXGqT6n6q-9miLPoVcL9KuvaZ2QbVUQ@mail.gmail.com>
In-Reply-To: <CAFLxGvz__aw+BnfmGS3XXGqT6n6q-9miLPoVcL9KuvaZ2QbVUQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.224.82]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3VyZSwgSSdsbCBkbyBtb3JlIHRlc3RzIG9uIGRpZmZlcmVudCBtYWNoaW5lcyB0byBjaGVjayB0
aGUgYXNzZXJ0aW9uLiBJJ20gdHJ5aW5nIHRvIHVuZGVyc3RhbmQgd2hlbiB0aGlzIGFzc2VydGlv
biB3aWxsIGJlIHRyaWdnZXJlZC4gQWx0aG91Z2ggSSBoYXZlbid0IGZvdW5kIHRoaXMgYXNzZXJ0
aW9uIGJlIHRyaWdnZXJlZCBzbyBmYXIgaW4gc2V2ZXJhbCB0ZXN0cyBvbiB4ODZfNjQocWVtdSku
DQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogUmljaGFyZCBXZWluYmVyZ2Vy
IFttYWlsdG86cmljaGFyZC53ZWluYmVyZ2VyQGdtYWlsLmNvbV0gDQrlj5HpgIHml7bpl7Q6IDIw
MTnlubQ45pyIMTTml6UgNTo0NA0K5pS25Lu25Lq6OiBjaGVuZ3poaWhhbyA8Y2hlbmd6aGloYW8x
QGh1YXdlaS5jb20+DQrmioTpgIE6IFJpY2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+
OyBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBBcnRlbSBCaXR5dXRza2l5
IDxkZWRla2luZDFAZ21haWwuY29tPjsgemhhbmd5aSAoRikgPHlpLnpoYW5nQGh1YXdlaS5jb20+
OyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgTEtNTCA8bGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZz4NCuS4u+mimDogUmU6IFtQQVRDSF0gdWJpZnM6IHViaWZzX3RuY19zdGFydF9j
b21taXQ6IEZpeCBPT0IgaW4gbGF5b3V0X2luX2dhcHMNCg0KT24gVHVlLCBKdWwgMzAsIDIwMTkg
YXQgMzoyMSBBTSBjaGVuZ3poaWhhbyA8Y2hlbmd6aGloYW8xQGh1YXdlaS5jb20+IHdyb3RlOg0K
Pg0KPiBPSywgdGhhdCdzIGZpbmUsIGFuZCBJIHdpbGwgY29udGludWUgdG8gdW5kZXJzdGFuZCBt
b3JlIGltcGxlbWVudGF0aW9uIGNvZGUgcmVsYXRlZCB0byB0aGlzIHBhcnQuDQoNCkkgdGhpbmsg
d2UgY2FuIGdvIHdpdGggdGhlIHJlYWxsb2MoKSBhcHByb2FjaCBmb3Igbm93Lg0KQ2FuIHlvdSBw
bGVhc2UgY2hlY2sgd2hldGhlciB0aGUgYXNzZXJ0KCkgdHJpZ2dlcnM/DQoNCi0tIA0KVGhhbmtz
LA0KLy9yaWNoYXJkDQo=
