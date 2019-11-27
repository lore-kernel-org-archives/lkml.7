Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F52C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872FD215F2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="oloirGvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfK0WQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:16:01 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:54652 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfK0WQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 17:16:01 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6F881886BF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 11:15:58 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1574892958;
        bh=86ybmKdYyEAkqXJW6P1i+HtVhRLKuKTGrNJP3O0OTt0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=oloirGvbZeDI3GCNcCzHjc9f4YDAIskYhn4+yxdPlh87uR5k/lxFHo5zWD0wnK+9m
         fLSVlMxwX+cEbdhJenCTLNTHfPHhOt0mP6w57OCFX2SaVePYTAd/5Ew31u/p5hj+Yk
         Omg/slvybJ2YhtQOou4WN5bGdtpuxwx0UoE9Q8kGKOjE0PcOGRMdHfitV2ji1m+NrC
         V+HkIzThlEnj8ApuDUL9/y8OjfBtU0L6mMJHyh+eMhsjfjA2Dz5kiDlZUdyK269/i7
         cVtCjpJ+D+Q/a9FdztlW1z6cLw/t4xiqZZo6nEe3xyzA5msxvML75klbzkVIwsVTgQ
         xeEg+JJWopfhw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ddef59d0001>; Thu, 28 Nov 2019 11:15:57 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Thu, 28 Nov 2019 11:15:58 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Thu, 28 Nov 2019 11:15:58 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nico@fluxnic.net" <nico@fluxnic.net>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: ARM expections for location of kernel, ramdisk and dtb
Thread-Topic: ARM expections for location of kernel, ramdisk and dtb
Thread-Index: AQHVpPt9nOgyqufu70+hpQyr7hZevaed5YmAgADXDYA=
Date:   Wed, 27 Nov 2019 22:15:57 +0000
Message-ID: <c108d58e3ee511040bb99edb28c893b27b238bdb.camel@alliedtelesis.co.nz>
References: <e1f7cca54843abcef0c2703a5f7071c045b99baa.camel@alliedtelesis.co.nz>
         <20191127092615.GC25745@shell.armlinux.org.uk>
