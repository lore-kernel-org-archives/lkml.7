Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA87C31E50
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 23:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EE621848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 23:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="c2Qp4i/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfFNXT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 19:19:29 -0400
Received: from m15-62.126.com ([220.181.15.62]:11101 "EHLO m15-62.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfFNXT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 19:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=n4WmK
        URsM47Zn2SNCEHlEjsXVDp9cHazAH6KI9Q6OlM=; b=c2Qp4i/sV5X1m7eLE+D2T
        eH91jqD5tkjm299WO9ssSuwVgFk+wpMBf3ca5wqFyXRCzwhMerNEG9ilG8ZxjE+H
        N0DSH33LflSilP2fEKdJ98qfwgWIRgdTAL8CAT/sHIad3Stxs+s7KaBB8Ltp33kn
        T5h+JSQxfBU6OJ28ythcFA=
Received: from kernelpatch$126.com ( [117.136.86.35] ) by
 ajax-webmail-wmsvr62 (Coremail) ; Sat, 15 Jun 2019 07:18:20 +0800 (CST)
X-Originating-IP: [117.136.86.35]
Date:   Sat, 15 Jun 2019 07:18:20 +0800 (CST)
From:   "Tiezhu Yang" <kernelpatch@126.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com
Subject: [PATCH] kexec: fix warnig of crash_zero_bytes in crash.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20180927(cd7136b6) Copyright (c) 2002-2019 www.mailtech.cn 126com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <fa5d08.1fe.16b5848e5f7.Coremail.kernelpatch@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: PsqowADnTBE9KwRdlf1AAA--.6214W
X-CM-SenderInfo: xnhu0vxosd3ubk6rjloofrz/1tbijBzR9VpD9X4bpwACsY
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBmaXhlcyB0aGUgZm9sbG93aW5nIHNwYXJzZSB3YXJuaW5nOgoKYXJjaC94ODYv
a2VybmVsL2NyYXNoLmM6NTk6MTU6Cndhcm5pbmc6IHN5bWJvbCAnY3Jhc2hfemVyb19ieXRlcycg
d2FzIG5vdCBkZWNsYXJlZC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8KCkluIGFkZGl0aW9uLCBjcmFz
aF96ZXJvX2J5dGVzIGlzIHVzZWQgd2hlbiBDT05GSUdfS0VYRUNfRklMRSBpcwpzZXQsIHNvIG1h
a2UgaXQgb25seSBhdmFpbGFibGUgdW5kZXIgQ09ORklHX0tFWEVDX0ZJTEUuIE90aGVyd2lzZSwK
aWYgQ09ORklHX0tFWEVDX0ZJTEUgaXMgbm90IHNldCwgdGhlIGZvbGxvd2luZyB3YXJuaW5nIHdp
bGwgYXBwZWFyOgoKYXJjaC94ODYva2VybmVsL2NyYXNoLmM6NTk6MjI6Cndhcm5pbmc6IKGuY3Jh
c2hfemVyb19ieXRlc6GvIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC12YXJpYWJsZV0K
CkZpeGVzOiBkZDVmNzI2MDc2Y2MgKCJrZXhlYzogc3VwcG9ydCBmb3Iga2V4ZWMgb24gcGFuaWMg
dXNpbmcgbmV3IHN5c3RlbSBjYWxsIikKU2lnbmVkLW9mZi1ieTogVGllemh1IFlhbmcgPGtlcm5l
bHBhdGNoQDEyNi5jb20+CkNjOiBWaXZlayBHb3lhbCA8dmdveWFsQHJlZGhhdC5jb20+Ci0tLQog
YXJjaC94ODYva2VybmVsL2NyYXNoLmMgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3Jh
c2guYyBiL2FyY2gveDg2L2tlcm5lbC9jcmFzaC5jCmluZGV4IDU3NmIyZTEuLmYxMzQ4MGUgMTAw
NjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcmFzaC5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9j
cmFzaC5jCkBAIC01Niw3ICs1Niw5IEBAIHN0cnVjdCBjcmFzaF9tZW1tYXBfZGF0YSB7CiAgKi8K
IGNyYXNoX3ZtY2xlYXJfZm4gX19yY3UgKmNyYXNoX3ZtY2xlYXJfbG9hZGVkX3ZtY3NzID0gTlVM
TDsKIEVYUE9SVF9TWU1CT0xfR1BMKGNyYXNoX3ZtY2xlYXJfbG9hZGVkX3ZtY3NzKTsKLXVuc2ln
bmVkIGxvbmcgY3Jhc2hfemVyb19ieXRlczsKKyNpZmRlZiBDT05GSUdfS0VYRUNfRklMRQorc3Rh
dGljIHVuc2lnbmVkIGxvbmcgY3Jhc2hfemVyb19ieXRlczsKKyNlbmRpZgogCiBzdGF0aWMgaW5s
aW5lIHZvaWQgY3B1X2NyYXNoX3ZtY2xlYXJfbG9hZGVkX3ZtY3NzKHZvaWQpCiB7Ci0tIAoxLjgu
My4x
