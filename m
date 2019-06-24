Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EC6C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09444208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="Yo4W9q7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfFXE1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 00:27:20 -0400
Received: from m15-33.126.com ([220.181.15.33]:62962 "EHLO m15-33.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbfFXE1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 00:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=7gNCP
        t58FlHiGVUS+1eGn/1dip54Ve5n7lgjcoKAC6A=; b=Yo4W9q7fsMtDEM6NVy6dN
        CHZ4vekiOWCHOIEfTlSKmZau784hkiQZr9kKY93UWFzh2fkJV7TGeeGSUt7WEDFH
        HUhT/6ZAS0tZnvjnpPYSZ/P+XSZ93zn2uT4euT0OdC3HKRa8MSfcs5ATm47dUO/e
        F3M95HvQ9vNo0TJyJbLCvM=
Received: from kernelpatch$126.com ( [222.90.31.26] ) by
 ajax-webmail-wmsvr33 (Coremail) ; Mon, 24 Jun 2019 12:26:47 +0800 (CST)
X-Originating-IP: [222.90.31.26]
Date:   Mon, 24 Jun 2019 12:26:47 +0800 (CST)
From:   "Tiezhu Yang" <kernelpatch@126.com>
To:     "Dave Young" <dyoung@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com
Subject: Re:Re: [PATCH v2] kexec: fix warnig of crash_zero_bytes in crash.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20190614(cb3344cf) Copyright (c) 2002-2019 www.mailtech.cn 126com
In-Reply-To: <20190624015359.GC2976@dhcp-128-65.nay.redhat.com>
References: <43d6fe3a.18e.16b814a09ba.Coremail.kernelpatch@126.com>
 <20190624013520.GA2976@dhcp-128-65.nay.redhat.com>
 <20190624015359.GC2976@dhcp-128-65.nay.redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <7e73e4c4.3c0e.16b87bc8418.Coremail.kernelpatch@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: IcqowACX1_oIURBdqWFGAA--.32223W
X-CM-SenderInfo: xnhu0vxosd3ubk6rjloofrz/1tbi7wjd9VpD68uGGAAAso
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXQgMjAxOS0wNi0yNCAwOTo1Mzo1OSwgIkRhdmUgWW91bmciIDxkeW91bmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj5PbiAwNi8yNC8xOSBhdCAwOTozNWFtLCBEYXZlIFlvdW5nIHdyb3RlOgo+PiBPbiAw
Ni8yMy8xOSBhdCAwNjoyNGFtLCBUaWV6aHUgWWFuZyB3cm90ZToKPj4gPiBGaXggdGhlIGZvbGxv
d2luZyBzcGFyc2Ugd2FybmluZzoKPj4gPiAKPj4gPiBhcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYzo1
OToxNToKPj4gPiB3YXJuaW5nOiBzeW1ib2wgJ2NyYXNoX3plcm9fYnl0ZXMnIHdhcyBub3QgZGVj
bGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/Cj4+ID4gCj4+ID4gRmlyc3QsIG1ha2UgY3Jhc2hf
emVyb19ieXRlcyBzdGF0aWMuIEluIGFkZGl0aW9uLCBjcmFzaF96ZXJvX2J5dGVzCj4+ID4gaXMg
dXNlZCB3aGVuIENPTkZJR19LRVhFQ19GSUxFIGlzIHNldCwgc28gbWFrZSBpdCBvbmx5IGF2YWls
YWJsZQo+PiA+IHVuZGVyIENPTkZJR19LRVhFQ19GSUxFLiBPdGhlcndpc2UsIGlmIENPTkZJR19L
RVhFQ19GSUxFIGlzIG5vdCBzZXQsCj4+ID4gdGhlIGZvbGxvd2luZyB3YXJuaW5nIHdpbGwgYXBw
ZWFyIHdoZW4gbWFrZSBjcmFzaF96ZXJvX2J5dGVzIHN0YXRpYzoKPj4gPiAKPj4gPiBhcmNoL3g4
Ni9rZXJuZWwvY3Jhc2guYzo1OToyMjoKPj4gPiB3YXJuaW5nOiChrmNyYXNoX3plcm9fYnl0ZXOh
ryBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtdmFyaWFibGVdCj4+ID4gCj4+ID4gRml4
ZXM6IGRkNWY3MjYwNzZjYyAoImtleGVjOiBzdXBwb3J0IGZvciBrZXhlYyBvbiBwYW5pYyB1c2lu
ZyBuZXcgc3lzdGVtIGNhbGwiKQo+PiA+IFNpZ25lZC1vZmYtYnk6IFRpZXpodSBZYW5nIDxrZXJu
ZWxwYXRjaEAxMjYuY29tPgo+PiA+IENjOiBWaXZlayBHb3lhbCA8dmdveWFsQHJlZGhhdC5jb20+
Cj4+ID4gLS0tCj4+ID4gIGFyY2gveDg2L2tlcm5lbC9jcmFzaC5jIHwgNCArKystCj4+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4gPiAKPj4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NyYXNoLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3Jh
c2guYwo+PiA+IGluZGV4IDU3NmIyZTEuLmYxMzQ4MGUgMTAwNjQ0Cj4+ID4gLS0tIGEvYXJjaC94
ODYva2VybmVsL2NyYXNoLmMKPj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYwo+PiA+
IEBAIC01Niw3ICs1Niw5IEBAIHN0cnVjdCBjcmFzaF9tZW1tYXBfZGF0YSB7Cj4+ID4gICAqLwo+
PiA+ICBjcmFzaF92bWNsZWFyX2ZuIF9fcmN1ICpjcmFzaF92bWNsZWFyX2xvYWRlZF92bWNzcyA9
IE5VTEw7Cj4+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKGNyYXNoX3ZtY2xlYXJfbG9hZGVkX3ZtY3Nz
KTsKPj4gPiAtdW5zaWduZWQgbG9uZyBjcmFzaF96ZXJvX2J5dGVzOwo+PiA+ICsjaWZkZWYgQ09O
RklHX0tFWEVDX0ZJTEUKPj4gPiArc3RhdGljIHVuc2lnbmVkIGxvbmcgY3Jhc2hfemVyb19ieXRl
czsKPj4gPiArI2VuZGlmCj4+ID4gIAo+PiA+ICBzdGF0aWMgaW5saW5lIHZvaWQgY3B1X2NyYXNo
X3ZtY2xlYXJfbG9hZGVkX3ZtY3NzKHZvaWQpCj4+ID4gIHsKPj4gPiAtLSAKPj4gPiAxLjguMy4x
Cj4+IAo+PiBBY2tlZC1ieTogRGF2ZSBZb3VuZyA8ZHlvdW5nQHJlZGhhdC5jb20+Cj4KPkJUVywg
YSBzb2Z0IHJlbWluZGVyLCBmb3Iga2V4ZWMgcGF0Y2hlcywgaXQgd291bGQgYmUgYmV0dGVyIHRv
IGNjIGtleGVjIG1haWwKPmxpc3QuCgpUaGFuayB5b3UgZm9yIHJlbWluZGluZyBtZSBvZiB0aGF0
LCBJIHdpbGwgcmVzZW5kIGl0IHdpdGggYSBDYyB0byBrZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
LgoKVGhhbmtzLAoKPgo+PiAKPj4gVGhhbmtzCj4+IERhdmUKPj4gCg==
