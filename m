Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8F2C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 10:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA8B2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 10:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="v2P4SJpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388045AbfIMKCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 06:02:33 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:44294 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbfIMKCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 06:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1568368950; x=1599904950;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=F+XGj6uFxp/ya7o8G91y2SWOC9ONU2Uvki6hwH32Ppo=;
  b=v2P4SJpWesHYW+VYsmiAu9SPSlCzxtiUWtQnowV6T2vAoqHucVIhE8Gh
   rCN5N1EX6oAqR0/z8x9ZsaEogBZV5m74SP85exbBMFKMtSZ7CXaYhuc+d
   F5k7pnf6g2LkJbYbhZ34V0Nq5yqOygHqH3FJxB6V7jaOLimror5H2oiaJ
   w=;
X-IronPort-AV: E=Sophos;i="5.64,500,1559520000"; 
   d="scan'208";a="784760765"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 13 Sep 2019 10:02:29 +0000
Received: from EX13MTAUEB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id B3125A218A;
        Fri, 13 Sep 2019 10:02:26 +0000 (UTC)
Received: from EX13D08UEB003.ant.amazon.com (10.43.60.11) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.96) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Sep 2019 10:02:25 +0000
Received: from EX13D04EUB003.ant.amazon.com (10.43.166.235) by
 EX13D08UEB003.ant.amazon.com (10.43.60.11) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Sep 2019 10:02:25 +0000
Received: from EX13D04EUB003.ant.amazon.com ([10.43.166.235]) by
 EX13D04EUB003.ant.amazon.com ([10.43.166.235]) with mapi id 15.00.1367.000;
 Fri, 13 Sep 2019 10:02:24 +0000
From:   "Spassov, Stanislav" <stanspas@amazon.de>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chao.gao@intel.com" <chao.gao@intel.com>
CC:     "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>,
        "jbeulich@suse.com" <jbeulich@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] xen: xen-pciback: Reset MSI-X state when exposing a
 device
Thread-Topic: [PATCH] xen: xen-pciback: Reset MSI-X state when exposing a
 device
