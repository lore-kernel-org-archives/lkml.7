Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A8AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 07:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5CD20835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 07:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393793AbfIWHk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 03:40:59 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:1255 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392971AbfIWHk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 03:40:59 -0400
Received: from P80254710 (unknown [121.12.147.249])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 8FAEE261B5E;
        Mon, 23 Sep 2019 15:40:55 +0800 (CST)
Date:   Mon, 23 Sep 2019 15:41:00 +0800
From:   "richard.peng@oppo.com" <richard.peng@oppo.com>
To:     mst <mst@redhat.com>, davem <davem@davemloft.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] vhost/vsock: Micro optimize error handle
X-Priority: 3
X-GUID: 69B50D16-4E09-4BBA-8580-AB33E91D02D2
X-Has-Attach: no
X-Mailer: Foxmail 7.2.10.151[cn]
Mime-Version: 1.0
Message-ID: <2019092315405925910511@oppo.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVk5VSEtKS0tKTk9DTE1MS0JZV1koWU
        FJSUtLSjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PC46Aww6NTkCHQ8QGUwaSCwO
        VhdPCh5VSlVKTk1CSUlPT05NSkNIVTMWGhIXVQkSGBMaCR9VCx4VHDsUCwsUVRgUFkVZV1kSC1lB
        WUpJSlVKSVVKT0xVSU9CWVdZCAFZQUlKTk83Bg++
X-HM-Tid: 0a6d5d10f6999375kuws8faee261b5e
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiBhIHZxIGVycm9yLCB0aGVyZSBpcyBubyBuZWVkIHRvIG9wZXJhdGUgb24gdGhlIHVubW9k
aWZpZWQgdnEuCgpTaWduZWQtb2ZmLWJ5OlBlbmcgSGFvIDxyaWNoYXJkLnBlbmdAb3Bwby5jb20+
Ci0tLQrCoGRyaXZlcnMvdmhvc3QvdnNvY2suYyB8IDYgKysrLS0tCsKgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Zo
b3N0L3Zzb2NrLmMgYi9kcml2ZXJzL3Zob3N0L3Zzb2NrLmMKaW5kZXggNmE1MGUxZC4uMGJlZDE5
ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy92aG9zdC92c29jay5jCisrKyBiL2RyaXZlcnMvdmhvc3Qv
dnNvY2suYwpAQCAtNDM3LDcgKzQzNyw3IEBAIHN0YXRpYyB2b2lkIHZob3N0X3Zzb2NrX2hhbmRs
ZV9yeF9raWNrKHN0cnVjdCB2aG9zdF93b3JrICp3b3JrKQrCoHN0YXRpYyBpbnQgdmhvc3RfdnNv
Y2tfc3RhcnQoc3RydWN0IHZob3N0X3Zzb2NrICp2c29jaykKwqB7CsKgCXN0cnVjdCB2aG9zdF92
aXJ0cXVldWUgKnZxOwotCXNpemVfdCBpOworCXNpemVfdCBpLCBqOwrCoAlpbnQgcmV0OwrCoArC
oAltdXRleF9sb2NrKCZ2c29jay0+ZGV2Lm11dGV4KTsKQEAgLTQ3Myw4ICs0NzMsOCBAQCBzdGF0
aWMgaW50IHZob3N0X3Zzb2NrX3N0YXJ0KHN0cnVjdCB2aG9zdF92c29jayAqdnNvY2spCsKgCXZx
LT5wcml2YXRlX2RhdGEgPSBOVUxMOwrCoAltdXRleF91bmxvY2soJnZxLT5tdXRleCk7CsKgCi0J
Zm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUodnNvY2stPnZxcyk7IGkrKykgewotCQl2cSA9ICZ2
c29jay0+dnFzW2ldOworCWZvciAoaiA9IDA7IGogPCBpOyBqKyspIHsKKwkJdnEgPSAmdnNvY2st
PnZxc1tqXTsKwqAKwqAJCW11dGV4X2xvY2soJnZxLT5tdXRleCk7CsKgCQl2cS0+cHJpdmF0ZV9k
YXRhID0gTlVMTDsKLS3CoAoyLjcuNA==

