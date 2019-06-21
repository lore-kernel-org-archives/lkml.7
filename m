Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88D1C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9508A206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="HtOzTPWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfFUNjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:39:40 -0400
Received: from m15-14.126.com ([220.181.15.14]:46907 "EHLO m15-14.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfFUNjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=QGdsU
        gyXCSYHoOEp1Wefv/TO84Pvr2WEjxPG073SWEk=; b=HtOzTPWrh4OlfO89a6B8o
        NxANss8JkIJn+zNkYys1QiDA09nMJhL/t62eic3xpaHIPb87r/reROWpqGsDqZTA
        iTXGOR7dV3JUJLbHMfqpUsS5Mi8dsVcOlDAR1xMvcuT7rcjxqi3X/P3tWIPILsQS
        yaXCjttebq5dux8RpEqeXs=
Received: from kernelpatch$126.com ( [117.136.87.52] ) by
 ajax-webmail-wmsvr14 (Coremail) ; Fri, 21 Jun 2019 21:38:44 +0800 (CST)
X-Originating-IP: [117.136.87.52]
Date:   Fri, 21 Jun 2019 21:38:44 +0800 (CST)
From:   "Tiezhu Yang" <kernelpatch@126.com>
To:     "Borislav Petkov" <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com
Subject: Re:Re: [PATCH] kexec: fix warnig of crash_zero_bytes in crash.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20190614(cb3344cf) Copyright (c) 2002-2019 www.mailtech.cn 126com
In-Reply-To: <20190620163900.GF28032@zn.tnic>
References: <fa5d08.1fe.16b5848e5f7.Coremail.kernelpatch@126.com>
 <20190620163900.GF28032@zn.tnic>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <7c86df5d.8b94.16b7a42c5be.Coremail.kernelpatch@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: DsqowAA3JVbl3QxdKMRFAA--.18968W
X-CM-SenderInfo: xnhu0vxosd3ubk6rjloofrz/1tbirwDa9VpD6Xs+gwABs3
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXQgMjAxOS0wNi0yMSAwMDozOTowMCwgIkJvcmlzbGF2IFBldGtvdiIgPGJwQGFsaWVuOC5kZT4g
d3JvdGU6Cj5PbiBTYXQsIEp1biAxNSwgMjAxOSBhdCAwNzoxODoyMEFNICswODAwLCBUaWV6aHUg
WWFuZyB3cm90ZToKPj4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgZm9sbG93aW5nIHNwYXJzZSB3YXJu
aW5nOgo+Cj5Bdm9pZCBoYXZpbmcgIlRoaXMgcGF0Y2giIG9yICJUaGlzIGNvbW1pdCIgaW4gdGhl
IGNvbW1pdCBtZXNzYWdlLiBJdCBpcwo+dGF1dG9sb2dpY2FsbHkgdXNlbGVzcy4KPgo+QWxzbywg
ZG8KPgo+JCBnaXQgZ3JlcCAnVGhpcyBwYXRjaCcgRG9jdW1lbnRhdGlvbi9wcm9jZXNzCj4KPmZv
ciBtb3JlIGRldGFpbHMuCj4KPj4gYXJjaC94ODYva2VybmVsL2NyYXNoLmM6NTk6MTU6Cj4+IHdh
cm5pbmc6IHN5bWJvbCAnY3Jhc2hfemVyb19ieXRlcycgd2FzIG5vdCBkZWNsYXJlZC4gU2hvdWxk
IGl0IGJlIHN0YXRpYz8KPj4gCj4+IEluIGFkZGl0aW9uLCBjcmFzaF96ZXJvX2J5dGVzIGlzIHVz
ZWQgd2hlbiBDT05GSUdfS0VYRUNfRklMRSBpcwo+PiBzZXQsIHNvIG1ha2UgaXQgb25seSBhdmFp
bGFibGUgdW5kZXIgQ09ORklHX0tFWEVDX0ZJTEUuIE90aGVyd2lzZSwKPj4gaWYgQ09ORklHX0tF
WEVDX0ZJTEUgaXMgbm90IHNldCwgdGhlIGZvbGxvd2luZyB3YXJuaW5nIHdpbGwgYXBwZWFyOgo+
PiAKPj4gYXJjaC94ODYva2VybmVsL2NyYXNoLmM6NTk6MjI6Cj4+IHdhcm5pbmc6IKGuY3Jhc2hf
emVyb19ieXRlc6GvIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC12YXJpYWJsZV0KPgo+
VGhhdCBoYXBwZW5zIG9ubHkgd2hlbiB5b3UgbWFrZSBpdCBzdGF0aWMsIHNvIHBsZWFzZSBzdGF0
ZSB0aGF0IGluIHRoZQo+Y29tbWl0IG1lc3NhZ2UuCgpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlv
biwgSSB3aWxsIHNlbmQgYSB2MiBwYXRjaC4KClRoYW5rcywKCj4KPlRoeC4KPgo+LS0gCj5SZWdh
cmRzL0dydXNzLAo+ICAgIEJvcmlzLgo+Cj5Hb29kIG1haWxpbmcgcHJhY3RpY2VzIGZvciA0MDA6
IGF2b2lkIHRvcC1wb3N0aW5nIGFuZCB0cmltIHRoZSByZXBseS4K
