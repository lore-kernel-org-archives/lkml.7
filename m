Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC80C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF97206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="B1dKCqi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfDCQeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:34:06 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:57344 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCQeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:34:06 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id D9FA110C1B04;
        Wed,  3 Apr 2019 09:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1554309245; bh=KMPaJnKdpeECMMTWpSAagOQwbWS5+N/nJVWgI2pIBRM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=B1dKCqi/wfHkauziyTHv3Lyg7VzHzNJsYbQ+8Y9JpCCKbkQ2ObaTMINCE167xK5tY
         cEcoet/6LghnyXP9e6zDfQPvrSixmBu/Gb175IGCH9u2dRK1R+VgXE0ri7hvLhKVhQ
         HvshsCOUcvihH94wIhJcBXWCncgKH/fdkduiGZDpoQADleCuLsjeMOXI9vTMPrLQqH
         YpDW6iqqbiw5tPDFnFzWW8/IwQ0nVubb9lXSSEdq3BFiQKb1v3d2To4hIO0Uq6mqt5
         YSKUcAhKQGjJaSHrg9Q4iQXCMzIZEcnLmJQFHDAo54TrrxptGT3ovjh1/FFg3IU6Kq
         z2PztkVv+JE7Q==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 942CFA0062;
        Wed,  3 Apr 2019 16:34:05 +0000 (UTC)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 3 Apr 2019 09:34:05 -0700
