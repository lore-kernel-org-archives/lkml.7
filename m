Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515ABC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED0120665
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="B7cawGbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfHFFdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 01:33:01 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:52744 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFFdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:33:01 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 909F1806B6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2019 17:32:58 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1565069578;
        bh=9EkglKTtMXOxdDieRj8LBKkvP9cd9hJQy2kWMZQR37E=;
        h=From:To:Subject:Date;
        b=B7cawGbXXXVSNRYB53DmNSoNOTLpLY6m/2po3fUJN7oSZ5K9eMqwwHd/EL5Uk70jF
         pTi63EcrnEau5KnLttSMM+jdLBX4tMd86UxtNZ175nXgDEU5/z9chywkUPH3MWntBC
         Z2ZMAQSw2deYlM93yEPnrhr4plkXYQBAqoMmE7ZtT6A0LTBtbM1mjjfXEyFTZvp/Jg
         2e/Zl67vXvCy4nns8C5qkkyVcvUY96BTsCOYNnwNoT+oRd5iTM6QPhQZnWXqXzRQ45
         uK0MeAwFfj08o++OIbDBjmZuUQdtpc/ZOJya8Z2+Bwl/gc1ecjJcElj6ZIU825p6h6
         wcibWMlfNcloA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d49110b0000>; Tue, 06 Aug 2019 17:32:59 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Tue, 6 Aug 2019 17:32:58 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Tue, 6 Aug 2019 17:32:58 +1200
