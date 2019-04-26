Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506AFC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F830208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfDZP3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:29:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37656 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfDZP3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:29:48 -0400
Received: from localhost (unknown [12.154.31.190])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 46883145E49C8;
        Fri, 26 Apr 2019 08:29:48 -0700 (PDT)
Date:   Fri, 26 Apr 2019 11:29:46 -0400 (EDT)
Message-Id: <20190426.112946.1319839231077035351.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org
Subject: Re: [PATCH net-next] cnic: Refactor code and mark expected switch
 fall-through
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190424163732.GA12492@embeddedor>
References: <20190424163732.GA12492@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 26 Apr 2019 08:29:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIkd1c3Rhdm8gQS4gUi4gU2lsdmEiIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KRGF0
ZTogV2VkLCAyNCBBcHIgMjAxOSAxMTozNzozMiAtMDUwMA0KDQo+IEluIHByZXBhcmF0aW9uIHRv
IGVuYWJsaW5nIC1XaW1wbGljaXQtZmFsbHRocm91Z2gsIHJlZmFjdG9yIGNvZGUgYQ0KPiBiaXQg
YW5kIG1hcmsgc3dpdGNoIGNhc2VzIHdoZXJlIHdlIGFyZSBleHBlY3RpbmcgdG8gZmFsbCB0aHJv
dWdoLg0KPiANCj4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgZm9sbG93aW5nIHdhcm5pbmc6DQo+IA0K
PiBkcml2ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNvbS9jbmljLmM6IEluIGZ1bmN0aW9uIKFjbmlj
X2NtX3Byb2Nlc3Nfa2NxZaI6DQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2Jyb2FkY29tL2NuaWMu
Yzo0MDQ0OjExOiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFstV2lt
cGxpY2l0LWZhbGx0aHJvdWdoPV0NCj4gICAgIG9wY29kZSA9IEw0X0tDUUVfT1BDT0RFX1ZBTFVF
X0NMT1NFX0NPTVA7DQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2Jyb2FkY29tL2NuaWMuYzo0MDUw
OjI6IG5vdGU6IGhlcmUNCj4gICBjYXNlIEw0X0tDUUVfT1BDT0RFX1ZBTFVFX1JFU0VUX1JFQ0VJ
VkVEOg0KPiAgIF5+fn4NCj4gDQo+IFdhcm5pbmcgbGV2ZWwgMyB3YXMgdXNlZDogLVdpbXBsaWNp
dC1mYWxsdGhyb3VnaD0zDQo+IA0KPiBOb3RpY2UgdGhhdCwgaW4gdGhpcyBwYXJ0aWN1bGFyIGNh
c2UsIHRoZSBjb2RlIGNvbW1lbnQgaXMgbW9kaWZpZWQNCj4gaW4gYWNjb3JkYW5jZSB3aXRoIHdo
YXQgR0NDIGlzIGV4cGVjdGluZyB0byBmaW5kLg0KPiANCj4gVGhpcyBwYXRjaCBpcyBwYXJ0IG9m
IHRoZSBvbmdvaW5nIGVmZm9ydHMgdG8gZW5hYmxlDQo+IC1XaW1wbGljaXQtZmFsbHRocm91Z2gu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvQGVtYmVk
ZGVkb3IuY29tPg0KDQpBcHBsaWVkLg0K