In-Reply-To: <20191127092615.GC25745@shell.armlinux.org.uk>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:f928:a51e:370a:f684]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A49DAC3587DCC445BBE48480D9222B57@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUnVzc2VsbCwNCg0KT24gV2VkLCAyMDE5LTExLTI3IGF0IDA5OjI2ICswMDAwLCBSdXNzZWxs
IEtpbmcgLSBBUk0gTGludXggYWRtaW4NCndyb3RlOg0KPiBPbiBXZWQsIE5vdiAyNywgMjAxOSBh
dCAwODoyMDoxMkFNICswMDAwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPiA+IEhpIEFsbCwNCj4g
PiANCj4gPiBXZSdyZSB1cGRhdGluZyBvdXIgc3lzdGVtcyB0byB1c2UgdGhlIGxhdGVzdCBrZXJu
ZWwuIEZvciBtYW55IG9mIHRoZW0NCj4gPiB0aGlzIGlzIGEgZmFpcmx5IGxhcmdlIGxlYXAuIE9u
ZSBwcm9ibGVtIHdlJ3ZlIGhpdCBpcyB0aGF0IGR1cm5nIGJvb3QNCj4gPiB0aGUgZHRiIGlzIGNs
b2JiZXJlZCBieSB0aGUgdW5jb21wcmVzc2VkIGtlcm5lbC4NCj4gPiANCj4gPiBIZXJlJ3MgYSBz
bmlwcGV0IG9mIG91dHB1dCBmcm9tIHUtYm9vdA0KPiA+IA0KPiA+ICMjIExvYWRpbmcga2VybmVs
IGZyb20gRklUIEltYWdlIGF0IDYyMDAwMDAwIC4uLg0KPiA+ICAgIFVzaW5nICdYUzkxNk1YU0Ay
JyBjb25maWd1cmF0aW9uDQo+ID4gICAgVHJ5aW5nICdrZXJuZWxAMScga2VybmVsIHN1YmltYWdl
DQo+ID4gICAgICBEZXNjcmlwdGlvbjogIGxpbnV4DQo+ID4gICAgICBDcmVhdGVkOiAgICAgIDIw
MTktMTEtMjcgICA2OjUzOjQ4IFVUQw0KPiA+ICAgICAgVHlwZTogICAgICAgICBLZXJuZWwgSW1h
Z2UNCj4gPiAgICAgIENvbXByZXNzaW9uOiAgdW5jb21wcmVzc2VkDQo+ID4gICAgICBEYXRhIFN0
YXJ0OiAgIDB4NjIwMDAxNzQNCj4gPiAgICAgIERhdGEgU2l6ZTogICAgMzQ5NTQzMiBCeXRlcyA9
IDMuMyBNaUINCj4gPiAgICAgIEFyY2hpdGVjdHVyZTogQVJNDQo+ID4gICAgICBPUzogICAgICAg
ICAgIExpbnV4DQo+ID4gICAgICBMb2FkIEFkZHJlc3M6IDB4MDA4MDAwMDANCj4gPiAgICAgIEVu
dHJ5IFBvaW50OiAgMHg2MDgwMDAwMA0KPiA+ICAgIC4uLg0KPiA+ICAgIEJvb3RpbmcgdXNpbmcg
dGhlIGZkdCBibG9iIGF0IDB4NjNiOTBmNmMNCj4gPiAgICBMb2FkaW5nIEtlcm5lbCBJbWFnZSAu
Li4gT0sNCj4gPiAgICBMb2FkaW5nIFJhbWRpc2sgdG8gNmU3YzYwMDAsIGVuZCA3MDAwMDAwMCAu
Li4gT0sNCj4gPiAgICBMb2FkaW5nIERldmljZSBUcmVlIHRvIDYwN2ZiMDAwLCBlbmQgNjA3ZmZm
ZDggLi4uIE9LDQo+ID4gDQo+ID4gU3RhcnRpbmcga2VybmVsIC4uLg0KPiA+IA0KPiA+IFVuY29t
cHJlc3NpbmcgTGludXguLi4gZG9uZSwgYm9vdGluZyB0aGUga2VybmVsLg0KPiA+IA0KPiA+IEVy
cm9yOiBpbnZhbGlkIGR0YiBhbmQgdW5yZWNvZ25pemVkL3Vuc3VwcG9ydGVkIG1hY2hpbmUgSUQN
Cj4gPiAgIHIxPTB4MDAwMDIwNmUsIHIyPTB4MDAwMDAwMDANCj4gPiANCj4gPiBCZXR3ZWVuIG9s
ZCBhbmQgbmV3IHRoZSBsb2NhdGlvbiBvZiB0aGUgZGV2aWNldHJlZSBoYXNuJ3QgYWN0dWFsbHkN
Cj4gPiBjaGFuZ2VkLiBCdXQgd2hhdCBoYXMgY2hhbmdlZCBpcyB0aGUgc2l6ZSBvZiB0aGUga2Vy
bmVsIHRoZSBzZWxmDQo+ID4gZXh0cmFjdGluZyBrZXJuZWwgdW5wYWNrcyB0byAweDYwMDA4MDAw
IGFuZCB3aXRoIG91ciBjdXJyZW50DQo+ID4gY29uZmlndXJhdGlvbiBleHRlbmRzIGludG8gd2hl
cmUgdGhlIGR0YiBpcyBsb2NhdGVkLg0KPiA+IA0KPiA+IERvY3VtZW50YXRpb24vYXJtL2Jvb3Rp
bmcucnN0IHNheXMgdGhhdCAiVGhlIGR0YiBtdXN0IGJlIHBsYWNlZCBpbiBhDQo+ID4gcmVnaW9u
IG9mIG1lbW9yeSB3aGVyZSB0aGUga2VybmVsIGRlY29tcHJlc3NvciB3aWxsIG5vdCBvdmVyd3Jp
dGUgaXQiLiANCj4gPiANCj4gPiBUaGlzIHN1Z2dlc3RzIHRoYXQgdGhlIHByb2JsZW0gaXMgd2l0
aCBvdXIgdS1ib290IGNvbmZpZ3VyYXRpb24sIGJ1dA0KPiA+IGhvdyBpcyB1LWJvb3Qgc3VwcG9z
ZWQgdG8ga25vdyB3aGVyZSB0aGUgc2VsZi1leHRyYWN0aW5nIGtlcm5lbCBpcw0KPiA+IGdvaW5n
IHRvIHBsYWNlIHRoaW5ncz8gQXMgZmFyIGFzIEkgY2FuIHRlbGwgdS1ib290IGlzIGRvaW5nIGEN
Cj4gPiByZWFzb25hYmxlIGpvYiBvZiBmaW5kaW5nIGEgcGxhY2UgdG8gcHV0IHRoZSBkdGIgd2hp
Y2ggaXQgdGhpbmtzIGlzDQo+ID4gdW51c2VkLiBJJ20gbm90IHN1cmUgd2h5IGl0J3MgcGlja2Vk
IDB4NjA3ZmIwMDAgaW5zdGVhZCBvZiBwdXR0aW5nIGl0DQo+ID4ganVzdCB1bmRlciB0aGUgcmFt
ZGlzayBidXQgcmVnYXJkbGVzcyB3aXRoIHRoZSBpbmZvcm1hdGlvbiB1LWJvb3QgaGFzDQo+ID4g
dGhhdCBhZGRyZXNzIGlzIHVwIGZvciBncmFicy4NCj4gPiANCj4gPiBIYXMgdGhpcyBjb21lIHVw
IGJlZm9yZT8gVGhlIHNlbGYtZXh0cmFjdGlvbiBjb2RlIGlzIGZhaXJseSBjYXJlZnVsIG5vdA0K
PiA+IHRvIG92ZXJ3cml0ZSBpdHNlbGYgYnV0IGRvZXNuJ3Qgc2VlbSB0byBwYXkgYW55IGF0dGVu
dGlvbiB0byB0aGUgZHRiDQo+ID4gd2hpY2ggc3VycHJpc2VkIG1lLiBTbyBJIHdvbmRlciBpZiBJ
J20gbWlzc2luZyBzb21ldGhpbmc/DQo+IA0KPiBUaGUgc2VsZi1leHRyYWN0aW9uIGhhc24ndCBj
aGFuZ2VkIG11Y2ggb3ZlciB0aGUgeWVhcnMsIGFuZCBiYXNpY2FsbHkNCj4gZm9sbG93cyB0aGUg
c2FtZSBtZXRob2Qgd2hpY2ggaGFzIHdvcmtlZCBmb3IgdGhlIHZhc3QgbWFqb3JpdHkgb2YNCj4g
cGxhdGZvcm1zLg0KPiANCj4gV2hlcmUgdGhpbmdzIGZhbGwgZG93biBpcyB3aGVyZSB0aGluZ3Mg
YXJlIHBsYWNlZCB0b28gY2xvc2UsIGFuZCB5ZXMsDQo+IGFzIHRoZSBrZXJuZWwgZ3Jvd3MsIHdo
YXQgd2FzIHJlYXNvbmFibGUgeWVhcnMgYWdvIGJlY29tZXMgdG9vIGNsb3NlDQo+IHdpdGggbW9k
ZXJuIGtlcm5lbHMuDQo+IA0KPiBUaGUgcHJvYmxlbSBoYXMgYmVlbiBjb21wb3VuZGVkIGJ5IHRo
ZSB2YXJpb3VzIGRpZmZlcmVudCBjb21wcmVzc2lvbg0KPiBhbGdvcml0aG1zIHRoYXQgY2FuIG5v
dyBiZSB1c2VkIGZvciB0aGUgY29tcHJlc3NlZCBrZXJuZWwuDQo+IA0KDQpJIGRvbid0IHRoaW5r
IGl0J3MgdGhhdCB3ZSBkb24ndCBrbm93IGhvdyBiaWcgdGhlIGV4dHJhY3RlZCBrZXJuZWwgd2ls
bA0KYmUuIEl0J3MganVzdCB0aGF0IHdlIGFyZW4ndCBkb2luZyBhbnl0aGluZyB3aXRoIHRoYXQg
aW5mb3JtYXRpb24gdy5yLnQNCnRoZSBkdGIuDQoNCj4ga2V4ZWMgYWxzbyByYW4gaW50byB0aGlz
IHByb2JsZW0sIGFuZCB0aGVyZSBpcyBub3cgZW5vdWdoIGluZm9ybWF0aW9uDQo+IGluIGEgbW9k
ZXJuIGtlcm5lbCB0byBjYWxjdWxhdGUgaG93IG11Y2ggc3BhY2UgdGhlIGRlY29tcHJlc3NvciBp
cw0KPiBnb2luZyB0byByZXF1aXJlLiAgSGF2ZSBhIGxvb2sgYXQgdGhlIGN1cnJlbnQga2V4ZWMg
c291cmNlcyBmb3IgaG93DQo+IGl0IGlzIGRvbmUuDQo+IA0KDQpUaGFua3Mgd2lsbCBkby4gSWYg
d2UgZ2V0IHNvbWV0aGluZyBzdWl0YWJsZSB3ZSdsbCBwb3N0IGEgcGF0Y2guDQoNCg==
