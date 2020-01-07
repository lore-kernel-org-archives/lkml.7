Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1726C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFD5206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgAGIu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:50:56 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.5]:32991 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725801AbgAGIu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:50:56 -0500
Received: from [85.158.142.100] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.eu-central-1.aws.symcld.net id 98/34-17694-D66441E5; Tue, 07 Jan 2020 08:50:53 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRWlGSWpSXmKPExsVyU+ECq26Om0i
  cwfVnRhaXd81hc2D0+LxJLoAxijUzLym/IoE149/RrII3AhULli5hamC8INDFyMUhJLCXUeLB
  umZWCOcMo8Sdld9Yuhg5OdgEtCRmbJ3KCGKLCGhIvDx6iwWkiFmgk1Hi9usDYAlhAS+J6c/72
  CGKvCX23pvLAmFbSdx7dZ0JxGYRUJFYf/A7WJxXwFeia8IRZhBbSCBOYvfclWA2p4C+xOQjJ8
  FsRgFZiUcrf4HNZBYQl7j1ZD7YHAkBAYkle84zQ9iiEi8f/2OFsA0kti7dxwJhK0jcPXkdKM4
  BZFtL3HjAD2IyC2hKrN+lDzFRUWJK90N2iGsEJU7OfMIygVFsFpJlsxA6ZiHpmIWkYwEjyypG
  86SizPSMktzEzBxdQwMDXUNDY10DXXO9xCrdRL3UUt3k1LySokSgnF5iebFecWVuck6KXl5qy
  SZGYHylFDKw72Bs/fZW7xCjJAeTkijv62LhOCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvMtdRe
  KEBItS01Mr0jJzgLEOk5bg4FES4V3nApTmLS5IzC3OTIdInWK05Jjwcu4iZo6DR+cBySNzly5
  iFmLJy89LlRLnfQjSIADSkFGaBzcOlo4uMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmPQwy
  hSczrwRu6yugg5iADuJ6IQhyUEkiQkqqganpXIrOvGPBYWLPLmS4aVuKsE77tUS5a+Url2K5C
  rG/t7KOfyn9oHB91rZDO4qvvw6LWazp1HT3uXEJy/1ekXWT/3LtunmqVfL2IWaWi8GK82Z0rl
  /lfs9i7Z+PSzPfzdOPeRUx/Y7oJ2Etu7wt8rXRWr5FB6a+3qObK9FrXv5yV5XtMX2+skte935
  UXAv4fWjm/sS8bME/c5NVA6YIzzN7vbK58ZK42fynE/0mHt82+b71otCaloWmD00Lrbcu+X7p
  zdLjEaUfdvgJME59X3zhbta3CXt2OPzPiGORUuM7wbvgxV4O1cKGrHs7L0zU9dDb2CG14WTPx
  oMV91iDG47rx//n2/zaV3or06p0P4sfSizFGYmGWsxFxYkAo88p+sIDAAA=
X-Env-Sender: david.kim@ncipher.com
X-Msg-Ref: server-27.tower-225.messagelabs.com!1578387052!2107841!2
X-Originating-IP: [217.32.208.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24145 invoked from network); 7 Jan 2020 08:50:52 -0000
Received: from unknown (HELO exukdagfar02.INTERNAL.ROOT.TES) (217.32.208.5)
  by server-27.tower-225.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 7 Jan 2020 08:50:52 -0000
Received: from exukdagfar01.INTERNAL.ROOT.TES (10.194.2.70) by
 exukdagfar02.INTERNAL.ROOT.TES (10.194.2.71) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jan 2020 08:50:51 +0000
Received: from exukdagfar01.INTERNAL.ROOT.TES ([fe80::48de:aa33:fc4c:d1f5]) by
 exukdagfar01.INTERNAL.ROOT.TES ([fe80::48de:aa33:fc4c:d1f5%14]) with mapi id
 15.00.1497.000; Tue, 7 Jan 2020 08:50:51 +0000
From:   "Kim, David" <david.kim@ncipher.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Magee, Tim" <tim.magee@ncipher.com>
Subject: RE: [PATCH v2] drivers: misc: Add support for nCipher HSM devices
Thread-Topic: [PATCH v2] drivers: misc: Add support for nCipher HSM devices
Thread-Index: AQHVt0zVoKuntuLcG0+uDmw07DztyKfDitUAgBt0REA=
Date:   Tue, 7 Jan 2020 08:50:50 +0000
Message-ID: <46e2f36d770c462db487d0e918ad2b0b@exukdagfar01.INTERNAL.ROOT.TES>
References: <20191220154738.31448-1-david.kim@ncipher.com>
 <20191220213036.GA27120@kroah.com>
