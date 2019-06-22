Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82134C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 22:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B7E21670
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 22:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="ZWGCL+Qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfFVW0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 18:26:06 -0400
Received: from m15-14.126.com ([220.181.15.14]:46058 "EHLO m15-14.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfFVW0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 18:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=3zSBw
        1RjUY93BrJZkueCMqrf8iggV0hii4OWaCJ/AWg=; b=ZWGCL+Qqao86zOQ/lt1fZ
        wH47m7LumCQBeqEyU3Op9kLtDOejzKhtRkx4WJZsE+wY20DDpSUTEVesulKgqQkw
        JCgb2bLV2q0rOLIFKmrAILqYcxQsGV3kQK9EiYq7kz3xWaUM2lH8w7fuuwWLAQqX
        L6v155jHxbY37EZx9qu7a8=
Received: from kernelpatch$126.com ( [222.90.31.153] ) by
 ajax-webmail-wmsvr14 (Coremail) ; Sun, 23 Jun 2019 06:24:01 +0800 (CST)
X-Originating-IP: [222.90.31.153]
Date:   Sun, 23 Jun 2019 06:24:01 +0800 (CST)
From:   "Tiezhu Yang" <kernelpatch@126.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com
Subject: [PATCH v2] kexec: fix warnig of crash_zero_bytes in crash.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20190614(cb3344cf) Copyright (c) 2002-2019 www.mailtech.cn 126com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <43d6fe3a.18e.16b814a09ba.Coremail.kernelpatch@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: DsqowABnVleCqg5dzxxGAA--.25374W
X-CM-SenderInfo: xnhu0vxosd3ubk6rjloofrz/1tbiEALb9VpD9ASEyQAAsY
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
ZWxwYXRjaEAxMjYuY29tPgpDYzogVml2ZWsgR295YWwgPHZnb3lhbEByZWRoYXQuY29tPgotLS0K
IGFyY2gveDg2L2tlcm5lbC9jcmFzaC5jIHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2Ny
YXNoLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYwppbmRleCA1NzZiMmUxLi5mMTM0ODBlIDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYworKysgYi9hcmNoL3g4Ni9rZXJuZWwv
Y3Jhc2guYwpAQCAtNTYsNyArNTYsOSBAQCBzdHJ1Y3QgY3Jhc2hfbWVtbWFwX2RhdGEgewogICov
CiBjcmFzaF92bWNsZWFyX2ZuIF9fcmN1ICpjcmFzaF92bWNsZWFyX2xvYWRlZF92bWNzcyA9IE5V
TEw7CiBFWFBPUlRfU1lNQk9MX0dQTChjcmFzaF92bWNsZWFyX2xvYWRlZF92bWNzcyk7Ci11bnNp
Z25lZCBsb25nIGNyYXNoX3plcm9fYnl0ZXM7CisjaWZkZWYgQ09ORklHX0tFWEVDX0ZJTEUKK3N0
YXRpYyB1bnNpZ25lZCBsb25nIGNyYXNoX3plcm9fYnl0ZXM7CisjZW5kaWYKIAogc3RhdGljIGlu
bGluZSB2b2lkIGNwdV9jcmFzaF92bWNsZWFyX2xvYWRlZF92bWNzcyh2b2lkKQogewotLSAKMS44
LjMuMQ==
