Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258F4C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05155215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbfJDMSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:18:22 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:55132 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfJDMSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:18:22 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Oct 2019 08:18:21 EDT
X-AuditID: c0a8fbf4-d45ff700000042c9-df-5d9735068d53
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id DC.A3.17097.605379D5; Fri,  4 Oct 2019 14:03:18 +0200 (CEST)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0439.000; Fri, 4 Oct 2019 14:03:13 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "zhang.chunyan@linaro.org" <zhang.chunyan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count
 usage
Thread-Topic: [PATCH 1/3] regulator: core: fix boot-on regulators use_count
 usage
Thread-Index: AQHVeqdp55KhBLOpUES6p/Iah5mM6qdKQI0A
Date:   Fri, 4 Oct 2019 12:03:12 +0000
Message-ID: <054bc4c050f1b16988de057f812232b0feb707cb.camel@fi.rohmeurope.com>
References: <CAD=FV=W7M8mwQqnPyU9vsK5VAdqqJdQdyxcoe9FRRGTY8zjnFw@mail.gmail.com>
         <20190923181431.GU2036@sirena.org.uk>
         <CAD=FV=WVGj8xzKFFxsjpeuqtVzSvv22cHmWBRJtTbH00eC=E9w@mail.gmail.com>
         <20190923184907.GY2036@sirena.org.uk>
         <CAD=FV=VkaXDn034EFnJWYvWwyLgvq7ajfgMRm9mbhQeRKmPDRQ@mail.gmail.com>
         <20190924182758.GC2036@sirena.org.uk>
         <CAD=FV=WZSy6nHjsY2pvjcoR4iy64b35OPGEb3EPSSc5vpeTTuA@mail.gmail.com>
         <20190927084710.mt42454vsrjm3yh3@pengutronix.de>
         <CAD=FV=XM0i=GsvttJjug6VPOJJGHRqFmsmCp-1XXNvmsYp9sJA@mail.gmail.com>
         <20191004063443.GA26028@localhost.localdomain>
         <20191004113234.GA4866@sirena.co.uk>
In-Reply-To: <20191004113234.GA4866@sirena.co.uk>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFA9EDE18EA483488861C9DD46A09804@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXeOZ6+XU8fjZW/rRkNMjbyVNEjComARRGYYCcuOenLSLna2
        lfalfUhndlvqGs6MmCVihLWE1Ax1WZIlmlPBMGMohXaxKApdtc5xK/30Pu/zf37//wvvAzG6
        ipDCIq2B5bSMWkaE4N1N3vubiTSbMtlRtk1u9UwT8pEyJ5APNPYQ8mZrOy7/MVIhkrs7rhPy
        Lx2jmLza0ROUARV1ple4ot3+RqxwNp8nFBNjnYTCdt0HFFd+Jyu+OdcdEOeEpucxhlNZRYXa
        pB3HQlWzfa2i4gpJia28SmwCndGVIBgiait6OzUJKkEIpKkxgF5cfBq49PGXpgaiEkBIUOmo
        clwsAJHUZmRdENohEKPMGGoYqiEEIYI6iCwDkyL/UBYa8noDdSrqfODABR+cikF37wChTVL7
        0eVzbsKfNY+j2asDi0IwlYJqKz4ssoBai86bPi/WGCVBznc/g/yvptCtzkHMX0ehmak/gb4M
        PZ73LGZhVDxq6UjyoxlorLs/YLMB1VzwiP1vCEfPa6dxC4i2L0uwL9H2ZbR9GW1fRt8EQc0A
        aZgidSFjYFMSOdaYyOlUGv7I12mcwP/H39uAz7XXBUQQuMAqKJJFkU/OWpX0ijxdQamK0aty
        OaOa1bsAgpgskhxuqVHSZAFTeobldP+k1RCXSciNnqtKmhKyTrBsMcv9U9dAKEOkO9WmpMM5
        tpAtOV6kNizJIhgsmIdII/WstoDlGKNBlSvsR66eXxBBCuNzM7fwOKkvZjR814/2g03QMlPv
        wGBv/W0HRuNanZaVSsj+FH6UEkZVRu3/oFkggUAWQV4TjML4Rf/vM8tHiPiI7TnVQoSBWZKk
        JkC3PayZmBtOe9mTkRnZ2vtooffQ4Jczvqe9TOOvnUcMmqOXErLcdc+zKyZtnHnf6SdxvtF8
        GKdb2f6pGWul1V3Pqkx7zLvrLtz45cr4mLe+0V2dNze+88eOWCyRKTfbE07ussTEu6/dq892
        fs1eY63dNfj6fRfpLY093B3dLimpluF6FZOSgHF65i+lwgxZpQMAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBGcmksIDIwMTktMTAtMDQgYXQgMTI6MzIgKzAxMDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+
