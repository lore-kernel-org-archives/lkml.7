Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF84C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77DD21479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391731AbfETQXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:23:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:29400 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388110AbfETQXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:23:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 09:23:29 -0700
X-ExtLoop1: 1
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga007.fm.intel.com with ESMTP; 20 May 2019 09:23:29 -0700
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 20 May 2019 09:23:29 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.182]) by
 ORSMSX115.amr.corp.intel.com ([169.254.4.95]) with mapi id 14.03.0415.000;
 Mon, 20 May 2019 09:23:29 -0700
From:   "Yang, Fei" <fei.yang@intel.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        John Stultz <john.stultz@linaro.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chen Yu <chenyu56@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: RE: [REGRESSION] usb: gadget: f_fs: Allow scatter-gather buffers
Thread-Topic: [REGRESSION] usb: gadget: f_fs: Allow scatter-gather buffers
Thread-Index: AQHVBUSfP50+H4oA+0GPWiTwRhChu6ZjSo+AgABJVwCAADHfAIAFz8aAgABDQICAAQ2pAIAJdbYA///lWmA=
Date:   Mon, 20 May 2019 16:23:28 +0000
Message-ID: <02E7334B1630744CBDC55DA8586225837F884D53@ORSMSX103.amr.corp.intel.com>
References: <CALAqxLUMRaNxwTUi9QS7-Cy-Ve4+vteBm8-jW4yzZg_QTJVChA@mail.gmail.com>
 <7caebeb2-ea96-2276-3078-1e53f09ce227@collabora.com>
 <CALAqxLUfJYUtmQDC_aDMxW7KcPUawGoRq-PNUfmzQuNKh97FmQ@mail.gmail.com>
 <CALAqxLVUFfrPVVjR74V3PhhtcCytfp=cUYjo=BcJ14D1fkVXTw@mail.gmail.com>
 <7ec57c29-d1ab-dc4c-755d-a6009b9132b5@collabora.com>
 <CALAqxLUgnTB7aZ4edXCaG8SJsJzfY1_yNEPc6Losssw5Xy9-XA@mail.gmail.com>
 <36620156-d119-b1b2-989e-0c13b783296e@collabora.com>
 <db5665cf-6274-c254-720c-798fec79d131@collabora.com>
In-Reply-To: <db5665cf-6274-c254-720c-798fec79d131@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzE5YjIxYmQtYmE4Ni00ZTI5LTgwMDEtMTNiZWI0MWRiZmEwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQU92bjJmbGlySmI1NW0rWEVVTnNNZWlvZE1WTjVycEVMUENVdzl6SFFyQkZNQW1WTTQySU1rTnBsUHdidXo4cSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gT25lIHF1ZXN0aW9uIHRoYXQgY29tZXMgdG8gbXkgbWluZCBpcyB0aGlzOiBEb2VzIHRoZSBV
U0IgdHJhbnNtaXNzaW9uIA0KPj4gc3RhbGwgKGUuZy4gZW5kcG9pbnQgc3RhbGwpIG9yIG5vdD8g
SW4gb3RoZXIgd29yZHMsIGlzIGFkYiBjb25uZWN0aW9uIA0KPj4gYnJva2VuIGJlY2F1c2UgVVNC
IHN0b3BzIHRyYW5zbWl0dGluZyBhbnl0aGluZywgb3IgYmVjYXVzZSB0aGUgZGF0YSBpcyANCj4+
IHRyYW5zbWl0dGVkIGJ1dCBpdHMgaW50ZWdyaXR5IGlzIGJyb2tlbiBkdXJpbmcgdHJhbnNtaXNz
aW9uIGFuZCB0aGF0IA0KPj4gY2F1c2VzIGFkYi9hZGJkIGNvbmZ1c2lvbiB3aGljaCByZXN1bHRz
IGluIHN0b3BwaW5nIHRoZWlyIG9wZXJhdGlvbj8gDQo+PiBEb2VzIGFueXRoaW5nIGtlZXAgaGFw
cGVuaW5nIG9uIEZ1bmN0aW9uRlMgd2hlbiBhZGIgY29ubmVjdGlvbiBpcyANCj4+IGJyb2tlbj8N
Cj4NCj5BbnkgZGlzY292ZXJpZXMgYWJvdXQgdGhlIHByb2JsZW0/DQoNCkluIG15IGRlYnVnZ2lu
ZywgSSdtIHNlZWluZyBhIGxvdCBvZiByZXF1ZXN0cyBxdWV1ZWQgdXAgdGhyb3VnaCBmZnNfZXBm
aWxlX2lvIChyZXR1cm5pbmcgLUVJT0NCUVVFVUVEKSwgYnV0DQpvbmx5IGEgZmV3IG9mIHRoZW0g
Y2FtZSBiYWNrIHRocm91Z2ggZmZzX2VwZmlsZV9hc3luY19pb19jb21wbGV0ZSAtPiBmZnNfdXNl
cl9jb3B5X3dvcmtlci4NCkkgZG9u4oCZdCB0aGluayB0aGVyZSBpcyBhIFVTQiB0cmFuc21pc3Np
b24gc3RhbGwgdGhvdWdoLCBiZWNhdXNlIGlmIEkgbWFudWFsbHkgZGlzYWJsZSBpb19kYXRhLT51
c2Vfc2csIGV2ZXJ5dGhpbmcNCmdvZXMgYmFjayB0byBub3JtYWwuIFNvIGl0IGxvb2tzIG1vcmUg
bGlrZWx5IHRvIGJlIGEgYnVmZmVyIGhhbmRsaW5nIHByb2JsZW0gaW4gdGhlIERXQzMgZHJpdmVy
Lg0KDQotRmVpDQoNCj4NCj5BbmRyemVqDQo=
