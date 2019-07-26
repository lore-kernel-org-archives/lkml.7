Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60850C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D1B21734
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfGZRRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 13:17:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:31424 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbfGZRRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:17:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 10:17:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="189684198"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jul 2019 10:17:22 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 26 Jul 2019 10:17:22 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.96]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.253]) with mapi id 14.03.0439.000;
 Fri, 26 Jul 2019 10:17:21 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH 1/1] iommu/vt-d: Correctly check format of page table in
 debugfs
Thread-Topic: [PATCH 1/1] iommu/vt-d: Correctly check format of page table
 in debugfs
Thread-Index: AQHVPp8ipwYNQGhYs0KyxJ8SpXgi1qbWGSVggATyvwCAAiH/MA==
Date:   Fri, 26 Jul 2019 17:17:20 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F4F975DF0@ORSMSX114.amr.corp.intel.com>
References: <20190720020126.9974-1-baolu.lu@linux.intel.com>
 <FFF73D592F13FD46B8700F0A279B802F4F9354AF@ORSMSX114.amr.corp.intel.com>
 <8d09da43-d0dd-9dff-0cb3-aa93448a7e60@linux.intel.com>
In-Reply-To: <8d09da43-d0dd-9dff-0cb3-aa93448a7e60@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzI0ZDYzYmMtMTU2OC00OWZiLWIyODQtMTYxNzRhNWUyYTg0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOWJBaDI5dGtsQmgyMHg5K1QyRkZNVW9YNzkzNVdKXC9wMkhxRjZzQlBRcGhYZnZkWEowNEt4bStSb0hMYlRFajgifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiA3LzIyLzE5IDE6MjEgUE0sIFByYWtoeWEsIFNhaSBQcmFuZWV0aCB3cm90ZToNCj4gPiBI
aSBBbGxlbiwNCj4gPg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC1pb21t
dS1kZWJ1Z2ZzLmMNCj4gPj4gYi9kcml2ZXJzL2lvbW11L2ludGVsLSBpb21tdS1kZWJ1Z2ZzLmMg
aW5kZXgNCj4gPj4gNzNhNTUyOTE0NDU1Li5lMzFjM2I0MTYzNTEgMTAwNjQ0DQo+ID4+IC0tLSBh
L2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUtZGVidWdmcy5jDQo+ID4+ICsrKyBiL2RyaXZlcnMv
aW9tbXUvaW50ZWwtaW9tbXUtZGVidWdmcy5jDQo+ID4+IEBAIC0yMzUsNyArMjM1LDcgQEAgc3Rh
dGljIHZvaWQgY3R4X3RibF93YWxrKHN0cnVjdCBzZXFfZmlsZSAqbSwNCj4gPj4gc3RydWN0IGlu
dGVsX2lvbW11ICppb21tdSwgdTE2IGJ1cykNCj4gPj4gICAJCXRibF93bGsuY3R4X2VudHJ5ID0g
Y29udGV4dDsNCj4gPj4gICAJCW0tPnByaXZhdGUgPSAmdGJsX3dsazsNCj4gPj4NCj4gPj4gLQkJ
aWYgKHBhc2lkX3N1cHBvcnRlZChpb21tdSkgJiYgaXNfcGFzaWRfZW5hYmxlZChjb250ZXh0KSkg
ew0KPiA+PiArCQlpZiAoZG1hcl9yZWFkcShpb21tdS0+cmVnICsgRE1BUl9SVEFERFJfUkVHKSAm
DQo+ID4+IERNQV9SVEFERFJfU01UKSB7DQo+ID4NCj4gPiBUaGFua3MgZm9yIGFkZGluZyB0aGlz
LCBJIGRvIGJlbGlldmUgdGhpcyBpcyBhIGdvb2QgYWRkaXRpb24gYnV0IEkNCj4gPiBhbHNvIHRo
aW5rIHRoYXQgd2UgbWlnaHQgbmVlZCAiaXNfcGFzaWRfZW5hYmxlZCgpIiBhcyB3ZWxsLiBJdCBj
aGVja3MgaWYgUEFTSURFDQo+IGJpdCBpbiBjb250ZXh0IGVudHJ5IGlzIGVuYWJsZWQgb3Igbm90
Lg0KPiA+DQo+ID4gSSBhbSB0aGlua2luZyB0aGF0IGV2ZW4gdGhvdWdoIERNQVIgbWlnaHQgYmUg
dXNpbmcgc2NhbGFibGUgcm9vdCBhbmQNCj4gPiBjb250ZXh0IHRhYmxlLCB0aGUgZW50cnkgaXRz
ZWxmIHNob3VsZCBoYXZlIFBBU0lERSBiaXQgc2V0LiBEaWQgSSBtaXNzIHNvbWV0aGluZw0KPiBo
ZXJlPw0KPiANCj4gTm8gbWF0dGVyIHRoZSBQQVNJREUgYml0IHNldCBvciBub3QsIElPTU1VIGFs
d2F5cyB1c2VzIHRoZSBzY2FsYWJsZSBtb2RlDQo+IHBhZ2UgdGFibGUgaWYgc2NhbGFibGUgbW9k
ZSBpcyBlbmFibGVkLiBJZiBQQVNJREUgaXMgc2V0LCByZXF1ZXN0cyB3aXRoIFBBU0lEIHdpbGwN
Cj4gYmUgaGFuZGxlZC4gT3RoZXJ3aXNlLCByZXF1ZXN0cyB3aXRoIFBBU0lEIHdpbGwgYmUgYmxv
Y2tlZCAoYnV0IHJlcXVlc3Qgd2l0aG91dA0KPiBQQVNJRCB3aWxsIGFsd2F5cyBiZSBoYW5kbGVk
KS4NCj4gDQo+IFdlIGFyZSBkdW1wbGluZyB0aGUgcGFnZSB0YWJsZSBvZiB0aGUgSU9NTVUsIHNv
IHdlIG9ubHkgY2FyZSBhYm91dCB3aGF0DQo+IHBhZ2UgdGFibGUgZm9ybWF0IGl0IGlzIHVzaW5n
LiBEbyBJIHVuZGVyc3RhbmQgaXQgcmlnaHQ+DQoNClRoYW5rcyEgQmFvbHUsIGZvciB0aGUgZXhw
bGFuYXRpb24uIFllcywgaXQgbWFrZXMgc2Vuc2UgYW5kIEkgYWdyZWUgdGhhdCB3ZSBkb24ndCBu
ZWVkIHRoZSBleHRyYSBjaGVjayBmb3IgUEFTSURFIGJpdC4NCg0KSSBoYXZlIHRlc3RlZCB0aGlz
IGNoYW5nZSBvbiBzY2FsYWJsZS9sZWdhY3kgRE1BUidzIHdpdGgvd2l0aG91dCBpb21tdT1wdCBh
bmQgaXQgd29ya3MgOikNCg0KUmVnYXJkcywNClNhaQ0K