Thread-Index: AQHVahhAHUCnM9/kUkG3Q7Ogt5hZ16cpYHyA
Date:   Fri, 13 Sep 2019 10:02:24 +0000
Message-ID: <2c0ad3bf96551ea6e96e812229507221b76876c6.camel@amazon.de>
References: <1543976357-1053-1-git-send-email-chao.gao@intel.com>
In-Reply-To: <1543976357-1053-1-git-send-email-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.68]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5750EAD36033D745AD2E682C7B18BD78@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBEZWMgMTMsIDIwMTggYXQgMDc6NTQsIENoYW8gR2FvIHdyb3RlOg0KPk9uIFRodSwg
RGVjIDEzLCAyMDE4IGF0IDEyOjU0OjUyQU0gLTA3MDAsIEphbiBCZXVsaWNoIHdyb3RlOg0KPj4+
Pj4gT24gMTMuMTIuMTggYXQgMDQ6NDYsIDxjaGFvLmdhb0BpbnRlbC5jb20+IHdyb3RlOg0KPj4+
IE9uIFdlZCwgRGVjIDEyLCAyMDE4IGF0IDA4OjIxOjM5QU0gLTA3MDAsIEphbiBCZXVsaWNoIHdy
b3RlOg0KPj4+Pj4+PiBPbiAxMi4xMi4xOCBhdCAxNjoxOCwgPGNoYW8uZ2FvQGludGVsLmNvbT4g
d3JvdGU6DQo+Pj4+PiBPbiBXZWQsIERlYyAxMiwgMjAxOCBhdCAwMTo1MTowMUFNIC0wNzAwLCBK
YW4gQmV1bGljaCB3cm90ZToNCj4+Pj4+Pj4+PiBPbiAxMi4xMi4xOCBhdCAwODowNiwgPGNoYW8u
Z2FvQGludGVsLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+IE9uIFdlZCwgRGVjIDA1LCAyMDE4IGF0IDA5
OjAxOjMzQU0gLTA1MDAsIEJvcmlzIE9zdHJvdnNreSB3cm90ZToNCj4+Pj4+Pj4+T24gMTIvNS8x
OCA0OjMyIEFNLCBSb2dlciBQYXUgTW9ubsOpIHdyb3RlOg0KPj4+Pj4+Pj4+IE9uIFdlZCwgRGVj
IDA1LCAyMDE4IGF0IDEwOjE5OjE3QU0gKzA4MDAsIENoYW8gR2FvIHdyb3RlOg0KPj4+Pj4+Pj4+
PiBJIGZpbmQgc29tZSBwYXNzLXRocnUgZGV2aWNlcyBkb24ndCB3b3JrIGFueSBtb3JlIGFjcm9z
cyBndWVzdCByZWJvb3QuDQo+Pj4+Pj4+Pj4+IEFzc2lnbmluZyBpdCB0byBhbm90aGVyIGd1ZXN0
IGFsc28gbWVldHMgdGhlIHNhbWUgaXNzdWUuIEFuZCB0aGUgb25seQ0KPj4+Pj4+Pj4+PiB3YXkg
dG8gbWFrZSBpdCB3b3JrIGFnYWluIGlzIHVuLWJpbmRpbmcgYW5kIGJpbmRpbmcgaXQgdG8gcGNp
YmFjay4NCj4+Pj4+Pj4+Pj4gU29tZW9uZSByZXBvcnRlZCB0aGlzIGlzc3VlIG9uZSB5ZWFyIGFn
byBbMV0uIE1vcmUgZGV0YWlsIGFsc28gY2FuIGJlDQo+Pj4+Pj4+Pj4+IGZvdW5kIGluIFsyXS4N
Cj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gVGhlIHJvb3QtY2F1c2UgaXMgWGVuJ3MgaW50ZXJuYWwg
TVNJLVggc3RhdGUgaXNuJ3QgcmVzZXQgcHJvcGVybHkNCj4+Pj4+Pj4+Pj4gZHVyaW5nIHJlYm9v
dCBvciByZS1hc3NpZ25tZW50LiBJbiB0aGUgYWJvdmUgY2FzZSwgWGVuIHNldCBtYXNrYWxsIGJp
dA0KPj4+Pj4+Pj4+PiB0byBtYXNrIGFsbCBNU0kgaW50ZXJydXB0cyBhZnRlciBpdCBkZXRlY3Rl
ZCBhIHBvdGVudGlhbCBzZWN1cml0eQ0KPj4+Pj4+Pj4+PiBpc3N1ZS4gRXZlbiBhZnRlciBkZXZp
Y2UgcmVzZXQsIFhlbiBkaWRuJ3QgcmVzZXQgaXRzIGludGVybmFsIG1hc2thbGwNCj4+Pj4+Pj4+
Pj4gYml0LiBBcyBhIHJlc3VsdCwgbWFza2FsbCBiaXQgd291bGQgYmUgc2V0IGFnYWluIGluIG5l
eHQgd3JpdGUgdG8NCj4+Pj4+Pj4+Pj4gTVNJLVggbWVzc2FnZSBjb250cm9sIHJlZ2lzdGVyLg0K
Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+PiBHaXZlbiB0aGF0IFBIWVNERVZPUFNfcHJlcGFyZV9tc2l4
KCkgYWxzbyB0cmlnZ2VycyBYZW4gcmVzZXR0aW5nIE1TSS1YDQo+Pj4+Pj4+Pj4+IGludGVybmFs
IHN0YXRlIG9mIGEgZGV2aWNlLCB3ZSBlbXBsb3kgaXQgdG8gZml4IHRoaXMgaXNzdWUgcmF0aGVy
IHRoYW4NCj4+Pj4+Pj4+Pj4gaW50cm9kdWNpbmcgYW5vdGhlciBkZWRpY2F0ZWQgc3ViLWh5cGVy
Y2FsbC4NCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gTm90ZSB0aGF0IFBIWVNERVZPUFNfcmVsZWFz
ZV9tc2l4KCkgd2lsbCBmYWlsIGlmIHRoZSBtYXBwaW5nIGJldHdlZW4NCj4+Pj4+Pj4+Pj4gdGhl
IGRldmljZSdzIG1zaXggYW5kIHBpcnEgaGFzIGJlZW4gY3JlYXRlZC4gVGhpcyBsaW1pdGF0aW9u
IHByZXZlbnRzDQo+Pj4+Pj4+Pj4+IHVzIGNhbGxpbmcgdGhpcyBmdW5jdGlvbiB3aGVuIGRldGFj
aGluZyBhIGRldmljZSBmcm9tIGEgZ3Vlc3QgZHVyaW5nDQo+Pj4+Pj4+Pj4+IGd1ZXN0IHNodXRk
b3duLiBUaHVzIGl0IGlzIGNhbGxlZCByaWdodCBiZWZvcmUgY2FsbGluZw0KPj4+Pj4+Pj4+PiBQ
SFlTREVWT1BTX3ByZXBhcmVfbXNpeCgpLg0KPj4+Pj4+Pj4+IHMvUEhZU0RFVk9QUy9QSFlTREVW
T1AvIChubyBmaW5hbCBTKS4gQW5kIHRoZW4gSSB3b3VsZCBhbHNvIGRyb3AgdGhlDQo+Pj4+Pj4+
Pj4gKCkgYXQgdGhlIGVuZCBvZiB0aGUgaHlwZXJjYWxsIG5hbWUgc2luY2UgaXQncyBub3QgYSBm
dW5jdGlvbi4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IEknbSBhbHNvIHdvbmRlcmluZyB3aHkgdGhl
IHJlbGVhc2UgY2FuJ3QgYmUgZG9uZSB3aGVuIHRoZSBkZXZpY2UgaXMNCj4+Pj4+Pj4+PiBkZXRh
Y2hlZCBmcm9tIHRoZSBndWVzdCAob3IgdGhlIGd1ZXN0IGhhcyBiZWVuIHNodXQgZG93bikuIFRo
aXMgbWFrZXMNCj4+Pj4+Pj4+PiBtZSB3b3JyeSBhYm91dCB0aGUgcmFjaW5lc3Mgb2YgdGhlIGF0
dGFjaC9kZXRhY2ggcHJvY2VkdXJlOiBpZiB0aGVyZSdzDQo+Pj4+Pj4+Pj4gYSBzdGF0ZSB3aGVy
ZSBwY2liYWNrIGFzc3VtZXMgdGhlIGRldmljZSBoYXMgYmVlbiBkZXRhY2hlZCBmcm9tIHRoZQ0K
Pj4+Pj4+Pj4+IGd1ZXN0LCBidXQgdGhlcmUgYXJlIHN0aWxsIHBpcnFzIGJvdW5kLCBhbiBhdHRl
bXB0IHRvIGF0dGFjaCB0bw0KPj4+Pj4+Pj4+IGFub3RoZXIgZ3Vlc3QgaW4gc3VjaCBzdGF0ZSB3
aWxsIGZhaWwuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj5JIHdvbmRlciB3aGV0aGVyIHRoaXMgYWRkaXRp
b25hbCByZXNldCBmdW5jdGlvbmFsaXR5IGNvdWxkIGJlIGRvbmUgb3V0DQo+Pj4+Pj4+Pm9mIHhl
bl9wY2lia194ZW5idXNfcmVtb3ZlKCkuIFdlIGZpcnN0IGRvIGEgKGJlc3QgZWZmb3J0KSBkZXZp
Y2UgcmVzZXQNCj4+Pj4+Pj4+YW5kIHRoZW4gZG8gdGhlIGV4dHJhIHRoaW5ncyB0aGF0IGFyZSBu
b3QgcHJvcGVybHkgZG9uZSB0aGVyZS4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IE5vLiBJdCBjYW5ub3Qg
YmUgZG9uZSBpbiB4ZW5fcGNpYmtfeGVuYnVzX3JlbW92ZSgpIHdpdGhvdXQgbW9kaWZ5aW5nDQo+
Pj4+Pj4+IHRoZSBoYW5kbGVyIG9mIFBIWVNERVZPUF9yZWxlYXNlX21zaXguIFRvIGRvIGEgc3Vj
Y2Vzc2Z1bCBYZW4gaW50ZXJuYWwNCj4+Pj4+Pj4gTVNJLVggc3RhdGUgcmVzZXQsIFBIWVNERVZP
UF97cmVsZWFzZSwgcHJlcGFyZX1fbXNpeCBzaG91bGQgYmUgZmluaXNoZWQNCj4+Pj4+Pj4gd2l0
aG91dCBlcnJvci4gQnV0IEFUTSwgeGVuIGV4cGVjdHMgdGhhdCBubyBtc2kgaXMgYm91bmQgdG8g
cGlycSB3aGVuDQo+Pj4+Pj4+IGRvaW5nIFBIWVNERVZPUF9yZWxlYXNlX21zaXguIE90aGVyd2lz
ZSBpdCBmYWlscyB3aXRoIGVycm9yIGNvZGUgLUVCVVNZLg0KPj4+Pj4+PiBIb3dldmVyLCB0aGUg
ZXhwZWN0YXRpb24gaXNuJ3QgZ3VhcmFudGVlZCBpbiB4ZW5fcGNpYmtfeGVuYnVzX3JlbW92ZSgp
Lg0KPj4+Pj4+PiBJbiBzb21lIGNhc2VzLCBpZiBxZW11IGZhaWxzIHRvIHVubWFwIE1TSXMsIE1T
SXMgYXJlIHVubWFwcGVkIGJ5IFhlbg0KPj4+Pj4+PiBhdCBsYXN0IG1pbnV0ZSwgd2hpY2ggaGFw
cGVucyBhZnRlciBkZXZpY2UgcmVzZXQgaW4gDQo+Pj4+Pj4+IHhlbl9wY2lia194ZW5idXNfcmVt
b3ZlKCkuDQo+Pj4+Pj4NCj4+Pj4+PkJ1dCB0aGF0IG1heSBuZWVkIHRha2luZyBjYXJlIG9mOiBJ
IGRvbid0IHRoaW5rIGl0IGlzIGEgZ29vZCBpZGVhIHRvIGhhdmUNCj4+Pj4+PmFueXRoaW5nIGxl
ZnQgZnJvbSB0aGUgcHJpb3Igb3duaW5nIGRvbWFpbiB3aGVuIHRoZSBkZXZpY2UgZ2V0cyByZXNl
dC4NCj4+Pj4+PkkuZS4gbGVmdCBvdmVyIElSUSBiaW5kaW5ncyBzaG91bGQgcGVyaGFwcyBiZSBm
b3JjaWJseSBjbGVhcmVkIGJlZm9yZQ0KPj4+Pj4+aW52b2tpbmcgdGhlIHJlc2V0Ow0KPj4+Pj4g
DQo+Pj4+PiBBZ3JlZS4gSG93IGFib3V0IHBjaWJhY2sgdG8gdHJhY2sgdGhlIGVzdGFibGlzaGVk
IElSUSBiaW5kaW5ncz8gVGhlbg0KPj4+Pj4gcGNpYmFjayBjYW4gY2xlYXIgaXJxIGJpbmRpbmcg
YmVmb3JlIGludm9raW5nIHRoZSByZXNldC4NCj4+Pj4NCj4+Pj5Ib3cgd291bGQgcGNpYmFjayBl
dmVuIGtub3cgb2YgdGhvc2UgbWFwcGluZ3MsIHdoZW4gaXQncyBxZW11DQo+Pj4+d2hvIGVzdGFi
bGlzaGVzIChhbmQgbWFuYWdlcykgdGhlbT8NCj4+PiANCj4+PiBJIG1lYW50IHRvIGV4cG9zZSBz
b21lIGludGVyZmFjZXMgZnJvbSBwY2liYWNrLiBBbmQgcGNpYmFjayBzZXJ2ZXMNCj4+PiBhcyB0
aGUgcHJveHkgb2YgSVJRICh1biliaW5kaW5nIEFQSXMuDQo+Pg0KPj5JZiBhdCBhbGwgcG9zc2li
bGUgd2Ugc2hvdWxkIGF2b2lkIGhhdmluZyB0byBjaGFuZ2UgbW9yZSBwYXJ0aWVzIChxZW11LA0K
Pj5saWJ4Yywga2VybmVsLCBoeXBlcnZpc29yKSB0aGFuIHJlYWxseSBuZWNlc3NhcnkuIFJlbWVt
YmVyIHRoYXQgc3VjaA0KPj5hIGJ1ZyBmaXggbWF5IHdhbnQgYmFja3BvcnRpbmcsIGFuZCBtYWtp
bmcgc3VyZSBhZmZlY3RlZCBwZW9wbGUgaGF2ZQ0KPj5hbGwgcmVsZXZhbnQgY29tcG9uZW50cyB1
cGRhdGVkIGlzIGluY3JlYXNpbmdseSBkaWZmaWN1bHQgd2l0aCB0aGVpcg0KPj5udW1iZXIgZ3Jv
d2luZy4NCj4+DQo+Pj4+Pj5pbiBmYWN0IEknZCBleHBlY3QgdGhpcyB0byBoYXBwZW4gaW4gdGhl
IGNvdXJzZSBvZg0KPj4+Pj4+ZG9tYWluIGRlc3RydWN0aW9uLCBhbmQgSSdkIGV4cGVjdCB0aGUg
ZGV2aWNlIHJlc2V0IHRvIGNvbWUgYWZ0ZXIgdGhlDQo+Pj4+Pj5kb21haW4gd2FzIGNsZWFuZWQg
dXAuIFBlcmhhcHMgc2ltcGx5IGFuIG9yZGVyaW5nIGlzc3VlIGluIHRoZSB0b29sDQo+Pj4+Pj5z
dGFjaz8NCj4+Pj4+IA0KPj4+Pj4gSSBkb24ndCB0aGluayByZXZlcnNpbmcgdGhlIHNlcXVlbmNl
cyBvZiBkZXZpY2UgcmVzZXQgYW5kIGRvbWFpbg0KPj4+Pj4gZGVzdHJ1Y3Rpb24gd291bGQgYmUg
c2ltcGxlLiBGdXJ0aGVybW9yZSwgZHVyaW5nIGRldmljZSBob3QtdW5wbHVnLA0KPj4+Pj4gZGV2
aWNlIHJlc2V0IGlzIGRvbmUgd2hlbiB0aGUgb3duZXIgaXMgYWxpdmUuIFNvIGlmIHdlIHVzZSBk
b21haW4NCj4+Pj4+IGRlc3RydWN0aW9uIHRvIGVuZm9yY2UgYWxsIGlycSBiaW5kaW5nIGNsZWFy
ZWQsIGluIHRoZW9yeSwgaXQgd29uJ3QgYmUNCj4+Pj4+IGFwcGxpY2FibGUgdG8gaG90LXVucGx1
ZyBjYXNlIChpZiBxZW11J3MgaG90LXVucGx1ZyBsb2dpYyBpcw0KPj4+Pj4gY29tcHJvbWlzZWQp
Lg0KPj4+Pg0KPj4+PkV2ZW4gaW4gdGhlIGhvdC11bnBsdWcgY2FzZSB0aGUgdG9vbCBzdGFjayBj
b3VsZCBpc3N1ZSB1bmJpbmQNCj4+Pj5yZXF1ZXN0cywgYmVoaW5kIHRoZSBiYWNrIG9mIHRoZSBw
b3NzaWJseSBjb21wcm9taXNlZCBxZW11LA0KPj4+Pm9uY2UgbmVpdGhlciB0aGUgZ3Vlc3Qgbm9y
IHFlbXUgaGF2ZSBhY2Nlc3MgdG8gdGhlIGRldmljZQ0KPj4+PmFueW1vcmUuDQo+Pj4gDQo+Pj4g
QnV0IGN1cnJlbnRseSwgdG9vbCBzdGFjayBkb2Vzbid0IGtub3cgdGhlIHJlbWFpbmluZyBJUlEg
YmluZGluZ3MuDQo+Pj4gSWYgdG9vbCBzdGFjayBjYW4gbWFpbnRhaW5lIElSUSBiaW5kaW5nIGlu
Zm9ybWF0aW9uIG9mIGEgcGFzcy10aHJ1DQo+Pj4gZGV2aWNlIChzdG9yZWQgaW4gWGVuc3RvcmU/
KSwgd2UgY2FuIGNvbWUgdXAgd2l0aCBhIGNsZWFuIHNvbHV0aW9uDQo+Pj4gd2l0aG91dCBtb2Rp
ZnlpbmcgbGludXgga2VybmVsIGFuZCBYZW4uDQo+Pg0KPj5JZiB0aGVyZSdzIG5vIHdheSBmb3Ig
dGhlIHRvb2wgc3RhY2sgdG8gZWl0aGVyIGZpbmQgb3V0IHRoZSBiaW5kaW5ncw0KPj5vciAiYmxp
bmRseSIgaXNzdWUgdW5iaW5kIHJlcXVlc3RzIChhY2NlcHRpbmcgdGhlbSB0byBmYWlsKSwgdGhl
biBhDQo+PiJ3aWxkY2FyZCIgdW5iaW5kIG9wZXJhdGlvbiBtYXkgd2FudCBhZGRpbmcuIE9yLCBw
ZXJoYXBzIGV2ZW4NCj4+YmV0dGVyLCBYRU5fRE9NQ1RMX2RlYXNzaWduX2RldmljZSBjb3VsZCB1
bmJpbmQgYW55dGhpbmcgbGVmdA0KPj5pbiBwbGFjZSBmb3IgdGhlIHNwZWNpZmllZCBkZXZpY2Uu
DQo+DQo+R29vZCBpZGVhLiBJIHdpbGwgdGFrZSB0aGlzIGFkdmljZS4NCj4NCj5UaGFua3MNCj5D
aGFvDQoNCkkgYW0gaGF2aW5nIHRoZSBzYW1lIGlzc3VlLCBhbmQgY2Fubm90IGZpbmQgYSBmaXgg
aW4gZWl0aGVyIHhlbi1wY2liYWNrIG9yIHRoZSBYZW4gY29kZWJhc2UuDQpXYXMgYSBzb2x1dGlv
biBldmVyIHB1c2hlZCBhcyBhIHJlc3VsdCBvZiB0aGlzIHRocmVhZD8NCg0KQmVzdCwNClN0YW5p
c2xhdg0KCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0
ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdl
ciwgUmFsZiBIZXJicmljaApFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVy
ZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkK
Cgo=