From:   Chun Wang <Chun.Wang@alliedtelesis.co.nz>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Source address selection for ICMP error message
Thread-Topic: Source address selection for ICMP error message
Thread-Index: AQHVTBhnuxpHXsTkZ0+DEEQi3XdQjg==
Date:   Tue, 6 Aug 2019 05:32:57 +0000
Message-ID: <1565069577.1493.29.camel@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:13:1809:e856:f83a:c60f]
Content-Type: text/plain; charset="utf-8"
Content-ID: <52E3626162737548A5670BAE8B509A56@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgYWxsDQoNCkkndmUgZ290IDIgdW5pdHMgbmV0d29yazoNCg0KKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0rDQp8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8DQp8
dmxhbjIzOjE3Mi4xNi4yMy4yLzI0IHwNCistLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHwNCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8DQrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgfA0KKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQp8VlJGIGxvMcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHwNCnx2bGFuMjA6IDE3Mi4xNi4yMC4xLzI0fA0KfHZsYW4yMTog
MTcyLjE2LjIxLjEvMjR8DQp8dmxhbjIyOiAxNzIuMTYuMjIuMS8yNHwNCnx2bGFuMjM6IDE3Mi4x
Ni4yMy4xLzI0fA0KfHZsYW4yNDogMTcyLjE2LjI0LjEvMjR8DQp8wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8DQp8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB8DQorLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCg0KSW50ZXJmYWNl
IHZsYW4yMCx2bGFuMjEsdmxhbjIyLHZsYW4yMyBhbmQgdmxhbjI0IGFyZSBlbnNsYXZlZCBpbiBW
UkYgb24NCm9uZSBvZiB0aGUgdW5pdC4NCg0KI2lwIHJvdXRlIHNob3cgdnJmIGxvMQ0KMTcyLjE2
LjIwLjAvMjQgZGV2IHZsYW4yMCBwcm90byBrZXJuZWwgc2NvcGUgbGluayBzcmMgMTcyLjE2LjIw
LjHCoA0KMTcyLjE2LjIxLjAvMjQgZGV2IHZsYW4yMSBwcm90byBrZXJuZWwgc2NvcGUgbGluayBz
cmMgMTcyLjE2LjIxLjHCoA0KMTcyLjE2LjIyLjAvMjQgZGV2IHZsYW4yMiBwcm90byBrZXJuZWwg
c2NvcGUgbGluayBzcmMgMTcyLjE2LjIyLjHCoA0KMTcyLjE2LjIzLjAvMjQgZGV2IHZsYW4yMyBw
cm90byBrZXJuZWwgc2NvcGUgbGluayBzcmMgMTcyLjE2LjIzLjHCoA0KMTcyLjE2LjI0LjAvMjQg
ZGV2IHZsYW4yNCBwcm90byBrZXJuZWwgc2NvcGUgbGluayBzcmMgMTcyLjE2LjI0LjHCoA0KDQpX
aGVuIEkgcGluZyAxNzIuMTYuMjIuNCBhbmQgMi4yLjIuMiBmcm9tIDE3Mi4xNi4yMy4yLiBUaGUg
c291cmNlDQphZGRyZXNzIG9mIHRoZSBpY21wIGVycm9yIGlzIDE3Mi4xNi4yMC4xLCBub3QgMTcy
LjE2LjIzLjEgd2hpY2ggSQ0KZXhwZWN0ZWQuwqANCg0KI3BpbmcgMTcyLjE2LjI0LjUgwqAgwqDC
oA0KUElORyAxNzIuMTYuMjQuNSAoMTcyLjE2LjI0LjUpIDU2KDg0KSBieXRlcyBvZiBkYXRhLg0K
RnJvbSAxNzIuMTYuMjAuMSBpY21wX3NlcT0xIERlc3RpbmF0aW9uIEhvc3QgVW5yZWFjaGFibGUg
wqDCoA0KRnJvbSAxNzIuMTYuMjAuMSBpY21wX3NlcT0yIERlc3RpbmF0aW9uIEhvc3QgVW5yZWFj
aGFibGUNCkZyb20gMTcyLjE2LjIwLjEgaWNtcF9zZXE9MyBEZXN0aW5hdGlvbiBIb3N0IFVucmVh
Y2hhYmxlDQpGcm9tIDE3Mi4xNi4yMC4xIGljbXBfc2VxPTQgRGVzdGluYXRpb24gSG9zdCBVbnJl
YWNoYWJsZQ0KRnJvbSAxNzIuMTYuMjAuMSBpY21wX3NlcT01IERlc3RpbmF0aW9uIEhvc3QgVW5y
ZWFjaGFibGUNCg0KI3BpbmcgMi4yLjIuMiDCoCDCoCDCoCDCoMKgDQpQSU5HIDIuMi4yLjIgKDIu
Mi4yLjIpIDU2KDg0KSBieXRlcyBvZiBkYXRhLg0KRnJvbSAxNzIuMTYuMjAuMSBpY21wX3NlcT0x
IERlc3RpbmF0aW9uIE5ldCBVbnJlYWNoYWJsZQ0KRnJvbSAxNzIuMTYuMjAuMSBpY21wX3NlcT0y
IERlc3RpbmF0aW9uIE5ldCBVbnJlYWNoYWJsZQ0KRnJvbSAxNzIuMTYuMjAuMSBpY21wX3NlcT0z
IERlc3RpbmF0aW9uIE5ldCBVbnJlYWNoYWJsZQ0KRnJvbSAxNzIuMTYuMjAuMSBpY21wX3NlcT00
IERlc3RpbmF0aW9uIE5ldCBVbnJlYWNoYWJsZQ0KDQpUaGUgdW5pdHMgaGF2ZSBsaW51eCB2ZXJz
aW9uIDQuNC42IGFuZA0KInN5c2N0bF9pY21wX2Vycm9yc191c2VfaW5ib3VuZF9pZmFkZHIiIGlz
IHNldCB0byAxKHRoaXMgaXMgcmVxdWlyZWQNCmFuZCBJIGhhdmUgbm8gaW50ZW50aW9uIHRvIGNo
YW5nZSB0aGlzKS7CoA0KDQpJcyB0aGUgc291cmNlIGFkZHJlc3Mgc2VsZWN0aW9uIGluIHRoaXMg
Y2FzZSBjb3JyZWN0PyBXaWxsIHRoZSBsYXRlc3QNCmludXggdmVyc2lvbiByZXR1cm4gMTcyLjE2
LjIzLjEgaW5zdGVhZCBvZiAxNzIuMTYuMjAuMSBpbiB0aGlzIGNhc2U/IElmDQpub3QsIHdoYXQn
cyB0aGUgYmVzdCB3YXkgdG8gc29sdmUgdGhpcz8NCg0KSSBoYXZlbid0IHN1YnNjcmliZWQgdG8g
dGhpcyBsaXN0IHlldCwgcGxlYXNlIENDIG1lIHRoZQ0KYW5zd2Vycy9jb21tZW50cy7CoA0KDQpU
aGFua3MgZm9yIHlvdXIgaGVscCwNCkNodW4=
