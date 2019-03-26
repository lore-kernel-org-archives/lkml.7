Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D27FC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA36320830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbfCZK3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:29:36 -0400
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:21837 "EHLO
        SHSQR01.unisoc.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726413AbfCZK3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:29:35 -0400
X-Greylist: delayed 2406 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Mar 2019 06:29:31 EDT
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id x2Q9mspM045945;
        Tue, 26 Mar 2019 17:48:54 +0800 (CST)
        (envelope-from Orson.Zhai@unisoc.com)
Received: from ig2.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTPS id x2Q9lH3v043326
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 26 Mar 2019 17:47:18 +0800 (CST)
        (envelope-from Orson.Zhai@unisoc.com)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.847.32; Tue, 26 Mar 2019
 17:47:47 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.0847.030; Tue, 26 Mar 2019 17:47:29 +0800
From:   =?gb2312?B?tdS+qSAoT3Jzb24gWmhhaSk=?= <Orson.Zhai@unisoc.com>
To:     Baolin Wang <baolin.wang@linaro.org>, Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        "Ralf Spenneberg" <ralf@spenneberg.net>,
        USB list <linux-usb@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        =?gb2312?B?1cW0utHeIChDaHVueWFuIFpoYW5nKQ==?= 
        <Chunyan.Zhang@unisoc.com>,
        =?gb2312?B?zfWxpsHWIChCYW9saW4gV2FuZyk=?= <baolin.wang@unisoc.com>
Subject: RE: [BACKPORT 4.4.y 04/25] USB: iowarrior: fix oops with malicious
 USB descriptors
Thread-Topic: [BACKPORT 4.4.y 04/25] USB: iowarrior: fix oops with malicious
 USB descriptors
Thread-Index: AQHU47dhTWr5bN/B3EW6PMMFJpFH8KYdqWvs
Date:   Tue, 26 Mar 2019 09:47:28 +0000
Message-ID: <da28497fe12647b495db75473fd4e91c@BJMBX01.spreadtrum.com>
References: <20190322154425.3852517-1-arnd@arndb.de>
 <20190322154425.3852517-5-arnd@arndb.de> <20190326011319.GC29420@kroah.com>
 <CAK8P3a1u_2gz=UieoNT7yOqSKFvFOXA34CAs7w+qouoQTjqDgQ@mail.gmail.com>,<CAMz4kuJJPS+GBQqJ4p-PebbKJt5MKK4vQv5EwJAPpL64fBDKLQ@mail.gmail.com>
