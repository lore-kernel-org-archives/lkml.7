Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13728C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB3E216B7
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfHERu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:50:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:47840 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfHERu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:50:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 10:50:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="176376130"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga003.jf.intel.com with ESMTP; 05 Aug 2019 10:50:28 -0700
Received: from orsmsx111.amr.corp.intel.com ([169.254.12.46]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.186]) with mapi id 14.03.0439.000;
 Mon, 5 Aug 2019 10:50:26 -0700
From:   "Lin, Jing" <jing.lin@intel.com>
To:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/asm: Add support for MOVDIR64B instruction
Thread-Topic: [PATCH] x86/asm: Add support for MOVDIR64B instruction
Thread-Index: AQHVSKFv5siymBrH4UWZ6VHVf1YRd6bnKKIAgAAKtgCAAAJDAIAAGTWAgAEV2wCABHZo8A==
Date:   Mon, 5 Aug 2019 17:50:25 +0000
Message-ID: <4055BDF753AD6F41A91F928E1B53A9303E8A9E29@ORSMSX111.amr.corp.intel.com>
References: <20190801194348.GA6059@avx2>
 <20190801194947.GA12033@agluck-desk2.amr.corp.intel.com>
 <20190801202808.e2cqlqetixie4gcu@box> <20190801203614.GA16228@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7EA0719C@ORSMSX104.amr.corp.intel.com>
 <20190802144056.GC30661@zn.tnic>
In-Reply-To: <20190802144056.GC30661@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjc5ODUzNzMtMjBiMy00NzE5LWE3OTctYjdiNjg1YWVmNTQ1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMHNcL0tybmJOTDRWcFwveit3bzdzelVvN1p2ejBXcXp0eitFSWZzV3czNGRYaWtsWjlDaCtmOWw0bjdjVUFkQTBLIn0=
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K0RhdmUsIHdobyBpcyB0aGUgRFNBIGRldmVsb3Blci4gDQoNClRoYW5rcywNCkppbmcgDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVu
OC5kZT4gDQpTZW50OiBGcmlkYXksIEF1Z3VzdCAyLCAyMDE5IDc6NDEgQU0NClRvOiBMdWNrLCBU
b255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KQ2M6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxs
QHNodXRlbW92Lm5hbWU+OyBBbGV4ZXkgRG9icml5YW4gPGFkb2JyaXlhbkBnbWFpbC5jb20+OyBr
aXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBMaW4sIEppbmcgPGppbmcubGluQGludGVsLmNvbT47IHg4NkBrZXJuZWwub3JnDQpTdWJq
ZWN0OiBSZTogW1BBVENIXSB4ODYvYXNtOiBBZGQgc3VwcG9ydCBmb3IgTU9WRElSNjRCIGluc3Ry
dWN0aW9uDQoNCk9uIFRodSwgQXVnIDAxLCAyMDE5IGF0IDEwOjA2OjI3UE0gKzAwMDAsIEx1Y2ss
IFRvbnkgd3JvdGU6DQo+ID4gSSB0aGluayBUb255J3MgaW4gdGhlIHJpZ2h0IGRpcmVjdGlvbi4g
V2UgYWxyZWFkeSBkbyBkc3QgInNpemluZyIgDQo+ID4gbGlrZSB0aGF0IGZvciB0aGUgY29tcGls
ZXIgaW4gY2x3YigpLg0KPiANCj4gVGhlIGNsd2IgY2FzZSBkb2VzIGxvb2sgbGlrZSB3aGF0IHdl
IHdhbnQgZm9yIG1vdmRpcjY0YigpLg0KPiANCj4gQnV0IGlzIGl0IHJpZ2h0IGZvciBjbHdiKCkg
Li4uIHRoYXQgZG9lc24ndCBtb2RpZnkgYW55dGhpbmcsIGp1c3QgDQo+IHB1c2hlcyB0aGluZ3Mg
ZnJvbSBjYWNoZSB0byBtZW1vcnkuIFNvIHdoeSBpcyBpdCB1c2luZyAiK20iPw0KDQpIZXJlIHNv
bWUgaGludHMgZnJvbSB0byBteSBub3RlcywgaWYgeW91IHdhbnQgdG8ga25vdyBtb3JlIGRldGFp
bCwgSSBjYW4gcGluZyBteSBnY2MgZ3V5Lg0KDQpJdCBuZWVkcyB0byBiZSBhbiBpbnB1dCBhbmQg
YW4gb3V0cHV0IG9wZXJhbmQgc28gdGhhdCBpdCBwcmV2ZW50cyBnY2MgZnJvbSByZW9yZGVyaW5n
IGFjY2Vzc2VzIHRvIGl0IGFmdGVyIHRoZSBpbnNuIGhhcHBlbnMsIGkuZS4sIHlvdSBkb24ndCB3
YW50IHRvIHRvdWNoIGl0IGFmdGVyIENMRkxVU0ggaGFzIGV4ZWN1dGVkLg0KDQpBbmQgYWxzbywg
eW91IHdhbnQgdG8gbWFrZSBzdXJlIGl0IHdvcmtzIHdpdGggYWxsIGdjYyB2ZXJzaW9ucyBhbmQg
dGhpcyBpcywgSSB3YXMgdG9sZCwgdGhlIHJpZ2h0IHdheSB0byBkbyBpdC4gRm9yIGV4YW1wbGUs
IHNvbWUgZ2NjIHZlcnNpb25zIGNvbnNpZGVyIGl0IG5vdCBsaW1pdGVkIHRvIDY0IGJ5dGVzIG9m
IG1lbW9yeSBiZWluZyB0b3VjaGVkIGJ1dCBhIGZ1bGwgbWVtb3J5IGNsb2JiZXIuDQoNCkhUSC4N
Cg0KLS0NClJlZ2FyZHMvR3J1c3MsDQogICAgQm9yaXMuDQoNCkdvb2QgbWFpbGluZyBwcmFjdGlj
ZXMgZm9yIDQwMDogYXZvaWQgdG9wLXBvc3RpbmcgYW5kIHRyaW0gdGhlIHJlcGx5Lg0K
