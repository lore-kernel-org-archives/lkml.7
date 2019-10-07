Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBDAC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8A420867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QiiJnrk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbfJGWLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 18:11:31 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:22513 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfJGWLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 18:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570486290; x=1602022290;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=fwumaDoNR8/M5OTVKavfEmL4UPE4WrZDuS1OgsLehDw=;
  b=QiiJnrk0fnzI2yvM3AprnDHnufkkjl7+zdvn3NTS01JG+nglO6uaZ3Em
   nlqJVfHGyUzhhPC7VqYYojE9u8MU9TDdyYC81BRv4GdB6GFaqvUVicoUV
   9dJtyXHTJsn/knupXouhKuDFqfrsKa6V9n9iZ2IpLTQbpnDQj7Uo1hH7a
   E=;
X-IronPort-AV: E=Sophos;i="5.67,269,1566864000"; 
   d="scan'208";a="420684493"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 07 Oct 2019 22:11:28 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id ACA92A212F;
        Mon,  7 Oct 2019 22:11:27 +0000 (UTC)
Received: from EX13D01UWB001.ant.amazon.com (10.43.161.75) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 7 Oct 2019 22:11:27 +0000
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13d01UWB001.ant.amazon.com (10.43.161.75) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 7 Oct 2019 22:11:26 +0000
Received: from EX13D01UWB003.ant.amazon.com ([10.43.161.94]) by
 EX13d01UWB003.ant.amazon.com ([10.43.161.94]) with mapi id 15.00.1367.000;
 Mon, 7 Oct 2019 22:11:26 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "tyaramer@gmail.com" <tyaramer@gmail.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: Shutdown when removing dead controller
Thread-Topic: [PATCH] nvme-pci: Shutdown when removing dead controller
Thread-Index: AQHVfVwpGhwUwA6X9kWpqedn8pc+zg==
Date:   Mon, 7 Oct 2019 22:11:26 +0000
Message-ID: <7042458bf65523747514c98db36ceaa5fa390679.camel@amazon.com>
References: <20191003191354.GA4481@Serenity>
In-Reply-To: <20191003191354.GA4481@Serenity>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.7]
Content-Type: text/plain; charset="utf-8"
Content-ID: <95C8F61E4CD0D44AAB11CB3984C122A6@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTEwLTAzIGF0IDE1OjEzIC0wNDAwLCBUeWxlciBSYW1lciB3cm90ZToNCj4g
QWx3YXlzIHNodXRkb3duIHRoZSBjb250cm9sbGVyIHdoZW4gbnZtZV9yZW1vdmVfZGVhZF9jb250
cm9sbGVyIGlzDQo+IHJlYWNoZWQuDQo+IA0KPiBJdCdzIHBvc3NpYmxlIGZvciBudm1lX3JlbW92
ZV9kZWFkX2NvbnRyb2xsZXIgdG8gYmUgY2FsbGVkIGFzIHBhcnQgb2YgYQ0KPiBmYWlsZWQgcmVz
ZXQsIHdoZW4gdGhlcmUgaXMgYSBiYWQgTlZNRV9DU1RTLiBUaGUgY29udHJvbGxlciB3b24ndA0K
PiBiZSBjb21taW5nIGJhY2sgb25saW5lLCBzbyB3ZSBzaG91bGQgc2h1dCBpdCBkb3duIHJhdGhl
ciB0aGFuIGp1c3QNCj4gZGlzYWJsaW5nLg0KPiANCg0KSSB3b3VsZCBhZGQgdGhhdCBudm1lX3Rp
bWVvdXQoKSB3b3VsZCBnbyB0aHJvdWdoIHRoZSBudm1lX3Nob3VsZF9yZXNldCgpIHBhdGgNCndo
ZXJlIHdlIGRvbid0IHNodXRkb3duIHRoZSBkZXZpY2UgZHVyaW5nIG52bWVfZGV2X2Rpc2FibGUs
IGl0IG1ha2VzIHNlbnNlIHRvDQpkbyBhIGZ1bGwgc2h1dGRvd24gZHVyaW5nIG52bWVfcmVtb3Zl
X2RlYWxfY3RybCB3b3JrKCkgd2hlbiByZXNldCBmYWlscy4NCg0KDQoNCj4gU2lnbmVkLW9mZi1i
eTogVHlsZXIgUmFtZXIgPHR5YXJhbWVyQGdtYWlsLmNvbT4NCj4gLS0tDQoNClJldmlld2VkLWJ5
OiBCYWxiaXIgU2luZ2ggPHNibGJpckBhbWF6b24uY29tPg0KDQo+ICBkcml2ZXJzL252bWUvaG9z
dC9wY2kuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIGIvZHJp
dmVycy9udm1lL2hvc3QvcGNpLmMNCj4gaW5kZXggYzA4MDhmOWViOGFiLi5jM2Y1YmEyMmM2MjUg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jDQo+ICsrKyBiL2RyaXZlcnMv
bnZtZS9ob3N0L3BjaS5jDQo+IEBAIC0yNTA5LDcgKzI1MDksNyBAQCBzdGF0aWMgdm9pZCBudm1l
X3BjaV9mcmVlX2N0cmwoc3RydWN0IG52bWVfY3RybCAqY3RybCkNCj4gIHN0YXRpYyB2b2lkIG52
bWVfcmVtb3ZlX2RlYWRfY3RybChzdHJ1Y3QgbnZtZV9kZXYgKmRldikNCj4gIHsNCj4gIAludm1l
X2dldF9jdHJsKCZkZXYtPmN0cmwpOw0KPiAtCW52bWVfZGV2X2Rpc2FibGUoZGV2LCBmYWxzZSk7
DQo+ICsJbnZtZV9kZXZfZGlzYWJsZShkZXYsIHRydWUpOw0KPiAgCW52bWVfa2lsbF9xdWV1ZXMo
JmRldi0+Y3RybCk7DQo+ICAJaWYgKCFxdWV1ZV93b3JrKG52bWVfd3EsICZkZXYtPnJlbW92ZV93
b3JrKSkNCj4gIAkJbnZtZV9wdXRfY3RybCgmZGV2LT5jdHJsKTsNCg==
