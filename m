Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E93DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A83208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="nDmzM6de"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfFXOlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:41:15 -0400
Received: from m15-41.126.com ([220.181.15.41]:33066 "EHLO m15-41.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbfFXOlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=+sdgh
        JB/TLNpVA12VTC+HwIxrI+KvMHiMNktZnWRL0I=; b=nDmzM6deNuzbSwrhibezr
        9HRUmNgQwaPkgOLR/tLJWvg9VdbeCmCCq4XWftTp7b1lvGlRvRJ/D0bnDnugkck4
        8XL93ko6VLkMun3KxTMiCzwXnVuC1B5+HoatRWX+nt3Rq4nPQvPm+eJtjwuf+FQt
        rvCtj0IlZWZ2L7YvigS3ng=
Received: from liuxiang_1999$126.com ( [222.209.17.143] ) by
 ajax-webmail-wmsvr41 (Coremail) ; Mon, 24 Jun 2019 22:38:35 +0800 (CST)
X-Originating-IP: [222.209.17.143]
Date:   Mon, 24 Jun 2019 22:38:35 +0800 (CST)
From:   "Liu Xiang" <liuxiang_1999@126.com>
To:     Tudor.Ambarus@microchip.com
Cc:     liu.xiang6@zte.com.cn, linux-mtd@lists.infradead.org,
        bbrezillon@kernel.org, richard@nod.at,
        linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        nagasure@xilinx.com, vigneshr@ti.com
Subject: Re:Re: [PATCH v3] mtd: spi-nor: fix nor->addr_width when its value
 configured from SFDP does not match the actual width
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20190614(cb3344cf) Copyright (c) 2002-2019 www.mailtech.cn 126com
In-Reply-To: <5ffc9e32-ff69-9819-7bfd-ad9f793bb629@microchip.com>
References: <1554018157-10860-1-git-send-email-liu.xiang6@zte.com.cn>
 <5ffc9e32-ff69-9819-7bfd-ad9f793bb629@microchip.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <675ae013.8c92.16b89eca4a9.Coremail.liuxiang_1999@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: KcqowAD3VIFs4BBduQhHAA--.19543W
X-CM-SenderInfo: xolx5x5dqjsiqzzzqiyswou0bp/1tbi2wndsFpD9RwKmQABsd
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpIaSwgdGEKClRoYW5rcyBmb3IgeW91ciBhZHZpY2UhIEkgd2lsbCBzZW5kIHRoZSB1cGRhdGUg
cGF0Y2ggaW4gc29vbi4KCgoKCkF0IDIwMTktMDYtMjIgMTk6NDk6MjUsIFR1ZG9yLkFtYmFydXNA
bWljcm9jaGlwLmNvbSB3cm90ZToKPkhpLCBMaXUsCj4KPk9uIDAzLzMxLzIwMTkgMTA6NDIgQU0s
IExpdSBYaWFuZyB3cm90ZToKPgo+PiBTb21lIGlzMjVscDI1NiBnZXQgQkZQVF9EV09SRDFfQURE
UkVTU19CWVRFU18zX09OTFkgZnJvbSBCRlBUIHRhYmxlIGZvcgo+PiBhZGRyZXNzIHdpZHRoLiBC
dXQgaW4gYWN0dWFsIGZhY3QgdGhlIGZsYXNoIGNhbiBzdXBwb3J0IDQtYnl0ZSBhZGRyZXNzLgo+
PiBTbyB3ZSBzaG91bGQgZml4IGl0Lgo+Cj5JdCdzIGJldHRlciB0byBiZSBpbXBlcmF0aXZlLiBT
dWJzdGl0dXRlICJTbyB3ZSBzaG91bGQgZml4IGl0IiB3aXRoIHNvbWV0aGluZwo+bGlrZSAiVXNl
IGEgcG9zdCBiZnB0IGZpeHVwIGhvb2sgdG8gb3ZlcndyaXRlIHRoZSBhZGRyZXNzIHdpZHRoIGFk
dmVydGlzZWQgYnkKPnRoZSBCRlBUIi4KPgo+Pgo+Cj5XZSdsbCBuZWVkIGEgZml4ZXMgdGFnIGhl
cmUuPiBTdWdnZXN0ZWQtYnk6IEJvcmlzIEJyZXppbGxvbiA8YmJyZXppbGxvbkBrZXJuZWwub3Jn
Pgo+PiBTdWdnZXN0ZWQtYnk6IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRpLmNvbT4K
Pgo+V2hlbj8gSWYgdGhleSBkaWRuJ3QgZXhwbGljaXRseSBzdWdnZXN0ZWQgdGhpcyBhcHByb2Fj
aCwgbGV0cyBkcm9wIHRoZSBTLWIgdGFncy4KPgo+PiBTaWduZWQtb2ZmLWJ5OiBMaXUgWGlhbmcg
PGxpdS54aWFuZzZAenRlLmNvbS5jbj4KPj4gLS0tCj4+IAo+PiBDaGFuZ2VzIGluIHYzOgo+PiAg
YWRkIGEgZml4dXAgZm9yIGlzMjVscDI1NiB0byBzb2x2ZSB0aGUgYWRkcmVzcyB3aWR0aCBwcm9i
bGVtLgo+PiAKPj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIHwgMjUgKysrKysrKysr
KysrKysrKysrKysrKysrLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1u
b3IuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jCj4+IGluZGV4IDZlMTNiYmQuLmQy
NTJhNjYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jCj4+ICsr
KyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jCj4+IEBAIC0xNjgyLDYgKzE2ODIsMjgg
QEAgc3RhdGljIGludCBzcjJfYml0N19xdWFkX2VuYWJsZShzdHJ1Y3Qgc3BpX25vciAqbm9yKQo+
PiAgCQkuZmxhZ3MgPSBTUElfTk9SX05PX0ZSIHwgU1BJX1MzQU4sCj4+ICAKPj4gIHN0YXRpYyBp
bnQKPj4gK2lzMjVscDI1Nl9wb3N0X2JmcHRfZml4dXBzKHN0cnVjdCBzcGlfbm9yICpub3IsCj4+
ICsJCQkgICBjb25zdCBzdHJ1Y3Qgc2ZkcF9wYXJhbWV0ZXJfaGVhZGVyICpiZnB0X2hlYWRlciwK
Pj4gKwkJCSAgIGNvbnN0IHN0cnVjdCBzZmRwX2JmcHQgKmJmcHQsCj4+ICsJCQkgICBzdHJ1Y3Qg
c3BpX25vcl9mbGFzaF9wYXJhbWV0ZXIgKnBhcmFtcykKPj4gK3sKPj4gKwkvKgo+PiArCSAqIElT
MjVMUDI1NiBzdXBwb3J0cyA0QiBvcGNvZGVzLgo+PiArCSAqIFVuZm9ydHVuYXRlbHksIHNvbWUg
ZGV2aWNlcyBnZXQgQkZQVF9EV09SRDFfQUREUkVTU19CWVRFU18zX09OTFkKPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBeIHdoaWNoIGRldmljZXMsIGRpZCB5b3UgZ2V0IGEgbGlzdCBmcm9t
IGlzc2k/Cj4KPj4gKwkgKiBmcm9tIEJGUFQgdGFibGUgZm9yIGFkZHJlc3Mgd2lkdGguIFdlIHNo
b3VsZCBmaXggaXQuCj4KPkhvdyBhYm91dCAiSVMyNUxQMjU2IHN1cHBvcnRzIDRCIG9wY29kZXMs
IGJ1dCB0aGUgQkZQVCBhZHZlcnRpc2VzIGEKPkJGUFRfRFdPUkQxX0FERFJFU1NfQllURVNfM19P
TkxZIGFkZHJlc3Mgd2lkdGguIE92ZXJ3cml0ZSB0aGUgYWRkcmVzcyB3aWR0aAo+YWR2ZXJ0aXNl
ZCBieSB0aGUgQkZQVC4iCj4KPj4gKwkgKi8KPj4gKwlpZiAoKGJmcHQtPmR3b3Jkc1tCRlBUX0RX
T1JEKDEpXSAmIEJGUFRfRFdPUkQxX0FERFJFU1NfQllURVNfTUFTSykgPT0KPj4gKwkJQkZQVF9E
V09SRDFfQUREUkVTU19CWVRFU18zX09OTFkpCj4+ICsJCW5vci0+YWRkcl93aWR0aCA9IDQ7Cj4+
ICsKPj4gKwlyZXR1cm4gMDsKPj4gK30KPj4gKwo+PiArc3RhdGljIHN0cnVjdCBzcGlfbm9yX2Zp
eHVwcyBpczI1bHAyNTZfZml4dXBzID0gewo+Cj5OYWdhIHdpbGwgdXNlICJpczI1bHAyNTZfZml4
dXBzIiBmb3IgdGhlIGlzMjV3cDI1NiB0b28sIGJ1dCBpdCdzIG5vdCB0aGUgY2FzZSB0bwo+Y2hh
bmdlIHRoZSBuYW1lIHlldC4gQWxsIGdvb2QgaGVyZS4KPgo+SSByZWFsbHkgd2FudCB0byBoYXZl
IHRoaXMgaW4gbmV4dCwgY2FuIEkgaGF2ZSBhbiB1cGRhdGUgaW4gdGhlIG5leHQgZmV3IGRheXM/
Cj4KPkNoZWVycywKPnRhCg==