In-Reply-To: <20191220213036.GA27120@kroah.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.194.37.67]
x-exclaimer-md-config: 7ae4f661-56ee-4cc7-9363-621ce9eeb65f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4NCj4gPiBUaGlzIGlzIHRoZSBkcml2ZXIgZm9yIG5DaXBoZXLigJlzIFNvbG8gYW5kIFNv
bG8gWEMgaGFyZHdhcmUgc2VjdXJpdHkgbW9kdWxlcy4NCj4gPiBUaGVzZSBtb2R1bGVzIGltcGxl
bWVudCBhIHByb3ByaWV0YXJ5IGNvbW1hbmQgc2V0ICh0aGUg4oCZbkNvcmUgQVBJ4oCZKSB0bw0K
PiA+IHBlcmZvcm0gY3J5cHRvZ3JhcGhpYyBvcGVyYXRpb25zIC0ga2V5IGdlbmVyYXRpb24sIHNp
Z25hdHVyZSwgYW5kIHNvDQo+ID4gb24uIEhTTSBjb21tYW5kcyBhbmQgdGhlaXIgcmVwbGllcyBh
cmUgcGFzc2VkIGluIGEgc2VyaWFsaXNlZCBiaW5hcnkNCj4gPiBmb3JtYXQgb3ZlciB0aGUgUENJ
ZSBidXMgdmlhIGEgc2hhcmVkIG1lbW9yeSByZWdpb24uIE11bHRpcGxlIGNvbW1hbmRzDQo+ID4g
bWF5IGJlIGluLWZsaWdodCBhdCBhbnkgb25lIHRpbWUgLSBjb21tYW5kIHByb2Nlc3NpbmcgaXMN
Cj4gPiBtdWx0aS10aHJlYWRlZCBhbmQgYXN5bmNocm9ub3VzLiBBIHdyaXRlIG9wZXJhdGlvbiBt
YXksIHRoZXJlZm9yZSwNCj4gPiBkZWxpdmVyIG11bHRpcGxlIGNvbW1hbmRzLCBhbmQgbXVsdGlw
bGUgcmVwbGllcyBtYXkgYmUgcmV0cmlldmVkIGluIG9uZQ0KPiByZWFkIG9wZXJhdGlvbi4NCj4g
DQo+IElmIHRoaXMgaXMgImp1c3QiIGEgY3J5cHRvIGFjY2VsZXJhdG9yLCB3aHkgaXNuJ3QgdGhp
cyBkcml2ZXIgdXNpbmcgdGhlIGV4aXN0aW5nIGluLQ0KPiBrZXJuZWwgaGFyZHdhcmUgY3J5cHRv
IGFwaT8gIFdoYXQgaXMgbGFja2luZyBmcm9tIGl0IHRoYXQgeW91IG5lZWQgaGVyZT8NCg0KSGkg
R3JlZywNCg0KQSBjcnlwdG9ncmFwaGljIGFjY2VsZXJhdG9yIHVzZXMga2V5IG1hdGVyaWFsIHdo
aWNoIGlzIHN0b3JlZCBvbiwgYW5kIG1hbmFnZWQgYnksIHRoZSBob3N0IG1hY2hpbmUuIEhhcmR3
YXJlIHNlY3VyaXR5IG1vZHVsZXMsIHN1Y2ggYXMgbkNpcGhlcuKAmXMgU29sbyBwcm9kdWN0cywg
cmV0YWluIGtleSBtYXRlcmlhbCAoaS5lLiBzZWNyZXRzKSB3aXRoaW4gdGhlIHNlY3VyZSBib3Vu
ZGFyeSBvZiB0aGUgZGV2aWNlLCBhbmQgaW1wbGVtZW50IHZhcmlvdXMgZm9ybXMgb2YgYWNjZXNz
IGNvbnRyb2wgdG8gcmVzdHJpY3QgdXNlIG9mIHRoYXQga2V5IG1hdGVyaWFsLg0KDQpuQ2lwaGVy
J3MgcHJvZHVjdCByYW5nZSBzdGFydGVkLCBpbiB0aGUgZWFybHkgMTk5MHMsIGFzIGNyeXB0b2dy
YXBoaWMgYWNjZWxlcmF0b3JzLiAgVGhlIHNlcmllcyBvZiBoYXJkd2FyZSBzZWN1cml0eSBtb2R1
bGVzIHNlcnZlZCBieSB0aGlzIGRyaXZlciBzdGlsbCBkb2VzIGRvIGNyeXB0b2dyYXBoeSBidXQg
dGhlaXIgbWFpbiBmdW5jdGlvbiBpcyB0aGUgZ2VuZXJhdGlvbiwgbWFuYWdlbWVudCBhbmQgdXNl
IG9mIGtleXMgd2l0aGluIGEgc2VjdXJlIGJvdW5kYXJ5Lg0KDQpUaGUgZHJpdmVyIGRvZXNuJ3Qg
ZG8gYW55IGNyeXB0b2dyYXBoeS4gSXQgcHJvdmlkZXMgdGhlIGxpbmsgYmV0d2VlbiB0aGUgdXNl
cnNwYWNlIHNvZnR3YXJlIGFuZCB0aGUgSFNNJ3MgZmlybXdhcmUuIENyeXB0b2dyYXBoeSBpcyBk
b25lIHdpdGhpbiB0aGUgSFNNJ3Mgc2VjdXJlIGJvdW5kYXJ5Lg0KDQpSZWdhcmRzDQpEYXZlDQo=