Received: from DE02WEMBXA.internal.synopsys.com ([fe80::a014:7216:77d:d55c])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 3 Apr 2019 18:34:02 +0200
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC: [hsdk] Make it easier to add PAE40 region to DTB
Thread-Topic: [PATCH] ARC: [hsdk] Make it easier to add PAE40 region to DTB
Thread-Index: AQHU6YjVkC3kTPTpzkiiVHKQ83ImE6YqgX2A
Date:   Wed, 3 Apr 2019 16:34:02 +0000
Message-ID: <1554309241.2797.20.camel@synopsys.com>
References: <1554232683-8173-1-git-send-email-vgupta@synopsys.com>
In-Reply-To: <1554232683-8173-1-git-send-email-vgupta@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.106]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B51DCB34F108974F94658F970DA928EC@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluZWV0LA0KDQpPbiBUdWUsIDIwMTktMDQtMDIgYXQgMTI6MTggLTA3MDAsIFZpbmVldCBH
dXB0YSB3cm90ZToNCj4gMS4gQnVtcCB0b3AgbGV2ZWwgYWRkcmVzcy1jZWxscy9zaXplLWNlbGxz
IG5vZGVzIHRvIDIgKHRvIGVuc3VyZSBhbGwNCj4gICAgZG93biBzdHJlYW0gYWRkcmVzc2VzIGFy
ZSA2NC1iaXRzLCB1bmxlc3MgZXhwbGljaXRseSBzcGVjaWZpZWQNCj4gICAgb3RoZXJ3aXNlIChp
biAic29jIiBidXMgd2l0aCBhbGwgcGVyaXBoZXJhbHMpDQo+IA0KPiAyLiAibWVtb3J5IiBhbHNv
IHNwZWNpZmllZCB3aXRoIGFkZHJlc3Mvc2l6ZSAyDQo+IA0KPiAzLiBBZGQgYSBjb21tZW50ZWQg
cmVmZXJlbmNlIGZvciBQQUU0MCByZWdpb24gYmV5b25kIDRHQiBwaHlzaWNhbA0KPiAgICBhZGRy
ZXNzIHNwYWNlDQoNCltzZWUgYmVsb3ddDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFZpbmVldCBH
dXB0YSA8dmd1cHRhQHN5bm9wc3lzLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FyYy9ib290L2R0cy9o
c2RrLmR0cyB8IDEzICsrKysrKystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMvYm9vdC9k
dHMvaHNkay5kdHMgYi9hcmNoL2FyYy9ib290L2R0cy9oc2RrLmR0cw0KPiBpbmRleCA2OWJjMWM5
ZThlNTAuLjc0MjViYjBmMmQxYiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcmMvYm9vdC9kdHMvaHNk
ay5kdHMNCj4gKysrIGIvYXJjaC9hcmMvYm9vdC9kdHMvaHNkay5kdHMNCj4gQEAgLTE4LDggKzE4
LDggQEANCj4gIAltb2RlbCA9ICJzbnBzLGhzZGsiOw0KPiAgCWNvbXBhdGlibGUgPSAic25wcyxo
c2RrIjsNCj4gIA0KPiAtCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAtCSNzaXplLWNlbGxzID0g
PDE+Ow0KPiArCSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiArCSNzaXplLWNlbGxzID0gPDI+Ow0K
PiAgDQo+ICAJY2hvc2VuIHsNCj4gIAkJYm9vdGFyZ3MgPSAiZWFybHljb249dWFydDgyNTAsbW1p
bzMyLDB4ZjAwMDUwMDAsMTE1MjAwbjggY29uc29sZT10dHlTMCwxMTUyMDBuOCBkZWJ1ZyBwcmlu
dC1mYXRhbC1zaWduYWxzPTEiOw0KPiBAQCAtMTA1LDcgKzEwNSw3IEBADQo+ICAJCSNzaXplLWNl
bGxzID0gPDE+Ow0KPiAgCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZpZHVfaW50Yz47DQo+ICANCj4g
LQkJcmFuZ2VzID0gPDB4MDAwMDAwMDAgMHhmMDAwMDAwMCAweDEwMDAwMDAwPjsNCj4gKwkJcmFu
Z2VzID0gPDB4MDAwMDAwMDAgMHgwIDB4ZjAwMDAwMDAgMHgxMDAwMDAwMD47DQo+ICANCj4gIAkJ
Y2d1X3JzdDogcmVzZXQtY29udHJvbGxlckA4YTAgew0KPiAgCQkJY29tcGF0aWJsZSA9ICJzbnBz
LGhzZGstcmVzZXQiOw0KPiBAQCAtMjY5LDkgKzI2OSwxMCBAQA0KPiAgCX07DQo+ICANCj4gIAlt
ZW1vcnlAODAwMDAwMDAgew0KPiAtCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gLQkJI3NpemUt
Y2VsbHMgPSA8MT47DQo+ICsJCSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiArCQkjc2l6ZS1jZWxs
cyA9IDwyPjsNCj4gIAkJZGV2aWNlX3R5cGUgPSAibWVtb3J5IjsNCj4gLQkJcmVnID0gPDB4ODAw
MDAwMDAgMHg0MDAwMDAwMD47ICAvKiAxIEdpQiAqLw0KPiArCQlyZWcgPSA8MHgwIDB4ODAwMDAw
MDAgMHgwIDB4NDAwMDAwMDA+OyAgLyogMSBHQiBsb3dtZW0gKi8NCj4gKwkJLyogICAgIDB4MSAw
eDAwMDAwMDAwIDB4MCAweDQwMDAwMDAwPjsgICAgIDEgR0IgaGlnaG1lbSAqLw0KDQpDb3VsZCB5
b3UgcGxlYXNlIGdldCByaWQgb2YgY29tbWVudCB3aXRoIHJlZmVyZW5jZSBmb3IgUEFFNDAvSElH
SE1FTSByZWdpb24gaW4gdGhpcyBwYXRjaD8NCkl0IGdpdmVzIHdyb25nIGV4cGVjdGF0aW9ucyB0
aGF0IGlmIHdlIHVuY29tbWVudCBpdCBhbmQgZW5hYmxlIFBBRTQwIGluIGNvbmZpZyB3ZSdsbCBn
ZXQgd29ya2luZyBzeXN0ZW0uDQpCdXQgaXQgaXNuJ3QgdHJ1ZSAtIHdlIGFsc28gbmVlZCB0byBy
ZW1hcCBBWEkgYXBlcnR1cmVzIGFwcHJvcHJpYXRlbHkuDQoNCk90aGVyd2lzZSBrZXJuZWwgd2ls
bCBjcnVzaCBzb21ld2hlcmUuIE1vcmVvdmVyIGtlcm5lbCB3aWxsIGNydXNoIGZvciBkaWZmZXJl
bnQgcmVhc29ucyBpbiBjYXNlIG9mIGxhdW5jaA0KdmlhIFUtYm9vdCBhbmQgdmlhIE1EQiAoYmVj
YXVzZSB3ZSByZW1hcCBBWEkgYXBlcnR1cmVzIGluIFUtYm9vdCBmb3IgaW50ZXJuYWwgcHVycG9z
ZXMpLg0KDQpJZiB5b3UgcmVhbGx5IHdhbnQgdG8ga2VlcCB0aGlzIC0gSSBjYW4gc2VuZCB5b3Ug
cGF0Y2ggd2l0aCBBWEkgYXBlcnR1cmVzIHJlbWFwcGluZyB3ZSBuZWVkIHRvIGFwcGx5IGZpcnN0
bHkuDQoNClRoYW5rcy4NCg0KPiAgCX07DQo+ICB9Ow0KLS0gDQogRXVnZW5peSBQYWx0c2V2
