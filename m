Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DBFC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF67A2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="C4Tw//dI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfFXEmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 00:42:08 -0400
Received: from m15-33.126.com ([220.181.15.33]:64582 "EHLO m15-33.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfFXEmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 00:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=fr3xf
        Wx23bz/Eqtr0uwAkowQvRgf1dRaxLibGwj+Yck=; b=C4Tw//dI66ALwU9ocLJ6P
        ImFz151v7k3ARwzL+gyhefbbWqI/hrAkkuc1NvC+L5PvcfSDBsTE0fGfv3Xu4zE4
        vdK4nfuzIJitCuY1R+NSPNVjNc3Iyi0b+d1o7Og078af1DY3lRAjrjYj7AHkfaC2
        EUVY1UCs+kGCo3Dbt5L9ak=
Received: from kernelpatch$126.com ( [222.90.31.26] ) by
 ajax-webmail-wmsvr33 (Coremail) ; Mon, 24 Jun 2019 12:41:18 +0800 (CST)
X-Originating-IP: [222.90.31.26]
Date:   Mon, 24 Jun 2019 12:41:18 +0800 (CST)
From:   "Tiezhu Yang" <kernelpatch@126.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, vgoyal@redhat.com
Subject: [PATCH v2 RESEND] kexec: fix warnig of crash_zero_bytes in crash.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20190614(cb3344cf) Copyright (c) 2002-2019 www.mailtech.cn 126com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <117ef0c6.3d30.16b87c9cfbf.Coremail.kernelpatch@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: IcqowAAnb_pvVBBdLWNGAA--.27613W
X-CM-SenderInfo: xnhu0vxosd3ubk6rjloofrz/1tbi7w-d9VpD68ubhAAAsu
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgc3BhcnNlIHdhcm5pbmc6CgphcmNoL3g4Ni9rZXJuZWwvY3Jhc2gu
Yzo1OToxNToKd2FybmluZzogc3ltYm9sICdjcmFzaF96ZXJvX2J5dGVzJyB3YXMgbm90IGRlY2xh
cmVkLiBTaG91bGQgaXQgYmUgc3RhdGljPwoKRmlyc3QsIG1ha2UgY3Jhc2hfemVyb19ieXRlcyBz
dGF0aWMuIEluIGFkZGl0aW9uLCBjcmFzaF96ZXJvX2J5dGVzCmlzIHVzZWQgd2hlbiBDT05GSUdf
S0VYRUNfRklMRSBpcyBzZXQsIHNvIG1ha2UgaXQgb25seSBhdmFpbGFibGUKdW5kZXIgQ09ORklH
X0tFWEVDX0ZJTEUuIE90aGVyd2lzZSwgaWYgQ09ORklHX0tFWEVDX0ZJTEUgaXMgbm90IHNldCwK
dGhlIGZvbGxvd2luZyB3YXJuaW5nIHdpbGwgYXBwZWFyIHdoZW4gbWFrZSBjcmFzaF96ZXJvX2J5
dGVzIHN0YXRpYzoKCmFyY2gveDg2L2tlcm5lbC9jcmFzaC5jOjU5OjIyOgp3YXJuaW5nOiChrmNy
YXNoX3plcm9fYnl0ZXOhryBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtdmFyaWFibGVd
CgpGaXhlczogZGQ1ZjcyNjA3NmNjICgia2V4ZWM6IHN1cHBvcnQgZm9yIGtleGVjIG9uIHBhbmlj
IHVzaW5nIG5ldyBzeXN0ZW0gY2FsbCIpClNpZ25lZC1vZmYtYnk6IFRpZXpodSBZYW5nIDxrZXJu
ZWxwYXRjaEAxMjYuY29tPgpBY2tlZC1ieTogRGF2ZSBZb3VuZyA8ZHlvdW5nQHJlZGhhdC5jb20+
CkNjOiBWaXZlayBHb3lhbCA8dmdveWFsQHJlZGhhdC5jb20+CkNjOiBrZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCi0tLQogYXJjaC94ODYva2VybmVsL2NyYXNoLmMgfCA0ICsrKy0KIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9rZXJuZWwvY3Jhc2guYyBiL2FyY2gveDg2L2tlcm5lbC9jcmFzaC5jCmluZGV4IDU3NmIy
ZTEuLmYxMzQ4MGUgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcmFzaC5jCisrKyBiL2Fy
Y2gveDg2L2tlcm5lbC9jcmFzaC5jCkBAIC01Niw3ICs1Niw5IEBAIHN0cnVjdCBjcmFzaF9tZW1t
YXBfZGF0YSB7CiAgKi8KIGNyYXNoX3ZtY2xlYXJfZm4gX19yY3UgKmNyYXNoX3ZtY2xlYXJfbG9h
ZGVkX3ZtY3NzID0gTlVMTDsKIEVYUE9SVF9TWU1CT0xfR1BMKGNyYXNoX3ZtY2xlYXJfbG9hZGVk
X3ZtY3NzKTsKLXVuc2lnbmVkIGxvbmcgY3Jhc2hfemVyb19ieXRlczsKKyNpZmRlZiBDT05GSUdf
S0VYRUNfRklMRQorc3RhdGljIHVuc2lnbmVkIGxvbmcgY3Jhc2hfemVyb19ieXRlczsKKyNlbmRp
ZgogCiBzdGF0aWMgaW5saW5lIHZvaWQgY3B1X2NyYXNoX3ZtY2xlYXJfbG9hZGVkX3ZtY3NzKHZv
aWQpCiB7Ci0tIAoxLjguMy4x
