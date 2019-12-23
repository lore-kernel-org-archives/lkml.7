Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CE8C2D0C8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 01:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367F4206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 01:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uynViSAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLWBxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 20:53:45 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:57211 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfLWBxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 20:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1577066024; x=1608602024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+wko5RT25RxW2zeycjxSO5Xakzc/zM0/ZUap54jab14=;
  b=uynViSAktnp2WPcHnZCDRveb7lE3Si6+CLRmTGzYuTs9kgNzePsZKR9V
   /ANwZmXjJfIyOziJ+NDN3fdZouLKHgpT1OeyfyeBrjIRRb/3a8OzztcMH
   OJsE7p6yV/PCyvEtz7G21QRJ9sLM7g7m1ihxLf4jlCO+g5oyxd0hwAB+2
   A=;
IronPort-SDR: 7ryDAeCaJipu6dr1NaTh+ZQLiiweTV1ev5z/mCxhwEP8xXivmZ2jz53XmcMjjVnp4eJofiUsxM
 2R2IthzTw2WQ==
X-IronPort-AV: E=Sophos;i="5.69,346,1571702400"; 
   d="scan'208";a="9713435"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 23 Dec 2019 01:53:42 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id A8E2CA23BF;
        Mon, 23 Dec 2019 01:53:41 +0000 (UTC)
Received: from EX13D11UWB003.ant.amazon.com (10.43.161.206) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Dec 2019 01:53:41 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D11UWB003.ant.amazon.com (10.43.161.206) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Dec 2019 01:53:40 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Mon, 23 Dec 2019 01:53:40 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "=linux-block@vger.kernel.org" <=linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Sangaraju, Someswarudu" <ssomesh@amazon.com>
Subject: Re: [RFC PATCH 1/5] block/genhd: Notify udev about capacity change
Thread-Topic: [RFC PATCH 1/5] block/genhd: Notify udev about capacity change
Thread-Index: AQHVuTIQS2D+6UASEUSut4lHWyy8r6fG9TQA
Date:   Mon, 23 Dec 2019 01:53:40 +0000
Message-ID: <e452f6a638fe09f065b9e4cd1c25d5d3a2f29e5a.camel@amazon.com>
References: <20191223014056.17318-1-sblbir@amazon.com>
In-Reply-To: <20191223014056.17318-1-sblbir@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.78]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7D314F84E432C468D7F28186EDB3776@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTEyLTIzIGF0IDAxOjQwICswMDAwLCBCYWxiaXIgU2luZ2ggd3JvdGU6DQo+
IEFsbG93IGJsb2NrL2dlbmhkIHRvIG5vdGlmeSB1c2VyIHNwYWNlICh2aWEgdWRldikgYWJvdXQg
ZGlzayBzaXplIGNoYW5nZXMNCj4gdXNpbmcgYSBuZXcgaGVscGVyIGRpc2tfc2V0X2NhcGFjaXR5
KCksIHdoaWNoIGlzIGEgd3JhcHBlciBvbiB0b3ANCj4gb2Ygc2V0X2NhcGFjaXR5KCkuIGRpc2tf
c2V0X2NhcGFjaXR5KCkgd2lsbCBvbmx5IG5vdGlmeSB2aWEgdWRldiBpZg0KPiB0aGUgY3VycmVu
dCBjYXBhY2l0eSBvciB0aGUgdGFyZ2V0IGNhcGFjaXR5IGlzIG5vdCB6ZXJvLg0KPiANCj4gQmFj
a2dyb3VuZDoNCj4gDQo+IEFzIGEgcGFydCBvZiBhIHBhdGNoIHRvIGFsbG93IHNlbmRpbmcgdGhl
IFJFU0laRSBldmVudCBvbiBkaXNrIGNhcGFjaXR5DQo+IGNoYW5nZSwgQ2hyaXN0b3BoIChoY2hA
bHN0LmRlKSByZXF1ZXN0ZWQgdGhhdCB0aGUgcGF0Y2ggYmUgbWFkZSBnZW5lcmljDQo+IGFuZCB0
aGUgaGFja3MgZm9yIHZpcnRpbyBibG9jayBhbmQgeGVuIGJsb2NrIGRldmljZXMgYmUgcmVtb3Zl
ZCBhbmQNCj4gbWVyZ2VkIHZpYSBhIGdlbmVyaWMgaGVscGVyLg0KPiANCj4gDQoNCkkgbWVzc2Vk
IHVwIHdpdGggbGludXgtYmxvY2sgTUwgYWRkcmVzcywgSSBjYW4gcmVzZW5kIHdpdGggdGhlIHJp
Z2h0IGFkZHJlc3MNCmlmIG5lZWRlZC4gTXkgYXBvbG9naWVzDQoNCkJhbGJpciBTaW5naC4NCg==
