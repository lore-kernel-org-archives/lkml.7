Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2E9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD1C2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="VLZlwQHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbfCZOVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:21:51 -0400
Received: from m15-29.126.com ([220.181.15.29]:35102 "EHLO m15-29.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfCZOVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=n1jzq
        8200DdddCyXM3kjf0pJJmlFhUFeWh8XmCOIek8=; b=VLZlwQHP85mRxB8CtRKEU
        L95sKB7xJGc0bksd65Az3FZjpCQ2t9ClcEEAHXDkt6zoNHBqqp9/wuOHZEud2+kS
        1mvIf00xwPEe+Qxt1cymQUONaKNqTA/9QTio0Um59kOLPXLSPR+V4iOniVf7XEKK
        EJ/14zhKCTaH1/P//fmH94=
Received: from liuxiang_1999$126.com ( [222.209.19.73] ) by
 ajax-webmail-wmsvr29 (Coremail) ; Tue, 26 Mar 2019 22:20:50 +0800 (CST)
X-Originating-IP: [222.209.19.73]
Date:   Tue, 26 Mar 2019 22:20:50 +0800 (CST)
From:   "Liu Xiang" <liuxiang_1999@126.com>
To:     "Vignesh Raghavendra" <vigneshr@ti.com>
Cc:     "Liu Xiang" <liu.xiang6@zte.com.cn>, bbrezillon@kernel.org,
        richard@nod.at, linux-kernel@vger.kernel.org,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        computersforpeace@gmail.com, dwmw2@infradead.org
Subject: Re:Re: [PATCH v2] mtd: spi-nor: Return error when nor->addr_width
 does not match the device size
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20180927(cd7136b6) Copyright (c) 2002-2019 www.mailtech.cn 126com
In-Reply-To: <823dcd3f-8b9f-15c5-a072-06625120766e@ti.com>
References: <1552484753-3393-1-git-send-email-liu.xiang6@zte.com.cn>
 <823dcd3f-8b9f-15c5-a072-06625120766e@ti.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7c81cffa.98f1.169ba600d1e.Coremail.liuxiang_1999@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: HcqowAD3_19DNZpc0AgMAA--.33921W
X-CM-SenderInfo: xolx5x5dqjsiqzzzqiyswou0bp/1tbiZgSDsFpD5zMzZwACsK
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkhpLCBWaWduZXNoCgpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4gSSB3aWxsIHNlbmQgYSBu
ZXcgcGF0Y2guCgoKCgoKCkF0IDIwMTktMDMtMTkgMTM6MjI6MTUsICJWaWduZXNoIFJhZ2hhdmVu
ZHJhIiA8dmlnbmVzaHJAdGkuY29tPiB3cm90ZToKPkhpLAo+Cj5PbiAxMy8wMy8xOSA3OjE1IFBN
LCBMaXUgWGlhbmcgd3JvdGU6Cj4+IEluIHNvbWUgaXMyNWxwMjU2LCB0aGUgRFdPUkQxIG9mIEpF
REVDIEJhc2ljIEZsYXNoIFBhcmFtZXRlciBIZWFkZXIKPj4gaXMgMHhmZmY5MjBlNS4gU28gdGhl
IERXT1JEMVsxODoxN10gQWRkcmVzcyBCeXRlcyBiaXRzIGFyZSAwYjAwLAo+PiBtZWFucyB0aGF0
IDMtQnl0ZSBvbmx5IGFkZHJlc3NpbmcuIEJ1dCB0aGUgZGV2aWNlIHNpemUgaXMgbGFyZ2VyCj4+
IHRoYW4gMTZNQiwgbm9yLT5hZGRyX3dpZHRoIG11c3QgYmUgNCB0byBhY2Nlc3MgdGhlIHdob2xl
IGFkZHJlc3MuCj4+IEFuIGVycm9yIHNob3VsZCBiZSByZXR1cm5lZCB3aGVuIG5vci0+YWRkcl93
aWR0aCBkb2VzIG5vdCBtYXRjaAo+PiB0aGUgZGV2aWNlIHNpemUgaW4gc3BpX25vcl9wYXJzZV9i
ZnB0KCkuIFRoZW4gaXQgY2FuIGdvIGJhY2sgdG8KPj4gdXNlIHNwaV9ub3JfaWRzW10gZm9yIHNl
dHRpbmcgdGhlIHJpZ2h0IGFkZHJfd2lkdGguCj4+IAo+PiBTdWdnZXN0ZWQtYnk6IEJvcmlzIEJy
ZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBM
aXUgWGlhbmcgPGxpdS54aWFuZzZAenRlLmNvbS5jbj4KPj4gLS0tCj4+ICBkcml2ZXJzL210ZC9z
cGktbm9yL3NwaS1ub3IuYyB8IDggKysrKysrKysKPj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKykKPj4gCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3Iu
YyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jCj4+IGluZGV4IDZlMTNiYmQuLjYzOTMz
YzcgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jCj4+ICsrKyBi
L2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jCj4+IEBAIC0yODExLDYgKzI4MTEsMTQgQEAg
c3RhdGljIGludCBzcGlfbm9yX3BhcnNlX2JmcHQoc3RydWN0IHNwaV9ub3IgKm5vciwKPj4gIAl9
Cj4+ICAJcGFyYW1zLT5zaXplID4+PSAzOyAvKiBDb252ZXJ0IHRvIGJ5dGVzLiAqLwo+PiAgCj4+
ICsJLyoKPj4gKwkgKiBJZiB0aGUgZGV2aWNlIGV4Y2VlZHMgMTZNaUIsIGFkZHJfd2lkdGggbXVz
dCBiZSA0Lgo+PiArCSAqIGFkZHJfd2lkdGggPT0gMyBtZWFucyB0aGUgQWRkcmVzcyBCeXRlcyB3
ZSBhcmUKPj4gKwkgKiByZWFkaW5nIGZyb20gQkZQVCBpcyB3cm9uZy4KPj4gKwkgKi8KPgo+SkVT
RDIxNiBzdGFuZGFyZCBkb2VzIG5vdCBtYW5kYXRlIGZsYXNoIGRldmljZXMgPjE2TWlCIHRvIGFs
d2F5cyBzdXBwb3J0Cj40IGJ5dGUgYWRkcmVzc2luZyBvcGNvZGUuIFNvLCBpdHMgb2theSBmb3Ig
Zmxhc2ggdmVuZG9yIHRvIHN1cHBvcnQKPj4xNk1pQiBmbGFzaCB3aXRoIDMgYnl0ZSBhZGRyZXNz
aW5nIGFuZCBCYW5rL2V4dGVuZGVkIGFkZHJlc3MgcmVnaXN0ZXIuCj4KPj4gKwlpZiAocGFyYW1z
LT5zaXplID4gMHgxMDAwMDAwICYmIG5vci0+YWRkcl93aWR0aCA9PSAzKQo+PiArCQlyZXR1cm4g
LUVJTlZBTDsKPj4gKwo+Cj5Bc3N1bWluZyBvbmx5IERXT1JEMVsxODoxN10gYml0cyBhcmUgd3Jv
bmcsIHRoZW4gcmV0dXJuaW5nIGZyb20gaGVyZQo+d291bGQgbWVhbiB3ZSBtaXNzIHBhcnNpbmcg
U2VjdG9yIEVyYXNlIHNldHRpbmdzLCBRdWFkIEVuYWJsZQo+UmVxdWlyZW1lbnRzIGV0YyBmcm9t
IEJGUFQgd2hpY2ggaXMga2luZCBvZiBiYWQuCj5JIHN1Z2dlc3QgdG8gbW92ZSB0aGUgZml4IHRv
WzFdLCBhZGRyX3dpZHRoIGluZGljYXRlZCBpbiBmbGFzaF9pbmZvCj5zdHJ1Y3Qgb2YgdGhlIGRl
dmljZSBjYW4gdGFrZSBwcmVjZWRlbmNlIG92ZXIgU0ZEUC4KPgo+WzFdaHR0cHM6Ly9lbGl4aXIu
Ym9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1u
b3IuYyNMNDEwNgo+Cj4KPj4gIAkvKiBGYXN0IFJlYWQgc2V0dGluZ3MuICovCj4+ICAJZm9yIChp
ID0gMDsgaSA8IEFSUkFZX1NJWkUoc2ZkcF9iZnB0X3JlYWRzKTsgaSsrKSB7Cj4+ICAJCWNvbnN0
IHN0cnVjdCBzZmRwX2JmcHRfcmVhZCAqcmQgPSAmc2ZkcF9iZnB0X3JlYWRzW2ldOwo+PiAKPgo+
LS0gCj5SZWdhcmRzCj5WaWduZXNoCg==