IE9uIEZyaSwgT2N0IDA0LCAyMDE5IGF0IDA5OjM0OjQzQU0gKzAzMDAsIE1hdHRpIFZhaXR0aW5l
biB3cm90ZToNCj4gPiBPbiBUdWUsIE9jdCAwMSwgMjAxOSBhdCAxMjo1NzozMVBNIC0wNzAwLCBE
b3VnIEFuZGVyc29uIHdyb3RlOg0KPiA+ID4gSSBkb24ndCB0aGluayB5b3VyIGZpeCBpcyBjb3Jy
ZWN0LiAgSXQgc291bmRzIGFzIGlmIHRoZSBpbnRlbnRpb24NCj4gPiA+IG9mDQo+ID4gPiAicmVn
dWxhdG9yLWJvb3Qtb24iIGlzIHRvIGhhdmUgdGhlIE9TIHR1cm4gdGhlIHJlZ3VsYXRvciBvbiBh
dA0KPiA+ID4gYm9vdHVwDQo+ID4gPiBhbmQgaXQga2VlcCBhbiBpbXBsaWNpdCByZWZlcmVuY2Ug
dW50aWwgc29tZW9uZSBleHBsaWNpdGx5IHRlbGxzDQo+ID4gPiB0aGUNCj4gPiA+IE9TIHRvIGRy
b3AgdGhlIHJlZmVyZW5jZS4NCj4gPiBIbW0uLiBXaGF0IGlzIHRoZSBpbnRlbmRlZCB3YXkgdG8g
ZXhwbGljaXRseSB0ZWxsIHRoZSBPUyB0byBkcm9wDQo+ID4gdGhlDQo+ID4gcmVmZXJlbmNlPyBJ
IHdvdWxkIGFzc3VtZSB3ZSBzaG91bGQgc3RpbGwgdXNlIHNhbWUgbG9naWMgYXMgd2l0aA0KPiA+
IG90aGVyDQo+ID4gcmVndWxhdG9ycyAtIGlmIGxhc3QgdXNlciBjYWxscyByZWd1bGF0b3JfZGlz
YWJsZSgpIHdlIHNob3VsZA0KPiA+IGRpc2FibGUNCj4gPiB0aGUgcmVndWxhdG9yPyAoSSBtYXkg
bm90IHVuZGVyc3RhbmQgYWxsIHRoaXMgd2VsbCBlbm91Z2ggdGhvdWdoKQ0KPiANCj4gWWVzLg0K
PiANCj4gPiA+IEl0J3MgYSBmaXhlZCByZWd1bGF0b3IgY29udHJvbGxlZCBieSBhIEdQSU8/ICBQ
cmVzdW1hYmx5IHRoZSBHUElPDQo+ID4gPiBjYW4NCj4gPiA+IGJlIHJlYWQuICBUaGF0IHdvdWxk
IG1lYW4gaXQgaWRlYWxseSBzaG91bGRuJ3QgYmUgdXNpbmcNCj4gPiA+ICJyZWd1bGF0b3ItYm9v
dC1vbiIgc2luY2UgdGhpcyBpcyBfbm90XyBhIHJlZ3VsYXRvciB3aG9zZQ0KPiA+ID4gc29mdHdh
cmUNCj4gPiA+IHN0YXRlIGNhbid0IGJlIHJlYWQuICBKdXN0IHJlbW92ZSB0aGUgcHJvcGVydHku
DQo+ID4gSG93IHNob3VsZCB3ZSBoYW5kbGUgY2FzZXMgd2hlcmUgd2Ugd2FudCBPUyB0byBlbmFi
bGUgcmVndWxhdG9yIGF0DQo+ID4gYm9vdC11cCAtIHBvc3NpYmx5IGJlZm9yZSBjb25zdW1lciBk
cml2ZXJzIGNhbiBiZSBsb2FkPw0KPiANCj4gSWYgeW91IHdhbnQgdGhlIHJlZ3VsYXRvciB0byBi
ZSBvbiB3aXRob3V0IGFueSBkcml2ZXIgcHJlc2VudCB0aGVuDQo+IG1hcmsNCj4gaXQgYWx3YXlz
LW9uLiAgSWYgeW91IHdhbnQgdGhlIHJlZ3VsYXRvciB0byBiZSBlbmFibGVkIHByaW9yIHRvIHRo
ZQ0KPiBkcml2ZXIgYmVpbmcgbG9hZGVkIHRoZW4gdGhlIGV4cGVjdGF0aW9uIGlzIHRoYXQgdGhl
IGJvb3Rsb2FkZXIgd2lsbA0KPiBkbw0KPiB0aGF0LCBpdCdzIGRpZmZpY3VsdCB0byBzZWUgd2hh
dCB0aGUgYmVuZWZpdCB0aGVyZSBpcyBmcm9tIGhhdmluZyB0aGUNCj4ga2VybmVsIGVuYWJsZSB0
aGluZ3Mgd2hlbiBpdCBzdGFydHMgcHJpb3IgdG8gaGF2aW5nIGEgZHJpdmVyIHVubGVzcw0KPiB0
aGUNCj4gaW50ZW50IGlzIHRvIGtlZXAgdGhlIHJlZ3VsYXRvciBhbHdheXMgb24uDQoNCkkgdGhv
dWdodCB0aGUgcmVndWxhdG9yLWJvb3Qtb24gY291bGQgaGF2ZSBiZWVuIHVzZWQgZm9yIHRoYXQu
IEJ1dCBhcyBJDQpzYWlkIC0gSSBkb24ndCByZWFsbHkga25vdyBhbGwgdGhpcyBzbyB3ZWxsID0p
IEFuZCBubywgSSBhbSBub3Qgb3Bwb3NlZA0KdG8gb2ZmbG9hZGluZyB0aGlzIGZyb20ga2VybmVs
IHRvIGJvb3QsIEkgd2FzIGp1c3QgdHJ5aW5nIHRvIGxlYXJuIHdoYXQNCmlzIHRoZSBjb3JyZWN0
IHRoaW5nIHRvIGRvICh0bSkuIFRoYW5rcyBmb3IgZWR1Y2F0aW5nIG1lIG9uIHRoaXMgOikgSQ0K
d2lsbCBzdWdnZXN0IGFkZGluZyB0aGUgZW5hYmxpbmcgdG8gYm9vdCBjb2RlIGlmICh3aGVuKSBJ
IGdldCBxdWVzdGlvbnMNCmNvbmNlcm5pbmcgdGhpcy4gKGFsd2F5cy1vbiB3b24ndCBkbyBmb3Ig
cmVndWxhdG9ycyB3aGljaCBuZWVkIHRvIGJlDQpjb250cm9sbGVkIGZvciBwb3dlciBzYXZpbmcg
b3IgaGVhdGluZyBpc3N1ZXMpLg0KDQpCciwNCglNYXR0aSBWYWl0dGluZW4NCg==
