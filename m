Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8DDC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385AF2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389343AbfHAWG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:06:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:49477 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbfHAWG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:06:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 15:06:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,335,1559545200"; 
   d="scan'208";a="201443080"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga002.fm.intel.com with ESMTP; 01 Aug 2019 15:06:28 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 1 Aug 2019 15:06:28 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.30]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.199]) with mapi id 14.03.0439.000;
 Thu, 1 Aug 2019 15:06:28 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Alexey Dobriyan <adobriyan@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lin, Jing" <jing.lin@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/asm: Add support for MOVDIR64B instruction
Thread-Topic: [PATCH] x86/asm: Add support for MOVDIR64B instruction
Thread-Index: AQHVSKFvXgAMIWvJGESjDr+8j/kY7Kbms0iAgACAEACAAAJDAP//oxig
Date:   Thu, 1 Aug 2019 22:06:27 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7EA0719C@ORSMSX104.amr.corp.intel.com>
References: <20190801194348.GA6059@avx2>
 <20190801194947.GA12033@agluck-desk2.amr.corp.intel.com>
 <20190801202808.e2cqlqetixie4gcu@box> <20190801203614.GA16228@zn.tnic>
In-Reply-To: <20190801203614.GA16228@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjgzOGIzZmEtMDVlMi00NWJiLTlkYmQtYjJjZDNmMThjYWNmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoid0h6aFM2RjhVMEMwMzVHXC81bEZaeTUxWWJrUXRCRkVLQjFiWUF0aytRYXpIR2RIeWkyZmFwSGxKK3owVmtMRGQifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIHRoaW5rIFRvbnkncyBpbiB0aGUgcmlnaHQgZGlyZWN0aW9uLiBXZSBhbHJlYWR5IGRvIGRz
dCAic2l6aW5nIiBsaWtlDQo+IHRoYXQgZm9yIHRoZSBjb21waWxlciBpbiBjbHdiKCkuDQoNClRo
ZSBjbHdiIGNhc2UgZG9lcyBsb29rIGxpa2Ugd2hhdCB3ZSB3YW50IGZvciBtb3ZkaXI2NGIoKS4N
Cg0KQnV0IGlzIGl0IHJpZ2h0IGZvciBjbHdiKCkgLi4uIHRoYXQgZG9lc24ndCBtb2RpZnkgYW55
dGhpbmcsIGp1c3QgcHVzaGVzDQp0aGluZ3MgZnJvbSBjYWNoZSB0byBtZW1vcnkuIFNvIHdoeSBp
cyBpdCB1c2luZyAiK20iPw0KDQotVG9ueQ0K
