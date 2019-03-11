Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CCCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244F8206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfCKQmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:42:02 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:52817 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfCKQmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:42:02 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2BGfZmN001941
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 12 Mar 2019 01:41:35 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2BGfZUk021195;
        Tue, 12 Mar 2019 01:41:35 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2BGfZVb010851;
        Tue, 12 Mar 2019 01:41:35 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.138] [10.38.151.138]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-3232926; Tue, 12 Mar 2019 01:40:32 +0900
Received: from BPXM09GP.gisp.nec.co.jp ([10.38.151.201]) by
 BPXC10GP.gisp.nec.co.jp ([10.38.151.138]) with mapi id 14.03.0319.002; Tue,
 12 Mar 2019 01:40:31 +0900
From:   Kazuhito Hagio <k-hagio@ab.jp.nec.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        kexec-ml <kexec@lists.infradead.org>,
        "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v2] makedumpfile: exclude pages that are logically
 offline
Thread-Topic: [PATCH v2] makedumpfile: exclude pages that are logically
 offline
Thread-Index: AQHUgkt9RCAzPwtH6E+Mr2lxoeU83qVig1dAgJ1kP4CAB2P8UA==
Date:   Mon, 11 Mar 2019 16:40:30 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03569C9C@BPXM09GP.gisp.nec.co.jp>
References: <20181122100627.5189-1-david@redhat.com>
 <20181122100938.5567-1-david@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03561800@BPXM09GP.gisp.nec.co.jp>
 <7c9d6d5c-d6cf-00a7-7f23-bf28cbb382af@redhat.com>
In-Reply-To: <7c9d6d5c-d6cf-00a7-7f23-bf28cbb382af@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.101.135.136]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gT24gMjcuMTEuMTggMTc6MzIsIEthenVoaXRv
IEhhZ2lvIHdyb3RlOg0KPiA+PiBMaW51eCBtYXJrcyBwYWdlcyB0aGF0IGFyZSBsb2dpY2FsbHkg
b2ZmbGluZSB2aWEgYSBwYWdlIGZsYWcgKG1hcCBjb3VudCkuDQo+ID4+IFN1Y2ggcGFnZXMgZS5n
LiBpbmNsdWRlIHBhZ2VzIGluZmF0ZWQgYXMgcGFydCBvZiBhIGJhbGxvb24gZHJpdmVyIG9yDQo+
ID4+IHBhZ2VzIHRoYXQgd2VyZSBub3QgYWN0dWFsbHkgb25saW5lZCB3aGVuIG9ubGluaW5nIHRo
ZSB3aG9sZSBzZWN0aW9uLg0KPiA+Pg0KPiA+PiBXaGlsZSB0aGUgaHlwZXJ2aXNvciB1c3VhbGx5
IGFsbG93cyB0byByZWFkIHN1Y2ggaW5mbGF0ZWQgbWVtb3J5LCB3ZQ0KPiA+PiBiYXNpY2FsbHkg
cmVhZCBhbmQgZHVtcCBkYXRhIHRoYXQgaXMgY29tcGxldGVseSBpcnJlbGV2YW50LiBBbHNvLCB0
aGlzDQo+ID4+IG1pZ2h0IHJlc3VsdCBpbiBxdWl0ZSBzb21lIG92ZXJoZWFkIGluIHRoZSBoeXBl
cnZpc29yLiBJbiBhZGRpdGlvbiwNCj4gPj4gd2Ugc2F3IHNvbWUgcHJvYmxlbXMgdW5kZXIgSHlw
ZXItViwgd2hlcmVieSB3ZSBjYW4gY3Jhc2ggdGhlIGtlcm5lbCBieQ0KPiA+PiBkdW1waW5nLCB3
aGVuIHJlYWRpbmcgbWVtb3J5IG9mIGEgcGFydGlhbGx5IG9ubGluZWQgbWVtb3J5IHNlZ21lbnQN
Cj4gPj4gKGZvciBtZW1vcnkgYWRkZWQgYnkgdGhlIEh5cGVyLVYgYmFsbG9vbiBkcml2ZXIpLg0K
PiA+Pg0KPiA+PiBUaGVyZWZvcmUsIGRvbid0IHJlYWQgYW5kIGR1bXAgcGFnZXMgdGhhdCBhcmUg
bWFya2VkIGFzIGJlaW5nIGxvZ2ljYWxseQ0KPiA+PiBvZmZsaW5lLg0KPiA+Pg0KPiA+PiBTaWdu
ZWQtb2ZmLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gPg0KPiA+
IFRoYW5rcyBmb3IgdGhlIHYyIHVwZGF0ZS4NCj4gPiBJJ20gZ29pbmcgdG8gbWVyZ2UgdGhpcyBw
YXRjaCBhZnRlciB0aGUga2VybmVsIHBhdGNoZXMgYXJlIG1lcmdlZA0KPiA+IGFuZCBpdCB0ZXN0
cyBmaW5lIHdpdGggdGhlIGtlcm5lbC4NCj4gPg0KPiA+IEthenUNCj4gDQo+IEhpIEthenUsDQo+
IA0KPiB0aGUgcGF0Y2hlcyBhcmUgbm93IHVwc3RyZWFtLiBUaGFua3MhDQoNClRlc3RlZCBPSyBh
dCBteSBlbmQsIHRvby4gQXBwbGllZCB0byB0aGUgZGV2ZWwgYnJhbmNoLg0KDQogICAgT2ZmbGlu
ZSBwYWdlcyAgICAgICAgICAgOiAweDAwMDAwMDAwMDAwMDI0MDANCg0KVGhhbmsgeW91IQ0KS2F6
dQ0KDQo+IA0KPiAtLQ0KPiANCj4gVGhhbmtzLA0KPiANCj4gRGF2aWQgLyBkaGlsZGVuYg0KDQo=