In-Reply-To: <CAMz4kuJJPS+GBQqJ4p-PebbKJt5MKK4vQv5EwJAPpL64fBDKLQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.1.253]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: SHSQR01.spreadtrum.com x2Q9lH3v043326
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuZCwgQmFvbGluLAoKVGhhbmsgeW91IQoKSSBhbSBpbiB0cmF2ZWwuCgpJICdsbCBhcHBs
eSBpdCB3aGVuIEkgYW0gYmFjay4KCkJlc3QsCk9yc29uCi0tLS0tLS0tCkdvb2QgcGF0Y2hlcyBh
cmUgYWx3YXlzIHdlbGNvbWUhCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpGcm9tOiBCYW9saW4gV2FuZyA8YmFvbGluLndhbmdAbGluYXJvLm9yZz4KU2VudDogVHVl
c2RheSwgTWFyY2ggMjYsIDIwMTkgMTc6MzUKVG86IEFybmQgQmVyZ21hbm4KQ2M6IEdyZWcgS3Jv
YWgtSGFydG1hbjsgIyAzLjQueDsgS2VlcyBDb29rOyBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9y
OyBHdXN0YXZvIEEuIFIuIFNpbHZhOyBKb3NoIEJveWVyOyBSYWxmIFNwZW5uZWJlcmc7IFVTQiBs
aXN0OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0OyDVxbS60d4gKENodW55YW4gWmhhbmcpOyDN
9bGmwdYgKEJhb2xpbiBXYW5nKTsgtdS+qSAoT3Jzb24gWmhhaSk7INXFtLrR3iAoQ2h1bnlhbiBa
aGFuZykKU3ViamVjdDogUmU6IFtCQUNLUE9SVCA0LjQueSAwNC8yNV0gVVNCOiBpb3dhcnJpb3I6
IGZpeCBvb3BzIHdpdGggbWFsaWNpb3VzIFVTQiBkZXNjcmlwdG9ycwoKT24gVHVlLCAyNiBNYXIg
MjAxOSBhdCAxNjoyMSwgQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gd3JvdGU6Cj4KPiBP
biBUdWUsIE1hciAyNiwgMjAxOSBhdCAyOjIzIEFNIEdyZWcgS3JvYWgtSGFydG1hbgo+IDxncmVn
a2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4gPgo+ID4gT24gRnJpLCBNYXIgMjIsIDIw
MTkgYXQgMDQ6NDM6NTVQTSArMDEwMCwgQXJuZCBCZXJnbWFubiB3cm90ZToKPiA+ID4gRnJvbTog
Sm9zaCBCb3llciA8andib3llckBmZWRvcmFwcm9qZWN0Lm9yZz4KPiA+ID4KPiA+ID4gVGhlIGlv
d2FycmlvciBkcml2ZXIgZXhwZWN0cyBhdCBsZWFzdCBvbmUgdmFsaWQgZW5kcG9pbnQuICBJZiBn
aXZlbgo+ID4gPiBtYWxpY2lvdXMgZGVzY3JpcHRvcnMgdGhhdCBzcGVjaWZ5IDAgZm9yIHRoZSBu
dW1iZXIgb2YgZW5kcG9pbnRzLAo+ID4gPiBpdCB3aWxsIGNyYXNoIGluIHRoZSBwcm9iZSBmdW5j
dGlvbi4gIEVuc3VyZSB0aGVyZSBpcyBhdCBsZWFzdAo+ID4gPiBvbmUgZW5kcG9pbnQgb24gdGhl
IGludGVyZmFjZSBiZWZvcmUgdXNpbmcgaXQuCj4gPiA+Cj4gPiA+IFRoZSBmdWxsIHJlcG9ydCBv
ZiB0aGlzIGlzc3VlIGNhbiBiZSBmb3VuZCBoZXJlOgo+ID4gPiBodHRwOi8vc2VjbGlzdHMub3Jn
L2J1Z3RyYXEvMjAxNi9NYXIvODcKPiA+ID4KPiA+ID4gUmVwb3J0ZWQtYnk6IFJhbGYgU3Blbm5l
YmVyZyA8cmFsZkBzcGVubmViZXJnLm5ldD4KPiA+ID4gQ2M6IHN0YWJsZSA8c3RhYmxlQHZnZXIu
a2VybmVsLm9yZz4KPiA+ID4gU2lnbmVkLW9mZi1ieTogSm9zaCBCb3llciA8andib3llckBmZWRv
cmFwcm9qZWN0Lm9yZz4KPiA+ID4gU2lnbmVkLW9mZi1ieTogR3JlZyBLcm9haC1IYXJ0bWFuIDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KPiA+ID4gKGNoZXJyeSBwaWNrZWQgZnJvbSBjb21t
aXQgNGVjMGVmM2E4MjEyNWVmYzM2MTczMDYyYTUwNjI0NTUwYTkwMGFlMCkKPiA+ID4gU2lnbmVk
LW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KPiA+ID4gLS0tCj4gPiA+ICBk
cml2ZXJzL3VzYi9taXNjL2lvd2Fycmlvci5jIHwgNiArKysrKysKPiA+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKykKPiA+Cj4gPiBUaGlzIGNvbW1pdCBoYXMgYmVlbiBpbiB0aGUg
dHJlZSBmb3IgYSBsb25nIHRpbWUuICBJdCB3YXMgaW4gdGhlIDQuNC43Cj4gPiByZWxlYXNlLCBi
YWNrIGluIEFwcmlsIDIwMTYuICBBbmQgdGhlbiBpdCB3YXMgcmV2ZXJ0ZWQgaW4gY29tbWl0Cj4g
PiBiNzMyMWU4MWZjMzYgKCJVU0I6IGlvd2FycmlvcjogZml4IE5VTEwtZGVyZWYgYXQgcHJvYmUi
KSBhcyBpdCBicm9rZQo+ID4gc3lzdGVtcy4gIFNvIHdoeSBhZGQgaXQgYmFjaywgdGhlIGNvcnJl
Y3QgZnVuY3Rpb25hbGl0eSBzaG91bGQgYmUgdGhlcmUKPiA+IHRvZGF5LCByaWdodD8KPgo+IFNv
cnJ5IEkgbWlzc2VkIHRoYXQgaGlzdG9yeS4gVGhlIHNjcmlwdCBJIHVzZWQgdG8gaWRlbnRpZnkg
cGF0Y2hlcyBub3RpY2VkCj4gdGhhdCB0aGlzIHBhdGNoIHdhcyBub3QgYXBwbGllZCwgYnV0IEkg
ZGlkIG5vdCBoYXZlIGEgY2hlY2sgZm9yIGFscmVhZHktCj4gcmV2ZXJ0ZWQgcGF0Y2hlcy4KPgo+
IENodW55YW4sIEJhb2xpbjogaXQgc2VlbXMgdGhlIHNwcmVhZHRydW0gNC40IGtlcm5lbCBnb3Qg
dGhpcyB3cm9uZwo+IGFzIHdlbGwsIGJ5IGJhY2twb3J0aW5nIHRoZSBwYXRjaCBhZ2FpbiBvbiB0
b3Agb2YgNC40LjE3Mi4gQ2FuIHlvdSBjaGVjawo+IHRoZSBsYXRlc3QgaW50ZXJuYWwgdmVyc2lv
biBmb3IgdGhpcz8KClllcywgSSBzYXcgdGhpcyBwYXRjaCBpbiBvdXIgNC40IGtlcm5lbC4KCk9y
c29uLCB3ZSBzaG91bGQgcmV2ZXJ0IHRoaXMgcGF0Y2ggZnJvbSBvdXIga2VybmVsIGFzIEdyZWcg
bWVudGlvbmVkLgoKLS0KQmFvbGluIFdhbmcKQmVzdCBSZWdhcmRzCg==
