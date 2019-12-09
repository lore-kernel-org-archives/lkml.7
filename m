Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65B5C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A31D2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JlJmb3pd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfLIMEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:04:14 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:7105 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLIMEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575893052; x=1607429052;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8AECTFICSyM5s/Ut1CazRsEgSzhmj8Neeu19wKVW8Qs=;
  b=JlJmb3pdRHmui1w1hbePrs9nzrDFG4RLMnDZTX2mG+ZQvyYwSieriW4l
   nGSBnl/G/ZBgzK7w4GoeU/1W1lI8zxcSawA9e30fBmCX9FU5Be77x0kom
   w6pCrroScjqjqjNeBqEYbEwtu054FQKbLlwwf8NBi/TCQhuyN2jOzpTzC
   E=;
IronPort-SDR: rxRvUi+UywRuZk0+seSZDRlQZu/1IiRYbjPHUaFz3HJAOPm0l+qwvctWEFEG00kVUENUykWkxR
 nJWyhetsMfVA==
X-IronPort-AV: E=Sophos;i="5.69,294,1571702400"; 
   d="scan'208";a="13791202"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 09 Dec 2019 12:03:58 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 60AEAA2144;
        Mon,  9 Dec 2019 12:03:56 +0000 (UTC)
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 12:03:55 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D32EUC003.ant.amazon.com (10.43.164.24) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 12:03:54 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Mon, 9 Dec 2019 12:03:54 +0000
From:   "Durrant, Paul" <pdurrant@amazon.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: RE: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
 closed
Thread-Topic: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
 closed
Thread-Index: AQHVq3SCoU35oX1INEGjFwMD1PQM5aexs7UAgAAEWoCAAAHxUA==
Date:   Mon, 9 Dec 2019 12:03:54 +0000
Message-ID: <3412e42d13224b6786613e58dc189ebf@EX13D32EUC003.ant.amazon.com>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-3-pdurrant@amazon.com>
 <20191209113926.GS980@Air-de-Roger>
 <b8a138ad-5770-65fa-f368-f7b4063702fa@suse.com>
In-Reply-To: <b8a138ad-5770-65fa-f368-f7b4063702fa@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.211]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKw7xyZ2VuIEdyb8OfIDxqZ3Jv
c3NAc3VzZS5jb20+DQo+IFNlbnQ6IDA5IERlY2VtYmVyIDIwMTkgMTE6NTUNCj4gVG86IFJvZ2Vy
IFBhdSBNb25uw6kgPHJvZ2VyLnBhdUBjaXRyaXguY29tPjsgRHVycmFudCwgUGF1bA0KPiA8cGR1
cnJhbnRAYW1hem9uLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHhl
bi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZzsgU3RlZmFubw0KPiBTdGFiZWxsaW5pIDxzc3Rh
YmVsbGluaUBrZXJuZWwub3JnPjsgQm9yaXMgT3N0cm92c2t5DQo+IDxib3Jpcy5vc3Ryb3Zza3lA
b3JhY2xlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtYZW4tZGV2ZWxdIFtQQVRDSCAyLzRdIHhlbmJ1
czogbGltaXQgd2hlbiBzdGF0ZSBpcyBmb3JjZWQgdG8NCj4gY2xvc2VkDQo+IA0KPiBPbiAwOS4x
Mi4xOSAxMjozOSwgUm9nZXIgUGF1IE1vbm7DqSB3cm90ZToNCj4gPiBPbiBUaHUsIERlYyAwNSwg
MjAxOSBhdCAwMjowMToyMVBNICswMDAwLCBQYXVsIER1cnJhbnQgd3JvdGU6DQo+ID4+IE9ubHkg
Zm9yY2Ugc3RhdGUgdG8gY2xvc2VkIGluIHRoZSBjYXNlIHdoZW4gdGhlIHRvb2xzdGFjayBtYXkg
bmVlZCB0bw0KPiA+PiBjbGVhbiB1cC4gVGhpcyBjYW4gYmUgZGV0ZWN0ZWQgYnkgY2hlY2tpbmcg
d2hldGhlciB0aGUgc3RhdGUgaW4NCj4geGVuc3RvcmUNCj4gPj4gaGFzIGJlZW4gc2V0IHRvIGNs
b3NpbmcgcHJpb3IgdG8gZGV2aWNlIHJlbW92YWwuDQo+ID4NCj4gPiBJJ20gbm90IHN1cmUgSSBz
ZWUgdGhlIHBvaW50IG9mIHRoaXMsIEkgd291bGQgZXhwZWN0IHRoYXQgYSBmYWlsdXJlIHRvDQo+
ID4gcHJvYmUgb3IgdGhlIHJlbW92YWwgb2YgdGhlIGRldmljZSB3b3VsZCBsZWF2ZSB0aGUgeGVu
YnVzIHN0YXRlIGFzDQo+ID4gY2xvc2VkLCB3aGljaCBpcyBjb25zaXN0ZW50IHdpdGggdGhlIGFj
dHVhbCBkcml2ZXIgc3RhdGUuDQo+ID4NCj4gPiBDYW4geW91IGV4cGxhaW4gd2hhdCdzIHRoZSBi
ZW5lZml0IG9mIGxlYXZpbmcgYSBkZXZpY2Ugd2l0aG91dCBhDQo+ID4gZHJpdmVyIGluIHN1Y2gg
dW5rbm93biBzdGF0ZT8NCj4gDQo+IEFuZCBtb3JlIGNvbmNlcm5pbmc6IGRpZCB5b3UgY2hlY2sg
dGhhdCBubyBmcm9udGVuZC9iYWNrZW5kIGlzDQo+IHJlbHlpbmcgb24gdGhlIGNsb3NlZCBzdGF0
ZSB0byBiZSB2aXNpYmxlIHdpdGhvdXQgY2xvc2luZyBoYXZpbmcgYmVlbg0KPiBzZXQgYmVmb3Jl
Pw0KDQpCbGtmcm9udCBkb2Vzbid0IHNlZW0gdG8gbWluZCBhbmQgSSBiZWxpZXZlIHRoZSBXaW5k
b3dzIFBWIGRyaXZlcnMgY29wZSwgYnV0IEkgZG9uJ3QgcmVhbGx5IHVuZGVyc3RhbmQgdGhlIGNv
bW1lbnQgc2luY2UgdGhpcyBwYXRjaCBpcyBhY3R1YWxseSByZW1vdmluZyBhIGNhc2Ugd2hlcmUg
dGhlIGJhY2tlbmQgdHJhbnNpdGlvbnMgZGlyZWN0bHkgdG8gY2xvc2VkLg0KDQogIFBhdWwNCg0K
PiANCj4gDQo+IEp1ZXJnZW4NCg0K
